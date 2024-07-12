#include "riscv.h"
#include "riscv-virt.h"
#include "imsic.h"
#include "aplic.h"

#define DOMAINCFG               (0x0000)
#define SOURCECFG               (0x0004)
#define MMSIADDRCFG             (0x1BC0)
#define MMSIADDRCFGH            (0x1BC4)
#define SMSIADDRCFG             (0x1BC8)
#define SMSIADDRCFGH            (0x1BCC)
#define SETIP                   (0x1C00)
#define SETIPNUM                (0x1CDC)
#define IN_CLRIP                (0x1D00)
#define CLRIPNUM                (0x1DDC)
#define SETIE                   (0x1E00)
#define SETIENUM                (0x1EDC)
#define CLRIE                   (0x1F00)
#define CLRIENUM                (0x1FDC)
#define SETIPNUM_LE             (0x2000)
#define SETIPNUM_BE             (0x2004)
#define GENMSI                  (0x3000)
#define TARGET                  (0x3004)
#define IDC                     (0x4000)

#define IDELIVERY               (0x00)
#define IFORCE                  (0x04)
#define ITHRESHOLD              (0x08)
#define TOPI                    (0x18)
#define CLAIMI                  (0x1C)

#define APLIC_REG(reg) (*((volatile u32 *)(reg)))

// aplic_mode: APLIC_MACHINE or APLIC_SUPERVISOR
struct aplic *aplic_get_addr(int aplic_mode)
{
    return (struct aplic *)(aplic_mode ? APLIC0_S_ADDR : APLIC0_M_ADDR);
}

// dm_mode: APLIC_DM_DIRECT, or APLIC_DM_MSI
void aplic_set_domaincfg(struct aplic *aplic, int dm_mode)
{
    u32 enabled = 1;
    u32 msimode = dm_mode;
    u32 bigendian = 0;

    aplic->domaincfg = (enabled << 8) | (msimode << 2) | bigendian;
}

// irq: 1 - 1023
// irq_mode: APLIC_SM_EDGE1 or APLIC_SM_EDGE0 or ...
void aplic_set_sourcecfg(struct aplic *aplic, int irq, int irq_mode)
{
    aplic->sourcecfg[irq - 1] = irq_mode;
}

// irq: 1 - 1023
// child: the child aplic to delegate this interrupt to
void aplic_sourcecfg_delegate(struct aplic *aplic, int irq, int child)
{
    u32 delegate = 1 << 10;
    aplic->sourcecfg[irq - 1] = delegate | (child & 0x3ff);
}

// irq: 1 - 1023
// pending: true: set the bit to 1, false: clear the bit to 0
void aplic_set_ip(struct aplic *aplic, int irq, int pending)
{
    u32 irqidx = irq / 32;
    u32 irqbit = irq % 32;

    if (pending)
        aplic->setip[irqidx] = 1 << irqbit;
    else
        aplic->in_clrip[irqidx] = 1 << irqbit;
}

// irq: 1 - 1023
// enable: true: enable interrupt, false: disable interrupt
void aplic_set_ie(struct aplic *aplic, int irq, int enable)
{
    u32 irqidx = irq / 32;
    u32 irqbit = irq % 32;

    if (enable)
        aplic->setie[irqidx] = 1 << irqbit;
    else
        aplic->clrie[irqidx] = 1 << irqbit;
}

// # Overview
// Set the target interrupt to a given hart and priority
// ## Arguments
// * `irq` - the interrupt to set
// * `hart` - the hart that will receive interrupts from this irq
// * `prio` - the priority of this direct interrupt.
void aplic_set_target_direct(struct aplic *aplic, int irq, int hart, int prio)
{
    aplic->target[irq - 1] = (hart << 18) | (prio & 0xFF);
}

// # Overview
// Set the target interrupt to a given hart, guest, and identifier
// ## Arguments
// * `irq` - the interrupt to set
// * `hart` - the hart that will receive interrupts from this irq
// * `guest` - the guest identifier to send these interrupts
// * `eiid` - the identification number of the irq (usually the same as the irq itself)
void aplic_set_target_msi(struct aplic *aplic, int irq, int hart, int guest, int eiid)
{
    aplic->target[irq - 1] = (hart << 18) | (guest << 12) | eiid;
}

// idelivery: 0 = interrupt delivery is disabled, 1 = interrupt delivery is enabled
// ithreshold: interrupt threshold, 0 for no threshold
void aplic_set_idc(struct aplic *aplic, int hart, int idelivery, int ithreshold)
{
    u64 addr = (u64)aplic + IDC + 32 * hart;
    APLIC_REG(addr + IDELIVERY) = idelivery;
    APLIC_REG(addr + ITHRESHOLD) = ithreshold;
}

int aplic_get_claimi(int aplic_mode, int hart)
{
    struct aplic *aplic = aplic_get_addr(aplic_mode);
    u64 addr = (u64)aplic + IDC + 32 * hart;
    u64 claimi = APLIC_REG(addr + CLAIMI);
    return claimi >> 16;
}

// aplic_mode: APLIC_MACHINE or APLIC_SUPERVISOR
// dm_mode: APLIC_DM_DIRECT - direct, APLIC_DM_MSI - msi
// irq: 1 - 1023
// enable: true: enable interrupt, false: disable interrupt
void aplic_enable_irq(int aplic_mode, int dm_mode, int irq, int enable)
{
    struct aplic *aplic = aplic_get_addr(aplic_mode);

    if (dm_mode == APLIC_DM_MSI) {
        // MSI 模式的 APLIC's target
        aplic_set_target_msi(aplic, irq, 0, 0, irq);
        aplic_set_sourcecfg(aplic, irq, APLIC_SM_LEVEL_HIGH);
        // APLIC 使能中断
        aplic_set_ie(aplic, irq, enable);
    } else {
        aplic_set_target_direct(aplic, irq, 0, 1);
        aplic_set_sourcecfg(aplic, irq, APLIC_SM_LEVEL_HIGH);
        aplic_set_ie(aplic, irq, enable);
    }
}

// dm_mode: APLIC_DM_DIRECT - direct, APLIC_DM_MSI - msi
void aplic_init(int dm_mode)
{
    struct aplic *aplic = aplic_get_addr(APLIC_SUPERVISOR);

    // 配置 domaincfg
    aplic_set_domaincfg(aplic, dm_mode);

    if (dm_mode == APLIC_DM_DIRECT) {
        // 配置 idc
        aplic_set_idc(aplic, 0, 1, 0);
    }
}
