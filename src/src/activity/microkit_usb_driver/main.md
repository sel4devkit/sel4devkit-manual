# Microkit xHCI USB Driver


## Introduction
Initially wanted to create an Sel4 Native xhci driver.- Specifically xhci. Sustainability in mind (if anything change easy to update)

Uboot drivers for maaxboard have no interrupts and they are all just pollin - less performant. Its GPL licenced as well.

We looked at multiple USB drivers (writing one from scratch would take a while.)

Landed on Net BSD - good portability, (support a wide range of hardware, bsd licenced, updated often (safey), uses interrupts. Base to pull drivers from in the future.

## Project Layout

We use microkit manifest
Before restructure of the project… (could go in actual readme as well to explain)

## xHCI

Protocol for communicating with usb devices - Advancement over OHCI/UHCI/EHCI, supporting all speeds.

The host controller is part of the USB hardware -

The interface to the host controller is the xhci interface - standardised interface. Thats what it stands for x host controller interface.

Its an interface to deal with these two things. 

Describes basics between software and host controller:
How memory should be set up
Data structures (rings etc)
MMIO
DMA



## Camkes


First challenge was to interface with the hardware.

First step was to compile net bsd - traced the initialisation of the xhci and read the input output read and writes - first reads out the version of xhci for instance.

Once we had the hardcoded memory register  addresses - we then could figure out what changes we needed to make to the driver to make it compatible with sel4 and camkes.

Got to a certain point - The initialisation. It was happy it had been initialized, set up DMA, interrupts etc - then ported it to microkit - got it to the same state before continuing.

## Microkit

No standard libraries - biggest challenges. Exporting libraries for print statements, memory handling etc.

Camkes has a dma library - created a simple DMA handler.

No build system - so we opted for Makefile.

### Architecture

Show a screenshot - 

Got a central driver as the main protection domain which handles all of the initialization and that communciates with chadware via mmio.

That calls into a hardware interrupt then calls into a software interrupt to allow for the hardware interrupt to occur while the software interrupt is occurring. Then calls up into the USB class drivers (keyboard mouse etc)

Task thread is for hotplugging - not not implemented.

### Keyboard device

Once initialsied host controller - Then moved onto devices. We started with keyboard as straight forward to get an example up and running and uses a human interface.

One issue was hardcoded functions - with usb it sets up a transfer tells the host controller to go and comes back to a call back. Initially that was hardcoded to avoid various memory issues.

### Memory difficulties

See slide - 6:30
BEtweeen the core driver protection domain and the software interrupt protection domain - theres an issue because netbsd uses a lot of function pointers - so its ecpecting to be in the same 

Explain issue then talk about two possible solutions

### Additional devices

Next we added a mouse - conceptually very similar, both human interface devices, same funemental layer,

Use mouse set up files from netbsd.

Like a touch screen - just has an extra form of set up and a z direction.

Make use of generic code for mouse and add touchscreen on top.

When probe bus for drivers we have to say what device is being attached. Means modifying code and recompiling the program. - Introduced netbsd auto configuration

### Auto Configuration

Makes use of a match function where it looks at device description and says what devices it will assign it to. Big lsit of devices created at net bsd compile time. We can just extract the lsit and trim down any non xhci devices. Allows our driver to determine best match for each device.


## Additional libraries

Libc for microkit. 
DMA library


