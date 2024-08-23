# Remote Power Cycle

It is conventional for seL4 Microkernel to be deployed on embedded devices,
such as the Avent MaaXBoard. And it is conventional for applications installed
onto embedded devices to be designed to start, and never terminate. Thus, in a
development environment, it is very convenient to be able to routinely power
cycle the embedded device, to gain access to the bootloader, and adjust the
application.

The Avent MaaXBoard is powered from a standard USB Type C connection. Thus,
where the Avent MaaXBoard is physically present, the power switch to its USB-C
connection may be flipped off, and back on again, to trivially achieve a power
cycle.

However, where the Avent MaaXBoard is in a remote location, it is more awkward
to achieve a power cycle. One solution is to utilise a USB Hub with PPPS
(Per-Port Power Switching), as described below.

## PPPS (Per-Port Power Switching)

The [uhubctl](https://github.com/mvp/uhubctlk) project provides both software
and instructions for programmatically controlling power on PPPS equipped USB
ports. Since the MaaXBoard is powered via a standard USB Type C connection, it
may be powered from a PPPS equipped USB port, permitting its power supply to
be controlled remotely. 

Unfortunately, while there are many USB Hubs available, only a select few
implement the PPPS (Per-Port Power Switching) feature. The
[uhubctl](https://github.com/mvp/uhubctlk) maintains a list of USB Hubs that
are known to support this feature.

We have selected the "MEGA4 (4-Port USB 3.1 PPPS Hub for Raspberry Pi 4)",
which has been specifically developed to provide an embedded USB HUB
supporting PPPS. The device is intended for controlling power to a "Raspberry
Pi". However, since both the "Raspberry Pi" and "Avent MaaXBoard" are powered
from a standard USB Type C connection, it may also be used for our purpose.


## Deployment

The physical deployment is straight forward. The Host Machine is connected to
the PPPS USB Hub, and a PPPS USB Hub Port is connected to supply power to the
the MaaXBoard. The arrangement is illustrated below.

![PPPS Physical Deployment](../remote_power_cycle/figures/PPPS_physical_deployment.png)

Once the physical deployment is complete, the controlling software needs to be
established. The [uhubctl](https://github.com/mvp/uhubctlk) project provides a
complete and self-contained solution. The exact configuration of uhubctl will
likely vary depending on the specific details of the host operating system.

In our Linux Debian based development environment, uhubctl may be installed
thus:
```
sudo apt-get install uhubctl
```

The entire set of USB Ports, and their PPPS status, may be queried thus:
```
sudo /usr/sbin/uhubctl
```

In our deployment, the MEGA4 PPPS USB Hub resides at location "1-12.1". Where
its fourth port is used to power the MaaXBoard, its power may be remotely
cycled (turned off and back on again) as follows:
```
sudo /usr/sbin/uhubctl -l "1-12.1" -p 4 -a cycle
```

In the above, use of `sudo` is required, as by default manipulating the power
controls of USB Ports is an administrator (root) privilege. The use of `sudo`
may be avoided, by granting this privilege to standard users, as described and
maintained within the uhubctl documentation as [Linux USB
permissions](https://github.com/mvp/uhubctl?tab=readme-ov-file#linux-usb-permissions).
