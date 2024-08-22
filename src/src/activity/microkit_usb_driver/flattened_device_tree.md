# Flattened Device Tree
The Flattened Device Tree (FDT) functionality allows much more flexibility and generic usage of our driver. We use the libfdt library provided by NetBSD (but also available as a stand-alone library) to traverse and process the tree which lowers the amount of the driver that needs to be statically programmed.

Due to Microkit lacking the ability to load the utilised device tree (for some reason) we have to load in the binary using inline assembly. This can be seen in the memory handler PD:
```C
// this aligns start address to 16 and terminates byte array with explicit 0
// which is not really needed, feel free to change it to whatever you want/need
#define INCBIN(name, file) \
    __asm__(".section " INCBIN_SECTION "\n" \
            ".global incbin_" STR(name) "_start\n" \
            ".balign 16\n" \
            "incbin_" STR(name) "_start:\n" \
            ".incbin \"" file "\"\n" \
            \
            ".global incbin_" STR(name) "_end\n" \
            ".balign 1\n" \
            "incbin_" STR(name) "_end:\n" \
            ".byte 0\n" \
    ); \
    extern __attribute__((aligned(16))) const char incbin_ ## name ## _start[]; \
    extern                              const char incbin_ ## name ## _end[]
```

This memory address is then distributed throughout the other protection domains where it can be used with libfdt. This has currently only been tested with a MaaXBoard by virtue of hardware availability, but the FDT traversal will work with any device tree. The FDT is then initialised and can be called by initialisation functions to extract device specific information without the need for static configuration of the driver for each unique device, lowering the barrier for use.

Traversal of the FDT can take some time, so I have included the possibility to set the offset manually to skip traversal (since the traversal is only required to calculate the offset of the dwc3 node). To disable manual usage, set `offset` to `-1`. The debug output will include the offset that can be used to skip the traversal for future usage. 
