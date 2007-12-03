From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 03 Dec 2007 21:38:09 +0100
Message-ID: <47546931.2090602@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050501090501010308090703"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475417E7.9070006@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------050501090501010308090703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Derek Murray wrote:
> If we let Linux zap the page tables before we unmap the grant reference,
> then it is not possible to unmap the grant reference. The
> unmap_grant_ref hypercall ultimately calls destroy_grant_pte_mapping in
> xen/arch/x86/mm.c, which ensures that the PTE does in fact point to the
> granted frame.

Hmm, I see.  You have to do that for every mapping, not just the last
(kernel) one to get release the grant.  And just dropping that check is
probably out of question because the guest could fool xen's reference
counting then?

> On this point I completely agree with you! If anyone has any less
> radical suggestions, then I'd be delighted to refactor the gntdev code
> to use them. However, I'm not currently aware of any alternative that
> maintains robustness to process crashes.

Oh, for me it isn't robust at all, it crashes on the first munmap
syscall.  It is the Fedora 8 kernel.  See attachment.  Didn't try
xensource 2.6.18 yet.

Ideas what is wrong?
Who uses the gntdev device right now?

> I think this would represent good progress, though I wonder if there
> would be a performance penalty due to performing the mapping and
> unmapping in user-space (multiple syscalls per mapping versus a single
> hypercall).

I'd expect the hard disk (and how I/O is scheduled) being the
bottleneck, not the syscall overhead.  Nevertheless I plan to benchmark
it once I have it up and running.

cheers,
  Gerd

--------------050501090501010308090703
Content-Type: text/plain;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops"

Linux version 2.6.21-2952.fc8xen (kojibuilder@hammer2.fedora.redhat.com) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #1 SMP Mon Nov 19 07:06:55 EST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize bail 0
copy_e820_map() start: 0000000000000000 size: 000000007491e000 end: 000000007491e000 type: 1
 Xen: 0000000000000000 - 000000007491e000 (usable)
1137MB HIGHMEM available.
727MB LOWMEM available.
NX (Execute Disable) protection: active
Entering add_active_range(0, 0, 477470) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->   186366
  Normal     186366 ->   186366
  HighMem    186366 ->   477470
early_node_map[1] active PFN ranges
    0:        0 ->   477470
On node 0 totalpages: 477470
  DMA zone: 1455 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 184911 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  HighMem zone: 2274 pages used for memmap
  HighMem zone: 288830 pages, LIFO batch:31
found SMP MP-table at 000ff780
DMI present.
ACPI: RSDP 000F9990, 0014 (r0 ACPIAM)
ACPI: RSDT 7D6B0000, 0044 (r1 A M I  OEMRSDT   5000708 MSFT       97)
ACPI: FACP 7D6B0200, 0084 (r2 A M I  OEMFACP   5000708 MSFT       97)
ACPI Warning (tbfadt-0360): Ignoring BIOS FADT r2 C-state control [20070126]
ACPI: DSDT 7D6B0490, 6643 (r1 SDBLI9 SDBLI944       44 INTL 20051117)
ACPI: FACS 7D6BE000, 0040
ACPI: APIC 7D6B0390, 006C (r1 A M I  OEMAPIC   5000708 MSFT       97)
ACPI: MCFG 7D6B0450, 003C (r1 A M I  OEMMCFG   5000708 MSFT       97)
ACPI: OEMB 7D6BE040, 0079 (r1 A M I  AMI_OEM   5000708 MSFT       97)
ACPI: ASF! 7D6B6AE0, 0099 (r32 LEGEND I865PASF        1 INTL 20051117)
ACPI: GSCI 7D6BE0C0, 2024 (r1 A M I  GMCHSCI   5000708 MSFT       97)
ACPI: iEIT 7D6C00F0, 00B0 (r1 A M I  EITTABLE  5000708 MSFT       97)
ACPI: SSDT 7D6C0BC0, 0877 (r1 DpgPmm    CpuPm       12 INTL 20051117)
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Detected 2992.804 MHz processor.
Built 1 zonelists.  Total pages: 473741
Kernel command line: ro root=/dev/xeni/fedora32 console=tty1 xencons=xvc0 console=xvc0 panic=30
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c136c000 soft=c134c000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Xen reported: 2992.594 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Software IO TLB enabled: 
 Aperture:     2 megabytes
 Kernel range: c033c000 - c053c000
 Address size: 24 bits
vmalloc area: ee000000-f4ffe000, maxmem 2d7fe000
Memory: 1866468k/1909880k available (2071k kernel code, 34068k reserved, 1080k data, 188k init, 1164416k highmem)
virtual kernel memory layout:
    fixmap  : 0xf5315000 - 0xf57fe000   (5028 kB)
    pkmap   : 0xf5000000 - 0xf5200000   (2048 kB)
    vmalloc : 0xee000000 - 0xf4ffe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xed7fe000   ( 727 MB)
      .init : 0xc1319000 - 0xc1348000   ( 188 kB)
      .data : 0xc1205e5e - 0xc1313fd4   (1080 kB)
      .text : 0xc1000000 - 0xc1205e5e   (2071 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5991.67 BogoMIPS (lpj=11983344)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebd3f1 20100000 00000000 00000000 0000e3fd 00000000 00000001
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: After all inits, caps: bfebd3f1 20100000 00000000 00003940 0000e3fd 00000000 00000001
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
CPU 1 irqstacks, hard=c136d000 soft=c134d000
ENABLING IO-APIC IRQs
SMP alternatives: switching to SMP code
Brought up 2 CPUs
Initializing CPU#1
sizeof(vma)=88 bytes
sizeof(page)=32 bytes
sizeof(inode)=336 bytes
sizeof(dentry)=132 bytes
sizeof(ext3inode)=488 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=176 bytes
sizeof(task_struct)=1376 bytes
migration_cost=19
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
Setting up standard PCI resources
Allocating PCI resources starting at 80000000 (gap: 7d6b0000:82950000)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
Error attaching device data
Error attaching device data
Error attaching device data
Error attaching device data
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 12 14 *15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 12 *14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 12 14 *15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 23 devices
xen_mem: Initialising balloon driver.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
pnp: 00:0a: ioport range 0xa20-0xa3f has been reserved
pnp: 00:0a: ioport range 0xa00-0xa0f has been reserved
pnp: 00:0a: ioport range 0xa10-0xa1f has been reserved
pnp: 00:0a: ioport range 0xa40-0xa5f has been reserved
pnp: 00:0b: iomem range 0xfed1c000-0xfed1ffff has been reserved
pnp: 00:0b: iomem range 0xfed20000-0xfed8ffff has been reserved
pnp: 00:0e: iomem range 0xffc00000-0xffefffff has been reserved
pnp: 00:0f: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:0f: iomem range 0xfee00000-0xfee00fff has been reserved
pnp: 00:10: iomem range 0xe0000000-0xefffffff has been reserved
pnp: 00:11: iomem range 0xffa77000-0xffa77fff has been reserved
pnp: 00:12: iomem range 0x0-0x0 could not be reserved
pnp: 00:13: iomem range 0x0-0x0 could not be reserved
pnp: 00:14: iomem range 0x0-0x0 could not be reserved
pnp: 00:15: iomem range 0x0-0x0 could not be reserved
pnp: 00:16: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:16: iomem range 0xc0000-0xcffff could not be reserved
pnp: 00:16: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:16: iomem range 0x100000-0x7d6fffff could not be reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: ff600000-ff6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: ff600000-ff6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:02:00.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 8554k freed
audit: initializing netlink socket (disabled)
audit(1196713193.812:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Warning (tbutils-0158): Incorrect checksum in table [OEMB] -  5E, should be 4F [20070126]
ACPI: SSDT 7D6C01A0, 02F4 (r1 DpgPmm  P001Ist       11 INTL 20051117)
Monitor-Mwait will be used to enter C-1 state
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: SSDT 7D6C06B0, 02F4 (r1 DpgPmm  P002Ist       12 INTL 20051117)
ACPI: CPU1 (power states: C1[C1] C2[C2])
ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
Xen virtual console successfully installed as xvc0
Event-channel device installed.
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 188k freed
Write protecting the kernel read-only data: 795k
ACPI: PCI Interrupt 0000:00:1a.7[D] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xffa7b400
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xffa7b000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 20, io base 0x0000d880
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000d800
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1a.2 to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 17, io base 0x0000d480
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000d400
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000d080
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[D] -> GSI 16 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 20, io base 0x0000d000
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
SCSI subsystem initialized
libata version 2.20 loaded.
ahci 0000:00:1f.2: version 2.1
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
usb 6-1: new low speed USB device using uhci_hcd and address 2
usb 6-1: configuration #1 chosen from 1 choice
input: SOLIDTEK USB Composite Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
input: SOLIDTEK USB Composite Keyboard as /class/input/input2
input,hiddev96: USB HID v1.10 Device [SOLIDTEK USB Composite Keyboard] on usb-0000:00:1d.0-1
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports ? Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xee074900 ctl 0x00000000 bmdma 0x00000000 irq 18
ata2: SATA max UDMA/133 cmd 0xee074980 ctl 0x00000000 bmdma 0x00000000 irq 18
ata3: SATA max UDMA/133 cmd 0xee074a00 ctl 0x00000000 bmdma 0x00000000 irq 18
ata4: SATA max UDMA/133 cmd 0xee074a80 ctl 0x00000000 bmdma 0x00000000 irq 18
ata5: SATA max UDMA/133 cmd 0xee074b00 ctl 0x00000000 bmdma 0x00000000 irq 18
ata6: SATA max UDMA/133 cmd 0xee074b80 ctl 0x00000000 bmdma 0x00000000 irq 18
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ata_hpa_resize 1: sectors = 321672960, hpa_sectors = 321672960
ata1.00: ATA-7: Hitachi HDS721616PLA380, P22OAB3A, max UDMA/133
ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: ata_hpa_resize 1: sectors = 321672960, hpa_sectors = 321672960
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI, max UDMA/66
ata2.00: configured for UDMA/66
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi4 : ahci
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : ahci
ata6: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72161 P22O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            PLEXTOR  DVDR   PX-755A   1.04 PQ: 0 ANSI: 5
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
ata1: D2H reg with I during NCQ, this message won't be printed again
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  5 users, 11 roles, 2391 types, 114 bools, 1 sens, 1024 cats
security:  67 classes, 215624 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), uses genfs_contexts
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1196713206.804:2): policy loaded auid=4294967295
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
input: PC Speaker as /class/input/input3
8250_pnp: Unknown symbol serial8250_unregister_port
8250_pnp: Unknown symbol serial8250_register_port
8250_pnp: Unknown symbol serial8250_unregister_port
8250_pnp: Unknown symbol serial8250_register_port
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
FDC 0 is a National Semiconductor PC87306
Intel(R) PRO/1000 Network Driver - version 7.5.5.1-NAPI
Copyright (c) 1999-2007 Intel Corporation.
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:19.0 to 64
e1000: 0000:00:19.0: e1000_probe: PHY reset is blocked due to SOL/IDER session.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
e1000: 0000:00:19.0: e1000_check_copper_options: Link active due to SoL/IDER Session. Speed/Duplex/AutoNeg parameter ignored.
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:13:20:f5:f8:50
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1b.0 to 64
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:03.3[B] -> GSI 17 (level, low) -> IRQ 16
device-mapper: multipath: version 1.0.5 loaded
loop: loaded (max 8 devices)
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-2, type ext3), uses xattr
SELinux: initialized (dev sda1, type ext2), uses xattr
SELinux: initialized (dev sda2, type ext2), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 4194296k swap on /dev/mapper/xeni-swap.  Priority:-1 extents:1 across:4194296k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IA-32 Microcode Update Driver: v1.14a-xen <tigran@veritas.com>
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
e1000: eth0: e1000_watchdog_task: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
audit(1196713221.215:3): audit_pid=1901 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
eth0: no IPv6 routers present
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
Bridge firewalling registered
ADDRCONF(NETDEV_UP): peth0: link is not ready
e1000: peth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
e1000: peth0: e1000_watchdog_task: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): peth0: link becomes ready
device peth0 entered promiscuous mode
eth0: port 1(peth0) entering learning state
eth0: topology change detected, propagating
eth0: port 1(peth0) entering forwarding state
virbr0: no IPv6 routers present
peth0: no IPv6 routers present
eth0: no IPv6 routers present
xen-vbd: registered block device major 202
blkfront: xvda: barriers enabled
 xvda:<0>Eeek! page_mapcount(page) went negative! (-1)
  page pfn = 29384
  page->flags = 835
  page->count = 3
  page->mapping = eb093d98
  vma->vm_ops = gntdev_vmops+0x0/0x34
  vma->vm_ops->nopage = 0x0
  vma->vm_file->f_op->mmap = gntdev_mmap+0x0/0x467
------------[ cut here ]------------
kernel BUG at mm/rmap.c:574!
invalid opcode: 0000 [#1]
SMP 
last sysfs file: /devices/xen/vbd-51712/devtype
Modules linked in: xenblk(U) ipt_MASQUERADE(U) iptable_nat(U) nf_nat(U) bridge(U) autofs4(U) sunrpc(U) nf_conntrack_netbios_ns(U) nf_conntrack_ipv4(U) xt_state(U) nf_conntrack(U) nfnetlink(U) ipt_REJECT(U) iptable_filter(U) ip_tables(U) xt_tcpudp(U) ip6t_REJECT(U) ip6table_filter(U) ip6_tables(U) x_tables(U) ipv6(U) ext2(U) loop(U) dm_multipath(U) 8250_pci(U) snd_hda_intel(U) snd_hda_codec(U) snd_seq_dummy(U) snd_seq_oss(U) snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) snd_pcm_oss(U) snd_mixer_oss(U) snd_pcm(U) snd_timer(U) parport_pc(U) snd(U) i2c_i801(U) ata_generic(U) e1000(U) parport(U) floppy(U) serio_raw(U) pcspkr(U) soundcore(U) i2c_core(U) 8250(U) snd_page_alloc(U) sg(U) sr_mod(U) serial_core(U) cdrom(U) ata_piix(U) dm_snapshot(U) dm_zero(U) dm_mirror(U) dm_mod(U) ahci(U) liba
 ta(U) sd_mod(U) scsi_mod(U) ext3(U) jbd(U) mbcache(U) uhci_hcd(U) ohci_hcd(U) ehci_hcd(U)
CPU:    1
EIP:    0061:[<c1065c32>]    Not tainted VLI
EFLAGS: 00210282   (2.6.21-2952.fc8xen #1)
EIP is at page_remove_rmap+0xce/0xed
eax: 00000036   ebx: c2371080   ecx: 00000001   edx: 00000000
esi: e92aed84   edi: 00000020   ebp: 53584067   esp: e9245ea4
ds: 007b   es: 007b   fs: 00d8  gs: 0033  ss: 0069
Process blkbackd (pid: 3154, ti=e9245000 task=c1d95150 task.ti=e9245000)
Stack: c1291346 eb093d98 c1156c6b 00000000 c105d7fa 00000000 00000000 ffffffef 
       b7f03000 e92aed84 e9245f68 53584067 00000000 003ff000 b7f03000 00000000 
       00000000 b7f04000 e95a1010 00000000 eb128580 e92df818 c2371080 c1c64900 
Call Trace:
 [<c1156c6b>] gntdev_clear_pte+0x0/0x289
 [<c105d7fa>] unmap_vmas+0x62e/0x8bd
 [<c101d6f4>] __wake_up+0x32/0x43
 [<c106269f>] unmap_region+0x93/0xf7
 [<c1063073>] do_munmap+0x15a/0x1ac
 [<c10630f5>] sys_munmap+0x30/0x3e
 [<c1005688>] syscall_call+0x7/0xb
 =======================
Code: c0 74 0d 8b 50 08 b8 76 13 29 c1 e8 35 af fd ff 8b 46 4c 85 c0 74 14 8b 40 10 85 c0 74 0d 8b 50 2c b8 95 13 29 c1 e8 1a af fd ff <0f> 0b eb fe 8b 53 10 89 d8 59 5b 5b 83 e2 01 5e f7 da 83 c2 04 
EIP: [<c1065c32>] page_remove_rmap+0xce/0xed SS:ESP 0069:e9245ea4

--------------050501090501010308090703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------050501090501010308090703--
