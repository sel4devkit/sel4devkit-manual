# Microkit Case Study Application 

This section works through the changes completed to port the case study application to Microkit.

As well as the changes to the [Architecture](../../activity/microkit_case_study_application/architecture.md) and [Design](../../activity/microkit_case_study_application/detail.md), other infrastructure changes had to be made to make the case study compatible with Microkit:

## Picolibc

Microkit does not contain a bundled libc; therefore, it was decided to port picolibc to Microkit. Picolibc is a C library specifically designed for use in embedded systems, providing a lightweight and efficient implementation of the C standard library functions. This makes it an ideal choice to complement Microkit, enhancing its capabilities without adding unnecessary overhead.

The ported picolibc for Microkit is linked [here](https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-picolibc) with instructions for building and linking with Microkit. To use dynamic memory allocation (malloc) the __heap_start and __heap_end symbols (defined in the system file) needed to be added to the picosbrk.c file. This tells picolibc where the memory location of the heap.

## U-Boot

[U-boot](https://github.com/sel4devkit/u-boot/tree/microkit) has been ported to be used with Microkit using the fork and patch method. The majority of the changes were made to remove name space clashes with picolibc.

## Device tree

Inline assembly is used to import the device tree to Microkit:

```c
#define STR2(x) #x
#define STR(x) STR2(x)
#define INCBIN_SECTION ".rodata"
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
INCBIN(device_tree, DTB_PATH); 

const char* _end = incbin_device_tree_end;
```

## DMA library

The CAmkES dma allocated has been adapted to work with Microkit. The initialisation of the DMA library was separated out from the IO operations of CAmkES. The CAmkES DMA library allocated multiple pools of dma to be used in each component however in Microkit multiple pools of DMA can be assigned and allocated in the system file therefore the library was adapted so only one pool of DMA memory is allocated. The address and size of the DMA pool are also configured in the [system file](https://github.com/sel4devkit/sel4devkit-maaxboard-microkit-security-demo-example/blob/main/security_demo.system). 