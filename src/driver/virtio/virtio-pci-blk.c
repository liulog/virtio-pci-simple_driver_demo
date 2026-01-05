#include "riscv.h"
#include "trap-handler.h"
// #include "aplic.h"
// #include "imsic.h"
#include "plic.h"
#include "pcie/pci.h"
#include "virtio.h"
#include "virtio-ring.h"
#include "virtio-pci.h"
#include "virtio-blk.h"
#include "virtio-pci-blk.h"
#include "printf/printf.h"
#include <string.h>

// vring buffer
static u8 gs_blk_buf[3*4096] __attribute__((aligned(4096))) = { 0 };
static virtio_pci_hw_t gs_virtio_blk_hw = { 0 };
static struct virtio_blk gs_virtio_blk = { 0 };
static trap_handler_fn gs_blk_msix_handler[] = {
    virtio_pci_blk_cfg_isr,
    virtio_pci_blk_intr };

int virtio_pci_blk_init(void)
{
    // Probe device, here modern virtio-pci device id is 0x1042.
    u64 pci_base = pci_device_probe(0x1af4, 0x1042);

    if (pci_base) {
		virtio_pci_read_caps(&gs_virtio_blk_hw, pci_base, gs_blk_msix_handler);
		virtio_pci_print_common_cfg(&gs_virtio_blk_hw);
	} else {
        printf("virtion-blk-pci device not found!\n");
        return -1;
    }

    // 1. reset device
    virtio_pci_set_status(&gs_virtio_blk_hw, 0);

    u8 status = 0;
    // 2. set ACKNOWLEDGE status bit
    status |= VIRTIO_STAT_ACKNOWLEDGE;
    virtio_pci_set_status(&gs_virtio_blk_hw, status);

    // 3. set DRIVER status bit
    status |= VIRTIO_STAT_DRIVER;
    virtio_pci_set_status(&gs_virtio_blk_hw, status);

    // 4. negotiate features
    u64 features = virtio_pci_get_device_features(&gs_virtio_blk_hw);
    printf("device features: 0x%016llx\n", features);
    features &= ~(1 << VIRTIO_BLK_F_RO);
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    features &= ~(1 << VIRTIO_BLK_F_FLUSH);
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    features &= ~(1 << VIRTIO_F_EVENT_IDX);
    features &= ~(1 << VIRTIO_F_INDIRECT_DESC);
    printf("driver features: 0x%016llx\n", features);
    virtio_pci_set_driver_features(&gs_virtio_blk_hw, features);

    // 5. tell device that feature negotiation is complete.
    status |= VIRTIO_STAT_FEATURES_OK;
    virtio_pci_set_status(&gs_virtio_blk_hw, status);

    // 6. re-read status to ensure FEATURES_OK is set.
    status = virtio_pci_get_status(&gs_virtio_blk_hw);
    if(!(status & VIRTIO_STAT_FEATURES_OK)) {
        printf("virtio disk FEATURES_OK unset");
        return -2;
    }

    // 7. initialize queue 0.
    int qnum = 0;
    int qsize = BLK_QSIZE;
    // ensure queue 0 is not in use.
    if (virtio_pci_get_queue_enable(&gs_virtio_blk_hw, qnum)) {
        printf("virtio disk should not be ready");
        return -3;
    }

    // check maximum queue size.
    u32 max = virtio_pci_get_queue_size(&gs_virtio_blk_hw, qnum);
    printf("queue_0 max size: %d\n", max);
    if(max == 0){
        printf("virtio disk has no queue 0");
        return -4;
    }
    if(max < qsize){
        printf("virtio disk max queue too short");
        return -5;
    }
    gs_virtio_blk.qsize = max;

    // initialize vring.
    int r = virtio_vring_init(&gs_virtio_blk.vr, gs_blk_buf, sizeof(gs_blk_buf), qsize, qnum);
    if (r) {
        printf("virtio_vring_init failed: %d\n", r);
        return r;
    }

    // (1) set queue size.
    virtio_pci_set_queue_size(&gs_virtio_blk_hw, qnum, qsize);
    // (2) disable msix / enable msix
    // virtio_pci_set_config_msix(&gs_virtio_blk_hw, 0);
    // virtio_pci_set_queue_msix(&gs_virtio_blk_hw, qnum, 1);
    virtio_pci_disable_config_msix(&gs_virtio_blk_hw);
    virtio_pci_disable_queue_msix(&gs_virtio_blk_hw, qnum);
    // (3) write physical addresses.
    virtio_pci_set_queue_addr(&gs_virtio_blk_hw, qnum, &gs_virtio_blk.vr);
    // (4) queue is ready.
    virtio_pci_set_queue_enable(&gs_virtio_blk_hw, qnum);

    // 8. tell device we're completely ready.
    status |= VIRTIO_STAT_DRIVER_OK;
    virtio_pci_set_status(&gs_virtio_blk_hw, status);

    virtio_pci_blk_cfg();

    // enable interrupts for blk
    // aplic_enable_irq(APLIC_SUPERVISOR, APLIC_DM_MSI, APLIC_PCIE0_IRQ, 1);
	// imsic_enable(APLIC_SUPERVISOR, APLIC_PCIE0_IRQ);
    plic_enable(PCIE_IRQ_PINB);  // Due to its dev_id is 1 (group1), so here is pinB
    return 0;
}

void virtio_pci_blk_cfg(void)
{
    // read blk cfg from device configuration space
    struct virtio_blk_cfg *cfg = (struct virtio_blk_cfg *)gs_virtio_blk_hw.device_cfg;

    gs_virtio_blk.capacity = cfg->capacity;
    printf("virtio-blk-pci device config:\n");
    printf("    capacity: %lld\n", cfg->capacity);  // 131072 * 512 = 64M
    printf("    size_max: %d\n", cfg->size_max);    // 0: means for single operation I/O bytes is no limit
    printf("    seg_max: %d\n", cfg->seg_max);      // 254: max 254 segments per request
    printf("    geometry.cylinders: %d\n", cfg->geometry.cylinders);    // traditional CHS geometry
    printf("    geometry.heads: %d\n", cfg->geometry.heads);            // cylinders * heads * sectors = capacity
    printf("    geometry.sectors: %d\n", cfg->geometry.sectors);
    printf("    blk_size: %d\n", cfg->blk_size);    // 512: block size in bytes
}

void virtio_pci_blk_rw(struct blk_buf *b)
{
    int idx[3];
    int qnum = 0;
    u64 sector = b->addr / SECTOR_SZIE;                     // calculate start sector number
    struct virtio_blk *blk = &gs_virtio_blk;
    u64 sector_end = (b->addr + b->data_len) / SECTOR_SZIE; // calculate end sector number

    if (sector_end > blk->capacity) {
        printf("virtio_blk_rw: invalid data length!\n");
        return;
    }

    for (int i = 0; i < 3; ++i) {
        idx[i] = blk->avail_idx++ % blk->vr.size;   // Get available descriptor index, here according to avail_idx
    }

    struct virtio_blk_req *req = &blk->ops[idx[0]]; // Fill blk request header
    req->type = b->is_write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;   // Read or Write
    req->reserved = 0;
    req->sector = sector;   // Start sector number

    // (1) fill descriptor: blk request header
    virtio_vring_fill_desc(blk->vr.desc + idx[0], (u64)req, sizeof(struct virtio_blk_req),
            VRING_DESC_F_NEXT, idx[1]);
    // (2) fill descriptor: blk data
    virtio_vring_fill_desc(blk->vr.desc + idx[1], (u64)(b->data), b->data_len,
            (b->is_write ? 0 : VRING_DESC_F_WRITE) | VRING_DESC_F_NEXT, idx[2]);
    // (3) fill descriptor: blk request status
    blk->status[idx[0]] = 0xff;                                     // device writes 0 on success
    virtio_vring_fill_desc(blk->vr.desc + idx[2], (u64)(&blk->status[idx[0]]), 1,
            VRING_DESC_F_WRITE, 0);

    // set blk flag
    b->flag = 1;
    blk->info[idx[0]] = b;

    virtio_vring_add_avail(blk->vr.avail, idx[0], blk->vr.size);
    printf("virtio_blk_rw waiting, b: %p ...\n", b);
    virtio_pci_set_queue_notify(&gs_virtio_blk_hw, qnum);

    // example 1: PLIC
    volatile u16 *pflag = &b->flag;
    // wait cmd done, blk intr will set b->flag = 0
    while (*pflag == 1) ;

    // example2: polling
    // volatile u16 *pt_used_idx = &blk->used_idx;
    // volatile u16 *pt_idx = &blk->vr.used->idx;
    // wait cmd done
    // while (*pt_used_idx == *pt_idx) ;
    // blk->used_idx += 1;

    blk->info[idx[0]] = NULL;   // is done, clear info
}

int virtio_pci_blk_cfg_isr(int irq)
{
    printf("virtio-blk cfg: %d\n", irq);
    return 0;
}

int virtio_pci_blk_intr(int irq)
{
    struct virtio_blk *blk = &gs_virtio_blk;
    virtio_pci_clear_isr(&gs_virtio_blk_hw);

    dsb();
    // blk->used_idx indicate the next used index to be processed
    // blk->vr.used->idx indicate the used index from device
    while (blk->used_idx != blk->vr.used->idx) {
        int id = blk->vr.used->ring[blk->used_idx % BLK_QSIZE].id;
        printf("virtio_blk_intr id: %d, status: 0x%02x\n", id, blk->status[id]);
        // blk->status[id] == 0 means success
        if (blk->status[id] != 0) {
            printf("virtio_pci_blk_intr status: %d\n", blk->status[id]);
        }

        struct blk_buf *b = blk->info[id];
        //printf("virtio_blk_intr b: %p\n", b);
        b->flag = 0;    // set flag to 0, indicate cmd is done
        blk->used_idx += 1;
        dsb();
        //printf("virtio_blk_intr b->flag: %d\n", b->flag);
    }
    return 0;
}