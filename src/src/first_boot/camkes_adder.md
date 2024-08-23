# CAmkES adder

The purpose of this example is to confirm that the CAmkES environment is configured correctly. As usual, this assumes that the user is already running the CAmkES Docker container within the [build environment](../install_and_configure/build_environment_setup.md), where we can create a directory and clone the code and dependencies.

## Getting the code 

```
git clone git@github.com:sel4devkit/sel4devkit-maaxboard-camkes-first-boot-adder.git
```

## Building 

The CAmkES adder example uses the make build system therefore make needs to be run in the repository:

```
cd sel4devkit-maaxboard-camkes-first-boot-adder
```

```
make get
make all
```

On completion of the compilation, the resulting executable is available at `/host/sel4devkit-maaxboard-camkes-first-boot-adder/out/program.img` on the build environment, or available at `/<host_directory>/sel4devkit-maaxboard-camkes-first-boot-adder/out/program.img` on the host machine, where `/<host_directory>` was the directory on the host mapped to the build environment.

## Example output 

The example output when executed on the target (as described in [bootloader](../first_boot/bootloader.md)) is demonstrated below:

```
u-boot=> bootelf 0x50000000
## Starting application at 0x4085e000 ...

ELF-loader started on CPU: ARM Ltd. Cortex-A53 r0p4
  paddr=[4085e000..40b6d137]
No DTB passed in from boot loader.
Looking for DTB in CPIO archive...found at 409a0a08.
Loaded DTB from 409a0a08.
   paddr=[4023f000..40249fff]
ELF-loading image 'kernel' to 40000000
  paddr=[40000000..4023efff]
  vaddr=[ffffff8040000000..ffffff804023efff]
  virt_entry=ffffff8040000000
ELF-loading image 'capdl-loader' to 4024a000
  paddr=[4024a000..40462fff]
  vaddr=[400000..618fff]
  virt_entry=408e98
Enabling MMU and paging
Jumping to kernel-image entry point...

Warning:  gpt_cntfrq 8333333, expected 8000000
Bootstrapping kernel
available phys memory regions: 1
  [40000000..c0000000]
reserved virt address space regions: 3
  [ffffff8040000000..ffffff804023f000]
  [ffffff804023f000..ffffff80402492c7]
  [ffffff804024a000..ffffff8040463000]
Booting all finished, dropped to user space
client: what's the answer to 342 + 74 + 283 + 37 + 534 ?
adder: Adding 342
adder: Adding 74
adder: Adding 283
adder: Adding 37
adder: Adding 534
client: result was 1270
```