# Architecture Overview

It is assumed the CAmkES case study [architecture document](../camkes_case_study_application/architecture.md) had been read previous to reading this document.

The architecture of the Microkit demonstrator is shown below.

![Demonstrator architecture](encrypter_arch.png)

The Microkit architecture is different to the CAmkES architecture as it does not include the picoserver, Timeserver or EthDriverUboot modules because there is no ethernet capability in the Microkit case study. Arrow labels refer to Microkit connector types (some concerned with data flow, some with control flow), which are elaborated in the key. More details about Microkit connector types may be found in the Microkit manual, but the fundamental types are Protected procedure and Notification (see examples such as Protected procedure in the key).

## Protection domains and Connector Types

Protected procedure is an appropriate connector type for the character-by-character data flow between KeyReader and Crypto because it sends a singular message when invoked. The encrypted characters are transferred to the Transmitter PD via a shared circular buffer, where Crypto writes to the head of the buffer and Transmitter reads from its tail. The buffer is implemented as a shared memory region. When there is data to be read in the buffer Crypto notifies Transmitter that data needs to be read via the notification mechanism. Transmitter acts upon notifications by reading all available characters until the buffer is empty.

## Device Drivers

The Microkit case study only requires two hardware devices compared with CAmkES's three. This is because the ethernet device is not needed. 

As can be seen from the architecture diagram, the two hardware devices needed are:

1. The USB device in the KeyReader protection domain

2. The SD/MMC device in the Transmitter protection domain
