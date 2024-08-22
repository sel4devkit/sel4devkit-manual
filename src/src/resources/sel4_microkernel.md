# seL4 Microkernel

The [seL4 Microkernel](https://sel4.systems), and its closely associated
components, is managed by the [seL4
Foundation](https://sel4.systems/Foundation), operating as a project under the
[Linux Foundation](https://www.linuxfoundation.org). The entirety of the seL4
Foundation contribution is made publicly available. More so, there are several
related efforts that provide further relevant contributions.

## Community

The main entry points to the seL4 community are as follows:

- [seL4 Microkernel](https://sel4.systems): The primary landing page for seL4,
  as maintained by the seL4 Foundation. This provides the latest information
and news related to seL4.

- [seL4 Microkernel Community Documentation](https://docs.sel4.systems): Large
  corpus of community maintained documentation associated with the seL4
Microkernel itself, many of its associated components, and projects
incorporating seL4 aspects.

- [seL4 Foundation Git Hub](https://github.com/sel4): The primary location for
  all seL4 content as maintained by the seL4 Foundation.

- [Trustworthy Systems](https://trustworthy.systems): A research group, based
  at the School of CSE (Computer Science and Engineering) of UNSW (University
of New South Wales) Sydney. The original developers of seL4, still very active
in the community, with various ongoing seL4 related research and projects.

- [seL4 Microkit Tutorial](https://trustworthy.systems/projects/microkit/tutorial/welcome.html):
A tutorial, prepared by Trustworthy Systems, for getting started with the seL4
Microkit, principally focusing on an emulated target (via the QEMU simulator).

- [Trustworthy Systems Git Hub](https://github.com/au-ts): The primary
  location for all seL4 content as maintained by Trustworthy Systems.

## Components

Several significant seL4 components are highlighted below. Many of these
components are directly utilised within this seL4 Developer Kit:

- [seL4 Microkernel](https://github.com/seL4/seL4): The seL4 Microkernel.

- [CAmkES](https://github.com/seL4/camkes-manifest): The entry point to CAmkES
  (component architecture for microkernel-based embedded systems).

- [Microkit](https://github.com/seL4/microkit): Retains Microkit, a simple and
  small framework for building and running applications atop the seL4
Microkernel.

- [sDDF](https://github.com/au-ts/sddf): The sDDF (seL4 Device Driver
  Framework). Provides a suite of generic capabilities (interfaces and
protocols) and also specific deployments (drivers and examples). The
contribution is geared for easing the deployment of device drivers atop the
seL4 Microkernel.

- [libvmm](https://github.com/au-ts/libvmm): A VMM (Virtual Machine Monitor)
  library, permitting the execution of virtualised guest hosts, atop the seL4
Microkernel.

- [Lions OS](https://lionsos.org): Trustworthy Systems are developing the
  Lions OS (Operating System), building atop both the principles and
technology associated with the seL4 Microkernel.

## Context

The seL4 Microkernel may be reasonably characterised as a technology of
increasing relevance and interest. 

Historically, it is relatively ordinary for an academic system to deliver
novel advancements in high-assurance, while sacrificing the algorithmic
complexity associated with achieving high-performance. Or, conversely, for a
platform to offer high-performance, while sacrificing the controls and
constraints associated with achieving high-assurances.  Thus, a key
differentiator of the seL4 Microkernel is its _simultaneous_ focus, and
evidenced achievement, of both high-assurance and high-performance.

In particular, in the current modern climate, it is straight forward to
identify numerous security critical applications which could immediately
benefit from building atop an existing high-assurance and high-performance
platform.

The formation the seL4 Foundation (07 April 2020) ([press
release](https://www.linuxfoundation.org/press/press-release/sel4-microkernel-optimized-for-security-gets-support-of-linux-foundation))
is a key indicator of the growing importance of the seL4 Microkernel, and the
explicit intention to enhance and mature its associated contributions.

The two main frameworks for developing seL4 applications are:

- [CAmkES](https://github.com/seL4/camkes-manifest): Introduced in 2015.
- [Microkit](https://github.com/seL4/microkit): Introduced in 2020.

These two frameworks adopt very contrasting approaches. CAmkES provides a rich
feature set, but has greater complexity. Microkit provides a very minimum
feature set, but has greater simplicity.

Both frameworks remain supported by the seL4 Foundation, and are accommodated
in this seL4 developer kit. However, in many respects, Microkit may be
regarded as a response to the lessons learned from CAmkES, and is gradually
emerging as the logical default choice for any new development. Perhaps,
fundamentally, Microkit is closer in spirit to Microkernels, in providing
essential behaviours only, and thus provides a more compelling fit as a seL4
Microkernel component. A guide for translating CAmkES applications into
Microkit is available externally ([CAmkES to
Microkit](https://github.com/au-ts/camkes_to_microkit_guide/blob/main/guide.md)).
