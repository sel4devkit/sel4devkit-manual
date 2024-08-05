# Single Linux guest 

## Introduction 

For this task, the goal was to load up a virtual machine (VM) on a host with serial TTY passthrough. Our starting point for this activity was to rework an example from the Trustworthy Systems libvmm repository so that it runs on the Maaxboard. This repo contains a virtual machine monitor for the seL4 microkernel with various examples built for the Odroid board and the open source emulator Qemu. Libvmm provides a virtual machine monitor (VMM) which is used to start and manage the guest VM. 

The repository for this project is located at: https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-vmm-single-linux-guest

## Design 


## Buildroot 
To create the linux kernel image we used buildroot. Buildroot is an open source project that automates the process of building a complete and bootable Linux environment for an embedded system. We chose buildroot because the process to create a basic linux kernel image is straightforward. **(More on build root)**

How have we used build root?

## Virtual memory faults
The VM doesn’t necessarily know it's being virtualised, so it may try to perform read and write operations on certain devices and memory regions that it doesn’t have access to. When setting up the project there were a number of virtual memory faults, which were caused by the guest VM trying to access devices that it was not exposed to in the system file. Generally, there are three approaches to fix this.

One approach is to disable the device node in the device tree so that it does not try to access the device. This approach may not be feasible because the memory region may be required by a specific process in your system or dependent on another device in order to function. Another approach is to disable the device driver in the guest configuration (This can be configured with buildroot). The last approach is to utilise device “pass-through” which is where the address of the device is mapped into the guest VM allowing access directly to the device. Ideally, in a virtualised environment the guest VM shouldn’t have access to physical devices. However, for simplicity and with the absence of a serial driver it was necessary to pass through the serial device and the devices that depend on it. 

## Passthrough 
Two memory regions that are required to be passed through for the use of libvmm and our example are the RAM and the Generic Interrupt Controller Virtual CPU (GIC-VCPU). In order for the linux guest to be able to run, it needs to have an area of contiguous space directly allocated for its own RAM. In its current implementation libvmm expects the physical memory address and the virtual memory area for the RAM to be at the same address. At a minimum there needed to be enough memory to load the kernel image and other associated binaries. The size and position of this memory need to reflect the memory node in the device tree. The GIC-VCPU is used to signal virtual interrupts. Libvmm provides a driver to handle this device which is necessary for running any guest operating system with libvmm.

## Memory considerations

The only allocated 2gb and the initramfs issue.

## SMC issue


Another issue we faced was  

* Link to build root
* Link to bills repository
* Write a short bit about the SMC issue
* Talk about the RAM issue (only allocated 2gb for example - double check what we are using in the the actual example, look at hex amount and see if it is less - does this match up?)
* Did anything else trip us up on the way? Is more detail needed?

