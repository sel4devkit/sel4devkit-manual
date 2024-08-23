# Configure U-Boot

Where U-Boot is started, and after it has configured the MaaXBoard's memory
and devices, it is able to load application software into RAM and then execute
it.  It is possible for a user to do this interactively using U-Boot commands
via the serial terminal on the host machine. It is also possible and
convenient to provide a U-Boot configuration file `uEnv.txt` that runs
automatically. Both of these configuration options are described below.

### Methods of Loading

We cover three mechanisms for loading the application into RAM by U-Boot:

- From SD card
- From USB flash drive
- Via TFTP (Trivial File Transfer Protocol)

Additional mechanisms are available, such as downloading over the serial
cable. However, this would be much slower compared with the options above and
is not considered further here. Downloading from on-board flash memory is
another possible mechanism, but that is not applicable to the MaaXBoard.

#### Loading from SD Card

The SD card is used to store the bootloader, U-Boot. The SD card may also be
used to store the application software file that is to be loaded into RAM by
the bootloader. If the SD card is partitioned as described in the [Bootloader
setup](../install_and_configure/bootloader_setup.md) section, the `BOOT`
partition is used for this by placing the application software file in the
root of the partition.

An advantage of this approach is that it makes use of a single medium that (a)
is already being used to store U-Boot and (b) generally has a much larger
capacity than is required by U-Boot alone.

A disadvantage is that while U-Boot is likely to be a relatively unchanging
artefact (once it has been configured for a particular board), during
development the application is likely to be modified repeatedly, and removing,
reprogramming, and replacing the SD card is inconvenient and physically
stresses the card and its mountings.

#### Loading from USB Flash Drive

The MaaXBoard has two USB 3.0 connectors that U-Boot is able to access, so the
application software file may be stored on a removable USB flash drive and
loaded into RAM by U-Boot. Ordinarily U-Boot would expect the application
software file to be placed at the root of a FAT formatted drive.

Compared with loading from SD card, this approach has the advantage of leaving
the SD card and its U-Boot image undisturbed, although it still involves
physical insertion and removal of the USB flash drive on both the development
board and the Host Machine whenever a new version is to be tested.

#### Loading via TFTP

The MaaXBoard has an Ethernet port that U-Boot is able to access, and the
application software file may be downloaded from the host machine over TFTP
(Trivial File Transfer Protocol), a convenient and popular method for booting.

Connection options include either a direct wired Ethernet connection between
the host machine and the MaaXBoard:

![TFTP option direct connection](../install_and_configure/figures/TFTP-option-direct.png)

Or a network connection via a hub / router:

![TFTP option router connection](../install_and_configure/figures/TFTP-option-router.png)

Loading via TFTP is considered to be the most convenient method within an
application development environment as there is no need to keep plugging and
unplugging anything from the board. To load the application software file via
TFTP, the file needs to be made available for download from the TFTP server.


#### Setting up a netboot server using TFTP 

Below are instructions for setting up TFTP on Linux:

1. [Dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html) is the application
   used to provide a network infrastructure. The program can be installed
using your provided package manager (for Debian, this would be `apt`).

```
sudo apt install dnsmasq
```

2. Create the root folder where the application software file  will be stored.
   In this example, the path will be `/var/lib/tftpboot`.

3. Identify the Ethernet interface you will be connecting the board to using
   `ip addr` command from the terminal.

```
$ ip addr
1. eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP gruop default qlen 1000
    link/ether [IPv4 ADDRESS] brd ff:ff:ff:ff:ff:ff
    altname enp2s0
    inet 10.0.0.253/24 scope global eno2
        valid_lft forever preferred_lft forever
    inet6 [IPv6 ADDRESS] scope link
        valid_lft forever preferred_lft forever
```

From this command, the necessary information is the *mac address* of the
interface (01:23:45:67:89:0a in this case), and the *inet address*
(10.0.0.253).

4. Edit the file `/etc/dnsmasq.conf` with the output of the ip addr command.
   The dnsmasq.conf file takes this format:

```
interface=<interface_name>
dhcp-range=<start_ip>,<end_ip>,<lease_time>
dhcp-host=<mac_address>,<hostname>,infinite
dhcp-boot=<image_name>
enable-tftp
tftp-root=<root_folder>
```

- interface -> Specifies which network interface dnsmasq will listen on for DHCP and TFTP requests
- dhcp-range -> Defines the range of IP addresses that dnsmasq can allocate to devices on the network via DHCP.
- dhcp-host -> Maps a specific MAC address to a hostname and optionally assigns a permanent IP address (infinite lease time)
- dhcp-boot -> Specifies the boot file that should be served to clients requesting a network boot via TFTP
- enable-tftp -> Enables the TFTP (Trivial File Transfer Protocol) server functionality within dnsmasq. 
- tftp-root -> Specifies the directory where the TFTP server will look for files to serve.

For the output listed in step 3, the file will look like this:

```
interface=eno2
dhcp-range=10.0.0.101,10.0.0.200,12h
dhcp-host=01:23:45:67:89:0a,svr1,infinite
dhcp-boot=application_software.file
enable-tftp
tftp-root=/var/lib/tftpboot
```

5. With the setup complete for dnsmasq, the service can be started and
   enabled. To ensure the service has properly started, the `status` command
can be used.

```
systemctl start dnsmasq
systemctl enable dnsmasq
systemctl status dnsmasq
```

If, at any point, any of the configuration files need to be changed, the
service will need to be restarted with `systemctl restart dnsmasq` to see
these changes reflected.

6. If a firewall is enabled, rules will need to be added to allow requests to
   pass to the dnsmasq server. The following commands will permit requests:

```
iptables -A INPUT -i eno2 --dport 69 -j ACCEPT
iptables -A INPUT -i eno2 -p tcp --dport 67:68 -j accept
```

7. The board is now ready to use the tftp server. The bootloader will try to
   boot using `application_software.file` stored in `/var/lib/tftpboot`.

8. If an error occurs, U-Boot will drop to a prompt permitting investigation.

### U-Boot Configuration File

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
