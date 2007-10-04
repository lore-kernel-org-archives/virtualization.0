From: Chris Malley <mail@chrismalley.co.uk>
Subject: Re: [PATCH 0/5] Boot protocol changes
Date: Thu, 04 Oct 2007 10:47:11 +0100
Message-ID: <1191491231.5950.7.camel@feisty>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-z6TJgEiTOdrTBMza0Zwx"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--=-z6TJgEiTOdrTBMza0Zwx
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi guys

I gave these patches a try (on top of 2.6.23-rc9 plus the previously
submitted 2.6.24 patch set).

The last two seem to cause Badness on my system, whereby if I start a
guest (using the same bzImage as the host, as before) it seems to boot
OK, and the host system still superficially looks stable (my X session
is OK and I can interact with existing processes) but if I attempt to
launch any new process on the host (even typing "ls" into a terminal
window) I get a Segmentation fault.  Needless to say the only way to
resolve it is to reboot the host (stopping the guest doesn't resolve
the problem).

I'll attach a dump of the console/verbose output and my .config in
case it's of any use.

Interestingly if I run the example launcher before applying patch 05
(in other words with the old bzImage loader code) it just stops early
with an "unhandled trap 14":

$./lguest  --block=disk.img 256 /boot/vmlinuz-2.6.23-rc9 
  --initrd=/boot/initrd.img-2.6.23-rc9 --tunnet=192.168.150.1
  --verbose root=/dev/vda1 single

Guest base is at 0xa7cba000
device 0: console
Unpacked size 3506404 addr 0xa7dba000
mapped initrd /boot/initrd.img-2.6.23-rc9 size=14139392 @ 0xf284000
Linear mapping of 65536 pages in 64 pte pages at 0xf243000
Guest: 0xa7cba000 - 0xb7cc0000 (0x10006000)
lguest: unhandled trap 14 at 0xa7dba000 (0xa7dba000)


I did spend some time trying to understand the assembly in the patches
but it made my head hurt :-)   If there's any further diagnosis I can
do then let me know...

--
Chris

--=-z6TJgEiTOdrTBMza0Zwx
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; name=guest.out; charset=UTF-8
Content-Disposition: attachment; filename=guest.out

[    0.000000] Reserving virtual address space above 0xffc00000
[    0.000000] Linux version 2.6.23-rc9 (chris@feisty) (gcc version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #1 SMP Wed Oct 3 16:00:21 BST 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  LGUEST: 0000000000000000 - 0000000004000000 (usable)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 64MB LOWMEM available.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->    16384
[    0.000000]   HighMem     16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] DMI not present or invalid.
[    0.000000] Allocating PCI resources starting at 10000000 (gap: 04000000:fc000000)
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 16256
[    0.000000] Kernel command line: root=/dev/vda1 single 
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [hvc0] enabled
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 47468k/65536k available (1908k kernel code, 18048k reserved, 887k data, 260k init, 0k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffb4c000 - 0xffbff000   ( 716 kB)
[    0.000000]     pkmap   : 0xff400000 - 0xff800000   (4096 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff3fe000   ( 939 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]       .init : 0xc03c1000 - 0xc0402000   ( 260 kB)Guest base is at 0xb3cde000
device 0: console
mapped initrd /boot/initrd.img-2.6.23-rc9 size=14139392 @ 0x3284000
Linear mapping of 16384 pages in 16 pte pages at 0x3273000
Guest: 0xb3cde000 - 0xb7ce4000 (0x4006000)
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bdf23
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde4b
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0
[    0.000000]       .data : 0xc02dd0f2 - 0xc03baee4   ( 887 kB)
[    0.000000]       .text : 0xc0100000 - 0xc02dd0f2   (1908 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] SLUB: Genslabs=22, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[    0.029648] Security Framework v1.0.0 initialized
[    0.029648] Mount-cache hash table entries: 512
[    0.029648] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.029648] CPU: L2 cache: 2048K
[    0.029648] Compat vDSO mapped to ffbfe000.
[    0.030663] SMP alternatives: switching to UP code
[    0.030663] Freeing SMP alternatives: 11k freed
[    0.034768] CPU0: Intel(R) Pentium(R) M processor 2.00GHz stepping 06
[    0.034768] SMP motherboard not detected.
[    0.034768] Local APIC not detected. Using dummy APIC emulation.
[    0.034768] Brought up 1 CPUs
[    0.036813] Booting paravirtualized kernel on lguest
[    0.058246] Time: 165:165:165  Date: 164/165/165
[    0.058246] NET: Registered protocol family 16
[    0.058246] PCI: Fatal: No config space access function found
[    0.058246] Setting up standard PCI resources
[    0.059297] ACPI: Interpreter disabled.
[    0.059297] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.060316] pnp: PnP ACPI: disabled
[    0.060316] PCI: Using ACPI for IRQ routing
[    0.060316] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.060316] PCI: System does not support PCI
[    0.060316] PCI: System does not support PCI
[    0.062382] NET: Registered protocol family 8
[    0.062382] NET: Registered protocol family 20
[    0.062382] NET: Registered protocol family 2
[    0.063412] Time: lguest clocksource has been installed.
[    0.071442] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.071442] TCP established hash table entries: 2048 (order: 2, 24576 bytes)
[    0.071442] TCP bind hash table entries: 2048 (order: 2, 1638x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde47
Notify on address 0x3bde87
Notify on address 0x3bde87
Notify on address 0x3bde87
Notify on address 0x3bde87
Notify on address 0x3bde87
Notify on address 0x3bde87
Notify on address 0x3bdea7
Notify on address 0x3bdea7
Notify on address 0x3bdea7
Notify on address 0x3bdea7
Notify on address 0x3bde73
Notify on address 0x3bde73
Notify on address 0x3bde73
Notify on address 0x3bde73
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bdd87
Notify on address 0x3bde83
Notify on address 0x3bde83
Notify on address 0x3bde83
Notify on address 0x3bde9f
Notify on address 0x3bde9f
Notify on address 0x3bde9f
Notify on address 0x3bde9f
Notify on address 0x3bde7b
Notify on address 0x3bde7b
Notify on address 0x3bde7b
Notify on address 0x3bde7b
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe3b
Notify on address 0x10afe3b
Notify on address 0x10afe3b
Notify on address 0x10afe3b
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe8f
Notify on address 0x10afe8f
Notify on address 0x10afe8f
Notify on address 0x10afe7f
Notify on address 0x10afe7f
Notify on address 0x10afe7f
Notify on address 0x10afe7f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe4f
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe83
Notify on address 0x10afe6b
Notify on address 0x10afe6b
Notify on address 0x10afe6b
Notify on address 0x10afe6b
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe87
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x3bdd7f
Notify on address 0x3bdd7f
Notify on address 0x3bdd7f
Notify on address 0x3bdd7f
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe17
Notify on address 0x10afe14 bytes)
[    0.071442] TCP: Hash tables configured (established 2048 bind 2048)
[    0.071442] TCP reno registered
[    0.074443] checking if image is initramfs... it is
[    1.379405] Freeing initrd memory: 13808k freed
[    1.380388] audit: initializing netlink socket (disabled)
[    1.380388] audit(1191490352.366:1): initialized
[    1.383342] VFS: Disk quotas dquot_6.5.1
[    1.383342] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.383342] io scheduler noop registered
[    1.383342] io scheduler anticipatory registered
[    1.383342] io scheduler deadline registered
[    1.383342] io scheduler cfq registered (default)
[    1.405342] rtc: I/O resource 70 is not free.
[    1.405342] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.406343] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.407345] PNP: No PS/2 controller found. Probing ports directly.
[    1.407345] i8042.c: No controller found.
[    1.408682] mice: PS/2 mouse device common for all mice
[    1.408682] EDAC MC: Ver: 2.1.0 Oct  3 2007
[    1.408682] TCP cubic registered
[    1.408682] NET: Registered protocol family 1
[    1.408682] Using IPI No-Shortcut mode
[    1.408682]   Magic number: 1:252:3141
[    1.409344] Freeing unused kernel memory: 260k freed
Loading, please wait...
Begin: Loading essential drivers... ...
Done.
Begin: Running /scripts/init-premount ...
7
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe5b
Notify on address 0x10afe6b
Notify on address 0x10afe6b
Notify on address 0x10afe6b
Notify on address 0x10afe7b
Notify on address 0x10afe7b
Notify on address 0x10afe7b
Notify on address 0x10afe7b
Notify on address 0x10afe47
Notify on address 0x10afe47
Notify on address 0x10afe47
Notify on address 0x10afe47
Notify on address 0x10afe7b
Notify on address 0x10afe7b
Notify on address 0x10afe7b
Notify on address 0x10afe7b
Notify on address 0x10afe5f
Notify on address 0x10afe5f
Notify on address 0x10afe5f
Notify on address 0x10afe5f
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe77
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x10afe67
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 
[    1.752340] thermal: Unknown symbol acpi_processor_set_thermal_limit
Done.
Begin: Mounting root file system... ...
Begin: Running /scripts/local-top ...
[    2.666346]  vda: vda1
Done.
Begin: Waiting for root file system... ...
0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 0: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 8388480: 4096
Notify on address 0x4001000
Output to block
READ from sector 8388600: 4096
Notify on address 0x4001000
Output to block
READ from sector 8388544: 4096
Notify on address 0x4001000
Output to block
READ from sector 8388352: 4096
Notify on address 0x4001000
Output to block
READ from sector 8388592: 4096
Notify on address 0x4001000
Output to block
READ from sector 8388208: 4096
Notify on address 0x4001000
Output to block
READ from sector 0: 4096
Notify on address 0x4001000
Output to block
READ from sector 8: 4096
Notify on address 0x4001000
Output to block
READ from sector 16: 12288
Notify on address 0x4001000
Output to block
READ from sector 40: 4096
Notify on address 0x4001000
Output to block
READ from sector 48: 28672
Notify on address 0x4001000
Output to block
READ from sector 104: 4096
Notify on address 0x4001000
Output to block
READ from sector 112: 61440
Notify on address 0x4001000
Output to block
READ from sector 232: 4096
Notify on address 0x4001000
Output to block
READ from sector 240: 126976
Notify on address 0x4001000
Output to block
READ from sector 512: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385727: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 8385927: 512
Notify on address 0x4001000
Output to block
READ from sector 8385928: 1024
Notify on address 0x4001000
Output to block
READ from sector 8385863: 512
Notify on address 0x4001000
Output to block
READ from sector 8385864: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385671: 512
Notify on address 0x4001000
Output to block
READ from sector 8385672: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385911: 512
Notify on address 0x4001000
Output to block
READ from sector 8385912: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385527: 512
Notify on address 0x4001000
Output to block
READ from sector 8385528: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385919: 512
Notify on address 0x4001000
Output to block
READ from sector 8385920: 3584
Notify on address 0x4001000
Output to block
READ from sector 63: 512
Notify on address 0x4001000
Output to block
READ from sector 64: 3584
Notify on address 0x4001000
Output to block
READ from sector 71: 512
Notify on address 0x4001000
Output to block
READ from sector 72: 15872
Notify on address 0x4001000
Output to block
READ from sector 103: 512
Notify on address 0x4001000
Output to block
READ from sector 104: 32256
Notify on address 0x4001000
Output to block
READ from sector 167: 512
Notify on address 0x4001000
Output to block
READ from sector 168: 64000
READ from sector 293: 1024
Notify on address 0x4001000
Output to block
READ from sector 295: 512
Notify on address 0x4001000
Output to block
READ from sector 296: 36352
Notify on address 0x4001000
Output tDone.
Begin: Running /scripts/local-premount ...
Done.
[    2.886829] kjournald starting.  Commit interval 5 seconds
[    2.886829] EXT3-fs: mounted filesystem with ordered data mode.
Begin: Running /scripts/local-bottom ...
Done.
Done.
Begin: Running /scripts/init-bottom ...
o block
READ from sector 367: 36864
Notify on address 0x4001000
Output to block
READ from sector 439: 36864
Notify on address 0x4001000
Output to block
READ from sector 511: 20480
Notify on address 0x4001000
Output to block
READ from sector 8385727: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385927: 512
Notify on address 0x4001000
Output to block
READ from sector 8385928: 1024
Notify on address 0x4001000
Output to block
READ from sector 8385863: 512
Notify on address 0x4001000
Output to block
READ from sector 8385864: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385671: 512
Notify on address 0x4001000
Output to block
READ from sector 8385672: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385911: 512
Notify on address 0x4001000
Output to block
READ from sector 8385912: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385527: 512
Notify on address 0x4001000
Output to block
READ from sector 8385528: 3584
Notify on address 0x4001000
Output to block
READ from sector 8385919: 512
Notify on address 0x4001000
Output to block
READ from sector 8385920: 3584
Notify on address 0x4001000
Output to block
READ from sector 63: 512
Notify on address 0x4001000
Output to block
READ from sector 64: 3584
Notify on address 0x4001000
Output to block
READ from sector 71: 512
Notify on address 0x4001000
Output to block
READ from sector 72: 3584
Notify on address 0x4001000
Output to block
READ from sector 79: 12288
Notify on address 0x4001000
Output to block
READ from sector 103: 512
Notify on address 0x4001000
Output to block
READ from sector 104: 32256
Notify on address 0x4001000
Output to block
READ from sector 167: 512
Notify on address 0x4001000
Output to block
READ from sector 168: 52736
Notify on address 0x4001000
Output to block
READ from sector 271: 12288
Notify on address 0x4001000
Output to block
READ from sector 295: 512
Notify on address 0x4001000
Output to block
READ from sector 296: 36352
Notify on address 0x4001000
Output to block
READ from sector 367: 36864
Notify on address 0x4001000
Output to block
READ from sector 439: 36864
Notify on address 0x4001000
Output to block
READ from sector 511: 20480
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 63: 16384
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 65: 1024
Notify on address 0x4001000
Output to block
READ from sector 63: 4096
Notify on address 0x4001000
Output to block
READ from sector 71: 4096
Notify on address 0x4001000
Output to block
READ from sector 2135: 4096
Notify on address 0x4001000
Output to block
READ from sector 10375: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 10327: 4096
NotifDone.
y on address 0x4001000
Output to block
READ from sector 5767247: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 8126543: 4096
Notify on address 0x4001000
Output to block
READ from sector 1312855: 4096
Notify on address 0x4001000
Output to block
READ from sector 1837143: 4096
Notify on address 0x4001000
Output to block
READ from sector 1900607: 4096
Notify on address 0x4001000
Output to block
READ from sector 1945783: 4096
Notify on address 0x4001000
Output to block
READ from sector 1941767: 16384
Notify on address 0x4001000
Output to block
READ from sector 3407951: 4096
Notify on address 0x4001000
Output to block
READ from sector 3473471: 4096
Notify on address 0x4001000
Output to block
READ from sector 3408327: 4096
Notify on address 0x4001000
Output to block
READ from sector 3933519: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4142127: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4183079: 4096
READ from sector 4419271: 8192
READ from sector 4419327: 4096
READ from sector 4419335: 12288
Notify on address 0x4001000
Output to block
READ from sector 4419359: 73728
Notify on address 0x4001000
Output to block
READ from sector 1941799: 24576
Notify on address 0x4001000
Output to block
READ from sector 4419287: 20480
Notify on address 0x4001000
Output to block
READ from sector 524367: 4096
Notify on address 0x4001000
Output to block
READ from sector 589887: 4096
Notify on address 0x4001000
Output to block
READ from sector 524495: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 540743: 8192
READ from sector 540783: 12288
Notify on address 0x4001000
Output to block
READ from sector 4419815: 16384
Notify on address 0x4001000
Output to block
READ from sector 4419911: 4096
Notify on address 0x4001000
Output to block
READ from sector 4420159: 73728
Notify on address 0x4001000
Output to block
READ from sector 4420303: 16384
Notify on address 0x4001000
Output to block
READ from sector 4420351: 4096
Notify on address 0x4001000
Output to block
READ from sector 4420359: 24576
Notify on address 0x4001000
Output to block
READ from sector 4420407: 45056
Notify on address 0x4001000
Output to block
READ from sector 4457695: 4096
Notify on address 0x4001000
Output to block
READ from sector 4534095: 16384
Notify on address 0x4001000
Output to block
READ from sector 4534191: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4567535: 126976
READ from sector 4567783: 4096
Notify on address 0x4001000
Output to block
READ from sector 4534127: 4096
Notify on address 0x4001000
Output to block
READ from sector 4534135: 28672
Notify on address 0x4001000
Output to block
READ from sector 4534199: 86016
Notify on address 0x4001000
Output to block
READ from sector 4419503: 16384
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4566647: 126976
READ from sector 4566895: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4534839: 126976
Notify on address 0x4001000
Output to block
READ from sector 4554023: 4096
READ from sector 524423: 4096
Notify on address 0x4001000
Output to block
READ from sector 4534679: 81920
Notify on address 0x4001000
Output to block
READ from sector 4567111: 8192
Notify on address 0x4001000
Output to block
READ from sector 4567135: 122880
Notify on address 0x4001000
Output to block
READ from sector 595207: 4096
Notify on address 0x4001000
Output to block
READ from sector 524559: 4096
Notify on address 0x4001000
Output to block
READ from sector 4567375: 81920
Notify on address 0x4001000
Output to block
READ from sector 655455: 4096
Notify on address 0x4001000
Output to block
READ from sector 4534367: 69632
Notify on addre
INIT: version 2.86 booting
ss 0x4001000
Output to block
READ from sector 4534519: 81920
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4566151: 126976
READ from sector 4566399: 4096
Notify on address 0x4001000
Output to block
READ from sector 2097231: 4096
Notify on address 0x4001000
Output to block
READ from sector 1837159: 4096
Notify on address 0x4001000
Output to block
READ from sector 1911383: 16384
Notify on address 0x4001000
Output to block
READ from sector 1911415: 4096
Notify on address 0x4001000
Output to block
READ from sector 1911423: 32768
Notify on address 0x4001000
Output to block
READ from sector 1911487: 40960
Notify on address 0x4001000
Output to block
READ from sector 4566423: 20480
Notify on address 0x4001000
Output to block
READ from sector 4566471: 90112
Notify on address 0x4001000
Output to block
READ from sector 4566903: 53248
Notify on address 0x4001000
Output to block
READ from sector 4567015: 28672
Notify on address 0x4001000
Output to block
READ from sector 524679: 4096
Notify on address 0x4001000
Output to block
READ from sector 704639: 4096
Notify on address 0x4001000
Output to block
READ from sector 594807: 4096
Notify on address 0x4001000
Output to block
READ from sector 721167: 4096
Notify on address 0x4001000
Output to block
READ from sector 721175: 8192
Notify on address 0x4001000
Output to block
READ from sector 594871: 4096
Notify on address 0x4001000
Output to block
READ from sector 3473567: 4096
Notify on address 0x4001000
Output to block
READ from sector 6029391: 4096
Notify on address 0x4001000
Output to block
READ from sector 6183967: 4096
Notify on address 0x4001000
Output to block
READ from sector 6029615: 4096
Notify on address 0x4001000
Output to block
READ from sector 6199127: 16384
Notify on address 0x4001000
Output to block
READ from sector 6199159: 36864
Notify on address 0x4001000
Output to block
READ from sector 6199231: 32768
Notify on address 0x4001000
Output to block
READ from sector 6198991: 16384
Notify on address 0x4001000
Output to block
READ from sector 6199023: 4096
Notify on address 0x4001000
Output to block
READ from sector 6199031: 28672
Notify on address 0x4001000
Output to block
READ from sector 6199087: 4096
Notify on address 0x4001000
Output to block
READ from sector 6199095: 12288
Notify on address 0x4001000
Output to block
READ from sector 5242959: 4096
Notify on address 0x4001000
Output to block
READ from sector 5308479: 4096
Notify on address 0x4001000
Output to block
READ from sector 5242967: 4096
Notify on address 0x4001000
Output to block
READ from sector 5310183: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 524687: 4096
Notify on address 0x4001000
Output to block
READ from sector 630911: 4096
Notify on address 0x4001000
Output to block
READ from sector 5259391: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 5309479: 4096
READ from sector 524375: 4096
Notify on address 0x4001000
Output to block
READ from sector 5243079: 4096
Notify on address 0x4001000
Output to block
READ from sector 590991: 4096
Notify on address 0x4001000
Output to block
READ from sector 524463: 4096
Notify on address 0x4001000
Output to block
READ from sector 595887: 16384
Notify on address 0x4001000
Output to block
READ from sector 788567: 4096
Notify on address 0x4001000
Output to block
READ from sector 852031: 4096
Notify on address 0x4001000
Output to block
READ from sector 788575: 4096
Notify on address 0x4001000
Output to block
READ from sector 860975: 16384
Notify on address 0x4001000
Output to block
READ from sector 861071: 4096
Notify on address 0x4001000
Output to block
READ from sector 866583: 73728
Notify on address 0x4001000
Output to block
READ from sector 861007: 4096
Notify on address 0x4001000
Output to block
READ from sector 861015: 28672
Notify on address 0x4001000
Output to block
READ from sector 861079: 4096
READ from sector 861111: 12288
READ from sector 865439: 65536
READ from sector 3408343: 4096
Notify on address 0x4001000
Output to block
READ from sector 4568239: 16384
Notify on address 0x4001000
Output to block
READ from sector 866255: 126976
READ from sector 866503: 4096
Notify on address 0x4001000
Output to block
READ from sector 865567: 65536
Notify on address 0x4001000
Output to block
READ from sector 865815: 126976
READ from sector 866063: 4096
Notify on address 0x4001000
Output to block
READ from sector 866511: 36864
Notify on address 0x4001000
Output to block
READ from sector 866071: 90112
Notify on address 0x4001000
Output to block
READ from sector 865695: 61440
Notify on address 0x4001000
Output to block
READ from sector 5242983: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325407: 4096
Notify on address 0x4001000
Output to block
READ from sector 590975: 4096
Notify on address 0x4001000
Output to block
READ from sector 3559607: 16384
Notify on address 0x4001000
Output to block
READ from sector 3559639: 32768
Notify on address 0x4001000
Output to block
READ from sector 737415: 4096
Notify on address 0x4001000
Output to block
READ from sector 854775: 12288
READ from sector 595919: 12288
Notify on address 0x4001000
Output to block
READ from sector 788583: 4096
Notify on address 0x4001000
Output to block
READ from sector 855663: 16384
Notify on address 0x4001000
Output to block
READ from sector 855695: 4096
Notify on address 0x4001000
Output to block
READ from sector 589895: 4096
Notify on address 0x4001000
Output to block
READ from sector 589967: 4096
Notify on address 0x4001000
Output to block
READ from sector 3145807: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211327: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211447: 4096
Notify on address 0x4001000
Output to block
READ from sector 3416231: 4096
Notify on address 0x4001000
Output to block
READ from sector 591007: 4096
Notify on address 0x4001000
Output to block
READ from sector 595775: 16384
Notify on address 0x4001000
Output to block
READ from sector 1945775: 4096
Notify on address 0x4001000
Output to block
READ from sector 1924663: 8192
Notify on address 0x4001000
Output to block
READ from sector 590111: 4096
Notify on address 0x4001000
Output to block
READ from sector 595767: 4096
Notify on address 0x4001000
Output to block
READ from sector 630815: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211479: 4096
Notify on address 0x4001000
Output to block
READ from sector 3416399: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211511: 4096
Notify on address 0x4001000
Output to block
READ from sector 3271007: 4096
Notify on address 0x4001000
Output to block
READ from sector 3147047: 4096
Notify on address 0x4001000
Output to block
READ from sector 3563183: 8192
Notify on address 0x4001000
Output to block
READ from sector 3589543: 24576
Notify on address 0x4001000
Output to block
READ from sector 3830967: 20480
READ from sector 3831007: 32768
READ from sector 3589591: 28672
READ from sector 3589647: 12288
READ from sector 3563199: 65536
Notify on address 0x4001000
Output to block
READ from sector 3563391: 126976
READ from sector 3563639: 4096
Notify on address 0x4001000
Output to block
READ from sector 3565255: 126976
READ from sector 3565503: 4096
Notify on address 0x4001000
Output to block
READ from sector 3563647: 73728
Notify on address 0x4001000
Output to block
READ from sector 3565063: 98304
Notify on address 0x4001000
Output to block
READ from sector 4566127: 12288
Notify on address 0x4001000
Output to block
READ from sector 3670095: 4096
Notify on address 0x4001000
Output to block
READ from sector 3739791: 4096
Notify on address 0x4001000
Output to block
READ from sector 3749191: 4096
Notify on address 0x4001000
Output to block
READ from sector 3670159: 4096
Notify on address 0x4001000
Output to block
READ from sector 3866687: 28672
Notify on address 0x4001		Welcome to 000
Output to block
READ from sector 595967: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211343: 4096
Notify on address 0x4001000
Output to block
READ from sector 3145815: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211831: 4096
Notify on address 0x4001000
Output to block
READ from sector 3216999: 4096
Notify on address 0x4001000
Output to block
READ from sector 3146991: 4096
Notify on address 0x4001000
Output to block
READ from sector 3295287: 4096
Notify on address 0x4001000
Output to block
READ from sector 3217007: 4096
Notify on address 0x4001000
Output to block
READ from sector 3145887: 4096
Notify on address 0x4001000
Output to block
READ from sector 3214047: 4096
Notify on address 0x4001000
Output to block
READ from sector 3214055: 4096
Notify on address 0x4001000
Output to block
READ from sector 3213951: 4096
Notify on address 0x4001000
Output to block
READ from sector 3213959: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211335: 4096
Notify on address 0x4001000
Output to block
READ from sector 3416431: 4096
Notify on address 0x4001000
Output to block
READ from sector 859167: 16384
Notify on address 0x4001000
Output to block
READ from sector 859263: 4096
Notify on address 0x4001000
Output to block
READ from sector 861519: 73728
Notify on address 0x4001000
Output to block
READ from sector 4568271: 16384
Notify on address 0x4001000
Output to block
READ from sector 4568367: 4096
Notify on address 0x4001000
Output to block
READ from sector 4568447: 122880
Notify on address 0x4001000
Output to block
READ from sector 859199: 32768
Notify on address 0x4001000
Output to block
READ from sector 859271: 81920
READ from sector 859431: 94208
Notify on address 0x4001000
Output to block
READ from sector 861471: 24576
Notify on address 0x4001000
Output to block
READ from sector 4534503: 8192
Notify on address 0x4001000
Output to block
READ from sector 1837167: 4096
Notify on address 0x4001000
Output to block
READ from sector 1941863: 8192
Notify on address 0x4001000
Output to block
READ from sector 3416439: 4096
Notify on address 0x4001000
Output to block
READ from sector 862951: 16384
Notify on address 0x4001000
Output to block
READ from sector 862983: 4096
Notify on address 0x4001000
Output to block
READ from sector 1837183: 4096
Notify on address 0x4001000
Output to block
READ from sector 1923775: 4096
Notify on address 0x4001000
Output to block
READ from sector 860391: 4096
Notify on address 0x4001000
Output to block
READ from sector 788591: 4096
Notify on address 0x4001000
Output to block
READ from sector 861663: 8192
Notify on address 0x4001000
Output to block
READ from sector 856023: 8192
Notify on address 0x4001000
Output to block
READ from sector 856071: 8192
READ from sector 856087: 16384
READ from sector 856671: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456871: 4096
Notify on address 0x4001000
Output to block
READ from sector 4555487: 4096
Notify on address 0x4001000
Output to block
READ from sector 4555495: 4096
Notify on address 0x4001000
Output to block
READ from sector 4556831: 4096
Notify on address 0x4001000
Output to block
READ from sector 4556839: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456919: 4096
Notify on address 0x4001000
Output to block
READ from sector 861975: 16384
Notify on address 0x4001000
Output to block
READ from sector 862007: 36864
Notify on address 0x4001000
Output to block
READ from sector 862079: 16384
Notify on address 0x4001000
Output to block
READ from sector 4557007: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 524399: 4096
Notify on address 0x4001000
Output to block
READ from sector 593207: 4096
Notify on address 0x4001000
Output to block
READ from sector 4566407: 8192
Notify on address 0x4001000
Output to block
READ from sector 870119: 16384
Notify on address 0x4001000
Output to block
READ from sector 870151: 368 CentOS release 5 (Final)
		Press 'I' to enter interactive startup.
[    4.483371] hwclock[2049] general protection eip:804b593 esp:bfdb5330 error:0
/etc/rc.d/rc.sysinit: line 299:  2049 Segmentation fault      /sbin/hwclock $CLOCKFLAGS
Setting clock  (utc): Thu Oct  4 09:32:35 GMT 2007 [  OK  ]
Starting udev: 64
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 870223: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 630839: 4096
Notify on address 0x4001000
Output to block
READ from sector 1909671: 16384
Notify on address 0x4001000
Output to block
READ from sector 1909703: 20480
Notify on address 0x4001000
Output to block
READ from sector 3408335: 4096
Notify on address 0x4001000
Output to block
READ from sector 4419543: 16384
Notify on address 0x4001000
Output to block
READ from sector 4419575: 36864
Notify on address 0x4001000
Output to block
READ from sector 4419647: 28672
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 869991: 16384
Notify on address 0x4001000
Output to block
READ from sector 870023: 36864
Notify on address 0x4001000
Output to block
READ from sector 870095: 4096
READ from sector 4420751: 16384
Notify on address 0x4001000
Output to block
READ from sector 4420783: 28672
Notify on address 0x4001000
Output to block
READ from sector 4420495: 16384
Notify on address 0x4001000
Output to block
READ from sector 4420527: 36864
Notify on address 0x4001000
Output to block
READ from sector 4420599: 77824
Notify on address 0x4001000
Output to block
READ from sector 655471: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 856511: 16384
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 869399: 8192
Notify on address 0x4001000
Output to block
READ from sector 860407: 4096
Notify on address 0x4001000
Output to block
READ from sector 860503: 12288
READ from sector 860527: 8192
Notify on address 0x4001000
Output to block
READ from sector 1837191: 4096
Notify on address 0x4001000
Output to block
READ from sector 1942007: 12288
Notify on address 0x4001000
Output to block
READ from sector 4441551: 16384
Notify on address 0x4001000
Output to block
READ from sector 4441583: 36864
Notify on address 0x4001000
Output to block
READ from sector 4441655: 8192
Notify on address 0x4001000
Output to block
READ from sector 870231: 16384
Notify on address 0x4001000
Output to block
READ from sector 870263: 24576
Notify on address 0x4001000
Output to block
READ from sector 1837151: 4096
Notify on address 0x4001000
Output to block
READ from sector 1941943: 16384
Notify on address 0x4001000
Output to block
READ from sector 1837175: 4096
Notify on address 0x4001000
Output to block
READ from sector 1935415: 8192
Notify on address 0x4001000
Output to block
READ from sector 595655: 4096
Notify on address 0x4001000
Output to block
READ from sector 524543: 4096
Notify on address 0x4001000
Output to block
READ from sector 598815: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 854663: 16384
Notify on address 0x4001000
Output to block
READ from sector 854695: 16384
Notify on address 0x4001000
Output to block
READ from sector 861719: 16384
Notify on address 0x4001000
Output to block
READ from sector 861751: 16384
Notify on address 0x4001000
Output to block
READ from sector 598743: 4096
Notify on address 0x4001000
Output to block
READ from sector 598751: 4096
Notify on address 0x4001000
Output to block
READ from sector 1948919: 16384
Notify on address 0x4001000
Output to block
READ from sector 1948951: 12288
Notify on address 0x4001000
Output to block
READ from sector 524503: 4096
Notify on address 0x4001000
Output to block
READ from sector 597567: 4096
Notify on address 0x4001000
Output to block
READ from sector 524535: 4096
Notify on address 0x4001000
Output to block
READ from sector 597487: 4096
Notify on address 0x4001000
Output to block
READ from sector 597575: 8192
Notify on address 0x4001000
Output to block
READ from sector 597591: 16384
Notify on address 0x4001000
Output to block
READ from sector 597623: 36864
Notify on address 0x4001000
Output to block
READ from sector 597695: 57344
Notify on address 0x4001000
Output to block
READ from sector 597807: 4096
Notify on address 0x4001000
Output to block
READ from sector 597815: 4096
Notify on address 0x4001000
Output to block
READ from sector 597823: 16384
Notify on address 0x4001000
Output to block
READ from sector 597855: 32768
Notify on address 0x4001000
Output to block
READ from sector 597919: 4096
Notify on address 0x4001000
Output to block
READ from sector 597927: 65536
Notify on address 0x4001000
Output to block
READ from sector 598055: 86016
Notify on address 0x4001000
Output to block
READ from sector 598223: 4096
Notify on address 0x4001000
Output to block
READ from sector 598231: 4096
Notify on address 0x4001000
Output to block
READ from sector 598239: 4096
Notify on address 0x4001000
Output to block
READ from sector 598247: 4096
Notify on address 0x4001000
Output to block
READ from sector 598255: 16384
Notify on address 0x4001000
Output to block
READ from sector 598287: 36864
Notify on address 0x4001000
Output to block
READ from sector 598359: 53248
Notify on address 0x4001000
Output to block
READ from sector 598463: 4096
Notify on address 0x4001000
Output to block
READ from sector 598471: 4096
Notify on address 0x4001000
Output to block
READ from sector 598479: 4096
Notify on address 0x4001000
Output to block
READ from sector 598487: 16384
Notify on address 0x4001000
Output to block
READ from sector 598519: 32768
Notify on address 0x4001000
Output to block
READ from sector 598583: 4096
Notify on address 0x4001000
Output to block
READ from sector 598591: 20480
Notify on address 0x4001000
Output to block
READ from sector 598631: 4096
Notify on address 0x4001000
Output to block
READ from sector 598639: 4096
Notify on address 0x4001000
Output to block
READ from sector 598647: 4096
Notify on address 0x4001000
Output to block
READ from sector 598655: 4096
Notify on address 0x4001000
Output to block
READ from sector 598663: 4096
Notify on address 0x4001000
Output to block
READ from sector 598671: 4096
Notify on address 0x4001000
Output to block
READ from sector 598679: 4096
Notify on address 0x4001000
Output to block
READ from sector 598687: 4096
Notify on address 0x4001000
Output to block
READ from sector 598695: 4096
Notify on address 0x4001000
Output to block
READ from sector 598703: 4096
Notify on address 0x4001000
Output to block
READ from sector 540775: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456863: 4096
Notify on address 0x4001000
Output to block
READ from sector 4553119: 4096
Notify on address 0x4001000
Output to block
READ from sector 4457351: 4096
Notify on address 0x4001000
Output to block
READ from sector 4591919: 4096
Notify on address 0x4001000
Output to block
READ from sector 869143: 16384
Notify on address 0x4001000
Output to block
READ from sector 869175: 28672
Notify on address 0x4001000
Output to block
READ from sector 1935455: 16384
Notify on address 0x4001000
Output to block
READ from sector 1935487: 36864
Notify on address 0x4001000
Output to block
READ from sector 1935559: 24576
Notify on address 0x4001000
Output to block
READ from sector 524455: 4096
Notify on address 0x4001000
Output to block
READ from sector 595663: 4096
Notify on address 0x4001000
Output to block
READ from sector 598759: 4096
Notify on address 0x4001000
Output to block
READ from sector 598767: 16384
Notify on address 0x4001000
Output to block
READ from sector 598799: 4096
Notify on address 0x4001000
Output to block
READ from sector 524479: 4096
Notify on address 0x4001000
Output to block
READ from sector 596487: 4096
Notify on address 0x4001000
Output to block
READ from sector 524583: 4096
Notify on address 0x4001000
Output to block
READ from sector 627143: 4096
Notify on address 0x4001000
Output to block
READ from sector 598855: 4096
Notify on address 0x4001000
Output to block
READ from sector 524551: 4096
Notify on address 0x4001000
Output to block
READ from sector 598959: 4096
Notify on address 0x4001000
Output to block
READ from sector 598807: 4096
Notify on address 0x4001000
Output to block
READ from sector 524639: 4096
Notify on address 0x4001000
Output to block
READ from sector 629839: 4096
Notify on address 0x4001000
Output to block
READ from sector 1937239: 16384
Notify on address 0x4001000
Output to block
READ from sector 1937271: 8192
Notify on address 0x4001000
Output to block
READ from sector 4457359: 4096
Notify on address 0x4001000
Output to block
READ from sector 4592071: 12288
Notify on address 0x4001000
Output to block
READ from sector 4592047: 12288
Notify on address 0x4001000
Output to block
READ from sector 598711: 4096
Notify on address 0x4001000
Output to block
READ from sector 598719: 4096
Notify on address 0x4001000
Output to block
READ from sector 1945727: 16384
Notify on address 0x4001000
Output to block
READ from sector 1945759: 8192
READ from sector 1946775: 8192
READ from sector 1948839: 4096
Notify on address 0x4001000
Output to block
READ from sector 3408351: 4096
Notify on address 0x4001000
Output to block
READ from sector 4419703: 16384
Notify on address 0x4001000
Output to block
READ from sector 4419735: 28672
Notify on address 0x4001000
Output to block
READ from sector 524415: 4096
Notify on address 0x4001000
Output to block
READ from sector 593639: 4096
Notify on address 0x4001000
Output to block
READ from sector 595503: 4096
Notify on address 0x4001000
Output to block
READ from sector 595511: 4096
Notify on address 0x4001000
Output to block
READ from sector 595519: 4096
Notify on address 0x4001000
Output to block
READ from sector 5242975: 4096
Notify on address 0x4001000
Output to block
READ from sector 5323335: 4096
Notify on address 0x4001000
Output to block
READ from sector 4194383: 4096
Notify on address 0x4001000
Output to block
READ from sector 4259903: 4096
Notify on address 0x4001000
Output to block
READ from sector 1937199: 16384
Notify on address 0x4001000
Output to block
READ from sector 1937231: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4591959: 4096
READ from sector 4456535: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4523271: 12288
READ from sector 4592143: 16384
Notify on address 0x4001000
Output to block
READ from sector 4592239: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4296319: 12288
READ from sector 4296351: 4096
Notify on address 0x4001000
Output to block
READ from sector 4592951: 73728
READ from sector 4420871: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4592175: 32768
READ from sector 4592247: 81920
Notify on address 0x4001000
Output to block
READ from sector 4421903: 73728
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4592751: 102400
READ from sector 4296359: 12288
Notify on address 0x4001000
Output to block
READ from sector 4395511: 4096
READ from sector 4420839: 16384
READ from sector 4420879: 81920
Notify on address 0x4001000
Output to block
READ from sector 6029607: 4096
READ from sector 4592407: 114688
Notify on address 0x4001000
Output to block
READ from sector 4421351: 126976
READ from sector 4421599: 4096[  OK  ]

READ from sector 8388480: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 589903: 4096
READ from sector 8388600: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 6183975: 4096
READ from sector 4421055: 126976
READ from sector 4421303: 4096
READ from sector 8388544: 4096
Notify on address 0x4001000
Output to block
READ from sector 4421311: 20480
Notify on address 0x4001000
Output to block
READ from sector 4421607: 106496
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 630847: 4096
READ from sector 8388352: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 6555735: 4096
Notify on address 0x4001000
Output to block
READ from sector 595983: 4096
READ from sector 8388592: 4096
Notify on address 0x4001000
Output to block
READ from sector 6611159: 4096
READ from sector 8388208: 4096
Notify on address 0x4001000
Output to block
READ from sector 0: 4096
Notify on address 0x4001000
Output to block
READ from sector 8: 16384
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 7340143: 4096
READ from sector 40: 98304
Notify on address 0x4001000
Output to block
READ from sector 232: 126976
READ from sector 480: 4096
READ from sector 512: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 4592631: 61440
READ from sector 7475183: 4096
Notify on address 0x4001000
Output to block
READ from sector 6555943: 4096
READ from sector 7340151: 4096
Notify on address 0x4001000
Output to block
READ from sector 6620151: 4096
Notify on address 0x4001000
Output to block
READ from sector 6621687: 32768
Notify on address 0x4001000
Output to block
READ from sector 6621751: 20480
Notify on address 0x4001000
Output to block
READ from sector 6621791: 69632
Notify on address 0x4001000
Output to block
READ from sector 4591927: 12288
Notify on address 0x4001000
Output to block
READ from sector 524471: 4096
Notify on address 0x4001000
Output to block
READ from sector 596327: 4096
Notify on address 0x4001000
Output to block
READ from sector 596335: 12288
Notify on address 0x4001000
Output to block
READ from sector 8385727: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385863: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385671: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385911: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385527: 4096
Notify on address 0x4001000
Output to block
READ from sector 8385919: 4096
Notify on address 0x4001000
Output to block
READ from sector 79: 126976
READ from sector 327: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 595975: 4096
Notify on address 0x4001000
Output to block
READ from sector 598735: 4096
Notify on address 0x4001000
Output to block
READ from sector 7477767: 32768
Notify on address 0x4001000
Output to block
READ from sector 7477831: 20480
Notify on address 0x4001000
Output to block
READ from sector 7477871: 49152
Notify on address 0x4001000
Output to block
READ from sector 7477967: 126976
READ from sector 7478215: 4096
READ from sector 7478223: 57344
Notify on address 0x4001000
Output to block
READ from sector 7340167: 4096
Notify on address 0x4001000
Output to block
READ from sector 7499695: 4096
Notify on address 0x4001000
Output to block
READ from sector 7499927: 32768
Notify on address 0x4001000
Output to block
READ from sector 7499991: 20480
Notify on address 0x400Loading default keymap (uk): [  OK  ]
Setting hostname localhost.localdomain:  [  OK  ]
1000
Output to block
READ from sector 7500031: 49152
Notify on address 0x4001000
Output to block
READ from sector 7500127: 126976
READ from sector 7500375: 4096
Notify on address 0x4001000
Output to block
READ from sector 7500383: 126976
READ from sector 7500631: 4096
Notify on address 0x4001000
Output to block
READ from sector 7500639: 126976
READ from sector 7500887: 4096
READ from sector 7500895: 32768
Notify on address 0x4001000
Output to block
READ from sector 860655: 16384
Notify on address 0x4001000
Output to block
READ from sector 860687: 36864
Notify on address 0x4001000
Output to block
READ from sector 860759: 12288
Notify on address 0x4001000
Output to block
READ from sector 3856647: 16384
Notify on address 0x4001000
Output to block
READ from sector 3856679: 24576
Notify on address 0x4001000
Output to block
READ from sector 3856479: 12288
Notify on address 0x4001000
Output to block
READ from sector 3856503: 16384
Notify on address 0x4001000
Output to block
READ from sector 3856535: 36864
Notify on address 0x4001000
Output to block
READ from sector 3856607: 20480
Notify on address 0x4001000
Output to block
READ from sector 524439: 4096
Notify on address 0x4001000
Output to block
READ from sector 595239: 4096
Notify on address 0x4001000
Output to block
READ from sector 704591: 4096
Notify on address 0x4001000
Output to block
READ from sector 589935: 4096
Notify on address 0x4001000
Output to block
READ from sector 596479: 4096
Notify on address 0x4001000
Output to block
READ from sector 595959: 4096
Notify on address 0x4001000
Output to block
READ from sector 630823: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456943: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 869823: 16384
Notify on address 0x4001000
Output to block
READ from sector 869855: 36864
Notify on address 0x4001000
Output to block
READ from sector 869927: 32768
Notify on address 0x4001000
Output to block
READ from sector 4558399: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456983: 4096
Notify on address 0x4001000
Output to block
READ from sector 4559799: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558471: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456951: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558591: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558655: 4096
Notify on address 0x4001000
Output to block
READ from sector 4456975: 4096
Notify on address 0x4001000
Output to block
READ from sector 4559671: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558823: 4096
Notify on address 0x4001000
Output to block
READ from sector 4559647: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558791: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558687: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558767: 4096
Notify on address 0x4001000
Output to block
READ from sector 4558743: 8192
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 1904591: 16384
Notify on address 0x4001000
Output to block
READ from sector 1904687: 4096
Notify on address 0x4001000
Output to block
READ from sector 1909039: 69632
Notify on address 0x4001000
Output to block
READ from sector 1906895: 126976
READ from sector 1907143: 4096
Notify on address 0x4001000
Output to block
READ from sector 1907847: 126976
Notify raidautorun: failed to open /dev/md0: No such device or address
on address 0x4001000
Output to block
READ from sector 1908095: 4096
READ from sector 1908503: 126976
READ from sector 1908751: 4096
Notify on address 0x4001000
Output to block
READ from sector 1907375: 126976
READ from sector 1907623: 4096
Notify on address 0x4001000
Output to block
READ from sector 1907631: 110592
Notify on address 0x4001000
Output to block
READ from sector 1907151: 65536
Notify on address 0x4001000
Output to block
READ from sector 1908119: 126976
READ from sector 1908367: 4096
Notify on address 0x4001000
Output to block
READ from sector 1908759: 69632
Notify on address 0x4001000
Output to block
READ from sector 1905887: 126976
READ from sector 1906135: 4096
Notify on address 0x4001000
Output to block
READ from sector 1908375: 65536
Notify on address 0x4001000
Output to block
READ from sector 1904623: 32768
READ from sector 1904695: 86016
Notify on address 0x4001000
Output to block
READ from sector 1907279: 49152
Notify on address 0x4001000
Output to block
READ from sector 1905303: 126976
READ from sector 1905551: 4096
Notify on address 0x4001000
Output to block
READ from sector 1904967: 126976
READ from sector 1905215: 4096
Notify on address 0x4001000
Output to block
READ from sector 1904863: 53248
Notify on address 0x4001000
Output to block
READ from sector 1905223: 40960
Notify on address 0x4001000
Output to block
READ from sector 3416159: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 855479: 16384
Notify on address 0x4001000
Output to block
READ from sector 855511: 36864
Notify on address 0x4001000
Output to block
READ from sector 855583: 32768
READ from sector 855703: 4096
Notify on address 0x4001000
Output to block
READ from sector 4439919: 16384
Notify on address 0x4001000
Output to block
READ from sector 4440007: 8192
Notify on address 0x4001000
Output to block
READ from sector 4440023: 69632
Notify on address 0x4001000
Output to block
READ from sector 7507743: 4096
Notify on address 0x4001000
Output to block
READ from sector 7508287: 32768
Notify on address 0x4001000
Output to block
READ from sector 7508351: 20480
Notify on address 0x4001000
Output to block
READ from sector 7508391: 49152
Notify on address 0x4001000
Output to block
READ from sector 7508487: 126976
READ from sector 7508735: 4096
Notify on address 0x4001000
Output to block
READ from sector 7508743: 126976
READ from sector 7508991: 4096
Notify on address 0x4001000
Output to block
READ from sector 7508999: 126976
READ from sector 7509247: 4096
Notify on address 0x4001000
Output to block
READ from sector 7509255: 126976
READ from sector 7509503: 4096
Notify on address 0x4001000
Output to block
READ from sector 7509511: 126976
READ from sector 7509759: 4096
Notify on address 0x4001000
Output to block
READ from sector 7509767: 126976
READ from sector 7510015: 4096
READ from sector 7510023: 49152
Notify on address 0x4001000
Output to block
READ from sector 855431: 16384
Notify on address 0x4001000
Output to block
READ from sector 855463: 8192
Notify on address 0x4001000
Output to block
READ from sector 7340175: 4096
Notify on address 0x4001000
Output to block
READ from sector 7511887: 32768
Notify on address 0x4001000
Output to block
READ from sector 7511951: 20480
Notify on address 0x4001000
Output to block
READ from sector 7511991: 49152
Notify on address 0x4001000
Output to block
READ from sector 7512087: 126976
READ from sector 7512335: 4096
READ from sector 7512343: 77824
Notify on address 0x4001000
Output to block
READ from sector 1933431: 16384
Notify on address 0x4001000
Output to block
READ from sector 1933527: 4096
Notify on address 0x4001000
Output to block
READ from sector 1935215: 69632
Notify on address 0x4001000
Output to block
READ from sector 1933879: 126976
READ from sector 1934127: 4096
Notify on address 0x4001000
Output to block
READ from sector 1934287: 126976
READ from sector 1934535: 4096
Notify on address 0x4001000
Output to block
READ from sector 1934935: Setting up Logical Volume Management:   No volume groups found
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/vda1 
126976
READ from sector 1935183: 4096
Notify on address 0x4001000
Output to block
READ from sector 1934135: 77824
Notify on address 0x4001000
Output to block
READ from sector 1934615: 126976
READ from sector 1934863: 4096
Notify on address 0x4001000
Output to block
READ from sector 1935191: 12288
Notify on address 0x4001000
Output to block
READ from sector 1933599: 126976
READ from sector 1933847: 4096
Notify on address 0x4001000
Output to block
READ from sector 1934543: 36864
Notify on address 0x4001000
Output to block
READ from sector 1933463: 32768
READ from sector 1933535: 32768
Notify on address 0x4001000
Output to block
READ from sector 1934871: 32768
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 1928455: 16384
Notify on address 0x4001000
Output to block
READ from sector 1928551: 4096
Notify on address 0x4001000
Output to block
READ from sector 1931559: 69632
Notify on address 0x4001000
Output to block
READ from sector 1929823: 126976
READ from sector 1930071: 4096
Notify on address 0x4001000
Output to block
READ from sector 1930431: 126976
READ from sector 1930679: 4096
Notify on address 0x4001000
Output to block
READ from sector 1931183: 126976
READ from sector 1931431: 4096
Notify on address 0x4001000
Output to block
READ from sector 1930111: 126976
READ from sector 1930359: 4096
Notify on address 0x4001000
Output to block
READ from sector 1930711: 126976
READ from sector 1930959: 4096
Notify on address 0x4001000
Output to block
READ from sector 1931439: 61440
Notify on address 0x4001000
Output to block
READ from sector 1929407: 126976
READ from sector 1929655: 4096
Notify on address 0x4001000
Output to block
READ from sector 1931031: 77824
Notify on address 0x4001000
Output to block
READ from sector 1930079: 16384
Notify on address 0x4001000
Output to block
READ from sector 1929111: 126976
READ from sector 1929359: 4096
Notify on address 0x4001000
Output to block
READ from sector 1928591: 126976
READ from sector 1928839: 4096
Notify on address 0x4001000
Output to block
READ from sector 1928487: 32768
Notify on address 0x4001000
Output to block
READ from sector 1928559: 16384
READ from sector 1930967: 32768
Notify on address 0x4001000
Output to block
READ from sector 1928847: 114688
Notify on address 0x4001000
Output to block
READ from sector 524527: 4096
Notify on address 0x4001000
Output to block
READ from sector 597511: 4096
Notify on address 0x4001000
Output to block
READ from sector 597535: 16384
Notify on address 0x4001000
Output to block
READ from sector 532591: 4096
Notify on address 0x4001000
Output to block
READ from sector 1929071: 20480
Notify on address 0x4001000
Output to block
READ from sector 5310143: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 596471: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 1911335: 16384
Notify on address 0x4001000
Output to block
READ from sector 1911367: 8192
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 1920431: 16384
Notify on address 0x4001000
Output to block/: clean, 64515/1048576 files, 599286/1048233 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]

READ from sector 1920527: 4096
Notify on address 0x4001000
Output to block
READ from sector 1922351: 69632
Notify on address 0x4001000
Output to block
READ from sector 1920967: 126976
READ from sector 1921215: 4096
Notify on address 0x4001000
Output to block
READ from sector 1921431: 126976
READ from sector 1921679: 4096
Notify on address 0x4001000
Output to block
READ from sector 1922063: 126976
READ from sector 1922311: 4096
Notify on address 0x4001000
Output to block
READ from sector 1921223: 106496
Notify on address 0x4001000
Output to block
READ from sector 1921735: 126976
READ from sector 1921983: 4096
Notify on address 0x4001000
Output to block
READ from sector 1922319: 16384
Notify on address 0x4001000
Output to block
READ from sector 1920639: 126976
READ from sector 1920887: 4096
Notify on address 0x4001000
Output to block
READ from sector 1920463: 32768
READ from sector 1920535: 53248
Notify on address 0x4001000
Output to block
READ from sector 10367: 4096
Notify on address 0x4001000
Output to block
READ from sector 335: 16384
Notify on address 0x4001000
Output to block
READ from sector 367: 98304
Notify on address 0x4001000
Output to block
READ from sector 559: 126976
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 807: 126976
READ from sector 1055: 8192
READ from sector 1921991: 36864
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
WRITE to sector 10375: 4096
Notify on address 0x4001000
Output to block
WRITE to sector 63: 4096
Notify on address 0x4001000
Output to block
READ from sector 524359: 4096
Notify on address 0x4001000
Output to block
READ from sector 532639: 4096
Notify on address 0x4001000
Output to block
READ from sector 524647: 4096
Notify on address 0x4001000
Output to block
READ from sector 524351: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 532623: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 1909799: 16384
Notify on address 0x4001000
Output to block
READ from sector 1909831: 36864
Notify on address 0x4001000
Output to block
READ from sector 1909903: 20480
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 5308487: 4096
Notify on address 0x4001000
Output to block
READ from sector 5242991: 4096
Notify on address 0x4001000
Output to block
READ from sector 5488703: 4096
Notify on address 0x4001000
Output to block
READ from sector 856719: 16384
Notify on address 0x4001000
Output to block
READ from sector 856751: 4096
READ from sector 856919: 20480
Notify on address 0x4001000
Output to block
READ from sector 860879: 16384
Notify on address 0x4001000
Output to block
READ from sector 860911: 32768
Notify on address 0x4001000
Output to block
READ from sector 5242943: 4096
Notify on addreEnabling /etc/fstab swaps:  [  OK  ]
ss 0x4001000
Output to block
READ from sector 5325431: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325423: 4096
Notify on address 0x4001000
Output to block
READ from sector 5310151: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325343: 4096
Notify on address 0x4001000
Output to block
READ from sector 5251319: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325351: 4096
Notify on address 0x4001000
Output to block
READ from sector 5323295: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325543: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325551: 4096
Notify on address 0x4001000
Output to block
READ from sector 5323375: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325511: 4096
Notify on address 0x4001000
Output to block
READ from sector 5323351: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325175: 4096
Notify on address 0x4001000
Output to block
READ from sector 5318839: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325455: 4096
Notify on address 0x4001000
Output to block
READ from sector 5242951: 4096
Notify on address 0x4001000
Output to block
READ from sector 5325391: 4096
Notify on address 0x4001000
Output to block
READ from sector 5251223: 4096
Notify on address 0x4001000
Output to block
READ from sector 5308495: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
READ from sector 1919871: 16384
Notify on address 0x4001000
Output to block
READ from sector 5251191: 4096
Notify on address 0x4001000
Output to block
READ from sector 1919903: 8192
READ from sector 1922751: 4096
READ from sector 855711: 16384
Notify on address 0x4001000
Output to block
READ from sector 855927: 28672
Notify on address 0x4001000
Output to block
READ from sector 3735615: 4096
Notify on address 0x4001000
Output to block
READ from sector 6816871: 4096
Notify on address 0x4001000
Output to block
READ from sector 6894863: 4096
Notify on address 0x4001000
Output to block
READ from sector 6815807: 4096
Notify on address 0x4001000
Output to block
READ from sector 6815815: 4096
Notify on address 0x4001000
Output to block
READ from sector 3678287: 4096
Notify on address 0x4001000
Output to block
READ from sector 856127: 16384
Notify on address 0x4001000
Output to block
READ from sector 856159: 28672
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 1919279: 16384
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
READ from sector 6189703: 4096
Notify on address 0x4001000
Output to block
READ from sector 6197919: 32768
Notify on address 0x4001000
Output to block
READ from sector 6197983: 20480
Notify on address 0x4001000
Output to block
READ from sector 6198023: 86016
Notify on address 0x4001000
Output to block
READ from sector 3148671: 4096
Notify on address 0x4001000
Output to block
READ from sector 4195303: 4096
Notify on address 0x4001000
Output to block
READ from sector 4371239: 4096
Notify on address 0x4001000
Output to block
READ from sector 4195319: 4096
Notify on address 0x4001000
Output to block
READ from sector 2127: 4096
Notify on address 0x4001000
Output to block
READ from sector 322951: 4096
Notify on address 0x4001000
Output to block
READ from sector 5500207: 4096
Notify on address 0x4001000
Output to block
READ from sector 590103: 4096
Notify on address 0x4001000
Output to block
READ from sector 3147479: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211543: 4096
Notify on address 0x4001000
Output to block
READ from sector 3211599: 4096
Notify on address 0x4001000
Output to block
READ from sector 3839895: 16384
Notify on address 0x4001000
Output to block
READ from sector 3839927: 8192
Notify on address 0x4001000
Output to block
READ fromsh-3.1# 
sh-3.1# 
sh-3.1# 
sh-3.1# 
sh-3.1# 
sh-3.1# 
sh-3.1#  sector 5310191: 4096
Notify on address 0x4001000
Output to block
READ from sector 5310207: 4096
Notify on address 0x4001000
Output to block
READ from sector 593751: 4096
Notify on address 0x4001000
Output to block
READ from sector 3416223: 4096
Notify on address 0x4001000
Output to block
READ from sector 3147399: 4096
Notify on address 0x4001000
Output to block
READ from sector 3867535: 16384
Notify on address 0x4001000
Output to block
READ from sector 3867567: 12288
Notify on address 0x4001000
Output to block
READ from sector 593695: 4096
Notify on address 0x4001000
Output to block
READ from sector 524383: 4096
Notify on address 0x4001000
Output to block
READ from sector 591079: 4096
Notify on address 0x4001000
Output to block
READ from sector 721631: 4096
Notify on address 0x4001000
Output to block
READ from sector 524391: 4096
Notify on address 0x4001000
Output to block
READ from sector 593087: 4096
Notify on address 0x4001000
Output to block
READ from sector 3147383: 4096
Notify on address 0x4001000
Output to block
READ from sector 524671: 4096
Notify on address 0x4001000
Output to block
READ from sector 721615: 4096
Notify on address 0x4001000
Output to block
READ from sector 524567: 4096
Notify on address 0x4001000
Output to block
READ from sector 599343: 4096
Notify on address 0x4001000
Output to block
READ from sector 213055: 4096
Notify on address 0x4001000
Output to block
READ from sector 591151: 16384
Notify on address 0x4001000
Output to block
READ from sector 591183: 36864
Notify on address 0x4001000
Output to block
READ from sector 591255: 65536
Notify on address 0x4001000
Output to block
READ from sector 591383: 126976
READ from sector 591631: 4096
READ from sector 590079: 4096
Notify on address 0x4001000
Output to block
READ from sector 866247: 4096
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
WRITE to sector 10375: 4096
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
WRITE to sector 688191: 4096
WRITE to sector 737447: 8192
WRITE to sector 5341271: 4096
WRITE to sector 5488775: 4096
WRITE to sector 5489063: 4096
WRITE to sector 5500207: 4096
WRITE to sector 5259375: 4096
Notify on address 0x4001000
Output to block
WRITE to sector 10383: 4096
READ from sector 10471: 4096
Notify on address 0x4001000
Output to block
WRITE to sector 10479: 126976
WRITE to sector 10727: 94208
WRITE to sector 10391: 40960
Notify on address 0x4001000
Output to block
WRITE to sector 10911: 4096
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
Notify on address 0x4001000
Output to block
WRITE to sector 524351: 4096
WRITE to sector 63: 8192
WRITE to sector 2127: 8192
WRITE to sector 10327: 4096
WRITE to sector 524359: 20480
WRITE to sector 524415: 8192
WRITE to sector 524439: 4096
WRITE to sector 524455: 4096
WRITE to sector 524463: 4096
WRITE to sector 524495: 4096
WRITE to sector 
sh-3.1# 
sh-3.1# 524559: 8192
WRITE to sector 524583: 4096
WRITE to sector 524647: 4096
WRITE to sector 524671: 12288
WRITE to sector 589887: 4096
WRITE to sector 595239: 4096
Notify on address 0x4001000
Output to block
WRITE to sector 788567: 12288
WRITE to sector 1837143: 20480
WRITE to sector 3146991: 4096
WRITE to sector 3147047: 4096
WRITE to sector 3147399: 4096
WRITE to sector 3147479: 4096
WRITE to sector 3148671: 4096
WRITE to sector 3408327: 16384
WRITE to sector 3670095: 4096
WRITE to sector 3670159: 4096
WRITE to sector 3735615: 4096
WRITE to sector 3933519: 4096
WRITE to sector 4194383: 4096
WRITE to sector 4457695: 4096
WRITE to sector 5242943: 28672
WRITE to sector 5243079: 4096
Notify on address 0x4001000
Output to block
WRITE to sector 5310183: 4096
WRITE to sector 6029615: 4096
WRITE to sector 6815807: 8192
WRITE to sector 6816871: 4096
WRITE to sector 6894871: 4096
Notify on address 0x4001000
Output to block
WRITE to sector 10919: 4096
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4004000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Notify on address 0x4005000
Output to console
Guest base is at 0xb3cde000
device 0: console
mapped initrd /boot/initrd.img-2.6.23-rc9 size=14139392 @ 0x3284000
Linear mapping of 16384 pages in 16 pte pages at 0x3273000
Guest: 0xb3cde000 - 0xb7ce4000 (0x4006000)

--=-z6TJgEiTOdrTBMza0Zwx
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; name=.config; charset=UTF-8
Content-Disposition: attachment; filename=.config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.23-rc9
# Wed Oct  3 15:39:07 2007
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_QUICKLIST=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_USER_NS is not set
CONFIG_AUDIT=y
# CONFIG_AUDITSYSCALL is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_CPUSETS=y
CONFIG_SYSFS_DEPRECATED=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_GUEST=y
# CONFIG_XEN is not set
CONFIG_VMI=y
CONFIG_LGUEST_GUEST=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MCORE2 is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=m
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_EFI_VARS=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_DMIID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_NR_QUICK=1
CONFIG_VIRT_TO_BUS=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_EFI=y
# CONFIG_IRQBALANCE is not set
CONFIG_BOOT_IOREMAP=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_RELOCATABLE=y
CONFIG_PHYSICAL_ALIGN=0x100000
CONFIG_HOTPLUG_CPU=y
CONFIG_COMPAT_VDSO=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_VERBOSE is not set
# CONFIG_DISABLE_CONSOLE_SUSPEND is not set
CONFIG_PM_TRACE=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND_SMP_POSSIBLE=y
CONFIG_SUSPEND=y
CONFIG_HIBERNATION_SMP_POSSIBLE=y
# CONFIG_HIBERNATION is not set
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS is not set
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=m
# CONFIG_ACPI_BAY is not set
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=2000
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_SBS=m
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_PCIEAER=y
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_HT_IRQ=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=m
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=m

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK_ENABLED=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CT_ACCT=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=m
# CONFIG_NF_CT_PROTO_UDPLITE is not set
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_PPTP=m
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_NF_NAT_SIP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_NF_CONNTRACK_IPV6=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AH=m
# CONFIG_IP6_NF_MATCH_MH is not set
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_RAW=m

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_ULOG=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m
CONFIG_IP_DCCP_ACKVEC=y

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
CONFIG_IP_DCCP_CCID2=m
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=m
CONFIG_IP_DCCP_TFRC_LIB=m
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_CCID3_RTO=100

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_NET_DCCPPROBE=m
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_TIPC=m
# CONFIG_TIPC_ADVANCED is not set
# CONFIG_TIPC_DEBUG is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_FIFO=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_RR is not set
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_IPT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_CLS_POLICE=y
# CONFIG_NET_CLS_IND is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_TCPPROBE=m
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
CONFIG_YAM=m
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
# CONFIG_TOIM3232_DONGLE is not set
CONFIG_LITELINK_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m
# CONFIG_KINGSUN_DONGLE is not set

#
# Old SIR device drivers
#

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_VIA_FIR=m
CONFIG_MCS_FIR=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
CONFIG_AF_RXRPC=m
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_FIB_RULES=y

#
# Wireless
#
CONFIG_CFG80211=m
CONFIG_WIRELESS_EXT=y
CONFIG_MAC80211=m
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_DEBUG is not set
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IEEE80211_SOFTMAC=m
# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=m
# CONFIG_MTD is not set
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_VIRTIO_BLK=m
# CONFIG_MISC_DEVICES is not set
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_TGT=m
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_ATA=m
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=m
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_EMC=m
# CONFIG_DM_MULTIPATH_RDAC is not set
# CONFIG_DM_DELAY is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
CONFIG_I2O=m
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=y
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
CONFIG_I2O_BUS=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_IFB is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set
# CONFIG_ARCNET is not set
# CONFIG_NET_ETHERNET is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=m
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
CONFIG_WLAN_80211=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_IPW2100 is not set
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
# CONFIG_IPW2200_DEBUG is not set
# CONFIG_LIBERTAS is not set
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_RTL8187 is not set
# CONFIG_HOSTAP is not set
# CONFIG_BCM43XX is not set
# CONFIG_ZD1211RW is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_NET_PCMCIA is not set
# CONFIG_WAN is not set
# CONFIG_ATM_DRIVERS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
# CONFIG_PPPOL2TP is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_VIRTIO_NET=m
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_MOXA_SMARTIO_NEW is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=m
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=m
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83697HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_PROGEAR is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set
CONFIG_VGASTATE=m
CONFIG_VIDEO_OUTPUT_CONTROL=m
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_SYS_FOPS is not set
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
# CONFIG_FB_VESA is not set
# CONFIG_FB_IMAC is not set
# CONFIG_FB_HECUBA is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=m
# CONFIG_FB_I810_GTF is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
CONFIG_FB_INTEL_I2C=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
CONFIG_SND_AC97_POWER_SAVE=y

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# System on Chip audio support
#
# CONFIG_SND_SOC is not set

#
# SoC Audio support for SuperH
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=m
CONFIG_HID_SUPPORT=y
CONFIG_HID=m
CONFIG_HID_DEBUG=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT_POWERBOOK=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_PERSIST is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_CS=m
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
CONFIG_USB_LIBUSUAL=y

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#
# CONFIG_USB_ATM is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m

#
# LED drivers
#

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=m
# CONFIG_AUXDISPLAY is not set
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_LGUEST=m

#
# Userspace I/O
#
# CONFIG_UIO is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_RING=y

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_BIND34 is not set
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set
CONFIG_INSTRUMENTATION=y
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_FORCED_INLINING is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m
# CONFIG_SECURITY_SELINUX is not set
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_GEODE=m

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_AUDIT_GENERIC=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y

--=-z6TJgEiTOdrTBMza0Zwx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--=-z6TJgEiTOdrTBMza0Zwx--
