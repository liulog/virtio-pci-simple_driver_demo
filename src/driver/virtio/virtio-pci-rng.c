#include "riscv.h"
#include "aplic.h"
#include "pcie/pci.h"
#include "virtio.h"
#include "virtio-ring.h"
#include "virtio-pci.h"
#include "virtio-rng.h"
#include "virtio-pci-rng.h"
#include "printf/printf.h"
#include <string.h>

// 3 buffer: avail ring(driver), used ring(device), desc
static u8 gs_rng_buf[3*4096] __attribute__((aligned(4096))) = { 0 };
static virtio_pci_hw_t gs_virtio_rng_hw = { 0 };
static struct virtio_rng gs_virtio_rng = { 0 };
static trap_handler_fn gs_rng_msix_handler[] = {
    virtio_pci_rng_cfg_isr,
    virtio_pci_rng_intr 
};

int virtio_pci_rng_init(void)
{
    // Probe where the device is (according to vendor id and device id).
    // Note: BARs are configured during pci_device_probe.
    u64 pci_base = pci_device_probe(0x1af4, 0x1044);

    // Print device info.
	if (pci_base) {
        virtio_pci_read_caps(&gs_virtio_rng_hw, pci_base, gs_rng_msix_handler);
		virtio_pci_print_common_cfg(&gs_virtio_rng_hw);
	} else {
        printf("virtion-rng-pci device not found!\n");
        return -1;
    }

    // Below is the standard Virtio device initialization sequence.
    // 1. reset device
    virtio_pci_set_status(&gs_virtio_rng_hw, 0);

    u8 status = 0;
    // 2. set ACKNOWLEDGE status bit
    status |= VIRTIO_STAT_ACKNOWLEDGE;
    virtio_pci_set_status(&gs_virtio_rng_hw, status);

    // 3. set DRIVER status bit
    status |= VIRTIO_STAT_DRIVER;
    virtio_pci_set_status(&gs_virtio_rng_hw, status);

    // 4. negotiate features
    u64 features = virtio_pci_get_device_features(&gs_virtio_rng_hw);
    printf("device features: 0x%016llx\n", features);    
    // driver doesn't support event idx, used for optimization about notification
    features &= ~(1 << VIRTIO_F_EVENT_IDX);
    // driver doesn't support indirect desc
    features &= ~(1 << VIRTIO_F_INDIRECT_DESC);
    printf("driver features: 0x%016llx\n", features);
    virtio_pci_set_driver_features(&gs_virtio_rng_hw, features);

    // 5. tell device that feature negotiation is complete.
    status |= VIRTIO_STAT_FEATURES_OK;
    virtio_pci_set_status(&gs_virtio_rng_hw, status);

    // 6. re-read status to ensure FEATURES_OK is set.
    status = virtio_pci_get_status(&gs_virtio_rng_hw);
    if(!(status & VIRTIO_STAT_FEATURES_OK)) {
        printf("virtio rng FEATURES_OK unset");
        return -2;
    }

    // 7. initialize queue 0.
    int qnum = 0;
    int qsize = 8;  // Here, driver will try to configure queue size to 8.

    // ensure queue 0 is not in use.
    if (virtio_pci_get_queue_enable(&gs_virtio_rng_hw, qnum)) {
        printf("virtio rng should not be ready");
        return -3;
    }

    // check maximum queue size.
    u16 max = virtio_pci_get_queue_size(&gs_virtio_rng_hw, qnum);
    printf("queue_0 max size: %d\n", max);
    if(max == 0){
        printf("virtio rng has no queue 0");
        return -4;
    }
    if(max < qsize){
        printf("virtio rng max queue too short");
        return -5;
    }
    gs_virtio_rng.qsize = (u32)max;

    // initialize vring
    int r = virtio_vring_init(&gs_virtio_rng.vr, gs_rng_buf, sizeof(gs_rng_buf), qsize, qnum);
    if (r) {
        printf("virtio_vring_init failed1: %d\n", r);
        return r;
    }

    // (1) set queue size.
    virtio_pci_set_queue_size(&gs_virtio_rng_hw, qnum, qsize);
    // (2) disable msix.
    virtio_pci_disable_config_msix(&gs_virtio_rng_hw);
    virtio_pci_disable_queue_msix(&gs_virtio_rng_hw, qnum);
    // (3) write physical addresses (desc table, avail ring, used ring).
    virtio_pci_set_queue_addr(&gs_virtio_rng_hw, qnum, &gs_virtio_rng.vr);
    // (4) queue is ready.
    virtio_pci_set_queue_enable(&gs_virtio_rng_hw, qnum);

    // 8. tell device we're completely ready.
    status |= VIRTIO_STAT_DRIVER_OK;
    virtio_pci_set_status(&gs_virtio_rng_hw, status);

    return 0;
}

int virtio_pci_rng_read(u8 *buf, int len)
{
    int qnum = 0;
    struct virtio_rng *rng = &gs_virtio_rng;
    
    // Get available descriptor index (here use simple ring)
    // TODO: optimize vring management
    // here just avail_ring idx == descriptor_table idx for virtio-pci-rng
    int idx = rng->avail_idx++ % rng->vr.size;
    
    printf("buf: %p, len: %d\n", buf, len);
    printf("idx: %d, avail: %d, used_idx: %d, used->idx: %d\n",
        idx, rng->vr.avail->idx, rng->used_idx, rng->vr.used->idx);

    // fill descriptor: rng buf
    virtio_vring_fill_desc(rng->vr.desc + idx, (u64)buf, len, VRING_DESC_F_WRITE, 0);
    // fill avail ring
    virtio_vring_add_avail(rng->vr.avail, idx, rng->vr.size);
    // notify device to process
    virtio_pci_set_queue_notify(&gs_virtio_rng_hw, qnum);

    // rng->used_idx, recorded by driver
    volatile u16 *pt_used_idx = &rng->used_idx;
    // vr.used->idx, updated by device afer device process done
    volatile u16 *pt_idx = &rng->vr.used->idx;
    
    // pt_used_idx == pt_idx means device has not processed yet
    // Here only one request is sent each time.
    while (*pt_used_idx == *pt_idx) ;

    int rlen = rng->vr.used->ring[rng->used_idx % rng->vr.size].len;
    // update used_idx, used for polling to check whether device has processed done
    rng->used_idx += 1;
    return rlen;
}

int virtio_pci_rng_cfg_isr(int irq)
{
    printf("virtio-rng cfg: %d\n", irq);
    return 0;
}

int virtio_pci_rng_intr(int irq)
{
    printf("virtio-rng isr: %d\n", irq);
    return 0;
}