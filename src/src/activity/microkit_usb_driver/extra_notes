# Extra notes

## Machine Directory
NetBSD expects some machine specific includes and defines to be in the `machine` directory. In an ordinary build, this folder is created by the Makefile. To replicate this, the driver Makefile creates a similar directory, stored in the `mach_include` directory, and creates a symlink of the include directory of the used architecture (in the example of the MaaXBoard: `{NETBSD_ROOT}/sys/arch/evbarm/include/)`. Our Makefile also creates a symlink of various architecture specific files in the `mach_include` directory.

## Memory
In order to share memory between domains, We created a separate PD called mem_handler that manages the free lists between the two main threads. Any calls to `kem_alloc` (normally allocating kernel memory) are rerouted to this protection domain which allocates memory from a shared region of memory. This memory region is not shared with the client and is reserved for device specific structures and data.

## Hot Plugging
Hot plugging is the ability to set up a USB device while the system is running. This driver is able to support this, and works by calling `microkit_notify(HOTPLUG)` in software interrupts after a regular software interrupt (line 136). The main driver will check if there is an explore pending and attach the device if necessary. Without this call, any extra device connections are not processed past acknowledging the interrupt.
