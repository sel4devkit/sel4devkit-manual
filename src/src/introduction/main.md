# Introduction

The [seL4® Microkernel](https://sel4.systems) is a technology of
increasing interest. It delivers specific capabilities and assurances, which
make it particularly suitable for applications that demand a trusted execution
environment and strong separation of concerns. 

The seL4 Microkernel is engineered to deliver both high-assurance and
high-performance ([The seL4 Microkernel: An
Introduction](https://sel4.systems/About/seL4-whitepaper.pdf)). High-assurance
is achieved through comprehensive formal verification. High-performance is
achieved through deliberate design and profiling, potentially accepting
greater complexity in the formal verification where this achieves higher
performance. 

The development of the seL4 Microkernel is overseen by the [seL4
Foundation](https://sel4.systems/Foundation/), operating as a project under
The [Linux Foundation](https://www.linuxfoundation.org/). The entirety of the
seL4 Microkernel, and its associated components, are made available as Open
Source, on Git Hub ([seL4 Microkernel and associated
components](https://github.com/seL4)).

In common with all Microkernels, the seL4 Microkernel provides a minimum set
of essential features as needed to frame a viable OS (Operating System). There
is an expectation that further components will be introduced atop this OS, in
developing useful applications (such as drivers, libraries, and services).

As a consequence, developing on top of the seL4 microkernel is currently
complex and time-consuming, and the expertise is limited to a small number of
individuals and organisations. Thus, this seL4 Developer Kit is created to
reduce the barrier to entry for developing on top of seL4 Microkernel. The
overall intention is to encourage and support more organisations in adopting
seL4 in their projects and products.
