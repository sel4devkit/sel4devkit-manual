# Install and Configure

This section details how to configure a build environment with all tools required to generate seL4 executable images.

Development is conducted across three different environments:

1. __Host Machine__: The developer's host machine. This can be running macOS, Linux, or Windows.

2. __Build environment__: The environment within which all binaries for the target environment are built. This is a Linux-based development environment running within a [Docker](https://www.docker.com) container on the host machine. The use of a Docker container to provide all of the tooling required to build seL4 applications for the target platform greatly simplifies the requirements of the host machine.

3. __Target Platform__: The [Avnet MaaXBoard](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/maaxboard/maaxboard), a single board computer based around the [NXP i.MX 8M SoC (system on chip)](https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8m-family-armcortex-a53-cortex-m4-audio-voice-video:i.MX8M). This is the environment upon which seL4 binaries are executed. User interaction with the target platform is performed via a serial console from the host machine.

The required configuration of the host and target environments are detailed in
the [Host Setup](../install_and_configure/host_setup.md) and [Target Setup](../install_and_configure/target_setup.md) sections.
A preconfigured build environment is supplied as part of this developer kit as
detailed in the [Build Environment Setup](../install_and_configure/build_environment_setup.md) section.
[Bootloader setup](../install_and_configure/bootloader_setup.md) describes how to install and the
bootloader U-Boot.
