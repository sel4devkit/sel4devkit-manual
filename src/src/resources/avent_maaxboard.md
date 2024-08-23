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

The Avnet MaaxBoard uses the i.MX 8M Quad processor developed by NXP. The
application processor reference manual is a very useful document for
developing atop this processor. The manual is freely available through NXP,
once an account is created with them: [NXP](https://www.nxp.com). Search for
"Documentation" for the "i.MX 8M Family" with keyword "IMX8MDQLQRM".
