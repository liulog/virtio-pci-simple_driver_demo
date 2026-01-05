# virtio-pci-simple_driver_demo

这是一个简单的逻辑程序 Demo, 进行 virtio-pci 的简单驱动实现, 用于学习 virtio 相关机制.

它是一个 RISC-V 64bits 的程序, 运行在 S-mode.

### 编译&运行环境

- riscv64-unknown-elf-xx
- qemu-system-riscv64

### Quick start

```
make run
```

### debug

```
make debug
```

### virtio-pci-rng

```c
    // driver doesn't support event idx, used for optimization about notification
    features &= ~(1 << VIRTIO_F_EVENT_IDX);
    // driver doesn't support indirect desc
    features &= ~(1 << VIRTIO_F_INDIRECT_DESC);
```

代码中为一个轮询的版本, 并未提供以上 features 的支持

### virtio-pci-blk

```c
    // disk is read-write
    features &= ~(1 << VIRTIO_BLK_F_RO);
    // don't support scsi commands
    features &= ~(1 << VIRTIO_BLK_F_SCSI);
    // don't support flush commands
    features &= ~(1 << VIRTIO_BLK_F_FLUSH);
    // don't support config write cache enable
    features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    // don't support multi-queue
    features &= ~(1 << VIRTIO_BLK_F_MQ);
    // driver only use standard vring layout (i.e. desc table + avail ring + used ring)
    features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    // driver doesn't support event idx, used for optimization about notification
    features &= ~(1 << VIRTIO_F_EVENT_IDX);
    // driver doesn't support indirect desc
    features &= ~(1 << VIRTIO_F_INDIRECT_DESC);
```

代码中是一个线中断版本, 并且未提供以上 features 的支持, 仅用于学习 virtio 的机制, 并未进行相关优化

### TODO:

msi/msi-x related

### 参考

特别感谢: https://github.com/oldawei/show_me_the_code
