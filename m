From: "Thomas D." <whissi@whissi.de>
Subject: kernel BUG at drivers/block/virtio_blk.c:172!
Date: Thu, 1 Oct 2015 03:10:14 +0200
Message-ID: <560C87F6.4080708@whissi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I have a virtual machine which fails to boot linux-4.1.8 while mounting
file systems:

> * Mounting local filesystem ...
> ------------[ cut here ]------------
> kernel BUG at drivers/block/virtio_blk.c:172!
> invalid opcode: 000 [#1] SMP
> Modules linked in: pcspkr psmouse dm_log_userspace virtio_net e1000 fuse nfs lockd grace sunrpc fscache dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log usbhid usb_storage sr_mod cdrom
> CPU: 7 PIDL 2254 Comm: dmcrypt_write Not tainted 4.1.8-gentoo #1
> Hardware name: Red Hat KVM, BIOS seabios-1.7.5-8.el7 04/01/2014
> task: ffff88061fb70000 ti: ffff88061ff30000 task.ti: ffff88061ff30000
> RIP: 0010:[<ffffffffb4557b30>] [<ffffffffb4557b30>] virtio_queue_rq+0x210/0x2b0
> RSP: 0018:ffff88061ff33ba8 EFLAGS: 00010202
> RAX: 00000000000000b1 RBX: ffff88061fb2fc00 RCX: ffff88061ff33c30
> RDX: 0000000000000008 RSI: ffff88061ff33c50 RDI: ffff88061fb2fc00
> RBP: ffff88061ff33bf8 R08: ffff88061eef3540 R09: ffff88061ff33c30
> R10: 0000000000000000 R11: 00000000000000af R12: 0000000000000000
> R13: ffff88061eef3540 R14: ffff88061eef3540 R15: ffff880622c7ca80
> FS:  0000000000000000(0000) GS:ffff88063fdc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001ffe468 CR3: 00000000bb343000 CR4: 00000000001406e0
> Stack:
>  ffff880622d4c478 0000000000000000 ffff88061ff33bd8 ffff88061fb2f
>  0000000000000001 ffff88061fb2fc00 ffff88061ff33c30 0000000000000
>  ffff88061eef3540 0000000000000000 ffff88061ff33c98 ffffffffb43eb
> 
> Call Trace:
>  [<ffffffffb43eb500>] __blk_mq_run_hw_queue+0x1d0/0x370
>  [<ffffffffb43eb315>] blk_mq_run_hw_queue+0x95/0xb0
>  [<ffffffffb43ec804>] blk_mq_flush_plug_list+0x129/0x140
>  [<ffffffffb43e33d8>] blk_finish_plug+0x18/0x50
>  [<ffffffffb45e3bea>] dmcrypt_write+0x1da/0x1f0
>  [<ffffffffb4108c90>] ? wake_up_state+0x20/0x20
>  [<ffffffffb45e3a10>] ? crypt_iv_lmk_dtr+0x60/0x60
>  [<ffffffffb40fb789>] kthread_create_on_node+0x180/0x180
>  [<ffffffffb4705e92>] ret_from_fork+0x42/0x70
>  [<ffffffffb40fb6c0>] ? kthread_create_on_node+0x180/0x180
> Code: 00 0000 41 c7 85 78 01 00 00 08 00 00 00 49 c7 85 80 01 00 00 00 00 00 00 41 89 85 7c 01 00 00 e9 93 fe ff ff 66 0f 1f 44 00 00 <0f> 0b 66 0f 1f 44 00 00 49 8b 87 b0 00 00 00 41 83 e6 ef 4a 8b
> RIP [<ffffffffb4557b30>] virtio_queue_rq+0x210/0x2b0
>  RSP: <ffff88061ff33ba8>
> ---[ end trace 8078357c459d5fc0 ]---


System details:
===============
VM (KVM), I don't know any details about the host system.

The disk (vda) is partitioned in vda1 (ext4, /boot) and vda2
(LUKS-encrypted).
On top of the LUKS volume I have LVM.
On top of LVM I have several partitions, all XFS (so rootfs is on XFS!).

1/20 reboots seems to success.

Today I tried to upgrade to linux-4.1.9. Mounting wasn't a problem
anymore but after ~5min the system always dies with

> NMI watchdog: BUG: soft lockup - CPU#3 stuck for 23s!

(CPU number varies)

dmesg:

> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 4.1.8-gentoo (root@sysresccd) (gcc version 4.9.3 (Gentoo 4.9.3 p1.2, pie-0.6.3) ) #1 SMP Thu Sep 24 03:44:37 CEST 2015
> [    0.000000] Command line: BOOT_IMAGE=/kernel-genkernel-x86_64-4.1.8-gentoo root=/dev/mapper/vps1storage-volRoot ro dolvm crypt_root=UUID=fdea18e4-ba0f-1234-1234-12345678 root=UUID=86dad6e6-e43e-1234-1234-987654321 rootfs=xfs scandelay=3 nomodeset
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000063fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: Red Hat KVM, BIOS seabios-1.7.5-8.el7 04/01/2014
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] e820: last_pfn = 0x640000 max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: write-back
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 0000C0000000 mask 3FFFC0000000 uncachable
> [    0.000000]   1 disabled
> [    0.000000]   2 disabled
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
> [    0.000000] e820: last_pfn = 0xbffdf max_arch_pfn = 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000f1fb0-0x000f1fbf] mapped at [ffff8800000f1fb0]
> [    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x27016000, 0x27016fff] PGTABLE
> [    0.000000] BRK [0x27017000, 0x27017fff] PGTABLE
> [    0.000000] BRK [0x27018000, 0x27018fff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x63fe00000-0x63fffffff]
> [    0.000000]  [mem 0x63fe00000-0x63fffffff] page 1G
> [    0.000000] init_memory_mapping: [mem 0x620000000-0x63fdfffff]
> [    0.000000]  [mem 0x620000000-0x63fdfffff] page 1G
> [    0.000000] init_memory_mapping: [mem 0x00100000-0xbffdefff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
> [    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
> [    0.000000]  [mem 0x80000000-0xbfdfffff] page 2M
> [    0.000000]  [mem 0xbfe00000-0xbffdefff] page 4k
> [    0.000000] init_memory_mapping: [mem 0x100000000-0x61fffffff]
> [    0.000000]  [mem 0x100000000-0x61fffffff] page 1G
> [    0.000000] RAMDISK: [mem 0x37a10000-0x37cfffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F1F60 000014 (v00 BOCHS )
> [    0.000000] ACPI: RSDT 0x00000000BFFE163C 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACP 0x00000000BFFE0677 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x00000000BFFDFB80 000AF7 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACS 0x00000000BFFDFB40 000040
> [    0.000000] ACPI: SSDT 0x00000000BFFE06EB 000EA1 (v01 BOCHS  BXPCSSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: APIC 0x00000000BFFE158C 0000B0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000063fffffff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x63ffd8000-0x63fffdfff]
> [    0.000000]  [ffffea0000000000-ffffea0018ffffff] PMD -> [ffff880627600000-ffff88063f5fffff] on node 0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000063fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffdefff]
> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000063fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000063fffffff]
> [    0.000000] On node 0 totalpages: 6291325
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 12224 pages used for memmap
> [    0.000000]   DMA32 zone: 782303 pages, LIFO batch:31
> [    0.000000]   Normal zone: 86016 pages used for memmap
> [    0.000000]   Normal zone: 5505024 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x608
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ5 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] ACPI: IRQ10 used by override.
> [    0.000000] ACPI: IRQ11 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.000000] e820: [mem 0xc0000000-0xfeffbfff] available for PCI devices
> [    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
> [    0.000000] PERCPU: Embedded 33 pages/cpu @ffff88063fc00000 s95192 r8192 d31784 u262144
> [    0.000000] pcpu-alloc: s95192 r8192 d31784 u262144 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 6193000
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/kernel-genkernel-x86_64-4.1.8-gentoo root=/dev/mapper/vps1storage-volRoot ro dolvm crypt_root=UUID=fdea18e4-ba0f-4c82-8ebb-3dd160859ee8 root=UUID=86dad6e6-e43e-4b4e-a445-c2fe3d9aee13 rootfs=xfs scandelay=3 nomodeset
> [    0.000000] log_buf_len individual max cpu contribution: 32768 bytes
> [    0.000000] log_buf_len total cpu_extra contributions: 229376 bytes
> [    0.000000] log_buf_len min size: 262144 bytes
> [    0.000000] log_buf_len: 524288 bytes
> [    0.000000] early log buf free: 254352(97%)
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
> [    0.000000] Memory: 24684464K/25165300K available (7210K kernel code, 1199K rwdata, 2812K rodata, 1500K init, 1452K bss, 480836K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=8.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.000000] NR_IRQS:8448 nr_irqs:488 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] tsc: Fast TSC calibration failed
> [    0.000000] tsc: Unable to calibrate against PIT
> [    0.000000] tsc: using PMTIMER reference calibration
> [    0.000000] tsc: Detected 2297.102 MHz processor
> [    0.060019] Calibrating delay loop (skipped), value calculated using timer frequency.. 4594.20 BogoMIPS (lpj=22971020)
> [    0.060712] pid_max: default: 32768 minimum: 301
> [    0.061048] ACPI: Core revision 20150410
> [    0.063591] ACPI: All ACPI Tables successfully acquired
> [    0.066330] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
> [    0.097999] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
> [    0.110609] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.130058] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.140947] Initializing cgroup subsys blkio
> [    0.141262] Initializing cgroup subsys memory
> [    0.141575] Initializing cgroup subsys devices
> [    0.141855] Initializing cgroup subsys freezer
> [    0.142136] Initializing cgroup subsys net_cls
> [    0.142434] Initializing cgroup subsys perf_event
> [    0.142727] Initializing cgroup subsys net_prio
> [    0.143007] Initializing cgroup subsys hugetlb
> [    0.144131] mce: CPU supports 10 MCE banks
> [    0.144436] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
> [    0.144752] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> [    0.145340] Freeing SMP alternatives memory: 24K (ffffffffa6ea4000 - ffffffffa6eaa000)
> [    0.145825] ftrace: allocating 24377 entries in 96 pages
> [    0.171174] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.272232] TSC deadline timer enabled
> [    0.272240] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz (fam: 06, model: 3f, stepping: 02)
> [    0.275668] Performance Events: 16-deep LBR, Haswell events, Intel PMU driver.
> [    0.310508] ... version:                2
> [    0.310789] ... bit width:              48
> [    0.311062] ... generic registers:      4
> [    0.311334] ... value mask:             0000ffffffffffff
> [    0.311638] ... max period:             000000007fffffff
> [    0.311930] ... fixed-purpose events:   3
> [    0.312203] ... event mask:             000000070000000f
> [    0.312939] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    0.313572] x86: Booting SMP configuration:
> [    0.313857] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> [    1.530158] x86: Booted up 1 node, 8 CPUs
> [    1.530768] smpboot: Total of 8 processors activated (36791.87 BogoMIPS)
> [    1.532131] devtmpfs: initialized
> [    1.534359] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [    1.534359] NET: Registered protocol family 16
> [    1.560075] cpuidle: using governor ladder
> [    1.590031] cpuidle: using governor menu
> [    1.590464] ACPI: bus type PCI registered
> [    1.590878] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    1.591402] PCI: Using configuration type 1 for base access
> [    1.593581] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
> [    1.594921] perf_event_intel: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
> [    1.620474] ACPI: Added _OSI(Module Device)
> [    1.620995] ACPI: Added _OSI(Processor Device)
> [    1.621971] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    1.622488] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.626193] ACPI: Interpreter enabled
> [    1.626720] ACPI: (supports S0 S5)
> [    1.627200] ACPI: Using IOAPIC for interrupt routing
> [    1.627792] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    1.635465] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    1.636091] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> [    1.636716] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    1.637456] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
> [    1.638691] acpiphp: Slot [3] registered
> [    1.639231] acpiphp: Slot [4] registered
> [    1.639785] acpiphp: Slot [5] registered
> [    1.640041] acpiphp: Slot [6] registered
> [    1.640584] acpiphp: Slot [7] registered
> [    1.641115] acpiphp: Slot [8] registered
> [    1.641668] acpiphp: Slot [9] registered
> [    1.642212] acpiphp: Slot [10] registered
> [    1.643592] acpiphp: Slot [11] registered
> [    1.643899] acpiphp: Slot [12] registered
> [    1.644205] acpiphp: Slot [13] registered
> [    1.644510] acpiphp: Slot [14] registered
> [    1.644812] acpiphp: Slot [15] registered
> [    1.645135] acpiphp: Slot [16] registered
> [    1.645448] acpiphp: Slot [17] registered
> [    1.645758] acpiphp: Slot [18] registered
> [    1.646054] acpiphp: Slot [19] registered
> [    1.646365] acpiphp: Slot [20] registered
> [    1.646663] acpiphp: Slot [21] registered
> [    1.646964] acpiphp: Slot [22] registered
> [    1.647265] acpiphp: Slot [23] registered
> [    1.647573] acpiphp: Slot [24] registered
> [    1.647871] acpiphp: Slot [25] registered
> [    1.650061] acpiphp: Slot [26] registered
> [    1.650585] acpiphp: Slot [27] registered
> [    1.650885] acpiphp: Slot [28] registered
> [    1.651188] acpiphp: Slot [29] registered
> [    1.654491] acpiphp: Slot [30] registered
> [    1.654794] acpiphp: Slot [31] registered
> [    1.655088] PCI host bridge to bus 0000:00
> [    1.655375] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.655681] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    1.656004] pci_bus 0000:00: root bus resource [io  0x0d00-0xadff window]
> [    1.656331] pci_bus 0000:00: root bus resource [io  0xae0f-0xaeff window]
> [    1.656654] pci_bus 0000:00: root bus resource [io  0xaf20-0xafdf window]
> [    1.656976] pci_bus 0000:00: root bus resource [io  0xafe4-0xffff window]
> [    1.657302] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    1.657764] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
> [    1.658260] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> [    1.658612] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
> [    1.659003] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
> [    1.663759] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
> [    1.665700] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    1.666060] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    1.666379] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    1.666709] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    1.667227] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
> [    1.671870] pci 0000:00:01.2: reg 0x20: [io  0xc040-0xc05f]
> [    1.674388] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
> [    1.674684] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
> [    1.675393] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
> [    1.675919] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
> [    1.681068] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
> [    1.683771] pci 0000:00:02.0: reg 0x14: [mem 0xfebd0000-0xfebd0fff]
> [    1.694209] pci 0000:00:02.0: reg 0x30: [mem 0xfebc0000-0xfebcffff pref]
> [    1.694644] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
> [    1.696503] pci 0000:00:03.0: reg 0x10: [io  0xc060-0xc07f]
> [    1.698431] pci 0000:00:03.0: reg 0x14: [mem 0xfebd1000-0xfebd1fff]
> [    1.707348] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
> [    1.707672] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
> [    1.709600] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc03f]
> [    1.710937] pci 0000:00:04.0: reg 0x14: [mem 0xfebd2000-0xfebd2fff]
> [    1.720532] pci 0000:00:05.0: [1af4:1002] type 00 class 0x00ff00
> [    1.721499] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc09f]
> [    1.728430] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> [    1.729565] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> [    1.730332] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> [    1.731157] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> [    1.731921] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> [    1.733477] ACPI: Enabled 16 GPEs in block 00 to 0F
> [    1.734272] SCSI subsystem initialized
> [    1.734701] libata version 3.00 loaded.
> [    1.734701] ACPI: bus type USB registered
> [    1.734701] usbcore: registered new interface driver usbfs
> [    1.734701] usbcore: registered new interface driver hub
> [    1.734701] usbcore: registered new device driver usb
> [    1.734701] PCI: Using ACPI for IRQ routing
> [    1.734701] PCI: pci_cache_line_size set to 64 bytes
> [    1.734701] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    1.734701] e820: reserve RAM buffer [mem 0xbffdf000-0xbfffffff]
> [    1.734701] Switched to clocksource refined-jiffies
> [    1.780170] pnp: PnP ACPI init
> [    1.780817] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    1.780951] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
> [    1.781017] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
> [    1.781091] pnp 00:03: [dma 2]
> [    1.781112] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
> [    1.781248] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
> [    1.781553] pnp: PnP ACPI: found 5 devices
> [    1.787555] clocksource acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    1.790067] Switched to clocksource acpi_pm
> [    1.790589] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    1.790591] pci_bus 0000:00: resource 5 [io  0x0d00-0xadff window]
> [    1.790593] pci_bus 0000:00: resource 6 [io  0xae0f-0xaeff window]
> [    1.790594] pci_bus 0000:00: resource 7 [io  0xaf20-0xafdf window]
> [    1.790596] pci_bus 0000:00: resource 8 [io  0xafe4-0xffff window]
> [    1.790598] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
> [    1.790600] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xfebfffff window]
> [    1.790708] NET: Registered protocol family 2
> [    1.791746] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> [    1.794097] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> [    1.795244] TCP: Hash tables configured (established 262144 bind 65536)
> [    1.795836] UDP hash table entries: 16384 (order: 7, 524288 bytes)
> [    1.796670] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
> [    1.797515] NET: Registered protocol family 1
> [    1.797916] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    1.798317] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    1.798725] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> [    1.832711] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> [    1.866825] pci 0000:00:02.0: Video device with shadowed ROM
> [    1.866862] PCI: CLS 0 bytes, default 64
> [    1.866987] Unpacking initramfs...
> [    2.333153] Freeing initrd memory: 3008K (ffff880037a10000 - ffff880037d00000)
> [    2.333728] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    2.334102] software IO TLB [mem 0xbbfdf000-0xbffdf000] (64MB) mapped at [ffff8800bbfdf000-ffff8800bffdefff]
> [    2.484518] microcode: CPU0 sig=0x306f2, pf=0x1, revision=0x1
> [    2.484952] microcode: CPU1 sig=0x306f2, pf=0x1, revision=0x1
> [    2.485386] microcode: CPU2 sig=0x306f2, pf=0x1, revision=0x1
> [    2.485996] microcode: CPU3 sig=0x306f2, pf=0x1, revision=0x1
> [    2.486562] microcode: CPU4 sig=0x306f2, pf=0x1, revision=0x1
> [    2.487083] microcode: CPU5 sig=0x306f2, pf=0x1, revision=0x1
> [    2.487659] microcode: CPU6 sig=0x306f2, pf=0x1, revision=0x1
> [    2.488220] microcode: CPU7 sig=0x306f2, pf=0x1, revision=0x1
> [    2.488694] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
> [    2.502294] AVX2 version of gcm_enc/dec engaged.
> [    2.502789] AES CTR mode by8 optimization enabled
> [    2.508451] sha1_ssse3: Using AVX2 optimized SHA-1 implementation
> [    2.509347] sha256_ssse3: Using AVX2 optimized SHA-256 implementation
> [    2.510489] sha512_ssse3: Using AVX2 optimized SHA-512 implementation
> [    2.528966] futex hash table entries: 2048 (order: 5, 131072 bytes)
> [    2.530162] Initialise system trusted keyring
> [    2.531219] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    2.534975] zpool: loaded
> [    2.535407] zbud: loaded
> [    2.536346] VFS: Disk quotas dquot_6.6.0
> [    2.536897] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    2.537901] SGI XFS with ACLs, security attributes, no debug enabled
> [    2.552199] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> [    2.553012] io scheduler noop registered
> [    2.553337] io scheduler deadline registered (default)
> [    2.553696] io scheduler cfq registered
> [    2.554114] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    2.554489] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    2.554875] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    2.555304] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    2.730888] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    2.732614] intel_idle: does not run on family 6 model 63
> [    2.732683] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    2.733232] ACPI: Power Button [PWRF]
> [    2.737344] GHES: HEST is not enabled!
> [    2.771139] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
> [    2.771922] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> [    2.808645] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> [    2.857664] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> [    2.858195] virtio-pci 0000:00:05.0: virtio_pci: leaving for legacy driver
> [    2.860777] [drm] Initialized drm 1.1.0 20060810
> [    2.904350]  vda: vda1 vda2
> [    2.905228] ata_piix 0000:00:01.1: version 2.13
> [    2.909583] scsi host0: ata_piix
> [    2.910753] scsi host1: ata_piix
> [    2.911151] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
> [    2.911640] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
> [    2.912127] uhci_hcd: USB Universal Host Controller Interface driver
> [    2.951548] uhci_hcd 0000:00:01.2: UHCI Host Controller
> [    2.952000] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
> [    2.952776] uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c040
> [    2.953361] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> [    2.953817] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.954683] usb usb1: Product: UHCI Host Controller
> [    2.955100] usb usb1: Manufacturer: Linux 4.1.8-gentoo uhci_hcd
> [    2.955544] usb usb1: SerialNumber: 0000:00:01.2
> [    2.956124] hub 1-0:1.0: USB hub found
> [    2.956530] hub 1-0:1.0: 2 ports detected
> [    2.957113] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [    2.959024] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    2.959415] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    2.959991] mousedev: PS/2 mouse device common for all mice
> [    2.960736] rtc_cmos 00:00: RTC can wake from S4
> [    2.961887] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
> [    2.962357] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
> [    2.962989] device-mapper: uevent: version 1.0.3
> [    2.963915] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
> [    2.964689] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.965923] NET: Registered protocol family 10
> [    2.967249] NET: Registered protocol family 17
> [    2.968481] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [    2.970994] Loading compiled-in X.509 certificates
> [    2.971462] registered taskstats version 1
> [    2.972893] rtc_cmos 00:00: setting system clock to 2015-10-01 00:53:23 UTC (1443660803)
> [    3.070910] ata2.01: NODEV after polling detection
> [    3.071169] ata2.00: ATAPI: QEMU DVD-ROM, 2.1.2, max UDMA/100
> [    3.072156] ata2.00: configured for MWDMA2
> [    3.073901] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.1. PQ: 0 ANSI: 5
> [    3.075516] scsi 1:0:0:0: Attached scsi generic sg0 type 5
> [    3.079023] Freeing unused kernel memory: 1500K (ffffffffa6d2d000 - ffffffffa6ea4000)
> [    3.079913] Write protecting the kernel read-only data: 12288k
> [    3.082417] Freeing unused kernel memory: 968K (ffff88002670e000 - ffff880026800000)
> [    3.084810] Freeing unused kernel memory: 1284K (ffff880026abf000 - ffff880026c00000)
> [    3.270109] usb 1-1: new full-speed USB device number 2 using uhci_hcd
> [    3.443465] usb 1-1: New USB device found, idVendor=0627, idProduct=0001
> [    3.443469] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=5
> [    3.443471] usb 1-1: Product: QEMU USB Tablet
> [    3.443473] usb 1-1: Manufacturer: QEMU
> [    3.443474] usb 1-1: SerialNumber: 42
> [    3.480221] tsc: Refined TSC clocksource calibration: 2297.342 MHz
> [    3.480229] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x211d6678e63, max_idle_ns: 440795313325 ns
> [    3.701149] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [    3.701154] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    3.701432] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [    3.914781] usbcore: registered new interface driver usb-storage
> [    3.938615] input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input3
> [    3.938854] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Pointer [QEMU QEMU USB Tablet] on usb-0000:00:01.2-1/input0
> [    3.938898] usbcore: registered new interface driver usbhid
> [    3.938900] usbhid: USB HID core driver
> [    4.093620] FS-Cache: Loaded
> [    4.097657] RPC: Registered named UNIX socket transport module.
> [    4.097660] RPC: Registered udp transport module.
> [    4.097662] RPC: Registered tcp transport module.
> [    4.097663] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    4.102111] FS-Cache: Netfs 'nfs' registered for caching
> [    4.111955] fuse init (API version 7.23)
> [    4.123036] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    4.123039] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    4.237118] device-mapper: dm-log-userspace: version 1.3.0 loaded
> [    4.480564] Switched to clocksource tsc
> [    6.990017] timekeeping watchdog: Marking clocksource 'tsc' as unstable, because the skew is too large:
> [    6.990017] 	'acpi_pm' wd_now: 54f66c wd_last: 3041f5 mask: ffffff
> [    6.990017] 	'tsc' cs_now: 12fee71862 cs_last: 12ba72729d mask: ffffffffffffffff
> [    7.152645] Switched to clocksource acpi_pm
> [    7.307231] random: lvm urandom read with 16 bits of entropy available
> [   17.899633] XFS (dm-7): Mounting V4 Filesystem
> [   18.094485] XFS (dm-7): Starting recovery (logdev: internal)
> [   18.166829] XFS (dm-7): Ending recovery (logdev: internal)
> [   18.587634] random: nonblocking pool is initialized
> [   22.540164] udevd[2534]: starting version 225
> [   23.744732] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [   23.774381] virtio_net virtio0 internet0: renamed from eth0
> [   23.812931] udevd[2604]: Process 'net.sh eth0 start' failed with exit code 1.
> [   23.821106] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input5
> [   25.879944] Adding 4194300k swap on /dev/mapper/vps1storage-volSwap.  Priority:-1 extents:1 across:4194300k FS
> [   25.976101] EXT4-fs (vda1): mounted filesystem with ordered data mode. Opts: (null)
> [   25.991743] XFS (dm-3): Mounting V4 Filesystem
> [   26.674155] XFS (dm-3): Ending clean mount
> [   26.709912] XFS (dm-4): Mounting V4 Filesystem
> [   26.906203] XFS (dm-4): Ending clean mount
> [   26.959643] XFS (dm-2): Mounting V4 Filesystem
> [   27.149336] XFS (dm-2): Starting recovery (logdev: internal)
> [   27.223253] XFS (dm-2): Ending recovery (logdev: internal)
> [   27.262127] XFS (dm-8): Mounting V4 Filesystem
> [   27.350733] XFS (dm-8): Ending clean mount
> [   27.379363] XFS (dm-6): Mounting V4 Filesystem
> [   27.567352] XFS (dm-6): Starting recovery (logdev: internal)
> [   28.010426] XFS (dm-6): Ending recovery (logdev: internal)
> [   28.056060] XFS (dm-5): Mounting V4 Filesystem
> [   28.188959] XFS (dm-5): Starting recovery (logdev: internal)
> [   28.284561] XFS (dm-5): Ending recovery (logdev: internal)
> [   29.940191] Netfilter messages via NETLINK v0.30.
> [   30.003286] ip_set: protocol 6
> [   32.450468] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   32.559733] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
> [   33.093113] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   57.075187] xt_time: kernel timezone is +0200
> [   57.201413] ctnetlink v0.93: registering with nfnetlink.
> [   57.780880] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
> [   60.506072] u32 classifier
> [   60.506077]     Performance counters on
> [   60.506078]     Actions configured
> [  118.338005] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 2.220 msecs
> [  118.338016] perf interrupt took too long (19624 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
> [  180.970220] perf interrupt took too long (19751 > 5000), lowering kernel.perf_event_max_sample_rate to 25000



-Thomas
