# Build Environment Setup

The build environment is the environment within which all binaries for the
target environment are built; i.e. the environment that provides the required
compilation toolchain.

To simplify the requirements on the host environment and to enable rapid
setup, the build environment is provided as a pre-built Docker image.

## Environment Details

The build environment is a Debian Linux system pre-installed with all of the
required development tools. The primary tools supplied are:

- [Git](https://git-scm.com) version control system.
- [Repo](https://gerrit.googlesource.com/git-repo/+/refs/heads/master/README.md) Git repository management tool.
- [aarch64-linux-gnu](https://gcc.gnu.org) cross compiler toolchain targeting the ARM AArch64 instruction set.
- [Make](https://www.gnu.org/software/make/), [CMake](https://cmake.org), [Ninja](https://ninja-build.org) and [MESON](https://mesonbuild.com/) build automation tools.

## Installation

[Host machine setup](../install_and_configure/host_setup.md) must be completed, specifically
installation of Docker, and the Docker tools must be active prior to
installation of the build environment.

At this stage, the pre-built Docker image may be incorporated into the Docker
tools. Different approaches are recommended for Windows and Linux, to provide
a more effective integration into those different host Operating Systems.

### Docker Usage

Given their considerably different technical dependencies, separate Docker
Images are provided for CAmkES and Microkit. Normal usage involves acquiring
and running the appropriate Docker Image, optionally mapping in a local
development area (HOST_PATH), and (for Linux) a local home area (HOME_PATH).

Note that, apart from any mapped areas, the entirety of the Docker Image will
be lost when the Docker Image is exited. This is deliberate and desirable,
ensuring a consistent starting environment for each session.

### Windows

Given the limited shell provided by Windows, usage of its Docker Images are
best coordinated directly. 

#### Windows CAmkES

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

#### Windows Microkit

Pulling Docker Image (user-dev):
```
docker pull ghcr.io/sel4devkit/sel4devkit-maaxboard-microkit-docker-dev-env/user-dev:latest
```

Running Docker Image (user-dev):
```
docker run --rm --interactive --tty --hostname "sel4devkit-maaxboard-microkit" \
    ghcr.io/sel4devkit/sel4devkit-maaxboard-microkit-docker-dev-env/user-dev:latest \
    --mount type=bind,source="<HOST_PATH>",target="/host"
    /bin/bash --login
```

### Linux

Usage of the Linux Docker Images are coordinated indirectly via a separate
helper repository as follows:
- __CAmkES__: `git clone "git@github.com:sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env.git"`
- __Microkit__: `git clone "git@github.com:sel4devkit/sel4devkit-maaxboard-camkes-docker-dev-env.git"`


Within this repository, show usage instructions:
```
make
```

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

#### User Me

Pulling pre-built Docker Image (dep):
```
make pull IMAGE=dep
```

Building Docker Image (user-me):
```
make build IMAGE=user-me
```

Running Docker Image (user-me):
```
make run IMAGE=user-me HOST_PATH=<HOST_PATH> HOME_PATH=<HOME_PATH>
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
