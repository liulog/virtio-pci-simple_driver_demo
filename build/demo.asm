
build/demo.elf:     file format elf64-littleriscv

SYMBOL TABLE:
0000000080200000 l    d  .boot	0000000000000000 .boot
00000000802000cc l    d  .text	0000000000000000 .text
0000000080202000 l    d  .rodata	0000000000000000 .rodata
0000000080203000 l    d  .data	0000000000000000 .data
0000000080203010 l    d  .bss	0000000000000000 .bss
0000000080204000 l    d  .stack	0000000000000000 .stack
0000000000000000 l    d  .comment	0000000000000000 .comment
0000000000000000 l    d  .riscv.attributes	0000000000000000 .riscv.attributes
0000000000000000 l    df *ABS*	0000000000000000 start.o
0000000080200038 l       .boot	0000000000000000 trap_entry
0000000000000000 l    df *ABS*	0000000000000000 main.c
0000000000000000 l    df *ABS*	0000000000000000 ns16550.c
0000000080203010 l     O .bss	0000000000000008 gs_uart_base
0000000000000000 l    df *ABS*	0000000000000000 printf.c
00000000802002a6 l     F .text	0000000000000004 putchar_wrapper
00000000802002aa l     F .text	0000000000000426 out_rev_
00000000802006d0 l     F .text	00000000000007b2 print_integer
0000000080200e82 l     F .text	0000000000000a00 format_string_loop.constprop.0
0000000000000000 l    df *ABS*	0000000000000000 riscv32.c
0000000000000000 l    df *ABS*	0000000000000000 riscv-virt.c
0000000000000000 l    df *ABS*	0000000000000000 imsic.c
0000000080201dba g     F .text	0000000000000060 imsic_trigger
00000000802001ce g     F .text	000000000000001e UartOut
0000000080201882 g     F .text	0000000000000076 vprintf_
0000000000010000 g       *ABS*	0000000000000000 __stack_size
0000000080203008 g     O .data	0000000000000004 version
0000000080203000 g     O .data	0000000000000008 hello
00000000802001b0 g     F .text	000000000000001e UartGetc
0000000080201ae8 g     F .text	0000000000000086 sprintf_
0000000080201cf2 g     F .text	0000000000000060 imsic_enable
0000000080201c78 g     F .text	0000000000000012 handle_trap
0000000080203010 g       .bss	0000000000000000 _bss_start
0000000080201d52 g     F .text	0000000000000068 imsic_disable
0000000080201c8a g     F .text	0000000000000002 set_msix_handler
0000000080203018 g     O .bss	0000000000000008 g_sys_tick
0000000080201978 g     F .text	0000000000000074 vsprintf_
00000000802018f8 g     F .text	0000000000000080 vsnprintf_
00000000802019ec g     F .text	0000000000000074 vfctprintf
0000000080201e94 g     F .text	000000000000002a imsic_init
0000000080203020 g       .bss	0000000000000000 _bss_end
0000000080214000 g       .stack	0000000000000000 _stack_top
000000008020013c g     F .text	0000000000000074 UartPutc
0000000080201bfa g     F .text	000000000000007e fctprintf
0000000080201e1a g     F .text	0000000000000068 imsic_clear
00000000802001ec g     F .text	0000000000000030 UartInit
0000000080201cae g     F .text	000000000000001a imsic_get_addr
0000000080200000 g       .boot	0000000000000000 _start
0000000080201e82 g     F .text	0000000000000012 imsic_get_irq
00000000802000cc g     F .text	0000000000000070 main
0000000080201c8c g     F .text	000000000000001e handle_external_trap
000000008020021c g     F .text	000000000000008a UartIsr
0000000080201b6e g     F .text	000000000000008c snprintf_
0000000080201a60 g     F .text	0000000000000088 printf_
0000000080201cc8 g     F .text	000000000000002a imsic_ipi_send
0000000080201caa g     F .text	0000000000000004 putchar_



Disassembly of section .boot:

0000000080200000 <_start>:
    80200000:	00000297          	auipc	t0,0x0
    80200004:	03828293          	addi	t0,t0,56 # 80200038 <trap_entry>
    80200008:	10529073          	csrw	stvec,t0
    8020000c:	00014117          	auipc	sp,0x14
    80200010:	ff410113          	addi	sp,sp,-12 # 80214000 <_stack_top>
    80200014:	00003517          	auipc	a0,0x3
    80200018:	ffc50513          	addi	a0,a0,-4 # 80203010 <gs_uart_base>
    8020001c:	00003597          	auipc	a1,0x3
    80200020:	00458593          	addi	a1,a1,4 # 80203020 <_bss_end>
    80200024:	00b57763          	bgeu	a0,a1,80200032 <_start+0x32>
    80200028:	00050023          	sb	zero,0(a0)
    8020002c:	0505                	addi	a0,a0,1
    8020002e:	feb56de3          	bltu	a0,a1,80200028 <_start+0x28>
    80200032:	09a000ef          	jal	802000cc <main>
    80200036:	0001                	nop

0000000080200038 <trap_entry>:
    80200038:	7111                	addi	sp,sp,-256
    8020003a:	e406                	sd	ra,8(sp)
    8020003c:	e816                	sd	t0,16(sp)
    8020003e:	ec1a                	sd	t1,24(sp)
    80200040:	f01e                	sd	t2,32(sp)
    80200042:	f422                	sd	s0,40(sp)
    80200044:	f826                	sd	s1,48(sp)
    80200046:	fc2a                	sd	a0,56(sp)
    80200048:	e0ae                	sd	a1,64(sp)
    8020004a:	e4b2                	sd	a2,72(sp)
    8020004c:	e8b6                	sd	a3,80(sp)
    8020004e:	ecba                	sd	a4,88(sp)
    80200050:	f0be                	sd	a5,96(sp)
    80200052:	f4c2                	sd	a6,104(sp)
    80200054:	f8c6                	sd	a7,112(sp)
    80200056:	fcca                	sd	s2,120(sp)
    80200058:	e14e                	sd	s3,128(sp)
    8020005a:	e552                	sd	s4,136(sp)
    8020005c:	e956                	sd	s5,144(sp)
    8020005e:	ed5a                	sd	s6,152(sp)
    80200060:	f15e                	sd	s7,160(sp)
    80200062:	f562                	sd	s8,168(sp)
    80200064:	f966                	sd	s9,176(sp)
    80200066:	fd6a                	sd	s10,184(sp)
    80200068:	e1ee                	sd	s11,192(sp)
    8020006a:	e5f2                	sd	t3,200(sp)
    8020006c:	e9f6                	sd	t4,208(sp)
    8020006e:	edfa                	sd	t5,216(sp)
    80200070:	f1fe                	sd	t6,224(sp)
    80200072:	100022f3          	csrr	t0,sstatus
    80200076:	f596                	sd	t0,232(sp)
    80200078:	14202573          	csrr	a0,scause
    8020007c:	141025f3          	csrr	a1,sepc
    80200080:	3f9010ef          	jal	80201c78 <handle_trap>
    80200084:	14151073          	csrw	sepc,a0
    80200088:	72ae                	ld	t0,232(sp)
    8020008a:	10029073          	csrw	sstatus,t0
    8020008e:	60a2                	ld	ra,8(sp)
    80200090:	62c2                	ld	t0,16(sp)
    80200092:	6362                	ld	t1,24(sp)
    80200094:	7382                	ld	t2,32(sp)
    80200096:	7422                	ld	s0,40(sp)
    80200098:	74c2                	ld	s1,48(sp)
    8020009a:	7562                	ld	a0,56(sp)
    8020009c:	6586                	ld	a1,64(sp)
    8020009e:	6626                	ld	a2,72(sp)
    802000a0:	66c6                	ld	a3,80(sp)
    802000a2:	6766                	ld	a4,88(sp)
    802000a4:	7786                	ld	a5,96(sp)
    802000a6:	7826                	ld	a6,104(sp)
    802000a8:	78c6                	ld	a7,112(sp)
    802000aa:	7966                	ld	s2,120(sp)
    802000ac:	698a                	ld	s3,128(sp)
    802000ae:	6a2a                	ld	s4,136(sp)
    802000b0:	6aca                	ld	s5,144(sp)
    802000b2:	6b6a                	ld	s6,152(sp)
    802000b4:	7b8a                	ld	s7,160(sp)
    802000b6:	7c2a                	ld	s8,168(sp)
    802000b8:	7cca                	ld	s9,176(sp)
    802000ba:	7d6a                	ld	s10,184(sp)
    802000bc:	6d8e                	ld	s11,192(sp)
    802000be:	6e2e                	ld	t3,200(sp)
    802000c0:	6ece                	ld	t4,208(sp)
    802000c2:	6f6e                	ld	t5,216(sp)
    802000c4:	7f8e                	ld	t6,224(sp)
    802000c6:	6111                	addi	sp,sp,256
    802000c8:	10200073          	sret

Disassembly of section .text:

00000000802000cc <main>:
    802000cc:	1141                	addi	sp,sp,-16
    802000ce:	10000537          	lui	a0,0x10000
    802000d2:	e406                	sd	ra,8(sp)
    802000d4:	e022                	sd	s0,0(sp)
    802000d6:	116000ef          	jal	802001ec <UartInit>
    802000da:	00002517          	auipc	a0,0x2
    802000de:	f2650513          	addi	a0,a0,-218 # 80202000 <imsic_init+0x16c>
    802000e2:	17f010ef          	jal	80201a60 <printf_>
    802000e6:	00003417          	auipc	s0,0x3
    802000ea:	f2240413          	addi	s0,s0,-222 # 80203008 <version>
    802000ee:	400c                	lw	a1,0(s0)
    802000f0:	00002517          	auipc	a0,0x2
    802000f4:	f3850513          	addi	a0,a0,-200 # 80202028 <imsic_init+0x194>
    802000f8:	169010ef          	jal	80201a60 <printf_>
    802000fc:	85a2                	mv	a1,s0
    802000fe:	00002517          	auipc	a0,0x2
    80200102:	f4250513          	addi	a0,a0,-190 # 80202040 <imsic_init+0x1ac>
    80200106:	15b010ef          	jal	80201a60 <printf_>
    8020010a:	100025f3          	csrr	a1,sstatus
    8020010e:	00002517          	auipc	a0,0x2
    80200112:	f4a50513          	addi	a0,a0,-182 # 80202058 <imsic_init+0x1c4>
    80200116:	14b010ef          	jal	80201a60 <printf_>
    8020011a:	00003597          	auipc	a1,0x3
    8020011e:	ee65b583          	ld	a1,-282(a1) # 80203000 <hello>
    80200122:	00002517          	auipc	a0,0x2
    80200126:	f4e50513          	addi	a0,a0,-178 # 80202070 <imsic_init+0x1dc>
    8020012a:	137010ef          	jal	80201a60 <printf_>
    8020012e:	00002517          	auipc	a0,0x2
    80200132:	f4a50513          	addi	a0,a0,-182 # 80202078 <imsic_init+0x1e4>
    80200136:	12b010ef          	jal	80201a60 <printf_>
    8020013a:	a001                	j	8020013a <main+0x6e>

000000008020013c <UartPutc>:
    8020013c:	00003697          	auipc	a3,0x3
    80200140:	ed46b683          	ld	a3,-300(a3) # 80203010 <gs_uart_base>
    80200144:	00568793          	addi	a5,a3,5
    80200148:	0007c703          	lbu	a4,0(a5)
    8020014c:	02077293          	andi	t0,a4,32
    80200150:	04029b63          	bnez	t0,802001a6 <UartPutc+0x6a>
    80200154:	0007c303          	lbu	t1,0(a5)
    80200158:	02037393          	andi	t2,t1,32
    8020015c:	04039563          	bnez	t2,802001a6 <UartPutc+0x6a>
    80200160:	0007c583          	lbu	a1,0(a5)
    80200164:	0205f613          	andi	a2,a1,32
    80200168:	ee1d                	bnez	a2,802001a6 <UartPutc+0x6a>
    8020016a:	0007c803          	lbu	a6,0(a5)
    8020016e:	02087893          	andi	a7,a6,32
    80200172:	02089a63          	bnez	a7,802001a6 <UartPutc+0x6a>
    80200176:	0007ce03          	lbu	t3,0(a5)
    8020017a:	020e7e93          	andi	t4,t3,32
    8020017e:	020e9463          	bnez	t4,802001a6 <UartPutc+0x6a>
    80200182:	0007cf03          	lbu	t5,0(a5)
    80200186:	020f7f93          	andi	t6,t5,32
    8020018a:	000f9e63          	bnez	t6,802001a6 <UartPutc+0x6a>
    8020018e:	0007c703          	lbu	a4,0(a5)
    80200192:	02077293          	andi	t0,a4,32
    80200196:	00029863          	bnez	t0,802001a6 <UartPutc+0x6a>
    8020019a:	0007c303          	lbu	t1,0(a5)
    8020019e:	02037393          	andi	t2,t1,32
    802001a2:	fa0383e3          	beqz	t2,80200148 <UartPutc+0xc>
    802001a6:	0ff57793          	zext.b	a5,a0
    802001aa:	00f68023          	sb	a5,0(a3)
    802001ae:	8082                	ret

00000000802001b0 <UartGetc>:
    802001b0:	00003717          	auipc	a4,0x3
    802001b4:	e6073703          	ld	a4,-416(a4) # 80203010 <gs_uart_base>
    802001b8:	00574783          	lbu	a5,5(a4)
    802001bc:	0017f293          	andi	t0,a5,1
    802001c0:	00028563          	beqz	t0,802001ca <UartGetc+0x1a>
    802001c4:	00074503          	lbu	a0,0(a4)
    802001c8:	8082                	ret
    802001ca:	557d                	li	a0,-1
    802001cc:	8082                	ret

00000000802001ce <UartOut>:
    802001ce:	00003717          	auipc	a4,0x3
    802001d2:	e4273703          	ld	a4,-446(a4) # 80203010 <gs_uart_base>
    802001d6:	00574783          	lbu	a5,5(a4)
    802001da:	0017f293          	andi	t0,a5,1
    802001de:	00028563          	beqz	t0,802001e8 <UartOut+0x1a>
    802001e2:	00074503          	lbu	a0,0(a4)
    802001e6:	8082                	ret
    802001e8:	557d                	li	a0,-1
    802001ea:	8082                	ret

00000000802001ec <UartInit>:
    802001ec:	000500a3          	sb	zero,1(a0)
    802001f0:	f8000793          	li	a5,-128
    802001f4:	00f501a3          	sb	a5,3(a0)
    802001f8:	4285                	li	t0,1
    802001fa:	00550023          	sb	t0,0(a0)
    802001fe:	000500a3          	sb	zero,1(a0)
    80200202:	470d                	li	a4,3
    80200204:	00e501a3          	sb	a4,3(a0)
    80200208:	431d                	li	t1,7
    8020020a:	00650123          	sb	t1,2(a0)
    8020020e:	00003717          	auipc	a4,0x3
    80200212:	e0a73123          	sd	a0,-510(a4) # 80203010 <gs_uart_base>
    80200216:	005500a3          	sb	t0,1(a0)
    8020021a:	8082                	ret

000000008020021c <UartIsr>:
    8020021c:	00003617          	auipc	a2,0x3
    80200220:	df463603          	ld	a2,-524(a2) # 80203010 <gs_uart_base>
    80200224:	00564703          	lbu	a4,5(a2)
    80200228:	00560793          	addi	a5,a2,5
    8020022c:	00177293          	andi	t0,a4,1
    80200230:	06028a63          	beqz	t0,802002a4 <UartIsr+0x88>
    80200234:	00064683          	lbu	a3,0(a2)
    80200238:	0ff6f313          	zext.b	t1,a3
    8020023c:	0007c383          	lbu	t2,0(a5)
    80200240:	0203f513          	andi	a0,t2,32
    80200244:	e921                	bnez	a0,80200294 <UartIsr+0x78>
    80200246:	0007c583          	lbu	a1,0(a5)
    8020024a:	0205f813          	andi	a6,a1,32
    8020024e:	04081363          	bnez	a6,80200294 <UartIsr+0x78>
    80200252:	0007c883          	lbu	a7,0(a5)
    80200256:	0208fe13          	andi	t3,a7,32
    8020025a:	020e1d63          	bnez	t3,80200294 <UartIsr+0x78>
    8020025e:	0007ce83          	lbu	t4,0(a5)
    80200262:	020eff13          	andi	t5,t4,32
    80200266:	020f1763          	bnez	t5,80200294 <UartIsr+0x78>
    8020026a:	0007cf83          	lbu	t6,0(a5)
    8020026e:	020ff713          	andi	a4,t6,32
    80200272:	e30d                	bnez	a4,80200294 <UartIsr+0x78>
    80200274:	0007c283          	lbu	t0,0(a5)
    80200278:	0202f693          	andi	a3,t0,32
    8020027c:	ee81                	bnez	a3,80200294 <UartIsr+0x78>
    8020027e:	0007c383          	lbu	t2,0(a5)
    80200282:	0203f513          	andi	a0,t2,32
    80200286:	e519                	bnez	a0,80200294 <UartIsr+0x78>
    80200288:	0007c583          	lbu	a1,0(a5)
    8020028c:	0205f813          	andi	a6,a1,32
    80200290:	fa0806e3          	beqz	a6,8020023c <UartIsr+0x20>
    80200294:	00660023          	sb	t1,0(a2)
    80200298:	0007c303          	lbu	t1,0(a5)
    8020029c:	00137893          	andi	a7,t1,1
    802002a0:	f8089ae3          	bnez	a7,80200234 <UartIsr+0x18>
    802002a4:	8082                	ret

00000000802002a6 <putchar_wrapper>:
    802002a6:	2050106f          	j	80201caa <putchar_>

00000000802002aa <out_rev_>:
    802002aa:	715d                	addi	sp,sp,-80
    802002ac:	e0a2                	sd	s0,64(sp)
    802002ae:	fc26                	sd	s1,56(sp)
    802002b0:	f44e                	sd	s3,40(sp)
    802002b2:	ec56                	sd	s5,24(sp)
    802002b4:	e85a                	sd	s6,16(sp)
    802002b6:	e45e                	sd	s7,8(sp)
    802002b8:	e486                	sd	ra,72(sp)
    802002ba:	f84a                	sd	s2,48(sp)
    802002bc:	f052                	sd	s4,32(sp)
    802002be:	01852a03          	lw	s4,24(a0)
    802002c2:	00377793          	andi	a5,a4,3
    802002c6:	842a                	mv	s0,a0
    802002c8:	8aba                	mv	s5,a4
    802002ca:	8b2e                	mv	s6,a1
    802002cc:	84b2                	mv	s1,a2
    802002ce:	89b6                	mv	s3,a3
    802002d0:	8bd2                	mv	s7,s4
    802002d2:	12079363          	bnez	a5,802003f8 <out_rev_+0x14e>
    802002d6:	83d2                	mv	t2,s4
    802002d8:	8932                	mv	s2,a2
    802002da:	36d67563          	bgeu	a2,a3,80200644 <out_rev_+0x39a>
    802002de:	e062                	sd	s8,0(sp)
    802002e0:	40d60c33          	sub	s8,a2,a3
    802002e4:	fffc4093          	not	ra,s8
    802002e8:	0030f713          	andi	a4,ra,3
    802002ec:	02000b93          	li	s7,32
    802002f0:	8c3a                	mv	s8,a4
    802002f2:	cb3d                	beqz	a4,80200368 <out_rev_+0xbe>
    802002f4:	01c52283          	lw	t0,28(a0)
    802002f8:	001a031b          	addiw	t1,s4,1
    802002fc:	00652c23          	sw	t1,24(a0)
    80200300:	005a7a63          	bgeu	s4,t0,80200314 <out_rev_+0x6a>
    80200304:	00053383          	ld	t2,0(a0)
    80200308:	38038363          	beqz	t2,8020068e <out_rev_+0x3e4>
    8020030c:	650c                	ld	a1,8(a0)
    8020030e:	02000513          	li	a0,32
    80200312:	9382                	jalr	t2
    80200314:	4805                	li	a6,1
    80200316:	01842383          	lw	t2,24(s0)
    8020031a:	0014891b          	addiw	s2,s1,1
    8020031e:	000c089b          	sext.w	a7,s8
    80200322:	050c0363          	beq	s8,a6,80200368 <out_rev_+0xbe>
    80200326:	4e09                	li	t3,2
    80200328:	03c88563          	beq	a7,t3,80200352 <out_rev_+0xa8>
    8020032c:	01c42e83          	lw	t4,28(s0)
    80200330:	00138f1b          	addiw	t5,t2,1
    80200334:	01e42c23          	sw	t5,24(s0)
    80200338:	01d3fa63          	bgeu	t2,t4,8020034c <out_rev_+0xa2>
    8020033c:	00043f83          	ld	t6,0(s0)
    80200340:	360f8d63          	beqz	t6,802006ba <out_rev_+0x410>
    80200344:	640c                	ld	a1,8(s0)
    80200346:	02000513          	li	a0,32
    8020034a:	9f82                	jalr	t6
    8020034c:	01842383          	lw	t2,24(s0)
    80200350:	2905                	addiw	s2,s2,1
    80200352:	01c42283          	lw	t0,28(s0)
    80200356:	0013831b          	addiw	t1,t2,1
    8020035a:	00642c23          	sw	t1,24(s0)
    8020035e:	0853e263          	bltu	t2,t0,802003e2 <out_rev_+0x138>
    80200362:	01842383          	lw	t2,24(s0)
    80200366:	2905                	addiw	s2,s2,1
    80200368:	4c48                	lw	a0,28(s0)
    8020036a:	0013859b          	addiw	a1,t2,1
    8020036e:	cc0c                	sw	a1,24(s0)
    80200370:	00a3f963          	bgeu	t2,a0,80200382 <out_rev_+0xd8>
    80200374:	6010                	ld	a2,0(s0)
    80200376:	2a060263          	beqz	a2,8020061a <out_rev_+0x370>
    8020037a:	640c                	ld	a1,8(s0)
    8020037c:	02000513          	li	a0,32
    80200380:	9602                	jalr	a2
    80200382:	00190c1b          	addiw	s8,s2,1
    80200386:	23898963          	beq	s3,s8,802005b8 <out_rev_+0x30e>
    8020038a:	01842903          	lw	s2,24(s0)
    8020038e:	4c48                	lw	a0,28(s0)
    80200390:	0019069b          	addiw	a3,s2,1
    80200394:	cc14                	sw	a3,24(s0)
    80200396:	00a97a63          	bgeu	s2,a0,802003aa <out_rev_+0x100>
    8020039a:	00043803          	ld	a6,0(s0)
    8020039e:	2c080263          	beqz	a6,80200662 <out_rev_+0x3b8>
    802003a2:	640c                	ld	a1,8(s0)
    802003a4:	02000513          	li	a0,32
    802003a8:	9802                	jalr	a6
    802003aa:	01842083          	lw	ra,24(s0)
    802003ae:	4c5c                	lw	a5,28(s0)
    802003b0:	2c05                	addiw	s8,s8,1
    802003b2:	0010871b          	addiw	a4,ra,1
    802003b6:	cc18                	sw	a4,24(s0)
    802003b8:	00f0fa63          	bgeu	ra,a5,802003cc <out_rev_+0x122>
    802003bc:	00043303          	ld	t1,0(s0)
    802003c0:	28030663          	beqz	t1,8020064c <out_rev_+0x3a2>
    802003c4:	640c                	ld	a1,8(s0)
    802003c6:	02000513          	li	a0,32
    802003ca:	9302                	jalr	t1
    802003cc:	01842383          	lw	t2,24(s0)
    802003d0:	01c42e03          	lw	t3,28(s0)
    802003d4:	001c091b          	addiw	s2,s8,1
    802003d8:	0013851b          	addiw	a0,t2,1
    802003dc:	cc08                	sw	a0,24(s0)
    802003de:	f9c3f2e3          	bgeu	t2,t3,80200362 <out_rev_+0xb8>
    802003e2:	6014                	ld	a3,0(s0)
    802003e4:	22068063          	beqz	a3,80200604 <out_rev_+0x35a>
    802003e8:	640c                	ld	a1,8(s0)
    802003ea:	02000513          	li	a0,32
    802003ee:	2905                	addiw	s2,s2,1
    802003f0:	9682                	jalr	a3
    802003f2:	01842383          	lw	t2,24(s0)
    802003f6:	bf8d                	j	80200368 <out_rev_+0xbe>
    802003f8:	12060363          	beqz	a2,8020051e <out_rev_+0x274>
    802003fc:	8e5e                	mv	t3,s7
    802003fe:	34fd                	addiw	s1,s1,-1
    80200400:	02049e93          	slli	t4,s1,0x20
    80200404:	020edf13          	srli	t5,t4,0x20
    80200408:	003f7913          	andi	s2,t5,3
    8020040c:	01eb04b3          	add	s1,s6,t5
    80200410:	0c090c63          	beqz	s2,802004e8 <out_rev_+0x23e>
    80200414:	01c42f83          	lw	t6,28(s0)
    80200418:	001b809b          	addiw	ra,s7,1
    8020041c:	0004c503          	lbu	a0,0(s1)
    80200420:	00142c23          	sw	ra,24(s0)
    80200424:	01fbf763          	bgeu	s7,t6,80200432 <out_rev_+0x188>
    80200428:	601c                	ld	a5,0(s0)
    8020042a:	20078263          	beqz	a5,8020062e <out_rev_+0x384>
    8020042e:	640c                	ld	a1,8(s0)
    80200430:	9782                	jalr	a5
    80200432:	fff48b93          	addi	s7,s1,-1
    80200436:	4505                	li	a0,1
    80200438:	01842e03          	lw	t3,24(s0)
    8020043c:	84de                	mv	s1,s7
    8020043e:	0aa90563          	beq	s2,a0,802004e8 <out_rev_+0x23e>
    80200442:	4589                	li	a1,2
    80200444:	14b91763          	bne	s2,a1,80200592 <out_rev_+0x2e8>
    80200448:	01c42f03          	lw	t5,28(s0)
    8020044c:	001e091b          	addiw	s2,t3,1
    80200450:	0004c503          	lbu	a0,0(s1)
    80200454:	01242c23          	sw	s2,24(s0)
    80200458:	01ee7863          	bgeu	t3,t5,80200468 <out_rev_+0x1be>
    8020045c:	00043f83          	ld	t6,0(s0)
    80200460:	200f8c63          	beqz	t6,80200678 <out_rev_+0x3ce>
    80200464:	640c                	ld	a1,8(s0)
    80200466:	9f82                	jalr	t6
    80200468:	01842e03          	lw	t3,24(s0)
    8020046c:	14fd                	addi	s1,s1,-1
    8020046e:	a8ad                	j	802004e8 <out_rev_+0x23e>
    80200470:	640c                	ld	a1,8(s0)
    80200472:	9b82                	jalr	s7
    80200474:	fff48913          	addi	s2,s1,-1
    80200478:	0a9b0363          	beq	s6,s1,8020051e <out_rev_+0x274>
    8020047c:	4c1c                	lw	a5,24(s0)
    8020047e:	01c42283          	lw	t0,28(s0)
    80200482:	fff4c503          	lbu	a0,-1(s1)
    80200486:	0017831b          	addiw	t1,a5,1
    8020048a:	00642c23          	sw	t1,24(s0)
    8020048e:	0057f863          	bgeu	a5,t0,8020049e <out_rev_+0x1f4>
    80200492:	00043383          	ld	t2,0(s0)
    80200496:	14038c63          	beqz	t2,802005ee <out_rev_+0x344>
    8020049a:	640c                	ld	a1,8(s0)
    8020049c:	9382                	jalr	t2
    8020049e:	01842803          	lw	a6,24(s0)
    802004a2:	4c44                	lw	s1,28(s0)
    802004a4:	fff94503          	lbu	a0,-1(s2)
    802004a8:	0018089b          	addiw	a7,a6,1
    802004ac:	01142c23          	sw	a7,24(s0)
    802004b0:	00987863          	bgeu	a6,s1,802004c0 <out_rev_+0x216>
    802004b4:	00043e03          	ld	t3,0(s0)
    802004b8:	120e0063          	beqz	t3,802005d8 <out_rev_+0x32e>
    802004bc:	640c                	ld	a1,8(s0)
    802004be:	9e02                	jalr	t3
    802004c0:	4c1c                	lw	a5,24(s0)
    802004c2:	4c58                	lw	a4,28(s0)
    802004c4:	ffe94503          	lbu	a0,-2(s2)
    802004c8:	0017829b          	addiw	t0,a5,1
    802004cc:	00542c23          	sw	t0,24(s0)
    802004d0:	00e7f863          	bgeu	a5,a4,802004e0 <out_rev_+0x236>
    802004d4:	00043303          	ld	t1,0(s0)
    802004d8:	0e030563          	beqz	t1,802005c2 <out_rev_+0x318>
    802004dc:	640c                	ld	a1,8(s0)
    802004de:	9302                	jalr	t1
    802004e0:	01842e03          	lw	t3,24(s0)
    802004e4:	ffd90493          	addi	s1,s2,-3
    802004e8:	01c42303          	lw	t1,28(s0)
    802004ec:	001e039b          	addiw	t2,t3,1
    802004f0:	0004c503          	lbu	a0,0(s1)
    802004f4:	00742c23          	sw	t2,24(s0)
    802004f8:	f66e7ee3          	bgeu	t3,t1,80200474 <out_rev_+0x1ca>
    802004fc:	00043b83          	ld	s7,0(s0)
    80200500:	f60b98e3          	bnez	s7,80200470 <out_rev_+0x1c6>
    80200504:	680c                	ld	a1,16(s0)
    80200506:	020e1613          	slli	a2,t3,0x20
    8020050a:	02065693          	srli	a3,a2,0x20
    8020050e:	00d58833          	add	a6,a1,a3
    80200512:	00a80023          	sb	a0,0(a6)
    80200516:	fff48913          	addi	s2,s1,-1
    8020051a:	f69b11e3          	bne	s6,s1,8020047c <out_rev_+0x1d2>
    8020051e:	002afa93          	andi	s5,s5,2
    80200522:	02000493          	li	s1,32
    80200526:	020a8e63          	beqz	s5,80200562 <out_rev_+0x2b8>
    8020052a:	4c18                	lw	a4,24(s0)
    8020052c:	414708bb          	subw	a7,a4,s4
    80200530:	00170b1b          	addiw	s6,a4,1
    80200534:	0338f763          	bgeu	a7,s3,80200562 <out_rev_+0x2b8>
    80200538:	4c48                	lw	a0,28(s0)
    8020053a:	01642c23          	sw	s6,24(s0)
    8020053e:	2885                	addiw	a7,a7,1
    80200540:	02a77c63          	bgeu	a4,a0,80200578 <out_rev_+0x2ce>
    80200544:	00043e03          	ld	t3,0(s0)
    80200548:	020e0a63          	beqz	t3,8020057c <out_rev_+0x2d2>
    8020054c:	640c                	ld	a1,8(s0)
    8020054e:	02000513          	li	a0,32
    80200552:	9e02                	jalr	t3
    80200554:	4c18                	lw	a4,24(s0)
    80200556:	414708bb          	subw	a7,a4,s4
    8020055a:	00170b1b          	addiw	s6,a4,1
    8020055e:	fd38ede3          	bltu	a7,s3,80200538 <out_rev_+0x28e>
    80200562:	60a6                	ld	ra,72(sp)
    80200564:	6406                	ld	s0,64(sp)
    80200566:	74e2                	ld	s1,56(sp)
    80200568:	7942                	ld	s2,48(sp)
    8020056a:	79a2                	ld	s3,40(sp)
    8020056c:	7a02                	ld	s4,32(sp)
    8020056e:	6ae2                	ld	s5,24(sp)
    80200570:	6b42                	ld	s6,16(sp)
    80200572:	6ba2                	ld	s7,8(sp)
    80200574:	6161                	addi	sp,sp,80
    80200576:	8082                	ret
    80200578:	875a                	mv	a4,s6
    8020057a:	bf5d                	j	80200530 <out_rev_+0x286>
    8020057c:	01043e83          	ld	t4,16(s0)
    80200580:	02071f13          	slli	t5,a4,0x20
    80200584:	020f5f93          	srli	t6,t5,0x20
    80200588:	01fe80b3          	add	ra,t4,t6
    8020058c:	00908023          	sb	s1,0(ra)
    80200590:	bf69                	j	8020052a <out_rev_+0x280>
    80200592:	4c50                	lw	a2,28(s0)
    80200594:	001e069b          	addiw	a3,t3,1
    80200598:	000bc503          	lbu	a0,0(s7)
    8020059c:	cc14                	sw	a3,24(s0)
    8020059e:	00ce7863          	bgeu	t3,a2,802005ae <out_rev_+0x304>
    802005a2:	00043803          	ld	a6,0(s0)
    802005a6:	10080063          	beqz	a6,802006a6 <out_rev_+0x3fc>
    802005aa:	640c                	ld	a1,8(s0)
    802005ac:	9802                	jalr	a6
    802005ae:	01842e03          	lw	t3,24(s0)
    802005b2:	fffb8493          	addi	s1,s7,-1
    802005b6:	bd49                	j	80200448 <out_rev_+0x19e>
    802005b8:	c4ed                	beqz	s1,802006a2 <out_rev_+0x3f8>
    802005ba:	01842b83          	lw	s7,24(s0)
    802005be:	6c02                	ld	s8,0(sp)
    802005c0:	bd35                	j	802003fc <out_rev_+0x152>
    802005c2:	01043383          	ld	t2,16(s0)
    802005c6:	02079b93          	slli	s7,a5,0x20
    802005ca:	020bd593          	srli	a1,s7,0x20
    802005ce:	00b38633          	add	a2,t2,a1
    802005d2:	00a60023          	sb	a0,0(a2)
    802005d6:	b729                	j	802004e0 <out_rev_+0x236>
    802005d8:	01043e83          	ld	t4,16(s0)
    802005dc:	02081f13          	slli	t5,a6,0x20
    802005e0:	020f5f93          	srli	t6,t5,0x20
    802005e4:	01fe80b3          	add	ra,t4,t6
    802005e8:	00a08023          	sb	a0,0(ra)
    802005ec:	bdd1                	j	802004c0 <out_rev_+0x216>
    802005ee:	01043b83          	ld	s7,16(s0)
    802005f2:	02079593          	slli	a1,a5,0x20
    802005f6:	0205d613          	srli	a2,a1,0x20
    802005fa:	00cb86b3          	add	a3,s7,a2
    802005fe:	00a68023          	sb	a0,0(a3)
    80200602:	bd71                	j	8020049e <out_rev_+0x1f4>
    80200604:	01043803          	ld	a6,16(s0)
    80200608:	02039893          	slli	a7,t2,0x20
    8020060c:	0208de93          	srli	t4,a7,0x20
    80200610:	01d80f33          	add	t5,a6,t4
    80200614:	017f0023          	sb	s7,0(t5)
    80200618:	b3a9                	j	80200362 <out_rev_+0xb8>
    8020061a:	6814                	ld	a3,16(s0)
    8020061c:	02039813          	slli	a6,t2,0x20
    80200620:	02085893          	srli	a7,a6,0x20
    80200624:	01168e33          	add	t3,a3,a7
    80200628:	017e0023          	sb	s7,0(t3)
    8020062c:	bb99                	j	80200382 <out_rev_+0xd8>
    8020062e:	01043283          	ld	t0,16(s0)
    80200632:	020b9713          	slli	a4,s7,0x20
    80200636:	02075313          	srli	t1,a4,0x20
    8020063a:	006283b3          	add	t2,t0,t1
    8020063e:	00a38023          	sb	a0,0(t2)
    80200642:	bbc5                	j	80200432 <out_rev_+0x188>
    80200644:	8e52                	mv	t3,s4
    80200646:	da061ce3          	bnez	a2,802003fe <out_rev_+0x154>
    8020064a:	bf21                	j	80200562 <out_rev_+0x2b8>
    8020064c:	01043283          	ld	t0,16(s0)
    80200650:	02009393          	slli	t2,ra,0x20
    80200654:	0203d593          	srli	a1,t2,0x20
    80200658:	00b28633          	add	a2,t0,a1
    8020065c:	01760023          	sb	s7,0(a2)
    80200660:	b3b5                	j	802003cc <out_rev_+0x122>
    80200662:	01043883          	ld	a7,16(s0)
    80200666:	02091e93          	slli	t4,s2,0x20
    8020066a:	020edf13          	srli	t5,t4,0x20
    8020066e:	01e88fb3          	add	t6,a7,t5
    80200672:	017f8023          	sb	s7,0(t6)
    80200676:	bb15                	j	802003aa <out_rev_+0x100>
    80200678:	01043083          	ld	ra,16(s0)
    8020067c:	020e1793          	slli	a5,t3,0x20
    80200680:	0207d293          	srli	t0,a5,0x20
    80200684:	00508733          	add	a4,ra,t0
    80200688:	00a70023          	sb	a0,0(a4)
    8020068c:	bbf1                	j	80200468 <out_rev_+0x1be>
    8020068e:	6908                	ld	a0,16(a0)
    80200690:	020a1593          	slli	a1,s4,0x20
    80200694:	0205d613          	srli	a2,a1,0x20
    80200698:	00c506b3          	add	a3,a0,a2
    8020069c:	01768023          	sb	s7,0(a3)
    802006a0:	b995                	j	80200314 <out_rev_+0x6a>
    802006a2:	6c02                	ld	s8,0(sp)
    802006a4:	bd7d                	j	80200562 <out_rev_+0x2b8>
    802006a6:	01043883          	ld	a7,16(s0)
    802006aa:	1e02                	slli	t3,t3,0x20
    802006ac:	020e5493          	srli	s1,t3,0x20
    802006b0:	00988eb3          	add	t4,a7,s1
    802006b4:	00ae8023          	sb	a0,0(t4)
    802006b8:	bddd                	j	802005ae <out_rev_+0x304>
    802006ba:	01043083          	ld	ra,16(s0)
    802006be:	02039793          	slli	a5,t2,0x20
    802006c2:	0207d713          	srli	a4,a5,0x20
    802006c6:	00e08c33          	add	s8,ra,a4
    802006ca:	017c0023          	sb	s7,0(s8)
    802006ce:	b9bd                	j	8020034c <out_rev_+0xa2>

00000000802006d0 <print_integer>:
    802006d0:	7179                	addi	sp,sp,-48
    802006d2:	f406                	sd	ra,40(sp)
    802006d4:	88b6                	mv	a7,a3
    802006d6:	82ba                	mv	t0,a4
    802006d8:	83b2                	mv	t2,a2
    802006da:	86be                	mv	a3,a5
    802006dc:	8742                	mv	a4,a6
    802006de:	18059b63          	bnez	a1,80200874 <print_integer+0x1a4>
    802006e2:	03481593          	slli	a1,a6,0x34
    802006e6:	3405cd63          	bltz	a1,80200a40 <print_integer+0x370>
    802006ea:	03000f93          	li	t6,48
    802006ee:	01f10023          	sb	t6,0(sp)
    802006f2:	fef87713          	andi	a4,a6,-17
    802006f6:	4f85                	li	t6,1
    802006f8:	858a                	mv	a1,sp
    802006fa:	00277e93          	andi	t4,a4,2
    802006fe:	8f3a                	mv	t5,a4
    80200700:	340e9963          	bnez	t4,80200a52 <print_integer+0x382>
    80200704:	34068763          	beqz	a3,80200a52 <print_integer+0x382>
    80200708:	001f7613          	andi	a2,t5,1
    8020070c:	34060363          	beqz	a2,80200a52 <print_integer+0x382>
    80200710:	5a039463          	bnez	t2,80200cb8 <print_integer+0x5e8>
    80200714:	00cf7793          	andi	a5,t5,12
    80200718:	5a079063          	bnez	a5,80200cb8 <print_integer+0x5e8>
    8020071c:	32dffb63          	bgeu	t6,a3,80200a52 <print_integer+0x382>
    80200720:	02000313          	li	t1,32
    80200724:	686f8563          	beq	t6,t1,80200dae <print_integer+0x6de>
    80200728:	ffffc613          	not	a2,t6
    8020072c:	00d6033b          	addw	t1,a2,a3
    80200730:	020f9e13          	slli	t3,t6,0x20
    80200734:	020e5813          	srli	a6,t3,0x20
    80200738:	00737093          	andi	ra,t1,7
    8020073c:	01058e33          	add	t3,a1,a6
    80200740:	867e                	mv	a2,t6
    80200742:	03000f13          	li	t5,48
    80200746:	02000793          	li	a5,32
    8020074a:	06008f63          	beqz	ra,802007c8 <print_integer+0xf8>
    8020074e:	01ee0023          	sb	t5,0(t3)
    80200752:	001f861b          	addiw	a2,t6,1
    80200756:	0e05                	addi	t3,t3,1
    80200758:	0cf60363          	beq	a2,a5,8020081e <print_integer+0x14e>
    8020075c:	4e85                	li	t4,1
    8020075e:	07d08563          	beq	ra,t4,802007c8 <print_integer+0xf8>
    80200762:	4309                	li	t1,2
    80200764:	04608c63          	beq	ra,t1,802007bc <print_integer+0xec>
    80200768:	480d                	li	a6,3
    8020076a:	05008363          	beq	ra,a6,802007b0 <print_integer+0xe0>
    8020076e:	4e91                	li	t4,4
    80200770:	03d08a63          	beq	ra,t4,802007a4 <print_integer+0xd4>
    80200774:	4315                	li	t1,5
    80200776:	02608163          	beq	ra,t1,80200798 <print_integer+0xc8>
    8020077a:	4819                	li	a6,6
    8020077c:	01008863          	beq	ra,a6,8020078c <print_integer+0xbc>
    80200780:	01ee0023          	sb	t5,0(t3)
    80200784:	2605                	addiw	a2,a2,1
    80200786:	0e05                	addi	t3,t3,1
    80200788:	08f60b63          	beq	a2,a5,8020081e <print_integer+0x14e>
    8020078c:	01ee0023          	sb	t5,0(t3)
    80200790:	2605                	addiw	a2,a2,1
    80200792:	0e05                	addi	t3,t3,1
    80200794:	08f60563          	beq	a2,a5,8020081e <print_integer+0x14e>
    80200798:	01ee0023          	sb	t5,0(t3)
    8020079c:	2605                	addiw	a2,a2,1
    8020079e:	0e05                	addi	t3,t3,1
    802007a0:	06f60f63          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007a4:	01ee0023          	sb	t5,0(t3)
    802007a8:	2605                	addiw	a2,a2,1
    802007aa:	0e05                	addi	t3,t3,1
    802007ac:	06f60963          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007b0:	01ee0023          	sb	t5,0(t3)
    802007b4:	2605                	addiw	a2,a2,1
    802007b6:	0e05                	addi	t3,t3,1
    802007b8:	06f60363          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007bc:	01ee0023          	sb	t5,0(t3)
    802007c0:	2605                	addiw	a2,a2,1
    802007c2:	0e05                	addi	t3,t3,1
    802007c4:	04f60d63          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007c8:	01ee0023          	sb	t5,0(t3)
    802007cc:	2605                	addiw	a2,a2,1
    802007ce:	28d60363          	beq	a2,a3,80200a54 <print_integer+0x384>
    802007d2:	04f60663          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007d6:	01ee00a3          	sb	t5,1(t3)
    802007da:	2605                	addiw	a2,a2,1
    802007dc:	04f60163          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007e0:	01ee0123          	sb	t5,2(t3)
    802007e4:	2605                	addiw	a2,a2,1
    802007e6:	02f60c63          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007ea:	01ee01a3          	sb	t5,3(t3)
    802007ee:	2605                	addiw	a2,a2,1
    802007f0:	02f60763          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007f4:	01ee0223          	sb	t5,4(t3)
    802007f8:	2605                	addiw	a2,a2,1
    802007fa:	02f60263          	beq	a2,a5,8020081e <print_integer+0x14e>
    802007fe:	01ee02a3          	sb	t5,5(t3)
    80200802:	2605                	addiw	a2,a2,1
    80200804:	00f60d63          	beq	a2,a5,8020081e <print_integer+0x14e>
    80200808:	01ee0323          	sb	t5,6(t3)
    8020080c:	2605                	addiw	a2,a2,1
    8020080e:	00f60863          	beq	a2,a5,8020081e <print_integer+0x14e>
    80200812:	01ee03a3          	sb	t5,7(t3)
    80200816:	2605                	addiw	a2,a2,1
    80200818:	0e21                	addi	t3,t3,8
    8020081a:	faf617e3          	bne	a2,a5,802007c8 <print_integer+0xf8>
    8020081e:	38566763          	bltu	a2,t0,80200bac <print_integer+0x4dc>
    80200822:	40a1                	li	ra,8
    80200824:	32189963          	bne	a7,ra,80200b56 <print_integer+0x486>
    80200828:	fef77313          	andi	t1,a4,-17
    8020082c:	03271813          	slli	a6,a4,0x32
    80200830:	00030e1b          	sext.w	t3,t1
    80200834:	4a085963          	bgez	a6,80200ce6 <print_integer+0x616>
    80200838:	1752                	slli	a4,a4,0x34
    8020083a:	4a075863          	bgez	a4,80200cea <print_integer+0x61a>
    8020083e:	8772                	mv	a4,t3
    80200840:	02000f93          	li	t6,32
    80200844:	03f60363          	beq	a2,t6,8020086a <print_integer+0x19a>
    80200848:	02061793          	slli	a5,a2,0x20
    8020084c:	0207de93          	srli	t4,a5,0x20
    80200850:	2605                	addiw	a2,a2,1
    80200852:	020e8e13          	addi	t3,t4,32
    80200856:	002e0fb3          	add	t6,t3,sp
    8020085a:	03000793          	li	a5,48
    8020085e:	feff8023          	sb	a5,-32(t6)
    80200862:	02000293          	li	t0,32
    80200866:	30561f63          	bne	a2,t0,80200b84 <print_integer+0x4b4>
    8020086a:	a41ff0ef          	jal	802002aa <out_rev_>
    8020086e:	70a2                	ld	ra,40(sp)
    80200870:	6145                	addi	sp,sp,48
    80200872:	8082                	ret
    80200874:	4058579b          	sraiw	a5,a6,0x5
    80200878:	0017f093          	andi	ra,a5,1
    8020087c:	8e2e                	mv	t3,a1
    8020087e:	06100f13          	li	t5,97
    80200882:	1a009163          	bnez	ra,80200a24 <print_integer+0x354>
    80200886:	031e7633          	remu	a2,t3,a7
    8020088a:	858a                	mv	a1,sp
    8020088c:	4825                	li	a6,9
    8020088e:	832e                	mv	t1,a1
    80200890:	ff6f009b          	addiw	ra,t5,-10
    80200894:	0ff67e93          	zext.b	t4,a2
    80200898:	18c87163          	bgeu	a6,a2,80200a1a <print_integer+0x34a>
    8020089c:	01d08fbb          	addw	t6,ra,t4
    802008a0:	0fffff13          	zext.b	t5,t6
    802008a4:	01e58023          	sb	t5,0(a1)
    802008a8:	031e5633          	divu	a2,t3,a7
    802008ac:	391e6063          	bltu	t3,a7,80200c2c <print_integer+0x55c>
    802008b0:	00158313          	addi	t1,a1,1
    802008b4:	8e9a                	mv	t4,t1
    802008b6:	03167e33          	remu	t3,a2,a7
    802008ba:	0ffe7f93          	zext.b	t6,t3
    802008be:	39c87c63          	bgeu	a6,t3,80200c56 <print_integer+0x586>
    802008c2:	01f087bb          	addw	a5,ra,t6
    802008c6:	0ff7fe13          	zext.b	t3,a5
    802008ca:	01ce8023          	sb	t3,0(t4)
    802008ce:	03165fb3          	divu	t6,a2,a7
    802008d2:	35166d63          	bltu	a2,a7,80200c2c <print_integer+0x55c>
    802008d6:	001e8313          	addi	t1,t4,1
    802008da:	031ff633          	remu	a2,t6,a7
    802008de:	0ff67793          	zext.b	a5,a2
    802008e2:	36c87f63          	bgeu	a6,a2,80200c60 <print_integer+0x590>
    802008e6:	00f08f3b          	addw	t5,ra,a5
    802008ea:	0fff7613          	zext.b	a2,t5
    802008ee:	00c30023          	sb	a2,0(t1)
    802008f2:	031fde33          	divu	t3,t6,a7
    802008f6:	331feb63          	bltu	t6,a7,80200c2c <print_integer+0x55c>
    802008fa:	002e8313          	addi	t1,t4,2
    802008fe:	031e7eb3          	remu	t4,t3,a7
    80200902:	0ffeff93          	zext.b	t6,t4
    80200906:	11d86563          	bltu	a6,t4,80200a10 <print_integer+0x340>
    8020090a:	030f861b          	addiw	a2,t6,48
    8020090e:	0ff67f13          	zext.b	t5,a2
    80200912:	01e30023          	sb	t5,0(t1)
    80200916:	031e5fb3          	divu	t6,t3,a7
    8020091a:	311e6963          	bltu	t3,a7,80200c2c <print_integer+0x55c>
    8020091e:	0305                	addi	t1,t1,1
    80200920:	02010e93          	addi	t4,sp,32
    80200924:	8e1a                	mv	t3,t1
    80200926:	386e8b63          	beq	t4,t1,80200cbc <print_integer+0x5ec>
    8020092a:	031fff33          	remu	t5,t6,a7
    8020092e:	0fff7793          	zext.b	a5,t5
    80200932:	2de86963          	bltu	a6,t5,80200c04 <print_integer+0x534>
    80200936:	03078e9b          	addiw	t4,a5,48
    8020093a:	0ffeff13          	zext.b	t5,t4
    8020093e:	01ee0023          	sb	t5,0(t3)
    80200942:	031fdeb3          	divu	t4,t6,a7
    80200946:	2f1fe363          	bltu	t6,a7,80200c2c <print_integer+0x55c>
    8020094a:	001e0313          	addi	t1,t3,1
    8020094e:	031effb3          	remu	t6,t4,a7
    80200952:	0ffff793          	zext.b	a5,t6
    80200956:	2bf87c63          	bgeu	a6,t6,80200c0e <print_integer+0x53e>
    8020095a:	00f0863b          	addw	a2,ra,a5
    8020095e:	0ff67f93          	zext.b	t6,a2
    80200962:	01fe00a3          	sb	t6,1(t3)
    80200966:	031ed633          	divu	a2,t4,a7
    8020096a:	2d1ee163          	bltu	t4,a7,80200c2c <print_integer+0x55c>
    8020096e:	002e0313          	addi	t1,t3,2
    80200972:	03167eb3          	remu	t4,a2,a7
    80200976:	0ffef793          	zext.b	a5,t4
    8020097a:	29d87f63          	bgeu	a6,t4,80200c18 <print_integer+0x548>
    8020097e:	00f08f3b          	addw	t5,ra,a5
    80200982:	0fff7e93          	zext.b	t4,t5
    80200986:	01de0123          	sb	t4,2(t3)
    8020098a:	03165f33          	divu	t5,a2,a7
    8020098e:	29166f63          	bltu	a2,a7,80200c2c <print_integer+0x55c>
    80200992:	003e0313          	addi	t1,t3,3
    80200996:	031f7633          	remu	a2,t5,a7
    8020099a:	0ff67793          	zext.b	a5,a2
    8020099e:	28c87263          	bgeu	a6,a2,80200c22 <print_integer+0x552>
    802009a2:	00f08fbb          	addw	t6,ra,a5
    802009a6:	0ffff613          	zext.b	a2,t6
    802009aa:	00ce01a3          	sb	a2,3(t3)
    802009ae:	031f5633          	divu	a2,t5,a7
    802009b2:	271f6d63          	bltu	t5,a7,80200c2c <print_integer+0x55c>
    802009b6:	004e0313          	addi	t1,t3,4
    802009ba:	03167f33          	remu	t5,a2,a7
    802009be:	0fff7793          	zext.b	a5,t5
    802009c2:	27e87a63          	bgeu	a6,t5,80200c36 <print_integer+0x566>
    802009c6:	00f08fbb          	addw	t6,ra,a5
    802009ca:	0fffff13          	zext.b	t5,t6
    802009ce:	01ee0223          	sb	t5,4(t3)
    802009d2:	03165fb3          	divu	t6,a2,a7
    802009d6:	25166b63          	bltu	a2,a7,80200c2c <print_integer+0x55c>
    802009da:	005e0313          	addi	t1,t3,5
    802009de:	031ff633          	remu	a2,t6,a7
    802009e2:	0ff67793          	zext.b	a5,a2
    802009e6:	24c87d63          	bgeu	a6,a2,80200c40 <print_integer+0x570>
    802009ea:	00f08ebb          	addw	t4,ra,a5
    802009ee:	0ffef613          	zext.b	a2,t4
    802009f2:	00ce02a3          	sb	a2,5(t3)
    802009f6:	031fd7b3          	divu	a5,t6,a7
    802009fa:	231fe963          	bltu	t6,a7,80200c2c <print_integer+0x55c>
    802009fe:	006e0313          	addi	t1,t3,6
    80200a02:	8e3e                	mv	t3,a5
    80200a04:	031e7eb3          	remu	t4,t3,a7
    80200a08:	0ffeff93          	zext.b	t6,t4
    80200a0c:	efd87fe3          	bgeu	a6,t4,8020090a <print_integer+0x23a>
    80200a10:	01f087bb          	addw	a5,ra,t6
    80200a14:	0ff7ff13          	zext.b	t5,a5
    80200a18:	bded                	j	80200912 <print_integer+0x242>
    80200a1a:	030e879b          	addiw	a5,t4,48
    80200a1e:	0ff7ff13          	zext.b	t5,a5
    80200a22:	b549                	j	802008a4 <print_integer+0x1d4>
    80200a24:	031e7633          	remu	a2,t3,a7
    80200a28:	04100f13          	li	t5,65
    80200a2c:	858a                	mv	a1,sp
    80200a2e:	4825                	li	a6,9
    80200a30:	832e                	mv	t1,a1
    80200a32:	ff6f009b          	addiw	ra,t5,-10
    80200a36:	0ff67e93          	zext.b	t4,a2
    80200a3a:	e6c861e3          	bltu	a6,a2,8020089c <print_integer+0x1cc>
    80200a3e:	bff1                	j	80200a1a <print_integer+0x34a>
    80200a40:	40c1                	li	ra,16
    80200a42:	4f81                	li	t6,0
    80200a44:	858a                	mv	a1,sp
    80200a46:	ca189ae3          	bne	a7,ra,802006fa <print_integer+0x2a>
    80200a4a:	fef87713          	andi	a4,a6,-17
    80200a4e:	2701                	sext.w	a4,a4
    80200a50:	b16d                	j	802006fa <print_integer+0x2a>
    80200a52:	867e                	mv	a2,t6
    80200a54:	0e567e63          	bgeu	a2,t0,80200b50 <print_integer+0x480>
    80200a58:	02000e13          	li	t3,32
    80200a5c:	1fc60763          	beq	a2,t3,80200c4a <print_integer+0x57a>
    80200a60:	40560f33          	sub	t5,a2,t0
    80200a64:	ffff4793          	not	a5,t5
    80200a68:	02061e93          	slli	t4,a2,0x20
    80200a6c:	020ed313          	srli	t1,t4,0x20
    80200a70:	0077f813          	andi	a6,a5,7
    80200a74:	932e                	add	t1,t1,a1
    80200a76:	03000e13          	li	t3,48
    80200a7a:	02000093          	li	ra,32
    80200a7e:	06080e63          	beqz	a6,80200afa <print_integer+0x42a>
    80200a82:	01c30023          	sb	t3,0(t1)
    80200a86:	2605                	addiw	a2,a2,1
    80200a88:	0305                	addi	t1,t1,1
    80200a8a:	0c160363          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200a8e:	4f05                	li	t5,1
    80200a90:	07e80563          	beq	a6,t5,80200afa <print_integer+0x42a>
    80200a94:	4789                	li	a5,2
    80200a96:	04f80c63          	beq	a6,a5,80200aee <print_integer+0x41e>
    80200a9a:	4e8d                	li	t4,3
    80200a9c:	05d80363          	beq	a6,t4,80200ae2 <print_integer+0x412>
    80200aa0:	4f11                	li	t5,4
    80200aa2:	03e80a63          	beq	a6,t5,80200ad6 <print_integer+0x406>
    80200aa6:	4795                	li	a5,5
    80200aa8:	02f80163          	beq	a6,a5,80200aca <print_integer+0x3fa>
    80200aac:	4e99                	li	t4,6
    80200aae:	01d80863          	beq	a6,t4,80200abe <print_integer+0x3ee>
    80200ab2:	01c30023          	sb	t3,0(t1)
    80200ab6:	2605                	addiw	a2,a2,1
    80200ab8:	0305                	addi	t1,t1,1
    80200aba:	08160b63          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200abe:	01c30023          	sb	t3,0(t1)
    80200ac2:	2605                	addiw	a2,a2,1
    80200ac4:	0305                	addi	t1,t1,1
    80200ac6:	08160563          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200aca:	01c30023          	sb	t3,0(t1)
    80200ace:	2605                	addiw	a2,a2,1
    80200ad0:	0305                	addi	t1,t1,1
    80200ad2:	06160f63          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200ad6:	01c30023          	sb	t3,0(t1)
    80200ada:	2605                	addiw	a2,a2,1
    80200adc:	0305                	addi	t1,t1,1
    80200ade:	06160963          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200ae2:	01c30023          	sb	t3,0(t1)
    80200ae6:	2605                	addiw	a2,a2,1
    80200ae8:	0305                	addi	t1,t1,1
    80200aea:	06160363          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200aee:	01c30023          	sb	t3,0(t1)
    80200af2:	2605                	addiw	a2,a2,1
    80200af4:	0305                	addi	t1,t1,1
    80200af6:	04160d63          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200afa:	01c30023          	sb	t3,0(t1)
    80200afe:	2605                	addiw	a2,a2,1
    80200b00:	04c28863          	beq	t0,a2,80200b50 <print_integer+0x480>
    80200b04:	04160663          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b08:	01c300a3          	sb	t3,1(t1)
    80200b0c:	2605                	addiw	a2,a2,1
    80200b0e:	04160163          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b12:	01c30123          	sb	t3,2(t1)
    80200b16:	2605                	addiw	a2,a2,1
    80200b18:	02160c63          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b1c:	01c301a3          	sb	t3,3(t1)
    80200b20:	2605                	addiw	a2,a2,1
    80200b22:	02160763          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b26:	01c30223          	sb	t3,4(t1)
    80200b2a:	2605                	addiw	a2,a2,1
    80200b2c:	02160263          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b30:	01c302a3          	sb	t3,5(t1)
    80200b34:	2605                	addiw	a2,a2,1
    80200b36:	00160d63          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b3a:	01c30323          	sb	t3,6(t1)
    80200b3e:	2605                	addiw	a2,a2,1
    80200b40:	00160863          	beq	a2,ra,80200b50 <print_integer+0x480>
    80200b44:	01c303a3          	sb	t3,7(t1)
    80200b48:	2605                	addiw	a2,a2,1
    80200b4a:	0321                	addi	t1,t1,8
    80200b4c:	fa1617e3          	bne	a2,ra,80200afa <print_integer+0x42a>
    80200b50:	4821                	li	a6,8
    80200b52:	0f088f63          	beq	a7,a6,80200c50 <print_integer+0x580>
    80200b56:	00475793          	srli	a5,a4,0x4
    80200b5a:	2017fe93          	andi	t4,a5,513
    80200b5e:	8f3a                	mv	t5,a4
    80200b60:	d00e81e3          	beqz	t4,80200862 <print_integer+0x192>
    80200b64:	03471313          	slli	t1,a4,0x34
    80200b68:	06034563          	bltz	t1,80200bd2 <print_integer+0x502>
    80200b6c:	ee39                	bnez	a2,80200bca <print_integer+0x4fa>
    80200b6e:	4fc1                	li	t6,16
    80200b70:	1ff88863          	beq	a7,t6,80200d60 <print_integer+0x690>
    80200b74:	4609                	li	a2,2
    80200b76:	20c88763          	beq	a7,a2,80200d84 <print_integer+0x6b4>
    80200b7a:	03000613          	li	a2,48
    80200b7e:	00c10023          	sb	a2,0(sp)
    80200b82:	4605                	li	a2,1
    80200b84:	0e039363          	bnez	t2,80200c6a <print_integer+0x59a>
    80200b88:	00477393          	andi	t2,a4,4
    80200b8c:	12038b63          	beqz	t2,80200cc2 <print_integer+0x5f2>
    80200b90:	02061e13          	slli	t3,a2,0x20
    80200b94:	020e5f93          	srli	t6,t3,0x20
    80200b98:	020f8793          	addi	a5,t6,32
    80200b9c:	002782b3          	add	t0,a5,sp
    80200ba0:	02b00393          	li	t2,43
    80200ba4:	fe728023          	sb	t2,-32(t0)
    80200ba8:	2605                	addiw	a2,a2,1
    80200baa:	b1c1                	j	8020086a <print_integer+0x19a>
    80200bac:	40a1                	li	ra,8
    80200bae:	c6188de3          	beq	a7,ra,80200828 <print_integer+0x158>
    80200bb2:	00475f13          	srli	t5,a4,0x4
    80200bb6:	201f7793          	andi	a5,t5,513
    80200bba:	02000613          	li	a2,32
    80200bbe:	ca0786e3          	beqz	a5,8020086a <print_integer+0x19a>
    80200bc2:	03471e93          	slli	t4,a4,0x34
    80200bc6:	000ec663          	bltz	t4,80200bd2 <print_integer+0x502>
    80200bca:	12c28563          	beq	t0,a2,80200cf4 <print_integer+0x624>
    80200bce:	12c68363          	beq	a3,a2,80200cf4 <print_integer+0x624>
    80200bd2:	42c1                	li	t0,16
    80200bd4:	0a588d63          	beq	a7,t0,80200c8e <print_integer+0x5be>
    80200bd8:	4089                	li	ra,2
    80200bda:	c61893e3          	bne	a7,ra,80200840 <print_integer+0x170>
    80200bde:	02000f13          	li	t5,32
    80200be2:	c9e604e3          	beq	a2,t5,8020086a <print_integer+0x19a>
    80200be6:	82b2                	mv	t0,a2
    80200be8:	2605                	addiw	a2,a2,1
    80200bea:	02029893          	slli	a7,t0,0x20
    80200bee:	0208df93          	srli	t6,a7,0x20
    80200bf2:	020f8293          	addi	t0,t6,32
    80200bf6:	002287b3          	add	a5,t0,sp
    80200bfa:	06200e93          	li	t4,98
    80200bfe:	ffd78023          	sb	t4,-32(a5)
    80200c02:	b93d                	j	80200840 <print_integer+0x170>
    80200c04:	00f0863b          	addw	a2,ra,a5
    80200c08:	0ff67f13          	zext.b	t5,a2
    80200c0c:	bb0d                	j	8020093e <print_integer+0x26e>
    80200c0e:	03078f1b          	addiw	t5,a5,48
    80200c12:	0fff7f93          	zext.b	t6,t5
    80200c16:	b3b1                	j	80200962 <print_integer+0x292>
    80200c18:	03078f9b          	addiw	t6,a5,48
    80200c1c:	0ffffe93          	zext.b	t4,t6
    80200c20:	b39d                	j	80200986 <print_integer+0x2b6>
    80200c22:	03078e9b          	addiw	t4,a5,48
    80200c26:	0ffef613          	zext.b	a2,t4
    80200c2a:	b341                	j	802009aa <print_integer+0x2da>
    80200c2c:	40b3033b          	subw	t1,t1,a1
    80200c30:	00130f9b          	addiw	t6,t1,1
    80200c34:	b4d9                	j	802006fa <print_integer+0x2a>
    80200c36:	03078e9b          	addiw	t4,a5,48
    80200c3a:	0ffeff13          	zext.b	t5,t4
    80200c3e:	bb41                	j	802009ce <print_integer+0x2fe>
    80200c40:	03078f1b          	addiw	t5,a5,48
    80200c44:	0fff7613          	zext.b	a2,t5
    80200c48:	b36d                	j	802009f2 <print_integer+0x322>
    80200c4a:	40a1                	li	ra,8
    80200c4c:	f61893e3          	bne	a7,ra,80200bb2 <print_integer+0x4e2>
    80200c50:	f0cff3e3          	bgeu	t6,a2,80200b56 <print_integer+0x486>
    80200c54:	bed1                	j	80200828 <print_integer+0x158>
    80200c56:	030f8f1b          	addiw	t5,t6,48
    80200c5a:	0fff7e13          	zext.b	t3,t5
    80200c5e:	b1b5                	j	802008ca <print_integer+0x1fa>
    80200c60:	03078e1b          	addiw	t3,a5,48
    80200c64:	0ffe7613          	zext.b	a2,t3
    80200c68:	b159                	j	802008ee <print_integer+0x21e>
    80200c6a:	02061e93          	slli	t4,a2,0x20
    80200c6e:	020ed313          	srli	t1,t4,0x20
    80200c72:	02030813          	addi	a6,t1,32
    80200c76:	002800b3          	add	ra,a6,sp
    80200c7a:	02d00f13          	li	t5,45
    80200c7e:	ffe08023          	sb	t5,-32(ra)
    80200c82:	2605                	addiw	a2,a2,1
    80200c84:	e26ff0ef          	jal	802002aa <out_rev_>
    80200c88:	70a2                	ld	ra,40(sp)
    80200c8a:	6145                	addi	sp,sp,48
    80200c8c:	8082                	ret
    80200c8e:	02077793          	andi	a5,a4,32
    80200c92:	c3dd                	beqz	a5,80200d38 <print_integer+0x668>
    80200c94:	02000e93          	li	t4,32
    80200c98:	bdd609e3          	beq	a2,t4,8020086a <print_integer+0x19a>
    80200c9c:	02061e13          	slli	t3,a2,0x20
    80200ca0:	020e5813          	srli	a6,t3,0x20
    80200ca4:	02080093          	addi	ra,a6,32
    80200ca8:	00208f33          	add	t5,ra,sp
    80200cac:	05800893          	li	a7,88
    80200cb0:	ff1f0023          	sb	a7,-32(t5)
    80200cb4:	2605                	addiw	a2,a2,1
    80200cb6:	b669                	j	80200840 <print_integer+0x170>
    80200cb8:	36fd                	addiw	a3,a3,-1
    80200cba:	b48d                	j	8020071c <print_integer+0x4c>
    80200cbc:	02000f93          	li	t6,32
    80200cc0:	bc2d                	j	802006fa <print_integer+0x2a>
    80200cc2:	00877e93          	andi	t4,a4,8
    80200cc6:	ba0e82e3          	beqz	t4,8020086a <print_integer+0x19a>
    80200cca:	02061313          	slli	t1,a2,0x20
    80200cce:	02035813          	srli	a6,t1,0x20
    80200cd2:	02080093          	addi	ra,a6,32
    80200cd6:	00208f33          	add	t5,ra,sp
    80200cda:	02000893          	li	a7,32
    80200cde:	ff1f0023          	sb	a7,-32(t5)
    80200ce2:	2605                	addiw	a2,a2,1
    80200ce4:	b659                	j	8020086a <print_integer+0x19a>
    80200ce6:	8772                	mv	a4,t3
    80200ce8:	bead                	j	80200862 <print_integer+0x192>
    80200cea:	0ec28863          	beq	t0,a2,80200dda <print_integer+0x70a>
    80200cee:	b4c698e3          	bne	a3,a2,8020083e <print_integer+0x16e>
    80200cf2:	8772                	mv	a4,t3
    80200cf4:	eccfffe3          	bgeu	t6,a2,80200bd2 <print_integer+0x502>
    80200cf8:	fff60e1b          	addiw	t3,a2,-1
    80200cfc:	000e029b          	sext.w	t0,t3
    80200d00:	08028563          	beqz	t0,80200d8a <print_integer+0x6ba>
    80200d04:	40c1                	li	ra,16
    80200d06:	10189a63          	bne	a7,ra,80200e1a <print_integer+0x74a>
    80200d0a:	165ff663          	bgeu	t6,t0,80200e76 <print_integer+0x7a6>
    80200d0e:	ffe6031b          	addiw	t1,a2,-2
    80200d12:	02031293          	slli	t0,t1,0x20
    80200d16:	0202d813          	srli	a6,t0,0x20
    80200d1a:	02077093          	andi	ra,a4,32
    80200d1e:	01058f33          	add	t5,a1,a6
    80200d22:	12009163          	bnez	ra,80200e44 <print_integer+0x774>
    80200d26:	07800f93          	li	t6,120
    80200d2a:	020e1793          	slli	a5,t3,0x20
    80200d2e:	01ff0023          	sb	t6,0(t5)
    80200d32:	0207de93          	srli	t4,a5,0x20
    80200d36:	be31                	j	80200852 <print_integer+0x182>
    80200d38:	02000313          	li	t1,32
    80200d3c:	b26607e3          	beq	a2,t1,8020086a <print_integer+0x19a>
    80200d40:	82b2                	mv	t0,a2
    80200d42:	02029f93          	slli	t6,t0,0x20
    80200d46:	020fd793          	srli	a5,t6,0x20
    80200d4a:	02078e93          	addi	t4,a5,32
    80200d4e:	002e8333          	add	t1,t4,sp
    80200d52:	0012861b          	addiw	a2,t0,1
    80200d56:	07800293          	li	t0,120
    80200d5a:	fe530023          	sb	t0,-32(t1)
    80200d5e:	b4cd                	j	80200840 <print_integer+0x170>
    80200d60:	020f7813          	andi	a6,t5,32
    80200d64:	05800893          	li	a7,88
    80200d68:	00081463          	bnez	a6,80200d70 <print_integer+0x6a0>
    80200d6c:	07800893          	li	a7,120
    80200d70:	03000e13          	li	t3,48
    80200d74:	01110023          	sb	a7,0(sp)
    80200d78:	01c100a3          	sb	t3,1(sp)
    80200d7c:	4609                	li	a2,2
    80200d7e:	e00385e3          	beqz	t2,80200b88 <print_integer+0x4b8>
    80200d82:	b5e5                	j	80200c6a <print_integer+0x59a>
    80200d84:	06200893          	li	a7,98
    80200d88:	b7e5                	j	80200d70 <print_integer+0x6a0>
    80200d8a:	4641                	li	a2,16
    80200d8c:	06c88063          	beq	a7,a2,80200dec <print_integer+0x71c>
    80200d90:	4809                	li	a6,2
    80200d92:	df0894e3          	bne	a7,a6,80200b7a <print_integer+0x4aa>
    80200d96:	06200313          	li	t1,98
    80200d9a:	03000813          	li	a6,48
    80200d9e:	00610023          	sb	t1,0(sp)
    80200da2:	010100a3          	sb	a6,1(sp)
    80200da6:	4609                	li	a2,2
    80200da8:	de0380e3          	beqz	t2,80200b88 <print_integer+0x4b8>
    80200dac:	bd7d                	j	80200c6a <print_integer+0x59a>
    80200dae:	0a5ff363          	bgeu	t6,t0,80200e54 <print_integer+0x784>
    80200db2:	4ea1                	li	t4,8
    80200db4:	dfd89fe3          	bne	a7,t4,80200bb2 <print_integer+0x4e2>
    80200db8:	00475293          	srli	t0,a4,0x4
    80200dbc:	2012ff13          	andi	t5,t0,513
    80200dc0:	02000613          	li	a2,32
    80200dc4:	aa0f03e3          	beqz	t5,8020086a <print_integer+0x19a>
    80200dc8:	03471793          	slli	a5,a4,0x34
    80200dcc:	02000613          	li	a2,32
    80200dd0:	a607c8e3          	bltz	a5,80200840 <print_integer+0x170>
    80200dd4:	dec69fe3          	bne	a3,a2,80200bd2 <print_integer+0x502>
    80200dd8:	bf31                	j	80200cf4 <print_integer+0x624>
    80200dda:	32fd                	addiw	t0,t0,-1
    80200ddc:	02029663          	bnez	t0,80200e08 <print_integer+0x738>
    80200de0:	4741                	li	a4,16
    80200de2:	00e88463          	beq	a7,a4,80200dea <print_integer+0x71a>
    80200de6:	8772                	mv	a4,t3
    80200de8:	bb49                	j	80200b7a <print_integer+0x4aa>
    80200dea:	8772                	mv	a4,t3
    80200dec:	02077e93          	andi	t4,a4,32
    80200df0:	020e9263          	bnez	t4,80200e14 <print_integer+0x744>
    80200df4:	608d                	lui	ra,0x3
    80200df6:	07808f13          	addi	t5,ra,120 # 3078 <__stack_size-0xcf88>
    80200dfa:	01e11023          	sh	t5,0(sp)
    80200dfe:	4609                	li	a2,2
    80200e00:	d80384e3          	beqz	t2,80200b88 <print_integer+0x4b8>
    80200e04:	b59d                	j	80200c6a <print_integer+0x59a>
    80200e06:	8e3a                	mv	t3,a4
    80200e08:	02029893          	slli	a7,t0,0x20
    80200e0c:	0208de93          	srli	t4,a7,0x20
    80200e10:	8772                	mv	a4,t3
    80200e12:	b481                	j	80200852 <print_integer+0x182>
    80200e14:	05800313          	li	t1,88
    80200e18:	b749                	j	80200d9a <print_integer+0x6ca>
    80200e1a:	4f09                	li	t5,2
    80200e1c:	ffe895e3          	bne	a7,t5,80200e06 <print_integer+0x736>
    80200e20:	dc5ff5e3          	bgeu	t6,t0,80200bea <print_integer+0x51a>
    80200e24:	ffe6031b          	addiw	t1,a2,-2
    80200e28:	02031e13          	slli	t3,t1,0x20
    80200e2c:	020e5613          	srli	a2,t3,0x20
    80200e30:	02060813          	addi	a6,a2,32
    80200e34:	002800b3          	add	ra,a6,sp
    80200e38:	06200f13          	li	t5,98
    80200e3c:	ffe08023          	sb	t5,-32(ra)
    80200e40:	8616                	mv	a2,t0
    80200e42:	b419                	j	80200848 <print_integer+0x178>
    80200e44:	05800893          	li	a7,88
    80200e48:	1e02                	slli	t3,t3,0x20
    80200e4a:	011f0023          	sb	a7,0(t5)
    80200e4e:	020e5e93          	srli	t4,t3,0x20
    80200e52:	b401                	j	80200852 <print_integer+0x182>
    80200e54:	00475e13          	srli	t3,a4,0x4
    80200e58:	201e7813          	andi	a6,t3,513
    80200e5c:	02000613          	li	a2,32
    80200e60:	a00805e3          	beqz	a6,8020086a <print_integer+0x19a>
    80200e64:	03471093          	slli	ra,a4,0x34
    80200e68:	d600c5e3          	bltz	ra,80200bd2 <print_integer+0x502>
    80200e6c:	d7f283e3          	beq	t0,t6,80200bd2 <print_integer+0x502>
    80200e70:	d6c691e3          	bne	a3,a2,80200bd2 <print_integer+0x502>
    80200e74:	b541                	j	80200cf4 <print_integer+0x624>
    80200e76:	02077893          	andi	a7,a4,32
    80200e7a:	8616                	mv	a2,t0
    80200e7c:	e20890e3          	bnez	a7,80200c9c <print_integer+0x5cc>
    80200e80:	b5c9                	j	80200d42 <print_integer+0x672>

0000000080200e82 <format_string_loop.constprop.0>:
    80200e82:	0005ce03          	lbu	t3,0(a1)
    80200e86:	1e0e0de3          	beqz	t3,80201880 <format_string_loop.constprop.0+0x9fe>
    80200e8a:	7175                	addi	sp,sp,-144
    80200e8c:	00121737          	lui	a4,0x121
    80200e90:	6689                	lui	a3,0x2
    80200e92:	e506                	sd	ra,136(sp)
    80200e94:	f4ce                	sd	s3,104(sp)
    80200e96:	82170093          	addi	ra,a4,-2015 # 120821 <__stack_size+0x110821>
    80200e9a:	6985                	lui	s3,0x1
    80200e9c:	00168293          	addi	t0,a3,1 # 2001 <__stack_size-0xdfff>
    80200ea0:	fca6                	sd	s1,120(sp)
    80200ea2:	f8ca                	sd	s2,112(sp)
    80200ea4:	e8da                	sd	s6,80(sp)
    80200ea6:	e4de                	sd	s7,72(sp)
    80200ea8:	e0e2                	sd	s8,64(sp)
    80200eaa:	e122                	sd	s0,128(sp)
    80200eac:	f0d2                	sd	s4,96(sp)
    80200eae:	ecd6                	sd	s5,88(sp)
    80200eb0:	fc66                	sd	s9,56(sp)
    80200eb2:	f86a                	sd	s10,48(sp)
    80200eb4:	f46e                	sd	s11,40(sp)
    80200eb6:	8b2a                	mv	s6,a0
    80200eb8:	8c32                	mv	s8,a2
    80200eba:	02500493          	li	s1,37
    80200ebe:	00001b97          	auipc	s7,0x1
    80200ec2:	20ab8b93          	addi	s7,s7,522 # 802020c8 <imsic_init+0x234>
    80200ec6:	80098993          	addi	s3,s3,-2048 # 800 <__stack_size-0xf800>
    80200eca:	e006                	sd	ra,0(sp)
    80200ecc:	e416                	sd	t0,8(sp)
    80200ece:	00001917          	auipc	s2,0x1
    80200ed2:	23e90913          	addi	s2,s2,574 # 8020210c <imsic_init+0x278>
    80200ed6:	00158413          	addi	s0,a1,1
    80200eda:	169e1063          	bne	t3,s1,8020103a <format_string_loop.constprop.0+0x1b8>
    80200ede:	0015c503          	lbu	a0,1(a1)
    80200ee2:	c56d                	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    80200ee4:	4801                	li	a6,0
    80200ee6:	4ac1                	li	s5,16
    80200ee8:	fe05079b          	addiw	a5,a0,-32
    80200eec:	0ff7f313          	zext.b	t1,a5
    80200ef0:	00140593          	addi	a1,s0,1
    80200ef4:	006aeb63          	bltu	s5,t1,80200f0a <format_string_loop.constprop.0+0x88>
    80200ef8:	00231393          	slli	t2,t1,0x2
    80200efc:	01738633          	add	a2,t2,s7
    80200f00:	00062883          	lw	a7,0(a2)
    80200f04:	01788a33          	add	s4,a7,s7
    80200f08:	8a02                	jr	s4
    80200f0a:	fd050c9b          	addiw	s9,a0,-48
    80200f0e:	0ffcfd13          	zext.b	s10,s9
    80200f12:	4da5                	li	s11,9
    80200f14:	2dadf263          	bgeu	s11,s10,802011d8 <format_string_loop.constprop.0+0x356>
    80200f18:	02a00e13          	li	t3,42
    80200f1c:	4a81                	li	s5,0
    80200f1e:	37c50063          	beq	a0,t3,8020127e <format_string_loop.constprop.0+0x3fc>
    80200f22:	02e00593          	li	a1,46
    80200f26:	4d01                	li	s10,0
    80200f28:	18b50263          	beq	a0,a1,802010ac <format_string_loop.constprop.0+0x22a>
    80200f2c:	04900793          	li	a5,73
    80200f30:	00140a13          	addi	s4,s0,1
    80200f34:	1af50563          	beq	a0,a5,802010de <format_string_loop.constprop.0+0x25c>
    80200f38:	f985039b          	addiw	t2,a0,-104
    80200f3c:	0ff3f613          	zext.b	a2,t2
    80200f40:	48c9                	li	a7,18
    80200f42:	02c8e163          	bltu	a7,a2,80200f64 <format_string_loop.constprop.0+0xe2>
    80200f46:	00261c93          	slli	s9,a2,0x2
    80200f4a:	012c8db3          	add	s11,s9,s2
    80200f4e:	000daf03          	lw	t5,0(s11)
    80200f52:	012f0733          	add	a4,t5,s2
    80200f56:	8702                	jr	a4
    80200f58:	00144503          	lbu	a0,1(s0)
    80200f5c:	20086813          	ori	a6,a6,512
    80200f60:	c535                	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    80200f62:	0a05                	addi	s4,s4,1
    80200f64:	07800413          	li	s0,120
    80200f68:	10a46f63          	bltu	s0,a0,80201086 <format_string_loop.constprop.0+0x204>
    80200f6c:	06300793          	li	a5,99
    80200f70:	0ea7e963          	bltu	a5,a0,80201062 <format_string_loop.constprop.0+0x1e0>
    80200f74:	06200693          	li	a3,98
    80200f78:	08d508e3          	beq	a0,a3,80201808 <format_string_loop.constprop.0+0x986>
    80200f7c:	32f51263          	bne	a0,a5,802012a0 <format_string_loop.constprop.0+0x41e>
    80200f80:	00287413          	andi	s0,a6,2
    80200f84:	018b2283          	lw	t0,24(s6)
    80200f88:	01cb2583          	lw	a1,28(s6)
    80200f8c:	008c0c93          	addi	s9,s8,8
    80200f90:	6e040163          	beqz	s0,80201672 <format_string_loop.constprop.0+0x7f0>
    80200f94:	000c2c03          	lw	s8,0(s8)
    80200f98:	0012879b          	addiw	a5,t0,1
    80200f9c:	00fb2c23          	sw	a5,24(s6)
    80200fa0:	0ffc7513          	zext.b	a0,s8
    80200fa4:	4d05                	li	s10,1
    80200fa6:	62b2f663          	bgeu	t0,a1,802015d2 <format_string_loop.constprop.0+0x750>
    80200faa:	000b3d83          	ld	s11,0(s6)
    80200fae:	6e0d8763          	beqz	s11,8020169c <format_string_loop.constprop.0+0x81a>
    80200fb2:	008b3583          	ld	a1,8(s6)
    80200fb6:	9d82                	jalr	s11
    80200fb8:	001d0c1b          	addiw	s8,s10,1
    80200fbc:	60041d63          	bnez	s0,802015d6 <format_string_loop.constprop.0+0x754>
    80200fc0:	85d2                	mv	a1,s4
    80200fc2:	8c66                	mv	s8,s9
    80200fc4:	0005ce03          	lbu	t3,0(a1)
    80200fc8:	f00e17e3          	bnez	t3,80200ed6 <format_string_loop.constprop.0+0x54>
    80200fcc:	60aa                	ld	ra,136(sp)
    80200fce:	640a                	ld	s0,128(sp)
    80200fd0:	74e6                	ld	s1,120(sp)
    80200fd2:	7946                	ld	s2,112(sp)
    80200fd4:	79a6                	ld	s3,104(sp)
    80200fd6:	7a06                	ld	s4,96(sp)
    80200fd8:	6ae6                	ld	s5,88(sp)
    80200fda:	6b46                	ld	s6,80(sp)
    80200fdc:	6ba6                	ld	s7,72(sp)
    80200fde:	6c06                	ld	s8,64(sp)
    80200fe0:	7ce2                	ld	s9,56(sp)
    80200fe2:	7d42                	ld	s10,48(sp)
    80200fe4:	7da2                	ld	s11,40(sp)
    80200fe6:	6149                	addi	sp,sp,144
    80200fe8:	8082                	ret
    80200fea:	00186813          	ori	a6,a6,1
    80200fee:	0005c503          	lbu	a0,0(a1)
    80200ff2:	842e                	mv	s0,a1
    80200ff4:	bdd5                	j	80200ee8 <format_string_loop.constprop.0+0x66>
    80200ff6:	00286813          	ori	a6,a6,2
    80200ffa:	bfd5                	j	80200fee <format_string_loop.constprop.0+0x16c>
    80200ffc:	00486813          	ori	a6,a6,4
    80201000:	b7fd                	j	80200fee <format_string_loop.constprop.0+0x16c>
    80201002:	01086813          	ori	a6,a6,16
    80201006:	b7e5                	j	80200fee <format_string_loop.constprop.0+0x16c>
    80201008:	00886813          	ori	a6,a6,8
    8020100c:	b7cd                	j	80200fee <format_string_loop.constprop.0+0x16c>
    8020100e:	00144503          	lbu	a0,1(s0)
    80201012:	dd4d                	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    80201014:	06800f93          	li	t6,104
    80201018:	63f50b63          	beq	a0,t6,8020164e <format_string_loop.constprop.0+0x7cc>
    8020101c:	08086813          	ori	a6,a6,128
    80201020:	0a05                	addi	s4,s4,1
    80201022:	b789                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201024:	00144503          	lbu	a0,1(s0)
    80201028:	d155                	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020102a:	06c00e13          	li	t3,108
    8020102e:	63c50963          	beq	a0,t3,80201660 <format_string_loop.constprop.0+0x7de>
    80201032:	20086813          	ori	a6,a6,512
    80201036:	0a05                	addi	s4,s4,1
    80201038:	b735                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    8020103a:	018b2a03          	lw	s4,24(s6)
    8020103e:	01cb2d83          	lw	s11,28(s6)
    80201042:	001a029b          	addiw	t0,s4,1
    80201046:	005b2c23          	sw	t0,24(s6)
    8020104a:	01ba7a63          	bgeu	s4,s11,8020105e <format_string_loop.constprop.0+0x1dc>
    8020104e:	000b3303          	ld	t1,0(s6)
    80201052:	42030663          	beqz	t1,8020147e <format_string_loop.constprop.0+0x5fc>
    80201056:	008b3583          	ld	a1,8(s6)
    8020105a:	8572                	mv	a0,t3
    8020105c:	9302                	jalr	t1
    8020105e:	85a2                	mv	a1,s0
    80201060:	b795                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    80201062:	6e82                	ld	t4,0(sp)
    80201064:	f9c5009b          	addiw	ra,a0,-100
    80201068:	4685                	li	a3,1
    8020106a:	001695b3          	sll	a1,a3,ra
    8020106e:	01d5f2b3          	and	t0,a1,t4
    80201072:	36029863          	bnez	t0,802013e2 <format_string_loop.constprop.0+0x560>
    80201076:	07300893          	li	a7,115
    8020107a:	25150a63          	beq	a0,a7,802012ce <format_string_loop.constprop.0+0x44c>
    8020107e:	07000a93          	li	s5,112
    80201082:	33550f63          	beq	a0,s5,802013c0 <format_string_loop.constprop.0+0x53e>
    80201086:	018b2803          	lw	a6,24(s6)
    8020108a:	01cb2783          	lw	a5,28(s6)
    8020108e:	0018069b          	addiw	a3,a6,1
    80201092:	00db2c23          	sw	a3,24(s6)
    80201096:	00f87963          	bgeu	a6,a5,802010a8 <format_string_loop.constprop.0+0x226>
    8020109a:	000b3d03          	ld	s10,0(s6)
    8020109e:	6a0d0f63          	beqz	s10,8020175c <format_string_loop.constprop.0+0x8da>
    802010a2:	008b3583          	ld	a1,8(s6)
    802010a6:	9d02                	jalr	s10
    802010a8:	85d2                	mv	a1,s4
    802010aa:	bf29                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    802010ac:	00144503          	lbu	a0,1(s0)
    802010b0:	01386833          	or	a6,a6,s3
    802010b4:	dd01                	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    802010b6:	fd050e9b          	addiw	t4,a0,-48
    802010ba:	0ffef293          	zext.b	t0,t4
    802010be:	47a5                	li	a5,9
    802010c0:	00140713          	addi	a4,s0,1
    802010c4:	0457fa63          	bgeu	a5,t0,80201118 <format_string_loop.constprop.0+0x296>
    802010c8:	02a00313          	li	t1,42
    802010cc:	0e650763          	beq	a0,t1,802011ba <format_string_loop.constprop.0+0x338>
    802010d0:	843a                	mv	s0,a4
    802010d2:	04900793          	li	a5,73
    802010d6:	00140a13          	addi	s4,s0,1
    802010da:	e4f51fe3          	bne	a0,a5,80200f38 <format_string_loop.constprop.0+0xb6>
    802010de:	00144503          	lbu	a0,1(s0)
    802010e2:	ee0505e3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    802010e6:	03600093          	li	ra,54
    802010ea:	68150563          	beq	a0,ra,80201774 <format_string_loop.constprop.0+0x8f2>
    802010ee:	62a0ec63          	bltu	ra,a0,80201726 <format_string_loop.constprop.0+0x8a4>
    802010f2:	03100e93          	li	t4,49
    802010f6:	61d50963          	beq	a0,t4,80201708 <format_string_loop.constprop.0+0x886>
    802010fa:	03300293          	li	t0,51
    802010fe:	76551163          	bne	a0,t0,80201860 <format_string_loop.constprop.0+0x9de>
    80201102:	00244503          	lbu	a0,2(s0)
    80201106:	ec0503e3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020110a:	03200313          	li	t1,50
    8020110e:	72650863          	beq	a0,t1,8020183e <format_string_loop.constprop.0+0x9bc>
    80201112:	00340a13          	addi	s4,s0,3
    80201116:	b5b9                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201118:	002d1a1b          	slliw	s4,s10,0x2
    8020111c:	01aa0cbb          	addw	s9,s4,s10
    80201120:	0705                	addi	a4,a4,1
    80201122:	001c9d1b          	slliw	s10,s9,0x1
    80201126:	00ad0dbb          	addw	s11,s10,a0
    8020112a:	00074503          	lbu	a0,0(a4)
    8020112e:	8e3a                	mv	t3,a4
    80201130:	fd0d8d1b          	addiw	s10,s11,-48
    80201134:	fd050f1b          	addiw	t5,a0,-48
    80201138:	0fff7f93          	zext.b	t6,t5
    8020113c:	f9f7eae3          	bltu	a5,t6,802010d0 <format_string_loop.constprop.0+0x24e>
    80201140:	002d141b          	slliw	s0,s10,0x2
    80201144:	01a406bb          	addw	a3,s0,s10
    80201148:	0705                	addi	a4,a4,1
    8020114a:	0016909b          	slliw	ra,a3,0x1
    8020114e:	00a085bb          	addw	a1,ra,a0
    80201152:	00074503          	lbu	a0,0(a4)
    80201156:	fd058d1b          	addiw	s10,a1,-48
    8020115a:	fd050e9b          	addiw	t4,a0,-48
    8020115e:	0ffef293          	zext.b	t0,t4
    80201162:	f657e7e3          	bltu	a5,t0,802010d0 <format_string_loop.constprop.0+0x24e>
    80201166:	002d171b          	slliw	a4,s10,0x2
    8020116a:	01a7033b          	addw	t1,a4,s10
    8020116e:	0013139b          	slliw	t2,t1,0x1
    80201172:	00a3863b          	addw	a2,t2,a0
    80201176:	002e4503          	lbu	a0,2(t3)
    8020117a:	002e0713          	addi	a4,t3,2
    8020117e:	fd060d1b          	addiw	s10,a2,-48
    80201182:	fd05089b          	addiw	a7,a0,-48
    80201186:	0ff8fa13          	zext.b	s4,a7
    8020118a:	f547e3e3          	bltu	a5,s4,802010d0 <format_string_loop.constprop.0+0x24e>
    8020118e:	002d1c9b          	slliw	s9,s10,0x2
    80201192:	01ac8d3b          	addw	s10,s9,s10
    80201196:	001d1d9b          	slliw	s11,s10,0x1
    8020119a:	00ad8f3b          	addw	t5,s11,a0
    8020119e:	003e4503          	lbu	a0,3(t3)
    802011a2:	003e0713          	addi	a4,t3,3
    802011a6:	fd0f0d1b          	addiw	s10,t5,-48
    802011aa:	fd050e1b          	addiw	t3,a0,-48
    802011ae:	0ffe7f93          	zext.b	t6,t3
    802011b2:	f7f7f3e3          	bgeu	a5,t6,80201118 <format_string_loop.constprop.0+0x296>
    802011b6:	843a                	mv	s0,a4
    802011b8:	bf29                	j	802010d2 <format_string_loop.constprop.0+0x250>
    802011ba:	000c2383          	lw	t2,0(s8)
    802011be:	00244503          	lbu	a0,2(s0)
    802011c2:	0c21                	addi	s8,s8,8
    802011c4:	fff3c613          	not	a2,t2
    802011c8:	43f65893          	srai	a7,a2,0x3f
    802011cc:	0078fd33          	and	s10,a7,t2
    802011d0:	0409                	addi	s0,s0,2
    802011d2:	d4051de3          	bnez	a0,80200f2c <format_string_loop.constprop.0+0xaa>
    802011d6:	bbdd                	j	80200fcc <format_string_loop.constprop.0+0x14a>
    802011d8:	4a81                	li	s5,0
    802011da:	4ea5                	li	t4,9
    802011dc:	002a941b          	slliw	s0,s5,0x2
    802011e0:	01540f3b          	addw	t5,s0,s5
    802011e4:	001f1f9b          	slliw	t6,t5,0x1
    802011e8:	00af873b          	addw	a4,t6,a0
    802011ec:	0005c503          	lbu	a0,0(a1)
    802011f0:	842e                	mv	s0,a1
    802011f2:	fd070a9b          	addiw	s5,a4,-48
    802011f6:	fd05069b          	addiw	a3,a0,-48
    802011fa:	0ff6f093          	zext.b	ra,a3
    802011fe:	d21ee2e3          	bltu	t4,ra,80200f22 <format_string_loop.constprop.0+0xa0>
    80201202:	002a929b          	slliw	t0,s5,0x2
    80201206:	015287bb          	addw	a5,t0,s5
    8020120a:	0017931b          	slliw	t1,a5,0x1
    8020120e:	00a303bb          	addw	t2,t1,a0
    80201212:	0015c503          	lbu	a0,1(a1)
    80201216:	00158413          	addi	s0,a1,1
    8020121a:	fd038a9b          	addiw	s5,t2,-48
    8020121e:	fd05061b          	addiw	a2,a0,-48
    80201222:	0ff67893          	zext.b	a7,a2
    80201226:	cf1eeee3          	bltu	t4,a7,80200f22 <format_string_loop.constprop.0+0xa0>
    8020122a:	002a9a1b          	slliw	s4,s5,0x2
    8020122e:	015a0abb          	addw	s5,s4,s5
    80201232:	001a9c9b          	slliw	s9,s5,0x1
    80201236:	00ac8d3b          	addw	s10,s9,a0
    8020123a:	0025c503          	lbu	a0,2(a1)
    8020123e:	00258413          	addi	s0,a1,2
    80201242:	fd0d0a9b          	addiw	s5,s10,-48
    80201246:	fd050d9b          	addiw	s11,a0,-48
    8020124a:	0ffdfe13          	zext.b	t3,s11
    8020124e:	cdceeae3          	bltu	t4,t3,80200f22 <format_string_loop.constprop.0+0xa0>
    80201252:	002a941b          	slliw	s0,s5,0x2
    80201256:	01540f3b          	addw	t5,s0,s5
    8020125a:	001f1f9b          	slliw	t6,t5,0x1
    8020125e:	00af873b          	addw	a4,t6,a0
    80201262:	0035c503          	lbu	a0,3(a1)
    80201266:	00358413          	addi	s0,a1,3
    8020126a:	fd070a9b          	addiw	s5,a4,-48
    8020126e:	fd05069b          	addiw	a3,a0,-48
    80201272:	0ff6f093          	zext.b	ra,a3
    80201276:	ca1ee6e3          	bltu	t4,ra,80200f22 <format_string_loop.constprop.0+0xa0>
    8020127a:	0591                	addi	a1,a1,4
    8020127c:	b785                	j	802011dc <format_string_loop.constprop.0+0x35a>
    8020127e:	000c2503          	lw	a0,0(s8)
    80201282:	0c21                	addi	s8,s8,8
    80201284:	00050a9b          	sext.w	s5,a0
    80201288:	00055663          	bgez	a0,80201294 <format_string_loop.constprop.0+0x412>
    8020128c:	00286813          	ori	a6,a6,2
    80201290:	40a00abb          	negw	s5,a0
    80201294:	00144503          	lbu	a0,1(s0)
    80201298:	d2050ae3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020129c:	842e                	mv	s0,a1
    8020129e:	b151                	j	80200f22 <format_string_loop.constprop.0+0xa0>
    802012a0:	38951363          	bne	a0,s1,80201626 <format_string_loop.constprop.0+0x7a4>
    802012a4:	018b2a83          	lw	s5,24(s6)
    802012a8:	01cb2283          	lw	t0,28(s6)
    802012ac:	001a831b          	addiw	t1,s5,1
    802012b0:	006b2c23          	sw	t1,24(s6)
    802012b4:	de5afae3          	bgeu	s5,t0,802010a8 <format_string_loop.constprop.0+0x226>
    802012b8:	000b3383          	ld	t2,0(s6)
    802012bc:	48038263          	beqz	t2,80201740 <format_string_loop.constprop.0+0x8be>
    802012c0:	008b3583          	ld	a1,8(s6)
    802012c4:	02500513          	li	a0,37
    802012c8:	9382                	jalr	t2
    802012ca:	85d2                	mv	a1,s4
    802012cc:	b9e5                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    802012ce:	000c3d83          	ld	s11,0(s8)
    802012d2:	0c21                	addi	s8,s8,8
    802012d4:	2c0d8c63          	beqz	s11,802015ac <format_string_loop.constprop.0+0x72a>
    802012d8:	000dc503          	lbu	a0,0(s11)
    802012dc:	2e0d0463          	beqz	s10,802015c4 <format_string_loop.constprop.0+0x742>
    802012e0:	58050863          	beqz	a0,80201870 <format_string_loop.constprop.0+0x9ee>
    802012e4:	fffd0f1b          	addiw	t5,s10,-1
    802012e8:	001f071b          	addiw	a4,t5,1
    802012ec:	02071e13          	slli	t3,a4,0x20
    802012f0:	020e5f93          	srli	t6,t3,0x20
    802012f4:	007ff413          	andi	s0,t6,7
    802012f8:	01fd87b3          	add	a5,s11,t6
    802012fc:	86ee                	mv	a3,s11
    802012fe:	c035                	beqz	s0,80201362 <format_string_loop.constprop.0+0x4e0>
    80201300:	4085                	li	ra,1
    80201302:	04140963          	beq	s0,ra,80201354 <format_string_loop.constprop.0+0x4d2>
    80201306:	4589                	li	a1,2
    80201308:	04b40163          	beq	s0,a1,8020134a <format_string_loop.constprop.0+0x4c8>
    8020130c:	4e8d                	li	t4,3
    8020130e:	03d40a63          	beq	s0,t4,80201342 <format_string_loop.constprop.0+0x4c0>
    80201312:	4291                	li	t0,4
    80201314:	02540263          	beq	s0,t0,80201338 <format_string_loop.constprop.0+0x4b6>
    80201318:	4315                	li	t1,5
    8020131a:	00640a63          	beq	s0,t1,8020132e <format_string_loop.constprop.0+0x4ac>
    8020131e:	4399                	li	t2,6
    80201320:	50741663          	bne	s0,t2,8020182c <format_string_loop.constprop.0+0x9aa>
    80201324:	0016c883          	lbu	a7,1(a3)
    80201328:	0685                	addi	a3,a3,1
    8020132a:	08088863          	beqz	a7,802013ba <format_string_loop.constprop.0+0x538>
    8020132e:	0016cc83          	lbu	s9,1(a3)
    80201332:	0685                	addi	a3,a3,1
    80201334:	080c8363          	beqz	s9,802013ba <format_string_loop.constprop.0+0x538>
    80201338:	0016cf03          	lbu	t5,1(a3)
    8020133c:	0685                	addi	a3,a3,1
    8020133e:	060f0e63          	beqz	t5,802013ba <format_string_loop.constprop.0+0x538>
    80201342:	0016c703          	lbu	a4,1(a3)
    80201346:	0685                	addi	a3,a3,1
    80201348:	cb2d                	beqz	a4,802013ba <format_string_loop.constprop.0+0x538>
    8020134a:	0016ce03          	lbu	t3,1(a3)
    8020134e:	0685                	addi	a3,a3,1
    80201350:	060e0563          	beqz	t3,802013ba <format_string_loop.constprop.0+0x538>
    80201354:	0016cf83          	lbu	t6,1(a3)
    80201358:	0685                	addi	a3,a3,1
    8020135a:	060f8063          	beqz	t6,802013ba <format_string_loop.constprop.0+0x538>
    8020135e:	14d78363          	beq	a5,a3,802014a4 <format_string_loop.constprop.0+0x622>
    80201362:	0016c403          	lbu	s0,1(a3)
    80201366:	0685                	addi	a3,a3,1
    80201368:	80b6                	mv	ra,a3
    8020136a:	c821                	beqz	s0,802013ba <format_string_loop.constprop.0+0x538>
    8020136c:	0016c583          	lbu	a1,1(a3)
    80201370:	0685                	addi	a3,a3,1
    80201372:	c5a1                	beqz	a1,802013ba <format_string_loop.constprop.0+0x538>
    80201374:	0020ce83          	lbu	t4,2(ra)
    80201378:	00208693          	addi	a3,ra,2
    8020137c:	020e8f63          	beqz	t4,802013ba <format_string_loop.constprop.0+0x538>
    80201380:	0030c283          	lbu	t0,3(ra)
    80201384:	00308693          	addi	a3,ra,3
    80201388:	02028963          	beqz	t0,802013ba <format_string_loop.constprop.0+0x538>
    8020138c:	0040c303          	lbu	t1,4(ra)
    80201390:	00408693          	addi	a3,ra,4
    80201394:	02030363          	beqz	t1,802013ba <format_string_loop.constprop.0+0x538>
    80201398:	0050c383          	lbu	t2,5(ra)
    8020139c:	00508693          	addi	a3,ra,5
    802013a0:	00038d63          	beqz	t2,802013ba <format_string_loop.constprop.0+0x538>
    802013a4:	0060c603          	lbu	a2,6(ra)
    802013a8:	00608693          	addi	a3,ra,6
    802013ac:	c619                	beqz	a2,802013ba <format_string_loop.constprop.0+0x538>
    802013ae:	0070c883          	lbu	a7,7(ra)
    802013b2:	00708693          	addi	a3,ra,7
    802013b6:	fa0894e3          	bnez	a7,8020135e <format_string_loop.constprop.0+0x4dc>
    802013ba:	41b68cbb          	subw	s9,a3,s11
    802013be:	a0ed                	j	802014a8 <format_string_loop.constprop.0+0x626>
    802013c0:	000c3583          	ld	a1,0(s8)
    802013c4:	68a2                	ld	a7,8(sp)
    802013c6:	0c21                	addi	s8,s8,8
    802013c8:	01186833          	or	a6,a6,a7
    802013cc:	26058563          	beqz	a1,80201636 <format_string_loop.constprop.0+0x7b4>
    802013d0:	47c9                	li	a5,18
    802013d2:	876a                	mv	a4,s10
    802013d4:	46c1                	li	a3,16
    802013d6:	4601                	li	a2,0
    802013d8:	855a                	mv	a0,s6
    802013da:	af6ff0ef          	jal	802006d0 <print_integer>
    802013de:	85d2                	mv	a1,s4
    802013e0:	b6d5                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    802013e2:	06400313          	li	t1,100
    802013e6:	0a650863          	beq	a0,t1,80201496 <format_string_loop.constprop.0+0x614>
    802013ea:	06900393          	li	t2,105
    802013ee:	0a750463          	beq	a0,t2,80201496 <format_string_loop.constprop.0+0x614>
    802013f2:	06f00613          	li	a2,111
    802013f6:	46a1                	li	a3,8
    802013f8:	00c50763          	beq	a0,a2,80201406 <format_string_loop.constprop.0+0x584>
    802013fc:	0aa67063          	bgeu	a2,a0,8020149c <format_string_loop.constprop.0+0x61a>
    80201400:	46c1                	li	a3,16
    80201402:	08851d63          	bne	a0,s0,8020149c <format_string_loop.constprop.0+0x61a>
    80201406:	01387e33          	and	t3,a6,s3
    8020140a:	000e0463          	beqz	t3,80201412 <format_string_loop.constprop.0+0x590>
    8020140e:	ffe87813          	andi	a6,a6,-2
    80201412:	03181513          	slli	a0,a6,0x31
    80201416:	8fc2                	mv	t6,a6
    80201418:	40087713          	andi	a4,a6,1024
    8020141c:	14055863          	bgez	a0,8020156c <format_string_loop.constprop.0+0x6ea>
    80201420:	ef0d                	bnez	a4,8020145a <format_string_loop.constprop.0+0x5d8>
    80201422:	200ffd93          	andi	s11,t6,512
    80201426:	020d9a63          	bnez	s11,8020145a <format_string_loop.constprop.0+0x5d8>
    8020142a:	040ff293          	andi	t0,t6,64
    8020142e:	000c2603          	lw	a2,0(s8)
    80201432:	3e028463          	beqz	t0,8020181a <format_string_loop.constprop.0+0x998>
    80201436:	0186189b          	slliw	a7,a2,0x18
    8020143a:	4188d61b          	sraiw	a2,a7,0x18
    8020143e:	43f65f13          	srai	t5,a2,0x3f
    80201442:	00cf4e33          	xor	t3,t5,a2
    80201446:	87d6                	mv	a5,s5
    80201448:	876a                	mv	a4,s10
    8020144a:	01f6561b          	srliw	a2,a2,0x1f
    8020144e:	41ee05b3          	sub	a1,t3,t5
    80201452:	855a                	mv	a0,s6
    80201454:	a7cff0ef          	jal	802006d0 <print_integer>
    80201458:	a005                	j	80201478 <format_string_loop.constprop.0+0x5f6>
    8020145a:	000c3f83          	ld	t6,0(s8)
    8020145e:	87d6                	mv	a5,s5
    80201460:	876a                	mv	a4,s10
    80201462:	43ffda93          	srai	s5,t6,0x3f
    80201466:	01fac533          	xor	a0,s5,t6
    8020146a:	415505b3          	sub	a1,a0,s5
    8020146e:	03ffd613          	srli	a2,t6,0x3f
    80201472:	855a                	mv	a0,s6
    80201474:	a5cff0ef          	jal	802006d0 <print_integer>
    80201478:	85d2                	mv	a1,s4
    8020147a:	0c21                	addi	s8,s8,8
    8020147c:	b6a1                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    8020147e:	010b3383          	ld	t2,16(s6)
    80201482:	020a1613          	slli	a2,s4,0x20
    80201486:	02065893          	srli	a7,a2,0x20
    8020148a:	01138f33          	add	t5,t2,a7
    8020148e:	01cf0023          	sb	t3,0(t5)
    80201492:	85a2                	mv	a1,s0
    80201494:	be05                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    80201496:	6511                	lui	a0,0x4
    80201498:	00a86833          	or	a6,a6,a0
    8020149c:	fef87813          	andi	a6,a6,-17
    802014a0:	46a9                	li	a3,10
    802014a2:	b795                	j	80201406 <format_string_loop.constprop.0+0x584>
    802014a4:	41b78cbb          	subw	s9,a5,s11
    802014a8:	01387433          	and	s0,a6,s3
    802014ac:	c411                	beqz	s0,802014b8 <format_string_loop.constprop.0+0x636>
    802014ae:	87ea                	mv	a5,s10
    802014b0:	27ace963          	bltu	s9,s10,80201722 <format_string_loop.constprop.0+0x8a0>
    802014b4:	00078c9b          	sext.w	s9,a5
    802014b8:	00287813          	andi	a6,a6,2
    802014bc:	ec42                	sd	a6,24(sp)
    802014be:	2c080d63          	beqz	a6,80201798 <format_string_loop.constprop.0+0x916>
    802014c2:	c121                	beqz	a0,80201502 <format_string_loop.constprop.0+0x680>
    802014c4:	01ad8d3b          	addw	s10,s11,s10
    802014c8:	c409                	beqz	s0,802014d2 <format_string_loop.constprop.0+0x650>
    802014ca:	000d861b          	sext.w	a2,s11
    802014ce:	02cd0763          	beq	s10,a2,802014fc <format_string_loop.constprop.0+0x67a>
    802014d2:	018b2883          	lw	a7,24(s6)
    802014d6:	01cb2683          	lw	a3,28(s6)
    802014da:	0d85                	addi	s11,s11,1
    802014dc:	0018879b          	addiw	a5,a7,1
    802014e0:	00fb2c23          	sw	a5,24(s6)
    802014e4:	00d8f963          	bgeu	a7,a3,802014f6 <format_string_loop.constprop.0+0x674>
    802014e8:	000b3803          	ld	a6,0(s6)
    802014ec:	06080563          	beqz	a6,80201556 <format_string_loop.constprop.0+0x6d4>
    802014f0:	008b3583          	ld	a1,8(s6)
    802014f4:	9802                	jalr	a6
    802014f6:	000dc503          	lbu	a0,0(s11)
    802014fa:	f579                	bnez	a0,802014c8 <format_string_loop.constprop.0+0x646>
    802014fc:	6de2                	ld	s11,24(sp)
    802014fe:	ba0d85e3          	beqz	s11,802010a8 <format_string_loop.constprop.0+0x226>
    80201502:	001c8d1b          	addiw	s10,s9,1
    80201506:	bb5cf1e3          	bgeu	s9,s5,802010a8 <format_string_loop.constprop.0+0x226>
    8020150a:	02000413          	li	s0,32
    8020150e:	a819                	j	80201524 <format_string_loop.constprop.0+0x6a2>
    80201510:	008b3583          	ld	a1,8(s6)
    80201514:	02000513          	li	a0,32
    80201518:	9e82                	jalr	t4
    8020151a:	001d061b          	addiw	a2,s10,1
    8020151e:	b9aa85e3          	beq	s5,s10,802010a8 <format_string_loop.constprop.0+0x226>
    80201522:	8d32                	mv	s10,a2
    80201524:	018b2c83          	lw	s9,24(s6)
    80201528:	01cb2503          	lw	a0,28(s6)
    8020152c:	001c809b          	addiw	ra,s9,1
    80201530:	001b2c23          	sw	ra,24(s6)
    80201534:	feacf3e3          	bgeu	s9,a0,8020151a <format_string_loop.constprop.0+0x698>
    80201538:	000b3e83          	ld	t4,0(s6)
    8020153c:	fc0e9ae3          	bnez	t4,80201510 <format_string_loop.constprop.0+0x68e>
    80201540:	010b3583          	ld	a1,16(s6)
    80201544:	020c9293          	slli	t0,s9,0x20
    80201548:	0202d313          	srli	t1,t0,0x20
    8020154c:	006583b3          	add	t2,a1,t1
    80201550:	00838023          	sb	s0,0(t2)
    80201554:	b7d9                	j	8020151a <format_string_loop.constprop.0+0x698>
    80201556:	010b3f03          	ld	t5,16(s6)
    8020155a:	02089713          	slli	a4,a7,0x20
    8020155e:	02075e13          	srli	t3,a4,0x20
    80201562:	01cf0fb3          	add	t6,t5,t3
    80201566:	00af8023          	sb	a0,0(t6)
    8020156a:	b771                	j	802014f6 <format_string_loop.constprop.0+0x674>
    8020156c:	ff387813          	andi	a6,a6,-13
    80201570:	e70d                	bnez	a4,8020159a <format_string_loop.constprop.0+0x718>
    80201572:	200ff093          	andi	ra,t6,512
    80201576:	02009263          	bnez	ra,8020159a <format_string_loop.constprop.0+0x718>
    8020157a:	040ffe93          	andi	t4,t6,64
    8020157e:	280e8763          	beqz	t4,8020180c <format_string_loop.constprop.0+0x98a>
    80201582:	000c4403          	lbu	s0,0(s8)
    80201586:	02041593          	slli	a1,s0,0x20
    8020158a:	87d6                	mv	a5,s5
    8020158c:	876a                	mv	a4,s10
    8020158e:	4601                	li	a2,0
    80201590:	9181                	srli	a1,a1,0x20
    80201592:	855a                	mv	a0,s6
    80201594:	93cff0ef          	jal	802006d0 <print_integer>
    80201598:	b5c5                	j	80201478 <format_string_loop.constprop.0+0x5f6>
    8020159a:	000c3583          	ld	a1,0(s8)
    8020159e:	87d6                	mv	a5,s5
    802015a0:	876a                	mv	a4,s10
    802015a2:	4601                	li	a2,0
    802015a4:	855a                	mv	a0,s6
    802015a6:	92aff0ef          	jal	802006d0 <print_integer>
    802015aa:	b5f9                	j	80201478 <format_string_loop.constprop.0+0x5f6>
    802015ac:	00001597          	auipc	a1,0x1
    802015b0:	b0c58593          	addi	a1,a1,-1268 # 802020b8 <imsic_init+0x224>
    802015b4:	8742                	mv	a4,a6
    802015b6:	86d6                	mv	a3,s5
    802015b8:	4619                	li	a2,6
    802015ba:	855a                	mv	a0,s6
    802015bc:	ceffe0ef          	jal	802002aa <out_rev_>
    802015c0:	85d2                	mv	a1,s4
    802015c2:	b409                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    802015c4:	2a050663          	beqz	a0,80201870 <format_string_loop.constprop.0+0x9ee>
    802015c8:	80000cb7          	lui	s9,0x80000
    802015cc:	ffeccf13          	xori	t5,s9,-2
    802015d0:	bb21                	j	802012e8 <format_string_loop.constprop.0+0x466>
    802015d2:	4c09                	li	s8,2
    802015d4:	4d05                	li	s10,1
    802015d6:	9f5d75e3          	bgeu	s10,s5,80200fc0 <format_string_loop.constprop.0+0x13e>
    802015da:	02000413          	li	s0,32
    802015de:	a819                	j	802015f4 <format_string_loop.constprop.0+0x772>
    802015e0:	008b3583          	ld	a1,8(s6)
    802015e4:	02000513          	li	a0,32
    802015e8:	9e02                	jalr	t3
    802015ea:	001c0e9b          	addiw	t4,s8,1
    802015ee:	9d5c79e3          	bgeu	s8,s5,80200fc0 <format_string_loop.constprop.0+0x13e>
    802015f2:	8c76                	mv	s8,t4
    802015f4:	018b2d03          	lw	s10,24(s6)
    802015f8:	01cb2803          	lw	a6,28(s6)
    802015fc:	001d0f1b          	addiw	t5,s10,1
    80201600:	01eb2c23          	sw	t5,24(s6)
    80201604:	ff0d73e3          	bgeu	s10,a6,802015ea <format_string_loop.constprop.0+0x768>
    80201608:	000b3e03          	ld	t3,0(s6)
    8020160c:	fc0e1ae3          	bnez	t3,802015e0 <format_string_loop.constprop.0+0x75e>
    80201610:	010b3f83          	ld	t6,16(s6)
    80201614:	020d1713          	slli	a4,s10,0x20
    80201618:	02075513          	srli	a0,a4,0x20
    8020161c:	00af80b3          	add	ra,t6,a0
    80201620:	00808023          	sb	s0,0(ra)
    80201624:	b7d9                	j	802015ea <format_string_loop.constprop.0+0x768>
    80201626:	05800f13          	li	t5,88
    8020162a:	a5e51ee3          	bne	a0,t5,80201086 <format_string_loop.constprop.0+0x204>
    8020162e:	02086813          	ori	a6,a6,32
    80201632:	46c1                	li	a3,16
    80201634:	bbc9                	j	80201406 <format_string_loop.constprop.0+0x584>
    80201636:	00001597          	auipc	a1,0x1
    8020163a:	a8a58593          	addi	a1,a1,-1398 # 802020c0 <imsic_init+0x22c>
    8020163e:	8742                	mv	a4,a6
    80201640:	46c9                	li	a3,18
    80201642:	4615                	li	a2,5
    80201644:	855a                	mv	a0,s6
    80201646:	c65fe0ef          	jal	802002aa <out_rev_>
    8020164a:	85d2                	mv	a1,s4
    8020164c:	baa5                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    8020164e:	00244503          	lbu	a0,2(s0)
    80201652:	0c086813          	ori	a6,a6,192
    80201656:	96050be3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020165a:	00340a13          	addi	s4,s0,3
    8020165e:	b219                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201660:	00244503          	lbu	a0,2(s0)
    80201664:	60086813          	ori	a6,a6,1536
    80201668:	960502e3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020166c:	00340a13          	addi	s4,s0,3
    80201670:	b8d5                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201672:	4805                	li	a6,1
    80201674:	001a8d1b          	addiw	s10,s5,1
    80201678:	4d89                	li	s11,2
    8020167a:	05586e63          	bltu	a6,s5,802016d6 <format_string_loop.constprop.0+0x854>
    8020167e:	4d09                	li	s10,2
    80201680:	000c2603          	lw	a2,0(s8)
    80201684:	0012839b          	addiw	t2,t0,1
    80201688:	007b2c23          	sw	t2,24(s6)
    8020168c:	0ff67513          	zext.b	a0,a2
    80201690:	92b2f8e3          	bgeu	t0,a1,80200fc0 <format_string_loop.constprop.0+0x13e>
    80201694:	000b3d83          	ld	s11,0(s6)
    80201698:	900d9de3          	bnez	s11,80200fb2 <format_string_loop.constprop.0+0x130>
    8020169c:	010b3583          	ld	a1,16(s6)
    802016a0:	02029893          	slli	a7,t0,0x20
    802016a4:	0208d693          	srli	a3,a7,0x20
    802016a8:	00d587b3          	add	a5,a1,a3
    802016ac:	00a78023          	sb	a0,0(a5)
    802016b0:	b221                	j	80200fb8 <format_string_loop.constprop.0+0x136>
    802016b2:	000b3e03          	ld	t3,0(s6)
    802016b6:	020e0863          	beqz	t3,802016e6 <format_string_loop.constprop.0+0x864>
    802016ba:	008b3583          	ld	a1,8(s6)
    802016be:	02000513          	li	a0,32
    802016c2:	9e02                	jalr	t3
    802016c4:	018b2283          	lw	t0,24(s6)
    802016c8:	01cb2583          	lw	a1,28(s6)
    802016cc:	001d831b          	addiw	t1,s11,1
    802016d0:	fbba88e3          	beq	s5,s11,80201680 <format_string_loop.constprop.0+0x7fe>
    802016d4:	8d9a                	mv	s11,t1
    802016d6:	00128f1b          	addiw	t5,t0,1
    802016da:	01eb2c23          	sw	t5,24(s6)
    802016de:	fcb2eae3          	bltu	t0,a1,802016b2 <format_string_loop.constprop.0+0x830>
    802016e2:	82fa                	mv	t0,t5
    802016e4:	b7e5                	j	802016cc <format_string_loop.constprop.0+0x84a>
    802016e6:	010b3f83          	ld	t6,16(s6)
    802016ea:	02029713          	slli	a4,t0,0x20
    802016ee:	02075513          	srli	a0,a4,0x20
    802016f2:	00af80b3          	add	ra,t6,a0
    802016f6:	02000e93          	li	t4,32
    802016fa:	01d08023          	sb	t4,0(ra)
    802016fe:	018b2283          	lw	t0,24(s6)
    80201702:	01cb2583          	lw	a1,28(s6)
    80201706:	b7d9                	j	802016cc <format_string_loop.constprop.0+0x84a>
    80201708:	00244503          	lbu	a0,2(s0)
    8020170c:	8c0500e3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    80201710:	a01511e3          	bne	a0,ra,80201112 <format_string_loop.constprop.0+0x290>
    80201714:	00344503          	lbu	a0,3(s0)
    80201718:	08086813          	ori	a6,a6,128
    8020171c:	00440a13          	addi	s4,s0,4
    80201720:	b091                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201722:	87e6                	mv	a5,s9
    80201724:	bb41                	j	802014b4 <format_string_loop.constprop.0+0x632>
    80201726:	03800593          	li	a1,56
    8020172a:	12b51763          	bne	a0,a1,80201858 <format_string_loop.constprop.0+0x9d6>
    8020172e:	00244503          	lbu	a0,2(s0)
    80201732:	04086813          	ori	a6,a6,64
    80201736:	88050be3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020173a:	00340a13          	addi	s4,s0,3
    8020173e:	b01d                	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201740:	010b3603          	ld	a2,16(s6)
    80201744:	020a9893          	slli	a7,s5,0x20
    80201748:	0208d693          	srli	a3,a7,0x20
    8020174c:	00d607b3          	add	a5,a2,a3
    80201750:	02500d13          	li	s10,37
    80201754:	01a78023          	sb	s10,0(a5)
    80201758:	85d2                	mv	a1,s4
    8020175a:	b0ad                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    8020175c:	010b3703          	ld	a4,16(s6)
    80201760:	02081093          	slli	ra,a6,0x20
    80201764:	0200de93          	srli	t4,ra,0x20
    80201768:	01d70cb3          	add	s9,a4,t4
    8020176c:	00ac8023          	sb	a0,0(s9) # ffffffff80000000 <_stack_top+0xfffffffeffdec000>
    80201770:	85d2                	mv	a1,s4
    80201772:	b889                	j	80200fc4 <format_string_loop.constprop.0+0x142>
    80201774:	00244503          	lbu	a0,2(s0)
    80201778:	84050ae3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020177c:	03400693          	li	a3,52
    80201780:	98d519e3          	bne	a0,a3,80201112 <format_string_loop.constprop.0+0x290>
    80201784:	00344503          	lbu	a0,3(s0)
    80201788:	840502e3          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    8020178c:	20086813          	ori	a6,a6,512
    80201790:	00440a13          	addi	s4,s0,4
    80201794:	fd0ff06f          	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201798:	001c831b          	addiw	t1,s9,1
    8020179c:	0d5cfc63          	bgeu	s9,s5,80201874 <format_string_loop.constprop.0+0x9f2>
    802017a0:	001a8c9b          	addiw	s9,s5,1
    802017a4:	a829                	j	802017be <format_string_loop.constprop.0+0x93c>
    802017a6:	008b3583          	ld	a1,8(s6)
    802017aa:	02000513          	li	a0,32
    802017ae:	e81a                	sd	t1,16(sp)
    802017b0:	9e02                	jalr	t3
    802017b2:	6342                	ld	t1,16(sp)
    802017b4:	0013039b          	addiw	t2,t1,1
    802017b8:	046a8163          	beq	s5,t1,802017fa <format_string_loop.constprop.0+0x978>
    802017bc:	831e                	mv	t1,t2
    802017be:	018b2f03          	lw	t5,24(s6)
    802017c2:	01cb2703          	lw	a4,28(s6)
    802017c6:	001f051b          	addiw	a0,t5,1
    802017ca:	00ab2c23          	sw	a0,24(s6)
    802017ce:	feef73e3          	bgeu	t5,a4,802017b4 <format_string_loop.constprop.0+0x932>
    802017d2:	000b3e03          	ld	t3,0(s6)
    802017d6:	fc0e18e3          	bnez	t3,802017a6 <format_string_loop.constprop.0+0x924>
    802017da:	010b3f83          	ld	t6,16(s6)
    802017de:	020f1093          	slli	ra,t5,0x20
    802017e2:	0200d593          	srli	a1,ra,0x20
    802017e6:	00bf8eb3          	add	t4,t6,a1
    802017ea:	02000293          	li	t0,32
    802017ee:	005e8023          	sb	t0,0(t4)
    802017f2:	0013039b          	addiw	t2,t1,1
    802017f6:	fc6a93e3          	bne	s5,t1,802017bc <format_string_loop.constprop.0+0x93a>
    802017fa:	000dc503          	lbu	a0,0(s11)
    802017fe:	8a0505e3          	beqz	a0,802010a8 <format_string_loop.constprop.0+0x226>
    80201802:	01ad8d3b          	addw	s10,s11,s10
    80201806:	b1c9                	j	802014c8 <format_string_loop.constprop.0+0x646>
    80201808:	4689                	li	a3,2
    8020180a:	bef5                	j	80201406 <format_string_loop.constprop.0+0x584>
    8020180c:	080ffc93          	andi	s9,t6,128
    80201810:	040c8163          	beqz	s9,80201852 <format_string_loop.constprop.0+0x9d0>
    80201814:	000c5403          	lhu	s0,0(s8)
    80201818:	b3bd                	j	80201586 <format_string_loop.constprop.0+0x704>
    8020181a:	080ff313          	andi	t1,t6,128
    8020181e:	c20300e3          	beqz	t1,8020143e <format_string_loop.constprop.0+0x5bc>
    80201822:	0106139b          	slliw	t2,a2,0x10
    80201826:	4103d61b          	sraiw	a2,t2,0x10
    8020182a:	b911                	j	8020143e <format_string_loop.constprop.0+0x5bc>
    8020182c:	001dc603          	lbu	a2,1(s11)
    80201830:	001d8693          	addi	a3,s11,1
    80201834:	ae0618e3          	bnez	a2,80201324 <format_string_loop.constprop.0+0x4a2>
    80201838:	41b68cbb          	subw	s9,a3,s11
    8020183c:	b1b5                	j	802014a8 <format_string_loop.constprop.0+0x626>
    8020183e:	00344503          	lbu	a0,3(s0)
    80201842:	f8050563          	beqz	a0,80200fcc <format_string_loop.constprop.0+0x14a>
    80201846:	10086813          	ori	a6,a6,256
    8020184a:	00440a13          	addi	s4,s0,4
    8020184e:	f16ff06f          	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201852:	000c2403          	lw	s0,0(s8)
    80201856:	bb05                	j	80201586 <format_string_loop.constprop.0+0x704>
    80201858:	00240a13          	addi	s4,s0,2
    8020185c:	f08ff06f          	j	80200f64 <format_string_loop.constprop.0+0xe2>
    80201860:	02500813          	li	a6,37
    80201864:	00240a13          	addi	s4,s0,2
    80201868:	a3050ee3          	beq	a0,a6,802012a4 <format_string_loop.constprop.0+0x422>
    8020186c:	81bff06f          	j	80201086 <format_string_loop.constprop.0+0x204>
    80201870:	4c81                	li	s9,0
    80201872:	b91d                	j	802014a8 <format_string_loop.constprop.0+0x626>
    80201874:	8c9a                	mv	s9,t1
    80201876:	820509e3          	beqz	a0,802010a8 <format_string_loop.constprop.0+0x226>
    8020187a:	01ad8d3b          	addw	s10,s11,s10
    8020187e:	b1a9                	j	802014c8 <format_string_loop.constprop.0+0x646>
    80201880:	8082                	ret

0000000080201882 <vprintf_>:
    80201882:	7179                	addi	sp,sp,-48
    80201884:	800007b7          	lui	a5,0x80000
    80201888:	f406                	sd	ra,40(sp)
    8020188a:	fff7c093          	not	ra,a5
    8020188e:	862e                	mv	a2,a1
    80201890:	02009293          	slli	t0,ra,0x20
    80201894:	85aa                	mv	a1,a0
    80201896:	fffff717          	auipc	a4,0xfffff
    8020189a:	a1070713          	addi	a4,a4,-1520 # 802002a6 <putchar_wrapper>
    8020189e:	850a                	mv	a0,sp
    802018a0:	e03a                	sd	a4,0(sp)
    802018a2:	e402                	sd	zero,8(sp)
    802018a4:	e802                	sd	zero,16(sp)
    802018a6:	ec16                	sd	t0,24(sp)
    802018a8:	ddaff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    802018ac:	6302                	ld	t1,0(sp)
    802018ae:	00030663          	beqz	t1,802018ba <vprintf_+0x38>
    802018b2:	4562                	lw	a0,24(sp)
    802018b4:	70a2                	ld	ra,40(sp)
    802018b6:	6145                	addi	sp,sp,48
    802018b8:	8082                	ret
    802018ba:	43f2                	lw	t2,28(sp)
    802018bc:	4562                	lw	a0,24(sp)
    802018be:	fe038be3          	beqz	t2,802018b4 <vprintf_+0x32>
    802018c2:	65c2                	ld	a1,16(sp)
    802018c4:	d9e5                	beqz	a1,802018b4 <vprintf_+0x32>
    802018c6:	86aa                	mv	a3,a0
    802018c8:	00757d63          	bgeu	a0,t2,802018e2 <vprintf_+0x60>
    802018cc:	02069613          	slli	a2,a3,0x20
    802018d0:	02065813          	srli	a6,a2,0x20
    802018d4:	010588b3          	add	a7,a1,a6
    802018d8:	00088023          	sb	zero,0(a7)
    802018dc:	70a2                	ld	ra,40(sp)
    802018de:	6145                	addi	sp,sp,48
    802018e0:	8082                	ret
    802018e2:	fff3869b          	addiw	a3,t2,-1
    802018e6:	02069613          	slli	a2,a3,0x20
    802018ea:	02065813          	srli	a6,a2,0x20
    802018ee:	010588b3          	add	a7,a1,a6
    802018f2:	00088023          	sb	zero,0(a7)
    802018f6:	b7dd                	j	802018dc <vprintf_+0x5a>

00000000802018f8 <vsnprintf_>:
    802018f8:	7179                	addi	sp,sp,-48
    802018fa:	87aa                	mv	a5,a0
    802018fc:	f406                	sd	ra,40(sp)
    802018fe:	852e                	mv	a0,a1
    80201900:	4701                	li	a4,0
    80201902:	85b2                	mv	a1,a2
    80201904:	8636                	mv	a2,a3
    80201906:	cb81                	beqz	a5,80201916 <vsnprintf_+0x1e>
    80201908:	800006b7          	lui	a3,0x80000
    8020190c:	fff6c093          	not	ra,a3
    80201910:	872a                	mv	a4,a0
    80201912:	02a0e163          	bltu	ra,a0,80201934 <vsnprintf_+0x3c>
    80201916:	850a                	mv	a0,sp
    80201918:	e002                	sd	zero,0(sp)
    8020191a:	e402                	sd	zero,8(sp)
    8020191c:	e83e                	sd	a5,16(sp)
    8020191e:	cc02                	sw	zero,24(sp)
    80201920:	ce3a                	sw	a4,28(sp)
    80201922:	d60ff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    80201926:	6282                	ld	t0,0(sp)
    80201928:	00028863          	beqz	t0,80201938 <vsnprintf_+0x40>
    8020192c:	4562                	lw	a0,24(sp)
    8020192e:	70a2                	ld	ra,40(sp)
    80201930:	6145                	addi	sp,sp,48
    80201932:	8082                	ret
    80201934:	8706                	mv	a4,ra
    80201936:	b7c5                	j	80201916 <vsnprintf_+0x1e>
    80201938:	4372                	lw	t1,28(sp)
    8020193a:	4562                	lw	a0,24(sp)
    8020193c:	fe0309e3          	beqz	t1,8020192e <vsnprintf_+0x36>
    80201940:	63c2                	ld	t2,16(sp)
    80201942:	fe0386e3          	beqz	t2,8020192e <vsnprintf_+0x36>
    80201946:	85aa                	mv	a1,a0
    80201948:	00657d63          	bgeu	a0,t1,80201962 <vsnprintf_+0x6a>
    8020194c:	02059613          	slli	a2,a1,0x20
    80201950:	02065813          	srli	a6,a2,0x20
    80201954:	010388b3          	add	a7,t2,a6
    80201958:	00088023          	sb	zero,0(a7)
    8020195c:	70a2                	ld	ra,40(sp)
    8020195e:	6145                	addi	sp,sp,48
    80201960:	8082                	ret
    80201962:	fff3059b          	addiw	a1,t1,-1
    80201966:	02059613          	slli	a2,a1,0x20
    8020196a:	02065813          	srli	a6,a2,0x20
    8020196e:	010388b3          	add	a7,t2,a6
    80201972:	00088023          	sb	zero,0(a7)
    80201976:	b7dd                	j	8020195c <vsnprintf_+0x64>

0000000080201978 <vsprintf_>:
    80201978:	7179                	addi	sp,sp,-48
    8020197a:	00a036b3          	snez	a3,a0
    8020197e:	800007b7          	lui	a5,0x80000
    80201982:	f406                	sd	ra,40(sp)
    80201984:	fff7c293          	not	t0,a5
    80201988:	40d000b3          	neg	ra,a3
    8020198c:	872a                	mv	a4,a0
    8020198e:	0012f333          	and	t1,t0,ra
    80201992:	850a                	mv	a0,sp
    80201994:	e002                	sd	zero,0(sp)
    80201996:	e402                	sd	zero,8(sp)
    80201998:	e83a                	sd	a4,16(sp)
    8020199a:	cc02                	sw	zero,24(sp)
    8020199c:	ce1a                	sw	t1,28(sp)
    8020199e:	ce4ff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    802019a2:	6382                	ld	t2,0(sp)
    802019a4:	00038663          	beqz	t2,802019b0 <vsprintf_+0x38>
    802019a8:	4562                	lw	a0,24(sp)
    802019aa:	70a2                	ld	ra,40(sp)
    802019ac:	6145                	addi	sp,sp,48
    802019ae:	8082                	ret
    802019b0:	45f2                	lw	a1,28(sp)
    802019b2:	4562                	lw	a0,24(sp)
    802019b4:	d9fd                	beqz	a1,802019aa <vsprintf_+0x32>
    802019b6:	6642                	ld	a2,16(sp)
    802019b8:	da6d                	beqz	a2,802019aa <vsprintf_+0x32>
    802019ba:	882a                	mv	a6,a0
    802019bc:	00b57d63          	bgeu	a0,a1,802019d6 <vsprintf_+0x5e>
    802019c0:	02081893          	slli	a7,a6,0x20
    802019c4:	0208de13          	srli	t3,a7,0x20
    802019c8:	01c60eb3          	add	t4,a2,t3
    802019cc:	000e8023          	sb	zero,0(t4)
    802019d0:	70a2                	ld	ra,40(sp)
    802019d2:	6145                	addi	sp,sp,48
    802019d4:	8082                	ret
    802019d6:	fff5881b          	addiw	a6,a1,-1
    802019da:	02081893          	slli	a7,a6,0x20
    802019de:	0208de13          	srli	t3,a7,0x20
    802019e2:	01c60eb3          	add	t4,a2,t3
    802019e6:	000e8023          	sb	zero,0(t4)
    802019ea:	b7dd                	j	802019d0 <vsprintf_+0x58>

00000000802019ec <vfctprintf>:
    802019ec:	7179                	addi	sp,sp,-48
    802019ee:	800007b7          	lui	a5,0x80000
    802019f2:	88b2                	mv	a7,a2
    802019f4:	f406                	sd	ra,40(sp)
    802019f6:	fff7c093          	not	ra,a5
    802019fa:	882a                	mv	a6,a0
    802019fc:	872e                	mv	a4,a1
    802019fe:	02009293          	slli	t0,ra,0x20
    80201a02:	8636                	mv	a2,a3
    80201a04:	85c6                	mv	a1,a7
    80201a06:	850a                	mv	a0,sp
    80201a08:	e042                	sd	a6,0(sp)
    80201a0a:	e43a                	sd	a4,8(sp)
    80201a0c:	e802                	sd	zero,16(sp)
    80201a0e:	ec16                	sd	t0,24(sp)
    80201a10:	c72ff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    80201a14:	6302                	ld	t1,0(sp)
    80201a16:	00030663          	beqz	t1,80201a22 <vfctprintf+0x36>
    80201a1a:	4562                	lw	a0,24(sp)
    80201a1c:	70a2                	ld	ra,40(sp)
    80201a1e:	6145                	addi	sp,sp,48
    80201a20:	8082                	ret
    80201a22:	43f2                	lw	t2,28(sp)
    80201a24:	4562                	lw	a0,24(sp)
    80201a26:	fe038be3          	beqz	t2,80201a1c <vfctprintf+0x30>
    80201a2a:	65c2                	ld	a1,16(sp)
    80201a2c:	d9e5                	beqz	a1,80201a1c <vfctprintf+0x30>
    80201a2e:	86aa                	mv	a3,a0
    80201a30:	00757d63          	bgeu	a0,t2,80201a4a <vfctprintf+0x5e>
    80201a34:	02069613          	slli	a2,a3,0x20
    80201a38:	02065e13          	srli	t3,a2,0x20
    80201a3c:	01c58eb3          	add	t4,a1,t3
    80201a40:	000e8023          	sb	zero,0(t4)
    80201a44:	70a2                	ld	ra,40(sp)
    80201a46:	6145                	addi	sp,sp,48
    80201a48:	8082                	ret
    80201a4a:	fff3869b          	addiw	a3,t2,-1
    80201a4e:	02069613          	slli	a2,a3,0x20
    80201a52:	02065e13          	srli	t3,a2,0x20
    80201a56:	01c58eb3          	add	t4,a1,t3
    80201a5a:	000e8023          	sb	zero,0(t4)
    80201a5e:	b7dd                	j	80201a44 <vfctprintf+0x58>

0000000080201a60 <printf_>:
    80201a60:	7119                	addi	sp,sp,-128
    80201a62:	80000337          	lui	t1,0x80000
    80201a66:	04810e13          	addi	t3,sp,72
    80201a6a:	fc06                	sd	ra,56(sp)
    80201a6c:	fff34093          	not	ra,t1
    80201a70:	e4ae                	sd	a1,72(sp)
    80201a72:	e8b2                	sd	a2,80(sp)
    80201a74:	02009293          	slli	t0,ra,0x20
    80201a78:	85aa                	mv	a1,a0
    80201a7a:	f4be                	sd	a5,104(sp)
    80201a7c:	8672                	mv	a2,t3
    80201a7e:	fffff797          	auipc	a5,0xfffff
    80201a82:	82878793          	addi	a5,a5,-2008 # 802002a6 <putchar_wrapper>
    80201a86:	0808                	addi	a0,sp,16
    80201a88:	ecb6                	sd	a3,88(sp)
    80201a8a:	f0ba                	sd	a4,96(sp)
    80201a8c:	f8c2                	sd	a6,112(sp)
    80201a8e:	fcc6                	sd	a7,120(sp)
    80201a90:	e472                	sd	t3,8(sp)
    80201a92:	e83e                	sd	a5,16(sp)
    80201a94:	ec02                	sd	zero,24(sp)
    80201a96:	f002                	sd	zero,32(sp)
    80201a98:	f416                	sd	t0,40(sp)
    80201a9a:	be8ff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    80201a9e:	63c2                	ld	t2,16(sp)
    80201aa0:	00038663          	beqz	t2,80201aac <printf_+0x4c>
    80201aa4:	5522                	lw	a0,40(sp)
    80201aa6:	70e2                	ld	ra,56(sp)
    80201aa8:	6109                	addi	sp,sp,128
    80201aaa:	8082                	ret
    80201aac:	5732                	lw	a4,44(sp)
    80201aae:	5522                	lw	a0,40(sp)
    80201ab0:	db7d                	beqz	a4,80201aa6 <printf_+0x46>
    80201ab2:	7582                	ld	a1,32(sp)
    80201ab4:	d9ed                	beqz	a1,80201aa6 <printf_+0x46>
    80201ab6:	86aa                	mv	a3,a0
    80201ab8:	00e57d63          	bgeu	a0,a4,80201ad2 <printf_+0x72>
    80201abc:	02069613          	slli	a2,a3,0x20
    80201ac0:	02065813          	srli	a6,a2,0x20
    80201ac4:	010588b3          	add	a7,a1,a6
    80201ac8:	00088023          	sb	zero,0(a7)
    80201acc:	70e2                	ld	ra,56(sp)
    80201ace:	6109                	addi	sp,sp,128
    80201ad0:	8082                	ret
    80201ad2:	fff7069b          	addiw	a3,a4,-1
    80201ad6:	02069613          	slli	a2,a3,0x20
    80201ada:	02065813          	srli	a6,a2,0x20
    80201ade:	010588b3          	add	a7,a1,a6
    80201ae2:	00088023          	sb	zero,0(a7)
    80201ae6:	b7dd                	j	80201acc <printf_+0x6c>

0000000080201ae8 <sprintf_>:
    80201ae8:	7159                	addi	sp,sp,-112
    80201aea:	8e2a                	mv	t3,a0
    80201aec:	80000337          	lui	t1,0x80000
    80201af0:	00a03533          	snez	a0,a0
    80201af4:	04010e93          	addi	t4,sp,64
    80201af8:	fc06                	sd	ra,56(sp)
    80201afa:	fff34293          	not	t0,t1
    80201afe:	40a000b3          	neg	ra,a0
    80201b02:	e0b2                	sd	a2,64(sp)
    80201b04:	0012f3b3          	and	t2,t0,ra
    80201b08:	8676                	mv	a2,t4
    80201b0a:	0808                	addi	a0,sp,16
    80201b0c:	ecbe                	sd	a5,88(sp)
    80201b0e:	e4b6                	sd	a3,72(sp)
    80201b10:	e8ba                	sd	a4,80(sp)
    80201b12:	f0c2                	sd	a6,96(sp)
    80201b14:	f4c6                	sd	a7,104(sp)
    80201b16:	e476                	sd	t4,8(sp)
    80201b18:	e802                	sd	zero,16(sp)
    80201b1a:	ec02                	sd	zero,24(sp)
    80201b1c:	f072                	sd	t3,32(sp)
    80201b1e:	d402                	sw	zero,40(sp)
    80201b20:	d61e                	sw	t2,44(sp)
    80201b22:	b60ff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    80201b26:	67c2                	ld	a5,16(sp)
    80201b28:	c789                	beqz	a5,80201b32 <sprintf_+0x4a>
    80201b2a:	5522                	lw	a0,40(sp)
    80201b2c:	70e2                	ld	ra,56(sp)
    80201b2e:	6165                	addi	sp,sp,112
    80201b30:	8082                	ret
    80201b32:	5732                	lw	a4,44(sp)
    80201b34:	5522                	lw	a0,40(sp)
    80201b36:	db7d                	beqz	a4,80201b2c <sprintf_+0x44>
    80201b38:	7582                	ld	a1,32(sp)
    80201b3a:	d9ed                	beqz	a1,80201b2c <sprintf_+0x44>
    80201b3c:	86aa                	mv	a3,a0
    80201b3e:	00e57d63          	bgeu	a0,a4,80201b58 <sprintf_+0x70>
    80201b42:	02069613          	slli	a2,a3,0x20
    80201b46:	02065813          	srli	a6,a2,0x20
    80201b4a:	010588b3          	add	a7,a1,a6
    80201b4e:	00088023          	sb	zero,0(a7)
    80201b52:	70e2                	ld	ra,56(sp)
    80201b54:	6165                	addi	sp,sp,112
    80201b56:	8082                	ret
    80201b58:	fff7069b          	addiw	a3,a4,-1
    80201b5c:	02069613          	slli	a2,a3,0x20
    80201b60:	02065813          	srli	a6,a2,0x20
    80201b64:	010588b3          	add	a7,a1,a6
    80201b68:	00088023          	sb	zero,0(a7)
    80201b6c:	b7dd                	j	80201b52 <sprintf_+0x6a>

0000000080201b6e <snprintf_>:
    80201b6e:	7159                	addi	sp,sp,-112
    80201b70:	04810e13          	addi	t3,sp,72
    80201b74:	e8ba                	sd	a4,80(sp)
    80201b76:	ecbe                	sd	a5,88(sp)
    80201b78:	fc06                	sd	ra,56(sp)
    80201b7a:	e4b6                	sd	a3,72(sp)
    80201b7c:	f0c2                	sd	a6,96(sp)
    80201b7e:	f4c6                	sd	a7,104(sp)
    80201b80:	e472                	sd	t3,8(sp)
    80201b82:	872e                	mv	a4,a1
    80201b84:	832a                	mv	t1,a0
    80201b86:	85b2                	mv	a1,a2
    80201b88:	4781                	li	a5,0
    80201b8a:	c901                	beqz	a0,80201b9a <snprintf_+0x2c>
    80201b8c:	800000b7          	lui	ra,0x80000
    80201b90:	fff0c293          	not	t0,ra
    80201b94:	87ba                	mv	a5,a4
    80201b96:	02e2e263          	bltu	t0,a4,80201bba <snprintf_+0x4c>
    80201b9a:	8672                	mv	a2,t3
    80201b9c:	0808                	addi	a0,sp,16
    80201b9e:	e802                	sd	zero,16(sp)
    80201ba0:	ec02                	sd	zero,24(sp)
    80201ba2:	f01a                	sd	t1,32(sp)
    80201ba4:	d402                	sw	zero,40(sp)
    80201ba6:	d63e                	sw	a5,44(sp)
    80201ba8:	adaff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    80201bac:	63c2                	ld	t2,16(sp)
    80201bae:	00038863          	beqz	t2,80201bbe <snprintf_+0x50>
    80201bb2:	5522                	lw	a0,40(sp)
    80201bb4:	70e2                	ld	ra,56(sp)
    80201bb6:	6165                	addi	sp,sp,112
    80201bb8:	8082                	ret
    80201bba:	8796                	mv	a5,t0
    80201bbc:	bff9                	j	80201b9a <snprintf_+0x2c>
    80201bbe:	55b2                	lw	a1,44(sp)
    80201bc0:	5522                	lw	a0,40(sp)
    80201bc2:	d9ed                	beqz	a1,80201bb4 <snprintf_+0x46>
    80201bc4:	7602                	ld	a2,32(sp)
    80201bc6:	d67d                	beqz	a2,80201bb4 <snprintf_+0x46>
    80201bc8:	86aa                	mv	a3,a0
    80201bca:	00b57d63          	bgeu	a0,a1,80201be4 <snprintf_+0x76>
    80201bce:	02069813          	slli	a6,a3,0x20
    80201bd2:	02085893          	srli	a7,a6,0x20
    80201bd6:	01160eb3          	add	t4,a2,a7
    80201bda:	000e8023          	sb	zero,0(t4)
    80201bde:	70e2                	ld	ra,56(sp)
    80201be0:	6165                	addi	sp,sp,112
    80201be2:	8082                	ret
    80201be4:	fff5869b          	addiw	a3,a1,-1
    80201be8:	02069813          	slli	a6,a3,0x20
    80201bec:	02085893          	srli	a7,a6,0x20
    80201bf0:	01160eb3          	add	t4,a2,a7
    80201bf4:	000e8023          	sb	zero,0(t4)
    80201bf8:	b7dd                	j	80201bde <snprintf_+0x70>

0000000080201bfa <fctprintf>:
    80201bfa:	7159                	addi	sp,sp,-112
    80201bfc:	80000337          	lui	t1,0x80000
    80201c00:	8f32                	mv	t5,a2
    80201c02:	fc06                	sd	ra,56(sp)
    80201c04:	fff34093          	not	ra,t1
    80201c08:	8eaa                	mv	t4,a0
    80201c0a:	8e2e                	mv	t3,a1
    80201c0c:	00b0                	addi	a2,sp,72
    80201c0e:	02009293          	slli	t0,ra,0x20
    80201c12:	85fa                	mv	a1,t5
    80201c14:	0808                	addi	a0,sp,16
    80201c16:	ecbe                	sd	a5,88(sp)
    80201c18:	e4b6                	sd	a3,72(sp)
    80201c1a:	e8ba                	sd	a4,80(sp)
    80201c1c:	f0c2                	sd	a6,96(sp)
    80201c1e:	f4c6                	sd	a7,104(sp)
    80201c20:	e432                	sd	a2,8(sp)
    80201c22:	e876                	sd	t4,16(sp)
    80201c24:	ec72                	sd	t3,24(sp)
    80201c26:	f002                	sd	zero,32(sp)
    80201c28:	f416                	sd	t0,40(sp)
    80201c2a:	a58ff0ef          	jal	80200e82 <format_string_loop.constprop.0>
    80201c2e:	67c2                	ld	a5,16(sp)
    80201c30:	c789                	beqz	a5,80201c3a <fctprintf+0x40>
    80201c32:	5522                	lw	a0,40(sp)
    80201c34:	70e2                	ld	ra,56(sp)
    80201c36:	6165                	addi	sp,sp,112
    80201c38:	8082                	ret
    80201c3a:	5732                	lw	a4,44(sp)
    80201c3c:	5522                	lw	a0,40(sp)
    80201c3e:	db7d                	beqz	a4,80201c34 <fctprintf+0x3a>
    80201c40:	7382                	ld	t2,32(sp)
    80201c42:	fe0389e3          	beqz	t2,80201c34 <fctprintf+0x3a>
    80201c46:	86aa                	mv	a3,a0
    80201c48:	00e57d63          	bgeu	a0,a4,80201c62 <fctprintf+0x68>
    80201c4c:	02069593          	slli	a1,a3,0x20
    80201c50:	0205d613          	srli	a2,a1,0x20
    80201c54:	00c38833          	add	a6,t2,a2
    80201c58:	00080023          	sb	zero,0(a6)
    80201c5c:	70e2                	ld	ra,56(sp)
    80201c5e:	6165                	addi	sp,sp,112
    80201c60:	8082                	ret
    80201c62:	fff7069b          	addiw	a3,a4,-1
    80201c66:	02069593          	slli	a1,a3,0x20
    80201c6a:	0205d613          	srli	a2,a1,0x20
    80201c6e:	00c38833          	add	a6,t2,a2
    80201c72:	00080023          	sb	zero,0(a6)
    80201c76:	b7dd                	j	80201c5c <fctprintf+0x62>

0000000080201c78 <handle_trap>:
    80201c78:	02051793          	slli	a5,a0,0x20
    80201c7c:	0007c563          	bltz	a5,80201c86 <handle_trap+0xe>
    80201c80:	00458513          	addi	a0,a1,4
    80201c84:	8082                	ret
    80201c86:	852e                	mv	a0,a1
    80201c88:	8082                	ret

0000000080201c8a <set_msix_handler>:
    80201c8a:	8082                	ret

0000000080201c8c <handle_external_trap>:
    80201c8c:	1141                	addi	sp,sp,-16
    80201c8e:	e406                	sd	ra,8(sp)
    80201c90:	1f2000ef          	jal	80201e82 <imsic_get_irq>
    80201c94:	2501                	sext.w	a0,a0
    80201c96:	47a9                	li	a5,10
    80201c98:	00f50563          	beq	a0,a5,80201ca2 <handle_external_trap+0x16>
    80201c9c:	60a2                	ld	ra,8(sp)
    80201c9e:	0141                	addi	sp,sp,16
    80201ca0:	8082                	ret
    80201ca2:	60a2                	ld	ra,8(sp)
    80201ca4:	0141                	addi	sp,sp,16
    80201ca6:	d76fe06f          	j	8020021c <UartIsr>

0000000080201caa <putchar_>:
    80201caa:	c92fe06f          	j	8020013c <UartPutc>

0000000080201cae <imsic_get_addr>:
    80201cae:	00c5959b          	slliw	a1,a1,0xc
    80201cb2:	c511                	beqz	a0,80201cbe <imsic_get_addr+0x10>
    80201cb4:	280002b7          	lui	t0,0x28000
    80201cb8:	00558533          	add	a0,a1,t0
    80201cbc:	8082                	ret
    80201cbe:	240007b7          	lui	a5,0x24000
    80201cc2:	00f58533          	add	a0,a1,a5
    80201cc6:	8082                	ret

0000000080201cc8 <imsic_ipi_send>:
    80201cc8:	00c5959b          	slliw	a1,a1,0xc
    80201ccc:	c911                	beqz	a0,80201ce0 <imsic_ipi_send+0x18>
    80201cce:	28000337          	lui	t1,0x28000
    80201cd2:	006582b3          	add	t0,a1,t1
    80201cd6:	0ff00393          	li	t2,255
    80201cda:	0072b023          	sd	t2,0(t0) # 28000000 <__stack_size+0x27ff0000>
    80201cde:	8082                	ret
    80201ce0:	240007b7          	lui	a5,0x24000
    80201ce4:	00f582b3          	add	t0,a1,a5
    80201ce8:	0ff00393          	li	t2,255
    80201cec:	0072b023          	sd	t2,0(t0)
    80201cf0:	8082                	ret

0000000080201cf2 <imsic_enable>:
    80201cf2:	41f5d79b          	sraiw	a5,a1,0x1f
    80201cf6:	01b7d29b          	srliw	t0,a5,0x1b
    80201cfa:	00b285bb          	addw	a1,t0,a1
    80201cfe:	4055d31b          	sraiw	t1,a1,0x5
    80201d02:	01f5f713          	andi	a4,a1,31
    80201d06:	0c03061b          	addiw	a2,t1,192 # 280000c0 <__stack_size+0x27ff00c0>
    80201d0a:	405703bb          	subw	t2,a4,t0
    80201d0e:	4685                	li	a3,1
    80201d10:	02061893          	slli	a7,a2,0x20
    80201d14:	0076983b          	sllw	a6,a3,t2
    80201d18:	0208de13          	srli	t3,a7,0x20
    80201d1c:	cd11                	beqz	a0,80201d38 <imsic_enable+0x46>
    80201d1e:	150e1073          	csrw	siselect,t3
    80201d22:	151027f3          	csrr	a5,sireg
    80201d26:	0107e2b3          	or	t0,a5,a6
    80201d2a:	02029593          	slli	a1,t0,0x20
    80201d2e:	0205d713          	srli	a4,a1,0x20
    80201d32:	15171073          	csrw	sireg,a4
    80201d36:	8082                	ret
    80201d38:	350e1073          	csrw	miselect,t3
    80201d3c:	35102573          	csrr	a0,mireg
    80201d40:	01056eb3          	or	t4,a0,a6
    80201d44:	020e9f13          	slli	t5,t4,0x20
    80201d48:	020f5f93          	srli	t6,t5,0x20
    80201d4c:	351f9073          	csrw	mireg,t6
    80201d50:	8082                	ret

0000000080201d52 <imsic_disable>:
    80201d52:	41f5d79b          	sraiw	a5,a1,0x1f
    80201d56:	01b7d29b          	srliw	t0,a5,0x1b
    80201d5a:	00b285bb          	addw	a1,t0,a1
    80201d5e:	01f5f713          	andi	a4,a1,31
    80201d62:	4057033b          	subw	t1,a4,t0
    80201d66:	4385                	li	t2,1
    80201d68:	4055d69b          	sraiw	a3,a1,0x5
    80201d6c:	0063963b          	sllw	a2,t2,t1
    80201d70:	0c06889b          	addiw	a7,a3,192 # ffffffff800000c0 <_stack_top+0xfffffffeffdec0c0>
    80201d74:	fff64813          	not	a6,a2
    80201d78:	02089e93          	slli	t4,a7,0x20
    80201d7c:	00080e1b          	sext.w	t3,a6
    80201d80:	020edf13          	srli	t5,t4,0x20
    80201d84:	cd11                	beqz	a0,80201da0 <imsic_disable+0x4e>
    80201d86:	150f1073          	csrw	siselect,t5
    80201d8a:	151025f3          	csrr	a1,sireg
    80201d8e:	01c5f733          	and	a4,a1,t3
    80201d92:	02071313          	slli	t1,a4,0x20
    80201d96:	02035393          	srli	t2,t1,0x20
    80201d9a:	15139073          	csrw	sireg,t2
    80201d9e:	8082                	ret
    80201da0:	350f1073          	csrw	miselect,t5
    80201da4:	35102573          	csrr	a0,mireg
    80201da8:	01c57fb3          	and	t6,a0,t3
    80201dac:	020f9793          	slli	a5,t6,0x20
    80201db0:	0207d293          	srli	t0,a5,0x20
    80201db4:	35129073          	csrw	mireg,t0
    80201db8:	8082                	ret

0000000080201dba <imsic_trigger>:
    80201dba:	41f5d79b          	sraiw	a5,a1,0x1f
    80201dbe:	01b7d29b          	srliw	t0,a5,0x1b
    80201dc2:	00b285bb          	addw	a1,t0,a1
    80201dc6:	4055d31b          	sraiw	t1,a1,0x5
    80201dca:	01f5f713          	andi	a4,a1,31
    80201dce:	0803061b          	addiw	a2,t1,128
    80201dd2:	405703bb          	subw	t2,a4,t0
    80201dd6:	4685                	li	a3,1
    80201dd8:	02061893          	slli	a7,a2,0x20
    80201ddc:	0076983b          	sllw	a6,a3,t2
    80201de0:	0208de13          	srli	t3,a7,0x20
    80201de4:	cd11                	beqz	a0,80201e00 <imsic_trigger+0x46>
    80201de6:	150e1073          	csrw	siselect,t3
    80201dea:	151027f3          	csrr	a5,sireg
    80201dee:	0107e2b3          	or	t0,a5,a6
    80201df2:	02029593          	slli	a1,t0,0x20
    80201df6:	0205d713          	srli	a4,a1,0x20
    80201dfa:	15171073          	csrw	sireg,a4
    80201dfe:	8082                	ret
    80201e00:	350e1073          	csrw	miselect,t3
    80201e04:	35102573          	csrr	a0,mireg
    80201e08:	01056eb3          	or	t4,a0,a6
    80201e0c:	020e9f13          	slli	t5,t4,0x20
    80201e10:	020f5f93          	srli	t6,t5,0x20
    80201e14:	351f9073          	csrw	mireg,t6
    80201e18:	8082                	ret

0000000080201e1a <imsic_clear>:
    80201e1a:	41f5d79b          	sraiw	a5,a1,0x1f
    80201e1e:	01b7d29b          	srliw	t0,a5,0x1b
    80201e22:	00b285bb          	addw	a1,t0,a1
    80201e26:	01f5f713          	andi	a4,a1,31
    80201e2a:	4057033b          	subw	t1,a4,t0
    80201e2e:	4385                	li	t2,1
    80201e30:	4055d69b          	sraiw	a3,a1,0x5
    80201e34:	0063963b          	sllw	a2,t2,t1
    80201e38:	0806889b          	addiw	a7,a3,128
    80201e3c:	fff64813          	not	a6,a2
    80201e40:	02089e93          	slli	t4,a7,0x20
    80201e44:	00080e1b          	sext.w	t3,a6
    80201e48:	020edf13          	srli	t5,t4,0x20
    80201e4c:	cd11                	beqz	a0,80201e68 <imsic_clear+0x4e>
    80201e4e:	150f1073          	csrw	siselect,t5
    80201e52:	151025f3          	csrr	a1,sireg
    80201e56:	01c5f733          	and	a4,a1,t3
    80201e5a:	02071313          	slli	t1,a4,0x20
    80201e5e:	02035393          	srli	t2,t1,0x20
    80201e62:	15139073          	csrw	sireg,t2
    80201e66:	8082                	ret
    80201e68:	350f1073          	csrw	miselect,t5
    80201e6c:	35102573          	csrr	a0,mireg
    80201e70:	01c57fb3          	and	t6,a0,t3
    80201e74:	020f9793          	slli	a5,t6,0x20
    80201e78:	0207d293          	srli	t0,a5,0x20
    80201e7c:	35129073          	csrw	mireg,t0
    80201e80:	8082                	ret

0000000080201e82 <imsic_get_irq>:
    80201e82:	c509                	beqz	a0,80201e8c <imsic_get_irq+0xa>
    80201e84:	15c05573          	csrrwi	a0,stopei,0
    80201e88:	8141                	srli	a0,a0,0x10
    80201e8a:	8082                	ret
    80201e8c:	35c05573          	csrrwi	a0,mtopei,0
    80201e90:	8141                	srli	a0,a0,0x10
    80201e92:	8082                	ret

0000000080201e94 <imsic_init>:
    80201e94:	07000793          	li	a5,112
    80201e98:	35079073          	csrw	miselect,a5
    80201e9c:	3510d073          	csrwi	mireg,1
    80201ea0:	15079073          	csrw	siselect,a5
    80201ea4:	1510d073          	csrwi	sireg,1
    80201ea8:	07200293          	li	t0,114
    80201eac:	35029073          	csrw	miselect,t0
    80201eb0:	35105073          	csrwi	mireg,0
    80201eb4:	15029073          	csrw	siselect,t0
    80201eb8:	15105073          	csrwi	sireg,0
    80201ebc:	8082                	ret
