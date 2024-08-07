# Microkit xHCI USB Driver

## Introduction

For this activity the goal was to create an Sel4 native xHCI driver. Writing an entire xHCI driver from scratch is a long and complicated task, so we opted to re-work an existing solution. We chose to use NetBSD's xHCI driver because it has good portability, supports a wide range of hardware, is BSD licenced, is updated often and makes use of interrupts which are more performant compared to other solutions that use polling. The plan was to use this as a base to pull drivers from in the future.   

## Project Layout

The set up and structure of this project is different to other activites we've completed. See the following repository for more details:

LINK TO MK MANIFEST WITH UPDATED README (and/or explain here a little bit)

## xHCI

xHCI is a standardised interface used for USB host controllers. Also known as the USB 3.0 host controller specification, it is designed to be backward compatible, supporting a wide range of USB devices from older USB 1.x to the more recent USB 3.x versions. Compared to its predecessors (OHCI, UHCI and EHCI) it is designed to handle multiple data transfer speeds within a single unified standard, making it more effecient at handling computer resources. The standard describes the basic communication between the software and the host controller including memory layout, data structures, MMIO and DMA.

## CAmkES

For our initial development we used CAmkES with the first goal of interfacing with the hardware. We compiled net bsd, then traced the initialisation of the xHCI, noting down the input/output read and write commands. We then hardcoded the necessary memory register addresses and worked out the changes that we needed to make to the driver so that it was compatible with seL4 and CAmkES. We were then able to initialise the host controller by setting up the correct memory registers, DMA and interrupts. Once we got it to this point we decided to port the example to Microkit.

## Microkit

The first goal was to understand the differences between CAmkES and Microkit and become familiar with its features. Compared to CAmkES, Microkit has no standard libraries which means that we had to export libraries for simple functionality such as logging and memory handling. We also had to create a simple DMA handler and in the absence of a build system we opted to use GNU Make. Once we had an understanding of microkit, we got our new example to intitialise the host controller as we did with CAmkES.

We created a separate DMA library which can be found here: LINK TBD

### Architecture

Show a screenshot - 

One Protection Domain (PD) acts as a central driver which handles all of the initialization and communciates with the hardware via mmio. There are additional PD's for the memory handler, software interrupts and hardware interrupts. Task thread is for hotplugging and is not currently implemented.


### Memory considerations

Between the core driver PD and the software interrupt PD there are some function pointers to callback functions. In NetBSD's original set up it expects to be running in the same memory address space but with our setup this part of the communication is done between PD's, meaning that they don't have access to the same blocks of memory. Our first attempt at resolving this solution invovled using a master PD that handles all of these functions, where the driver would call into the master PD, then the master PD would call into the software interrupt PD. This however was not a viable solution because the software interrupt PD was of a lower priority than the driver which had an affect on performance. 



See slide - 6:30
BEtweeen the core driver protection domain and the software interrupt protection domain - theres an issue because netbsd uses a lot of function pointers - so its ecpecting to be in the same 

Explain issue then talk about two possible solutions

Talk about the client_heap memory region and the microkit libc - josh seems to have just committed that straight into it - rather than going for a separate build. 

### Devices

Once initialsied host controller, we moved onto devices. We started with keyboard as it was straightforward to get an example up and running and easy to test as it uses a human interface.

One issue was hardcoded functions - with usb it sets up a transfer tells the host controller to go and comes back to a call back. Initially that was hardcoded to avoid various memory issues.

Next we added a mouse - conceptually very similar, both human interface devices, same funemental layer,

Use mouse set up files from netbsd.

Like a touch screen - just has an extra form of set up and a z direction.

Make use of generic code for mouse and add touchscreen on top.

When probe bus for drivers we have to say what device is being attached. Means modifying code and recompiling the program. - Introduced netbsd auto configuration

Auto Configuration: (doesn't need to be its own section)

Makes use of a match function where it looks at device description and says what devices it will assign it to. Big lsit of devices created at net bsd compile time. We can just extract the lsit and trim down any non xhci devices. Allows our driver to determine best match for each device.

## Additional libraries

This section may not be needed

Libc for microkit (is this just prebuilt now?)
DMA library (need to make an activity?)


