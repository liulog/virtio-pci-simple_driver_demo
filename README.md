# virtio-pci-simple_driver_demo

这是一个简单的逻辑程序 Demo, 进行 virtio-pci 的简单驱动实现, 用于学习 virtio 相关机制.

它是一个 RISC-V 64bits 的程序, 运行在 S-mode.

#### 编译&运行环境

- riscv64-unknown-elf-xx
- qemu-system-riscv64

#### Quick start：

```
make run
```

gdb debug：

```
make debug
```

### 参考

https://github.com/oldawei/show_me_the_code
