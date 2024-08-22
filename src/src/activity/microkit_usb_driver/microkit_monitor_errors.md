# Microkit Monitor Errors
We found these errors to be difficult to understand for a while, so here is the general format:

### Invalid channel ID
If a channel ID number is called that is not defined in the system file, the following error can be seen:
```
<<seL4(CPU 0) [receiveIPC/142 T0x80bffe7400 "rootserver" @8a000318]: Reply object already has unexecuted reply!>>
```

This will not halt execution, but since the notification does not trigger, unintended results may occur. Can normally be fixed by checking all notifications or ppcalls and making sure they are correctly mapped in the `.system` file. If the stack is too small and overflows, this can cause the notifications channel IDs to get all messed up and this can cause an invalid channel ID error without any (logical) reason.

### Invalid memory address
```
MON|ERROR: received message 0x00000006  badge: 0x0000000000000001  tcb cap: 0x80000000000065c4  
MON|ERROR: faulting PD: xhci_stub  
Registers:  
pc : 0x000000000026a474  
spsr : 0x0000000020000040  
x0 : 0x4998000000000028  
x1 : 0x4998000000000027  
x2 : 0x4998000000000028  
x3 : 0x0000000000000000  
x4 : 0x0000000000000000  
x5 : 0x0000000000000000  
x6 : 0x0000000000000000  
x7 : 0xfffffffffffffff4  
MON|ERROR: VMFault: ip=0x000000000026a474  fault_addr=0x4998000000000028  fsr=0x0000000092000000  (data fault)  
MON|ERROR:    ec: 0x00000024  Data Abort from a lower Exception level   il: 1   iss: 0x00000000  
MON|ERROR:    dfsc = address size fault, level 0 (0x00000000)
```
When a memory address that is not supposed to be accessed by a given memory address is accessed, this error can be observed. This error halts execution. The faulting PD is named at the top (`xhci_stub` in this instance) and the memory address that has been accessed is shown by `ip=xxxx`.

In general, there are two main causes for this fault. One is that a region of memory has not been mapped into the PD that is trying to access it. The other is that a structure has been passed from one PD to another with a locally defined variable/function pointer. In this case, the fault address defined by `ip=xxxx` takes the form of the above message (similar to `0x...26a474`), since this will not resemble any of the addresses defined by the system file.
