
## Architecture Overview

It is assumed the CAmkES case study [architecture document](../camkes_case_study_application/architecture.md) had been read previous to reading this document.

The architecture of the Microkit demonstrator is shown below.

![Demonstrator architecture](encrypter_arch.png)

The CAmkES and Microkit architectures are the same up to the Picoserver module, the Microkit connector types are Protected Procedure and Notification. 


### Protection domains and Connector Types

Protected procedure is an appropriate connector type for the character-by-character data flow between KeyReader and Crypto. The encrypted characters are transferred to the Transmitter PD via a shared circular buffer, where Crypto writes to the head of the buffer and Transmitter reads from its tail. The buffer is implemented as a shared memory region. When the buffer is full Crypto notifies Transmitter that the buffer is full and the data needs to be read via the notification mechanism. Transmitter acts upon notifications by reading all available characters until the buffer is empty.

### Device Drivers

As can be seen from the architecture diagram, three hardware devices are involved in the operation of the application.

1. The KeyReader protection domain requires access to the USB device to allow for plaintext characters to be input from a USB keyboard.

2. The Transmitter protection domain requires access to the SD/MMC device to allow for the ciphertext message to be output to a log file.

Device drivers for the required hardware access are supplied by the [U-Boot Driver Library](uboot_driver_library.md) previously introduced by this development kit.

Two separate instances of the library are used by the application, one per protection domain with a need for hardware device access. The capabilities of each protection domain, and their associated library instances, are configured such that each protection domain is only capable of accessing the minimum set of hardware devices required to perform the desired function.

For example, the Transmitter protection domain only has a need to access the SD/MMC device to write the ciphertext log file. As such, the capabilities of the Transmitter protection domain permit it to access the memory-mapped interface of the SD/MMC device; however no such capabilities are provided for the USB device. Any attempt by the Transmitter protection domain to access the memory-mapped interface of the USB device (e.g. in an attempt to read the plaintext keypresses) would therefore be prevented by seL4.
