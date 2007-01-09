From: Gerd Hoffmann <kraxel@suse.de>
Subject: Oops
Date: Tue, 09 Jan 2007 14:34:15 +0100
Message-ID: <45A399D7.3090205@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060200020604030205090105"
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060200020604030205090105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi,

paravirt kernel doesn't boot as xen guest for me, see attachment.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>

--------------060200020604030205090105
Content-Type: text/x-log;
 name="boot.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.log"

Reserving virtual address space above 0xf57fe000
CPU: Vendor unknown, using generic init.
CPU: Your system may be unstable.
Linux version 2.6.20-rc4-pae-hg689 (kraxel@master-xen) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #7 Tue Jan 9 14:22:16 CET 2007
BIOS-provided physical RAM map:
 Xen: 0000000000000000 - 0000000002000000 (usable)
0MB HIGHMEM available.
32MB LOWMEM available.
NX (Execute Disable) protection: active
about to switch to new pagetable c039e000...
done
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->     8192
  HighMem      8192 ->     8192
early_node_map[1] active PFN ranges
    0:        0 ->     8192
DMI not present or invalid.
Allocating PCI resources starting at 10000000 (gap: 02000000:fe000000)
Detected 3793.006 MHz processor.
Built 1 zonelists.  Total pages: 8128
Kernel command line: root=/dev/ram0 ro 
Local APIC disabled by BIOS -- you can enable it with "lapic"
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 128 (order: 7, 512 bytes)
Xen reported: 3792.882 MHz processor.
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 25172k/32768k available (1741k kernel code, 7596k reserved, 754k data, 172k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xf57ac000 - 0xf57fd000   ( 324 kB)
    pkmap   : 0xf5400000 - 0xf5600000   (2048 kB)
    vmalloc : 0xc2800000 - 0xf53fe000   ( 811 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
      .init : 0xc0372000 - 0xc039d000   ( 172 kB)
      .data : 0xc02b3637 - 0xc036feb0   ( 754 kB)
      .text : 0xc0100000 - 0xc02b3637   (1741 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 7589.84 BogoMIPS (lpj=37949208)
Mount-cache hash table entries: 512
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
CPU: Intel Genuine Intel(R) CPU 3.80GHz stepping 06
Booting paravirtualized kernel on Xen
Hypervisor signature: xen-3.0-x86_32p
Grant table initialized
NET: Registered protocol family 16
Setting up standard PCI resources
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 4096k freed
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
rtc: IRQ 8 is not free.
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Registering block device major 202
netconsole: not configured, aborting
Xen virtual console successfully installed as tty1
netfront: Initialising virtual ethernet driver.
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
oprofile: using timer interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: xen clocksource has been installed.
blkfront: xvda: barriers enabled
 xvda: xvda1 xvda2
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096KiB [1 disk] into ram disk... done.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 172k freed
BUG: unable to handle kernel paging request at virtual address c2ffffe0
 printing eip:
c0102545
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0061:[<c0102545>]    Not tainted VLI
EFLAGS: 00010202   (2.6.20-rc4-pae-hg689 #7)
EIP is at pgd_walk+0x7d/0x139
eax: 01ffffe0   ebx: c1915d60   ecx: fffff0a1   edx: 00000000
esi: c1000000   edi: c1911000   ebp: c1911000   esp: c1067ee0
ds: 007b   es: 007b   ss: 0069
Process init (pid: 1, ti=c1066000 task=c1064a70 task.ti=c1066000)
Stack: 00000061 80000000 01915000 00000000 c1821570 00000009 c1911000 00000000 
       00000000 c1b3b030 c010261c 00000003 c1230f3c c12305f4 c1230f3c 00000000 
       c0116755 c1230f00 c0112031 c0149219 c1067fb8 bf8ab844 00000011 00000000 
Call Trace:
 [<c010261c>] xen_pgd_pin+0x1b/0x67
 [<c0116755>] copy_process+0x96e/0xe50
 [<c0112031>] paravirt_restore_flags+0x6/0x7
 [<c0149219>] kmem_cache_alloc+0x50/0x5c
 [<c0116e3b>] do_fork+0x9e/0x17d
 [<c01fd699>] copy_to_user+0x2d/0x44
 [<c0102c0d>] sys_fork+0x2c/0x30
 [<c01045d8>] syscall_call+0x7/0xb
 =======================
Code: 8b 03 8b 53 04 ff 15 cc f0 34 c0 85 c0 74 5e 8b 35 c0 d6 3e c0 85 f6 74 33 8b 03 8b 53 04 ff 15 cc f0 34 c0 0f ac d0 0c c1 e0 05 <8b> 04 30 c1 e8 1e 69 c0 44 01 00 00 05 e0 0b 35 c0 8b 90 30 01 
EIP: [<c0102545>] pgd_walk+0x7d/0x139 SS:ESP 0069:c1067ee0
 <0>Kernel panic - not syncing: Attempted to kill init!

--------------060200020604030205090105
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------060200020604030205090105--
