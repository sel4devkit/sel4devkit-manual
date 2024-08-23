# Using the prebuilt image

Instructions for using the prebuilt U-Boot image are as follows: _Note: the disk images have been created for a 16GB SD card; please use a card that is 16GB or larger._

1. Get the prebuilt disk image from the [maaxboard-prebuilt](https://github.com/sel4devkit/maaxboard-prebuilt) repository, either by cloning the entire repository, or by using the direct link [here](https://github.com/sel4devkit/maaxboard-prebuilt/blob/main/disk_images/maaxboard-uboot.img.zip).

    _Note: the images are compressed as zip files in order to reduce their size (compressed size ~15MB, uncompressed size ~15GB), and will need to be uncompressed using a suitable utility before use._

2. Once you have downloaded the image you will need to use a utility for flashing images to external drives. The rest of this section assumes that you will use Etcher; see the [Host Setup](../install_and_configure/host_setup.md) section for more details.

3. Insert the SD card you wish to flash, and open Etcher.
![etcher-default](../install_and_configure/figures/etcher-default.png)

4. Select Flash from file, and navigate to and select the image file you wish to flash. Then click open.
![etcher-img-select](../install_and_configure/figures/etcher-img-select.png)

5. Click select target and select the drive you wish to flash, taking care to choose the right drive.
![etcher-drive-select](../install_and_configure/figures/etcher-drive-select.png)

6. Then finally click ‘Flash!’ to flash the image. This may take a significant time (e.g. 25 minutes).
![etcher-ready-to-flash](../install_and_configure/figures/etcher-ready-to-flash.png)
_Flashing in progress:_
![etcher-flashing](../install_and_configure/figures/etcher-flashing.png)
_After Etcher has flashed the disk, it will validate the disk:_
![etcher-validation](../install_and_configure/figures/etcher-validation.png)

7. Once flashing is complete, the SD card is ready for use in the MaaXBoard for booting as far as the U-Boot bootloader.

