#include <string.h>
#include "riscv.h"
#include "riscv-virt.h"
#include "ns16550.h"
#include "aplic.h"
#include "imsic.h"
#include "printf/printf.h"

void plt_virt_init(void)
{
	// console init
	UartInit(NS16550_ADDR);

	// interrupts init
	interrupts_init();
}

void interrupts_init(void){
	// interrupts arch init
	set_csr(sie, SIE_STIE | SIE_SSIE | SIE_SEIE);		// sie 打开
	set_csr(sstatus, SSTATUS_SIE);						// sstatus 打开

	imsic_init();
	aplic_init(APLIC_DM_MSI); 							// msix mode, 选择 MSI-Mode

	// interrupts enable (MSI)
	aplic_enable_irq(APLIC_SUPERVISOR, APLIC_DM_MSI, APLIC_UART0_IRQ, 1);
	imsic_enable(APLIC_SUPERVISOR, APLIC_UART0_IRQ);

	aplic_enable_irq(APLIC_SUPERVISOR, APLIC_DM_MSI, APLIC_PCIE0_IRQ, 1);
	imsic_enable(APLIC_SUPERVISOR, APLIC_PCIE0_IRQ);
}

void putchar_(char c)
{
	UartPutc( c );
}
