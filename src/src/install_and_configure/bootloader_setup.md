# Bootloader Setup

When a computer is turned off, its software remains stored in non-volatile memory. When the computer is powered on, a bootstrap loader is required: a small, low-level program to configure the computer's memory and devices sufficient to then be able to load further software, such as a bare-metal application or operating system, into RAM and then call it.

**Das U-Boot** (known as "the Universal Boot Loader" and often shortened to U-Boot) is an open-source bootloader commonly used in embedded devices. For such low-level operations, it has to be customized for the hardware on which it is running.

There are two options for configuring and installing U-Boot:
- [Using the prebuilt image](../install_and_configure/using_the_prebuilt_image.md)
- [Building U-Boot manually](../install_and_configure/building_uboot_manually.md)

For how to configure U-Boot see:
- [Setting up the U-Boot config file](../install_and_configure/configure_uboot.md)
