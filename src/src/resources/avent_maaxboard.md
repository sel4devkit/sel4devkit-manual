# Avnet MaaxBoard

The Avnet MaaXBoard SBC (Single Board Computer) has been selected as the
target platform for developing and investigating this seL4 Developer Kit. 

The following high level features of the Avnet MaaXBoard SBC make it
particularly suitable for use with the seL4 Developer Kit:

- __Inexpensive__: The Avnet MaaXBoard SBC is relatively inexpensive,
  minimising the cost of getting started with the seL4 Developer Kit.

- __Available__: While not a routine product, it is straight forward to identify
  suppliers with multiple instances of the Avnet MaaXBoard in stock.

- __Devices__: The Avnet MaaXBoard incorporates a wide collection of input and
  output devices, simplifying its practical usage, and permitting some
flexibility in the activities that may be explored with the seL4 Developer
Kit. 

- __Architecture__: The Avnet MaaXBoard supports an ARM architecture (AArch32
  and AArch64). In general, the ARM architecture, in contrast to the x86
architecture, is much simpler, which is particularly suitable for security
focused applications. More so, because of this intrinsic suitability, the seL4
Microkernel and its associated components, tend to offer greater support and
capabilities for the ARM architecture.

- __Open__: The detailed technical aspects of the Avnet MaaXBoard, its
  resident devices, and the ARM architecture, are well documented and freely
publicly available.

## Specifications

The Avnet MaaXBoard SBC is part of a family of SBCs. For clarity, we are using
the "Avnet MaaXBoard" with part number "AES-MC-SBC-IMX8M-G".

The Avnet MaaxBoard uses the i.MX 8M SoC (System-on-Chip) processor as
developed by NXP. The associated reference manual is a very useful document
for developing atop this processor. The manual is freely available through
NXP, once an account is created with them: [NXP](https://www.nxp.com).  Search
for "Documentation" for the "i.MX 8M Family" with keyword "IMX8MDQLQRM".

The Avnet MaaXBoard SBC contains two USB ports, routed to the two USB hosts,
as provided by the i.MX 8M SoC. While the i.MX 8M SoC manual provides
considerable detail, it is also helpful to inspect the xHCI (eXtensible Host
Controller Interface) specification, which the i.MX 8M SoC implements. This is
directly available from Intel as the [eXtensible Host Controller Interface for
Universal Serial Bus (xHCI) - Requirements
Specification](https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf)

The Avnet MaaxBoard, due to its i.MX 8M SoC, build around the Cortex-A53 and
Cortex-M4 cores, adopts an ARM architecture, and specifically the Instruction
Set "ARMv8-A" (also know as ARMv8). While less directly relevant, the
associated documentation can nevertheless be valuable in investigating and
understanding detailed aspects of the platform. The documentation is directly
available from Arm as the [Arm Architecture Reference Manual for A-profile
architecture](https://developer.arm.com/documentation/ddi0487/latest).
