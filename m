From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Tue, 19 Sep 2006 18:03:51 +1000
Message-ID: <1158653031.23629.1.camel@localhost.localdomain>
References: <1158635617.21726.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158635617.21726.8.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-09-19 at 13:13 +1000, Rusty Russell wrote:
> Hi Jeremy, all,
> =

> 	Sorry this took so long, spent last week in Japan at OSDL conf then
> netconf.  After several false starts, I ended up with a very simple
> implementation, which clashes significantly with your work since then
> 8(.  I've pushed the patches anyway, but it's going to be significant
> work for me to re-merge them, so I wanted your feedback first.

OK, here's a patch against 2.6.18-rc6-mm2.  Tested on UP and SMP.
Crashes on hotplugging CPU, but crashes in same way as before the patch
8).

Replace PDA with per-cpu section, and put GDT in per-cpu section.

This patch uses the "gs" segment register which Jeremy Fitzhardinge
freed up for kernel use, for the per-cpu section.  This means that
instead of having a special per-cpu struct which we can access in a
single instruction, any per-cpu variable can be accessed in a single
instruction.  In addition, it avoids introducing the concept of a
"pda" into the kernel, in favour of the well-known "percpu" concept.

So, arch-specific code (eg. smp_processor_id()) can use
x86_write_percpu()/x86_read_percpu() directly.  Generic code expects
an lvalue from __get_cpu_var(), but it takes two instruction to get
the address of a per-cpu variable (still not bad).  Ideally, we could
use the __thread extension, and GCC would then generate optimal code
when an lvalue isn't needed, however, the linker wants to use a
negative offset within the gs register, which cannot be used with Xen
(or any similar hypervisor), because it requires a 4GB segment, which
would allow the OS to access the hypervisor memory.

As an additional simplification, the GDT is placed directly in a
per-cpu variable, rather than allocated dynamically.  This is optimal
for the UP case (previously, we made a copy even here), and
signficantly simplfies the code.  It's a little unusual to have asm
access a per-cpu var, but it is only done early at boot, where the
per-cpu GDT is sitting in the to-be-discarded section.

More cleanups/optimizations are possible:
1) Don't save/restore %gs on UP.  The cost is measurable, and we don't use =
it.
2) Remove early_smp_processor_id(), by setting up the per-cpu
   processor_id field correctly before starting a CPU.
3) Similarly, get rid of early_current().
4) Implement cpu_local_* in terms of x86_read_percpu etc.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/arch/i386/kernel/cpu/common.c working-2.6=
.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/cpu/common.c
--- linux-2.6.18-rc6-mm2/arch/i386/kernel/cpu/common.c	2006-09-19 14:54:22.=
000000000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/cpu/common.c	2006=
-09-19 15:27:29.000000000 +1000
@@ -19,18 +19,14 @@
 #include <asm/apic.h>
 #include <mach_apic.h>
 #endif
-#include <asm/pda.h>
 =

 #include "cpu.h"
 =

-DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
-EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
-
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 =

-struct i386_pda *_cpu_pda[NR_CPUS] __read_mostly;
-EXPORT_SYMBOL(_cpu_pda);
+DEFINE_PER_CPU(struct task_struct *, current_task) =3D &init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
 =

 static int cachesize_override __cpuinitdata =3D -1;
 static int disable_x86_fxsr __cpuinitdata;
@@ -592,141 +587,10 @@ void __init early_cpu_init(void)
 struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
-	regs->xgs =3D __KERNEL_PDA;
+	regs->xgs =3D __KERNEL_PERCPU;
 	return regs;
 }
 =

-__cpuinit int alloc_gdt(int cpu)
-{
-	struct Xgt_desc_struct *cpu_gdt_descr =3D &per_cpu(cpu_gdt_descr, cpu);
-	struct desc_struct *gdt;
-	struct i386_pda *pda;
-
-	gdt =3D (struct desc_struct *)cpu_gdt_descr->address;
-	pda =3D cpu_pda(cpu);
-
-	/*
-	 * This is a horrible hack to allocate the GDT.  The problem
-	 * is that cpu_init() is called really early for the boot CPU
-	 * (and hence needs bootmem) but much later for the secondary
-	 * CPUs, when bootmem will have gone away
-	 */
-	if (NODE_DATA(0)->bdata->node_bootmem_map) {
-		BUG_ON(gdt !=3D NULL || pda !=3D NULL);
-
-		gdt =3D alloc_bootmem_pages(PAGE_SIZE);
-		pda =3D alloc_bootmem(sizeof(*pda));
-		/* alloc_bootmem(_pages) panics on failure, so no check */
-
-		memset(gdt, 0, PAGE_SIZE);
-		memset(pda, 0, sizeof(*pda));
-	} else {
-		/* GDT and PDA might already have been allocated if
-		   this is a CPU hotplug re-insertion. */
-		if (gdt =3D=3D NULL)
-			gdt =3D (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
-
-		if (pda =3D=3D NULL)
-			pda =3D kmalloc_node(sizeof(*pda), GFP_KERNEL, cpu_to_node(cpu));
-
-		if (unlikely(!gdt || !pda)) {
-			free_pages((unsigned long)gdt, 0);
-			kfree(pda);
-			return 0;
-		}
-	}
-
- 	cpu_gdt_descr->address =3D (unsigned long)gdt;
-	cpu_pda(cpu) =3D pda;
-
-	return 1;
-}
-
-static __cpuinit void pda_init(int cpu, struct task_struct *curr)
-{
-	struct i386_pda *pda =3D cpu_pda(cpu);
-
-	memset(pda, 0, sizeof(*pda));
-
-	pda->cpu_number =3D cpu;
-	pda->pcurrent =3D curr;
-
-	printk("cpu %d current %p\n", cpu, curr);
-}
-
-static inline void set_kernel_gs(void)
-{
-	/* Set %gs for this CPU's PDA.  Memory clobber is to create a
-	   barrier with respect to any PDA operations, so the compiler
-	   doesn't move any before here. */
-	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
-}
-
-/* Initialize the CPU's GDT and PDA */
-static __cpuinit void init_gdt(void)
-{
-	int cpu =3D early_smp_processor_id();
-	struct task_struct *curr =3D early_current();
-	struct Xgt_desc_struct *cpu_gdt_descr =3D &per_cpu(cpu_gdt_descr, cpu);
-	__u32 stk16_off =3D (__u32)&per_cpu(cpu_16bit_stack, cpu);
-	struct desc_struct *gdt;
-	struct i386_pda *pda;
-
-	/* For non-boot CPUs, the GDT and PDA should already have been
-	   allocated. */
-	if (!alloc_gdt(cpu)) {
-		printk(KERN_CRIT "CPU%d failed to allocate GDT or PDA\n", cpu);
-		for (;;)
-			local_irq_enable();
-	}
-
-	gdt =3D (struct desc_struct *)cpu_gdt_descr->address;
-	pda =3D cpu_pda(cpu);
-
-	BUG_ON(gdt =3D=3D NULL || pda =3D=3D NULL);
-
-	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
-	 */
- 	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
-	cpu_gdt_descr->size =3D GDT_SIZE - 1;
-
-	/* Set up GDT entry for 16bit stack */
- 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=3D
-		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
-		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
-		(CPU_16BIT_STACK_SIZE - 1);
-
-	pack_descriptor((u32 *)&gdt[GDT_ENTRY_PDA].a,
-			(u32 *)&gdt[GDT_ENTRY_PDA].b,
-			(unsigned long)pda, sizeof(*pda) - 1,
-			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
-
-	load_gdt(cpu_gdt_descr);
-	set_kernel_gs();
-
-	/* Do this once everything GDT-related has been set up. */
-	pda_init(cpu, curr);
-}
-
-/* Set up a very early PDA for the boot CPU so that smp_processor_id()
-   and current will work. */
-void __init smp_setup_processor_id(void)
-{
-	static __initdata struct i386_pda boot_pda;
-
-	pack_descriptor((u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].a,
-			(u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].b,
-			(unsigned long)&boot_pda, sizeof(struct i386_pda) - 1,
-			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
-
-	boot_pda.pcurrent =3D early_current();
-
-	/* Set %gs for this CPU's PDA */
-	set_kernel_gs();
-}
-
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -740,15 +604,27 @@ void __cpuinit cpu_init(void)
 =

 	struct tss_struct * t =3D &per_cpu(init_tss, cpu);
 	struct thread_struct *thread =3D &curr->thread;
+	struct desc_struct *gdt;
+	u32 stk16_off;
 =

 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) local_irq_enable();
 	}
 =

-	/* Init the GDT and PDA early, before calling printk(),
-	   since it may end up using the PDA indirectly. */
-	init_gdt();
+	/* Complete percpu area setup early, before calling printk(),
+	   since it may end up using it indirectly. */
+	setup_percpu_for_this_cpu(cpu);
+	/* FIXME: Always the idle thread, can get rid of early_current. */
+	__get_cpu_var(current_task) =3D curr;
+
+	/* Set up GDT entry for 16bit stack */
+	stk16_off =3D (u32)&__get_cpu_var(cpu_16bit_stack);
+	gdt =3D __get_cpu_var(cpu_gdt_table);
+	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=3D
+		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
+		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
+		(CPU_16BIT_STACK_SIZE - 1);
 =

 	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
 =

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/arch/i386/kernel/entry.S working-2.6.18-r=
c6-mm2-pda-to-percpu/arch/i386/kernel/entry.S
--- linux-2.6.18-rc6-mm2/arch/i386/kernel/entry.S	2006-09-19 14:54:23.00000=
0000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/entry.S	2006-09-1=
9 15:26:28.000000000 +1000
@@ -125,7 +125,7 @@ VM_MASK		=3D 0x00020000
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es; \
-	movl $(__KERNEL_PDA), %edx; \
+	movl $(__KERNEL_PERCPU), %edx; \
 	movl %edx, %gs
 =

 #define RESTORE_INT_REGS \
@@ -638,7 +638,7 @@ error_code:
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
 	movl %ecx, %es
-	movl $(__KERNEL_PDA), %ecx
+	movl $(__KERNEL_PERCPU), %ecx
 	movl %ecx, %gs
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/arch/i386/kernel/head.S working-2.6.18-rc=
6-mm2-pda-to-percpu/arch/i386/kernel/head.S
--- linux-2.6.18-rc6-mm2/arch/i386/kernel/head.S	2006-09-19 14:54:23.000000=
000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/head.S	2006-09-19=
 15:23:48.000000000 +1000
@@ -302,7 +302,7 @@ is386:	movl $2,%ecx		# set MP
 	movl %eax,%cr0
 =

 	call check_x87
-	lgdt cpu_gdt_descr
+	lgdt per_cpu__cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
@@ -523,12 +523,6 @@ idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
 	.long idt_table
 =

-# boot GDT descriptor (later on used by CPU#0):
-	.word 0				# 32 bit align gdt_desc.address
-cpu_gdt_descr:
-	.word GDT_ENTRIES*8-1
-	.long cpu_gdt_table
-
 /*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
  * used only for booting.
@@ -539,55 +533,3 @@ ENTRY(boot_gdt_table)
 	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
 =

-/*
- * The Global Descriptor Table contains 28 quadwords, per-CPU.
- */
-	.align L1_CACHE_BYTES
-ENTRY(cpu_gdt_table)
-	.quad 0x0000000000000000	/* NULL descriptor */
-	.quad 0x0000000000000000	/* 0x0b reserved */
-	.quad 0x0000000000000000	/* 0x13 reserved */
-	.quad 0x0000000000000000	/* 0x1b reserved */
-	.quad 0x0000000000000000	/* 0x20 unused */
-	.quad 0x0000000000000000	/* 0x28 unused */
-	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
-	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
-	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
-	.quad 0x0000000000000000	/* 0x4b reserved */
-	.quad 0x0000000000000000	/* 0x53 reserved */
-	.quad 0x0000000000000000	/* 0x5b reserved */
-
-	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
-	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
-	.quad 0x00cffa000000ffff	/* 0x73 user 4GB code at 0x00000000 */
-	.quad 0x00cff2000000ffff	/* 0x7b user 4GB data at 0x00000000 */
-
-	.quad 0x0000000000000000	/* 0x80 TSS descriptor */
-	.quad 0x0000000000000000	/* 0x88 LDT descriptor */
-
-	/*
-	 * Segments used for calling PnP BIOS have byte granularity.
-	 * They code segments and data segments have fixed 64k limits,
-	 * the transfer segment sizes are set at run time.
-	 */
-	.quad 0x00409a000000ffff	/* 0x90 32-bit code */
-	.quad 0x00009a000000ffff	/* 0x98 16-bit code */
-	.quad 0x000092000000ffff	/* 0xa0 16-bit data */
-	.quad 0x0000920000000000	/* 0xa8 16-bit data */
-	.quad 0x0000920000000000	/* 0xb0 16-bit data */
-
-	/*
-	 * The APM segments have byte granularity and their bases
-	 * are set at run time.  All have 64k limits.
-	 */
-	.quad 0x00409a000000ffff	/* 0xb8 APM CS    code */
-	.quad 0x00009a000000ffff	/* 0xc0 APM CS 16 code (16 bit) */
-	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
-
-	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - PDA */
-	.quad 0x0000000000000000	/* 0xe0 - unused */
-	.quad 0x0000000000000000	/* 0xe8 - unused */
-	.quad 0x0000000000000000	/* 0xf0 - unused */
-	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
-
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/arch/i386/kernel/process.c working-2.6.18=
-rc6-mm2-pda-to-percpu/arch/i386/kernel/process.c
--- linux-2.6.18-rc6-mm2/arch/i386/kernel/process.c	2006-09-19 14:54:24.000=
000000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/process.c	2006-09=
-19 15:26:28.000000000 +1000
@@ -38,6 +38,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/personality.h>
+#include <linux/percpu.h>
 =

 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -56,7 +57,6 @@
 =

 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
-#include <asm/pda.h>
 =

 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 =

@@ -345,7 +345,7 @@ int kernel_thread(int (*fn)(void *), voi
 =

 	regs.xds =3D __USER_DS;
 	regs.xes =3D __USER_DS;
-	regs.xgs =3D __KERNEL_PDA;
+	regs.xgs =3D __KERNEL_PERCPU;
 	regs.orig_eax =3D -1;
 	regs.eip =3D (unsigned long) kernel_thread_helper;
 	regs.xcs =3D __KERNEL_CS | get_kernel_rpl();
@@ -684,7 +684,7 @@ struct task_struct fastcall * __switch_t
 	if (unlikely(prev->fs | next->fs))
 		loadsegment(fs, next->fs);
 =

-	write_pda(pcurrent, next_p);
+	x86_write_percpu(current_task, next_p);
 =

 	/*
 	 * Restore IOPL if needed.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/arch/i386/kernel/setup.c working-2.6.18-r=
c6-mm2-pda-to-percpu/arch/i386/kernel/setup.c
--- linux-2.6.18-rc6-mm2/arch/i386/kernel/setup.c	2006-09-19 14:54:24.00000=
0000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/setup.c	2006-09-1=
9 15:26:28.000000000 +1000
@@ -1470,6 +1470,52 @@ void __init setup_arch(char **cmdline_p)
 	tsc_init();
 }
 =

+/*
+ * The Global Descriptor Table contains 28 quadwords, per-CPU.
+ */
+__attribute__((aligned(L1_CACHE_BYTES)))
+DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]) =3D
+{
+	/* kernel 4GB code at 0x00000000 */
+	[GDT_ENTRY_KERNEL_CS] =3D { 0x0000ffff, 0x00cf9a00 },
+	/* kernel 4GB data at 0x00000000 */
+	[GDT_ENTRY_KERNEL_DS] =3D { 0x0000ffff, 0x00cf9200 },
+	/* user 4GB code at 0x00000000 */
+	[GDT_ENTRY_DEFAULT_USER_CS] =3D { 0x0000ffff, 0x00cffa00 },
+	/* user 4GB data at 0x00000000 */
+	[GDT_ENTRY_DEFAULT_USER_DS] =3D { 0x0000ffff, 0x00cff200 },
+	/*
+	 * Segments used for calling PnP BIOS have byte granularity.
+	 * They code segments and data segments have fixed 64k limits,
+	 * the transfer segment sizes are set at run time.
+	 */
+	[GDT_ENTRY_PNPBIOS_BASE] =3D
+	{ 0x0000ffff, 0x00409a00 }, /* 32-bit code */
+	{ 0x0000ffff, 0x00009a00 }, /* 16-bit code */
+	{ 0x0000ffff, 0x00009200 }, /* 16-bit data */
+	{ 0x00000000, 0x00009200 }, /* 16-bit data */
+	{ 0x00000000, 0x00009200 }, /* 16-bit data */
+
+	/*
+	 * The APM segments have byte granularity and their bases
+	 * are set at run time.  All have 64k limits.
+	 */
+	[GDT_ENTRY_APMBIOS_BASE] =3D
+	{ 0x0000ffff, 0x00409a00 }, /* APM CS    code */
+	{ 0x0000ffff, 0x00009a00 }, /* APM CS 16 code (16 bit) */
+	{ 0x0000ffff, 0x00409200 }, /* APM DS    data */
+
+	/* ESPFIX 16-bit SS */
+	[GDT_ENTRY_ESPFIX_SS] =3D { 0x00000000, 0x00009200 },
+	/* FIXME: We save/restore %gs even on UP: fix entry.S. */
+	[GDT_ENTRY_PERCPU] =3D { 0x0000ffff, 0x00cf9200 },
+};
+
+/* Early in boot we use the master per-cpu gdt_table directly. */
+DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr) =

+=3D { .size =3D GDT_ENTRIES*8-1, .address =3D (long)&per_cpu__cpu_gdt_tabl=
e };
+EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
+
 static __init int add_pcspkr(void)
 {
 	struct platform_device *pd;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/arch/i386/kernel/smpboot.c working-2.6.18=
-rc6-mm2-pda-to-percpu/arch/i386/kernel/smpboot.c
--- linux-2.6.18-rc6-mm2/arch/i386/kernel/smpboot.c	2006-09-19 14:54:24.000=
000000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/arch/i386/kernel/smpboot.c	2006-09=
-19 15:26:28.000000000 +1000
@@ -60,6 +60,9 @@
 /* Set if we find a B stepping CPU */
 static int __devinitdata smp_b_stepping;
 =

+DEFINE_PER_CPU(unsigned int, processor_id);
+EXPORT_PER_CPU_SYMBOL(processor_id);
+
 /* Number of siblings per CPU package */
 int smp_num_siblings =3D 1;
 #ifdef CONFIG_X86_HT
@@ -104,6 +107,9 @@ EXPORT_SYMBOL(x86_cpu_to_apicid);
 =

 u8 apicid_2_node[MAX_APICID];
 =

+DEFINE_PER_CPU(unsigned long, this_cpu_off);
+EXPORT_PER_CPU_SYMBOL(this_cpu_off);
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -934,14 +940,6 @@ static int __devinit do_boot_cpu(int api
 	unsigned long start_eip;
 	unsigned short nmi_high =3D 0, nmi_low =3D 0;
 =

-	/* Pre-allocate the CPU's GDT and PDA so it doesn't have to do
-	   any memory allocation during the delicate CPU-bringup
-	   phase. */
-	if (!alloc_gdt(cpu)) {
-		printk(KERN_INFO "Couldn't allocate GDT/PDA for CPU %d\n", cpu);
-		return -1;	/* ? */
-	}
-
 	++cpucount;
 	alternatives_smp_switch(1);
 =

@@ -1072,7 +1070,6 @@ static int __cpuinit __smp_prepare_cpu(i
 	struct warm_boot_cpu_info info;
 	struct work_struct task;
 	int	apicid, ret;
-	struct Xgt_desc_struct *cpu_gdt_descr =3D &per_cpu(cpu_gdt_descr, cpu);
 =

 	apicid =3D x86_cpu_to_apicid[cpu];
 	if (apicid =3D=3D BAD_APICID) {
@@ -1080,18 +1077,6 @@ static int __cpuinit __smp_prepare_cpu(i
 		goto exit;
 	}
 =

-	/*
-	 * the CPU isn't initialized at boot time, allocate gdt table here.
-	 * cpu_init will initialize it
-	 */
-	if (!cpu_gdt_descr->address) {
-		cpu_gdt_descr->address =3D get_zeroed_page(GFP_KERNEL);
-		if (!cpu_gdt_descr->address)
-			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
-			ret =3D -ENOMEM;
-			goto exit;
-	}
-
 	info.complete =3D &done;
 	info.apicid =3D apicid;
 	info.cpu =3D cpu;
@@ -1330,6 +1315,37 @@ static void __init smp_boot_cpus(unsigne
 		synchronize_tsc_bp();
 }
 =

+static inline void set_kernel_gs(void)
+{
+	/* Set %gs for this CPU's per-cpu area.  Memory clobber is to create a
+	   barrier with respect to any per-cpu operations, so the compiler
+	   doesn't move any before here. */
+	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PERCPU) : "memory");
+}
+
+static __cpuinit void setup_percpu_descriptor(struct desc_struct *gdt,
+					      unsigned long per_cpu_off)
+{
+	unsigned limit, flags;
+
+	limit =3D (1 << 20);
+	flags =3D 0x8;		/* 4k granularity */
+
+	/* present read-write data segment */
+	pack_descriptor((u32 *)&gdt->a, (u32 *)&gdt->b,
+			per_cpu_off, limit - 1,
+			0x80 | DESCTYPE_S | 0x2, flags);
+}
+
+/* Set up a very early per-cpu for the boot CPU so that smp_processor_id()
+   and current will work. */
+void __init smp_setup_processor_id(void)
+{
+	/* We use the per-cpu template area (__per_cpu_offset[0] =3D=3D 0). */
+	__per_cpu_offset[0] =3D 0;
+	setup_percpu_for_this_cpu(0);
+}
+
 /* These are wrappers to interface to the new boot process.  Someone
    who understands all this stuff should rewrite it properly. --RR 15/Jul/=
02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -1340,8 +1356,26 @@ void __init smp_prepare_cpus(unsigned in
 	smp_boot_cpus(max_cpus);
 }
 =

+/* Be careful not to use %gs references until this is setup: needs to
+ * be done on this CPU. */
+void __init setup_percpu_for_this_cpu(unsigned int cpu)
+{
+	struct desc_struct *gdt =3D per_cpu(cpu_gdt_table, cpu);
+	struct Xgt_desc_struct *cpu_gdt_descr =3D &per_cpu(cpu_gdt_descr, cpu);
+
+	per_cpu(processor_id, cpu) =3D cpu;
+	per_cpu(this_cpu_off, cpu) =3D __per_cpu_offset[cpu];
+	setup_percpu_descriptor(&gdt[GDT_ENTRY_PERCPU],	__per_cpu_offset[cpu]);
+	cpu_gdt_descr->address =3D (unsigned long)gdt;
+	cpu_gdt_descr->size =3D GDT_SIZE - 1;
+	load_gdt(cpu_gdt_descr);
+	set_kernel_gs();
+}
+
 void __devinit smp_prepare_boot_cpu(void)
 {
+	setup_percpu_for_this_cpu(0);
+
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 	cpu_set(smp_processor_id(), cpu_present_map);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/current.h working-2.6.18=
-rc6-mm2-pda-to-percpu/include/asm-i386/current.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/current.h	2006-09-19 14:55:55.000=
000000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/current.h	2006-09=
-19 15:26:28.000000000 +1000
@@ -2,7 +2,7 @@
 #define _I386_CURRENT_H
 =

 #include <linux/thread_info.h>
-#include <asm/pda.h>
+#include <asm/percpu.h>
 =

 struct task_struct;
 =

@@ -11,11 +11,7 @@ static __always_inline struct task_struc
 	return current_thread_info()->task;
 }
 =

-static __always_inline struct task_struct *get_current(void)
-{
-	return read_pda(pcurrent);
-}
-
-#define current get_current()
+DECLARE_PER_CPU(struct task_struct *, current_task);
+#define current x86_read_percpu(current_task)
 =

 #endif /* !(_I386_CURRENT_H) */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/desc.h working-2.6.18-rc=
6-mm2-pda-to-percpu/include/asm-i386/desc.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/desc.h	2006-09-19 14:55:55.000000=
000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/desc.h	2006-09-19=
 15:23:48.000000000 +1000
@@ -14,8 +14,8 @@
 =

 #include <asm/mmu.h>
 =

-extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
-
+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
+DECLARE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 =

 struct Xgt_desc_struct {
@@ -25,8 +25,6 @@ struct Xgt_desc_struct {
 } __attribute__ ((packed));
 =

 extern struct Xgt_desc_struct idt_descr;
-DECLARE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
-
 =

 static inline struct desc_struct *get_cpu_gdt_table(unsigned int cpu)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/pda.h working-2.6.18-rc6=
-mm2-pda-to-percpu/include/asm-i386/pda.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/pda.h	2006-09-19 14:55:56.0000000=
00 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/pda.h	1970-01-01 =
10:00:00.000000000 +1000
@@ -1,68 +0,0 @@
-#ifndef _I386_PDA_H
-#define _I386_PDA_H
-
-struct i386_pda
-{
-	struct task_struct *pcurrent;	/* current process */
-	int cpu_number;
-};
-
-extern struct i386_pda *_cpu_pda[];
-
-#define cpu_pda(i)	(_cpu_pda[i])
-
-#define pda_offset(field) offsetof(struct i386_pda, field)
-
-extern void __bad_pda_field(void);
-
-extern struct i386_pda _proxy_pda;
-
-#define pda_to_op(op,field,val)						\
-	do {								\
-		typedef typeof(_proxy_pda.field) T__;			\
-		if (0) { T__ tmp__; tmp__ =3D (val); }			\
-		switch (sizeof(_proxy_pda.field)) {			\
-		case 2:							\
-			asm(op "w %1,%%gs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
-			    :"ri" ((T__)val),				\
-			     "i"(pda_offset(field)));			\
-			break;						\
-		case 4:							\
-			asm(op "l %1,%%gs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
-			    :"ri" ((T__)val),				\
-			     "i"(pda_offset(field)));			\
-			break;						\
-		default: __bad_pda_field();				\
-		}							\
-	} while (0)
-
-#define pda_from_op(op,field)						\
-	({								\
-		typeof(_proxy_pda.field) ret__;				\
-		switch (sizeof(_proxy_pda.field)) {			\
-		case 2:							\
-			asm(op "w %%gs:%c1,%0"				\
-			    : "=3Dr" (ret__)				\
-			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
-			break;						\
-		case 4:							\
-			asm(op "l %%gs:%c1,%0"				\
-			    : "=3Dr" (ret__)				\
-			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
-			break;						\
-		default: __bad_pda_field();				\
-		}							\
-		ret__; })
-
-
-#define read_pda(field) pda_from_op("mov",field)
-#define write_pda(field,val) pda_to_op("mov",field,val)
-#define add_pda(field,val) pda_to_op("add",field,val)
-#define sub_pda(field,val) pda_to_op("sub",field,val)
-#define or_pda(field,val) pda_to_op("or",field,val)
-
-#endif	/* _I386_PDA_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/percpu.h working-2.6.18-=
rc6-mm2-pda-to-percpu/include/asm-i386/percpu.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/percpu.h	2004-02-04 14:44:44.0000=
00000 +1100
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/percpu.h	2006-09-=
19 15:26:28.000000000 +1000
@@ -1,6 +1,107 @@
 #ifndef __ARCH_I386_PERCPU__
 #define __ARCH_I386_PERCPU__
 =

+#ifdef CONFIG_SMP
+/* Same as generic implementation except for optimized local access. */
+#define __GENERIC_PER_CPU
+
+/* This is used for other cpus to find our section. */
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* Separate out the type, so (int[3], foo) works. */
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu_=
_##name
+
+/* We can use this directly for local CPU (faster). */
+DECLARE_PER_CPU(unsigned long, this_cpu_off);
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*({				\
+	extern int simple_indentifier_##var(void);	\
+	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
+
+#define __raw_get_cpu_var(var) (*({					\
+	extern int simple_indentifier_##var(void);			\
+	RELOC_HIDE(&per_cpu__##var, x86_read_percpu(this_cpu_off));	\
+}))
+
+#define __get_cpu_var(var) __raw_get_cpu_var(var)
+
+/* A macro to avoid #include hell... */
+#define percpu_modcopy(pcpudst, src, size)			\
+do {								\
+	unsigned int __i;					\
+	for_each_possible_cpu(__i)				\
+		memcpy((pcpudst)+__per_cpu_offset[__i],		\
+		       (src), (size));				\
+} while (0)
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+
+/* gs segment starts at (positive) offset =3D=3D __per_cpu_offset[cpu] */
+#define __percpu_seg "%%gs:"
+#else  /* !SMP */
 #include <asm-generic/percpu.h>
+#define __percpu_seg ""
+#endif	/* SMP */
+
+/* For arch-specific code, we can use direct single-insn ops (they
+ * don't give an lvalue though). */
+extern void __bad_percpu_size(void);
+
+#define percpu_to_op(op,var,val)				\
+	do {							\
+		typedef typeof(var) T__;			\
+		if (0) { T__ tmp__; tmp__ =3D (val); }		\
+		switch (sizeof(var)) {				\
+		case 1:						\
+			asm(op "b %1,"__percpu_seg"%0"		\
+			    : "+m" (var)			\
+			    :"ri" ((T__)val));			\
+			break;					\
+		case 2:						\
+			asm(op "w %1,"__percpu_seg"%0"		\
+			    : "+m" (var)			\
+			    :"ri" ((T__)val));			\
+			break;					\
+		case 4:						\
+			asm(op "l %1,"__percpu_seg"%0"		\
+			    : "+m" (var)			\
+			    :"ri" ((T__)val));			\
+			break;					\
+		default: __bad_percpu_size();			\
+		}						\
+	} while (0)
+
+#define percpu_from_op(op,var)					\
+	({							\
+		typeof(var) ret__;				\
+		switch (sizeof(var)) {				\
+		case 1:						\
+			asm(op "b "__percpu_seg"%1,%0"		\
+			    : "=3Dr" (ret__)			\
+			    : "m" (var));			\
+			break;					\
+		case 2:						\
+			asm(op "w "__percpu_seg"%1,%0"		\
+			    : "=3Dr" (ret__)			\
+			    : "m" (var));			\
+			break;					\
+		case 4:						\
+			asm(op "l "__percpu_seg"%1,%0"		\
+			    : "=3Dr" (ret__)			\
+			    : "m" (var));			\
+			break;					\
+		default: __bad_percpu_size();			\
+		}						\
+		ret__; })
+
+#define x86_read_percpu(var) percpu_from_op("mov", per_cpu__##var)
+#define x86_write_percpu(var,val) percpu_to_op("mov", per_cpu__##var, val)
+#define x86_add_percpu(var,val) percpu_to_op("add", per_cpu__##var, val)
+#define x86_sub_percpu(var,val) percpu_to_op("sub", per_cpu__##var, val)
+#define x86_or_percpu(var,val) percpu_to_op("or", per_cpu__##var, val)
 =

 #endif /* __ARCH_I386_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/processor.h working-2.6.=
18-rc6-mm2-pda-to-percpu/include/asm-i386/processor.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/processor.h	2006-09-19 14:55:56.0=
00000000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/processor.h	2006-=
09-19 15:26:28.000000000 +1000
@@ -473,7 +473,7 @@ struct thread_struct {
 	.vm86_info =3D NULL,						\
 	.sysenter_cs =3D __KERNEL_CS,					\
 	.io_bitmap_ptr =3D NULL,						\
-	.gs =3D __KERNEL_PDA,						\
+	.gs =3D __KERNEL_PERCPU,						\
 }
 =

 /*
@@ -728,6 +728,5 @@ extern void select_idle_routine(const st
 extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
-extern int alloc_gdt(int cpu);
 =

 #endif /* __ASM_I386_PROCESSOR_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/segment.h working-2.6.18=
-rc6-mm2-pda-to-percpu/include/asm-i386/segment.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/segment.h	2006-09-19 14:55:56.000=
000000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/segment.h	2006-09=
-19 15:26:28.000000000 +1000
@@ -39,7 +39,7 @@
  *  25 - APM BIOS support =

  *
  *  26 - ESPFIX small SS
- *  27 - PDA				[ per-cpu private data area ]
+ *  27 - PERCPU				[ offset segment for per-cpu area ]
  *  28 - unused
  *  29 - unused
  *  30 - unused
@@ -74,8 +74,8 @@
 #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
 =

-#define GDT_ENTRY_PDA			(GDT_ENTRY_KERNEL_BASE + 15)
-#define __KERNEL_PDA (GDT_ENTRY_PDA * 8)
+#define GDT_ENTRY_PERCPU		(GDT_ENTRY_KERNEL_BASE + 15)
+#define __KERNEL_PERCPU (GDT_ENTRY_PERCPU * 8)
 =

 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 =

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/smp.h working-2.6.18-rc6=
-mm2-pda-to-percpu/include/asm-i386/smp.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/smp.h	2006-09-19 14:55:56.0000000=
00 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/smp.h	2006-09-19 =
15:27:59.000000000 +1000
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <asm/pda.h>
+#include <asm/percpu.h>
 #endif
 =

 #ifdef CONFIG_X86_LOCAL_APIC
@@ -59,7 +59,8 @@ extern void cpu_uninit(void);
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (read_pda(cpu_number))
+DECLARE_PER_CPU(unsigned int, processor_id);
+#define raw_smp_processor_id() (x86_read_percpu(processor_id))
 /* This is valid from the very earliest point in boot that we care
    about. */
 #define early_smp_processor_id() (current_thread_info()->cpu)
@@ -93,6 +94,8 @@ extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 extern unsigned int num_processors;
 =

+void setup_percpu_for_this_cpu(unsigned int cpu);
+
 #endif /* !__ASSEMBLY__ */
 =

 #else /* CONFIG_SMP */
@@ -100,6 +103,7 @@ extern unsigned int num_processors;
 #define safe_smp_processor_id()		0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
 #define early_smp_processor_id()	0
+#define setup_percpu_for_this_cpu(cpu)
 =

 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 =

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.18-rc6-mm2/include/asm-i386/unwind.h working-2.6.18-=
rc6-mm2-pda-to-percpu/include/asm-i386/unwind.h
--- linux-2.6.18-rc6-mm2/include/asm-i386/unwind.h	2006-09-19 14:55:56.0000=
00000 +1000
+++ working-2.6.18-rc6-mm2-pda-to-percpu/include/asm-i386/unwind.h	2006-09-=
19 15:26:28.000000000 +1000
@@ -65,7 +65,7 @@ static inline void arch_unw_init_blocked
 	info->regs.xss =3D __KERNEL_DS;
 	info->regs.xds =3D __USER_DS;
 	info->regs.xes =3D __USER_DS;
-	info->regs.xgs =3D __KERNEL_PDA;
+	info->regs.xgs =3D __KERNEL_PERCPU;
 }
 =

 extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,

-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
