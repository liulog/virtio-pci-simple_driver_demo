#include "riscv-virt.h"
#include "aplic.h"
#include "imsic.h"
#include "printf/printf.h"

#define IMSIC_HART_STRIDE (0x1000)
// M-mode IMSIC CSRs
#define MISELECT (0x350)
#define MIREG (0x351)
#define MTOPEI (0x35C)
#define MTOPI (0xFB0)
// S-mode IMSIC CSRs
#define SISELECT (0x150)
#define SIREG (0x151)
#define STOPEI (0x15C)
#define STOPI (0xDB0)
// Constants for MISELECT/MIREG
// Pass one of these into MISELECT
// Then the MIREG will reflect that register
#define EIDELIVERY (0x70)
#define EITHRESHOLD (0x72)
#define EIP (0x80)
#define EIE (0xC0)

#define __ASM_STR(x) #x

#define csr_swap(csr, val)                                      \
    ({                                                          \
        unsigned long __v = (unsigned long)(val);               \
        __asm__ __volatile__("csrrw %0, " __ASM_STR(csr) ", %1" \
                             : "=r"(__v)                        \
                             : "rK"(__v)                        \
                             : "memory");                       \
        __v;                                                    \
    })

#define csr_read(csr)                                   \
    ({                                                  \
        register unsigned long __v;                     \
        __asm__ __volatile__("csrr %0, " __ASM_STR(csr) \
                             : "=r"(__v)                \
                             :                          \
                             : "memory");               \
        __v;                                            \
    })

#define csr_write(csr, val)                                \
    ({                                                     \
        unsigned long __v = (unsigned long)(val);          \
        __asm__ __volatile__("csrw " __ASM_STR(csr) ", %0" \
                             :                             \
                             : "rK"(__v)                   \
                             : "memory");                  \
    })

#define imsic_write(__c, __v) csr_write(__c, __v)
#define imsic_read(__c) csr_read(__c)

// mode: 0 - machine mode, 1 - supervisor mode
u64 imsic_get_addr(int mode, int hart)
{
    if (mode)
        return IMSIC0_S_ADDR + IMSIC_HART_STRIDE * hart;
    else
        return IMSIC0_M_ADDR + IMSIC_HART_STRIDE * hart;
}

// mode: 0 - machine mode, 1 - supervisor mode
void imsic_enable(int mode, int which)
{
    // 计算要写如的 eie 以及 bit
    // 64 bit 系统的只有偶数 eie[k]
    u64 eiebyte = EIE + (which / 64) * 2;
    u64 bit = which % 64;

    if (mode){
        imsic_write(SISELECT, eiebyte);
        u64 reg = imsic_read(SIREG);
        imsic_write(SIREG, reg | 1 << bit);
    }
    else{
        imsic_write(MISELECT, eiebyte);
        u64 reg = imsic_read(MIREG);
        imsic_write(MIREG, reg | 1 << bit);
    }
}

u64 imsic_get_irq(int mode)
{
    u64 val = 0;
    if (mode){
        val = csr_swap(STOPEI, 0);
    }else{
        val = csr_swap(MTOPEI, 0);
    }
    return val >> 16;
}

void imsic_init(void)
{
    // First, enable the interrupt file
    // 0 = disabled
    // 1 = enabled
    // 0x4000_0000 = use PLIC instead
    imsic_write(SISELECT, EIDELIVERY);
    imsic_write(SIREG, 1);

    // Set the interrupt threshold.
    // 0 = enable all interrupts
    // P = enable < P only
    // Priorities come from the interrupt number directly
    imsic_write(SISELECT, EITHRESHOLD);
    imsic_write(SIREG, 0);
}