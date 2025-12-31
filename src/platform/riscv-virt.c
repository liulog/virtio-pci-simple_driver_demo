#include <string.h>
#include "riscv.h"
#include "riscv-virt.h"
#include "ns16550.h"
// #include "aplic.h"
// #include "imsic.h"
#include "plic.h"
#include "printf/printf.h"

void plt_virt_init(void)
{
	// console init
	UartInit(NS16550_ADDR);

	// interrupts init
	interrupts_init();

	// enable uart irq
	// aplic_enable_irq(APLIC_SUPERVISOR, APLIC_DM_MSI, APLIC_UART0_IRQ, 1);
	// imsic_enable(APLIC_SUPERVISOR, APLIC_UART0_IRQ);
}

void interrupts_init(void){
	// interrupts arch init
	set_csr(sie, SIE_SEIE); // Enable external interrupt
	set_csr(sstatus, SSTATUS_SIE); // Enable global interrupt, allow interrupts when in S-mode

	plic_init(); // Initial PLIC, enable uart irq
	// imsic_init();
	// aplic_init(APLIC_DM_MSI);
}

void putchar_(char c)
{
	UartPutc( c );
}


void shutdown(int exit_code) {
    volatile uint32_t *test_finish = (volatile uint32_t *)SIFIVE_TEST_FINISH_ADDR;
    uint32_t code = (exit_code == 0) ? 0x5555U : 0x3333U;
    *test_finish = code;
    mb();
    while (1);
}