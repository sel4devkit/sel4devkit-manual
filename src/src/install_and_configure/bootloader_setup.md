# Bootloader Setup

## Overview

When a computer is turned off, its software remains stored in non-volatile memory. When the computer is powered on, a bootstrap loader is required: a small, low-level program to configure the computer's memory and devices sufficient to then be able to load further software, such as a bare-metal application or operating system, into RAM and then call it.

**Das U-Boot** (known as "the Universal Boot Loader" and often shortened to U-Boot) is an open-source bootloader commonly used in embedded devices. For such low-level operations, it has to be customized for the hardware on which it is running.

As part of this developer kit we have provided both prebuilt U-Boot binaries (see [here](sd_card_preparation.md)) and tooling to build U-Boot binaries (see [here](building_uboot.md)) suitable for the MaaXBoard.
