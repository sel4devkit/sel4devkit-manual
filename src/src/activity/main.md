# Activities

These techical activities provide a range of examples which seek to
demonstrate how to develop with seL4. For each activity our development
process is discussed which intends to shed light on the our experience with
writing programs in seL4. This aims to show the lessons we learnt along the
way and act as inspiration for others wishing to embark on writing their own
systems and programs with seL4.

- [Microkit Memory Probe](../activity/microkit_memory_probe/main.md): Simple Microkit program illustrating memory access.
- [Remote Power Cycle](../activity/remote_power_cycle/main.md): Use of PPPS (Per-Port Power Switching) USB Hub, to  programmatically power cycle the MaaXBoard, to ease remote development.
- [Use U-Boot Device Drivers](../activity/device_drivers/main.md): Guidance on adding device drivers to seL4.
- [Test application: picoserver_uboot](../activity/picoserver_uboot/main.md): Picoserver U-Boot test application.
- [Porting Device Drivers to a New Platform](../activity/new_platform/main.md): Guidance for porting the U-Boot driver library to a new platform.
- [Adding New U-Boot Device Driver](../activity/new_driver/main.md): Guidance for adding a new driver to the U-Boot driver library
- [Guide to Porting seL4](../activity/guide_to_porting_seL4/main.md): Guidance for porting seL4 to a new platform.
- [SPI Bus BMP280 Pressure Sensor](../activity/spi_bus_bmp280_pressure_sensor/main.md): Testing the Serial Peripheral Interface (SPI) driver with a pressure sensor.
- [CAmkES Case Study Application](../activity/camkes_case_study_application/main.md): Demonstrating device drivers being used within a larger application nominally a keyboard-based encryption device.
- [Microkit Case Study Application](../activity/microkit_case_study_application/main.md): Porting of the case study application to Microkit.
- [Microkit USB Driver](../activity/microkit_usb_driver/main.md): A XHCI USB driver with support for Keyboard, Mouse, Resistive Touch Screen, USB Hub and Mass Storage Devices.
- [Microkit HDMI Driver](../activity/microkit_hdmi_driver/main.md): A basic HDMI Driver capable of displaying static images and simple moving images.
- [Microkit Single Linux VMM](../activity/microkit_vmm_single_linux_guest/main.md): Loads up a single Linux virtual machine with serial I/O.
- [Microkit Dual Linux VMM with TTY Multiplexing](../activity/microkit_vmm_dual_linux_guest_tty_multiplex/main.md): Loads up two Linux virtual machines with serial I/O and multiplexing for each virtual machine.
- [Microkit Dual Linux VMM with USB Routing](../activity/microkit_vmm_dual_linux_guest_usb_routing/main.md): An investigation into communication between virtual machines.
