## VMM with dual linux guests and TTY Multiplex

For this activity the goal was to load two linux Virtual Machines (VM) on one host. This was achieved by building upon our previous single guest example and taking inspiration from an existing libvmm contribution that makes use of VirtIO console. For this example five Protection Domains (PD) are used. Two PD’s are used for each virtual machine, one for the UART serial driver and the remaining two for the TX and RX communication to handle the serial data. **(Explain RX and TX briefly)**

VirtIO is an interface used by virtual machines to use its hosts’ devices through the means of virtual devices. The main role of these devices is to get data to and from the hosts physical hardware. VirtIO consists of three main parts: front-end drivers, back-end devices, and VirtQueues.

Typically, the front end drivers exist in the hosts kernel. These can be turned on in the config file when creating a linux kernel with buildroot. They are responsible for accepting I/O requests from user processes, transfering I/O requests to its corresponding back-end VirtIO device and retrieving completed requests from the back-end device. The back-end devices typically exist in the VMM. Libvmm provides implementations for console, network, block and sound devices. They are responsible for accepting I/O requests from the corresponding front-end driver,
handling the requests by offloading the I/O operations to the host’s physical hardware,
and making the processed and requested data available to the VirtIO driver. 

VirtQueues are shared memory regions that are used by a VirtIO front-end driver and back-end device pair. A VRing is a data structure contained within the VirtQueue that facilitates data transfer between the VirtIO device and driver. Libvmm follows version 1.2 of the VirtIO specification and uses the seL4 Device Driver Framework (SDDF) to implement the VirtQueues for specific devices.

In our example, we make use of the VirtIO Console device to handle serial I/O data. To use VirtIO Console a node was created in the device tree and a multiple settings turned on in the linux kernel config file. In the “chosen” node of the device tree, the stdout path and the boot args also needed to be set up specifically for the console device. In our initial implementation we passed through 8 additional devices. We then managed to remove the need for 7 of them by disabling them in the device tree. The remaining “gpc” device was needed by virtio-console, but at this stage it is unknown why. 





* Memory considerations for two linuxes. (Where this is set up, tweaking was needed)
* Talk about the timer, priorities of the two VM’s
* What was the missing thing that bill found so that we could get set up?
* add in more failures and attempts at things 

