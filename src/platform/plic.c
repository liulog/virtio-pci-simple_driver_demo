#include "riscv.h"
#include "riscv-virt.h"
#include "types.h"
#include "plic.h"

#define PLIC_PRIORITY           (PLIC0_ADDR + 0x0)
#define PLIC_PENDING            (PLIC0_ADDR + 0x1000)
#define PLIC_ENABLE(context)      (PLIC0_ADDR + 0x2000 + (context)*0x80)
#define PLIC_THRESHOLD(context)   (PLIC0_ADDR + 0x200000 + (context)*0x1000)
#define PLIC_CLAIM(context)       (PLIC0_ADDR + 0x200004 + (context)*0x1000)

#define PLIC_REG(reg) (*((volatile u32 *)((u64)reg)))

void plic_init(void)
{   // set priority
    PLIC_REG(PLIC_PRIORITY + UART0_IRQ*4) = 1;
    // set threshold
    PLIC_REG(PLIC_THRESHOLD(1)) = 0;
    // enable
    PLIC_REG(PLIC_ENABLE(1)) = 1 << UART0_IRQ;
}

void plic_enable(int irq)
{
  // set priority
  PLIC_REG(PLIC_PRIORITY + irq*4) = 1;
  // enable irq
  u32 idx = irq / 32;
  u32 addr = PLIC_ENABLE(1) + 4 * idx;
  PLIC_REG(addr) |= 1 << (irq - 32 * idx);
}

// ask the PLIC what interrupt we should serve.
int plic_claim(void)
{
  int irq = PLIC_REG(PLIC_CLAIM(1));
  return irq;
}

// tell the PLIC we've served this IRQ.
void plic_complete(int irq)
{
  PLIC_REG(PLIC_CLAIM(1)) = irq;
}