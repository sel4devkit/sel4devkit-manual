# Dual Linux Guest with USB routing 

## Introduction

In this activity we explored different options for USB routing. Largely, the need for USB routing comes from virtualisation, where the physical hardware has the physical USB port, and there is a virtual system that we wish the USB port is routed into. In our case we are working towards routing a USB device into one of multiple virtual machines (VM). 

## USB IP

USB/IP Project to develops a general USB device sharing system over an IP network. It uses TCP/IP payloads to transmit USB I/O messages between two different computers. We ran a preconfigured Linux natively on the Maaxboard, which included USB IP functionality. We then connected to another server running Linux and routed the USB keyboard traffic from the maaxboard to it over IP. 

The next goal was to load a virtual Linux guest on the Maaxboard and pass through USB data to the guest. We were unable to transfer the data from the guest to another server because because the ethernet passthrough was not working properly. We have been notified that a newer version of Microkit may solve this issue. This exercise demonstrated the use of USB IP and helped us understand how to preconfigure a Linux kernel to include specific functionality. 


## VirtIO

At the time of writing the libvmm VirtIO Net contribution is still being developed. For our implementation we will rework the relevant parts of the example to work with our devkit setup using the Maaxboard. The Protection Domain (PD) structure will be similar to the VirtIO console implementation with specific net RX and TX queues and an ethernet driver. In the console example the multiplexing is done in the driver code, but for this example a "vswitch" is implemented in its own PD to handle the switching between the different VM's. This vswitch code appears to be in the SDDF repository, so it will be important to make sure these projects are synced up correctly. Also, the TX and RX queues will be implemented with net specific functions from the SDDF.

The ethernet device will need to be disabled in the device tree and an extra node for VirtIO-net will need to be added. Further investigation will need to be done to see if there are any other changes to the device tree that need to be made, such as changes to the boot arguments. Once VirtIO is avaialble we will be able to extend our previous dual guest example such that the two VM's can communicate via IP. At this stage there would not be any USB routing, but it demonstrates a solution to communicate IP data between two VM's.


## Notes

The exploration into USB IP gave us understanding on how we could send USB data between two instances of linux. In theory we should be able to plug a USB device to the maaxboard and pass it through to 1 of the linux guests. If only one VM was given passthrough to the USB device then this VM could act as the USB IP "server" and using VirtIO Net it could route the USB traffic to the other VM over IP.
