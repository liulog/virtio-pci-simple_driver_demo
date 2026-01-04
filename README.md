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

### 参考

https://github.com/oldawei/show_me_the_code
