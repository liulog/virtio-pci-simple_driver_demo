#include "riscv.h"
#include "riscv32.h"
#include "ns16550.h"
#include "printf/printf.h"
#include "aplic.h"
#include "imsic.h"
// #include "aclint_mtimer.h"
// #include "virtio-blk.h"
// #include "virtio-net.h"
// #include "virtio-pci-net.h"

u64 g_sys_tick = 0;

u64 handle_trap(u64 mcause, u64 mepc)
{
	int is_interrupt = mcause & 0x80000000;

	//printf("mcause: 0x%08x\n", mcause);
	//printf("mepc: 0x%08x\n", mepc);
	//printf("is_interrupt: 0x%08x\n", is_interrupt);

	// mcause = mcause & 0xFF;
	// if (is_interrupt) {
	// 	switch (mcause) {
	// 	case IRQ_S_SOFT: // s-mode soft
	// 		//aclint_clr_ssip(); // clear soft isr
    //         printf("ssoft isr: mcause %lld\n", mcause);
	// 		break;

    //     case IRQ_M_SOFT: // soft
	// 		//aclint_set_msip(0, 0); // clear soft isr
    //         printf("msoft isr: mcause %lld\n", mcause);
	// 		break;

	// 	case IRQ_M_TIMER: // mtime
	// 		// aclint_add_mtimecmp(D_CLOCK_RATE, 0);
    //         ++g_sys_tick;
	// 		// test only
	// 		if ((g_sys_tick & 3) == 0)
	// 			imsic_ipi_send(APLIC_SUPERVISOR, 0);
	// 		// debug only
    //         // printf("mtime: %d\n", g_sys_tick);
	// 		break;

	// 	case IRQ_M_EXT: // external
	// 		handle_external_trap(APLIC_MACHINE);
	// 		break;

	// 	case IRQ_S_EXT: // external
	// 		handle_external_trap(APLIC_SUPERVISOR);
	// 		break;

	// 	default:
	// 		printf("unknow isr: %lld\n", mcause);
	// 		break;
	// 	}
	// } else {
    //     printf("exception:\n");
    //     printf("mcause: 0x%08llx\n", mcause);
    //     printf("mepc: 0x%08llx\n", mepc);
	// 	while(1);
    // }

	//printf("mret");
	return is_interrupt ? mepc : (mepc + 4);
}

static trap_handler_fn gs_msix_isr[32] = { 0 };
void set_msix_handler(trap_handler_fn handler, int irq)	// 注册中断处理函数
{
	irq -= APLIC_MSIX0_IRQ;
	if (irq >= 0 && irq < 32) {							// 注册到 gs_msix_isr 中
		gs_msix_isr[irq] = handler;
	}
}

void handle_external_trap(int mode)
{
	int irq = imsic_get_irq(mode);
	//printf("mode %d, irq: %d\n", mode, irq);
	if (irq == APLIC_UART0_IRQ) {
		UartIsr();
	// } else if (irq == APLIC_VIRTIO1_IRQ) {
	// 	virtio_blk_intr();
	// } else if (irq == APLIC_VIRTIO2_IRQ) {
	// 	virtio_net_intr();
	// } else if (irq == APLIC_PCIE0_IRQ) {	// 0x21
	// 	virtio_pci_net_intr(irq);
	// } else if (irq >= APLIC_MSIX0_IRQ) {	// 0x80 以上的都是 MSI-X
	// 	trap_handler_fn handler = gs_msix_isr[irq-APLIC_MSIX0_IRQ];	// 获取处理函数
	// 	if (handler) handler(irq);			// 调用处理函数进行处理
	// } else if (irq == APLIC_IPI0_IRQ) {		// IPI
	// 	 printf("ipi: %d\n", irq);
	// } else {
		// printf("unknow external isr: %d\n", irq);
	}
}
