# Build Environment Setup

The build environment is the environment within which all binaries for the target environment are built; i.e. the environment that provides the required compilation toolchain.

To simplify the requirements on the host environment and to enable rapid setup, the build environment is provided as a pre-built Docker image.

## Environment Details

The build environment is a Debian Linux system pre-installed with all of the required development tools. The primary tools supplied are:

- [__Git__](https://git-scm.com) version control system.
- [__Repo__](https://gerrit.googlesource.com/git-repo/+/refs/heads/master/README.md) Git repository management tool.
- [__aarch64-linux-gnu__](https://gcc.gnu.org) cross compiler toolchain targeting the ARM AArch64 instruction set.
- [__arm-linux-gnueabi__](https://gcc.gnu.org) cross compiler toolchain targeting the ARM AArch32 instruction set.
- [__Make__](https://www.gnu.org/software/make/), [__CMake__](https://cmake.org), [__Ninja__](https://ninja-build.org) and [__MESON__](https://mesonbuild.com/) build automation tools.

## Installation

[Host machine setup](host_setup.md) must be completed, specifically installation of Docker, and the Docker tools must be active prior to installation of the build environment.

Installation of the build environment comprises the download of a pre-built Docker image into the Docker tools. This can be performed from the command line on the host machine as follows:

### CAmkES 

```bash
git clone "git@github.com:sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env.git"
```

### Microkit 

```bash
git clone "git@github.com:sel4devkit/sel4devkit-maaxboard-microkit-docker-dev-env.git"
```

## Usage

Normal usage would involve pulling a pre-built Docker Image, and then running
this Docker Image, optionally mapping in a local development area (HOST_PATH),
and a local home area (HOME_PATH).

Note that, apart from any mapped areas, the entirety of the Docker Image will
be lost when the Docker Image is exited. This is deliberate and desirable,
ensuring a consistent starting environment for each session.

Two different entry points are provided, as "user-dev" and "user-me":
* The "user-dev" operates with a fixed user name "developer", granted password
  free access to root, via sudo. This configuration is fully defined, and thus
may be prepared in advance. This property permits a very simple deployment,
and is particularly suited to Windows.
* The "user-me" is intended to be built, and then deployed, for a specific
  invoking user. It operates with the username of the invoking user, granted
password free access to root, via sudo. This configuration can not be prepared
in advance, but does provide a smoother integration for the invoking user. It
is particularly suited to Linux.

Once the Docker Image is started, its version may be inspected as follows:
```
cat /version.txt
```

### Windows

Only Deployment is supported on Windows.

Pulling Docker Image (user-dev):
```
docker pull ghcr.io/sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env/user-dev:latest
```

Running Docker Image (user-dev):
```
docker run --rm --interactive --tty --hostname "sel4devkit-maaxboard-camkes" \
    ghcr.io/sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env/user-dev:latest \
    --mount type=bind,source="<HOST_PATH>",target="/host"
    /bin/bash --login
```

### Linux

Deployment, and Maintenance, is supported on Linux.

Show usage instructions:
```
make
```

#### User Developer

Pulling Docker Image (user-dev):
```
make pull IMAGE=user-dev
```

Running Docker Image (user-dev):
```
make run IMAGE=user-dev HOST_PATH=<HOST_PATH> HOME_PATH=<HOME_PATH>
```

#### User Me

Pulling pre-built Docker Image (dep):
```
make pull IMAGE=dep
```

Building Docker Image (user-me):
```
make build IMAGE=user-me
```

Running Docker Image (user-dev):
```
make run IMAGE=user-me HOST_PATH=<HOST_PATH> HOME_PATH=<HOME_PATH>
```

On build environment startup the user will be placed into an interactive shell within the `/host` directory.
