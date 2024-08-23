# Using the U-Boot Driver Library

This section outlines the library's API.

## Library API

At the core of the library's public API (see library folder `include/public_api` for full details) are:

- Routines to initialise (`initialise_uboot_drivers`) and shutdown (`shutdown_uboot_drivers`) the library that must book-end the usage of all other API routines;

- A routine (`run_uboot_command`) to allow execution of the same textual commands as used at the [U-Boot prompt](../../first_boot/main.md#boot-to-u-boot-prompt). For example, in the [I<sup>2</sup>C worked example](../../activity/new_driver/add_driver_worked_example.md#establishing-the-driver-api), it is shown how the U-Boot `i2c` command is added and used, e.g. to probe the bus.

Although this provides a relatively simple API, it is intuitive as it has a direct analogue to the commands available at the U-Boot command line. There are limitations, but the API can be readily developed further to expose more functionality, for example:

- To accept arguments through parameter passing rather than through a textual command;

- To return data or results rather than printing outcomes to the console;

- To expose lower-level interfaces than the U-Boot commands permit, for example access to raw Ethernet frames.

It is expected that the source code of the U-Boot commands are likely to provide a starting point for extended API routines.

A number of worked examples have been provided for extensions to the core API described above:

- For accessing the `stdin` file maintained by U-Boot, routines `uboot_stdin_<...>` have been provided to enable testing whether characters are available and to retrieve them. The [uboot-driver-example](../../activity/device_drivers/uboot-driver-example.md) test application demonstrates usage of these API routines for retrieving characters typed on a connected USB keyboard.

- For reading and sending raw Ethernet frames, routines `uboot_eth_<...>` have been provided. The [picoserver_uboot](../../activity/picoserver_uboot/main.md) test application demonstrates usage of these API routines to integrate the library with the picoTCP stack.

The following documents give a basic overview of the test applications and how to build and run them.






