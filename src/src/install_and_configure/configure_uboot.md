# Setting up the U-Boot Configuration file

A U-Boot configuration file (`uEnv.txt`) may be placed within the BOOT
partition, to automatically control how U-Boot will locate and then boot the
desired software image.

The content of `uEnv.txt` will vary, depending on whether CAmkES or Microkit
is being used, where the software image is to be located, and how the software
image is to be retrieved. For convenience, covering each combination, a set of
`uEnv.txt` templates are prepared in advance, as listed below:

- [CAmkES::sd-card](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/camkes/sd-card/uEnv.txt) 
- [CAmkES::usb-flash](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/camkes/usb-flash/uEnv.txt) 
- [CAmkES::tftp::static](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/camkes/tftp/static/uEnv.txt)
- [CAmkES::tftp::dhcp](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/camkes/tftp/dhcp/uEnv.txt)
- [Microkit::sd-card](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/microkit/sd-card/uEnv.txt) 
- [Microkit::usb-flash](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/microkit/usb-flash/uEnv.txt) 
- [Microkit::tftp::static](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/microkit/tftp/static/uEnv.txt)
- [Microkit::tftp::dhcp](https://github.com/sel4devkit/sel4devkit-maaxboard-bootloader-u-boot/tree/main/uenv/microkit/tftp/dhcp/uEnv.txt)
