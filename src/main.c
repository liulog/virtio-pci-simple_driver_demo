#include "riscv.h"
#include "riscv-virt.h"
#include "printf/printf.h"
// #include "aplic.h"
// #include "imsic.h"
// #include "plic.h"
#include "ns16550.h"
#include "pcie/pci.h"
#include "virtio/virtio-pci-rng.h"
#include "virtio/virtio-pci-blk.h"
#include <string.h>

#define DATA_LEN	(SECTOR_SZIE * 2)
#define TEST_CNT  	(16)    // (64*1024*1024/DATA_LEN)

void virtio_pci_rng_test(void);
void virtio_pci_blk_test(void);
void virtio_pci_blk_test2(void);

// Information
int version = 20251231;
char *hello = "Hello, qemu and risc-v!";
// Virtio-blk test data buffer
static u8 read_buf[DATA_LEN] = { 0 };

int main(void)
{
	plt_virt_init();

	printf(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n");
	printf("  version is: %d\n", version);
	printf("  %s\n\n", hello);
	printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
	printf("\n	Begin Test:\n\n");

	// pci_rng_test
	printf(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
	printf("virtio pci rng test:\n");
	virtio_pci_rng_test();
	printf(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
	printf("virtio pci blk test:\n");

	// pci_blk_test
	// virtio_pci_blk_test();
	printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
	
	virtio_pci_blk_test2();

	printf("\nAll tests done!\n");
	
    shutdown(0);

	return 0;
}

void virtio_pci_rng_test(void)
{
    // Initialize the virtio-pci-rng device
	int r = virtio_pci_rng_init();
	printf("r: %d\n", r);
	u64 buf[4] = { 0 };
	for (int n = 0; n < 16; ++n){
		printf("==== %d ====\n", n);
		int rlen = virtio_pci_rng_read((u8 *)buf, sizeof(buf));
		printf("rlen: %d\n", rlen);
		for (int i = 0; i < sizeof(buf)/sizeof(buf[0]); i += 4) {
			printf("0x%016llx 0x%016llx 0x%016llx 0x%016llx\n", buf[i], buf[i+1], buf[i+2], buf[i+3]);
		}
		for (int i = 0; i < sizeof(buf)/sizeof(buf[0]); ++i) {
			buf[i] = 0;
		}
	}
	printf("virtio-pci-rng test passed!\n");
}

void *memset(void *s, int c, size_t n) {
    unsigned char *p = s;
    while (n--) {
        *p++ = (unsigned char)c;
    }
    return s;
}


void virtio_pci_blk_test(void)
{
	int r = virtio_pci_blk_init();
	printf("r: %d\n", r);

	if(r!=0){ return; }

	int dlen = DATA_LEN;
	for (int i = 0; i < dlen; ++i) {		// dlen = DATA_LEN = 512 * 2
		read_buf[i] = i;
	}
	struct blk_buf req = { 0 };
	printf("blk test...\n");
	for (int n = 0; n < TEST_CNT; ++n) {
		printf("==== n: %d ====\n", n);
		// blk write
		req.addr = n * dlen;				// blk write addr
		req.data = read_buf;						// buffer addr
		req.data_len = dlen;				// buffer len
		req.is_write = 1;					// 向磁盘写入
		virtio_pci_blk_rw(&req);
		
		memset(read_buf, 0, dlen);

		// blk read
		req.addr = n * dlen;				// blk read addr
		req.data = read_buf;						// buffer addr
		req.data_len = dlen;				// buffer len
		req.is_write = 0;					// 从磁盘读取
		virtio_pci_blk_rw(&req);
		// check read data
		for (int j = 0; j < dlen; ++j) {
			if (read_buf[j] != (u8)j) {
				//printf("buf[%d] = %d\n", j, buf[j]);
				printf("blk write or read failed\n");
				return;
			}
		}
	}

	printf("passed!\n");
}

void virtio_pci_blk_test2(){
	int r = virtio_pci_blk_init();	// 注意: 不要重复初始化!
	printf("r: %d\n", r);

	if(r!=0){ return; }

	int dlen = DATA_LEN / 2;		// 读一部分打印出来
	memset(read_buf, 0, dlen);

	struct blk_buf req = { 0 };

	// blk read
	req.addr = 0;						// blk read addr
	req.data = read_buf;				// buffer addr
	req.data_len = dlen;				// buffer len
	req.is_write = 0;					// 从磁盘读取

	virtio_pci_blk_rw(&req);
	
	// check read data
	for (int j = 0; j < dlen; ++j) {
		if(j % 16 == 0) printf("\n");
        printf("%02x\t", read_buf[j]);
    }
}