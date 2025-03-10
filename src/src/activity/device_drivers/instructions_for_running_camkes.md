# Instructions for running uboot-driver-example: CAmkES 

As usual, this assumes that the user is already running the CAmkES Docker container within the [build environment](../../install_and_configure/build_environment_setup.md), where we can create a directory and clone the code and dependencies.

```text
mkdir /host/uboot_test
cd /host/uboot_test
```

```bash
repo init -u https://github.com/sel4devkit/sel4devkit-maaxboard-camkes-manifest.git
```

```bash
repo sync
```

The test application includes an Ethernet operation (`ping`) with hard-coded IP addresses; these need to be customised for an individual's environment. The following lines of the source file `projects/camkes/apps/uboot-driver-example/components/Test/src/test.c` should be edited:

```c
run_uboot_command("setenv ipaddr xxx.xxx.xxx.xxx"); // IP address to allocate to MaaXBoard
run_uboot_command("ping yyy.yyy.yyy.yyy"); // IP address of host machine
```

Optionally, to `ping` to an address beyond the local network:

```c
run_uboot_command("setenv gatewayip zzz.zzz.zzz.zzz"); // IP address of router
run_uboot_command("setenv netmask 255.255.255.0");
run_uboot_command("ping 8.8.8.8"); // An example internet IP address (Google DNS)
```

From the `/host/uboot_test` directory, execute the following commands:

Configure the python environment:

```
python -m venv pyenv
source pyenv/bin/activate
pip install sel4-deps camkes-deps "protobuf<=3.20.*"
```

Create build area:

```text
mkdir build
cd build
```

Build application:

```bash
../init-build.sh -DCAMKES_APP=uboot-driver-example -DPLATFORM=maaxboard -DSIMULATION=FALSE
```

```bash
ninja
```

A successful build will result in an executable file called `capdl-loader-image-arm-maaxboard` in the `images` subdirectory. This should be copied to a file named `sel4_image` and then made available to the preferred loading mechanism, such as TFTP, as per [Bootloader](../../install_and_configure/configure_uboot.md#loading-via-tftp).
