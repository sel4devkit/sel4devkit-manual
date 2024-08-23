# HDMI Driver

## Introduction

For this task the aim was to create an HDMI display driver. For inspiration we looked at U-Boot’s imx8m display driver because it is BSD licensed and minimally featured which was useful to use as an initial foundation to build upon. We opted to copy the code into our repository rather than have a fork like we did with the xHCI driver. This is because we used a minimal amount of U-Boot's code and it was easier to manage compared to keeping a fork of a large repository up to date.

The repository for this project is located [here](https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-hdmi-driver).

## Displaying a Static Image

The first goal was to understand U-Boot’s display driver and to set up our memory regions for the frame buffer and the physical devices required by the driver. After building and running the U-Boot example, we looked through the source code and found relevant sections in IMX8M technical specification to get a better understanding of how to write the display driver. We currently rely on the firmware provided by U-Boot which needs to be configured when setting up the development environment.

Through reading the technical specification we learnt that the two main components of the Maaxboard needed for the driver are the DCSS (Display Controller Subsystem) and the HDMI TX Controller. With this information we were able to understand the purpose of the memory register read and write operations and which register bits needed to be set for specific functionality. We decided to use one protection domain for the simplicity of having one area to handle all operations. 

After gaining a deeper understanding of Maaxboard and U-Boots implementation, we set values for the essential memory registers including where to set the address of the frame buffer to. For the frame buffer, we defined a region of memory that was large enough for our currently selected screen resolution and bit depth.

In order to read and write from specific memory registers, they must be explicitly defined in the system file for the PD that they are being accessed from. This is an essential concept to grasp when working with Microkit. The majority of the code was taken from U-Boot, so the main focus of this part of the task was to set up the parts of the code that directly interfaced with the hardware. For other projects this could include registering and handling interrupts. 

Our initial display configuration had a screen resolution of 1280x720 and a colour depth of 32 bit RGB. This meant that each pixel was composed of 32 bits (8 bits reserved for each colour and an additional alpha channel for colour transparency). With this information, we were able to display four equally spaced bars across the screen as red, green, blue and white. We then experimented with different screen resolutions which involved re-defining the size of the frame buffer so that it could accommodate larger screen resolutions.

## Displaying a Moving Image

The next goal was to display a moving image, which first involved learning about the theory of double buffering and understanding the capabilities of the Maaxboard’s DCSS. Double buffering makes use of two buffers. The first buffer stores the current frame and the second buffer stores the next frame. Whilst the current frame is being displayed the second buffer is being written to. During the window of time where the image on screen is not actively being redrawn, the pointers to each buffer are swapped.

U-Boot’s implementation did not provide any capability to drive video, so we needed to investigate and understand the technical specification in greater detail. We found a component of the DCSS called the Context Loader which can be configured to change various parts of the display state at specific timing intervals. This would act as the trigger to switch the pointers to each frame buffer.

For our implementation we decided to use two PD’s. One PD contains the display driver, consisting of the DCSS and the HDMI TX Controller. The other PD contains the API and examples which demonstrate different use cases of the driver. The system is designed such that the two PD’s communicate with each other through notifications and make use of a single shared DMA memory region. This memory region is split into different parts which are accessed by a pointer with a specific offset for different parts of the memory e.g frame buffer 1, frame buffer 2. This approach was implemented for simplicity so that the memory is easily accessible, however it would be better to define individual DMA regions for specific tasks, so that certain parts of the memory are only exposed to the PD that should have access to it.

The initial time to redraw the buffer was slow because we were writing 8 bits of the 32 bit pixel at a time. To combat this we optimised the code logic reducing loops and where possible, we wrote 16, 32 or 64 bits at a time to minimise the amount of separate CPU instructions. This example is limited by the technology that we have available to us. For fully-fledged display drivers, there will be extra bits of hardware that will be able to handle the different stages of processing video, drastically increasing performance. 

For moving images there is a visible redraw of the screen when switching between frames. This is most noticeable when the whole screen has changed. Multiple attempts have been made to combat this issue, which have been listed in the repo for this activity.

## Examples

The API contains the following examples:

* static_image - Displays 4 colour bars on the screen.
* resolution_change - Displays a square of the same size in pixels one after another at three different resolutions.
* rotating_bars - Displays 4 colour bars rotating across the screen.
* moving_square - A small square that moves around the screen, changing direction each time it hits the side of the screen.

Currently the project is built using a build script that calls make. The
dependencies are also built separately with a script for Picolibc and a
Makefile for Microkit. For information on how to build and run the examples
see:
[sel4devkit-maaxboard-microkit-hdmi-driver](https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-hdmi-driver)
