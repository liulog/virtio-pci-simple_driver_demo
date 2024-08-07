#ifndef RISCV_VIRT_H_
#define RISCV_VIRT_H_

#define NS16550_ADDR		0x10000000UL
#define CLINT0_ADDR		    0x02000000UL
#define PLIC0_ADDR		    0x0c000000UL
#define PFLASH0_ADDR		0x20000000UL
#define PFLASH1_ADDR		0x22000000UL
#define RTC0_ADDR		    0x00101000UL
#define VIRTIO0_ADDR        0x10001000UL
#define VIRTIO1_ADDR        (VIRTIO0_ADDR + 0x1000UL)
#define VIRTIO2_ADDR        (VIRTIO1_ADDR + 0x1000UL)
#define ACLINT0_MTIMER_ADDR 0x02000000UL
#define APLIC0_M_ADDR       0x0c000000UL
#define APLIC0_S_ADDR       0x0d000000UL
#define IMSIC0_M_ADDR       0x24000000UL
#define IMSIC0_S_ADDR       0x28000000UL
#define PCIE0_ECAM          0x30000000UL
#define PCIE0_MMIO          0x40000000UL

void interrupts_init(void);
void plt_virt_init(void);

#endif /* RISCV_VIRT_H_ */
