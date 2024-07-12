#include "riscv.h"
#include "riscv-virt.h"
#include "printf/printf.h"
#include "aplic.h"
#include "imsic.h"
#include "ns16550.h"
#include "pcie/pci.h"
// #include "virtio-pci-net.h"
#include "virtio/virtio-pci-rng.h"
// #include "virtio-pci-blk.h"

// void virtio_pci_net_test(void);
void virtio_pci_rng_test(void);
// void virtio_pci_blk_test(void);

int version = 20240711;
char *hello = "Hello, qemu and risc-v!";

int main( void )
{	
	// 初始化平台设备 (包含uart & plic)
	plt_virt_init();

	printf(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
	printf("  version is: %d\n", version);
	printf("  %s\n", hello);
	printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");

	// pci_rng_test
	virtio_pci_rng_test();
	// virtio_pci_blk_test();
	// virtio_pci_net_test();

	printf("All aaplication done!\n");
	while(1) ;
	
	return 0;
}

// void virtio_pci_net_test(void)
// {
// 	int r = virtio_pci_net_init();
// 	printf("r: %d\n", r);
// 	if (r < 0) return;

// 	u8 buf[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0x08, 0x06, 0x00, 0x01,
// 			    0x08, 0x00, 0x06, 0x04, 0x00, 0x01, 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0x00, 0x00, 0x00, 0x00,
// 	            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xa8, 0x01, 0x64 };
// 	printf("buf: %p\n", buf);
// 	for (int i = 0; i < 16; ++i) {
// 		r = virtio_pci_net_tx(buf, sizeof(buf));
// 		//printf("r: %d\n", r);
// 	}
// 	printf("done\n");

// 	// u8 buf2[VIRTIO_NET_PKT_LEN] = { 0 };
// 	// for (int i = 0; i < 16; ++i) {
// 	// 	virtio_pci_net_rx(buf2);
// 	// }
// }

void virtio_pci_rng_test(void)
{
	int r = virtio_pci_rng_init();
	printf("r: %d\n", r);

	u32 buf[4] = { 0 };

	for (int n = 0; n < 16; ++n){
		printf("==== %d ====\n", n);
		int rlen = virtio_pci_rng_read((u8 *)buf, sizeof(buf));
		(void)rlen;
		//printf("rlen: %d\n", rlen);

		for (int i = 0; i < sizeof(buf)/sizeof(buf[0]); i += 4) {
			printf("0x%08x 0x%08x 0x%08x 0x%08x\n", buf[i], buf[i+1], buf[i+2], buf[i+3]);
		}

		for (int i = 0; i < sizeof(buf)/sizeof(buf[0]); ++i) {
			buf[i] = 0;
		}
	}

	printf("virtio-pci-rng test passed!\n");
}

// #define DATA_LEN	(SECTOR_SZIE*2)
// #define TEST_CNT  	(16) //(64*1024*1024/DATA_LEN) // 64MB
// void virtio_pci_blk_test(void)
// {
// 	int r = virtio_pci_blk_init();
// 	printf("r: %d\n", r);

// 	u8 buf[DATA_LEN] = { 0 };
// 	int dlen = DATA_LEN;
// 	for (int i = 0; i < dlen; ++i) {
// 		buf[i] = i;
// 	}

// 	struct blk_buf req = { 0 };
// 	printf("blk test...\n");
// 	for (int n = 0; n < TEST_CNT; ++n) {
// 		printf("==== n: %d ====\n", n);
// 		// blk write
// 		req.addr = n * dlen;
// 		req.data = buf;
// 		req.data_len = dlen;
// 		req.is_write = 1;
// 		virtio_pci_blk_rw(&req);

// 		// reset buf
// 		for (int i = 0; i < dlen; ++i) {
// 			buf[i] = 0;
// 		}

// 		// blk read
// 		req.addr = 0;
// 		req.data = buf;
// 		req.data_len = dlen;
// 		req.is_write = 0;
// 		virtio_pci_blk_rw(&req);

// 		// check read data
// 		for (int j = 0; j < dlen; ++j) {
// 			if (buf[j] != (u8)j) {
// 				//printf("buf[%d] = %d\n", j, buf[j]);
// 				printf("blk write or read failed\n");
// 				return;
// 			}
// 		}
// 	}

// 	printf("passed!\n");
// }
