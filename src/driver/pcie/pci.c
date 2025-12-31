#include "riscv-virt.h"
#include "aplic.h"
#include "imsic.h"
#include "pci.h"
#include "printf/printf.h"

// 64 bit address
#define PCI_ADDR(addr)  (PCIE0_ECAM + (u64)(addr))
#define PCI_REG8(reg)  (*(volatile u8 *)PCI_ADDR(reg))
#define PCI_REG16(reg)  (*(volatile u16 *)PCI_ADDR(reg))
#define PCI_REG32(reg)  (*(volatile u32 *)PCI_ADDR(reg))
#define PCI_REG64(reg)  (*(volatile u64 *)PCI_ADDR(reg))

u8 pci_config_read8(u64 offset)
{
    return PCI_REG8(offset);
}

u16 pci_config_read16(u64 offset)
{
    return PCI_REG16(offset);
}

u32 pci_config_read32(u64 offset)
{
    return PCI_REG32(offset);
}

u64 pci_config_read64(u64 offset)
{
    return PCI_REG64(offset);
}

void pci_config_write8(u32 offset, u8 val)
{
    PCI_REG8(offset) = val;
}

void pci_config_write16(u32 offset, u16 val)
{
    PCI_REG16(offset) = val;
}

void pci_config_write32(u32 offset, u32 val)
{
    PCI_REG32(offset) = val;
}

void pci_config_read(void *buf, u64 len, u64 offset)
{
    volatile u8 *dst = (volatile u8 *)buf;
    while (len) {
        *dst = PCI_REG8(offset);
        --len;
        ++dst;
        ++offset;
    }
}

u64 pci_device_probe(u16 vendor_id, u16 device_id)
{
    u32 pci_id = (((u32)device_id) << 16) | vendor_id;
    u64 ret = 0;

    // Note: this is just a simple implementation, only scan function 0
    //  and can't handle pci bridge (like pcie switch) correctly.
    // For current riscv-virt platform, it's enough.
    for (int bus = 0; bus < 255; bus++) {
        for (int dev = 0; dev < 32; dev++) {
            int func = 0;
            int offset = 0;
            u64 off = (bus << 20) | (dev << 15) | (func << 12) | (offset);
            volatile u32 *base = (volatile u32 *)PCI_ADDR(off);
            u32 id = base[0];   // device_id + vendor_id

            if (id != pci_id) continue;

            ret = off;

            // command and status register.
            // bit 0 : I/O access enable
            // bit 1 : memory access enable
            // bit 2 : enable mastering
            base[1] = 7;
            __sync_synchronize();

            // u8 flag = 0;
            // int spaceid = 0;
            // int addrbit = 0;
            for(int i = 0; i < 6; i++) {
                u32 old = base[4+i];
                u32 prefetchable = (old & 0x8) == 0x8;
                printf("bar%d origin value: 0x%08x\t", i, old);
                if(prefetchable) {
                    printf("prefetchable\t");
                } else {
                    printf("non-prefetchable\t");
                }
                if(old & 0x1) {
                    printf("IO space\n");
                    continue;
                } else {
                    printf("Mem space\t");
                }
                if(old & 0x4) {
                    printf("64 bit with BAR%d\n", i+1);
                    base[4+i] = 0xffffffff;
                    base[4+i+1] = 0xffffffff;
                    __sync_synchronize();

                    u64 sz = ((u64)base[4+i+1] << 32) | base[4+i];
                    sz = ~(sz & 0xFFFFFFFFFFFFFFF0) + 1;
                    if (sz == 0) { i++; continue; }

                    printf("bar%d need size: 0x%016llx\n", i, sz);
                    // Alloc MMIO space for device (just like mmio control registers, but more flexible)
                    u64 mem_addr = 0;
                    if (prefetchable) {
                        mem_addr = pci_alloc_mmio_prefetch(sz);
                    } else {
                        mem_addr = pci_alloc_mmio(sz);
                    }
                    base[4+i] = (u32)(mem_addr);
                    base[4+i+1] = (u32)(mem_addr >> 32);
                    printf("bar%d mem_addr: 0x%016llx\n", i, mem_addr);
                    i++;
                } else {
                    printf("32 bit\n");
                    // writing all 1's to the BAR causes it to be
                    // replaced with its size.
                    base[4+i] = 0xffffffff;
                    __sync_synchronize();

                    u32 sz = base[4+i];
                    sz = ~(sz & 0xFFFFFFF0) + 1;
                    if (sz == 0) { continue; }

                    printf("bar%d need size: 0x%08x\n", i, sz);
                    if (prefetchable) {
                        base[4+i] = (u32)pci_alloc_mmio_prefetch((u64)sz);
                    } else {
                        base[4+i] = (u32)pci_alloc_mmio((u64)sz);
                    }
                    printf("bar%d mem_addr: 0x%016llx\n", i, (u64)base[4+i]);
                }
            }
        }
    }
    printf("vendor_id: 0x%08x\n", vendor_id);
    printf("device_id: 0x%08x\n", device_id);
    printf("ecam_offset: 0x%016llx\n", ret);
    return ret;
}

// void pci_set_msix(struct pci_msix *msix, u32 pci_base, u32 pos, trap_handler_fn *msix_isr)
// {
//     struct pci_msix_cap cap;                                        // 软件上的结构体
//     // enable msi-x
//     struct pci_msix_cap *msix_cap = (struct pci_msix_cap *)&cap;    // 指针
//     // pos: 该 cap 在该设备 ECAM 区域中的 offset, 读取 MSI-X capability
//     pci_config_read(&cap, sizeof(cap), pos);
//     // 写入 Message Control, MSI-X Enable
//     pci_config_write16(pos + 2, msix_cap->ctrl | PCI_MSIX_ENABLE);
//     // 重新读取 MSI-X Capability
//     pci_config_read(&cap, sizeof(cap), pos);

//     /* Transitional devices would also have this capability,
//         * that's why we also check if msix is enabled.
//         * 1st byte is cap ID; 2nd byte is the position of next
//         * cap; next two bytes are the flags.
//         */
//     printf("ctrl: 0x%04x\n", msix_cap->ctrl);
//     printf("table: 0x%08x\n", msix_cap->table);
//     printf("pba: 0x%08x\n", msix_cap->pba);

//     // [26:16], 最多 2048 个中断号
//     int irq_num = (msix_cap->ctrl & MSIX_SIZE_MASK) + 1;    // Size of the MSI-X Table (只读)
//     int msix_bar = (msix_cap->table & MSIX_BAR_MASK);       // MSI-X Table 所属的 BAR
//     int tbl_off = (msix_cap->table & ~MSIX_BAR_MASK);       // MSI-X Table 位于 BAR 空间的起始位置
//     int pba_off = (msix_cap->pba & ~MSIX_BAR_MASK);         // MAX-X PBA 位于 BAR 空间的起始位置
//     printf("irq_num: %d\n", irq_num);
//     printf("msix_bar: %d\n", msix_bar);
//     printf("tbl_off: 0x%08x\n", tbl_off);
//     printf("pba_off: 0x%08x\n", pba_off);

//     u32 reg = pci_base + PCI_ADDR_BAR0 + 4 * msix_bar;      
//     u32 msix_addr = pci_config_read32(reg) & 0xFFFFFFF0;    // 获取 BAR 指明的基地址
//     u32 tbl_addr = msix_addr + tbl_off;                     // + tbl_off
//     u32 pba_addr = msix_addr + pba_off;                     // + pba_off
//     printf("msix_addr: 0x%08x\n", msix_addr);
//     printf("tbl_addr: 0x%08x\n", tbl_addr);
//     printf("pba_addr: 0x%08x\n", pba_addr);

//     msix->bar_num = msix_bar;
//     msix->irq_num = irq_num;
//     msix->tbl_addr = tbl_addr;
//     msix->pba_addr = pba_addr;

//     // pci_msix_tbl 指针
//     struct pci_msix_tbl *tbl = (struct pci_msix_tbl *)msix->tbl_addr;
    
//     // 获取 M-mode, hart 0 的中断文件地址
//     u32 imsic_addr = imsic_get_addr(APLIC_MACHINE, 0);
//     printf("imsic_addr: 0x%08x\n", imsic_addr);
//     //u32 imsic_irq = APLIC_MSIX0_IRQ;

//     // 填充 MSI-X Table, msix->irq_num = 2
//     for (int i = 0; i < msix->irq_num; ++i) {
//         // PCI 分配 IRQ 编号
//         u32 irq = pci_alloc_irq_number();  // 分配中断号
//         tbl->addr_l = imsic_addr;          // imsic_addr 地址
//         tbl->addr_h = 0;
//         tbl->msg_data = irq;               // 中断号
//         tbl->ctrl = 0;
//         ++tbl;

//         if (msix_isr[i]) {                  // 检查处理函数是否存在
//             set_msix_handler(msix_isr[i], irq);     // 注册到 gs_msix_isr 中（全局变量）
//             aplic_enable(irq);              // 使能该中断
//         }
//     }
// }

u32 pci_alloc_irq_number(void)
{
    static u32 n_off = 0;   // Static 从 0x80 开始分配 irq num

    u32 irq = APLIC_MSIX0_IRQ + n_off;
    n_off += 1;
    return irq;
}

#define PAGE_ALIGN(sz)	((((u64)sz) + 0x0fff) & ~0x0fff)
u64 pci_alloc_mmio(u64 sz)
{
    static u64 s_off = 0;
    u64 addr = PCIE0_MMIO + s_off;
    s_off += PAGE_ALIGN(sz);
    // printf("addr: 0x%016llx, 0x%016llx\n", addr, s_off);
    return addr;
}

u64 pci_alloc_mmio_prefetch(u64 sz)
{
    static u64 s_prefetch_off = 0;
    u64 addr = PCIE0_PREFETCH_ADDR + s_prefetch_off;
    s_prefetch_off += PAGE_ALIGN(sz);
    // printf("addr: 0x%016llx, 0x%016llx\n", addr, s_off);
    return addr;
}