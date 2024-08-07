# HDMI Driver

For this task the aim was to create an hdmi display driver. For inspiration we looked at U-Boot’s implementation of an imx8m display driver because it is BSD licensed and minimally featured, which was useful to build upon as an initial foundation.

The repository for this project is located at: [https://github.com/sel4-cap/sel4-hdmi ](https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-hdmi-driver)

## Displaying a static image

The first goal was to understand U-Boot’s display driver and to set up our memory regions for the frame buffer and the physical devices required by the driver. After building and running the U-Boot example, we looked through the source code and found relevant sections in IMX8M technical specification to get a better understanding of how to write the display driver. We currently rely on the firmware provided by U-Boot which needs to be configured when setting up the development environment.

Through reading the technical specification we learnt that the two main components of the Maaxboard needed for the driver are the DCSS (Display Controller Subsystem) and the HDMI TX Controller. With this information we were able to understand the purpose of the memory register read and write operations and which register bits needed to be set for specific functionality. We decided to use one protection domain for the simplicity of having one area to handle all operations. 

After gaining a deeper understanding of Maaxboard and U-Boots implementation, we set values for the essential memory registers including where to set the address of the frame buffer to. For the framebuffer, we defined a region of memory that was large enough for our currently selected screen resolution and bit depth.

In order to read and write from specific memory registers, they must be explicitly defined in the system file for the PD that they are being accessed from. This is an essential concept to grasp when working with microkit. The majority of the code was taken from U-Boot, so the main focus of this part of the task was to set up the parts of the code that directly interfaced with the hardware. For other projects this could include registering and handling interrupts. 

Our initial display configuration had a screen resolution of 1280x720 and a colour depth of 32 bit RGB. This meant that each pixel was composed of 32 bits with 8 bits reserved for each colour and an additional alpha channel for colour transparency. With this information, we were able to create a simple image displaying 4 colours red, green, blue and white as 4 equally spaced bars across the screen. We then experimented with different screen resolutions which involved re-defining the size of the framebuffer so that it could accommodate larger screen resolutions.


## Displaying a moving image

The next goal was to display a moving image, which first involved learning about the theory of double buffering and understanding the capabilities of the Maaxboard’s DCSS. Double buffering makes use of two buffers. The first buffer stores the current frame and the second buffer stores the next frame. Whilst the current frame is being displayed the second buffer is being written to. During the window of time where the image on screen is not actively being redrawn, the pointers to each buffer are swapped.

U-Boot’s implementation did not provide any capability to drive video, so we needed to investigate and understand the technical specification in greater detail. We found a component of the DCSS called the Context Loader which can be configured to change various parts of the display state at specific timing intervals. This would act as the trigger to switch the pointers to each frame buffer.

For our implementation we decided to use two PD’s. One PD contains the display driver, consisting of the DCSS and the HDMI TX Controller. The other PD contains the api and examples which demonstrate different use cases of the driver. The system is designed such that the two PD’s communicate with each other through notifications and make use of a single shared DMA memory region. This memory region is split into different parts which are accessed by a pointer with a specific offset for different parts of the memory e.g frame buffer 1, frame buffer 2. This approach was implemented for simplicity so that the memory is easily accessible, however it would be better to define individual DMA regions for specific tasks, so that certain parts of the memory are only exposed to the PD that should have access to it.

The initial time to redraw the buffer was slow because we were writing 8 bits of the 32 bit pixel at a time. To combat this we optimised the code logic reducing loops and where possible, we wrote 16, 32 or 64 bits at a time to minimise the amount of separate cpu instructions. This example is limited by the technology that we have available to us. For fully-fledged display drivers, there will be extra bits of hardware that will be able to handle the different stages of processing video, drastically increasing performance. 

For moving images a visible redraw is seen when switching between frames which is most noticeable when the entire screen has changed. Multiple attempts have been made to combat this issue, which have been listed in the repo for this activity.

The API contains the following examples:

* static_image - Displays 4 colour bars on the screen.
* resolution_change - Displays a square of the same size in pixels one after another at three different resolutions.
* rotating_bars - Displays 4 colour bars rotating across the screen.
* moving_square - A small square that moves around the screen, changing direction each time it hits the side of the screen.


Nice to have:

* Add some more specific code examples (What other things in this process could help someone to do something similar)
* Information on how to read the specification to find the memory register and how each memory register is set up, how to toggle bits, read and write to memory etc
