#include "riscv.h"
#include "trap-handler.h"
#include "ns16550.h"
#include "printf/printf.h"
// #include "aplic.h"
// #include "imsic.h"
#include "plic.h"
#include "virtio/virtio-pci-blk.h"

u64 g_sys_tick = 0;

u64 handle_trap(u64 scause, u64 sepc)
{
	int is_interrupt = (int)(scause >> 63) & 0x00000001;
	scause = scause & 0xFF;
	if (is_interrupt) {
		switch (scause) {
		case IRQ_S_EXT: 		// 仅处理外部中断
			handle_external_trap();
			break;
		default:
			printf("unknow isr: %lld\n", scause);
			break;
		}
	} else {
        printf("exception:\n");
        printf("mcause: 0x%08llx\n", scause);
        printf("mepc: 0x%08llx\n", sepc);
		while(1);
    }

	return is_interrupt ? sepc : (sepc + 4);
}

// static trap_handler_fn gs_msix_isr[32] = { 0 };
// void set_msix_handler(trap_handler_fn handler, int irq)	// 注册中断处理函数
// {
// 	irq -= APLIC_MSIX0_IRQ;
// 	if (irq >= 0 && irq < 32) {							// 注册到 gs_msix_isr 中
// 		gs_msix_isr[irq] = handler;
// 	}
// }

void handle_external_trap()
{
	// int irq = imsic_get_irq(mode);
	// if (irq == APLIC_UART0_IRQ) {					// 0xA
	// 	UartIsr();
	// } else if (irq == APLIC_PCIE0_IRQ) {				// 0x21
	// 	virtio_pci_blk_intr(irq);
	// } else {
	// 	printf("unknow external isr: %d\n", irq);
	// }

	int irq = plic_claim();
	if (irq == UART0_IRQ) {
		UartIsr();
	} else if (irq == PCIE_IRQ) {
		virtio_pci_blk_intr(irq);
	} else {
		printf("unknow external isr: %d\n", irq);
	}

	if(irq)
      plic_complete(irq);
}
