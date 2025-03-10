# Instructions for running the uboot-driver-example: Microkit

As usual, this assumes that the user is already running the Microkit Docker container within the [build environment](../../install_and_configure/build_environment_setup.md), where we can create a directory and clone the code and dependencies.

```text
mkdir /host/uboot_test
cd /host/uboot_test
```

```bash
repo init -u git@github.com:sel4devkit/sel4devkit-maaxboard-microkit_manifest.git
```

```bash
repo sync
```

The test application includes an Ethernet operation (`ping`) with hard-coded IP addresses; these need to be customised for an individual's environment. The following lines of the source file `examples/maaxboard/uboot-driver-example/uboot-driver-example.c` should be edited:

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

From the `/host/uboot_test/project_libs` directory, execute the following command:

```bash
./init-build.sh -DMICROKIT_APP=uboot_driver_example -DPLATFORM=maaxboard
```

A successful build will result in an executable file called `sel4_image` in the `examples/maaxboard/uboot-driver-example/example-build` subdirectory.

Once build there is an option to rebuild the entire project using the below command:

```bash
./init-build.sh -DMICROKIT_APP=uboot_driver_example -DPLATFORM=maaxboard -DBUILD_TYPE=rebuild
```
