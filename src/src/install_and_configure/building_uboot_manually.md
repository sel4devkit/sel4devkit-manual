# Building U-Boot manually 

The instructions for [formatting the SD card](#partitioning-the-sd-card), [building U-Boot](#building-u-boot) and [flashing the image](#writing-u-boot-to-the-sd-card) are as follows:
## Partitioning the SD Card

The SD card must be partitioned correctly in order to contain U-Boot, seL4 and space for a filesystem. This can be done as follows.

The intention of this section is provide instructions on how to create three partitions on the disk:

- a 10 megabyte bootloader partition for U-Boot;

- a 256 megabyte partition to hold the seL4 image; and,

- the remainder of the disk is provided for the file system.

### macOS Instructions

1. Connect your SD card reader to your host machine and insert your SD card.

2. Find the disk identifier (e.g `/dev/disk6` ) for your SD card, on macOS this can be done by running `diskutil list` . This command should present a list of disks and their partitions, `/dev/disk0` and `/dev/disk1` are usually used for the internal SSD/HDD on your Mac, so the SD card will usually be at the bottom, assuming it was the last storage device attached to your machine.

3. On macOS, you may need to unmount any volumes associated with the SD card. You can do this either from Disk Utility or by using `diskutil unmount /dev/diskXsY` where `X` is the disk identifier and `Y` is the volume identifier.

4. From terminal run the following command, replacing X in `/dev/diskX` with your disk identifier as found earlier. *Note: the `15GB` size mentioned for the `FILESYS` partition can be changed to `R` which will use the remainder of the disk. The instructions here use `15GB` to reflect what was used to create the prebuilt images in the [maaxboard-prebuilt](https://github.com/sel4devkit/maaxboard-prebuilt) repo. `15GB` is used as "16GB" SD cards/flash drives are not all truly "16GB" due to formatting, so this is done to account for minor differences in size.*

   ```sh
   sudo diskutil partitionDisk /dev/diskX 3 MBR \
      FREE Bootloader 10M \
      FAT32 BOOT 256M \
      FAT32 FILESYS 15GB
   ```

### Linux Instructions

1. Connect your SD card reader to your host machine and insert your SD card.

2. Find the disk identifier (e.g `/dev/sdb` ) for your SD card, on Linux this can be done by examining the kernel ring buffer following insertion of the SD card by running `dmesg | tail` . For example, the following `dmesg` output shows the inserted card using identifier `sdb` and having two volumes `sdb1` and `sdb2`.

   ```text
   [0.711] scsi host6: usb-storage 2-1.5:1.0
   [0.728] scsi 6:0:0:0: Direct-Access   SD/MMC   Card  Reader   1.00 PQ: 0 ANSI: 0
   [0.735] sd 6:0:0:0: Attached scsi generic sg2 type 0
   [1.020] sd 6:0:0:0: [sdb] 30883840 512-byte logical blocks: (15.8 GB/14.7 GiB)
   [1.022] sd 6:0:0:0: [sdb] Write Protect is off
   [1.022] sd 6:0:0:0: [sdb] Mode Sense: 03 00 00 00
   [1.025] sd 6:0:0:0: [sdb] No Caching mode page found
   [1.025] sd 6:0:0:0: [sdb] Assuming drive cache: write through
   [1.076]  sdb: sdb1 sdb2
   [1.084] sd 6:0:0:0: [sdb] Attached SCSI removable disk
   ```

3. On Linux, you may need to unmount any volumes associated with the SD card. You can do this using the `umount` command. If two volumes named `sdb1` abd `sdb2` were detected on insertion of the SD card these would be unmounted with the following commands:

   ```sh
   sudo umount /dev/sdb1
   sudo umount /dev/sdb2
   ```

4. From terminal run the following commands, replacing `<disk>` in `/dev/<disk>` with your disk identifier as found earlier. *Note: the `14602MiB` size mentioned for the final partition can be changed to `100%` which will use the remainder of the disk. `14602MiB` is used as "16GB" SD cards/flash drives are not all truly "16GB" due to formatting, so this is done to account for minor differences in size.*

   ```sh
   sudo parted /dev/<disk> mklabel msdos
   sudo parted /dev/<disk> mkpart primary fat32 10MiB 266MiB
   sudo parted /dev/<disk> mkpart primary fat32 266MiB 14602MiB
   sudo mkfs.vfat /dev/<disk>1 -F 32 -n BOOT
   sudo mkfs.vfat /dev/<disk>2 -F 32 -n FILESYS
   ```

## Building U-Boot

In order to build U-Boot, the seL4devkit Docker build environment is required, please see [Build Environment Setup](../install_and_configure/build_environment_setup.md) to setup this up if you haven't already done so.

1. Clone the repository:
```
git clone git@github.com:sel4devkit/sel4devkit-maaxboard-bootloader-u-boot.git
```

2. Clone dependencies 
```
cd sel4devkit-maaxboard-bootloader-u-boot
make get
```

3. Build
```
make all
```

4. The generated file `flash.bin` is located in the `/out` folder and can be written to storage media.


## Writing U-Boot to the SD card

1. Navigate to the folder containing your U-Boot `flash.bin` file. 

    > **WARNING: The next step uses the `dd` command line utility, which is used for writing images to disks. IT WILL OVERWRITE ANY DATA ON THE DISK IT IS SPECIFIED TO WRITE TO! Improper usage WILL cause data loss, corruption and potentially render your system inoperable. Please ensure you are familiar with the use of the command, as well as the disk identifiers on your system, and that you are writing to the disk you intend to, and not your system drive!**

2. From that folder run the following command, replacing `/dev/diskX` with the disk identifier of your SD card. You may be asked to enter your password.

    ```sh
    sudo dd if=flash.bin of=/dev/diskX bs=1k seek=33
    ```

3. The image should now be written to your SD card and should be bootable by the MaaXBoard.


