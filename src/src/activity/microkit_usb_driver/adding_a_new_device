# Adding a new device
Adding a new device requires several steps. The main file that allows importing of a new device is `ioconf.c`, and this file houses all of the structures that the `autoconf.c` autoconfiguration will use to construct a library of drivers and associated functions. This file has 9 distinct sections:
1. `*_iattrdata`: information about the attribute data. No devices have been removed from this original set of structures, and you are free to leave this device as is.
2. `*_attrs` : creates a structure from the `*_iattrdata` information for use by drivers. Again, this is the original set and is free to be left alone
3. `cfdriver_list_initial[]`: unused and unedited.
4. `cfattach *_ca`: references to the data structures created by each drivers `CFATTACH_*` macro that appears at the top of driver files (e.g. `umass.c:278`)
5. Locators. This is unedited and can be ignored.
6. `cfparent`: defines hierarchy between different driver classes where necessary. This is unedited and can be ignored
7. `cfdata`: A list of drivers that will actually be used by the system. `ioconf.c` has a minimal set of drivers enabled for different devices. To add a device that is unsupported by this list, find the relevant entry in `ioconf-template.c`, which has a full list of devices. This list has been generated from a real build of NetBSD, and can be regenerated at any time by performing a build of a live system. The template file is included here as a shortcut to avoid a full rebuild.
	1. Note that if a rebuild is executed, the entire `ioconf.c` file should be replaced as often the previous (unedited) steps will be out of sync.
8. `*_cfattachinit`: information for the match and attach functions. This can again be pulled from the `ioconf-template.c` for the device required.
9. `cfattachinit[]`: list comprised of the above structures. Must end in `{NULL, NULL}`.

Upon successfully adding the device to the required sections, include the necessary C files from the NetBSD source. This must include a file that has the `CFATTACH_DECL[0-3]_NEW` macro that exposes the attach and match functions to the autoconfiguration routines. Note that some header file and several global variables may need to be stubbed out for the file to compile initially. In the past, we tried to stub out as much as possible and then incrementally add back required functionality to avoid pulling in too much of the NetBSD source.

With the device now able to be matched and attached, the final piece of the puzzle is to implement the interrupt function. As discussed in a previous section, the setup for a device occurs in the main driver PD, but the interrupt handling will always occur in the soft interrupt PD. to avoid memory address issues, a structure of function pointers called `intr_ptrs` is created in the initialisation sequence of soft interrupt. Simply add a new entry for the new device, locate where the interrupt function pointer is set (often in a function call ending in `*_open`), and change this to use the `intr_ptrs->[NEW_DEV]` pointer instead.

For example, when adding `uts` to the supported drivers list, the interrupt pointer is set in `uts.c:353` , where the hardcoded `&uts_intr` has been replaced with `intr_ptrs->uts`.
