# Microkit Hello World

The purpose of this example is to confirm that the Microkit environment is configured correctly. As usual, this assumes that the user is already running the Microkit Docker container within the [build environment](../install_and_configure/build_environment_setup.md), where we can create a directory and clone the code and dependencies.

## Getting the code 

```
git clone git@github.com:sel4devkit/sel4devkit-maaxboard-microkit-first-boot-hello-world.git
```

## Building 

The Microkit hello world example uses the make build system therefore make needs to be run in the repository:

```
cd sel4devkit-maaxboard-microkit-first-boot-hello-world
```

```
make get
make all
```

On completion of the compilation, the resulting executable is available at `/host/sel4devkit-maaxboard-microkit-first-boot-hello-world/out/program.img` on the build environment, or available at `/<host_directory>/sel4devkit-maaxboard-microkit-first-boot-hello-world/out/program.img` on the host machine, where `/<host_directory>` was the directory on the host mapped to the build environment.

## Example output 

The example output when executed on the target (as described in [bootloader](../first_boot/bootloader.md)) is demonstrated below:

```
u-boot=> go 0x50000000
## Starting application at 0x50000000 ...
LDR|INFO: altloader for seL4 starting
LDR|INFO: Flags:                0x0000000000000001
             seL4 configured as hypervisor
LDR|INFO: Kernel:      entry:   0x0000008040000000
LDR|INFO: Root server: physmem: 0x0000000040270000 -- 0x0000000040277000
LDR|INFO:              virtmem: 0x000000008a000000 -- 0x000000008a007000
LDR|INFO:              entry  : 0x000000008a000000
LDR|INFO: region: 0x00000000   addr: 0x0000000040000000   size: 0x000000000024c000   offset: 0x0000000000000000   type: 0x01
LDR|INFO: region: 0x00000001   addr: 0x0000000040270000   size: 0x0000000000006b40   offset: 0x000000000024c000   type: 0x01
LDR|INFO: region: 0x00000002   addr: 0x000000004024c000   size: 0x00000000000011a8   offset: 0x0000000000252b40   type: 0x01
LDR|INFO: region: 0x00000003   addr: 0x000000004024e000   size: 0x000000000000046c   offset: 0x0000000000253ce8   type: 0x01
LDR|INFO: region: 0x00000004   addr: 0x000000004024f000   size: 0x0000000000020070   offset: 0x0000000000254154   type: 0x01
LDR|INFO: copying region 0x00000000
LDR|INFO: copying region 0x00000001
LDR|INFO: copying region 0x00000002
LDR|INFO: copying region 0x00000003
LDR|INFO: copying region 0x00000004
LDR|INFO: CurrentEL=EL2
LDR|INFO: Resetting CNTVOFF
LDR|INFO: enabling MMU
LDR|INFO: jumping to kernel
Warning:  gpt_cntfrq 8333333, expected 8000000
Bootstrapping kernel
available phys memory regions: 1
  [40000000..c0000000]
reserved virt address space regions: 3
  [8040000000..804024c000]
  [804024c000..8040270000]
  [8040270000..8040277000]
Booting all finished, dropped to user space
MON|INFO: Microkit Bootstrap
MON|INFO: bootinfo untyped list matches expected list
MON|INFO: Number of bootstrap invocations: 0x00000009
MON|INFO: Number of system invocations:    0x0000003f
MON|INFO: completed bootstrap invocations
MON|INFO: completed system invocations
hello, world
```

