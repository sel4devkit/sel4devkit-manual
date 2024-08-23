# Test application: uboot-driver-example

## Overview of the uboot-driver-example test application

The source file at `camkes/apps/uboot-driver-example/components/Test/src/test.c`/ `examples/maaxboard/uboot-driver-example/uboot-driver-example.c` represents the script for the test application. It contains `run_uboot_cmd("...")` calls to U-Boot commands that are supported by the library. The set of supported commands can be readily seen in the `cmd_tbl` entries of `projects_libs/libubootdrivers/include/plat/maaxboard/plat_driver_data.h`.

It is left to the reader to look through the test script in detail, but the features demonstrated include the following.

- The MaaXBoard's two integral LEDs are toggled.
- Ping operations.
- USB operations[^1], including:
  - identify and list (`ls`) the contents of a USB flash drive, if connected;
  - read and echo keypresses from a USB keyboard, if connected, during a defined period.
- SD/MMC operations to identify and list (`ls`) the contents of the SD card.
- Filesystem operations to write a file to a FAT partition on the SD card before reading the contents back and deleting the file.
- I<sup>2</sup>C operations to probe the bus and read the power management IC present on the MaaXBoard's I<sup>2</sup>C bus. (There are more details in the [worked example](../../activity/new_driver/add_driver_worked_example.md) that walks through the steps that were required to add this driver.)

[^1]: Note: Currently, only the upper USB port on the Avnet MaaXBoard is active (i.e. the port furthest away from the PCB); the lower USB port does not function. This is a feature of the power domains on the board, not the USB driver.

Other utility commands are exercised, such as `dm tree`, which is useful to follow the instantiation of device drivers, and `clocks` which lists all the available clocks. As well as 'headline' drivers like USB, there are also some fundamental 'building block' drivers in the library, for elements such as clocks, IOMUX, and GPIO, which are needed by other drivers.

### Configuration for different platforms

Although uboot-driver-example was created to demonstrate the device drivers developed for this MaaXBoard developer kit, it is configurable to support other platforms. For example, in the [worked example appendix for the Odroid-C2](../../activity/new_platform/add_odroidc2.md), a small subset of drivers has been developed for that platform, and the `test.c` source file for `uboot-driver-example` uses the preprocessor macros `CONFIG_PLAT_MAAXBOARD` and `CONFIG_PLAT_ODROIDC2` to configure which commands are run for each platform. By default, all tests are enabled for an unrecognised platform, but this would be readily configured for a new platform's `CONFIG_PLAT_...` preprocessor macro.
