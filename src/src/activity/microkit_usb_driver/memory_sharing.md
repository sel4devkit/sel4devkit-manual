# Memory sharing
As part of the implementation in Microkit, one of the more difficult parts that we found was the issue of memory isolation between PDs. Due to the fact that NetBSD expects code to all be executing in the same working memory regions, it uses a lot of function pointers. This translates just fine to Microkit as long as the function pointers are used in the same protection domain as they are defined.

One of the earliest memory region shares is the duplication of the `xhci_softc` data structure. `*_softc` structures in NetBSD are the structures that are used to contain information about the devices attached, and therefore sharing this structure between the two main PDs is paramount, such that the configuration and changes to the structure retain integrity.

A further example of this is the setup of the `*_pointer` and `*_pointer_other` methods. Although not ideal, we have set up the driver such that in initialisation phase, the main PD queries the interrupt PD for memory addresses of various functions, and assigns these to global variables. Then, when the function pointer would be incurred, the value of the memory address is compared against each function pointer, and corrected if the memory address points to a region in the alternate PD. That is to say:
```C
(main driver)
...
if (func_addr == func_pointer_other) {
	func_addr = func_pointer; //correct memory address of function pointer to use function in memory region
}
(usb_sc->func_addr)(args); //call function with required args. This is unmodified NetBSD code
...
```

A better use of this would be to instead create a structure with all the used functions, and then instead of using function pointers, use an index, such that less initial setup is required, and there is no need for RPCs. For reference, here is what NetBSD looks like currently at setup (with added comments for readability). This snippet is from `xhci.c:2167`
```C
//This initialisation happens in the main driver PD.
//setup (xhci.c:2167)
...
switch (xfertype) {
case UE_CONTROL:
	pipe->up_methods = &xhci_device_ctrl_methods; //this function pointer will be compared with a global pointer
	break;
...
case UE_BULK:
	pipe->up_methods = &xhci_device_bulk_methods;
	break;
case UE_INTERRUPT:
	pipe->up_methods = &xhci_device_intr_methods;
	break;
...
}
...


//usage (from usbdi.c:469). This will be used in both PDs
...
} else if (pipe->up_methods == device_ctrl_pointer_other) {
	pipe->up_methods = device_ctrl_pointer; //this is a pointer to xhci_device_ctrl_methods in the current PD
}
err = pipe->up_methods->upm_transfer(xfer); //call function
```

Instead, it could look something like 
```C
// setup in the init() function of each PD
void *get_up_methods(int ptr) {
	switch (ptr) {
	case 0:
		xhci_device_control_methods;
	case 1:
		xhci_device_bulk_methods;
	case 2:
		xhci_device_intr_methods;
		...
	}
}

//setup (xhci.c:2167)
...
switch (xfertype) {
case UE_CONTROL:
	pipe->up_methods = 0; //instead of being a function pointer, it is now an index
	break;
...
case UE_BULK:
	pipe->up_methods = 1;
	break;
case UE_INTERRUPT:
	pipe->up_methods = 2;
	break;
...
}

// usage (usbdi.c:469 ish)
...
err = get_up_methods(pipe->up_methods)->upm_transfer(xfer); //call function
```
