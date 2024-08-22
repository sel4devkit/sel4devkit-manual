# sel4test

As a worked example throughout this section the [seL4Test](https://docs.sel4.systems/projects/sel4test) project will be used. seL4Test is a test suite for seL4 developed and maintained by the seL4 Foundation.

This section of the document assumes the [build environment setup](../install_and_configure/build_environment_setup.md) has been completed and the user is using the [CAmkES docker environment](../install_and_configure/build_environment_setup.md#camkes). All commands provided within this section are to be executed within the build environment; i.e. please ensure that you have followed the instructions in the [build environment setup's usage](../install_and_configure/build_environment_setup.md#usage) section and that you execute the following commands from inside the Docker container.

## Context

The seL4Test example that is built in this section is a result of an seL4 port for the Avnet MaaXBoard that we created for this developer kit. Whilst our seL4 port is not documented here in detail, there is some guidance on this in the [Guide to Porting seL4](#appendices) appendix, which includes links to the Git commits that added the MaaXBoard port to the main seL4 repositories.

## Getting the Code

Clone the repository:

```bash
git clone git@github.com:sel4devkit/sel4devkit-maaxboard-first-boot-sel4test.git
```

## Building

The sel4test example uses the make build system therefore make needs to be run in the repository:

```
cd sel4devkit-maaxboard-first-boot-sel4test
```

```
make get
make all
```

On completion of the compilation, the resulting executable is available at `/host/sel4devkit-maaxboard-first-boot-sel4test/out/program.elf` on the build environment, or available at `/<host_directory>/sel4devkit-maaxboard-first-boot-sel4test/out/program.elf` on the host machine, where `/<host_directory>` was the directory on the host mapped to the build environment.

