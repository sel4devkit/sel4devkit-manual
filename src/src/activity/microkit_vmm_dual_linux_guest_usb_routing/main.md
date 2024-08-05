# Dual Linux Guest with USB routing 

## Introduction

In This activity we aim to
It will combine usb IP routing with the dual tty libvmm setup.
We are currently awaiting a virtio-net contribution from libvmm - what is a vswitch?


## USB IP

USB IP is... 
We have done the following.. 

This can be found...

## Virtio

At the time of writing the libvmm VirtIO Net contribution is still being developed. For our implementation we will rework the relevant parts of the example to work with our devkit setup using the Maaxboard.  
The Protection Domain (PD) structure will be similar to the VirtIO console implementation with specific net RX and TX queues and an ethernet driver. In the console example the multiplexing is done in the driver code, but for this example a "vswitch" is implemented in its own PD to handle the switching between the different VM's. This vswitch code appears to be in the SDDF repository, so it will be important to make sure these projects are synced up correctly. Also, the TX and RX queues will be implemented with net specific functions from the SDDF.

The ethernet device will need to be disabled in the device tree and an extra node for VirtIO-net will need to be added. Further investigation will need to be done to see if there are any other changes to the device tree that need to be made, such as changes to the boot arguments. 

