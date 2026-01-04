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
    // 在 PCI 总线上 探测设备
    u64 pci_base = pci_device_probe(0x1af4, 0x1042);
	
    // 获取 PCI 设备的能力信息, 遍历 Capability List (其中 common config 很重要)
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

    // 初始化 vring 相关
    int r = virtio_vring_init(&gs_virtio_blk.vr, gs_blk_buf, sizeof(gs_blk_buf), qsize, qnum);
    if (r) {
        printf("virtio_vring_init failed: %d\n", r);
        return r;
    }

    // 根据 vring 等初始化的内容进行配置
    // (1) set queue size.
    virtio_pci_set_queue_size(&gs_virtio_blk_hw, qnum, qsize);
    // (2) disable msix / enable msix
    // virtio_pci_set_config_msix(&gs_virtio_blk_hw, 0);
    // virtio_pci_set_queue_msix(&gs_virtio_blk_hw, qnum, 1);
    // virtio_pci_disable_config_msix(&gs_virtio_blk_hw);              // config 需要一个中断
    // virtio_pci_disable_queue_msix(&gs_virtio_blk_hw, qnum);         // 每个 virtqueue 需要一个中断
    // (3) write physical addresses.
    virtio_pci_set_queue_addr(&gs_virtio_blk_hw, qnum, &gs_virtio_blk.vr);
    // (4) queue is ready.
    virtio_pci_set_queue_enable(&gs_virtio_blk_hw, qnum);

    // 8. tell device we're completely ready.
    status |= VIRTIO_STAT_DRIVER_OK;
    virtio_pci_set_status(&gs_virtio_blk_hw, status);

    // 从 device_config
    virtio_pci_blk_cfg();

    // 开启中断
	// aplic_enable_irq(APLIC_SUPERVISOR, APLIC_DM_MSI, APLIC_PCIE0_IRQ, 1);
	// imsic_enable(APLIC_SUPERVISOR, APLIC_PCIE0_IRQ);
    plic_enable(PCIE_IRQ);
    return 0;
}

void virtio_pci_blk_cfg(void)
{
    // 从 device config 中打印一些信息:
    struct virtio_blk_cfg *cfg = (struct virtio_blk_cfg *)gs_virtio_blk_hw.device_cfg;

    gs_virtio_blk.capacity = cfg->capacity;
    printf("    capacity: %lld\n", cfg->capacity);      // 以 sector(512B) 为单位   ->  64MB（和设备的大小一致）
    printf("    size_max: %d\n", cfg->size_max);
    printf("    seg_max: %d\n", cfg->seg_max);
    printf("    geometry.cylinders: %d\n", cfg->geometry.cylinders);
    printf("    geometry.heads: %d\n", cfg->geometry.heads);
    printf("    geometry.sectors: %d\n", cfg->geometry.sectors);
    printf("    blk_size: %d\n", cfg->blk_size);
}

void virtio_pci_blk_rw(struct blk_buf *b)
{
    int idx[3];
    int qnum = 0;
    u64 sector = b->addr / SECTOR_SZIE;                     // 第一个 sector
    struct virtio_blk *blk = &gs_virtio_blk;
    u64 sector_end = (b->addr + b->data_len) / SECTOR_SZIE; // 最后一个 sector

    if (sector_end > blk->capacity) {
        printf("virtio_blk_rw: invalid data length!\n");
        return;
    }

    // 实际上这里是描述符表的索引 avail_idx
    for (int i = 0; i < 3; ++i) {
        idx[i] = blk->avail_idx++ % blk->vr.size;
    }

    struct virtio_blk_req *req = &blk->ops[idx[0]];
    req->type = b->is_write ? VIRTIO_BLK_T_OUT : VIRTIO_BLK_T_IN;   // 写入磁盘 / 磁盘读取
    req->reserved = 0;
    req->sector = sector;

    // 以下三部分共同组成一个请求
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
    blk->info[idx[0]] = b;              // 一次传输

    // 写入 avail_ring, 指向第一个描述符
    virtio_vring_add_avail(blk->vr.avail, idx[0], blk->vr.size);
    virtio_pci_set_queue_notify(&gs_virtio_blk_hw, qnum);

    // printf("virtio_blk_rw waiting, b: %p ...\n", b);

    // 方式1: PLIC 使用中断通知的方式, 判断设备是否写入完成
    volatile u16 *pflag = &b->flag;
    // wait cmd done, 等待设备写入
    while (*pflag == 1) ;

    // 注: APLIC+IMSIC 中断有问题, 使用这种方式可以
    // 方式2: 获取 used ring idx, 判断 blk 设备是否写入完成
    // volatile u16 *pt_used_idx = &blk->used_idx;
    // volatile u16 *pt_idx = &blk->vr.used->idx;
    // wait cmd done
    // while (*pt_used_idx == *pt_idx) ;
    // blk->used_idx += 1;

    blk->info[idx[0]] = NULL;           // 完成一次
}

int virtio_pci_blk_cfg_isr(int irq)
{
    printf("virtio-blk cfg: %d\n", irq);
    return 0;
}

int virtio_pci_blk_intr(int irq)
{
    struct virtio_blk *blk = &gs_virtio_blk;

    // 21 号中断直接会到达
    virtio_pci_clear_isr(&gs_virtio_blk_hw);

    dsb();
    while (blk->used_idx != blk->vr.used->idx) {
        int id = blk->vr.used->ring[blk->used_idx % BLK_QSIZE].id;
        //printf("virtio_blk_intr id: %d, status: 0x%02x\n", id, blk->status[id]);
        if (blk->status[id] != 0) {
            printf("virtio_pci_blk_intr status: %d\n", blk->status[id]);
        }

        struct blk_buf *b = blk->info[id];
        //printf("virtio_blk_intr b: %p\n", b);
        b->flag = 0;                    // blk is done -> 用来激活 virtio_blk_rw 中的等待
        blk->used_idx += 1;
        dsb();
        //printf("virtio_blk_intr b->flag: %d\n", b->flag);
    }
    return 0;
}