From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [locking/paravirt] static_key_disable_cpuslocked(): static key
	'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
Date: Mon, 30 Oct 2017 08:35:09 +0100
Message-ID: <20171030073509.23xtazsqrjuduqq5@wfg-t540p.sh.intel.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
	<20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i5g2a7gt6sl2dzir"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: boris.ostrovsky@oracle.com, jeremy@goop.org, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, rusty@rustcorp.com.au, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org


--i5g2a7gt6sl2dzir
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Oct 29, 2017 at 11:51:55PM +0100, Fengguang Wu wrote:
>Hi Linus,
>
>Up to now we see the below boot error/warnings when testing v4.14-rc6.
>
>They hit the RC release mainly due to various imperfections in 0day's
>auto bisection. So I manually list them here and CC the likely easy to
>debug ones to the corresponding maintainers in the followup emails.
>
>boot_successes: 4700
>boot_failures: 247

[...]

>WARNING:at_kernel/jump_label.c:#static_key_disable_cpuslocked: 7

The call trace is

[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:72 nr_cpu_ids:72 nr_node_ids:2
[    0.000000] percpu: Embedded 39 pages/cpu @ffff88103f400000 s120088 r8192 d31464 u262144
[    0.000000] pcpu-alloc: s120088 r8192 d31464 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] pcpu-alloc: [0] 16 17 36 37 38 39 40 41 [0] 42 43 44 45 46 47 48 49 
[    0.000000] pcpu-alloc: [0] 50 51 52 53 -- -- -- -- [1] 18 19 20 21 22 23 24 25 
[    0.000000] pcpu-alloc: [1] 26 27 28 29 30 31 32 33 [1] 34 35 54 55 56 57 58 59 
[    0.000000] pcpu-alloc: [1] 60 61 62 63 64 65 66 67 [1] 68 69 70 71 -- -- -- -- 
[    0.000000] static_key_disable_cpuslocked(): static key 'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:161 static_key_disable_cpuslocked+0x6c/0x80
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-rc6-00162-g3d6dabc2 #1
[    0.000000] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.0008.021120151325 02/11/2015
[    0.000000] task: ffffffff81e10480 task.stack: ffffffff81e00000
[    0.000000] RIP: 0010:static_key_disable_cpuslocked+0x6c/0x80
[    0.000000] RSP: 0000:ffffffff81e03e98 EFLAGS: 00010092 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 000000000000006f RBX: ffffffff81e36fc0 RCX: ffffffff81e60cf8
[    0.000000] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000047
[    0.000000] RBP: ffffffff81e03ea8 R08: 6b5f636974617473 R09: 000000000000018c
[    0.000000] R10: 0000000000000000 R11: 000000000000006f R12: ffff88207ffcf4c0
[    0.000000] R13: ffffffff82170920 R14: ffffffff8218b780 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffff88103f400000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff88207f4e0000 CR3: 000000207ee09000 CR4: 00000000000606b0
[    0.000000] Call Trace:
[    0.000000]  static_key_disable+0x1a/0x30
[    0.000000]  native_pv_lock_init+0x1b/0x1e
[    0.000000]  native_smp_prepare_boot_cpu+0x32/0x35
[    0.000000]  start_kernel+0x14f/0x421
[    0.000000]  x86_64_start_reservations+0x2a/0x2c
[    0.000000]  x86_64_start_kernel+0x72/0x75
[    0.000000]  secondary_startup_64+0xa5/0xb0
[    0.000000] Code: 85 c0 75 2f 48 c7 c7 20 5e f0 81 e8 df 2a 7b 00 5b 41 5c 5d c3 48 89 fa 48 c7 c6 40 93 a3 81 48 c7 c7 00 8b cb 81 e8 95 b5 f3 ff <0f> ff eb a8 0f ff eb b3 48 89 df e8 14 fc ff ff eb c7 66 90 e8 
[    0.000000] ---[ end trace c12d07f00399ce78 ]---
[    0.000000] Built 2 zonelists, mobility grouping on.  Total pages: 33006159
[    0.000000] Policy zone: Normal

which is bisected to

commit 9043442b43b1fddf202591b84702863286700c1a
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Wed Sep 6 19:36:24 2017 +0200
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Tue Oct 10 11:50:12 2017 +0200

    locking/paravirt: Use new static key for controlling call of virt_spin_lock()

    There are cases where a guest tries to switch spinlocks to bare metal
    behavior (e.g. by setting "xen_nopvspin" boot parameter). Today this
    has the downside of falling back to unfair test and set scheme for
    qspinlocks due to virt_spin_lock() detecting the virtualized
    environment.

    Add a static key controlling whether virt_spin_lock() should be
    called or not. When running on bare metal set the new key to false.

    Signed-off-by: Juergen Gross <jgross@suse.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Acked-by: Waiman Long <longman@redhat.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: akataria@vmware.com
    Cc: boris.ostrovsky@oracle.com
    Cc: chrisw@sous-sol.org
    Cc: hpa@zytor.com
    Cc: jeremy@goop.org
    Cc: rusty@rustcorp.com.au
    Cc: virtualization@lists.linux-foundation.org
    Cc: xen-devel@lists.xenproject.org
    Link: http://lkml.kernel.org/r/20170906173625.18158-2-jgross@suse.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/qspinlock.h | 11 ++++++++++-
 arch/x86/kernel/paravirt.c       | 14 ++++++++++++--
 arch/x86/kernel/smpboot.c        |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

Thanks,
Fengguang

--i5g2a7gt6sl2dzir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-lkp-hsw-ep4:20171029161128:x86_64-rhel-7.2:gcc-6:4.14.0-rc6-00162-g3d6dabc2:1"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Linux version 4.14.0-rc6-00162-g3d6dabc2 (kbuild@lkp-nex05) (gcc version 6.2.0 20160901 (Debian 6.2.0-3)) #1 SMP Sun Oct 29 15:58:26 CST 2017
[    0.000000] Command line: ip=::::lkp-hsw-ep4::dhcp root=/dev/ram0 user=lizhijian job=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml ARCH=x86_64 kconfig=x86_64-rhel-7.2 branch=tip/master commit=3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/vmlinuz-4.14.0-rc6-00162-g3d6dabc2 max_uptime=3600 RESULT_ROOT=/result/perf-sanity-tests/defaults/lkp-hsw-ep4/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/1 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic 
 oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000076230fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076231000-0x00000000762ddfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000762de000-0x000000007a1d2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a1d3000-0x000000007accefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007accf000-0x000000007b6fefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b6ff000-0x000000007b7d6fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007b7d7000-0x000000007b7fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007b800000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff400000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000207fffffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.0008.021120151325 02/11/2015
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x2080000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000080000000 mask 3FFF80000000 uncachable
[    0.000000]   1 base 380000000000 mask 3F8000000000 uncachable
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000000] e820: last_pfn = 0x7b800 max_arch_pfn = 0x400000000
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000fd850-0x000fd85f] mapped at [fffffffffd200850]
[    0.000000]   mpc: fd860-fde3c
[    0.000000] Base memory trampoline at [ffff880000096000] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x207f4e0000, 0x207f4e0fff] PGTABLE
[    0.000000] BRK [0x207f4e1000, 0x207f4e1fff] PGTABLE
[    0.000000] BRK [0x207f4e2000, 0x207f4e2fff] PGTABLE
[    0.000000] BRK [0x207f4e3000, 0x207f4e3fff] PGTABLE
[    0.000000] BRK [0x207f4e4000, 0x207f4e4fff] PGTABLE
[    0.000000] BRK [0x207f4e5000, 0x207f4e5fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x2057f56000-0x207dffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0460 000024 (v02 INTEL )
[    0.000000] ACPI: XSDT 0x000000007B7D50E8 0000BC (v01 INTEL  S2600WT  00000000 INTL 01000013)
[    0.000000] ACPI: FACP 0x000000007B7D4000 0000F4 (v04 INTEL  S2600WT  00000000 INTL 20091013)
[    0.000000] ACPI: DSDT 0x000000007B79A000 0313B2 (v02 INTEL  S2600WT  00000003 INTL 20091013)
[    0.000000] ACPI: FACS 0x000000007B6FB000 000040
[    0.000000] ACPI: HPET 0x000000007B7D3000 000038 (v01 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: APIC 0x000000007B7D2000 00085C (v03 INTEL  S2600WT  00000000 INTL 20091013)
[    0.000000] ACPI: MCFG 0x000000007B7D1000 00003C (v01 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: MSCT 0x000000007B7D0000 000090 (v01 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: SLIT 0x000000007B7CF000 00006C (v01 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: SRAT 0x000000007B7CE000 0009B0 (v03 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: SPMI 0x000000007B7CD000 000041 (v05 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: WDDT 0x000000007B7CC000 000040 (v01 INTEL  S2600WT  00000000 INTL 20091013)
[    0.000000] ACPI: PRAD 0x000000007B795000 000102 (v02 INTEL  SpsPrAgg 00000002 INTL 20130328)
[    0.000000] ACPI: DMAR 0x000000007B78F000 000120 (v01 INTEL  S2600WT  00000001 INTL 20091013)
[    0.000000] ACPI: SSDT 0x0000000076231000 0ACA42 (v02 INTEL  S2600WT  00004000 INTL 20130328)
[    0.000000] ACPI: SSDT 0x000000007B797000 00216B (v02 INTEL  S2600WT  00000002 INTL 20130328)
[    0.000000] ACPI: SSDT 0x000000007B796000 000064 (v02 INTEL  S2600WT  00000002 INTL 20130328)
[    0.000000] ACPI: HEST 0x000000007B794000 0000A8 (v01 INTEL  S2600WT  00000001 INTL 00000001)
[    0.000000] ACPI: BERT 0x000000007B793000 000030 (v01 INTEL  S2600WT  00000001 INTL 00000001)
[    0.000000] ACPI: ERST 0x000000007B792000 000230 (v01 INTEL  S2600WT  00000001 INTL 00000001)
[    0.000000] ACPI: EINJ 0x000000007B791000 000130 (v01 INTEL  S2600WT  00000001 INTL 00000001)
[    0.000000] ACPI: SPCR 0x000000007B790000 000050 (v01        S2600WT  00000000 INTL 00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Setting APIC routing to cluster x2apic.
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x28 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x32 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x34 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x36 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x40 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x42 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x44 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x46 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x48 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x50 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x52 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x54 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x56 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x60 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x62 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x64 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x66 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x68 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x70 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x72 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x74 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x76 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x29 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x33 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x35 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x37 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x41 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x43 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x45 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x47 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x49 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x51 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x53 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x55 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x57 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x61 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x63 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x65 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x67 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x69 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x71 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x73 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x75 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x77 -> Node 1
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x107fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x1080000000-0x207fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x107fffffff] -> [mem 0x00000000-0x107fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x107ffd5000-0x107fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x207ffd3000-0x207fffdfff]
[    0.000000] cma: Reserved 200 MiB at 0x000000204b400000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000207fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000076230fff]
[    0.000000]   node   0: [mem 0x00000000762de000-0x000000007a1d2fff]
[    0.000000]   node   0: [mem 0x000000007b7d7000-0x000000007b7fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000107fffffff]
[    0.000000]   node   1: [mem 0x0000001080000000-0x000000207fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000107fffffff]
[    0.000000] On node 0 totalpages: 16752875
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7750 pages used for memmap
[    0.000000]   DMA32 zone: 495951 pages, LIFO batch:31
[    0.000000]   Normal zone: 253952 pages used for memmap
[    0.000000]   Normal zone: 16252928 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000001080000000-0x000000207fffffff]
[    0.000000] On node 1 totalpages: 16777216
[    0.000000]   Normal zone: 16777216 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x20] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x21] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x22] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x23] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x24] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x25] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x26] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x27] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x28] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x29] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x30] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x31] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x32] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x33] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x34] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x35] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x36] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x37] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x38] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x39] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x40] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x41] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x42] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x43] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x44] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x45] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x46] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x47] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x48] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x49] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x50] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x51] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x52] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x53] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x54] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x55] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x56] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x57] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x58] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x59] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x60] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x61] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x62] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x63] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x64] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x65] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x66] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x67] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x68] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x69] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x70] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x71] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x72] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x73] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x74] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x75] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x76] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x77] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x78] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x79] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x80] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x81] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x82] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x83] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x84] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x85] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x86] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x87] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x88] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x89] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8f] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 8, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 8, APIC INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 8, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 8, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 8, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 8, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 8, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 8, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 8, APIC INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 8, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 8, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 8, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 8, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 8, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 8, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] [Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0x3a (or later)
[    0.000000] smpboot: Allowing 72 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] mapped IOAPIC to ffffffffff5fa000 (fec01000)
[    0.000000] mapped IOAPIC to ffffffffff5f9000 (fec40000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x76231000-0x762ddfff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a1d3000-0x7accefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7accf000-0x7b6fefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b6ff000-0x7b7d6fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b800000-0x8fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x90000000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xff3fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff400000-0xffffffff]
[    0.000000] e820: [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:72 nr_cpu_ids:72 nr_node_ids:2
[    0.000000] percpu: Embedded 39 pages/cpu @ffff88103f400000 s120088 r8192 d31464 u262144
[    0.000000] pcpu-alloc: s120088 r8192 d31464 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.000000] pcpu-alloc: [0] 16 17 36 37 38 39 40 41 [0] 42 43 44 45 46 47 48 49 
[    0.000000] pcpu-alloc: [0] 50 51 52 53 -- -- -- -- [1] 18 19 20 21 22 23 24 25 
[    0.000000] pcpu-alloc: [1] 26 27 28 29 30 31 32 33 [1] 34 35 54 55 56 57 58 59 
[    0.000000] pcpu-alloc: [1] 60 61 62 63 64 65 66 67 [1] 68 69 70 71 -- -- -- -- 
[    0.000000] static_key_disable_cpuslocked(): static key 'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:161 static_key_disable_cpuslocked+0x6c/0x80
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-rc6-00162-g3d6dabc2 #1
[    0.000000] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.0008.021120151325 02/11/2015
[    0.000000] task: ffffffff81e10480 task.stack: ffffffff81e00000
[    0.000000] RIP: 0010:static_key_disable_cpuslocked+0x6c/0x80
[    0.000000] RSP: 0000:ffffffff81e03e98 EFLAGS: 00010092 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 000000000000006f RBX: ffffffff81e36fc0 RCX: ffffffff81e60cf8
[    0.000000] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000047
[    0.000000] RBP: ffffffff81e03ea8 R08: 6b5f636974617473 R09: 000000000000018c
[    0.000000] R10: 0000000000000000 R11: 000000000000006f R12: ffff88207ffcf4c0
[    0.000000] R13: ffffffff82170920 R14: ffffffff8218b780 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffff88103f400000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff88207f4e0000 CR3: 000000207ee09000 CR4: 00000000000606b0
[    0.000000] Call Trace:
[    0.000000]  static_key_disable+0x1a/0x30
[    0.000000]  native_pv_lock_init+0x1b/0x1e
[    0.000000]  native_smp_prepare_boot_cpu+0x32/0x35
[    0.000000]  start_kernel+0x14f/0x421
[    0.000000]  x86_64_start_reservations+0x2a/0x2c
[    0.000000]  x86_64_start_kernel+0x72/0x75
[    0.000000]  secondary_startup_64+0xa5/0xb0
[    0.000000] Code: 85 c0 75 2f 48 c7 c7 20 5e f0 81 e8 df 2a 7b 00 5b 41 5c 5d c3 48 89 fa 48 c7 c6 40 93 a3 81 48 c7 c7 00 8b cb 81 e8 95 b5 f3 ff <0f> ff eb a8 0f ff eb b3 48 89 df e8 14 fc ff ff eb c7 66 90 e8 
[    0.000000] ---[ end trace c12d07f00399ce78 ]---
[    0.000000] Built 2 zonelists, mobility grouping on.  Total pages: 33006159
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ip=::::lkp-hsw-ep4::dhcp root=/dev/ram0 user=lizhijian job=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml ARCH=x86_64 kconfig=x86_64-rhel-7.2 branch=tip/master commit=3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/vmlinuz-4.14.0-rc6-00162-g3d6dabc2 max_uptime=3600 RESULT_ROOT=/result/perf-sanity-tests/defaults/lkp-hsw-ep4/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/1 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog
 =panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 290816 bytes
[    0.000000] log_buf_len min size: 524288 bytes
[    0.000000] log_buf_len: 1048576 bytes
[    0.000000] early log buf free: 493540(94%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 131094968K/134120364K available (9604K kernel code, 2566K rwdata, 3980K rodata, 2320K init, 2020K bss, 2820596K reserved, 204800K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=72, Nodes=2
[    0.000000] ftrace: allocating 38138 entries in 149 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=72.
[    0.000000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=72
[    0.000000] NR_IRQS: 524544, nr_irqs: 1816, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2294.723 MHz processor
[    0.000045] Calibrating delay loop (skipped), value calculated using timer frequency.. 4589.44 BogoMIPS (lpj=2294723)
[    0.001000] pid_max: default: 73728 minimum: 576
[    0.001000] ACPI: Core revision 20170728
[    0.001000] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    0.001000] Security Framework initialized
[    0.001000] SELinux:  Initializing.
[    0.001000] SELinux:  Starting in permissive mode
[    0.001000] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.001000] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.001000] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.001000] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.001000] CPU: Physical Processor ID: 0
[    0.001000] CPU: Processor Core ID: 0
[    0.001000] mce: CPU supports 22 MCE banks
[    0.001000] CPU0: Thermal monitoring enabled (TM1)
[    0.001000] process: using mwait in idle threads
[    0.001000] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.001000] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.001000] Freeing SMP alternatives memory: 40K
[    0.001000] smpboot: Max logical packages: 4
[    0.001000] DMAR: Host address width 46
[    0.001000] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.001000] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0466 ecap f020df
[    0.001000] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    0.001000] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap d2078c106f0466 ecap f020df
[    0.001000] DMAR: RMRR base: 0x0000007a5a1000 end: 0x0000007a5a3fff
[    0.001000] DMAR: ATSR flags: 0x0
[    0.001000] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    0.001000] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    0.001000] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    0.001000] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.001000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.001000] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
[    0.001000] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
[    0.001000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.001000] masked ExtINT on CPU#0
[    0.001000] ENABLING IO-APIC IRQs
[    0.001000] init IO_APIC IRQs
[    0.001000]  apic 8 pin 0 not connected
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:31 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-1 -> 0x31 -> IRQ 1 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:30 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:33 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-3 -> 0x33 -> IRQ 3 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:34 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-4 -> 0x34 -> IRQ 4 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:35 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-5 -> 0x35 -> IRQ 5 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:36 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-6 -> 0x36 -> IRQ 6 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:37 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-7 -> 0x37 -> IRQ 7 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:38 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-8 -> 0x38 -> IRQ 8 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:39 Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-9 -> 0x39 -> IRQ 9 Mode:1 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3A Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-10 -> 0x3a -> IRQ 10 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3B Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-11 -> 0x3b -> IRQ 11 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3C Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-12 -> 0x3c -> IRQ 12 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3D Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-13 -> 0x3d -> IRQ 13 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3E Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-14 -> 0x3e -> IRQ 14 Mode:0 Active:0 Dest:1)
[    0.001000] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:3F Dest:00000001 SID:F0FF SQ:0 SVT:1)
[    0.001000] IOAPIC[0]: Set routing entry (8-15 -> 0x3f -> IRQ 15 Mode:0 Active:0 Dest:1)
[    0.001000]  apic 8 pin 16 not connected
[    0.001000]  apic 8 pin 17 not connected
[    0.001000]  apic 8 pin 18 not connected
[    0.001000]  apic 8 pin 19 not connected
[    0.001000]  apic 8 pin 20 not connected
[    0.001000]  apic 8 pin 21 not connected
[    0.001000]  apic 8 pin 22 not connected
[    0.001000]  apic 8 pin 23 not connected
[    0.001000]  apic 9 pin 0 not connected
[    0.001000]  apic 9 pin 1 not connected
[    0.001000]  apic 9 pin 2 not connected
[    0.001000]  apic 9 pin 3 not connected
[    0.001000]  apic 9 pin 4 not connected
[    0.001000]  apic 9 pin 5 not connected
[    0.001000]  apic 9 pin 6 not connected
[    0.001000]  apic 9 pin 7 not connected
[    0.001000]  apic 9 pin 8 not connected
[    0.001000]  apic 9 pin 9 not connected
[    0.001000]  apic 9 pin 10 not connected
[    0.001000]  apic 9 pin 11 not connected
[    0.001000]  apic 9 pin 12 not connected
[    0.001000]  apic 9 pin 13 not connected
[    0.001000]  apic 9 pin 14 not connected
[    0.001000]  apic 9 pin 15 not connected
[    0.001000]  apic 9 pin 16 not connected
[    0.001000]  apic 9 pin 17 not connected
[    0.001000]  apic 9 pin 18 not connected
[    0.001000]  apic 9 pin 19 not connected
[    0.001000]  apic 9 pin 20 not connected
[    0.001000]  apic 9 pin 21 not connected
[    0.001000]  apic 9 pin 22 not connected
[    0.001000]  apic 9 pin 23 not connected
[    0.001000]  apic 10 pin 0 not connected
[    0.001000]  apic 10 pin 1 not connected
[    0.001000]  apic 10 pin 2 not connected
[    0.001000]  apic 10 pin 3 not connected
[    0.001000]  apic 10 pin 4 not connected
[    0.001000]  apic 10 pin 5 not connected
[    0.001000]  apic 10 pin 6 not connected
[    0.001000]  apic 10 pin 7 not connected
[    0.001000]  apic 10 pin 8 not connected
[    0.001000]  apic 10 pin 9 not connected
[    0.001000]  apic 10 pin 10 not connected
[    0.001000]  apic 10 pin 11 not connected
[    0.001000]  apic 10 pin 12 not connected
[    0.001000]  apic 10 pin 13 not connected
[    0.001000]  apic 10 pin 14 not connected
[    0.001000]  apic 10 pin 15 not connected
[    0.001000]  apic 10 pin 16 not connected
[    0.001000]  apic 10 pin 17 not connected
[    0.001000]  apic 10 pin 18 not connected
[    0.001000]  apic 10 pin 19 not connected
[    0.001000]  apic 10 pin 20 not connected
[    0.001000]  apic 10 pin 21 not connected
[    0.001000]  apic 10 pin 22 not connected
[    0.001000]  apic 10 pin 23 not connected
[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.010842] Using local APIC timer interrupts.
[    0.010842] calibrating APIC timer ...
[    0.012000] ... lapic delta = 623546
[    0.012000] ... PM-Timer delta = 357949
[    0.012000] ... PM-Timer result ok
[    0.012000] ..... delta 623546
[    0.012000] ..... mult: 26781096
[    0.012000] ..... calibration result: 99767
[    0.012000] ..... CPU clock speed is 2294.0650 MHz.
[    0.012000] ..... host bus clock speed is 99.0767 MHz.
[    0.012035] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz (family: 0x6, model: 0x3f, stepping: 0x2)
[    0.013302] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.014006] ... version:                3
[    0.015002] ... bit width:              48
[    0.016002] ... generic registers:      4
[    0.017006] ... value mask:             0000ffffffffffff
[    0.018003] ... max period:             00007fffffffffff
[    0.019002] ... fixed-purpose events:   3
[    0.020001] ... event mask:             000000070000000f
[    0.021169] Hierarchical SRCU implementation.
[    0.030888] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.031018] smp: Bringing up secondary CPUs ...
[    0.032180] x86: Booting SMP configuration:
[    0.033005] .... node  #0, CPUs:        #1
[    0.001000] masked ExtINT on CPU#1
[    0.106226]   #2
[    0.001000] masked ExtINT on CPU#2
[    0.176217]   #3
[    0.001000] masked ExtINT on CPU#3
[    0.246215]   #4
[    0.001000] masked ExtINT on CPU#4
[    0.315212]   #5
[    0.001000] masked ExtINT on CPU#5
[    0.385218]   #6
[    0.001000] masked ExtINT on CPU#6
[    0.454207]   #7
[    0.001000] masked ExtINT on CPU#7
[    0.523215]   #8
[    0.001000] masked ExtINT on CPU#8
[    0.592220]   #9
[    0.001000] masked ExtINT on CPU#9
[    0.661212]  #10
[    0.001000] masked ExtINT on CPU#10
[    0.731218]  #11
[    0.001000] masked ExtINT on CPU#11
[    0.801224]  #12
[    0.001000] masked ExtINT on CPU#12
[    0.871216]  #13
[    0.001000] masked ExtINT on CPU#13
[    0.941224]  #14
[    0.001000] masked ExtINT on CPU#14
[    1.011221]  #15
[    0.001000] masked ExtINT on CPU#15
[    1.081220]  #16
[    0.001000] masked ExtINT on CPU#16
[    1.151230]  #17
[    0.001000] masked ExtINT on CPU#17
[    1.221257] .... node  #1, CPUs:   #18
[    0.001000] masked ExtINT on CPU#18
[    1.294236]  #19
[    0.001000] masked ExtINT on CPU#19
[    1.364179]  #20
[    0.001000] masked ExtINT on CPU#20
[    1.434191]  #21
[    0.001000] masked ExtINT on CPU#21
[    1.504177]  #22
[    0.001000] masked ExtINT on CPU#22
[    1.574181]  #23
[    0.001000] masked ExtINT on CPU#23
[    1.644170]  #24
[    0.001000] masked ExtINT on CPU#24
[    1.714186]  #25
[    0.001000] masked ExtINT on CPU#25
[    1.785137]  #26
[    0.001000] masked ExtINT on CPU#26
[    1.854192]  #27
[    0.001000] masked ExtINT on CPU#27
[    1.924172]  #28
[    0.001000] masked ExtINT on CPU#28
[    1.994187]  #29
[    0.001000] masked ExtINT on CPU#29
[    2.064175]  #30
[    0.001000] masked ExtINT on CPU#30
[    2.134190]  #31
[    0.001000] masked ExtINT on CPU#31
[    2.204171]  #32
[    0.001000] masked ExtINT on CPU#32
[    2.274177]  #33
[    0.001000] masked ExtINT on CPU#33
[    2.344171]  #34
[    0.001000] masked ExtINT on CPU#34
[    2.414182]  #35
[    0.001000] masked ExtINT on CPU#35
[    2.484182] .... node  #0, CPUs:   #36
[    0.001000] masked ExtINT on CPU#36
[    2.554264]  #37
[    0.001000] masked ExtINT on CPU#37
[    2.624227]  #38
[    0.001000] masked ExtINT on CPU#38
[    2.694232]  #39
[    0.001000] masked ExtINT on CPU#39
[    2.764717]  #40
[    0.001000] masked ExtINT on CPU#40
[    2.834229]  #41
[    0.001000] masked ExtINT on CPU#41
[    2.904231]  #42
[    0.001000] masked ExtINT on CPU#42
[    2.973216]  #43
[    0.001000] masked ExtINT on CPU#43
[    3.042236]  #44
[    0.001000] masked ExtINT on CPU#44
[    3.112235]  #45
[    0.001000] masked ExtINT on CPU#45
[    3.182226]  #46
[    0.001000] masked ExtINT on CPU#46
[    3.252229]  #47
[    0.001000] masked ExtINT on CPU#47
[    3.322233]  #48
[    0.001000] masked ExtINT on CPU#48
[    3.392228]  #49
[    0.001000] masked ExtINT on CPU#49
[    3.462235]  #50
[    0.001000] masked ExtINT on CPU#50
[    3.532227]  #51
[    0.001000] masked ExtINT on CPU#51
[    3.602233]  #52
[    0.001000] masked ExtINT on CPU#52
[    3.672237]  #53
[    0.001000] masked ExtINT on CPU#53
[    3.742266] .... node  #1, CPUs:   #54
[    0.001000] masked ExtINT on CPU#54
[    3.814619]  #55
[    0.001000] masked ExtINT on CPU#55
[    3.884183]  #56
[    0.001000] masked ExtINT on CPU#56
[    3.954196]  #57
[    0.001000] masked ExtINT on CPU#57
[    4.024178]  #58
[    0.001000] masked ExtINT on CPU#58
[    4.094190]  #59
[    0.001000] masked ExtINT on CPU#59
[    4.164179]  #60
[    0.001000] masked ExtINT on CPU#60
[    4.234189]  #61
[    0.001000] masked ExtINT on CPU#61
[    4.304184]  #62
[    0.001000] masked ExtINT on CPU#62
[    4.374189]  #63
[    0.001000] masked ExtINT on CPU#63
[    4.444182]  #64
[    0.001000] masked ExtINT on CPU#64
[    4.514194]  #65
[    0.001000] masked ExtINT on CPU#65
[    4.584186]  #66
[    0.001000] masked ExtINT on CPU#66
[    4.654196]  #67
[    0.001000] masked ExtINT on CPU#67
[    4.724178]  #68
[    0.001000] masked ExtINT on CPU#68
[    4.794607]  #69
[    0.001000] masked ExtINT on CPU#69
[    4.864186]  #70
[    0.001000] masked ExtINT on CPU#70
[    4.934190]  #71
[    0.001000] masked ExtINT on CPU#71
[    5.004173] smp: Brought up 2 nodes, 72 CPUs
[    5.005013] smpboot: Total of 72 processors activated (330417.15 BogoMIPS)
[    5.016003] devtmpfs: initialized
[    5.017108] x86/mm: Memory block size: 2048MB
[    5.020282] evm: security.selinux
[    5.021002] evm: security.ima
[    5.022001] evm: security.capability
[    5.023345] PM: Registering ACPI NVS region [mem 0x7accf000-0x7b6fefff] (10682368 bytes)
[    5.025495] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    5.026202] futex hash table entries: 32768 (order: 9, 2097152 bytes)
[    5.030208] pinctrl core: initialized pinctrl subsystem
[    5.033030] NET: Registered protocol family 16
[    5.034638] cpuidle: using governor menu
[    5.035383] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    5.037004] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    5.038208] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    5.039043] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    5.040039] PCI: Using configuration type 1 for base access
[    5.042007] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    5.049338] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    5.050011] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    5.053346] ACPI: Added _OSI(Module Device)
[    5.054006] ACPI: Added _OSI(Processor Device)
[    5.056005] ACPI: Added _OSI(3.0 _SCP Extensions)
[    5.057003] ACPI: Added _OSI(Processor Aggregator Device)
[    5.058342] ACPI: Executed 1 blocks of module-level executable AML code
[    5.426809] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    5.452490] ACPI: Dynamic OEM Table Load:
[    5.533614] ACPI: Interpreter enabled
[    5.534030] ACPI: (supports S0 S5)
[    5.535002] ACPI: Using IOAPIC for interrupt routing
[    5.536091] HEST: Table parsing has been initialized.
[    5.537007] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    5.539409] ACPI: GPE 0x24 active on init
[    5.540000] ACPI: Enabled 6 GPEs in block 00 to 3F
[    5.630599] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    5.637013] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    5.646011] acpi PNP0A03:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    5.653090] PCI host bridge to bus 0000:ff
[    5.658007] pci_bus 0000:ff: root bus resource [bus ff]
[    5.664021] pci 0000:ff:08.0: [8086:2f80] type 00 class 0x088000
[    5.671106] pci 0000:ff:08.2: [8086:2f32] type 00 class 0x110100
[    5.677090] pci 0000:ff:08.3: [8086:2f83] type 00 class 0x088000
[    5.684090] pci 0000:ff:09.0: [8086:2f90] type 00 class 0x088000
[    5.691082] pci 0000:ff:09.2: [8086:2f33] type 00 class 0x110100
[    5.698081] pci 0000:ff:09.3: [8086:2f93] type 00 class 0x088000
[    5.705089] pci 0000:ff:0b.0: [8086:2f81] type 00 class 0x088000
[    5.711082] pci 0000:ff:0b.1: [8086:2f36] type 00 class 0x110100
[    5.718080] pci 0000:ff:0b.2: [8086:2f37] type 00 class 0x110100
[    5.725086] pci 0000:ff:0c.0: [8086:2fe0] type 00 class 0x088000
[    5.732094] pci 0000:ff:0c.1: [8086:2fe1] type 00 class 0x088000
[    5.739081] pci 0000:ff:0c.2: [8086:2fe2] type 00 class 0x088000
[    5.745082] pci 0000:ff:0c.3: [8086:2fe3] type 00 class 0x088000
[    5.752078] pci 0000:ff:0c.4: [8086:2fe4] type 00 class 0x088000
[    5.759080] pci 0000:ff:0c.5: [8086:2fe5] type 00 class 0x088000
[    5.766078] pci 0000:ff:0c.6: [8086:2fe6] type 00 class 0x088000
[    5.773079] pci 0000:ff:0c.7: [8086:2fe7] type 00 class 0x088000
[    5.779079] pci 0000:ff:0d.0: [8086:2fe8] type 00 class 0x088000
[    5.786079] pci 0000:ff:0d.1: [8086:2fe9] type 00 class 0x088000
[    5.793082] pci 0000:ff:0d.2: [8086:2fea] type 00 class 0x088000
[    5.800076] pci 0000:ff:0d.3: [8086:2feb] type 00 class 0x088000
[    5.807065] pci 0000:ff:0d.4: [8086:2fec] type 00 class 0x088000
[    5.813079] pci 0000:ff:0d.5: [8086:2fed] type 00 class 0x088000
[    5.820082] pci 0000:ff:0d.6: [8086:2fee] type 00 class 0x088000
[    5.827085] pci 0000:ff:0d.7: [8086:2fef] type 00 class 0x088000
[    5.834079] pci 0000:ff:0e.0: [8086:2ff0] type 00 class 0x088000
[    5.841050] pci 0000:ff:0e.1: [8086:2ff1] type 00 class 0x088000
[    5.847085] pci 0000:ff:0f.0: [8086:2ff8] type 00 class 0x088000
[    5.854078] pci 0000:ff:0f.1: [8086:2ff9] type 00 class 0x088000
[    5.861078] pci 0000:ff:0f.2: [8086:2ffa] type 00 class 0x088000
[    5.868081] pci 0000:ff:0f.3: [8086:2ffb] type 00 class 0x088000
[    5.875028] pci 0000:ff:0f.4: [8086:2ffc] type 00 class 0x088000
[    5.881084] pci 0000:ff:0f.5: [8086:2ffd] type 00 class 0x088000
[    5.888083] pci 0000:ff:0f.6: [8086:2ffe] type 00 class 0x088000
[    5.895083] pci 0000:ff:10.0: [8086:2f1d] type 00 class 0x088000
[    5.902080] pci 0000:ff:10.1: [8086:2f34] type 00 class 0x110100
[    5.909011] pci 0000:ff:10.5: [8086:2f1e] type 00 class 0x088000
[    5.915078] pci 0000:ff:10.6: [8086:2f7d] type 00 class 0x110100
[    5.922080] pci 0000:ff:10.7: [8086:2f1f] type 00 class 0x088000
[    5.929079] pci 0000:ff:12.0: [8086:2fa0] type 00 class 0x088000
[    5.936090] pci 0000:ff:12.1: [8086:2f30] type 00 class 0x110100
[    5.942086] pci 0000:ff:12.4: [8086:2f60] type 00 class 0x088000
[    5.949086] pci 0000:ff:12.5: [8086:2f38] type 00 class 0x110100
[    5.956092] pci 0000:ff:13.0: [8086:2fa8] type 00 class 0x088000
[    5.963087] pci 0000:ff:13.1: [8086:2f71] type 00 class 0x088000
[    5.970088] pci 0000:ff:13.2: [8086:2faa] type 00 class 0x088000
[    5.977004] pci 0000:ff:13.3: [8086:2fab] type 00 class 0x088000
[    5.983092] pci 0000:ff:13.6: [8086:2fae] type 00 class 0x088000
[    5.990086] pci 0000:ff:13.7: [8086:2faf] type 00 class 0x088000
[    5.997083] pci 0000:ff:14.0: [8086:2fb0] type 00 class 0x088000
[    6.004090] pci 0000:ff:14.1: [8086:2fb1] type 00 class 0x088000
[    6.011015] pci 0000:ff:14.2: [8086:2fb2] type 00 class 0x088000
[    6.017088] pci 0000:ff:14.3: [8086:2fb3] type 00 class 0x088000
[    6.024105] pci 0000:ff:14.4: [8086:2fbc] type 00 class 0x088000
[    6.031087] pci 0000:ff:14.5: [8086:2fbd] type 00 class 0x088000
[    6.038084] pci 0000:ff:14.6: [8086:2fbe] type 00 class 0x088000
[    6.045034] pci 0000:ff:14.7: [8086:2fbf] type 00 class 0x088000
[    6.051088] pci 0000:ff:16.0: [8086:2f68] type 00 class 0x088000
[    6.058089] pci 0000:ff:16.1: [8086:2f79] type 00 class 0x088000
[    6.065095] pci 0000:ff:16.2: [8086:2f6a] type 00 class 0x088000
[    6.072092] pci 0000:ff:16.3: [8086:2f6b] type 00 class 0x088000
[    6.079056] pci 0000:ff:16.6: [8086:2f6e] type 00 class 0x088000
[    6.085086] pci 0000:ff:16.7: [8086:2f6f] type 00 class 0x088000
[    6.092083] pci 0000:ff:17.0: [8086:2fd0] type 00 class 0x088000
[    6.099094] pci 0000:ff:17.1: [8086:2fd1] type 00 class 0x088000
[    6.106087] pci 0000:ff:17.2: [8086:2fd2] type 00 class 0x088000
[    6.113057] pci 0000:ff:17.3: [8086:2fd3] type 00 class 0x088000
[    6.119090] pci 0000:ff:17.4: [8086:2fb8] type 00 class 0x088000
[    6.126082] pci 0000:ff:17.5: [8086:2fb9] type 00 class 0x088000
[    6.133085] pci 0000:ff:17.6: [8086:2fba] type 00 class 0x088000
[    6.140082] pci 0000:ff:17.7: [8086:2fbb] type 00 class 0x088000
[    6.147081] pci 0000:ff:1e.0: [8086:2f98] type 00 class 0x088000
[    6.153085] pci 0000:ff:1e.1: [8086:2f99] type 00 class 0x088000
[    6.160082] pci 0000:ff:1e.2: [8086:2f9a] type 00 class 0x088000
[    6.167088] pci 0000:ff:1e.3: [8086:2fc0] type 00 class 0x088000
[    6.174060] pci 0000:ff:1e.4: [8086:2f9c] type 00 class 0x088000
[    6.181062] pci 0000:ff:1f.0: [8086:2f88] type 00 class 0x088000
[    6.187086] pci 0000:ff:1f.2: [8086:2f8a] type 00 class 0x088000
[    6.194276] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    6.201010] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.210009] acpi PNP0A03:03: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    6.218080] PCI host bridge to bus 0000:7f
[    6.222005] pci_bus 0000:7f: root bus resource [bus 7f]
[    6.228015] pci 0000:7f:08.0: [8086:2f80] type 00 class 0x088000
[    6.235087] pci 0000:7f:08.2: [8086:2f32] type 00 class 0x110100
[    6.242081] pci 0000:7f:08.3: [8086:2f83] type 00 class 0x088000
[    6.248086] pci 0000:7f:09.0: [8086:2f90] type 00 class 0x088000
[    6.255078] pci 0000:7f:09.2: [8086:2f33] type 00 class 0x110100
[    6.262078] pci 0000:7f:09.3: [8086:2f93] type 00 class 0x088000
[    6.269086] pci 0000:7f:0b.0: [8086:2f81] type 00 class 0x088000
[    6.276077] pci 0000:7f:0b.1: [8086:2f36] type 00 class 0x110100
[    6.282072] pci 0000:7f:0b.2: [8086:2f37] type 00 class 0x110100
[    6.289081] pci 0000:7f:0c.0: [8086:2fe0] type 00 class 0x088000
[    6.296076] pci 0000:7f:0c.1: [8086:2fe1] type 00 class 0x088000
[    6.303077] pci 0000:7f:0c.2: [8086:2fe2] type 00 class 0x088000
[    6.310051] pci 0000:7f:0c.3: [8086:2fe3] type 00 class 0x088000
[    6.316076] pci 0000:7f:0c.4: [8086:2fe4] type 00 class 0x088000
[    6.323083] pci 0000:7f:0c.5: [8086:2fe5] type 00 class 0x088000
[    6.330076] pci 0000:7f:0c.6: [8086:2fe6] type 00 class 0x088000
[    6.337076] pci 0000:7f:0c.7: [8086:2fe7] type 00 class 0x088000
[    6.344005] pci 0000:7f:0d.0: [8086:2fe8] type 00 class 0x088000
[    6.350078] pci 0000:7f:0d.1: [8086:2fe9] type 00 class 0x088000
[    6.357078] pci 0000:7f:0d.2: [8086:2fea] type 00 class 0x088000
[    6.364076] pci 0000:7f:0d.3: [8086:2feb] type 00 class 0x088000
[    6.371078] pci 0000:7f:0d.4: [8086:2fec] type 00 class 0x088000
[    6.377075] pci 0000:7f:0d.5: [8086:2fed] type 00 class 0x088000
[    6.384082] pci 0000:7f:0d.6: [8086:2fee] type 00 class 0x088000

[    6.391080] 0000:7f:0d.7: [8086:2fef] type 00 class 0x088000
[    6.398077] pci 0000:7f:0e.0: [8086:2ff0] type 00 class 0x088000
[    6.405079] pci 0000:7f:0e.1: [8086:2ff1] type 00 class 0x088000
[    6.411083] pci 0000:7f:0f.0: [8086:2ff8] type 00 class 0x088000
[    6.418078] pci 0000:7f:0f.1: [8086:2ff9] type 00 class 0x088000
[    6.425075] pci 0000:7f:0f.2: [8086:2ffa] type 00 class 0x088000
[    6.432077] pci 0000:7f:0f.3: [8086:2ffb] type 00 class 0x088000
[    6.439078] pci 0000:7f:0f.4: [8086:2ffc] type 00 class 0x088000
[    6.445076] pci 0000:7f:0f.5: [8086:2ffd] type 00 class 0x088000
[    6.452080] pci 0000:7f:0f.6: [8086:2ffe] type 00 class 0x088000
[    6.459081] pci 0000:7f:10.0: [8086:2f1d] type 00 class 0x088000
[    6.466080] pci 0000:7f:10.1: [8086:2f34] type 00 class 0x110100
[    6.473066] pci 0000:7f:10.5: [8086:2f1e] type 00 class 0x088000
[    6.479074] pci 0000:7f:10.6: [8086:2f7d] type 00 class 0x110100
[    6.486077] pci 0000:7f:10.7: [8086:2f1f] type 00 class 0x088000
[    6.493076] pci 0000:7f:12.0: [8086:2fa0] type 00 class 0x088000
[    6.500081] pci 0000:7f:12.1: [8086:2f30] type 00 class 0x110100
[    6.507031] pci 0000:7f:12.4: [8086:2f60] type 00 class 0x088000
[    6.513088] pci 0000:7f:12.5: [8086:2f38] type 00 class 0x110100
[    6.520089] pci 0000:7f:13.0: [8086:2fa8] type 00 class 0x088000
[    6.527087] pci 0000:7f:13.1: [8086:2f71] type 00 class 0x088000
[    6.534084] pci 0000:7f:13.2: [8086:2faa] type 00 class 0x088000
[    6.541036] pci 0000:7f:13.3: [8086:2fab] type 00 class 0x088000
[    6.547089] pci 0000:7f:13.6: [8086:2fae] type 00 class 0x088000
[    6.554082] pci 0000:7f:13.7: [8086:2faf] type 00 class 0x088000
[    6.561081] pci 0000:7f:14.0: [8086:2fb0] type 00 class 0x088000
[    6.568086] pci 0000:7f:14.1: [8086:2fb1] type 00 class 0x088000
[    6.575024] pci 0000:7f:14.2: [8086:2fb2] type 00 class 0x088000
[    6.581088] pci 0000:7f:14.3: [8086:2fb3] type 00 class 0x088000
[    6.588083] pci 0000:7f:14.4: [8086:2fbc] type 00 class 0x088000
[    6.595080] pci 0000:7f:14.5: [8086:2fbd] type 00 class 0x088000
[    6.602080] pci 0000:7f:14.6: [8086:2fbe] type 00 class 0x088000
[    6.609010] pci 0000:7f:14.7: [8086:2fbf] type 00 class 0x088000
[    6.615086] pci 0000:7f:16.0: [8086:2f68] type 00 class 0x088000
[    6.622088] pci 0000:7f:16.1: [8086:2f79] type 00 class 0x088000
[    6.629091] pci 0000:7f:16.2: [8086:2f6a] type 00 class 0x088000
[    6.636089] pci 0000:7f:16.3: [8086:2f6b] type 00 class 0x088000
[    6.643028] pci 0000:7f:16.6: [8086:2f6e] type 00 class 0x088000
[    6.649083] pci 0000:7f:16.7: [8086:2f6f] type 00 class 0x088000
[    6.656081] pci 0000:7f:17.0: [8086:2fd0] type 00 class 0x088000
[    6.663089] pci 0000:7f:17.1: [8086:2fd1] type 00 class 0x088000
[    6.670085] pci 0000:7f:17.2: [8086:2fd2] type 00 class 0x088000
[    6.677020] pci 0000:7f:17.3: [8086:2fd3] type 00 class 0x088000
[    6.683089] pci 0000:7f:17.4: [8086:2fb8] type 00 class 0x088000
[    6.690078] pci 0000:7f:17.5: [8086:2fb9] type 00 class 0x088000
[    6.697082] pci 0000:7f:17.6: [8086:2fba] type 00 class 0x088000
[    6.704079] pci 0000:7f:17.7: [8086:2fbb] type 00 class 0x088000
[    6.711031] pci 0000:7f:1e.0: [8086:2f98] type 00 class 0x088000
[    6.717082] pci 0000:7f:1e.1: [8086:2f99] type 00 class 0x088000
[    6.724079] pci 0000:7f:1e.2: [8086:2f9a] type 00 class 0x088000
[    6.731080] pci 0000:7f:1e.3: [8086:2fc0] type 00 class 0x088000
[    6.738076] pci 0000:7f:1e.4: [8086:2f9c] type 00 class 0x088000
[    6.745012] pci 0000:7f:1f.0: [8086:2f88] type 00 class 0x088000
[    6.751085] pci 0000:7f:1f.2: [8086:2f8a] type 00 class 0x088000
[    6.803864] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    6.810013] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    6.824939] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    6.834239] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    6.842007] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    6.852481] acpi PNP0A08:00: ignoring host bridge window [mem 0x000c4000-0x000cbfff window] (conflicts with Video ROM [mem 0x000c0000-0x000c7fff])
[    6.868023] PCI host bridge to bus 0000:00
[    6.872006] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    6.880003] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    6.887003] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    6.896003] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
[    6.904003] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x383fffffffff window]
[    6.913003] pci_bus 0000:00: root bus resource [bus 00-7e]
[    6.919014] pci 0000:00:00.0: [8086:2f00] type 00 class 0x060000
[    6.926293] pci 0000:00:01.0: [8086:2f02] type 01 class 0x060400
[    6.933080] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    6.940224] pci 0000:00:02.0: [8086:2f04] type 01 class 0x060400
[    6.947077] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    6.954221] pci 0000:00:02.2: [8086:2f06] type 01 class 0x060400
[    6.961077] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    6.968221] pci 0000:00:03.0: [8086:2f08] type 01 class 0x060400
[    6.975080] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    6.982116] pci 0000:00:03.2: [8086:2f0a] type 01 class 0x060400
[    6.988076] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
[    6.995222] pci 0000:00:04.0: [8086:2f20] type 00 class 0x088000
[    7.002020] pci 0000:00:04.0: reg 0x10: [mem 0x383ffff2c000-0x383ffff2ffff 64bit]
[    7.011260] pci 0000:00:04.1: [8086:2f21] type 00 class 0x088000
[    7.018020] pci 0000:00:04.1: reg 0x10: [mem 0x383ffff28000-0x383ffff2bfff 64bit]
[    7.026259] pci 0000:00:04.2: [8086:2f22] type 00 class 0x088000
[    7.033019] pci 0000:00:04.2: reg 0x10: [mem 0x383ffff24000-0x383ffff27fff 64bit]
[    7.041254] pci 0000:00:04.3: [8086:2f23] type 00 class 0x088000
[    7.048018] pci 0000:00:04.3: reg 0x10: [mem 0x383ffff20000-0x383ffff23fff 64bit]
[    7.057256] pci 0000:00:04.4: [8086:2f24] type 00 class 0x088000
[    7.064019] pci 0000:00:04.4: reg 0x10: [mem 0x383ffff1c000-0x383ffff1ffff 64bit]
[    7.072262] pci 0000:00:04.5: [8086:2f25] type 00 class 0x088000
[    7.079019] pci 0000:00:04.5: reg 0x10: [mem 0x383ffff18000-0x383ffff1bfff 64bit]
[    7.088057] pci 0000:00:04.6: [8086:2f26] type 00 class 0x088000
[    7.094018] pci 0000:00:04.6: reg 0x10: [mem 0x383ffff14000-0x383ffff17fff 64bit]
[    7.103258] pci 0000:00:04.7: [8086:2f27] type 00 class 0x088000
[    7.110019] pci 0000:00:04.7: reg 0x10: [mem 0x383ffff10000-0x383ffff13fff 64bit]
[    7.118255] pci 0000:00:05.0: [8086:2f28] type 00 class 0x088000
[    7.125247] pci 0000:00:05.1: [8086:2f29] type 00 class 0x088000
[    7.132270] pci 0000:00:05.2: [8086:2f2a] type 00 class 0x088000
[    7.139249] pci 0000:00:05.4: [8086:2f2c] type 00 class 0x080020
[    7.146015] pci 0000:00:05.4: reg 0x10: [mem 0x91d06000-0x91d06fff]
[    7.153275] pci 0000:00:11.0: [8086:8d7c] type 00 class 0xff0000
[    7.160346] pci 0000:00:11.1: [8086:8d7d] type 00 class 0x0c0500
[    7.167033] pci 0000:00:11.1: reg 0x10: [mem 0x91d05000-0x91d05fff]
[    7.174040] pci 0000:00:11.1: reg 0x20: [io  0x3060-0x307f]
[    7.181053] pci 0000:00:11.4: [8086:8d62] type 00 class 0x010601
[    7.187034] pci 0000:00:11.4: reg 0x10: [io  0x3098-0x309f]
[    7.194018] pci 0000:00:11.4: reg 0x14: [io  0x30cc-0x30cf]
[    7.200018] pci 0000:00:11.4: reg 0x18: [io  0x3090-0x3097]
[    7.206020] pci 0000:00:11.4: reg 0x1c: [io  0x30c8-0x30cb]
[    7.212019] pci 0000:00:11.4: reg 0x20: [io  0x3020-0x303f]
[    7.219006] pci 0000:00:11.4: reg 0x24: [mem 0x91d00000-0x91d007ff]
[    7.226066] pci 0000:00:11.4: PME# supported from D3hot
[    7.232144] pci 0000:00:14.0: [8086:8d31] type 00 class 0x0c0330
[    7.238033] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff00000-0x383ffff0ffff 64bit]
[    7.247086] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    7.254067] pci 0000:00:16.0: [8086:8d3a] type 00 class 0x078000
[    7.260035] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff33000-0x383ffff3300f 64bit]
[    7.269095] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    7.276223] pci 0000:00:16.1: [8086:8d3b] type 00 class 0x078000
[    7.283026] pci 0000:00:16.1: reg 0x10: [mem 0x383ffff32000-0x383ffff3200f 64bit]
[    7.291094] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    7.298241] pci 0000:00:1a.0: [8086:8d2d] type 00 class 0x0c0320
[    7.305034] pci 0000:00:1a.0: reg 0x10: [mem 0x91d02000-0x91d023ff]
[    7.312118] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    7.319218] pci 0000:00:1c.0: [8086:8d16] type 01 class 0x060400
[    7.326107] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    7.333239] pci 0000:00:1d.0: [8086:8d26] type 00 class 0x0c0320
[    7.340002] pci 0000:00:1d.0: reg 0x10: [mem 0x91d01000-0x91d013ff]
[    7.347119] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    7.354164] pci 0000:00:1f.0: [8086:8d44] type 00 class 0x060100
[    7.361217] pci 0000:00:1f.2: [8086:8d02] type 00 class 0x010601
[    7.367030] pci 0000:00:1f.2: reg 0x10: [io  0x30c0-0x30c7]
[    7.374017] pci 0000:00:1f.2: reg 0x14: [io  0x30dc-0x30df]
[    7.380010] pci 0000:00:1f.2: reg 0x18: [io  0x30b8-0x30bf]
[    7.386019] pci 0000:00:1f.2: reg 0x1c: [io  0x30d8-0x30db]
[    7.392018] pci 0000:00:1f.2: reg 0x20: [io  0x3040-0x305f]
[    7.399017] pci 0000:00:1f.2: reg 0x24: [mem 0x91d04000-0x91d047ff]
[    7.406064] pci 0000:00:1f.2: PME# supported from D3hot
[    7.412220] pci 0000:00:1f.3: [8086:8d22] type 00 class 0x0c0500
[    7.419031] pci 0000:00:1f.3: reg 0x10: [mem 0x383ffff31000-0x383ffff310ff 64bit]
[    7.427033] pci 0000:00:1f.3: reg 0x20: [io  0x3000-0x301f]
[    7.434253] pci 0000:00:01.0: PCI bridge to [bus 01]
[    7.440198] pci 0000:00:02.0: PCI bridge to [bus 02]
[    7.446171] pci 0000:03:00.0: [8086:1528] type 00 class 0x020000
[    7.452030] pci 0000:03:00.0: reg 0x10: [mem 0x383fffc00000-0x383fffdfffff 64bit pref]
[    7.461010] pci 0000:03:00.0: reg 0x18: [io  0x2020-0x203f]
[    7.468020] pci 0000:03:00.0: reg 0x20: [mem 0x383fffe04000-0x383fffe07fff 64bit pref]
[    7.476077] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    7.483029] pci 0000:03:00.0: reg 0x184: [mem 0x91900000-0x91903fff 64bit]
[    7.491007] pci 0000:03:00.0: VF(n) BAR0 space: [mem 0x91900000-0x919fffff 64bit] (contains BAR0 for 64 VFs)
[    7.502017] pci 0000:03:00.0: reg 0x190: [mem 0x91a00000-0x91a03fff 64bit]
[    7.510003] pci 0000:03:00.0: VF(n) BAR3 space: [mem 0x91a00000-0x91afffff 64bit] (contains BAR3 for 64 VFs)
[    7.521251] pci 0000:03:00.1: [8086:1528] type 00 class 0x020000
[    7.528027] pci 0000:03:00.1: reg 0x10: [mem 0x383fffa00000-0x383fffbfffff 64bit pref]
[    7.537013] pci 0000:03:00.1: reg 0x18: [io  0x2000-0x201f]
[    7.543021] pci 0000:03:00.1: reg 0x20: [mem 0x383fffe00000-0x383fffe03fff 64bit pref]
[    7.552080] pci 0000:03:00.1: PME# supported from D0 D3hot D3cold
[    7.559024] pci 0000:03:00.1: reg 0x184: [mem 0x91b00000-0x91b03fff 64bit]
[    7.566004] pci 0000:03:00.1: VF(n) BAR0 space: [mem 0x91b00000-0x91bfffff 64bit] (contains BAR0 for 64 VFs)
[    7.577016] pci 0000:03:00.1: reg 0x190: [mem 0x91c00000-0x91c03fff 64bit]
[    7.585003] pci 0000:03:00.1: VF(n) BAR3 space: [mem 0x91c00000-0x91cfffff 64bit] (contains BAR3 for 64 VFs)
[    7.597019] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    7.603005] pci 0000:00:02.2:   bridge window [io  0x2000-0x2fff]
[    7.610004] pci 0000:00:02.2:   bridge window [mem 0x91900000-0x91cfffff]
[    7.617006] pci 0000:00:02.2:   bridge window [mem 0x383fffa00000-0x383fffefffff 64bit pref]
[    7.627396] pci 0000:00:03.0: PCI bridge to [bus 05]
[    7.633388] pci 0000:00:03.2: PCI bridge to [bus 06]
[    7.639069] pci 0000:07:00.0: [102b:0522] type 00 class 0x030000
[    7.645048] pci 0000:07:00.0: reg 0x10: [mem 0x90000000-0x90ffffff pref]
[    7.653026] pci 0000:07:00.0: reg 0x14: [mem 0x91800000-0x91803fff]
[    7.660026] pci 0000:07:00.0: reg 0x18: [mem 0x91000000-0x917fffff]
[    7.667061] pci 0000:07:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    7.678031] pci 0000:00:1c.0: PCI bridge to [bus 07]
[    7.683017] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x918fffff]
[    7.691014] pci 0000:00:1c.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    7.699053] pci_bus 0000:00: on NUMA node 0
[    7.705583] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.715135] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.724167] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.734160] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.743166] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.753166] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.762164] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.772166] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    7.782333] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    7.789010] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    7.799776] acpi PNP0A08:01: _OSC: platform does not support [AER]
[    7.809046] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    7.817003] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    7.827226] PCI host bridge to bus 0000:80
[    7.831006] pci_bus 0000:80: root bus resource [io  0x03b0-0x03df window]
[    7.839003] pci_bus 0000:80: root bus resource [mem 0x000a0000-0x000bffff window]
[    7.847003] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    7.855003] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
[    7.863003] pci_bus 0000:80: root bus resource [mem 0x384000000000-0x387fffffffff window]
[    7.872004] pci_bus 0000:80: root bus resource [bus 80-fe]
[    7.879019] pci 0000:80:03.0: [8086:2f08] type 01 class 0x060400
[    7.885089] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    7.892165] pci 0000:80:04.0: [8086:2f20] type 00 class 0x088000
[    7.899021] pci 0000:80:04.0: reg 0x10: [mem 0x387ffff1c000-0x387ffff1ffff 64bit]
[    7.908101] pci 0000:80:04.1: [8086:2f21] type 00 class 0x088000
[    7.914020] pci 0000:80:04.1: reg 0x10: [mem 0x387ffff18000-0x387ffff1bfff 64bit]
[    7.923197] pci 0000:80:04.2: [8086:2f22] type 00 class 0x088000
[    7.930020] pci 0000:80:04.2: reg 0x10: [mem 0x387ffff14000-0x387ffff17fff 64bit]
[    7.938194] pci 0000:80:04.3: [8086:2f23] type 00 class 0x088000
[    7.945020] pci 0000:80:04.3: reg 0x10: [mem 0x387ffff10000-0x387ffff13fff 64bit]
[    7.953193] pci 0000:80:04.4: [8086:2f24] type 00 class 0x088000
[    7.960021] pci 0000:80:04.4: reg 0x10: [mem 0x387ffff0c000-0x387ffff0ffff 64bit]
[    7.969190] pci 0000:80:04.5: [8086:2f25] type 00 class 0x088000
[    7.976020] pci 0000:80:04.5: reg 0x10: [mem 0x387ffff08000-0x387ffff0bfff 64bit]
[    7.984191] pci 0000:80:04.6: [8086:2f26] type 00 class 0x088000
[    7.991020] pci 0000:80:04.6: reg 0x10: [mem 0x387ffff04000-0x387ffff07fff 64bit]
[    7.999191] pci 0000:80:04.7: [8086:2f27] type 00 class 0x088000
[    8.006020] pci 0000:80:04.7: reg 0x10: [mem 0x387ffff00000-0x387ffff03fff 64bit]
[    8.015123] pci 0000:80:05.0: [8086:2f28] type 00 class 0x088000
[    8.022029] pci 0000:80:05.1: [8086:2f29] type 00 class 0x088000
[    8.028211] pci 0000:80:05.2: [8086:2f2a] type 00 class 0x088000
[    8.035183] pci 0000:80:05.4: [8086:2f2c] type 00 class 0x080020
[    8.042016] pci 0000:80:05.4: reg 0x10: [mem 0xc8100000-0xc8100fff]
[    8.050203] pci 0000:81:00.0: [8086:0953] type 00 class 0x010802
[    8.056025] pci 0000:81:00.0: reg 0x10: [mem 0xc8000000-0xc8003fff 64bit]
[    8.064032] pci 0000:81:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    8.072887] pci 0000:80:03.0: PCI bridge to [bus 81]
[    8.078007] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xc80fffff]
[    8.086015] pci_bus 0000:80: on NUMA node 1
[    8.092070] pci 0000:07:00.0: vgaarb: setting as boot VGA device
[    8.093000] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    8.108009] pci 0000:07:00.0: vgaarb: bridge control possible
[    8.114009] vgaarb: loaded
[    8.118043] SCSI subsystem initialized
[    8.122039] ACPI: bus type USB registered
[    8.126028] usbcore: registered new interface driver usbfs
[    8.132017] usbcore: registered new interface driver hub
[    8.139192] usbcore: registered new device driver usb
[    8.144042] pps_core: LinuxPPS API ver. 1 registered
[    8.150002] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    8.160008] PTP clock support registered
[    8.165200] EDAC MC: Ver: 3.0.0
[    8.169383] PCI: Using ACPI for IRQ routing
[    8.180483] PCI: pci_cache_line_size set to 64 bytes
[    8.186358] e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
[    8.193005] e820: reserve RAM buffer [mem 0x76231000-0x77ffffff]
[    8.199002] e820: reserve RAM buffer [mem 0x7a1d3000-0x7bffffff]
[    8.206003] e820: reserve RAM buffer [mem 0x7b800000-0x7bffffff]
[    8.213203] NetLabel: Initializing
[    8.217003] NetLabel:  domain hash size = 128
[    8.222004] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    8.228033] NetLabel:  unlabeled traffic allowed by default
[    8.235301] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    8.242003] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    8.251092] clocksource: Switched to clocksource hpet
[    8.283531] VFS: Disk quotas dquot_6.6.0
[    8.288061] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    8.295942] pnp: PnP ACPI init
[    8.301232] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    8.308824] system 00:01: [io  0x0500-0x053f] has been reserved
[    8.315462] system 00:01: [io  0x0400-0x047f] has been reserved
[    8.322087] system 00:01: [io  0x0540-0x057f] has been reserved
[    8.328710] system 00:01: [io  0x0600-0x061f] has been reserved
[    8.335333] system 00:01: [io  0x0ca0-0x0ca5] could not be reserved
[    8.342345] system 00:01: [io  0x0880-0x0883] has been reserved
[    8.348969] system 00:01: [io  0x0800-0x081f] has been reserved
[    8.355598] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    8.363387] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    8.370787] system 00:01: [mem 0xff000000-0xffffffff] could not be reserved
[    8.378576] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    8.385975] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    8.393375] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    8.400767] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    8.408175] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    8.416250] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.423994] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    8.432022] pnp: PnP ACPI: found 4 devices
[    8.445208] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    8.455158] pci 0000:07:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    8.466235] pci 0000:81:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[    8.477441] pci 0000:00:01.0: PCI bridge to [bus 01]
[    8.483016] pci 0000:00:02.0: PCI bridge to [bus 02]
[    8.488578] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    8.494425] pci 0000:00:02.2:   bridge window [io  0x2000-0x2fff]
[    8.501245] pci 0000:00:02.2:   bridge window [mem 0x91900000-0x91cfffff]
[    8.508838] pci 0000:00:02.2:   bridge window [mem 0x383fffa00000-0x383fffefffff 64bit pref]
[    8.518277] pci 0000:00:03.0: PCI bridge to [bus 05]
[    8.523840] pci 0000:00:03.2: PCI bridge to [bus 06]
[    8.529411] pci 0000:07:00.0: BAR 6: assigned [mem 0x91810000-0x9181ffff pref]
[    8.537490] pci 0000:00:1c.0: PCI bridge to [bus 07]
[    8.543048] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x918fffff]
[    8.550635] pci 0000:00:1c.0:   bridge window [mem 0x90000000-0x90ffffff 64bit pref]
[    8.559293] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    8.566207] pci_bus 0000:00: resource 5 [io  0x1000-0x7fff window]
[    8.573122] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    8.580813] pci_bus 0000:00: resource 7 [mem 0x90000000-0xc7ffbfff window]
[    8.588504] pci_bus 0000:00: resource 8 [mem 0x380000000000-0x383fffffffff window]
[    8.596965] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    8.603202] pci_bus 0000:03: resource 1 [mem 0x91900000-0x91cfffff]
[    8.610212] pci_bus 0000:03: resource 2 [mem 0x383fffa00000-0x383fffefffff 64bit pref]
[    8.619060] pci_bus 0000:07: resource 1 [mem 0x91000000-0x918fffff]
[    8.626073] pci_bus 0000:07: resource 2 [mem 0x90000000-0x90ffffff 64bit pref]
[    8.634439] pci 0000:81:00.0: BAR 6: assigned [mem 0xc8010000-0xc801ffff pref]
[    8.642519] pci 0000:80:03.0: PCI bridge to [bus 81]
[    8.648077] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xc80fffff]
[    8.655679] pci_bus 0000:80: resource 4 [io  0x03b0-0x03df window]
[    8.662593] pci_bus 0000:80: resource 5 [mem 0x000a0000-0x000bffff window]
[    8.670283] pci_bus 0000:80: resource 6 [io  0x8000-0xffff window]
[    8.677198] pci_bus 0000:80: resource 7 [mem 0xc8000000-0xfbffbfff window]
[    8.684882] pci_bus 0000:80: resource 8 [mem 0x384000000000-0x387fffffffff window]
[    8.693346] pci_bus 0000:81: resource 1 [mem 0xc8000000-0xc80fffff]
[    8.700646] NET: Registered protocol family 2
[    8.706411] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    8.716001] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    8.723781] TCP: Hash tables configured (established 524288 bind 65536)
[    8.731564] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    8.739298] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    8.747810] NET: Registered protocol family 1
[    8.753316] RPC: Registered named UNIX socket transport module.
[    8.759950] RPC: Registered udp transport module.
[    8.765214] RPC: Registered tcp transport module.
[    8.770473] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    8.778358] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:81 Dest:000003FF SID:F0FF SQ:0 SVT:1)
[    8.793443] IOAPIC[0]: Set routing entry (8-19 -> 0x81 -> IRQ 19 Mode:1 Active:1 Dest:1023)
[    8.803233] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:91 Dest:000003FF SID:F0FF SQ:0 SVT:1)
[    8.818325] IOAPIC[0]: Set routing entry (8-18 -> 0x91 -> IRQ 18 Mode:1 Active:1 Dest:1023)
[    8.828034] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:A1 Dest:000003FF SID:F0FF SQ:0 SVT:1)
[    8.843107] IOAPIC[0]: Set routing entry (8-18 -> 0xa1 -> IRQ 18 Mode:1 Active:1 Dest:1023)
[    8.852680] pci 0000:07:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    8.862066] PCI: CLS 32 bytes, default 64
[    8.866660] Unpacking initramfs...
[   29.464524] Freeing initrd memory: 623272K
[   29.469385] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   29.476607] software IO TLB [mem 0x72231000-0x76231000] (64MB) mapped at [ffff880072231000-ffff880076230fff]
[   29.490246] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[   29.499116] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   29.505545] RAPL PMU: hw unit of domain package 2^-14 Joules
[   29.511868] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   29.517902] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   29.552916] audit: initializing netlink subsys (disabled)
[   29.559111] audit: type=2000 audit(1509292774.558:1): state=initialized audit_enabled=0 res=1
[   29.560619] Initialise system trusted keyrings
[   29.560781] workingset: timestamp_bits=36 max_order=25 bucket_order=0
[   29.562769] zbud: loaded
[   29.564337] 9p: Installing v9fs 9p2000 file system support
[   29.564529] SELinux:  Registering netfilter hooks
[   29.600409] NET: Registered protocol family 38
[   29.605405] Key type asymmetric registered
[   29.609987] Asymmetric key parser 'x509' registered
[   29.615512] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[   29.624049] io scheduler noop registered
[   29.628439] io scheduler deadline registered (default)
[   29.634296] io scheduler cfq registered
[   29.638584] io scheduler mq-deadline registered
[   29.643646] io scheduler kyber registered
[   29.650242] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[   29.658109] gpio-mockup: probe of gpio-mockup failed with error -22
[   29.665708] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:B1 Dest:000003FF SID:002C SQ:0 SVT:1)
[   29.680797] IOAPIC[1]: Set routing entry (9-23 -> 0xb1 -> IRQ 24 Mode:1 Active:1 Dest:1023)
[   29.692186] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:23 Dest:000003FF SID:F0FF SQ:0 SVT:1)
[   29.707264] IOAPIC[0]: Set routing entry (8-19 -> 0x23 -> IRQ 19 Mode:1 Active:1 Dest:1023)
[   29.717066] IOAPIC[10]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:53 Dest:000403FF SID:802C SQ:0 SVT:1)
[   29.732244] IOAPIC[2]: Set routing entry (10-23 -> 0x53 -> IRQ 31 Mode:1 Active:1 Dest:263167)
[   29.742241] pcieport 0000:00:01.0: Signaling PME with IRQ 25
[   29.748628] pcieport 0000:00:02.0: Signaling PME with IRQ 26
[   29.754996] pcieport 0000:00:02.2: Signaling PME with IRQ 27
[   29.761354] pcieport 0000:00:03.0: Signaling PME with IRQ 28
[   29.767731] pcieport 0000:00:03.2: Signaling PME with IRQ 29
[   29.774096] pcieport 0000:00:1c.0: Signaling PME with IRQ 30
[   29.780488] pcieport 0000:80:03.0: Signaling PME with IRQ 32
[   29.786904] intel_idle: MWAIT substates: 0x2120
[   29.791975] intel_idle: v0.4.1 model 0x3F
[   29.801986] intel_idle: lapic_timer_reliable_states 0xffffffff
[   29.808927] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   29.817335] ACPI: Power Button [PWRF]
[   30.041993] ERST: Error Record Serialization Table (ERST) support is initialized.
[   30.050393] pstore: using zlib compression
[   30.054985] pstore: Registered erst as persistent store backend
[   30.062334] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[   30.070927] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   30.098667] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   30.127612] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   30.136998] Non-volatile memory driver v1.3
[   30.141774] Linux agpgart interface v0.103
[   30.160521] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   30.168194] rdac: device handler registered
[   30.173053] hp_sw: device handler registered
[   30.177839] emc: device handler registered
[   30.182673] alua: device handler registered
[   30.187427] libphy: Fixed MDIO Bus: probed
[   30.192165] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   30.200042] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   30.206529] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   30.213054] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   30.219757] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[   30.227544] igb: Copyright (c) 2007-2014 Intel Corporation.
[   30.233845] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
[   30.242411] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   30.249319] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:93 Dest:000003FF SID:002C SQ:0 SVT:1)
[   30.264409] IOAPIC[1]: Set routing entry (9-13 -> 0x93 -> IRQ 33 Mode:1 Active:1 Dest:1023)
[   30.532270] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[   30.559092] tsc: Refined TSC clocksource calibration: 2294.702 MHz
[   30.566136] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2113a84a6ae, max_idle_ns: 440795217993 ns
[   30.580147] ixgbe 0000:03:00.0: PCI Express bandwidth of 32GT/s available
[   30.587760] ixgbe 0000:03:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[   30.620129] ixgbe 0000:03:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
[   30.627056] ixgbe 0000:03:00.0: 00:1e:67:f7:44:b3
[   30.788530] ixgbe 0000:03:00.0: Intel(R) 10 Gigabit Network Connection
[   30.796125] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:E8 Dest:000003FF SID:002C SQ:0 SVT:1)
[   30.811204] IOAPIC[1]: Set routing entry (9-10 -> 0xe8 -> IRQ 100 Mode:1 Active:1 Dest:1023)
[   31.084241] ixgbe 0000:03:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[   31.132240] ixgbe 0000:03:00.1: PCI Express bandwidth of 32GT/s available
[   31.139851] ixgbe 0000:03:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[   31.172230] ixgbe 0000:03:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
[   31.179164] ixgbe 0000:03:00.1: 00:1e:67:f7:44:b4
[   31.334252] ixgbe 0000:03:00.1: Intel(R) 10 Gigabit Network Connection
[   31.341832] usbcore: registered new interface driver catc
[   31.347924] usbcore: registered new interface driver kaweth
[   31.354164] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[   31.362445] usbcore: registered new interface driver pegasus
[   31.368784] usbcore: registered new interface driver rtl8150
[   31.375131] usbcore: registered new interface driver asix
[   31.381180] usbcore: registered new interface driver cdc_ether
[   31.387713] usbcore: registered new interface driver cdc_eem
[   31.394052] usbcore: registered new interface driver dm9601
[   31.400299] usbcore: registered new interface driver smsc75xx
[   31.406739] usbcore: registered new interface driver smsc95xx
[   31.413177] usbcore: registered new interface driver gl620a
[   31.419418] usbcore: registered new interface driver net1080
[   31.425755] usbcore: registered new interface driver plusb
[   31.431899] usbcore: registered new interface driver rndis_host
[   31.438529] usbcore: registered new interface driver cdc_subset
[   31.445159] usbcore: registered new interface driver zaurus
[   31.451403] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[   31.459685] usbcore: registered new interface driver int51x1
[   31.466024] usbcore: registered new interface driver ipheth
[   31.472266] usbcore: registered new interface driver sierra_net
[   31.479064] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   31.486386] ehci-pci: EHCI PCI platform driver
[   31.491664] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:6E Dest:000003FF SID:F0FF SQ:0 SVT:1)
[   31.506752] IOAPIC[0]: Set routing entry (8-18 -> 0x6e -> IRQ 18 Mode:1 Active:1 Dest:1023)
[   31.516226] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   31.522239] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   31.530546] ehci-pci 0000:00:1a.0: debug port 2
[   31.535910] alloc_contig_range: [204b400, 204b401) PFNs busy
[   31.542271] alloc_contig_range: [204b400, 204b401) PFNs busy
[   31.548614] alloc_contig_range: [204b401, 204b402) PFNs busy
[   31.558839] ehci-pci 0000:00:1a.0: cache line size of 32 is not supported
[   31.566449] ehci-pci 0000:00:1a.0: irq 18, io mem 0x91d02000
[   31.579095] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   31.585633] clocksource: Switched to clocksource tsc
[   31.585698] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   31.585701] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   31.585703] usb usb1: Product: EHCI Host Controller
[   31.585705] usb usb1: Manufacturer: Linux 4.14.0-rc6-00162-g3d6dabc2 ehci_hcd
[   31.585707] usb usb1: SerialNumber: 0000:00:1a.0
[   31.585883] hub 1-0:1.0: USB hub found
[   31.585891] hub 1-0:1.0: 2 ports detected
[   31.586335] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   31.586442] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   31.586461] ehci-pci 0000:00:1d.0: debug port 2
[   31.586485] alloc_contig_range: [204b400, 204b401) PFNs busy
[   31.586499] alloc_contig_range: [204b401, 204b402) PFNs busy
[   31.586510] alloc_contig_range: [204b402, 204b403) PFNs busy
[   31.586535] alloc_contig_range: [204b400, 204b401) PFNs busy
[   31.586545] alloc_contig_range: [204b401, 204b402) PFNs busy
[   31.586556] alloc_contig_range: [204b402, 204b403) PFNs busy
[   31.586567] alloc_contig_range: [204b403, 204b404) PFNs busy
[   31.590545] ehci-pci 0000:00:1d.0: cache line size of 32 is not supported
[   31.590555] ehci-pci 0000:00:1d.0: irq 18, io mem 0x91d01000
[   31.597064] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   31.597142] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   31.597145] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   31.597147] usb usb2: Product: EHCI Host Controller
[   31.597149] usb usb2: Manufacturer: Linux 4.14.0-rc6-00162-g3d6dabc2 ehci_hcd
[   31.597150] usb usb2: SerialNumber: 0000:00:1d.0
[   31.597343] hub 2-0:1.0: USB hub found
[   31.597350] hub 2-0:1.0: 2 ports detected
[   31.597573] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   31.597583] ohci-pci: OHCI PCI platform driver
[   31.597636] uhci_hcd: USB Universal Host Controller Interface driver
[   31.597951] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   31.598076] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[   31.600733] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[   31.600740] xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
[   31.600823] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[   31.600825] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   31.600827] usb usb3: Product: xHCI Host Controller
[   31.600829] usb usb3: Manufacturer: Linux 4.14.0-rc6-00162-g3d6dabc2 xhci-hcd
[   31.600830] usb usb3: SerialNumber: 0000:00:14.0
[   31.601046] hub 3-0:1.0: USB hub found
[   31.601075] hub 3-0:1.0: 15 ports detected
[   31.607617] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   31.607714] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[   31.607772] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[   31.607774] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   31.607776] usb usb4: Product: xHCI Host Controller
[   31.607778] usb usb4: Manufacturer: Linux 4.14.0-rc6-00162-g3d6dabc2 xhci-hcd
[   31.607779] usb usb4: SerialNumber: 0000:00:14.0
[   31.607930] hub 4-0:1.0: USB hub found
[   31.607947] hub 4-0:1.0: 6 ports detected
[   31.611127] usbcore: registered new interface driver usbserial
[   31.611137] usbcore: registered new interface driver usbserial_generic
[   31.611145] usbserial: USB Serial support registered for generic
[   31.611173] i8042: PNP: No PS/2 controller found.
[   31.611255] mousedev: PS/2 mouse device common for all mice
[   31.611394] rtc_cmos 00:00: RTC can wake from S4
[   31.611589] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[   31.611641] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   31.611934] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:8E Dest:000003FF SID:F0FF SQ:0 SVT:1)
[   31.611939] IOAPIC[0]: Set routing entry (8-17 -> 0x8e -> IRQ 17 Mode:1 Active:1 Dest:1023)
[   31.611990] i801_smbus 0000:00:11.1: SMBus using PCI interrupt
[   31.616131] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   31.619918] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   31.619965] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   31.619979] iTCO_vendor_support: vendor-support=0
[   31.619994] intel_pstate: Intel P-state driver initializing
[   31.640414] hidraw: raw HID events driver (C) Jiri Kosina
[   31.640494] usbcore: registered new interface driver usbhid
[   31.640495] usbhid: USB HID core driver
[   31.640778] drop_monitor: Initializing network drop monitor service
[   31.640958] Initializing XFRM netlink socket
[   31.641146] NET: Registered protocol family 10
[   31.641933] Segment Routing with IPv6
[   31.641948] NET: Registered protocol family 17
[   31.642103] 9pnet: Installing 9P2000 support
[   31.659787] intel_rdt: Intel RDT L3 monitoring detected
[   31.659845] microcode: sig=0x306f2, pf=0x1, revision=0x2d
[   31.666145] microcode: Microcode Update Driver: v2.2.
[   31.666200] ... APIC ID:      00000000 (0)
[   31.666202] ... APIC VERSION: 01060015
[   31.666205] 0000000000000000000000000000000000000000000000000000000000000000
[   31.666210] 0000000002000000000200020000000000000000000000000000000000000000
[   31.666226] number of IO-APIC #10 registers: 24.
[   31.666227] testing the IO APIC.......................
[   31.666236] IO APIC #8......
[   31.666237] .... register #00: 08000000
[   31.666238] .......    : physical APIC id: 08
[   31.666238] .......    : Delivery Type: 0
[   31.666239] .......    : LTS          : 0
[   31.666240] .... register #01: 00170020
[   31.666241] .......     : max redirection entries: 17
[   31.666241] .......     : PRQ implemented: 0
[   31.666242] .......     : IO APIC version: 20
[   31.666243] .... IRQ redirection table:
[   31.666244] IOAPIC 0:
[   31.666252]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666259]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666265]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(0)
[   31.666271]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666287]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666293]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666298]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped, I(0007),  Z(0)
[   31.666304]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped, I(0008),  Z(0)
[   31.666309]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666317]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666322]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666328]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666333]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666339]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666345]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.66636(0), physical, D(00), M(0)
[   31.666373]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666378]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666384]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666387] IO APIC #9......
[   31.666387] .... register #00: 09000000
[   31.666388] .......    : physical APIC id: 09
[   31.666388] .......    : Delivery Type: 0
[   31.666389] .......    : LTS          : 0
[   31.666390] .... register #01: 00170020
[   31.666390] .......     : max redirection entries: 17
[   31.666391] .......     : PRQ implemented: 0
[   31.666391] .......     : IO APIC version: 20
[   31.666392] .... register #02: 00000000
[   31.666393] .......     : arbitration: 00
[   31.666393] .... register #03: 00000001
[   31.666394] .......     : Boot DT    : 1
[   31.666394] .... IRQ redirection table:
[   31.666395] IOAPIC 1:
[   31.666398]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666400]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666403]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666406]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666409]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666411]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666414]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666417]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666420]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666423]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666425]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666428]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666431]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666434]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666436]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666439]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666442]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666445]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666448]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666450]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666453]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666456]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666459]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666462]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666465] IO APIC #10......
[   31.666466] .... register #00: 0A000000
[   31.666467] .......    : physical APIC id: 0A
[   31.666467] .......    : Delivery Type: 0
[   31.666468] .......    : LTS          : 0
[   31.666468] .... register #01: 00170020
[   31.666469] .......     : max redirection entries: 17
[   31.666470] .......     : PRQ implemented: 0
[   31.666470] .......     : IO APIC version: 20
[   31.666471] .... register #02: 00000000
[   31.666472] .......     : arbitration: 00
[   31.666472] .... register #03: 00000001
[   31.666473] .......     : Boot DT    : 1
[   31.666473] .... IRQ redirection table:
[   31.666474] IOAPIC 2:
[   31.666477]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666480]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666483]  pin02, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666486]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666489]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666492]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666495]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666498]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666501]  pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666504]  pin09, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666507]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666510]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666513]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666516]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666519]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666522]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666525]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666528]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666531]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666534]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666537]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666540]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666543]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666546]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
[   31.666547] IRQ to pin mappings:
[   31.666549] IRQ0 -> 0:2
[   31.666553] IRQ1 -> 0:1
[   31.666554] IRQ3 -> 0:3
[   31.666556] IRQ4 -> 0:4
[   31.666557] IRQ5 -> 0:5
[   31.666559] IRQ6 -> 0:6
[   31.666560] IRQ7 -> 0:7
[   31.666562] IRQ8 -> 0:8
[   31.666563] IRQ9 -> 0:9
[   31.666564] IRQ10 -> 0:10
[   31.666566] IRQ11 -> 0:11
[   31.666567] IRQ12 -> 0:12
[   31.666568] IRQ13 -> 0:13
[   31.666570] IRQ14 -> 0:14
[   31.666571] IRQ15 -> 0:15
[   31.666572] IRQ17 -> 0:17
[   31.666574] IRQ18 -> 0:18
[   31.666575] IRQ19 -> 0:19
[   31.666576] IRQ24 -> 1:23
[   31.666578] IRQ31 -> 2:23
[   31.666580] IRQ33 -> 1:13
[   31.666586] IRQ100 -> 1:10
[   31.666591] .................................... done.
[   31.666607] sched_clock: Marking stable (31666137098, 0)->(33750109044, -2083971946)
[   31.780088] registered taskstats version 1
[   31.780088] Loading compiled-in X.509 certificates
[   31.780164] zswap: loaded using pool lzo/zbud
[   31.864934] Key type big_key registered
[   31.867092] Key type trusted registered
[   31.869123] Key type encrypted registered
[   31.869127] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[   31.869152] evm: HMAC attrs: 0x1
[   31.875741] rtc_cmos 00:00: setting system clock to 2017-10-29 15:59:39 UTC (1509292779)
[   31.905067] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   31.921066] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   31.929066] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[   32.033464] usb 1-1: New USB device found, idVendor=8087, idProduct=800a
[   32.033467] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   32.033750] hub 1-1:1.0: USB hub found
[   32.033835] hub 1-1:1.0: 6 ports detected
[   32.050465] usb 2-1: New USB device found, idVendor=8087, idProduct=8002
[   32.050468] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   32.050748] hub 2-1:1.0: USB hub found
[   32.050835] hub 2-1:1.0: 8 ports detected
[   32.061580] usb 3-3: New USB device found, idVendor=14dd, idProduct=1005
[   32.061582] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   32.061584] usb 3-3: Product: D2CIM-VUSB
[   32.061586] usb 3-3: Manufacturer: Raritan
[   32.061587] usb 3-3: SerialNumber: EFFB212D0A6EE2A
[   32.069162] input: Raritan D2CIM-VUSB as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/0003:14DD:1005.0001/input/input1
[   32.121353] hid-generic 0003:14DD:1005.0001: input,hidraw0: USB HID v1.11 Keyboard [Raritan D2CIM-VUSB] on usb-0000:00:14.0-3/input0
[   32.150628] pps pps0: new PPS source ptp0
[   32.150632] ixgbe 0000:03:00.0: registered PHC device on eth0
[   32.235024] usb 3-9: new full-speed USB device number 3 using xhci_hcd
[   32.259679] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   32.283200] ixgbe 0000:03:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control: RX/TX
[   32.381135] usb 3-9: New USB device found, idVendor=046b, idProduct=ff10
[   32.381137] usb 3-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   32.381139] usb 3-9: Product: Virtual Keyboard and Mouse
[   32.381141] usb 3-9: Manufacturer: American Megatrends Inc.
[   32.381142] usb 3-9: SerialNumber: serial
[   32.382567] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/0003:046B:FF10.0002/input/input2
[   32.382819] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:14.0-9/input0
[   32.383720] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.1/0003:046B:FF10.0003/input/input3
[   32.383876] hid-generic 0003:046B:FF10.0003: input,hidraw2: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:14.0-9/input1
[   32.523446] pps pps1: new PPS source ptp1
[   32.523449] ixgbe 0000:03:00.1: registered PHC device on eth1
[   32.631828] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   32.632347] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   32.643047] Sending DHCP requests ., OK
[   32.649198] IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.227
[   32.649199] IP-Config: Complete:
[   32.649202]      device=eth0, hwaddr=00:1e:67:f7:44:b3, ipaddr=192.168.1.227, mask=255.255.255.0, gw=192.168.1.1
[   32.649203]      host=lkp-hsw-ep4, domain=lkp.intel.com, nis-domain=(none)
[   32.649205]      bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=     nameserver0=192.168.1.1
[   32.658145] ixgbe 0000:03:00.1: removed PHC on eth1
[   33.421940] Freeing unused kernel memory: 2320K
[   33.427012] Write protecting the kernel read-only data: 14336k
[   33.434218] Freeing unused kernel memory: 612K
[   33.439612] Freeing unused kernel memory: 116K
[   33.444584] rodata_test: all tests were successful
SELinux:  Could 
[   33.453329] systemd[1]: RTC configured in localtime, applying delta of 480 minutes to system time.
not open policy file <= /etc/selinux/targeted/policy/policy.31:  No such file or directory
[   33.477812] ip_tables: (C) 2000-2006 Netfilter Core Team

         Mounting RPC Pipe File System...
         Mounting Debug File System...
         Starting Load Kernel Modules...
         Starting Create list of required st... nodes for the current kernel...
         Mounting POSIX Message Queue File System...
         Mounting Huge Pages File System...
         Starting Remount Root and Kernel File Systems...
         Starting Journal Service...
         Starting Apply Kernel Variables...
         Mounting Configuration File System...
         Starting Create Static Device Nodes in /dev...
 Systems.
         Starting Load/Save Random Seed...
         Starting udev Coldplug all Devices...
ed Configuration File System.
[
[   33.750900] ipmi device interface
[   33.751172] libata version 3.00 loaded.
s.
Load/Save Random
[   33.785231] IPMI System Interface driver.
 Seed.
ted Create Stati
[   33.804809] ipmi_si: SPMI-specified kcs state machine: duplicate
c Device Nodes i
[   33.813065] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
n /dev.
       
[   33.823585] power_meter ACPI000D:00: Found ACPI power meter.
  Starting udev 
[   33.823623] power_meter ACPI000D:00: Ignoring unsafe software power cap!
Kernel Device Ma
[   33.823630] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
nager...
ached target Loc
[   33.866556] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:47 Dest:000003FF SID:F0FF SQ:0 SVT:1)
al File Systems 
[   33.882931] IOAPIC[0]: Set routing entry (8-16 -> 0x47 -> IRQ 16 Mode:1 Active:1 Dest:1023)
(Pre).
hed target Local
[   33.894398] IOAPIC[10]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:67 Dest:000403FF SID:802C SQ:0 SVT:1)
 File Systems.
[   33.894402] IOAPIC[2]: Set routing entry (10-16 -> 0x67 -> IRQ 166 Mode:1 Active:1 Dest:263167)
         Startin
[   33.939154] ahci 0000:00:11.4: flags: 64bit ncq led clo pio slum part ems apst 
g Preprocess NFS
[   33.949175] AVX2 version of gcm_enc/dec engaged.
 configuration..
[   33.955538] AES CTR mode by8 optimization enabled
.
reprocess NFS co
[   33.968977] scsi host1: ahci
nfiguration.
] Reached target
[   33.983120] ata1: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00100 irq 165
 NFS client serv
[   33.987459] ipmi_si dmi-ipmi-si.0: Found new BMC (man_id: 0x000157, prod_id: 0x006f, dev_id: 0x21)
ices.
ed udev Kernel D
[   34.022788] ata3: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00200 irq 165
evice Manager.
[   34.032713] ata4: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00280 irq 165
0m] Started Jour
[   34.053321] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part ems apst 
nal Service.
[   34.063265] Error: Driver 'pcspkr' is already registered, aborting...
         Starting Flush Journal to Persistent Storage...
[   34.091229] [TTM] Zone  kernel: Available graphics memory: 65963068 kiB
[   34.098639] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[   34.105959] scsi host4: ahci
[   34.109239] [TTM] Initializing pool allocator
[   34.109244] [TTM] Initializing DMA pool allocator
[   34.109383] scsi host5: ahci
[   34.121740] scsi host6: ahci
[   34.121929] scsi host7: ahci
[   34.122092] scsi host8: ahci
[   34.122206] scsi host9: ahci
[   34.122235] ata5: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04100 irq 168
[   34.122236] ata6: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04180 irq 168
[   34.122238] ata7: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04200 irq 168
[   34.122239] ata8: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04280 irq 168
[   34.122241] ata9: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04300 irq 168
[   34.122243] ata10: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04380 irq 168
[   34.185788] fbcon: mgadrmfb (fb0) is primary device
[   34.185921] Console: switching to colour frame buffer device 128x48
[   34.207893] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[   34.207902] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[   34.207911] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[   34.207918] EDAC sbridge: Seeking for: PCI ID 8086:2f60
[   34.207922] EDAC sbridge: Seeking for: PCI ID 8086:2f60
[   34.207926] EDAC sbridge: Seeking for: PCI ID 8086:2f60
[   34.207929] EDAC sbridge: Seeking for: PCI ID 8086:2fa8
[   34.207933] EDAC sbridge: Seeking for: PCI ID 8086:2fa8
[   34.207937] EDAC sbridge: Seeking for: PCI ID 8086:2fa8
[   34.207940] EDAC sbridge: Seeking for: PCI ID 8086:2f71
[   34.207943] EDAC sbridge: Seeking for: PCI ID 8086:2f71
[   34.207947] EDAC sbridge: Seeking for: PCI ID 8086:2f71
[   34.207951] EDAC sbridge: Seeking for: PCI ID 8086:2faa
[   34.207954] EDAC sbridge: Seeking for: PCI ID 8086:2faa
[   34.207958] EDAC sbridge: Seeking for: PCI ID 8086:2faa
[   34.207961] EDAC sbridge: Seeking for: PCI ID 8086:2fab
[   34.207965] EDAC sbridge: Seeking for: PCI ID 8086:2fab
[   34.207970] EDAC sbridge: Seeking for: PCI ID 8086:2fab
[   34.207973] EDAC sbridge: Seeking for: PCI ID 8086:2fac
[   34.207980] EDAC sbridge: Seeking for: PCI ID 8086:2fad
[   34.207988] EDAC sbridge: Seeking for: PCI ID 8086:2f68
[   34.207991] EDAC sbridge: Seeking for: PCI ID 8086:2f68
[   34.207996] EDAC sbridge: Seeking for: PCI ID 8086:2f68
[   34.207998] EDAC sbridge: Seeking for: PCI ID 8086:2f79
[   34.208015] EDAC sbridge: Seeking for: PCI ID 8086:2f79
[   34.208020] EDAC sbridge: Seeking for: PCI ID 8086:2f79
[   34.208022] EDAC sbridge: Seeking for: PCI ID 8086:2f6a
[   34.208026] EDAC sbridge: Seeking for: PCI ID 8086:2f6a
[   34.208031] EDAC sbridge: Seeking for: PCI ID 8086:2f6a
[   34.208033] EDAC sbridge: Seeking for: PCI ID 8086:2f6b
[   34.208037] EDAC sbridge: Seeking for: PCI ID 8086:2f6b
[   34.208041] EDAC sbridge: Seeking for: PCI ID 8086:2f6b
[   34.208044] EDAC sbridge: Seeking for: PCI ID 8086:2f6c
[   34.208051] EDAC sbridge: Seeking for: PCI ID 8086:2f6d
[   34.208059] EDAC sbridge: Seeking for: PCI ID 8086:2ffc
[   34.208062] EDAC sbridge: Seeking for: PCI ID 8086:2ffc
[   34.208066] EDAC sbridge: Seeking for: PCI ID 8086:2ffc
[   34.208070] EDAC sbridge: Seeking for: PCI ID 8086:2ffd
[   34.208072] EDAC sbridge: Seeking for: PCI ID 8086:2ffd
[   34.208077] EDAC sbridge: Seeking for: PCI ID 8086:2ffd
[   34.208080] EDAC sbridge: Seeking for: PCI ID 8086:2fbd
[   34.208084] EDAC sbridge: Seeking for: PCI ID 8086:2fbd
[   34.208088] EDAC sbridge: Seeking for: PCI ID 8086:2fbd
[   34.208091] EDAC sbridge: Seeking for: PCI ID 8086:2fbf
[   34.208094] EDAC sbridge: Seeking for: PCI ID 8086:2fbf
[   34.208098] EDAC sbridge: Seeking for: PCI ID 8086:2fbf
[   34.208101] EDAC sbridge: Seeking for: PCI ID 8086:2fb9
[   34.208105] EDAC sbridge: Seeking for: PCI ID 8086:2fb9
[   34.208109] EDAC sbridge: Seeking for: PCI ID 8086:2fb9
[   34.208112] EDAC sbridge: Seeking for: PCI ID 8086:2fbb
[   34.208116] EDAC sbridge: Seeking for: PCI ID 8086:2fbb
[   34.208120] EDAC sbridge: Seeking for: PCI ID 8086:2fbb
[   34.208385] EDAC MC0: Giving out device to module sb_edac.c controller Haswell SrcID#1_Ha#0: DEV 0000:ff:12.0 (INTERRUPT)
[   34.208500] EDAC MC1: Giving out device to module sb_edac.c controller Haswell SrcID#0_Ha#0: DEV 0000:7f:12.0 (INTERRUPT)
[   34.208681] EDAC MC2: Giving out device to module sb_edac.c controller Haswell SrcID#1_Ha#1: DEV 0000:ff:12.4 (INTERRUPT)
[   34.209066] EDAC MC3: Giving out device to module sb_edac.c controller Haswell SrcID#0_Ha#1: DEV 0000:7f:12.4 (INTERRUPT)
[   34.209067] EDAC sbridge:  Ver: 1.1.2 
[   34.212357] intel_rapl: Found RAPL domain package
[   34.212359] intel_rapl: Found RAPL domain dram
[   34.212360] intel_rapl: DRAM domain energy unit 15300pj
[   34.212573] intel_rapl: Found RAPL domain package
[   34.212576] intel_rapl: Found RAPL domain dram
[   34.212578] intel_rapl: DRAM domain energy unit 15300pj
[   34.348271] ata1: SATA link down (SStatus 0 SControl 300)
[   34.348292] ata4: SATA link down (SStatus 0 SControl 300)
[   34.348312] ata3: SATA link down (SStatus 0 SControl 300)
[   34.348332] ata2: SATA link down (SStatus 0 SControl 300)
[   34.428266] ata5: SATA link down (SStatus 0 SControl 300)
[   34.428296] ata10: SATA link down (SStatus 0 SControl 300)
[   34.428323] ata6: SATA link down (SStatus 0 SControl 300)
[   34.428351] ata8: SATA link down (SStatus 0 SControl 300)
[   34.428376] ata7: SATA link down (SStatus 0 SControl 300)
[   34.428838] ata9: SATA link down (SStatus 0 SControl 300)
[   34.887562] mgag200 0000:07:00.0: fb0: mgadrmfb frame buffer device
         Starting Create Volatil
[   34.897024] [drm] Initialized mgag200 1.0.0 20110418 for 0000:07:00.0 on minor 0
e Files and Directories...
         Starting RPC bind portmap service...
         Starting Network Time Synchronization...
         Starting Update UTMP about System Boot/Shutdown...
         Starting /etc/rc.local Compatibility...
rc.local[853]: PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/lkp/lizhijian/src/bin
LKP: HOSTNAME lkp-hsw-ep4, MAC 00:1e:67:f7:44:b3, kernel 4.14.0-rc6-00162-g3d6dabc2 1, serial console /dev/ttyS0
         Starting OpenBSD Secure Shell server...
         Starting Permit User Sessions...
[   35.132425] Kernel tests: Boot OK!
[   35.132428] 
         Starting LKP bootstrap...
         Starting Login Service...
[   35.245894] install debs round one: dpkg -i --force-depends /opt/deb/mime-support_3.60_all.deb
[   35.245896] 
[   35.258679] /opt/deb/libexpat1_2.2.3-1_amd64.deb
[   35.258681] 
[   35.266849] /opt/deb/libatomic1_7.2.0-7_amd64.deb
[   35.266850] 
[   35.275164] /opt/deb/libquadmath0_7.2.0-7_amd64.deb
[   35.275165] 
[   35.283724] /opt/deb/libexpat1-dev_2.2.3-1_amd64.deb
[   35.283726] 
[   35.292313] /opt/deb/patch_2.7.5-1+b2_amd64.deb
[   35.292314] 
[   35.300383] /opt/deb/debconf_1.5.63_all.deb
[   35.300385] 
[   35.308488] /opt/deb/libtext-charwidth-perl_0.04-7+b7_amd64.deb
[   35.308489] 
[   35.318453] /opt/deb/libtext-iconv-perl_1.7-5+b6_amd64.deb
[   35.318455] 
[   35.327798] /opt/deb/perl-base_5.26.0-5_amd64.deb
[   35.327799] 
[   35.336538] /opt/deb/liblocale-gettext-perl_1.07-3+b3_amd64.deb
[   35.336540] 
[   35.346578] /opt/deb/perl-modules-5.26_5.26.0-5_all.deb
[   35.346580] 
[   35.355752] /opt/deb/libperl5.26_5.26.0-5_amd64.deb
[   35.355753] 
[   35.364505] /opt/deb/perl_5.26.0-5_amd64.deb
[   35.364506] 
[   35.372661] /opt/deb/gawk_1%3a4.1.4+dfsg-1_amd64.deb
[   35.372662] 
[   35.381572] /opt/deb/libssl1.1_1.1.0f-3_amd64.deb
[   35.381574] 
[   35.389757] /opt/deb/openssl_1.1.0f-3_amd64.deb
[   35.389758] 
[   35.397812] /opt/deb/ca-certificates_20161130+nmu1_all.deb
[   35.397813] 
[   35.407114] Selecting previously unselected package mime-support.
[   35.407115] 
[   35.417449] (Reading database ... 2202 files and directories currently installed.)
[   35.417450] 
[   35.429212] Preparing to unpack .../deb/mime-support_3.60_all.deb ...
[   35.429213] 
[   35.439308] Unpacking mime-support (3.60) ...
[   35.439309] 
[   35.447468] Preparing to unpack .../libexpat1_2.2.3-1_amd64.deb ...
[   35.447469] 
[   35.457643] Unpacking libexpat1:amd64 (2.2.3-1) over (2.2.0-1) ...
[   35.457644] 
[   35.467676] Selecting previously unselected package libatomic1:amd64.
[   35.467677] 
[   35.478234] Preparing to unpack .../libatomic1_7.2.0-7_amd64.deb ...
[   35.478236] 
[   35.488400] Unpacking libatomic1:amd64 (7.2.0-7) ...
[   35.488401] 
[   35.497386] Selecting previously unselected package libquadmath0:amd64.
[   35.497387] 
[   35.508173] Preparing to unpack .../libquadmath0_7.2.0-7_amd64.deb ...
[   35.508175] 
[   35.518574] Unpacking libquadmath0:amd64 (7.2.0-7) ...
[   35.518575] 
[   35.527734] Selecting previously unselected package libexpat1-dev:amd64.
[   35.527735] 
[   35.538611] Preparing to unpack .../libexpat1-dev_2.2.3-1_amd64.deb ...
[   35.538613] 
[   35.549155] Unpacking libexpat1-dev:amd64 (2.2.3-1) ...
[   35.549156] 
[   35.558177] Selecting previously unselected package patch.
[   35.558178] 
[   35.567661] Preparing to unpack .../deb/patch_2.7.5-1+b2_amd64.deb ...
[   35.567662] 
[   35.578023] Unpacking patch (2.7.5-1+b2) ...
[   35.578024] 
[   35.586155] Preparing to unpack .../opt/deb/debconf_1.5.63_all.deb ...
[   35.586156] 
[   35.596596] Unpacking debconf (1.5.63) over (1.5.59) ...
[   35.596597] 
[   35.605991] Preparing to unpack .../libtext-charwidth-perl_0.04-7+b7_amd64.deb ...
[   35.605992] 
[   35.617847] Unpacking libtext-charwidth-perl (0.04-7+b7) over (0.04-7+b4) ...
[   35.617848] 
[   35.629399] Preparing to unpack .../libtext-iconv-perl_1.7-5+b6_amd64.deb ...
[   35.629400] 
[   35.640724] Unpacking libtext-iconv-perl (1.7-5+b6) over (1.7-5+b3) ...
[   35.640725] 
[   35.651409] Preparing to unpack .../perl-base_5.26.0-5_amd64.deb ...
[   35.651410] 
[   35.661705] Unpacking perl-base (5.26.0-5) over (5.22.2-3) ...
[   35.661706] 
[   35.671717] Preparing to unpack .../liblocale-gettext-perl_1.07-3+b3_amd64.deb ...
[   35.671718] 
[   35.683673] Unpacking liblocale-gettext-perl (1.07-3+b3) over (1.07-3) ...
[   35.683674] 
[   35.694855] Selecting previously unselected package perl-modules-5.26.
[   35.694856] 
[   35.705718] Preparing to unpack .../perl-modules-5.26_5.26.0-5_all.deb ...
[   35.705718] 
[   35.716694] Unpacking perl-modules-5.26 (5.26.0-5) ...
[   35.716694] 
[   35.964376] Selecting previously unselected package libperl5.26:amd64.
[   35.964378] 
[   35.975823] Preparing to unpack .../libperl5.26_5.26.0-5_amd64.deb ...
[   35.975824] 
[   35.986567] Unpacking libperl5.26:amd64 (5.26.0-5) ...
[   35.986568] 
[   36.323748] Selecting previously unselected package perl.
[   36.323750] 
[   36.333960] Preparing to unpack .../deb/perl_5.26.0-5_amd64.deb ...
[   36.333961] 
[   36.344423] Unpacking perl (5.26.0-5) ...
[   36.344424] 
[   36.371336] Preparing to unpack .../gawk_1%3a4.1.4+dfsg-1_amd64.deb ...
[   36.371339] 
[   36.383626] Unpacking gawk (1:4.1.4+dfsg-1) over (1:4.1.1+dfsg-1) ...
[   36.383626] 
[   36.452792] Selecting previously unselected package libssl1.1:amd64.
[   36.452793] 
[   36.463885] Preparing to unpack .../libssl1.1_1.1.0f-3_amd64.deb ...
[   36.463886] 
[   36.474505] Unpacking libssl1.1:amd64 (1.1.0f-3) ...
[   36.474506] 
[   36.509876]  nvme0n1: p1
[   36.575490] Selecting previously unselected package openssl.
[   36.575492] 
[   36.585887] Preparing to unpack .../deb/openssl_1.1.0f-3_amd64.deb ...
[   36.585889] 
[   36.596541] Unpacking openssl (1.1.0f-3) ...
[   36.596542] 
[   36.654395] Selecting previously unselected package ca-certificates.
[   36.654396] 
[   36.665595] Preparing to unpack .../ca-certificates_20161130+nmu1_all.deb ...
[   36.665596] 
[   36.677059] Unpacking ca-certificates (20161130+nmu1) ...
[   36.677060] 
[   36.686180] Setting up mime-support (3.60) ...
[   36.686181] 
[   36.702713] Setting up libexpat1:amd64 (2.2.3-1) ...
[   36.702714] 
[   36.711306] Setting up patch (2.7.5-1+b2) ...
[   36.711307] 
[   36.719212] Setting up perl-base (5.26.0-5) ...
[   36.719213] 
[   36.727487] Setting up liblocale-gettext-perl (1.07-3+b3) ...
[   36.737029] 
[   36.745816] Setting up debconf (1.5.63) ...
[   36.745817] 
[   37.056245] Setting up libtext-charwidth-perl (0.04-7+b7) ...
[   37.056249] 
[   37.066857] Setting up libtext-iconv-perl (1.7-5+b6) ...
[   37.066858] 
[   37.076424] Setting up libssl1.1:amd64 (1.1.0f-3) ...
[   37.076425] 
[   37.200912] Setting up openssl (1.1.0f-3) ...
[   37.200914] 
[   37.209947] Setting up ca-certificates (20161130+nmu1) ...
[   37.209948] 
[   40.922187] Setting up libexpat1-dev:amd64 (2.2.3-1) ...
[   40.922191] 
[   40.931235] Setting up libperl5.26:amd64 (5.26.0-5) ...
[   40.931237] 
[   40.939307] Setting up perl (5.26.0-5) ...
[   40.939309] 
[   40.948548] update-alternatives: using /usr/bin/prename to provide /usr/bin/rename (rename) in auto mode
[   40.948550] 
[   40.961435] Setting up gawk (1:4.1.4+dfsg-1) ...
[   40.961436] 
[   40.968962] Setting up libatomic1:amd64 (7.2.0-7) ...
[   40.968964] 
[   40.977013] Setting up libquadmath0:amd64 (7.2.0-7) ...
[   40.977014] 
[   40.985284] Processing triggers for libc-bin (2.23-5) ...
[   40.985286] 
[   40.993982] Processing triggers for ca-certificates (20161130+nmu1) ...
[   40.993983] 
[   41.003731] Updating certificates in /etc/ssl/certs...
[   41.003732] 
[   41.704252] 0 added, 0 removed; done.
[   41.704255] 
[   41.710989] Running hooks in /etc/ca-certificates/update.d...
[   41.710990] 
[   41.719232] done.
[   41.719233] 
[   47.834520] 29 Oct 16:09:03 ntpdate[4558]: step time server 192.168.1.1 offset 548.116267 sec
[   47.834523] 
[   47.849931] /lkp/lizhijian/src/bin/run-lkp
[   47.849933] 
[   47.870228] RESULT_ROOT=/result/perf-sanity-tests/defaults/lkp-hsw-ep4/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/1
[   47.870231] 
[   47.888651] Key type dns_resolver registered
[   47.892293] job=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml
[   47.892296] 
[   47.915174] NFS: Registering the id_resolver key type
[   47.920847] Key type id_resolver registered
[   47.925541] Key type id_legacy registered
[   52.831395] random: crng init done
[   55.516302] run-job /lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml
[   55.516305] 
[   55.568198] /usr/bin/curl -sSf http://inn:80/~lizhijian/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml&job_state=running -o /dev/null
[   55.568201] 
[   67.959987] IPMI Device Information
[   67.959991] 
[   68.091366] BMC ARP Control         : ARP Responses Enabled, Gratuitous ARP Disabled
[   68.091369] 
[   68.938561] 2017-10-29 16:09:24 make LLVM_CONFIG=/usr/bin/llvm-config-3.9 LIBCLANGLLVM=1 ARCH= -C /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf
[   68.938565] 
[   68.964848] make: Entering directory '/usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf'
[   68.964849] 
[   68.982531] 
[   68.992774]   HOSTCC   fixdep.o
[   68.992775] 
[   69.020187]   HOSTLD   fixdep-in.o
[   69.020189] 
[   69.027724]   LINK     fixdep
[   69.027725] 
[   71.935953] 
[   71.940363] Auto-detecting system features:
[   71.940366] 
[   71.949883] 
[   71.960393] 
[   71.970928] 
[   71.981395] 
[   71.991822] 
[   72.002197] 
[   72.012533] 
[   72.022787] 
[   72.027935] Makefile.config:533: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
[   72.027937] 
[   72.030152] Makefile.config:548: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
[   72.030153] 
[   72.031956] Makefile.config:562: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
[   72.031956] 
[   72.035454] Makefile.config:588: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
[   72.035455] 
[   72.097416] 
[   72.107174] 
[   72.116833] 
[   72.126428] 
[   72.135995] 
[   72.145537] 
[   72.155100] 
[   72.164590] 
[   72.174160] 
[   72.183655] 
[   72.193247] 
[   72.202254] 
[   72.255376] Makefile.config:802: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
[   72.255378] 
[   74.626970] make[3]: *** No rule to make target 'kernelversion'.  Stop.
[   74.626974] 
[   74.636704]   GEN      common-cmds.h
[   74.636708] 
[   74.646528]   PERF_VERSION = 
[   74.646530] 
[   74.769277]   CC       cpu.o
[   74.769281] 
[   74.777304]   CC       debug.o
[   74.777306] 
[   74.784390]   CC       fd/array.o
[   74.784391] 
[   74.791038]   CC       str_error_r.o
[   74.791040] 
[   74.797987]   CC       fs/fs.o
[   74.797988] 
[   74.805462]   CC       fs/tracing_path.o
[   74.805464] 
[   74.813609]   CC       exec-cmd.o
[   74.813611] 
[   74.820722]   CC       help.o
[   74.820724] 
[   74.824313] Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
[   74.824315] 
[   74.844649]   CC       pager.o
[   74.844652] 
[   74.851688]   CC       parse-options.o
[   74.851691] 
[   74.859664]   CC       run-command.o
[   74.859666] 
[   74.867184]   CC       sigchain.o
[   74.867187] 
[   74.874729]   CC       subcmd-config.o
[   74.874732] 
[   74.882720]   CC       event-parse.o
[   74.882722] 
[   74.890589]   CC       event-plugin.o
[   74.890592] 
[   74.898624]   CC       trace-seq.o
[   74.898627] 
[   74.906312]   CC       parse-filter.o
[   74.906315] 
[   74.914263]   CC       parse-utils.o
[   74.914265] 
[   74.921953]   CC       kbuffer-parse.o
[   74.921956] 
[   74.930044]   HOSTCC   pmu-events/json.o
[   74.930047] 
[   74.938000]   HOSTCC   pmu-events/jsmn.o
[   74.938022] 
[   74.946061]   HOSTCC   pmu-events/jevents.o
[   74.946064] 
[   74.954375]   CC       libbpf.o
[   74.954378] 
[   74.961435]   CC       bpf.o
[   74.961437] 
[   74.968116]   GEN      perf-archive
[   74.968119] 
[   74.975610]   LD       fd/libapi-in.o
[   74.975613] 
[   74.983251]   CC       plugin_jbd2.o
[   74.983254] 
[   74.990835]   GEN      perf-with-kcore
[   74.990837] 
[   74.998692]   CC       plugin_hrtimer.o
[   74.998695] 
[   75.006557]   CC       plugin_kmem.o
[   75.006560] 
[   75.014258]   CC       plugin_mac80211.o
[   75.014261] 
[   75.022195]   CC       plugin_kvm.o
[   75.022198] 
[   75.029696]   CC       plugin_function.o
[   75.029698] 
[   75.037522]   CC       plugin_sched_switch.o
[   75.037524] 
[   75.045736]   CC       plugin_xen.o
[   75.045738] 
[   75.053374]   CC       plugin_cfg80211.o
[   75.053377] 
[   75.061180]   CC       plugin_scsi.o
[   75.061182] 
[   75.068395]   CC       trace/beauty/clone.o
[   75.068397] 
[   75.076586]   CC       arch/common.o
[   75.076588] 
[   75.084205]   CC       ui/setup.o
[   75.084207] 
[   75.091684]   CC       trace/beauty/fcntl.o
[   75.091686] 
[   75.099931]   CC       trace/beauty/ioctl.o
[   75.099933] 
[   75.108105]   CC       util/annotate.o
[   75.108108] 
[   75.115796]   CC       ui/helpline.o
[   75.115798] 
[   75.124083]   CC       scripts/python/Perf-Trace-Util/Context.o
[   75.124085] 
[   75.134558]   CC       trace/beauty/pkey_alloc.o
[   75.134561] 
[   75.143374]   CC       ui/progress.o
[   75.143376] 
[   75.150964]   CC       trace/beauty/statx.o
[   75.150967] 
[   75.159559]   CC       util/block-range.o
[   75.159561] 
[   75.159988]   CC       ui/util.o
[   75.159990] 
[   75.160538]   CC       util/build-id.o
[   75.160540] 
[   75.160971]   CC       ui/hist.o
[   75.160973] 
[   75.161802]   CC       arch/x86/tests/regs_load.o
[   75.161804] 
[   75.162397]   CC       ui/stdio/hist.o
[   75.162398] 
[   75.163130]   CC       arch/x86/util/header.o
[   75.163132] 
[   75.163651]   CC       util/config.o
[   75.163653] 
[   75.164543]   CC       arch/x86/tests/dwarf-unwind.o
[   75.164544] 
[   75.165095]   LD       fs/libapi-in.o
[   75.165096] 
[   75.165738]   CC       arch/x86/util/tsc.o
[   75.165740] 
[   75.166260]   CC       util/ctype.o
[   75.166262] 
[   75.167123]   CC       arch/x86/tests/arch-tests.o
[   75.167125] 
[   75.167783]   CC       arch/x86/util/pmu.o
[   75.167785] 
[   75.168385]   CC       util/db-export.o
[   75.168387] 
[   75.169377]   CC       arch/x86/tests/perf-time-to-tsc.o
[   75.169379] 
[   75.169837]   CC       util/env.o
[   75.169839] 
[   75.170569]   CC       arch/x86/tests/rdpmc.o
[   75.170571] 
[   75.171335]   CC       arch/x86/util/kvm-stat.o
[   75.171337] 
[   75.171837]   CC       util/event.o
[   75.171839] 
[   75.172638]   CC       arch/x86/tests/insn-x86.o
[   75.172639] 
[   75.173435]   CC       arch/x86/util/perf_regs.o
[   75.173437] 
[   75.174263]   CC       arch/x86/tests/intel-cqm.o
[   75.174265] 
[   75.174789]   CC       util/evlist.o
[   75.174791] 
[   75.175369]   CC       util/find_bit.o
[   75.175371] 
[   75.175869]   CC       util/evsel.o
[   75.175870] 
[   75.176695]   CC       arch/x86/util/dwarf-regs.o
[   75.176697] 
[   75.177403]   CC       arch/x86/util/group.o
[   75.177404] 
[   75.177971]   CC       util/kallsyms.o
[   75.177973] 
[   75.178617]   CC       util/levenshtein.o
[   75.178618] 
[   75.179580]   CC       arch/x86/util/unwind-libunwind.o
[   75.179581] 
[   75.180352]   CC       arch/x86/util/auxtrace.o
[   75.180354] 
[   75.180989]   CC       util/llvm-utils.o
[   75.180991] 
[   75.181671]   CC       util/evsel_fprintf.o
[   75.181673] 
[   75.182252]   CC       builtin-bench.o
[   75.182254] 
[   75.182801]   CC       util/memswap.o
[   75.182802] 
[   75.183285]   LD       libapi-in.o
[   75.183286] 
[   75.183926]   CC       builtin-annotate.o
[   75.183927] 
[   75.184724]   BISON    util/parse-events-bison.c
[   75.184726] 
[   75.185318]   CC       builtin-config.o
[   75.185320] 
[   75.185737]   AR       libapi.a
[   75.185738] 
[   75.186290]   CC       builtin-diff.o
[   75.186291] 
[   75.186874]   CC       builtin-evlist.o
[   75.186876] 
[   75.187476]   CC       util/perf_regs.o
[   75.187478] 
[   75.188251]   CC       arch/x86/util/intel-pt.o
[   75.188253] 
[   75.188942]   LD       plugin_cfg80211-in.o
[   75.188943] 
[   75.189545]   LD       plugin_kmem-in.o
[   75.189546] 
[   75.190194]   LD       plugin_hrtimer-in.o
[   75.190196] 
[   75.190991]   CC       arch/x86/util/intel-bts.o
[   75.190992] 
[   75.191580]   LD       plugin_jbd2-in.o
[   75.191582] 
[   75.192150]   LD       plugin_xen-in.o
[   75.192151] 
[   75.192630]   CC       util/path.o
[   75.192632] 
[   75.193221]   CC       builtin-ftrace.o
[   75.193222] 
[   75.193763]   CC       builtin-help.o
[   75.193764] 
[   75.194401]   LINK     plugin_cfg80211.so
[   75.194402] 
[   75.195088]   LD       plugin_mac80211-in.o
[   75.195089] 
[   75.195746]   CC       util/print_binary.o
[   75.195747] 
[   75.196279]   CC       util/rbtree.o
[   75.196280] 
[   75.196949]   LD       plugin_function-in.o
[   75.196950] 
[   75.197541]   CC       util/libstring.o
[   75.197543] 
[   75.198327]   LD       plugin_sched_switch-in.o
[   75.198329] 
[   75.198856]   CC       util/bitmap.o
[   75.198858] 
[   75.199408]   LINK     plugin_jbd2.so
[   75.199410] 
[   75.199947]   CC       util/hweight.o
[   75.199949] 
[   75.200410]   CC       util/smt.o
[   75.200412] 
[   75.201190]   HOSTLD   pmu-events/jevents-in.o
[   75.201191] 
[   75.201779]   LD       plugin_kvm-in.o
[   75.201781] 
[   75.202377]   LD       plugin_scsi-in.o
[   75.202379] 
[   75.202915]   LINK     plugin_kmem.so
[   75.202917] 
[   75.203545]   LINK     plugin_hrtimer.so
[   75.203547] 
[   75.204116]   CC       builtin-sched.o
[   75.204117] 
[   75.204756]   LINK     plugin_mac80211.so
[   75.204758] 
[   75.205500]   LINK     plugin_sched_switch.so
[   75.205502] 
[   75.206035]   LINK     plugin_xen.so
[   75.206037] 
[   75.206665]   LINK     plugin_function.so
[   75.206666] 
[   75.207164]   CC       util/quote.o
[   75.207165] 
[   75.207681]   CC       util/strbuf.o
[   75.207683] 
[   75.208226]   LINK     plugin_scsi.so
[   75.208228] 
[   75.208748]   LINK     plugin_kvm.so
[   75.208750] 
[   75.209478]   CC       builtin-buildid-list.o
[   75.209480] 
[   75.210233]   CC       builtin-buildid-cache.o
[   75.210235] 
[   75.210756]   CC       util/string.o
[   75.210757] 
[   75.211310]   CC       util/strlist.o
[   75.211312] 
[   75.211899]   CC       util/strfilter.o
[   75.211901] 
[   75.212529]   CC       builtin-kallsyms.o
[   75.212531] 
[   75.212991]   CC       util/top.o
[   75.212993] 
[   75.213536]   CC       builtin-list.o
[   75.213538] 
[   75.214173]   LINK     pmu-events/jevents
[   75.214174] 
[   75.214753]   CC       builtin-record.o
[   75.214755] 
[   75.215260]   CC       util/usage.o
[   75.215261] 
[   75.215723]   CC       util/dso.o
[   75.215725] 
[   75.216313]   CC       builtin-report.o
[   75.216315] 
[   75.216834]   CC       util/symbol.o
[   75.216836] 
[   75.217646]   LD       trace/beauty/libperf-in.o
[   75.217648] 
[   75.218358]   CC       util/symbol_fprintf.o
[   75.218360] 
[   75.218860]   CC       util/color.o
[   75.218862] 
[   75.219410]   CC       builtin-stat.o
[   75.219412] 
[   75.220068]   CC       builtin-timechart.o
[   75.220070] 
[   75.220589]   CC       builtin-top.o
[   75.220590] 
[   75.221117]   CC       util/header.o
[   75.221119] 
[   75.221709]   CC       util/callchain.o
[   75.221711] 
[   75.222264]   CC       builtin-kmem.o
[   75.222266] 
[   75.222853]   CC       builtin-script.o
[   75.222855] 
[   75.223380]   CC       util/values.o
[   75.223382] 
[   75.223923]   CC       builtin-lock.o
[   75.223925] 
[   75.224430]   CC       util/debug.o
[   75.224431] 
[   75.224951]   CC       builtin-kvm.o
[   75.224952] 
[   75.225511]   CC       util/machine.o
[   75.225512] 
[   75.225970]   CC       util/map.o
[   75.225972] 
[   75.226501]   CC       builtin-inject.o
[   75.226502] 
[   75.226991]   CC       util/pstack.o
[   75.226992] 
[   75.227487]   CC       builtin-mem.o
[   75.227489] 
[   75.228317]   GEN      libtraceevent-dynamic-list
[   75.228319] 
[   75.228856]   CC       builtin-data.o
[   75.228858] 
[   75.229343]   LD       libbpf-in.o
[   75.229344] 
[   75.229752]   LINK     libbpf.a
[   75.229753] 
[   75.230293]   CC       util/session.o
[   75.230295] 
[   75.230904]   CC       builtin-version.o
[   75.230906] 
[   75.231435]   CC       builtin-c2c.o
[   75.231437] 
[   75.231997]   CC       builtin-trace.o
[   75.231999] 
[   75.232635]   CC       util/syscalltbl.o
[   75.232637] 
[   75.233206]   CC       builtin-probe.o
[   75.233208] 
[   75.233963]   GEN      pmu-events/pmu-events.c
[   75.233965] 
[   75.235208]   LD       scripts/python/Perf-Trace-Util/libperf-in.o
[   75.235210] 
[   75.235914]   CC       util/ordered-events.o
[   75.235915] 
[   75.236630]   LD       scripts/libperf-in.o
[   75.236632] 
[   75.237258]   CC       util/namespaces.o
[   75.237260] 
[   75.237738]   CC       util/comm.o
[   75.237740] 
[   75.238499]   CC       bench/sched-messaging.o
[   75.238501] 
[   75.239181]   CC       tests/builtin-test.o
[   75.239183] 
[   75.239858]   CC       tests/parse-events.o
[   75.239860] 
[   75.240488]   CC       bench/sched-pipe.o
[   75.240490] 
[   75.240863]   CC       perf.o
[   75.240865] 
[   75.241562]   CC       bench/mem-functions.o
[   75.241564] 
[   75.242094]   CC       util/thread.o
[   75.242096] 
[   75.242688]   CC       tests/dso-data.o
[   75.242689] 
[   75.243327]   CC       bench/futex-hash.o
[   75.243329] 
[   75.243832]   CC       tests/attr.o
[   75.243834] 
[   75.245615]   CC       bench/futex-wake-parallel.o
[   75.245617] 
[   75.254445]   CC       bench/futex-wake.o
[   75.254449] 
[   75.256371]   LD       arch/x86/tests/libperf-in.o
[   75.256373] 
[   75.257464]   CC       bench/futex-requeue.o
[   75.257466] 
[   75.260898]   CC       util/thread_map.o
[   75.260901] 
[   75.262974]   CC       tests/vmlinux-kallsyms.o
[   75.262976] 
[   75.264675]   CC       pmu-events/pmu-events.o
[   75.264677] 
[   75.274068]   CC       tests/openat-syscall.o
[   75.274071] 
[   75.283776]   CC       tests/openat-syscall-all-cpus.o
[   75.283779] 
[   75.284506]   CC       util/trace-event-parse.o
[   75.284508] 
[   75.289693]   CC       bench/futex-lock-pi.o
[   75.289695] 
[   75.307183]   CC       util/parse-events-bison.o
[   75.307187] 
[   75.318990]   CC       tests/openat-syscall-tp-fields.o
[   75.318993] 
[   75.319655]   CC       tests/mmap-basic.o
[   75.319656] 
[   75.320596]   CC       tests/perf-record.o
[   75.320598] 
[   75.323582]   CC       tests/evsel-roundtrip-name.o
[   75.323584] 
[   75.324285]   CC       tests/evsel-tp-sched.o
[   75.324287] 
[   75.365552]   CC       bench/mem-memcpy-x86-64-asm.o
[   75.365555] 
[   75.380023]   CC       bench/mem-memset-x86-64-asm.o
[   75.380025] 
[   75.387586]   CC       bench/numa.o
[   75.387587] 
[   75.389089]   CC       util/trace-event-read.o
[   75.389091] 
[   75.389419]   BISON    util/pmu-bison.c
[   75.389420] 
[   75.410372]   CC       tests/fdarray.o
[   75.410375] 
[   75.417821]   CC       util/trace-event-info.o
[   75.417824] 
[   75.426533]   CC       tests/pmu.o
[   75.426536] 
[   75.428404]   CC       tests/hists_common.o
[   75.428406] 
[   75.436889]   CC       tests/hists_filter.o
[   75.436892] 
[   75.438215]   CC       tests/hists_link.o
[   75.438217] 
[   75.447317]   CC       tests/hists_cumulate.o
[   75.447320] 
[   75.448201]   CC       tests/python-use.o
[   75.448203] 
[   75.456618]   CC       tests/hists_output.o
[   75.456620] 
[   75.461449]   CC       tests/bp_signal.o
[   75.461451] 
[   75.485175]   LD       libsubcmd-in.o
[   75.485178] 
[   75.496013]   CC       tests/bp_signal_overflow.o
[   75.496016] 
[   75.501716]   AR       libsubcmd.a
[   75.501719] 
[   75.502665]   CC       util/trace-event-scripting.o
[   75.502667] 
[   75.503464]   CC       tests/task-exit.o
[   75.503466] 
[   75.507447]   CC       util/sort.o
[   75.507449] 
[   75.508511]   CC       util/svghelper.o
[   75.508513] 
[   75.509124]   CC       util/trace-event.o
[   75.509126] 
[   75.509582]   CC       util/hist.o
[   75.509583] 
[   75.511292]   CC       util/util.o
[   75.511294] 
[   75.530675]   LD       libtraceevent-in.o
[   75.530679] 
[   75.538139]   CC       util/xyarray.o
[   75.538143] 
[   75.542319]   CC       tests/sw-clock.o
[   75.542321] 
[   75.548724]   CC       util/cpumap.o
[   75.548727] 
[   75.549351]   CC       util/cgroup.o
[   75.549353] 
[   75.550494]   LINK     libtraceevent.a
[   75.550496] 
[   75.552358]   CC       util/target.o
[   75.552360] 
[   75.567429]   CC       tests/mmap-thread-lookup.o
[   75.567432] 
[   75.575076]   CC       tests/thread-mg-share.o
[   75.575079] 
[   75.578918]   CC       util/rblist.o
[   75.578922] 
[   75.582269]   CC       util/intlist.o
[   75.582273] 
[   75.594786]   CC       tests/switch-tracking.o
[   75.594790] 
[   75.598361]   GEN      python/perf.so
[   75.598363] 
[   75.609311]   CC       tests/keep-tracking.o
[   75.609315] 
[   75.627791]   CC       util/vdso.o
[   75.627794] 
[   75.637055]   CC       util/counts.o
[   75.637059] 
[   75.656394]   CC       tests/code-reading.o
[   75.656398] 
[   75.658090]   CC       tests/sample-parsing.o
[   75.658092] 
[   75.659427]   LD       arch/x86/util/libperf-in.o
[   75.659430] 
[   75.659900]   CC       util/stat.o
[   75.659902] 
[   75.661356]   CC       util/stat-shadow.o
[   75.661358] 
[   75.663436]   CC       tests/parse-no-sample-id-all.o
[   75.663438] 
[   75.672434]   CC       tests/kmod-path.o
[   75.672437] 
[   75.676904]   CC       tests/thread-map.o
[   75.676907] 
[   75.686666]   LD       arch/x86/libperf-in.o
[   75.686669] 
[   75.688676]   CC       tests/llvm.o
[   75.688678] 
[   75.691643]   CC       util/record.o
[   75.691646] 
[   75.695882]   CC       util/srcline.o
[   75.695885] 
[   75.698573]   CC       util/data.o
[   75.698576] 
[   75.708021]   LD       arch/libperf-in.o
[   75.708024] 
[   75.710417]   CC       tests/bpf.o
[   75.710419] 
[   75.711343]   CC       util/tsc.o
[   75.711345] 
[   75.712247]   CC       util/cloexec.o
[   75.712249] 
[   75.713621]   CC       tests/topology.o
[   75.713623] 
[   75.717099]   CC       tests/mem.o
[   75.717101] 
[   75.717711]   CC       util/call-path.o
[   75.717713] 
[   75.723635]   CC       util/thread-stack.o
[   75.723637] 
[   75.728356]   CC       util/auxtrace.o
[   75.728359] 
[   75.745097]   CC       util/scripting-engines/trace-event-python.o
[   75.745100] 
[   75.746413]   CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
[   75.746415] 
[   75.748960]   CC       tests/cpumap.o
[   75.748962] 
[   75.750288]   CC       util/intel-pt.o
[   75.750290] 
[   75.751626]   CXX      util/c++/clang.o
[   75.751629] 
[   75.763551]   CC       util/intel-bts.o
[   75.763554] 
[   75.774611]   GEN      util/intel-pt-decoder/inat-tables.c
[   75.774615] 
[   75.795083]   CC       util/intel-pt-decoder/intel-pt-log.o
[   75.795087] 
[   75.799326]   CC       util/parse-branch-options.o
[   75.799328] 
[   75.814708]   LD       pmu-events/pmu-events-in.o
[   75.814711] 
[   75.831159]   CC       util/dump-insn.o
[   75.831163] 
[   75.835328]   CC       util/parse-regs-options.o
[   75.835331] 
[   75.871237]   CC       tests/event_update.o
[   75.871239] 
[   75.875540]   CC       tests/stat.o
[   75.875544] 
[   75.877595]   CC       util/help-unknown-cmd.o
[   75.877597] 
[   75.880118]   CC       util/term.o
[   75.880119] 
[   75.888174]   CC       util/mem-events.o
[   75.888177] 
[   75.894396]   CXX      util/c++/clang-test.o
[   75.894399] 
[   75.895098]   CC       tests/event-times.o
[   75.895099] 
[   75.896815]   CC       util/intel-pt-decoder/intel-pt-decoder.o
[   75.896817] 
[   75.898210]   CC       tests/expr.o
[   75.898212] 
[   75.899670]   CC       util/vsprintf.o
[   75.899672] 
[   75.908602]   CC       tests/backward-ring-buffer.o
[   75.908605] 
[   75.911015]   CC       util/drv_configs.o
[   75.911017] 
[   75.911518]   CC       util/units.o
[   75.911519] 
[   75.915347]   CC       util/time-utils.o
[   75.915348] 
[   75.916051]   BISON    util/expr-bison.c
[   75.916052] 
[   75.945408]   CC       util/branch.o
[   75.945413] 
[   75.946934]   CC       tests/sdt.o
[   75.946936] 
[   75.956590]   CC       tests/is_printable_array.o
[   75.956593] 
[   75.965715]   CC       util/bpf-prologue.o
[   75.965719] 
[   75.967258]   CC       util/symbol-elf.o
[   75.967261] 
[   75.967865]   CC       tests/perf-hooks.o
[   75.967867] 
[   75.968839]   CC       util/bpf-loader.o
[   75.968840] 
[   75.969385]   CC       tests/bitmap.o
[   75.969386] 
[   75.990419]   CC       tests/clang.o
[   75.990423] 
[   75.992694]   CC       tests/unit_number__scnprintf.o
[   75.992697] 
[   75.995345]   CC       tests/dwarf-unwind.o
[   75.995347] 
[   75.995966]   CC       util/probe-file.o
[   75.995968] 
[   76.018084]   CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
[   76.018087] 
[   76.018788]   CC       util/probe-event.o
[   76.018790] 
[   76.021752]   CC       tests/llvm-src-base.o
[   76.021755] 
[   76.023557]   CC       tests/llvm-src-kbuild.o
[   76.023559] 
[   76.035060]   CC       tests/llvm-src-prologue.o
[   76.035063] 
[   76.035931]   CC       tests/llvm-src-relocation.o
[   76.035932] 
[   76.037936]   CC       util/probe-finder.o
[   76.037938] 
[   76.045473]   CC       util/dwarf-aux.o
[   76.045476] 
[   76.048277]   CC       util/dwarf-regs.o
[   76.048280] 
[   76.049869]   CC       util/unwind-libunwind-local.o
[   76.049871] 
[   76.051732]   CC       util/unwind-libunwind.o
[   76.051734] 
[   76.056257]   CC       util/zlib.o
[   76.056261] 
[   76.063359]   CC       util/lzma.o
[   76.063363] 
[   76.066806]   CC       util/demangle-java.o
[   76.066808] 
[   76.068280]   CC       util/demangle-rust.o
[   76.068281] 
[   76.079953]   CC       util/jitdump.o
[   76.079956] 
[   76.080503]   CC       util/genelf.o
[   76.080505] 
[   76.082424]   CC       util/genelf_debug.o
[   76.082426] 
[   76.086886]   CC       util/perf-hooks.o
[   76.086889] 
[   76.089730]   FLEX     util/parse-events-flex.c
[   76.089734] 
[   76.106232]   FLEX     util/pmu-flex.c
[   76.106235] 
[   76.110610]   CC       util/expr-bison.o
[   76.110612] 
[   76.116478]   CC       util/pmu-bison.o
[   76.116481] 
[   76.138208]   CC       util/pmu-flex.o
[   76.138220] 
[   76.141818]   CC       util/pmu.o
[   76.141821] 
[   76.153010]   CC       util/parse-events-flex.o
[   76.153013] 
[   76.153641]   CC       util/parse-events.o
[   76.153642] 
[   76.552199]   LD       bench/perf-in.o
[   76.552201] 
[   76.572201]   LD       tests/perf-in.o
[   76.572204] 
[   76.608097]   LD       util/scripting-engines/libperf-in.o
[   76.608099] 
[   76.624613]   LD       ui/libperf-in.o
[   76.624617] 
[   76.944792] In file included from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:5:0,
[   76.944796] 
[   76.949172]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/namespaces.h:13,
[   76.949174] 
[   76.950906]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util.h:15,
[   76.950907] 
[   76.952662]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util-cxx.h:20,
[   76.952663] 
[   76.953210]                  from util/c++/clang-c.h:5,
[   76.953211] 
[   76.953798]                  from util/c++/clang-test.cpp:2:
[   76.953798] 
[   76.957542] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h: In function 'void list_del(list_head*)':
[   76.957543] 
[   76.966138] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   76.966139] 
[   76.966916]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   76.966917] 
[   76.967428]                                        ^
[   76.967429] 
[   76.969497] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:107:16: note: in expansion of macro 'LIST_POISON1'
[   76.969498] 
[   76.969840]   entry->next = LIST_POISON1;
[   76.969841] 
[   76.970198]                 ^~~~~~~~~~~~
[   76.970199] 
[   76.972906] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:61: error: invalid conversion from 'void*' to 'list_head*' [-fpermissive]
[   76.972907] 
[   76.973705]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   76.973706] 
[   76.974488]                                                              ^
[   76.974489] 
[   76.976570] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:107:16: note: in expansion of macro 'LIST_POISON1'
[   76.976571] 
[   76.976906]   entry->next = LIST_POISON1;
[   76.976907] 
[   76.977272]                 ^~~~~~~~~~~~
[   76.977272] 
[   76.979952] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   76.979953] 
[   76.980112]   LD       util/intel-pt-decoder/libperf-in.o
[   76.980114] 
[   76.980731]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   76.980731] 
[   76.981238]                                        ^
[   76.981238] 
[   76.983283] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:108:16: note: in expansion of macro 'LIST_POISON2'
[   76.983284] 
[   76.983648]   entry->prev = LIST_POISON2;
[   76.983648] 
[   76.983985]                 ^~~~~~~~~~~~
[   76.983986] 
[   76.986571] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:61: error: invalid conversion from 'void*' to 'list_head*' [-fpermissive]
[   76.986572] 
[   76.987349]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   76.987349] 
[   76.988145]                                                              ^
[   76.988145] 
[   76.990209] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:108:16: note: in expansion of macro 'LIST_POISON2'
[   76.990210] 
[   76.990559]   entry->prev = LIST_POISON2;
[   76.990560] 
[   76.990896]                 ^~~~~~~~~~~~
[   76.990896] 
[   76.992872] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h: In function 'void hlist_del(hlist_node*)':
[   76.992873] 
[   76.995486] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   76.995487] 
[   76.996274]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   76.996274] 
[   76.996745]                                        ^
[   76.996746] 
[   76.998743] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:626:12: note: in expansion of macro 'LIST_POISON1'
[   76.998745] 
[   76.999049]   n->next = LIST_POISON1;
[   76.999049] 
[   76.999348]             ^~~~~~~~~~~~
[   76.999348] 
[   77.001922] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:61: error: invalid conversion from 'void*' to 'hlist_node*' [-fpermissive]
[   77.001923] 
[   77.002701]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   77.002702] 
[   77.003492]                                                              ^
[   77.003492] 
[   77.005566] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:626:12: note: in expansion of macro 'LIST_POISON1'
[   77.005567] 
[   77.005849]   n->next = LIST_POISON1;
[   77.005849] 
[   77.006141]             ^~~~~~~~~~~~
[   77.006141] 
[   77.008708] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   77.008709] 
[   77.009493]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   77.009494] 
[   77.009968]                                        ^
[   77.009968] 
[   77.012066] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:627:13: note: in expansion of macro 'LIST_POISON2'
[   77.012067] 
[   77.012391]   n->pprev = LIST_POISON2;
[   77.012391] 
[   77.012669]              ^~~~~~~~~~~~
[   77.012669] 
[   77.015354] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:61: error: invalid conversion from 'void*' to 'hlist_node**' [-fpermissive]
[   77.015355] 
[   77.016100]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   77.016101] 
[   77.016844]                                                              ^
[   77.016845] 
[   77.018962] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:627:13: note: in expansion of macro 'LIST_POISON2'
[   77.018963] 
[   77.019292]   n->pprev = LIST_POISON2;
[   77.019293] 
[   77.019592]              ^~~~~~~~~~~~
[   77.019593] 
[   77.021232] In file included from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util.h:13:0,
[   77.021233] 
[   77.022895]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util-cxx.h:20,
[   77.022896] 
[   77.023476]                  from util/c++/clang-c.h:5,
[   77.023476] 
[   77.024073]                  from util/c++/clang-test.cpp:2:
[   77.024074] 
[   77.026651] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h: In function 'int atomic_read(const atomic_t*)':
[   77.026652] 
[   77.033841] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:45: error: use of deleted function 'atomic_read(const atomic_t*)::<unnamed union>::<constructor>()'
[   77.033842] 
[   77.035368]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   77.035369] 
[   77.035930]                                              ^
[   77.035930] 
[   77.038426] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   77.038427] 
[   77.038805]   return READ_ONCE((v)->counter);
[   77.038806] 
[   77.039013]          ^~~~~~~~~
[   77.039014] 
[   77.053480] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:11: note: 'atomic_read(const atomic_t*)::<unnamed union>::<constructor>()' is implicitly deleted because the default definition would be ill-formed:
[   77.053482] 
[   77.054841]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   77.054842] 
[   77.054978]            ^
[   77.054979] 
[   77.057300] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   77.057301] 
[   77.057677]   return READ_ONCE((v)->counter);
[   77.057677] 
[   77.057882]          ^~~~~~~~~
[   77.057882] 
[   77.060770] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:11: error: uninitialized const member in 'union atomic_read(const atomic_t*)::<unnamed>'
[   77.060771] 
[   77.062152]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   77.062153] 
[   77.062304]            ^
[   77.062305] 
[   77.064680] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   77.064681] 
[   77.065062]   return READ_ONCE((v)->counter);
[   77.065063] 
[   77.065284]          ^~~~~~~~~
[   77.065285] 
[   77.068062] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:23: note: 'const int atomic_read(const atomic_t*)::<unnamed union>::__val' should be initialized
[   77.068063] 
[   77.069407]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   77.069408] 
[   77.069662]                        ^
[   77.069663] 
[   77.072058] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   77.072059] 
[   77.072464]   return READ_ONCE((v)->counter);
[   77.072465] 
[   77.072662]          ^~~~~~~~~
[   77.072663] 
[   77.085424]   LD       perf-in.o
[   77.085427] 
[   77.172323] cc1plus: all warnings being treated as errors
[   77.172327] 
[   77.184037] mv: cannot stat 'util/c++/.clang-test.o.tmp': No such file or directory
[   77.184040] 
[   77.185321] make[5]: *** [util/c++/clang-test.o] Error 1
[   77.185323] 
[   77.186603] make[5]: *** Waiting for unfinished jobs....
[   77.186604] 
[   77.187370] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/build/Makefile.build:99: recipe for target 'util/c++/clang-test.o' failed
[   77.187374] 
[   78.728065] In file included from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:5:0,
[   78.728069] 
[   78.749287]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/namespaces.h:13,
[   78.749289] 
[   78.768551]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util.h:15,
[   78.768552] 
[   78.787201]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util-cxx.h:20,
[   78.787202] 
[   78.805153]                  from util/c++/clang-c.h:5,
[   78.805155] 
[   78.814213]                  from util/c++/clang.cpp:28:
[   78.814214] 
[   78.824752] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h: In function 'void list_del(list_head*)':
[   78.824754] 
[   78.846316] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   78.846318] 
[   78.870124]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   78.870125] 
[   78.881041]                                        ^
[   78.881042] 
[   78.891112] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:107:16: note: in expansion of macro 'LIST_POISON1'
[   78.891114] 
[   78.911587]   entry->next = LIST_POISON1;
[   78.911588] 
[   78.912123]                 ^~~~~~~~~~~~
[   78.912124] 
[   78.916374] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:61: error: invalid conversion from 'void*' to 'list_head*' [-fpermissive]
[   78.916375] 
[   78.917593]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   78.917594] 
[   78.918824]                                                              ^
[   78.918825] 
[   78.922156] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:107:16: note: in expansion of macro 'LIST_POISON1'
[   78.922157] 
[   78.922775]   entry->next = LIST_POISON1;
[   78.922775] 
[   78.923289]                 ^~~~~~~~~~~~
[   78.923290] 
[   78.927789] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   78.927790] 
[   78.929135]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   78.929136] 
[   78.929946]                                        ^
[   78.929947] 
[   78.933351] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:108:16: note: in expansion of macro 'LIST_POISON2'
[   78.933352] 
[   78.933659]   entry->prev = LIST_POISON2;
[   78.933660] 
[   78.933954]                 ^~~~~~~~~~~~
[   78.933955] 
[   78.936368] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:61: error: invalid conversion from 'void*' to 'list_head*' [-fpermissive]
[   78.936369] 
[   78.937021]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   78.937022] 
[   78.937703]                                                              ^
[   78.937703] 
[   78.939579] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:108:16: note: in expansion of macro 'LIST_POISON2'
[   78.939580] 
[   78.939875]   entry->prev = LIST_POISON2;
[   78.939876] 
[   78.940196]                 ^~~~~~~~~~~~
[   78.940197] 
[   78.942078] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h: In function 'void hlist_del(hlist_node*)':
[   78.942079] 
[   78.944466] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   78.944467] 
[   78.945163]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   78.945164] 
[   78.945594]                                        ^
[   78.945595] 
[   78.947429] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:626:12: note: in expansion of macro 'LIST_POISON1'
[   78.947430] 
[   78.947688]   n->next = LIST_POISON1;
[   78.947688] 
[   78.947942]             ^~~~~~~~~~~~
[   78.947943] 
[   78.950328] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:22:61: error: invalid conversion from 'void*' to 'hlist_node*' [-fpermissive]
[   78.950329] 
[   78.951049]  #define LIST_POISON1  ((void *) 0x100 + POISON_POINTER_DELTA)
[   78.951050] 
[   78.951718]                                                              ^
[   78.951719] 
[   78.953757] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:626:12: note: in expansion of macro 'LIST_POISON1'
[   78.953759] 
[   78.954037]   n->next = LIST_POISON1;
[   78.954038] 
[   78.954289]             ^~~~~~~~~~~~
[   78.954290] 
[   78.956720] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:39: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
[   78.956721] 
[   78.957419]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   78.957420] 
[   78.957851]                                        ^
[   78.957852] 
[   78.959870] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:627:13: note: in expansion of macro 'LIST_POISON2'
[   78.959870] 
[   78.960162]   n->pprev = LIST_POISON2;
[   78.960163] 
[   78.960442]              ^~~~~~~~~~~~
[   78.960443] 
[   78.962808] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/poison.h:23:61: error: invalid conversion from 'void*' to 'hlist_node**' [-fpermissive]
[   78.962809] 
[   78.963529]  #define LIST_POISON2  ((void *) 0x200 + POISON_POINTER_DELTA)
[   78.963530] 
[   78.964225]                                                              ^
[   78.964226] 
[   78.966259] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/list.h:627:13: note: in expansion of macro 'LIST_POISON2'
[   78.966260] 
[   78.966545]   n->pprev = LIST_POISON2;
[   78.966546] 
[   78.966809]              ^~~~~~~~~~~~
[   78.966810] 
[   78.968300] In file included from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util.h:13:0,
[   78.968301] 
[   78.969929]                  from /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf/util/util-cxx.h:20,
[   78.969930] 
[   78.970430]                  from util/c++/clang-c.h:5,
[   78.970431] 
[   78.970907]                  from util/c++/clang.cpp:28:
[   78.970908] 
[   78.973267] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h: In function 'int atomic_read(const atomic_t*)':
[   78.973268] 
[   78.976366] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:45: error: use of deleted function 'atomic_read(const atomic_t*)::<unnamed union>::<constructor>()'
[   78.976368] 
[   78.977673]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   78.977674] 
[   78.978189]                                              ^
[   78.978190] 
[   78.980438] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   78.980439] 
[   78.980784]   return READ_ONCE((v)->counter);
[   78.980785] 
[   78.980975]          ^~~~~~~~~
[   78.980976] 
[   78.984949] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:11: note: 'atomic_read(const atomic_t*)::<unnamed union>::<constructor>()' is implicitly deleted because the default definition would be ill-formed:
[   78.984950] 
[   78.986281]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   78.986282] 
[   78.986424]            ^
[   78.986425] 
[   78.988738] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   78.988738] 
[   78.989096]   return READ_ONCE((v)->counter);
[   78.989097] 
[   78.989286]          ^~~~~~~~~
[   78.989287] 
[   78.991848] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:11: error: uninitialized const member in 'union atomic_read(const atomic_t*)::<unnamed>'
[   78.991849] 
[   78.993143]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   78.993143] 
[   78.993274]            ^
[   78.993274] 
[   78.995575] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   78.995576] 
[   78.995928]   return READ_ONCE((v)->counter);
[   78.995929] 
[   78.996135]          ^~~~~~~~~
[   78.996135] 
[   78.998966] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/linux/compiler.h:157:23: note: 'const int atomic_read(const atomic_t*)::<unnamed union>::__val' should be initialized
[   78.998967] 
[   79.000323]   ({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
[   79.000324] 
[   79.000586]                        ^
[   79.000587] 
[   79.003003] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/include/asm/../../arch/x86/include/asm/atomic.h:27:9: note: in expansion of macro 'READ_ONCE'
[   79.003004] 
[   79.003380]   return READ_ONCE((v)->counter);
[   79.003380] 
[   79.003570]          ^~~~~~~~~
[   79.003571] 
[   80.009672] cc1plus: all warnings being treated as errors
[   80.009674] 
[   80.030851] mv: cannot stat 'util/c++/.clang.o.tmp': No such file or directory
[   80.030854] 
[   80.036069] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/build/Makefile.build:99: recipe for target 'util/c++/clang.o' failed
[   80.036072] 
[   80.041120] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/build/Makefile.build:138: recipe for target 'c++' failed
[   80.041122] 
[   80.043561] /usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/build/Makefile.build:138: recipe for target 'util' failed
[   80.043562] 
[   80.044216] Makefile.perf:595: recipe for target 'libperf-in.o' failed
[   80.044217] 
[   80.109988] make[5]: *** [util/c++/clang.o] Error 1
[   80.109989] 
[   80.118568] make[4]: *** [c++] Error 2
[   80.118569] 
[   80.125999] make[3]: *** [util] Error 2
[   80.126000] 
[   80.133530] make[2]: *** [libperf-in.o] Error 2
[   80.133531] 
[   80.141893] make[2]: *** Waiting for unfinished jobs....
[   80.141894] 
[   80.676757] make[1]: *** [sub-make] Error 2
[   80.676771] 
[   80.677264] Makefile.perf:209: recipe for target 'sub-make' failed
[   80.677266] 
[   80.678199] Makefile:68: recipe for target 'all' failed
[   80.678200] 
[   80.681127] make: Leaving directory '/usr/src/linux-perf-x86_64-rhel-7.2-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/tools/perf'
[   80.681129] 
[   80.718817] make: *** [all] Error 2
[   80.718818] 
[   80.725804] make perf failed
[   80.725805] 
[   80.732299]   /lkp/lizhijian/src/lib/debug.sh:7: die
[   80.732301] 
[   80.741255]   /lkp/lizhijian/src/tests/perf-sanity-tests:80: main
[   80.741256] 
[   80.750840]   :0: 
[   80.750841] 
[   81.699784] kill 4615 vmstat --timestamp -n 10 
[   81.699788] 
[   81.710080] kill 4613 dmesg --follow --decode 
[   81.710082] 
[   81.718947] wait for background monitors: 4618 oom-killer
[   81.718949] 
[   86.699922] /usr/bin/curl -sSf http://inn:80/~lizhijian/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml&loadavg=5.58%201.38%200.46%201/624%207888&start_time=1509264564&end_time=1509264576&version=/lkp/lizhijian/.src-20171027-145642& -o /dev/null
[   86.699925] 
[  103.790318] /usr/bin/curl -sSf http://inn:80/~lizhijian/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml&job_state=incomplete -o /dev/null
[  103.790320] 
[  133.879175] /usr/bin/curl -sSf http://inn:80/~lizhijian/cgi-bin/lkp-post-run?job_file=/lkp/scheduled/lkp-hsw-ep4/perf-sanity-tests-defaults-debian-x86_64-2016-08-31.cgz-3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f-20171029-69014-181lmno-0.yaml -o /dev/null
[  133.879179] 
[  140.319352] getting new job...
[  140.319357] 
[  140.337284] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?hostname=lkp-hsw-ep4&mac=00:1e:67:f7:44:b3&last_kernel=/pkg/linux/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/vmlinuz-4.14.0-rc6-00162-g3d6dabc2&lkp_wtmp -o /tmp/next-job-lkp
[  140.337287] 
[  173.614922] /usr/bin/curl -sSf http://inn:80/~lkp//lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%25-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.cgz -o /tmp/next-job.cgz
[  173.614927] 
[  173.886353] 24 blocks
[  173.886357] 
[  173.912961] downloading kernel image ...
[  173.912964] 
[  173.927243] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%25-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.yaml&job_state=wget_kernel -o /dev/null
[  173.927245] 
[  176.066561] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/vmlinuz-4.14.0-rc6 -o /tmp/cache/pkg/linux/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/vmlinuz-4.14.0-rc6
[  176.066564] 
[  176.151232] downloading initrds ...
[  176.151234] 
[  176.166491] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%25-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.yaml&job_state=wget_initrd -o /dev/null
[  176.166493] 
[  179.043933] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/debian/debian-x86_64-2016-08-31.cgz -o /tmp/cache/osimage/debian/debian-x86_64-2016-08-31.cgz
[  179.043937] 
[  180.360231] /usr/bin/curl -sSf http://inn:80/~lkp/lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%25-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.cgz -o /tmp/cache/lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.cgz
[  180.360236] 
[  180.402960] /usr/bin/curl -sSf http://inn:80/~lkp/lkp/lkp/lkp-x86_64.cgz -o /tmp/cache/lkp/lkp/lkp-x86_64.cgz
[  180.402962] 
[  180.421384] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-08-01.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/lkp_2017-08-01.cgz
[  180.421386] 
[  180.792078] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz
[  180.792082] 
[  180.833312] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz
[  180.833315] 
[  180.873144] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/will-it-scale_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/will-it-scale_2016-11-15.cgz
[  180.873148] 
[  181.017276] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/pkg/debian-x86_64-2016-08-31.cgz/will-it-scale-x86_64_2016-09-02.cgz -o /tmp/cache/osimage/pkg/debian-x86_64-2016-08-31.cgz/will-it-scale-x86_64_2016-09-02.cgz
[  181.017280] 
[  181.050255] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/iostat_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/iostat_2016-11-15.cgz
[  181.050257] 
[  181.078494] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/turbostat_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/turbostat_2016-11-15.cgz
[  181.078496] 
[  181.107860] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/pkg/debian-x86_64-2016-08-31.cgz/turbostat-x86_64-d5256b2_2017-06-20.cgz -o /tmp/cache/osimage/pkg/debian-x86_64-2016-08-31.cgz/turbostat-x86_64-d5256b2_2017-06-20.cgz
[  181.107862] 
[  181.138771] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/perf_2017-10-01.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/perf_2017-10-01.cgz
[  181.138773] 
[  181.374625] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/pkg/debian-x86_64-2016-08-31.cgz/perf-x86_64-a8c964eacb21_2017-10-01.cgz -o /tmp/cache/osimage/pkg/debian-x86_64-2016-08-31.cgz/perf-x86_64-a8c964eacb21_2017-10-01.cgz
[  181.374629] 
[  181.415789] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x86_64-2016-08-31.cgz/hw_2016-11-15.cgz -o /tmp/cache/osimage/deps/debian-x86_64-2016-08-31.cgz/hw_2016-11-15.cgz
[  181.415792] 
[  181.536816] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/modules.cgz -o /tmp/cache/pkg/linux/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/modules.cgz
[  181.536820] 
[  181.795978] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/linux-perf.cgz -o /tmp/cache/pkg/linux/x86_64-rhel-7.2/gcc-6/3d6dabc2c8b475c40d8f4a8b5da8c5d71b2fa13f/linux-perf.cgz
[  181.795982] 
[  182.332617] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%25-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.yaml&job_state=booting -o /dev/null
[  182.332621] 
[  184.201412] LKP: kexec loading...
[  184.201417] 
[  184.218434] kexec --noefi -l /tmp/cache/pkg/linux/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/vmlinuz-4.14.0-rc6 --initrd=/tmp/cache/initrd-concatenated
[  184.218439] 
[  185.775505] --append=ip=::::lkp-hsw-ep4::dhcp root=/dev/ram0 user=lkp job=/lkp/scheduled/lkp-hsw-ep4/will-it-scale-100%-thread-writeseek1-performance-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20171002-6004-1575yyc-0.yaml ARCH=x86_64 kconfig=x86_64-rhel-7.2 branch=linux-devel/devel-hourly-2017102620 commit=bb176f67090ca54869fc1262c913aa69d2ede070 BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/vmlinuz-4.14.0-rc6 max_uptime=1500 RESULT_ROOT=/result/will-it-scale/100%-thread-writeseek1-performance/lkp-hsw-ep4/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-6/bb176f67090ca54869fc1262c913aa69d2ede070/0 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_wat
 chdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel con
[  185.871239] 
[  186.245397] Unknown type (Reserved) while parsing /sys/firmware/memmap/11/type. Please report this as bug. Using RANGE_RESERVED now.
[  186.245401] 
[  186.268940] Unknown type (Reserved) while parsing /sys/firmware/memmap/1/type. Please report this as bug. Using RANGE_RESERVED now.
[  186.268942] 
[  186.289944] Unknown type (Reserved) while parsing /sys/firmware/memmap/6/type. Please report this as bug. Using RANGE_RESERVED now.
[  186.289946] 
[  186.310905] Unknown type (Reserved) while parsing /sys/firmware/memmap/12/type. Please report this as bug. Using RANGE_RESERVED now.
[  186.310907] 
[  186.331631] Unknown type (Reserved) while parsing /sys/firmware/memmap/2/type. Please report this as bug. Using RANGE_RESERVED now.
[  186.331633] 
[  186.352439] Unknown type (Reserved) while parsing /sys/firmware/memmap/10/type. Please report this as bug. Using RANGE_RESERVED now.
[  186.352441] 
[  187.926702] umount: /tmp: target is busy
[  187.926705] 
[  187.937859]         (In some cases useful info about processes that
[  187.937861] 
[  187.950561]          use the device is found by lsof(8) or fuser(1).)
[  187.950563] 
[  188.092344] umount: /sys/fs/cgroup/systemd: target is busy
[  188.092347] 
[  188.104917]         (In some cases useful info about processes that
[  188.104918] 
[  188.116534]          use the device is found by lsof(8) or fuser(1).)
[  188.116535] 
[  188.127983] umount: /sys/fs/cgroup: target is busy
[  188.127984] 
[  188.137808]         (In some cases useful info about processes that
[  188.137809] 
[  188.149275]          use the device is found by lsof(8) or fuser(1).)
[  188.149276] 
[  188.160512] umount: /run: target is busy
[  188.160513] 
[  188.169351]         (In some cases useful info about processes that
[  188.169352] 
[  188.180714]          use the device is found by lsof(8) or fuser(1).)
[  188.180716] 
[  188.197506] umount: /dev: target is busy
LKP: kexecing
[  188.197507] 
[  188.198697] LKP: kexecing
[  188.198699] 
[  188.202916] ixgbe 0000:03:00.0: removed PHC on eth0
[  188.219145]         (In some cases useful info about processes that
[  188.219146] 
[  188.230179]          use the device is found by lsof(8) or fuser(1).)
[  188.230180] 
[  188.240903] umount: /: not mounted
[  188.240904] 
[  188.547843] kvm: exiting hardware virtualization
Starting new kernel

--i5g2a7gt6sl2dzir
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--i5g2a7gt6sl2dzir--
