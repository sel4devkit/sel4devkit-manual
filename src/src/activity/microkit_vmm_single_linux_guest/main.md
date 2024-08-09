# Single Linux guest 

## Introduction 

For this task, the goal was to load up a virtual machine (VM) on a host with serial TTY pass-through. This was with the intended goal of performing I/O with the Linux guest. Our starting point for this activity was to rework an example from the Trustworthy Systems Libvmm repository so that it runs on the Maaxboard. This repo contains a virtual machine monitor for the seL4 microkernel with various examples built for the Odroid board and the open source emulator Qemu. Libvmm provides a virtual machine monitor (VMM) which is used to start and manage the guest VM. 

The repository for this project is located [here](https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-vmm-single-linux-guest).

The Trustworthy Systems Libvmm repository can be found [here](https://github.com/au-ts/libvmm/tree/main).

## Design 

One Protection Domain (PD) is used which contains a virtual machine and physical devices such as the UART which are passed through to the Linux guest. This means that no driver code is needed in seL4 as the Linux guest will contain the driver and communicate directly with the Maaxboard's hardware. 

## Buildroot 
To create the Linux kernel image and the root filesystem we used Buildroot. It is an open source project that automates the process of building a complete and bootable Linux environment for an embedded system. We chose Buildroot because it makes the process to create a basic Linux kernel images straightforward. In this project the Linux kernel image, the root filesystem and the device tree are linked into the PD's image file.

Our buildroot repository can be found [here](https://github.com/sel4devkit/sel4devkit-maaxboard-linux-guest/blob/main/doc/MANUAL.md).

## Virtual Memory Faults

The VM doesn’t necessarily know it's being virtualised, so it may try to perform read and write operations on certain devices and memory regions that it doesn’t have access to. When setting up the project there were a number of virtual memory faults, which were caused by the guest VM trying to access devices that it was not exposed to in the system file. Generally, there are three approaches to fix this.

* Disable the device node in the device tree so that it does not try to access the device. This approach may not be feasible because the memory region may be required by a specific process in your system or dependent on another device in order to function.
* Disable the device driver in the guest configuration (This can be configured with Buildroot).
* Utilise device “pass-through” which is where the address of the device is mapped into the guest VM allowing access directly to the device. Ideally, in a virtualised environment the guest VM shouldn’t have access to physical devices. However, for simplicity and with the absence of a serial driver it was necessary to pass through the serial device and the devices that depend on it. 

## Pass-through 

Two memory regions that are required to be passed through for the use of Libvmm and our example are the RAM and the Generic Interrupt Controller Virtual CPU (GIC-VCPU). In order for the Linux guest to be able to run, it needs to have an area of contiguous space directly allocated for its own RAM. In its current implementation Libvmm expects the physical memory address and the virtual memory area for the RAM to be at the same address. At a minimum there needs to be enough memory to load the kernel image and other associated binaries. The size and position of this memory need to reflect the memory node in the device tree. The GIC-VCPU is used to signal virtual interrupts. Libvmm provides a driver to handle this device which is necessary for running any guest operating system with Libvmm.

## Memory Considerations

In the current release of Microkit (1.2.6 At the time of writing), the way that Microkit allocates memory for untyped regions is not optimal for large amounts of memory. All of memory, including RAM, is split into regions based on some rules and then Microkit allocates kernel objects from those untypeds. It is thought that the Microkit allocator is for some reason only allocating from a maximum of one untyped for a single allocation. This means that for example, if you want 3GB of RAM then it will be split over a couple of untypeds. So if you're trying to create an MR of 512MiB, and the biggest untyped is only 256MB, then Microkit is failing even though technically there is 3GB of space.

An initramfs (initial ram file system) is used to prepare Linux systems during boot before the init process starts. If the memory allocated for the ram isn't big enough then this process will fail. It is not known why exactly, but currently the size is 0xf000000 because 0x9000000 was too small.

## SMC Issue

Whilst developing this project, we came across an error when trying to boot up the VM:

```VMM|ERROR: Unhandled SMC: unknown value service: 0x2, function number: 0x6```

The MaaxBoard Firmware provides a small set of SiP Function Identifiers. The Linux Driver "drivers/soc/imx/soc-imx8m.c" compatible with "fsl,imx8mp" leverages MaaxBoard Firmware SiP Function Identifier "0xc2000006" to get version information. If SMC properly declares that "0xc2000006" is absent, this would be interpreted as detecting an earlier version of the Board (that lacked the Function Identifier). A work around has been implemented to handle this service which suppresses the error. 
