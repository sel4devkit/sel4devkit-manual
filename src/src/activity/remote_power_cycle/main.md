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

## MEGA4 (4-Port USB 3.1 PPPS Hub for Raspberry Pi 4)

While there are many USB Hubs 

## Deployment



## Usage

sudo apt-get install uhubctl



sudo /usr/sbin/uhubctl

Identify the address...


Indvidual control....

sudo /usr/sbin/uhubctl -l "1-12.1" -p 4 -a cycle







perhaps being
shared across a team, 



in close physically, it may be trivially power
cycled, by removing and 



When the 




applications to start and never
terminite 


targeting the 

The development of applications of with the 

atop the seL4 Microkernel, particularly where interacting with




https://thepihut.com/products/mega4-4-port-usb-3-1-ppps-hub-for-raspberry-pi-4




