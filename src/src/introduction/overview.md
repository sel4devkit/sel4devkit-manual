## Overview

The seL4 Developer Kit intends to support developers in gaining familiarity
with seL4 Microkernel, and ultimately to encourage more use of seL4 within
projects and products. It does this by:






- selecting a readily available, low-cost single board computer (the [Avnet
  MaaXBoard](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/maaxboard/maaxboard/))
as the target platform;

- detailing the minimum hardware and software requirements necessary to follow the guide;

- supplying a preconfigured build environment with all tools required to generate seL4 executable images;

- demonstrating how an seL4 executable image can be loaded and executed on the chosen target platform; and

- documenting the specific steps needed along with more general guidance.

In its later sections, this documentation:

- presents a comprehensive device driver library with:

  - explanations and design details;

  - test applications to exercise the drivers;

  - guidance for extending it to other platforms; and

- works through a case study application that:

  - uses the device driver library; and

  - demonstrates communication between protection domains using different seL4 mechanisms.



