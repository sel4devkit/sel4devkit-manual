
# Setting up U-Boot config

A U-Boot configuration file (uEnv.txt) is contained within the provided image. It is placed in the root of the `BOOT` partition and is named `uEnv.txt`. It contains 3 main configurable items:

1. U-Boot network configuration (`ipaddr` and `netmask`): use this to manually configure the IP address and subnet for U-Boot to use, or comment them out to have them assigned by DHCP/BootP.

2. TFTP server IP address (`serverip`): use this to configure the IP address of the TFTP server to contact, or comment out to disable boot via TFTP.

3. ELF binary name (`elf_binary_file`): the name of the ELF binary the U-Boot will try to load, first from a USB device, then from a SD card, and finally via the configured TFTP server.

Different commands are needed to load each type of image. Microkit generates .img file which is loaded using the "go" instruction and CAmkES generates a .elf file which is loaded using the "bootelf" command. To see different U-Boot configuration options see: [sel4devkit-maaxboard-bootloader-u-boot](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv)


