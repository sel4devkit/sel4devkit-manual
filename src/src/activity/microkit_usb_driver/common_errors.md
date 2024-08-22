# Common errors
## Looping "sleeping on xfer"
**Symptoms**: when running on debug, seeing `sleeping on xfer ...` looped in output. Without debug, output will seem to freeze.

**Possible causes**: Race condition caused by `xfer->ux_done` being set to false AFTER the transfer has finished (overwriting the real value (true)), meaning the while loop in `usbdi.c:499` never resolves. It can also be caused by the driver being stuck in the loop and never allowing computation to complete the transfer, but this should never happen, since the transfer is set to done during software interrupt which is higher priority.

**Possible Solutions**: Can be caused by modified NetBSD code `xhci.c:4680`. The status is set to in progress before doing anything else. Also, the transfer is never timed out, which could be potentially dangerous in the future for devices that stop responding as it will freeze the whole driver. Sometimes, increasing the `usbd_delay_ms()` in various places in `xhci.c` allows the xfer to complete setup before it gets overwritten

## MON|Error ...
**Symptoms**: Monitor error causing program to crash

**Possible causes**: Could be a lot of different things, as it just means that memory has been accessed that has not been allocated. Check structures to ensure memory allocation has happened where it should have, or shared memory has been properly shared between all PDs. Can also be caused by stack overflows or buffer overflows.

However, once all obvious causes have been exhausted, these are some possible causes that are specific to this driver:
-  Function pointers being called where they have been setup in a different PD to the one executing. Particularly common offenders include:
	- `usbdi.c:1207 upm_done`
	- `usbdi.c:457 upm_transfer`
	- Function pointers that are setup in main driver PD and always called from software PD
		- Any interrupt pointer call (e.g. setup in `uts.c:353` and called in `uhidev.c:624`) 
		- Any callback call (e.g. setup in `umass_scsipi.c:334` and called in `umass.c:1100`)

**Possible solutions**: Make sure that the function is being called using `get_up_methods()` or using the `intr_ptrs` structure for functions that are always called in software. Sometimes, observing the actual incorrectly invoked memory address can give a clue as to what exactly is going wrong (see Monitor Errors  section)
