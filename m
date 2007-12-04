From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 04 Dec 2007 20:58:16 +0100
Message-ID: <4755B158.3030008@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>	
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>	
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>	
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030807020102050601010800"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1196771999.10809.18.camel@sisko.scot.redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------030807020102050601010800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2007-12-04 at 13:01 +0100, Gerd Hoffmann wrote:
> 
>>>> Who uses the gntdev device right now?
>>> Good question! I'm aware of it being used in a few research projects,
>>> and it seems to work for them (though I think it is mostly used with the
>>> linux-2.6.18-xen kernel). Anyone else?
>> So it effectively got no real-world testing yet ...
> 
> So... the interface (a) cannot be used on the Linux VM without at least
> one invasive VM modification, due to the requirement of ptes being
> explicitly unmapped via hypercall; and (b) isn't used significantly in
> real life yet.

(c) seems not to work for anything non-trivial.  I've compiled and
tested a xensource 2.6.18 kernel (3.1 testing mercurial tree head,
should be 3.1.2-release), it fails in a simliar way.  See attachment.

Want reproduce?  Here we go:

  * grab xenner 0.8 from http://dl.bytesex.org/releases/xenner/
  * grab a xenified dom0 kernel without blktap driver (either not
    compiled or module not loaded).
  * start xend
  * start blkbackd from xenner package (you probably want the -d switch
    for debug output, twice for more).
  * run "xm block-attach 0 tap:aio:/path/to/some/file xvda r"
  * watch it blow up ;)

> I can't help wondering if this is a hint that now is the time to find a
> better API, which doesn't have the requirement (a) that seems to be
> causing such trouble?  Are other PV guests --- *BSD, Solaris --- going
> to have the same problems with their VM layers if they try to implement
> this API?  Upstream Linux pv_ops certainly will, and it would be good if
> we could avoid tying unprivileged guests to ABIs which cannot hope to be
> merged into pv_ops.

And I fear the problems I've trapped into up to now is only the tip of
the iceberg.  What happens if an application with active grant table
mappings calls fork() ?

cheers,
  Gerd

--------------030807020102050601010800
Content-Type: text/plain;
 name="oops"
Content-Disposition: inline;
 filename="oops"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.18-xen (kraxel@zweiblum.travel.kraxel.org) (gcc version=
 4.1.2 20070925 (Red Hat 4.1.2-33)) #1 SMP Tue Dec 4 18:17:24 CET 2007
BIOS-provided physical RAM map:
 Xen: 0000000000000000 - 000000000adc3000 (usable)
0MB HIGHMEM available.
173MB LOWMEM available.
On node 0 totalpages: 44483
  DMA zone: 44483 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                ) @ 0x000f0010
ACPI: RSDT (v001 OID_00 RSDT_000 0x30303030 =90& 0x00010000) @ 0x0bfffbd0
ACPI: FADT (v001 OID_00 FACP_000 0x30303030 =90& 0x00010000) @ 0x0bfffb20
ACPI: BOOT (v001 OID_00 BOOT_000 0x30303030 =90& 0x00010000) @ 0x0bfffba0
ACPI: DSDT (v001 INT440 SYSFexxx 0x00001001 MSFT 0x0100000b) @ 0x00000000
ACPI: Vendor "INT440" System "SYSFexxx" Revision 0x1001 has a known ACPI =
BIOS problem.
ACPI: Reason: Does not use _REG to protect EC OpRegions. This is a non-re=
coverable error
ACPI: Disabling ACPI support
Allocating PCI resources starting at 10000000 (gap: 0c000000:f3fc0000)
Detected 600.047 MHz processor.
Built 1 zonelists.  Total pages: 44483
Kernel command line: ro root=3D/dev/zen/rhel5 apm=3Doff vga=3D0x317 panic=
=3D30
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Xen reported: 600.034 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Software IO TLB enabled:=20
 Aperture:     2 megabytes
 Kernel range: c0aad000 - c0cad000
 Address size: 24 bits
vmalloc area: cb800000-f51fe000, maxmem 2d7fe000
Memory: 155572k/177932k available (1972k kernel code, 14020k reserved, 69=
3k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 1502.07 BogoMIPS (lpj=3D=
7510358)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387d1f1 00000000 00000000 00000000 00=
000000 00000000 00000000
CPU: After vendor identify, caps: 0387d1f1 00000000 00000000 00000000 000=
00000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383d1f1 00000000 00000000 00000040 00000000 =
00000000 00000000
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
Brought up 1 CPUs
migration_cost=3D0
checking if image is initramfs... it is
Freeing initrd memory: 6538k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
xen_mem: Initialising balloon driver.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-103f claimed by PIIX4 ACPI
PCI quirk: region 1400-140f claimed by PIIX4 SMB
PIIX4 devres C PIO at 0398-0399
Boot video device is 0000:00:09.0
PCI: Using IRQ router PIIX/ICH [8086/7198] at 0000:00:07.0
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: Bus 1, cardbus bridge: 0000:00:08.0
  IO window: 00001c00-00001cff
  IO window: 00002000-000020ff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:08.0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Simple Boot Flag at 0x37 set to 0x1
IA-32 Microcode Update Driver: v1.14a-xen <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1196794944.970:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Xen virtual console successfully installed as ttyS0
Event-channel device installed.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Freeing unused kernel memory: 192k freed
piix: no version for "struct_module" found: kernel tainted.
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: HTS548040M9AT00, ATA DISK drive
input: PS/2 Mouse as /class/input/input1
input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0

PCI: IRQ 11 for device 0000:00:07.2 doesn't match PIRQ mask - try pci=3Du=
sepirqmask
<7>PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0a.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00001200
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI=
)
hda: max request size: 512KiB
usb 1-2: new full speed USB device using uhci_hcd and address 2
hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=3D16383/255/63, UDM=
A(33)
hda: cache flushes supported
 hda:<6>usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 3 ports detected
 hda1 hda2 hda3 < hda5 > hda4
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redh=
at.com
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input3
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
Yenta: CardBus bridge found at 0000:00:08.0 [1071:7722]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:08.0, mfunc 0x017c1602, devctl 0x64
Intel 810 + AC97 Audio, version 1.01, 18:04:40 Dec  4 2007
Yenta: ISA IRQ mask 0x02d8, PCI irq 10
Socket status: 30000010
PCI: Setting latency timer of device 0000:00:00.1 to 64
i810: Intel 440MX found at IO 0x1500 and 0x1600, MEM 0x0000 and 0x0000, I=
RQ 5
ieee1394: Initialized config rom entry `ip1394'
i810_audio: Audio Controller supports 2 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: CRY52 (Cirrus Logic CS4299 rev D)
i810_audio: AC'97 codec 0 supports AMAP, total channels =3D 2
i810_audio: setting clocking to 38348
PCI: Found IRQ 10 for device 0000:00:0b.0
ohci1394: fw-host0: SelfID received outside of bus reset sequence
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[10]  MMIO=3D[14021000-140=
217ff]  Max Packet=3D[1024]  IR/IT contexts=3D[4/4]
pccard: PCMCIA card inserted into slot 0
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp 0000:00:0a.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatib=
le chip
8139cp 0000:00:0a.0: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 11 for device 0000:00:0a.0
PCI: Sharing IRQ 11 with 0000:00:07.2
eth0: RealTek RTL8139 at 0xcb980000, 00:40:d0:12:f3:b4, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'
PCI: Setting latency timer of device 0000:00:00.2 to 64
evbug.c: Connected device: "AT Translated Set 2 keyboard", isa0060/serio0=
/input0
evbug.c: Connected device: "PS/2 Mouse", isa0060/serio1/input1
evbug.c: Connected device: "AlpsPS/2 ALPS GlidePoint", isa0060/serio1/inp=
ut0
evbug.c: Connected device: "PC Speaker", isa0061/input0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ts: Compaq touchscreen protocol output
8250_pci: Unknown symbol serial8250_unregister_port
8250_pci: Unknown symbol serial8250_resume_port
8250_pci: Unknown symbol serial8250_register_port
8250_pci: Unknown symbol serial8250_suspend_port
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0040d00100000b49]
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xf=
ffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <=
proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roski=
n <proski@gnu.org>, et al)
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
eth1: Hardware identity 8008:0000:0001:0000
eth1: Station identity  001f:0004:0001:0003
eth1: Firmware determined as Intersil 1.3.4
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:30:AB:0F:69:F6
eth1: Station name "Prism  I"
eth1: ready
eth1: orinoco_cs at 0.0, irq 10, io 0x0100-0x013f
Non-volatile memory driver v1.2
lp: driver loaded but no devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: multipath: version 1.0.4 loaded
EXT3 FS on dm-1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048568k swap on /dev/zen/swap.  Priority:-1 extents:1 across:1048=
568k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (1390 buckets, 11120 max) - 228 bytes per conntr=
ack
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.r=
etrans_time; Use net.ipv6.neigh.lo.retrans_time_ms instead.
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
eth1: New link status: Connected (0001)
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
audit(1196794998.576:2): audit_pid=3D3073 old=3D0 by auid=3D4294967295
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
eth1: no IPv6 routers present
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bridge firewalling registered
openvpn0: no IPv6 routers present
virbr0: no IPv6 routers present
xen-vbd: registered block device major 202
blkfront: xvda: barriers enabled
 xvda:<0>------------[ cut here ]------------
kernel BUG at /home/kraxel/xen/xen31/linux-2.6.18-xen/mm/rmap.c:522!
invalid opcode: 0000 [#1]
SMP=20
Modules linked in: xenblk ipt_MASQUERADE iptable_nat ip_nat bridge hidp r=
fcomm l2cap bluetooth tun sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_st=
ate ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp=
 ip6table_filter ip6_tables x_tables ipv6 binfmt_misc dm_multipath parpor=
t_pc lp parport nvram orinoco_cs orinoco hermes joydev pcmcia firmware_cl=
ass tsdev evbug evdev serial_core snd_intel8x0m snd_seq_dummy snd_seq_oss=
 snd_seq_midi_event snd_seq 8139too serio_raw 8139cp mii snd_intel8x0 snd=
_ac97_codec snd_ac97_bus ohci1394 ieee1394 snd_seq_device snd_pcm_oss snd=
_mixer_oss snd_pcm i810_audio snd_timer ac97_codec snd snd_page_alloc sou=
ndcore yenta_socket rsrc_nonstatic pcmcia_core i2c_piix4 i2c_core pcspkr =
rtc dm_snapshot dm_zero dm_mirror dm_mod ide_disk ext3 jbd ehci_hcd ohci_=
hcd uhci_hcd usbcore piix
CPU:    0
EIP:    0061:[<c0169688>]    Tainted: GF     VLI
EFLAGS: 00010286   (2.6.18-xen #1)=20
EIP is at page_remove_rmap+0x28/0x40
eax: ffffffff   ebx: c1080780   ecx: c1080780   edx: 00000000
esi: c4e65a14   edi: 00000020   ebp: c536ab80   esp: c407bea8
ds: 007b   es: 007b   ss: 0069
Process blkbackd (pid: 3973, ti=3Dc407a000 task=3Dc05eda30 task.ti=3Dc407=
a000)
Stack: c0160b51 c536ab80 00000000 c05eda30 00000000 00000000 00000002 c01=
ea764=20
       b7f70000 c4e65a14 c407bf68 07a3c067 00000000 003ff000 b7f70000 000=
00000=20
       00000000 b7f71000 c4ccd010 c99e9740 c1080780 c1161c00 00000000 fff=
fffff=20
Call Trace:
 [<c0160b51>] unmap_vmas+0x4a1/0x910
 [<c01ea764>] copy_from_user+0x34/0x80
 [<c016594b>] unmap_region+0x9b/0x120
 [<c016645c>] do_munmap+0x14c/0x1e0
 [<c0166522>] sys_munmap+0x32/0x50
 [<c010568f>] syscall_call+0x7/0xb
Code: 00 00 00 89 c1 90 83 40 08 ff 0f 98 c0 84 c0 75 02 f3 c3 8b 41 08 8=
3 c0 01 78 10 8b 51 10 89 c8 83 f2 01 83 e2 01 e9 e8 42 ff ff <0f> 0b 0a =
02 48 84 30 c0 eb e6 8d b4 26 00 00 00 00 8d bc 27 00=20
EIP: [<c0169688>] page_remove_rmap+0x28/0x40 SS:ESP 0069:c407bea8
 <7>evbug.c: Event. Dev: isa0060/serio0/input0, Type: 4, Code: 4, Value: =
42
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 42, Value: 1
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
XENBUS: Waiting for devices to initialise: 295s...<7>evbug.c: Event. Dev:=
 isa0060/serio0/input0, Type: 4, Code: 4, Value: 201
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 104, Value: 1
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 4, Code: 4, Value: 201
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 104, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 4, Code: 4, Value: 201
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 104, Value: 1
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 4, Code: 4, Value: 201
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 104, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 4, Code: 4, Value: 42
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 42, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
290s...285s...

--------------030807020102050601010800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------030807020102050601010800--
