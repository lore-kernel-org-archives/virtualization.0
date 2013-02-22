From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [Xen-devel] [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 18:25:46 +0000
Message-ID: <5127B82A.3000506@citrix.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
	<20130222172403.GA17056@phenom.dumpdata.com>
	<CAE9FiQUe86t2Me4uF=oCz5VGqa8AJYrGQHhPA=w_9OP5OSWN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAE9FiQUe86t2Me4uF=oCz5VGqa8AJYrGQHhPA=w_9OP5OSWN=w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Gokul Caushik <caushik1@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Russell King <linux@arm.linux.org.uk>, Zachary
List-Id: virtualization@lists.linuxfoundation.org

On 22/02/13 17:53, Yinghai Lu wrote:
> On Fri, Feb 22, 2013 at 9:24 AM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> On Fri, Feb 22, 2013 at 11:55:31AM -0500, Konrad Rzeszutek Wilk wrote:
>>> On Thu, Feb 21, 2013 at 04:34:06PM -0800, H. Peter Anvin wrote:
>>>> Hi Linus,
>>>>
>>>> This is a huge set of several partly interrelated (and concurrently
>>>> developed) changes, which is why the branch history is messier than
>>>> one would like.
>>>>
>>>> The *really* big items are two humonguous patchsets mostly developed
>>>> by Yinghai Lu at my request, which completely revamps the way we
>>>> create initial page tables.  In particular, rather than estimating how
>>>> much memory we will need for page tables and then build them into that
>>>> memory -- a calculation that has shown to be incredibly fragile -- we
>>>> now build them (on 64 bits) with the aid of a "pseudo-linear mode" --
>>>> a #PF handler which creates temporary page tables on demand.
>>>>
>>>> This has several advantages:
>>>>
>>>> 1. It makes it much easier to support things that need access to
>>>>    data very early (a followon patchset uses this to load microcode
>>>>    way early in the kernel startup).
>>>>
>>>> 2. It allows the kernel and all the kernel data objects to be invoked
>>>>    from above the 4 GB limit.  This allows kdump to work on very large
>>>>    systems.
>>>>
>>>> 3. It greatly reduces the difference between Xen and native (Xen's
>>>>    equivalent of the #PF handler are the temporary page tables created
>>>>    by the domain builder), eliminating a bunch of fragile hooks.
>>>>
>>>> The patch series also gets us a bit closer to W^X.
>>>>
>>>> Additional work in this pull is the 64-bit get_user() work which you
>>>> were also involved with, and a bunch of cleanups/speedups to
>>>> __phys_addr()/__pa().
>>> Looking at figuring out which of the patches in the branch did this, but
>>> with this merge I am getting a crash with a very simple PV guest (booted with
>>> one 1G):
>>>
>>> Call Trace:
>>>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a  <--
>>>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a
>>>   [<ffffffff81042d27>] xen_write_cr3+0x77
>>>   [<ffffffff81ad2d21>] init_mem_mapping+0x1f9
>>>   [<ffffffff81ac293f>] setup_arch+0x742
>>>   [<ffffffff81666d71>] printk+0x48
>>>   [<ffffffff81abcd62>] start_kernel+0x90
>>>   [<ffffffff8109416b>] __add_preferred_console.clone.1+0x9b
>>>   [<ffffffff81abc5f7>] x86_64_start_reservations+0x2a
>>>   [<ffffffff81abf0c7>] xen_start_kernel+0x564
>>>
>>> And the hypervisor says:
>>> (XEN) d7:v0: unhandled page fault (ec=0000)
>>> (XEN) Pagetable walk from ffffea000005b2d0:
>>> (XEN)  L4[0x1d4] = 0000000000000000 ffffffffffffffff
>>> (XEN) domain_crash_sync called from entry.S
>>> (XEN) Domain 7 (vcpu#0) crashed on cpu#3:
>>> (XEN) ----[ Xen-4.2.0  x86_64  debug=n  Not tainted ]----
>>> (XEN) CPU:    3
>>> (XEN) RIP:    e033:[<ffffffff8103feba>]
>>> (XEN) RFLAGS: 0000000000000206   EM: 1   CONTEXT: pv guest
>>> (XEN) rax: ffffea0000000000   rbx: 0000000001a0c000   rcx: 0000000080000000
>>> (XEN) rdx: 000000000005b2a0   rsi: 0000000001a0c000   rdi: 0000000000000000
>>> (XEN) rbp: ffffffff81a01dd8   rsp: ffffffff81a01d90   r8:  0000000000000000
>>> (XEN) r9:  0000000010000001   r10: 0000000000000000   r11: 0000000000000000
>>> (XEN) r12: 0000000000000000   r13: 0000001000000000   r14: 0000000000000000
>>> (XEN) r15: 0000000000100000   cr0: 000000008005003b   cr4: 00000000000406f0
>>> (XEN) cr3: 0000000411165000   cr2: ffffea000005b2d0
>>> (XEN) ds: 0000   es: 0000   fs: 0000   gs: 0000   ss: e02b   cs: e033
>>> (XEN) Guest stack trace from rsp=ffffffff81a01d90:
>>> (XEN)    0000000080000000 0000000000000000 0000000000000000 ffffffff8103feba
>>> (XEN)    000000010000e030 0000000000010006 ffffffff81a01dd8 000000000000e02b
>> Here is a better serial log of the crash (just booting a normal Xen 4.1 + initial
>> kernel with 8GB):
>>
>> PXELINUX 3.82 2009-06-09  Copyright (C) 1994-2009 H. Peter Anvin et al
>> boot:
>> Loading xen.gz... ok
>> Loading vmlinuz... ok
>> Loading initramfs.cpio.gz... ok
>>  __  __            _  _    _   ____
>>  \ \/ /___ _ __   | || |  / | | ___|    _ __  _ __ ___
>>   \  // _ \ '_(_)_(_)____/   | .__/|_|  \___|
>>                                        |_|
>> (XEN) Xen version 4.1.5-pre (konrad@dumpdata.com) (gcc version 4.4.4 20100503 (Red Hat 4.4.4-2) (GCC) ) Fri Feb 22 11:37:00 EST 2013
>> (XEN) Latest ChangeSet: Fri Feb 15 15:31:55 2013 +0100 23459:9f12bdd6b7f0
>> (XEN) Console output is synchronous.
>> (XEN) Bootloader: unknown
>> (XEN) Command line: cpuinfo conring_size=1048576 sync_console cpufreq=verbose com1=115200,8n1 console=com1,vga loglvl=all guest_loglvl=all
>> (XEN) Video information:
>> (XEN)  VGA is text mode 80x25, font 8x16
>> (XEN)  VBE/DDC methods: none; EDID transfer time: 0 seconds
>> (XEN)  EDID info not retrieved because no DDC retrieval method detected
>> (XEN) Disc information:
>> (XEN)  Found 1 MBR signatures
>> (XEN)  Found 1 EDD information structures
>> (XEN) Xen-e820 RAM map:
>> (XEN)  0000000000000000 - 000000000009ec00 (usable)
>> (XEN)  000000000009ec00 - 00000000000a0000 (reserved)
>> (XEN)  00000000000e0000 - 0000000000100000 (reserved)
>> (XEN)  0000000000100000 - 0000000020000000 (usable)
>> (XEN)  0000000020000000 - 0000000020200000 (reserved)
>> (XEN)  0000000020200000 - 0000000040000000 (usable)
>> (XEN)  0000000040000000 - 0000000040200000 (reserved)
>> (XEN)  0000000040200000 - 00000000bad80000 (usable)
>> (XEN)  00000000bad80000 - 00000000badc9000 (ACPI NVS)
>> (XEN)  00000000badc9000 - 00000000badd1000 (ACPI data)
>> (XEN)  00000000badd1000 - 00000000badf4000 (reserved)
>> (XEN)  00000000badf4000 - 00000000badf6000 (usable)
>> (XEN)  00000000badf6000 - 00000000bae06000 (reserved)
>> (XEN)  00000000bae06000 - 00000000bae14000 (ACPI NVS)
>> (XEN)  00000000bae14000 - 00000000bae3c000 (reserved)
>> (XEN)  00000000bae3c000 - 00000000bae7f000 (ACPI NVS)
>> (XEN)  00000000bae7f000 - 00000000bb000000 (usable)
>> (XEN)  00000000bb800000 - 00000000bfa00000 (reserved)
>> (XEN)  00000000fed1c000 - 00000000fed40000 (reserved)
>> (XEN)  00000000ff000000 - 0000000100000000 (reserved)
>> (XEN)  0000000100000000 - 000000023fe00000 (usable)
>> (XEN) ACPI: RSDP 000F0450, 0024 (r2 ALASKA)
>> (XEN) ACPI: XSDT BADC9068, 0054 (r1 ALASKA    A M I  1072009 AMI     10013)
>> (XEN)  PROC        1 MSFT  3000001)
>> (XEN) ACPI: MCFG BADD0580, 003C (r1 ALASKA    A M I  1072009 MSFT       97)
>> (XEN) ACPI: HPET BADD05C0, 0038 (r1 ALASKA    A M I  1072009 AMI.        4)
>> (XEN) ACPI: ASF! BADD05F8, 00A0 (r32 INTEL       HCG        1 TFSM    F4240)
>> (XEN) System RAM: 8104MB (8299140kB)
>> (XEN) No NUMA configuration found
>> (XEN) Faking a node at 0000000000000000-000000023fe00000
>> (XEN) Domain heap initialised
>> (XEN) found SMP MP-table at 000fcde0
>> (XEN) DMI 2.7 present.
>> (XEN) Using APIC driver default
>> (XEN) ACPI: PM-Timer IO Port: 0x408
>> (XEN) ACPI: ACPI SLEEP INFO: pm1x_cnt[404,0], pm1x_evt[400,0]
>> (XEN) ACPI: 32/64X FACS address mismatch in FADT - bae0bf80/0000000000000000, using 32
>> (XEN) ACPI:                  wakeup_vec[bae0bf8c], vec_size[20]
>> (XEN) ACPI: Local APIC address 0xfee00000
>> (XEN) ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>> (XEN) Processor #0 6:10 APIC version 21
>> (XEN) ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
>> (XEN) Processor #2 6:10 APIC version 21
>> (XEN) ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
>> (XEN) Processor #1 6:10 APIC version 21
>> (XEN) ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
>> (XEN) Processor #3 6:10 APIC version 21
>> (XEN) ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
>> (XEN) ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
>> (XEN) IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
>> (XEN) ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> (XEN) ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>> (XEN) ACPI: IRQ0 used by override.
>> (XEN) ACPI: IRQ2 used by override.
>> (XEN) ACPI: IRQ9 used by override.
>> (XEN) Enabling APIC mode:  Flat.  Using 1 I/O APICs
>> (XEN) ACPI: HPET id: 0x8086a701 base: 0xfed00000
>> (XEN) PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
>> (XEN) PCI: Not using MMCONFIG.
>> (XEN) Table is not found!
>> (XEN) Using ACPI (MADT) for SMP configuration information
>> (XEN) IRQ limits: 24 GSI, 760 MSI/MSI-X
>> (XEN) Using scheduler: SMP Credit Scheduler (credit)
>> (XEN) Initializing CPU#0
>> (XEN) Detected 3093.067 MHz processor.
>> (XEN) Initing memory sharing.
>> (XEN) CPU: Physical Processor ID: 0
>> (XEN) CPU: Processor Core ID: 0
>> (XEN) CPU: L1 I cache: 32K, L1 D cache: 32K
>> (XEN) CPU: L2 cache: 256K
>> (XEN) CPU: L3 cache: 3072K
>> (XEN) mce_intel.c:1162: MCA Capability: BCAST 1 SER 0 CMCI 1 firstbank 0 extended MCE MSR 0
>> (XEN) CPU0: Thermal monitoring enabled (TM1)
>> (XEN) Intel machine check reporting enabled
>> (XEN) I/O virtualisation disabled
>> (XEN) CPU0: Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz stepping 07
>> (XEN) Enabled directed EOI with ioapic_ack_old on!
>> (XEN) ENABLING IO-APIC IRQs
>> (XEN)  -> Using old ACK method
>> (XEN) ..TIMER: vector=0xF0 apic1=0 pin1=2 apic2=-1 pin2=-1
>> (XEN) TSC deadline timer enabled
>> (XEN) Platform timer is 14.318MHz HPET
>> (XEN) Allocated console ring of 1048576 KiB.
>> (XEN) VMX: Supported advanced features:
>> (isation
>> (XEN)  - APIC TPR shadow
>> (XEN)  - Extended Page Tables (EPT)
>> (XEN)  - Virtual-Processor Identifiers (VPID)
>> (XEN)  - Virtual NMI
>> (XEN)  - MSR direct-access bitmap
>> (XEN)  - Unrestricted Guest
>> (XEN) HVM: ASIDs enabled.
>> (XEN) HVM: VMX enabled
>> (XEN) HVM: Hardware Assisted Paging (HAP) detected
>> (XEN) HVM: HAP page sizes: 4kB, 2MB
>> (XEN) Booting processor 1/1 eip 7c000
>> (XEN) Initializing CPU#1
>> (XEN) CPU: Physical Processor ID: 0
>> (XEN) CPU: Processor Core ID: 0
>> (XEN) CPU: L1 I cache: 32K, L1 D
>> (XEN) Initializing CPU#2
>> (XEN) CPU: Physical Processor ID: 0
>> (XEN) CPU: Processor Core ID: 1
>> (XEN) CPU: L1 I cache: 32K, L1 D cache: 32K
>> (XEN) CPU: L2 cache: 256K
>> (XEN) CPU: L3 cache: 3072K
>> (XEN) CPU2: Thermal monitoring enabled (TM1)
>> (XEN) CPU2: Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz stepping 07
>> (XEN) Booting processor 3/3 eip 7c000
>> (XEN) Initializing CPU#3
>> (XEN) CPU: Physical Processor ID: 0
>> (XEN) CPU: Processor Core ID: 1
>> (XEN) CPU: L1 I cache: 32K, L1 D100 CPU @ 3.10GHz stepping 07
>> (XEN) Brought up 4 CPUs
>> (XEN) ACPI sleep modes: S3
>> (XEN) mcheck_poll: Machine check polling timer started.
>> (XEN) *** LOADING DOMAIN 0 ***
>> (XEN) elf_parse_binary: phdr: paddr=0x1000000 memsz=0x9e0000
>> (XEN) elf_parse_binary: phdr: paddr=0x1a00000 memsz=0xa60f0
>> (XEN): paddr=0x1abc000 memsz=0x61b000
>> (XEN) elf_parse_binary: memory: 0x1000000 -> 0x20d7000
>> (XEN) elf_xen_parse_note: GUEST_OS = "linux"
>> (XEN) elf_xen_parse_note: GUEST_VERSION = "2.6"
>> (XEN) elf_xen_parse_note: XEN_VERSION = "xen-3.0"
>> (XEN) elf_xen_parse_note: VIRT_BASE = 0xffffffff80000000
>> (XEN) elf_xen_parse_note: ENTRY = 0xffffffff81abc1e0
>> (XEN) elf_xen_parse_note: HYPERCALL_PAGE = 0xffffffff81001000
>> (XEN) elf_xen_parse_note: FEATURES = "!writable_page_tables|pae_pgdir_above_4gb"
>> (XEN) elf_xen_parse_note: PAE_MODE = "yes"
>> (XEN) elf_xen_parse_note: LOADER = "generic"
>> (XEN) elf_xen_parse_note: unknown xen elf note (0xd)
>> (XEN) elf_xen_parse_note: SUSPEND_CANCEL = 0x1
>> (XEN) elf_xen_parse_note: HV_START_LOW = 0xffff800000000000
>> (XEN) elf_xen_parse_note: PADDR_OFFSET = 0x0
>> (XEN) elf_xen_addr_calc_check: addresses:
>> (XEN)     virt_base        = 0xffffffff80000000
>> (XEN)     elf_paddr_offset = 0x0
>> (XEN)     virt_offset      = 0xffffffff80000000
>> (XEN)     virt_kstart      = 0xffffffff81000000
>> (XEN)     virt_kend        = 0xffffffff820d7000
>> (XEN)     virt_entry       = 0xffffffff81abc1e0
>> (XEN)     p2m_base         = 0xffffffffffffffff
>> (XEN)  Xen  kernel: 64-bit, lsb, compat32
>> (XEN)  Dom0 kernel: 64-bit, PAE, lsb, paddr 0x1000000 -> 0x20d7000
>> (XEN) PHYSICAL MEMORY ARRANGEMENT:
>> (XEN)  Dom0 alloc.:   0000000220000000->0000000224000000 (1661249 pages to be allocated)
>> (XEN)  Init. ramdisk: 000000022cbdc000->000000023fe00000
>> (XEN) VIRTUAL MEMORY ARRANGEMENT:
>> (XEN)  Loaded kernel: ffffffff81000000->ffffffff820d7000
>> (XEN)  Init. ramdisk: ffffffff820d7000->ffffffff952fb000
>> (XEN)  Phys-Mach map: ffffffff952fb000->ffffffff96060b28
>> (XEN)  Start info:    ffffffff96061000->ffffffff960614b4
>> (XEN)  Page tables:   ffffffff96062000->ffffffff96117000
>> (XEN)  Boot stack:    ffffffff96117000->ffffffff96118000
>> (XEN)  TOTAL:         ffffffff80000000->ffffffff96400000
>> (XEN)  ENTRY ADDRESS: ffffffff81abc1e0
>> (XEN) Dom0 has maximum 4 VCPUs
>> (XEN) elf_load_binary: phdr 0 at 0xffffffff81000000 -> 0xffffffff819e0000
>> (XEN) elf_load_binary: phdr 1 at 0xffffffff81a00000 -> 0xffffffff81aa60f0
>> (XEN) elf_load_binary: phdr 2 at 0xffffffff81aa7000 -> 0xffffffff81abbbc0
>> (XEN) elf_load_binary: phdr 3 at 0xffffffff81abc000 -> 0xffffffff81baf000
>> (XEN) Scrubbing Free RAM: .done.
>> (XEN) Xen trace buffers: disabled
>> (XEN) Std. Loglevel: All
>> (XEN) Guest Loglevel: All
>> (XEN) ***************************intended to aid debugging of Xen by ensuring
>> (XEN) ******* that all output is synchronously delivered on the serial line.
>> (XEN) ******* However it can introduce SIGNIFICANT latencies and affect
>> (XEN) ******* timekeeping. It is NOT recommended for production use!
>> (XEN) **********************************************
>> (XEN) 3... 2... 1...
>> (XEN) Xen is relinquishing VGA console.
>> (XEN) *** Serial input -> DOM0 (type 'CTRL-a' three times to switch input to Xen)
>> (XEN) Freed 224kB init memory.
>> mapping kernel into physical memory
>> about to get started...
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.8.0upstream-06471-g2ef14f4-dirty (konrad@build.dumpdata.com) (gcc version 4.4.4 20100503 (Red Hat 4.4.4-2) (GCC) ) #1 SMP Fri Feb 22 11:36:48 EST 2013
>> [    0.000000] Command line: initcall_debug debug console=hvc0 loglevel=10 xen-pciback.hide=(01:00.0) earlyprintk=xen
>> [    0.000000] Freeing 9e-100 pfn range: 98 pages freed
>> [    0.000000] 1-1 mapping on 9e->100
>> [    0.000000] Freeing 20000-20200 pfn range: 512 pages freed
>> [    0.000000] 1-1 mapping on 20000->20200
>> [    0.000000] Freeing 40000-40200 pfn range: 512 pages freed
>> [    0.000000] 1-1 mapping on 40000->40200
>> [    0.000000] Freeing bad80-badf4 pfn range: 116 pages freed
>> [    0.000000] 1-1 mapping on bad80->badf4
>> [    0.000000] Freeing badf6-bae7f pfn range: 137 pages freed
>> [    0.000000] 1-1 mapping on badf6->bae7f
>> [    0.000000] Freeing bb000-100000 pfn range: 282624 pages freed
>> [    0.000000] 1-1 mapping on bb000->100000
>> [    0.000000] Released 283999 pages of unused memory
>> [    0.000000] Set 283999 page(s) to 1-1 mapping
>> [    0.000000] Populating 1acb65-1f20c4 pfn range: 283999 pages added
>> [    0.000000] e820: BIOS-provided physical RAM map:
>> [    0.000000] Xen: [mem 0x0000000000000000-0x000000000009dfff] usable
>> [    0.000000] Xen: [mem 0x000000000009ec00-0x00000000000fffff] reserved
>> [    0.000000] Xen: [mem 0x0000000000100000-0x000000001fffffff] usable
>> [    0.000000] Xen: [mem 0x0000000020000000-0x00000000201fffff] reserved
>> [    0.000000] Xen: [mem 0x0000000020200000-0x000000003fffffff] usable
>> [    0.000000] Xen: [mem 0x0000000040000000-0x00000000401fffff] reserved
>> [    0.000000] Xen: [mem 0x0000000040200000-0x00000000bad7ffff] usable
>> [    0.000000] Xen: [mem 0x00000000bad80000-0x00000000badc8fff] ACPI NVS
>> [    0.000000] Xen: [mem 0x00000000badc9000-0x00000000badd0fff] ACPI data
>> [    0.000000] Xen: [mem 0x00000000badd1000-0x00000000badf3fff] reserved
>> [    0.000000] Xen: [mem 0x00000000badf4000-0x00000000badf5fff] usable
>> [    0.000000] Xen: [mem 0x00000000badf6000-0x00000000bae05fff] reserved
>> [    0.000000] Xen: [mem 0x00000000bae06000-0x00000000bae13fff] ACPI NVS
>> [    0.000000] Xen: [mem 0x00000000bae14000-0x00000000bae3bfff] reserved
>> [    0.000000] Xen: [mem 0x00000000bae3c000-0x00000000bae7efff] ACPI NVS
>> [    0.000000] Xen: [mem 0x00000000bae7f000-0x00000000baffffff] usable
>> [    0.000000] Xen: [mem 0x00000000bb800000-0x00000000bf9fffff] reserved
>> [    0.000000] Xen: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
>> [    0.000000] Xen: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
>> [    0.000000] Xen: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
>> [    0.000000] Xen: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
>> [    0.000000] Xen: [mem 0x0000000100000000-0x000000023fdfffff] usable
>> [    0.000000] bootconsole [xenboot0] enabled
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] SMBIOS 2.7 present.
>> [    0.000000] DMI: MSI MS-7680/H61M-P23 (MS-7680), BIOS V17.0 03/14/2011
>> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.000000] No AGP bridge found
>> [    0.000000] e820: last_pfn = 0x23fe00 max_arch_pfn = 0x400000000
>> [    0.000000] e820: lacanning 1 areas for low memory corruption
>> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
>> [    0.000000] reserving inaccessible SNB gfx pages
>> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
>> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x1f2000000-0x1f20c3fff]
>> [    0.000000]  [mem 0x1f2000000-0x1f20c3fff] page 4k
>> [    0.000000] BRK [0x01cd2000, 0x01cd2fff] PGTABLE
>> [    0.000000] BRK [0x01cd3000, 0x01cd3fff] PGTABLE
>> [    0.000000] init_memory_mapping: [mem 0x1f0000000-0x1f1ffffff]
>> [    0.000000]  [mem 0x1f0000000-0x1f1ffffff] page 4k
>> [    0.000000] BRK [0x01cd4000, 0x01cd4fff] PGTABLE
>> [    0.000000] BRK [0x01cd5000, 0x01cd5fff] PGTABLE
>> [    0.000000] BRK [0x01cd6000, 0x01cd6fff] PGTABLE
>> [    0.000000] init_memory_mapping: [mem 0x180000000-0x1efffffff]
>> [    0.000000]  [mem 0x180000000-0x1efffffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
>> [    0.000000]  [mem 0x00100000-0x1fffffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
>> [    0.000000]  [mem 0x20200000-0x3fffffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x40200000-0xbad7ffff]
>> [    0.000000]  [mem 0x40200000-0xbad7ffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0xbadf4000-0xbadf5fff]
>> [    0.000000]  [mem 0xbadf4000-0xbadf5fff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0xbae7f000-0xbaffffff]
>> [    0.000000]  [mem 0xbae7f000-0xbaffffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x100000000-0x17fffffff]
>> [    0.000000]  [mem 0x100000000-0x17fffffff] page 4k
>> [    0.000000] init_memory_mapping: [mem 0x1f20c4000-0x23fdfffff]
>> [    0.000000]  [mem 0x1f20c4000-0x23fdfffff] page 4k
> so init_memory_mapping are all done.
>
>> (XEN) d0:v0: unhandled page fault (ec=0000)
>> (XEN) Pagetable walk from ffffea000005b2d0:
>> (XEN)  L4[0x1d4] = 0000000000000000 ffffffffffffffff
>> (XEN) domain_crash_sync called from entry.S
>> (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
>> (XEN) ----[ Xen-4.1.5-pre  x86_64  debug=y  Tainted:    C ]----
>> (XEN) CPU:    0
>> (XEN) RIP:    e033:[<ffffffff8103feba>]
>> (XEN) RFLAGS: 0000000000000206   EM: 1   CONTEXT: pv guest
>> (XEN) rax: ffffea0000000000   rbx: 0000000001a0c000   rcx: 0000000080000000
>> (XEN) rdx: 000000000005b2a0   rsi: 0000000001a0c000   rdi: 0000000000000000
>> (XEN) rbp: ffffffff81a01dd8   rsp: ffffffff81a01d90   r8:  0000000000000000
>> (XEN) r9:  0000000010000001   r10: 0000000000000005   r11: 0000000000100000
>> (XEN) r12: 0000000000000000   r13: 0000020000000000   r14: 0000000000000000
>> (XEN) r15: 0000000000100000   cr0: 000000008005003b   cr4: 00000000000026f0
>> (XEN) cr3: 0000000221a0c000   cr2: ffffea000005b2d0
>> (XEN) ds: 0000   es: 0000   fs: 0000   gs: 0000   ss: e02b   cs: e033
>> (XEN) Guest stack trace from rsp=ffffffff81a01d90:
>> (XEN)    0000000080000000 0000000000100000 0000000000000000 ffffffff8103feba
>> (XEN)    000000010000e030 0000000000010006 ffffffff81a01dd8 000000000000e02b
>> (XEN)    0000000000000000 ffffffff81a01e08 ffffffff81042d27 000000023fe00000
>> (XEN)    00000001f20c4000 0000020000000000 00000001acac7000 ffffffff81a01e48
>> (XEN)    ffffffff81ad2d21 0000000000000000 0000000000000028 0000000040004000
>> (XEN)    0000000000000000 0000000000000000 0000000000000000 ffffffff81a01ed8
>> (XEN)    ffffffff81ac293f ffffffff81b46900 0000000000000000 0000000000000000
>> (XEN)    0000000000000000 ffffffff81a01f00 ffffffff8165fbd1 ffffffff00000010
>> (XEN)    ffffffff81a01ee8 ffffffff81a01ea8 0000000000000000 ffffffff81a01ec8
>> (XEN)    ffffffffffffffff ffffffff81b46900 0000000000000000 0000000000000000
>> (XEN)    0000000000000000 ffffffff81a01f28 ffffffff81abcd62 ffffffff96062000
>> (XEN)    ffffffff81cc6000 ffffffff81ccd000 ffffffff81b4f2e0 0000000000000000
>> (XEN)    0000000000000000 0000000000000000 0000000000000000 ffffffff81a01f38
>> (XEN)    ffffffff81abc5f7 ffffffff81a01ff8 ffffffff81abf0c7 0300000100000032
>> (XEN)    0000000000000005 0000000000000000 0000000000000000 0000000000000000
>> (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> (XEN)    0000000000000000 819822831fc9cbf5 000206a700100800 0000000000000001
>> (XEN)    0000000000000000 0000000000000000 0f00000060c0c748 ccccccccccccc305
>> (XEN) Domain 0 crashed: rebooting machine in 5 seconds.
>> (XEN) Resetting with ACPI MEMORY or I/O RESET_REG.
> can we get kernel trace instead?

(XEN) d0:v0: unhandled page fault (ec=0000)
(XEN) Pagetable walk from ffffea000005b2d0:
(XEN)  L4[0x1d4] = 0000000000000000 ffffffffffffffff
(XEN) domain_crash_sync called from entry.S

This means that Xen was unable to context switch back to dom0

The value in rax looks suspiciously related to the faulting address in cr2.

Konrad: is the instruction at ffffffff8103feba possibly a rax-relative
dereference?

~Andrew

>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
