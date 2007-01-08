From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH] x86_64 paravirt_ops port
Date: Mon, 8 Jan 2007 12:08:26 -0200
Message-ID: <20070108140826.GA1624@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've been working on a port of paravirt_ops for the x86_64 architectures
for a couple of days. Here's the result so far. I'm posting it soon for
early cooments. The more, the better.

It's obviously based on the previous work for i386, with the needed
modifications. By now, I'm able to boot a bare metal kernel, but there
are still some known issues, that are in my TODO list for the next days.
Highlighting, 

* There are still some hardcoded references to lidt instructions spread
over, that need to be replaced
* Code to init guests, as in 32-bit's startup_32
* patching works (sometimes). Still work needed to stabilize it.

So, here it goes. 
Comments welcome
 
-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="paravirt_x86_64.patch"

Index: linux-2.6.19-quilt/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/Kconfig
+++ linux-2.6.19-quilt/arch/x86_64/Kconfig
@@ -336,6 +336,18 @@ config NODES_SHIFT
 
 # Dummy CONFIG option to select ACPI_NUMA from drivers/acpi/Kconfig.
 
+config PARAVIRT
+       bool "Paravirtualization support (EXPERIMENTAL)"
+       depends on EXPERIMENTAL
+       help
+         Paravirtualization is a way of running multiple instances of
+         Linux on the same machine, under a hypervisor.  This option
+         changes the kernel so it can modify itself when it is run
+         under a hypervisor, improving performance significantly.
+         However, when run without a hypervisor the kernel is
+         theoretically slower.  If in doubt, say N.
+
+
 config X86_64_ACPI_NUMA
        bool "ACPI NUMA detection"
        depends on NUMA
Index: linux-2.6.19-quilt/arch/x86_64/Kconfig.debug
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/Kconfig.debug
+++ linux-2.6.19-quilt/arch/x86_64/Kconfig.debug
@@ -55,6 +55,17 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config DEBUG_PARAVIRT
+       bool "Enable some paravirtualization debugging"
+       default y
+       depends on PARAVIRT && DEBUG_KERNEL
+       help
+         Currently deliberately clobbers regs which are allowed to be
+         clobbered in inlined paravirt hooks, even in native mode.
+         If turning this off solves a problem, then DISABLE_INTERRUPTS() or
+         ENABLE_INTERRUPTS() is lying about what registers can be clobbered.
+
+
 #config X86_REMOTE_DEBUG
 #       bool "kgdb debugging stub"
 
Index: linux-2.6.19-quilt/arch/x86_64/kernel/asm-offsets.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/asm-offsets.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/asm-offsets.c
@@ -15,6 +15,7 @@
 #include <asm/segment.h>
 #include <asm/thread_info.h>
 #include <asm/ia32.h>
+#include <asm/paravirt.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -71,5 +72,17 @@ int main(void)
 	DEFINE(TSS_ist, offsetof(struct tss_struct, ist));
 	BLANK();
 	DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
+
+#ifdef CONFIG_PARAVIRT
+#define ENTRY(entry) DEFINE(PARAVIRT_ ## entry, offsetof(struct paravirt_ops, entry))
+	BLANK();
+	ENTRY(paravirt_enabled);
+	ENTRY(irq_disable);
+	ENTRY(irq_enable);
+	ENTRY(irq_enable_sysexit);
+	ENTRY(iret);
+	ENTRY(read_cr0);
+#endif
+
 	return 0;
 }
Index: linux-2.6.19-quilt/arch/x86_64/kernel/entry.S
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.19-quilt/arch/x86_64/kernel/entry.S
@@ -1064,6 +1064,22 @@ KPROBE_ENTRY(int3)
  	CFI_ENDPROC
 KPROBE_END(int3)
 
+#ifdef CONFIG_PARAVIRT
+ENTRY(native_iret)
+1:	iretq
+.section __ex_table,"a"
+	.align 8
+	.quad 1b, bad_iret
+.previous
+ENDPROC(native_iret)
+
+ENTRY(native_irq_enable_sysexit)
+	sti
+	sysretq
+ENDPROC(native_irq_enable_sysexit)
+
+#endif /* CONFIG_PARAVIRT */
+
 ENTRY(overflow)
 	zeroentry do_overflow
 END(overflow)
Index: linux-2.6.19-quilt/arch/x86_64/kernel/head64.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/head64.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/head64.c
@@ -70,7 +70,7 @@ void __init x86_64_start_kernel(char * r
 	 * switch to init_level4_pgt from boot_level4_pgt
 	 */
 	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
-	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+	write_cr3(__pa_symbol(&init_level4_pgt));
 
  	for (i = 0; i < NR_CPUS; i++)
  		cpu_pda(i) = &boot_cpu_pda[i];
Index: linux-2.6.19-quilt/arch/x86_64/kernel/i8259.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/i8259.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/i8259.c
@@ -501,7 +501,10 @@ static int __init init_timer_sysfs(void)
 
 device_initcall(init_timer_sysfs);
 
-void __init init_IRQ(void)
+/* Overridden in paravirt.c */
+void init_IRQ(void) __attribute__((weak, alias("native_init_IRQ")));
+
+void __init native_init_IRQ(void)
 {
 	int i;
 
Index: linux-2.6.19-quilt/arch/x86_64/kernel/Makefile
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/Makefile
+++ linux-2.6.19-quilt/arch/x86_64/kernel/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_AUDIT)		+= audit.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_PCI)		+= early-quirks.o
 
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o
+
 obj-y				+= topology.o
 obj-y				+= intel_cacheinfo.o
 
Index: linux-2.6.19-quilt/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/process.c
@@ -334,10 +334,10 @@ void __show_regs(struct pt_regs * regs)
 	rdmsrl(MSR_GS_BASE, gs); 
 	rdmsrl(MSR_KERNEL_GS_BASE, shadowgs); 
 
-	asm("movq %%cr0, %0": "=r" (cr0));
-	asm("movq %%cr2, %0": "=r" (cr2));
-	asm("movq %%cr3, %0": "=r" (cr3));
-	asm("movq %%cr4, %0": "=r" (cr4));
+	cr0 = read_cr0();
+	cr2 = read_cr2();
+	cr3 = read_cr3();
+	cr4 = read_cr4();
 
 	printk("FS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n", 
 	       fs,fsindex,gs,gsindex,shadowgs); 
@@ -574,7 +574,7 @@ __switch_to(struct task_struct *prev_p, 
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
-	tss->rsp0 = next->rsp0;
+	load_rsp0(tss,next);
 
 	/* 
 	 * Switch DS and ES.
Index: linux-2.6.19-quilt/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/setup.c
@@ -356,7 +356,7 @@ void __init setup_arch(char **cmdline_p)
 	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
-	setup_memory_region();
+	memory_setup();
 	copy_edd();
 
 	if (!MOUNT_ROOT_RDONLY)
@@ -561,6 +561,11 @@ static int __cpuinit get_model_name(stru
 	return 1;
 }
 
+/* Overridden in paravirt.c if CONFIG_PARAVIRT */
+void __attribute__((weak)) memory_setup(void)
+{
+       return setup_memory_region();
+}
 
 static void __cpuinit display_cacheinfo(struct cpuinfo_x86 *c)
 {
Index: linux-2.6.19-quilt/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/smpboot.c
@@ -848,7 +848,7 @@ do_rest:
 	start_rip = setup_trampoline();
 
 	init_rsp = c_idle.idle->thread.rsp;
-	per_cpu(init_tss,cpu).rsp0 = init_rsp;
+	load_rsp0(&per_cpu(init_tss,cpu), &c_idle.idle->thread);
 	initial_code = start_secondary;
 	clear_tsk_thread_flag(c_idle.idle, TIF_FORK);
 
Index: linux-2.6.19-quilt/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/time.c
@@ -42,6 +42,7 @@
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
 #include <asm/apic.h>
+#include <asm/time.h>
 
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
@@ -204,17 +205,11 @@ EXPORT_SYMBOL(profile_pc);
  * sheet for details.
  */
 
-static void set_rtc_mmss(unsigned long nowtime)
+void do_set_rtc_mmss(unsigned long nowtime)
 {
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char control, freq_select;
 
-/*
- * IRQs are disabled when we're called from the timer interrupt,
- * no need for spin_lock_irqsave()
- */
-
-	spin_lock(&rtc_lock);
 
 /*
  * Tell the clock it's being set and stop it.
@@ -263,9 +258,18 @@ static void set_rtc_mmss(unsigned long n
 	CMOS_WRITE(control, RTC_CONTROL);
 	CMOS_WRITE(freq_select, RTC_FREQ_SELECT);
 
-	spin_unlock(&rtc_lock);
 }
 
+static void set_rtc_mmss(unsigned long nowtime)
+{
+/*
+ * IRQs are disabled when we're called from the timer interrupt,
+ * no need for spin_lock_irqsave()
+ */
+	spin_lock(&rtc_lock);
+	set_wallclock(nowtime);
+	spin_unlock(&rtc_lock);
+}
 
 /* monotonic_clock(): returns # of nanoseconds passed since time_init()
  *		Note: This function is required to return accurate
@@ -494,13 +498,11 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
-static unsigned long get_cmos_time(void)
+unsigned long do_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	unsigned long flags;
 	unsigned extyear = 0;
 
-	spin_lock_irqsave(&rtc_lock, flags);
 
 	do {
 		sec = CMOS_READ(RTC_SECONDS);
@@ -516,7 +518,6 @@ static unsigned long get_cmos_time(void)
 #endif
 	} while (sec != CMOS_READ(RTC_SECONDS));
 
-	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	/*
 	 * We know that x86-64 always uses BCD format, no need to check the
@@ -545,6 +546,15 @@ static unsigned long get_cmos_time(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+static unsigned long get_cmos_time(void)
+{
+	unsigned long retval, flags;
+	/* XXX : lock being held more than necessary. */
+	spin_lock_irqsave(&rtc_lock, flags);
+	retval = get_wallclock();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return retval;
+}
 #ifdef CONFIG_CPU_FREQ
 
 /* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
@@ -876,6 +886,11 @@ static struct irqaction irq0 = {
 	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
 
+inline void time_init_hook()
+{
+	setup_irq(0, &irq0);
+}
+
 void __init time_init(void)
 {
 	if (nohpet)
@@ -915,7 +930,7 @@ void __init time_init(void)
 	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
 	vxtime.last_tsc = get_cycles_sync();
 	set_cyc2ns_scale(cpu_khz);
-	setup_irq(0, &irq0);
+	do_time_init();
 
 #ifndef CONFIG_SMP
 	time_init_gtod();
Index: linux-2.6.19-quilt/arch/x86_64/kernel/reboot.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/reboot.c
+++ linux-2.6.19-quilt/arch/x86_64/kernel/reboot.c
@@ -131,7 +131,7 @@ void machine_emergency_restart(void)
 		}
 
 		case BOOT_TRIPLE: 
-			__asm__ __volatile__("lidt (%0)": :"r" (&no_idt));
+			load_idt((const struct desc_struct *)&no_idt);
 			__asm__ __volatile__("int3");
 
 			reboot_type = BOOT_KBD;
Index: linux-2.6.19-quilt/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux-2.6.19-quilt/arch/x86_64/kernel/vmlinux.lds.S
@@ -58,6 +58,12 @@ SECTIONS
 	CONSTRUCTORS
 	} :data
 
+  .paravirtprobe : AT(ADDR(.paravirtprobe) - LOAD_OFFSET) {
+	__start_paravirtprobe = .;
+	*(.paravirtprobe)
+	__stop_paravirtprobe = .;
+  }
+
   _edata = .;			/* End of data section */
 
   . = ALIGN(PAGE_SIZE);
@@ -177,14 +183,20 @@ SECTIONS
   __con_initcall_end = .;
   SECURITY_INIT
   . = ALIGN(8);
-  __alt_instructions = .;
   .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+	__alt_instructions = .;
 	*(.altinstructions)
+  	__alt_instructions_end = .;
   }
-  __alt_instructions_end = .; 
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
   }
+  . = ALIGN(8);
+  .parainstructions : AT(ADDR(.parainstructions)  - LOAD_OFFSET) {
+	__start_parainstructions = .;
+	*(.parainstructions)
+	__stop_parainstructions = .;
+  }
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
Index: linux-2.6.19-quilt/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/mm/fault.c
+++ linux-2.6.19-quilt/arch/x86_64/mm/fault.c
@@ -180,7 +180,7 @@ void dump_pagetable(unsigned long addres
 	pmd_t *pmd;
 	pte_t *pte;
 
-	asm("movq %%cr3,%0" : "=r" (pgd));
+	pgd = (pgd_t *)read_cr3();
 
 	pgd = __va((unsigned long)pgd & PHYSICAL_PAGE_MASK); 
 	pgd += pgd_index(address);
@@ -347,7 +347,7 @@ asmlinkage void __kprobes do_page_fault(
 	prefetchw(&mm->mmap_sem);
 
 	/* get the address */
-	__asm__("movq %%cr2,%0":"=r" (address));
+	address = read_cr2();
 
 	info.si_code = SEGV_MAPERR;
 
Index: linux-2.6.19-quilt/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/x86_64/mm/init.c
+++ linux-2.6.19-quilt/arch/x86_64/mm/init.c
@@ -384,7 +384,7 @@ void __meminit init_memory_mapping(unsig
 	} 
 
 	if (!after_bootmem)
-		asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
+		mmu_cr4_features = read_cr4();
 	__flush_tlb_all();
 }
 
@@ -398,7 +398,7 @@ void __cpuinit zap_low_mappings(int cpu)
 		 * For AP's, zap the low identity mappings by changing the cr3
 		 * to init_level4_pgt and doing local flush tlb all
 		 */
-		asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+		write_cr3(__pa_symbol(&init_level4_pgt));
 	}
 	__flush_tlb_all();
 }
Index: linux-2.6.19-quilt/include/asm-x86_64/apic.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/apic.h
+++ linux-2.6.19-quilt/include/asm-x86_64/apic.h
@@ -37,16 +37,24 @@ struct pt_regs;
  * Basic functions accessing APICs.
  */
 
-static __inline void apic_write(unsigned long reg, unsigned int v)
+static __inline void native_apic_write(unsigned long reg, unsigned int v)
 {
 	*((volatile unsigned int *)(APIC_BASE+reg)) = v;
 }
 
-static __inline unsigned int apic_read(unsigned long reg)
+static __inline unsigned int native_apic_read(unsigned long reg)
 {
 	return *((volatile unsigned int *)(APIC_BASE+reg));
 }
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define apic_write native_apic_write
+#define apic_read native_apic_read
+
+#endif /* CONFIG_PARAVIRT */
+
 static __inline__ void apic_wait_icr_idle(void)
 {
 	while (apic_read( APIC_ICR ) & APIC_ICR_BUSY)
Index: linux-2.6.19-quilt/include/asm-x86_64/desc.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/desc.h
+++ linux-2.6.19-quilt/include/asm-x86_64/desc.h
@@ -16,9 +16,8 @@
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 
-#define load_TR_desc() asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() asm volatile("lldt %w0"::"r" (GDT_ENTRY_LDT*8))
-#define clear_LDT()  asm volatile("lldt %w0"::"r" (0))
+/* the cpu gdt accessor */
+#define cpu_gdt(_cpu) ((struct desc_struct *)cpu_gdt_descr[_cpu].address)
 
 /*
  * This is the ldt that every process will get unless we need
@@ -28,8 +27,6 @@ extern struct desc_struct default_ldt[];
 extern struct gate_struct idt_table[]; 
 extern struct desc_ptr cpu_gdt_descr[];
 
-/* the cpu gdt accessor */
-#define cpu_gdt(_cpu) ((struct desc_struct *)cpu_gdt_descr[_cpu].address)
 
 static inline void _set_gate(void *adr, unsigned type, unsigned long func, unsigned dpl, unsigned ist)  
 {
@@ -115,7 +112,19 @@ static inline void set_seg_base(unsigned
 	d->base0 = addr & 0xffff;
 	d->base1 = (addr >> 16) & 0xff;
 	d->base2 = (addr >> 24) & 0xff;
-} 
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+
+#define load_TR_desc() asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8))
+#define set_ldt native_set_ldt
+#define load_TLS native_load_TLS
+#endif /* CONFIG_PARAVIRT */
+
+#define clear_LDT() set_ldt(NULL,0)
+
 
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
@@ -149,7 +158,7 @@ static inline void set_seg_base(unsigned
 # error update this code.
 #endif
 
-static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+static inline void native_load_TLS(struct thread_struct *t, unsigned int cpu)
 {
 	u64 *gdt = (u64 *)(cpu_gdt(cpu) + GDT_ENTRY_TLS_MIN);
 	gdt[0] = t->tls_array[0];
@@ -157,27 +166,33 @@ static inline void load_TLS(struct threa
 	gdt[2] = t->tls_array[2];
 } 
 
+static inline void native_set_ldt(const void *addr,
+					unsigned int entries)
+{
+	if (likely(entries == 0))
+		__asm__ __volatile__ ("lldt %w0" :: "r" (0));
+	else {
+		unsigned cpu = smp_processor_id();
+
+		set_tssldt_descriptor(&cpu_gdt(cpu)[GDT_ENTRY_LDT], (unsigned long)addr,
+			      DESC_LDT, entries * 8 - 1);
+		__asm__ __volatile__ ("lldt %w0"::"r" (GDT_ENTRY_LDT*8));
+	}
+}
+
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT_nolock (mm_context_t *pc, int cpu)
+static inline void load_LDT_nolock (mm_context_t *pc)
 {
-	int count = pc->size;
-
-	if (likely(!count)) {
-		clear_LDT();
-		return;
-	}
-		
-	set_ldt_desc(cpu, pc->ldt, count);
-	load_LDT_desc();
+	set_ldt(pc->ldt, pc->size);
 }
 
 static inline void load_LDT(mm_context_t *pc)
 {
-	int cpu = get_cpu();
-	load_LDT_nolock(pc, cpu);
-	put_cpu();
+	preempt_disable();
+	load_LDT_nolock(pc);
+	preempt_enable();
 }
 
 extern struct desc_ptr idt_descr;
Index: linux-2.6.19-quilt/include/asm-x86_64/irqflags.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/irqflags.h
+++ linux-2.6.19-quilt/include/asm-x86_64/irqflags.h
@@ -11,6 +11,16 @@
 #define _ASM_IRQFLAGS_H
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1 << 9));
+}
+
+#else
+
 /*
  * Interrupt control:
  */
@@ -30,8 +40,6 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 
-#define raw_local_save_flags(flags) \
-		do { (flags) = __raw_local_save_flags(); } while (0)
 
 static inline void raw_local_irq_restore(unsigned long flags)
 {
@@ -100,8 +108,6 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 
-#define raw_local_irq_save(flags) \
-		do { (flags) = __raw_local_irq_save(); } while (0)
 
 static inline int raw_irqs_disabled(void)
 {
@@ -128,6 +134,7 @@ static inline void halt(void)
 	__asm__ __volatile__("hlt": : :"memory");
 }
 
+#endif /* CONFIG_PARAVIRT */
 #else /* __ASSEMBLY__: */
 # ifdef CONFIG_TRACE_IRQFLAGS
 #  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk
@@ -138,4 +145,9 @@ static inline void halt(void)
 # endif
 #endif
 
+#define raw_local_save_flags(flags) \
+		do { (flags) = __raw_local_save_flags(); } while (0)
+
+#define raw_local_irq_save(flags) \
+		do { (flags) = __raw_local_irq_save(); } while (0)
 #endif
Index: linux-2.6.19-quilt/include/asm-x86_64/irq.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/irq.h
+++ linux-2.6.19-quilt/include/asm-x86_64/irq.h
@@ -46,6 +46,9 @@ static __inline__ int irq_canonicalize(i
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+void init_IRQ(void);
+void native_init_IRQ(void);
+
 #define __ARCH_HAS_DO_SOFTIRQ 1
 
 #endif /* _ASM_IRQ_H */
Index: linux-2.6.19-quilt/include/asm-x86_64/mmu_context.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/mmu_context.h
+++ linux-2.6.19-quilt/include/asm-x86_64/mmu_context.h
@@ -42,7 +42,7 @@ static inline void switch_mm(struct mm_s
 		load_cr3(next->pgd);
 
 		if (unlikely(next->context.ldt != prev->context.ldt)) 
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -55,7 +55,7 @@ static inline void switch_mm(struct mm_s
 			 * to make sure to use no freed page tables.
 			 */
 			load_cr3(next->pgd);
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 		}
 	}
 #endif
Index: linux-2.6.19-quilt/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/page.h
+++ linux-2.6.19-quilt/include/asm-x86_64/page.h
@@ -64,16 +64,44 @@ typedef struct { unsigned long pgd; } pg
 
 typedef struct { unsigned long pgprot; } pgprot_t;
 
+static inline unsigned long native_pte_val(pte_t pte)
+{
+	return pte.pte;
+}
+
+static inline unsigned long native_pud_val(pud_t pud)
+{
+	return pud.pud;
+}
+
+
+static inline unsigned long native_pmd_val(pmd_t pmd)
+{
+	return pmd.pmd;
+}
+
+static inline unsigned long native_pgd_val(pgd_t pgd)
+{
+	return pgd.pgd;
+}
+
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).pmd)
 #define pud_val(x)	((x).pud)
 #define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
 
 #define __pte(x) ((pte_t) { (x) } )
 #define __pmd(x) ((pmd_t) { (x) } )
 #define __pud(x) ((pud_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
+#endif /* CONFIG_PARAVIRT */
+
+#define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
 #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
Index: linux-2.6.19-quilt/include/asm-x86_64/pgtable.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/pgtable.h
+++ linux-2.6.19-quilt/include/asm-x86_64/pgtable.h
@@ -55,50 +55,60 @@ extern unsigned long empty_zero_page[PAG
  */
 #define PTRS_PER_PTE	512
 
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), pte_val(e))
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), pmd_val(e))
-#define pud_ERROR(e) \
-	printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), pud_val(e))
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), pgd_val(e))
-
-#define pgd_none(x)	(!pgd_val(x))
-#define pud_none(x)	(!pud_val(x))
 
-static inline void set_pte(pte_t *dst, pte_t val)
+static inline void native_set_pte(pte_t *dst, pte_t val)
 {
-	pte_val(*dst) = pte_val(val);
+	dst->pte = pte_val(val);
 } 
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
-static inline void set_pmd(pmd_t *dst, pmd_t val)
+
+static inline void native_set_pmd(pmd_t *dst, pmd_t val)
 {
-        pmd_val(*dst) = pmd_val(val); 
+	dst->pmd = pmd_val(val);
 } 
 
-static inline void set_pud(pud_t *dst, pud_t val)
+static inline void native_set_pud(pud_t *dst, pud_t val)
 {
-	pud_val(*dst) = pud_val(val);
+	dst->pud = pud_val(val);
 }
 
-static inline void pud_clear (pud_t *pud)
+static inline void set_pgd(pgd_t *dst, pgd_t val)
 {
-	set_pud(pud, __pud(0));
+	dst->pgd = pgd_val(val);
 }
-
-static inline void set_pgd(pgd_t *dst, pgd_t val)
+static inline void native_pud_clear (pud_t *pud)
 {
-	pgd_val(*dst) = pgd_val(val); 
-} 
+	set_pud(pud, __pud(0));
+}
 
 static inline void pgd_clear (pgd_t * pgd)
 {
 	set_pgd(pgd, __pgd(0));
 }
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define set_pte native_set_pte
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+#define set_pmd native_set_pmd
+#define set_pud native_set_pud
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
+#endif
+
+#define pgd_none(x)	(!pgd_val(x))
+#define pud_none(x)	(!pud_val(x))
+
+#define pte_ERROR(e) \
+	printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), pte_val(e))
+#define pmd_ERROR(e) \
+	printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), pmd_val(e))
+#define pud_ERROR(e) \
+	printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), pud_val(e))
+#define pgd_ERROR(e) \
+	printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), pgd_val(e))
 
 struct mm_struct;
 
@@ -238,7 +248,6 @@ static inline unsigned long pmd_bad(pmd_
 
 #define pte_none(x)	(!pte_val(x))
 #define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))	/* FIXME: is this
 						   right? */
@@ -247,11 +256,11 @@ static inline unsigned long pmd_bad(pmd_
 
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	pte_t pte;
-	pte_val(pte) = (page_nr << PAGE_SHIFT);
-	pte_val(pte) |= pgprot_val(pgprot);
-	pte_val(pte) &= __supported_pte_mask;
-	return pte;
+	unsigned long pte;
+	pte = (page_nr << PAGE_SHIFT);
+	pte |= pgprot_val(pgprot);
+	pte &= __supported_pte_mask;
+	return __pte(pte);
 }
 
 /*
@@ -345,7 +354,6 @@ static inline int pmd_large(pmd_t pte) {
 			pmd_index(address))
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define pfn_pmd(nr,prot) (__pmd(((nr) << PAGE_SHIFT) | pgprot_val(prot)))
 #define pmd_pfn(x)  ((pmd_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 
@@ -362,19 +370,20 @@ static inline int pmd_large(pmd_t pte) {
 /* physical address -> PTE */
 static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 { 
-	pte_t pte;
-	pte_val(pte) = physpage | pgprot_val(pgprot); 
-	pte_val(pte) &= __supported_pte_mask;
-	return pte; 
+	unsigned long pte;
+	pte = physpage | pgprot_val(pgprot);
+	pte &= __supported_pte_mask;
+	return __pte(pte);
 }
  
 /* Change flags of a PTE */
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte_old, pgprot_t newprot)
 { 
-	pte_val(pte) &= _PAGE_CHG_MASK;
-	pte_val(pte) |= pgprot_val(newprot);
-	pte_val(pte) &= __supported_pte_mask;
-       return pte; 
+	unsigned long pte = pte_val(pte_old);
+	pte &= _PAGE_CHG_MASK;
+	pte |= pgprot_val(newprot);
+	pte &= __supported_pte_mask;
+       return __pte(pte);
 }
 
 #define pte_index(address) \
Index: linux-2.6.19-quilt/include/asm-x86_64/processor.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/processor.h
+++ linux-2.6.19-quilt/include/asm-x86_64/processor.h
@@ -299,6 +299,10 @@ struct thread_struct {
 	set_fs(USER_DS);							 \
 } while(0) 
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define paravirt_enabled() 0
 #define get_debugreg(var, register)				\
 		__asm__("movq %%db" #register ", %0"		\
 			:"=r" (var))
@@ -306,6 +310,7 @@ struct thread_struct {
 		__asm__("movq %0,%%db" #register		\
 			: /* no output */			\
 			:"r" (value))
+#endif
 
 struct task_struct;
 struct mm_struct;
Index: linux-2.6.19-quilt/include/asm-x86_64/spinlock.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/spinlock.h
+++ linux-2.6.19-quilt/include/asm-x86_64/spinlock.h
@@ -6,6 +6,10 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
+
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  *
Index: linux-2.6.19-quilt/include/asm-x86_64/system.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/system.h
+++ linux-2.6.19-quilt/include/asm-x86_64/system.h
@@ -65,6 +65,9 @@ extern void load_gs_index(unsigned); 
 		".previous"			\
 		: :"r" (value), "r" (0))
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 /*
  * Clear and set 'TS' bit respectively
  */
@@ -99,12 +102,14 @@ static inline unsigned long read_cr4(voi
 static inline void write_cr4(unsigned long val)
 { 
 	asm volatile("movq %0,%%cr4" :: "r" (val));
-} 
-
-#define stts() write_cr0(8 | read_cr0())
+}
 
 #define wbinvd() \
 	__asm__ __volatile__ ("wbinvd": : :"memory");
+#endif /* CONFIG_PARAVIRT */
+
+#define stts() write_cr0(8 | read_cr0())
+
 
 /*
  * On SMP systems, when the scheduler does migration-cost autodetection,
Index: linux-2.6.19-quilt/include/asm-x86_64/time.h
===================================================================
--- /dev/null
+++ linux-2.6.19-quilt/include/asm-x86_64/time.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_X86_64_TIME_H
+#define _ASM_X86_64_TIME_H
+
+inline void time_init_hook(void);
+unsigned long do_get_cmos_time(void);
+void do_set_rtc_mmss(unsigned long nowtime);
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else /* !CONFIG_PARAVIRT */
+
+#define get_wallclock() do_get_cmos_time()
+#define set_wallclock(x) do_set_rtc_mmss(x)
+#define do_time_init() time_init_hook()
+
+#endif /* CONFIG_PARAVIRT */
+
+#endif
Index: linux-2.6.19-quilt/include/asm-x86_64/tlbflush.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/tlbflush.h
+++ linux-2.6.19-quilt/include/asm-x86_64/tlbflush.h
@@ -4,6 +4,7 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 
+
 static inline unsigned long get_cr3(void)
 {
 	unsigned long cr3;
@@ -16,7 +17,7 @@ static inline void set_cr3(unsigned long
 	asm volatile("mov %0,%%cr3" :: "r" (cr3) : "memory");
 }
 
-static inline void __flush_tlb(void)
+static inline void __native_flush_tlb(void)
 {
 	set_cr3(get_cr3());
 }
@@ -33,17 +34,24 @@ static inline void set_cr4(unsigned long
 	asm volatile("mov %0,%%cr4" :: "r" (cr4) : "memory");
 }
 
-static inline void __flush_tlb_all(void)
+static inline void __native_flush_tlb_all(void)
 {
 	unsigned long cr4 = get_cr4();
 	set_cr4(cr4 & ~X86_CR4_PGE);	/* clear PGE */
 	set_cr4(cr4);			/* write old PGE again and flush TLBs */
 }
 
-#define __flush_tlb_one(addr) \
+#define __native_flush_tlb_one(addr) \
 	__asm__ __volatile__("invlpg (%0)" :: "r" (addr) : "memory")
 
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define __flush_tlb __native_flush_tlb
+#define __flush_tlb_one __native_flush_tlb_one
+#define __flush_tlb_all __native_flush_tlb_all
+#endif /* CONFIG_PARAVIRT */
 /*
  * TLB flushing:
  *
Index: linux-2.6.19-quilt/arch/x86_64/kernel/paravirt.c
===================================================================
--- /dev/null
+++ linux-2.6.19-quilt/arch/x86_64/kernel/paravirt.c
@@ -0,0 +1,583 @@
+/*  Paravirtualization interfaces
+    Copyright (C) 2007 Glauber de Oliveira Costa, Red Hat Inc.
+    Based on i386 work by Rusty Russel.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+*/
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/efi.h>
+#include <linux/bcd.h>
+#include <linux/start_kernel.h>
+
+#include <asm/bug.h>
+#include <asm/paravirt.h>
+#include <asm/desc.h>
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/delay.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+#include <asm/tlbflush.h>
+#include <asm/msr.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/time.h>
+#include <asm/e820.h>
+
+/* nop stub */
+void native_nop(void)
+{
+}
+
+static void __init default_banner(void)
+{
+	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
+	       paravirt_ops.name);
+}
+
+void memory_setup(void)
+{
+	paravirt_ops.memory_setup();
+}
+
+/* Simple instruction patching code. */
+#define DEF_NATIVE(name, code)					\
+	extern const char start_##name[], end_##name[];		\
+	asm("start_" #name ": " code "; end_" #name ":")
+DEF_NATIVE(cli, "cli");
+DEF_NATIVE(sti, "sti");
+DEF_NATIVE(popfq, "pushq %rax; popfq");
+DEF_NATIVE(pushfq, "pushfq; popq %rax");
+DEF_NATIVE(pushfq_cli, "pushfq; popq %rax; cli");
+DEF_NATIVE(iret, "iret");
+DEF_NATIVE(sti_sysretq, "sti; sysretq");
+
+static const struct native_insns
+{
+	const char *start, *end;
+} native_insns[] = {
+	[PARAVIRT_IRQ_DISABLE] = { start_cli, end_cli },
+	[PARAVIRT_IRQ_ENABLE] = { start_sti, end_sti },
+	[PARAVIRT_RESTORE_FLAGS] = { start_popfq, end_popfq },
+	[PARAVIRT_SAVE_FLAGS] = { start_pushfq, end_pushfq },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] = { start_pushfq_cli, end_pushfq_cli },
+	[PARAVIRT_INTERRUPT_RETURN] = { start_iret, end_iret },
+	[PARAVIRT_STI_SYSRETQ] = { start_sti_sysretq, end_sti_sysretq },
+};
+
+static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned len)
+{
+	unsigned int insn_len;
+
+	/* Don't touch it if we don't have a replacement */
+	if (type >= ARRAY_SIZE(native_insns) || !native_insns[type].start)
+		return len;
+
+	insn_len = native_insns[type].end - native_insns[type].start;
+
+
+	/* Similarly if we can't fit replacement. */
+	if (len < insn_len)
+		return len;
+
+	memcpy(insns, native_insns[type].start, insn_len);
+	return insn_len;
+}
+
+static unsigned long native_get_debugreg(int regno)
+{
+	unsigned long val = 0; 	/* Damn you, gcc! */
+
+	switch (regno) {
+	case 0:
+		asm("movq %%db0, %0" :"=r" (val)); break;
+	case 1:
+		asm("movq %%db1, %0" :"=r" (val)); break;
+	case 2:
+		asm("movq %%db2, %0" :"=r" (val)); break;
+	case 3:
+		asm("movq %%db3, %0" :"=r" (val)); break;
+	case 6:
+		asm("movq %%db6, %0" :"=r" (val)); break;
+	case 7:
+		asm("movq %%db7, %0" :"=r" (val)); break;
+	default:
+		BUG();
+	}
+	return val;
+}
+
+static void native_set_debugreg(int regno, unsigned long value)
+{
+	switch (regno) {
+	case 0:
+		asm("movq %0,%%db0"	: /* no output */ :"r" (value));
+		break;
+	case 1:
+		asm("movq %0,%%db1"	: /* no output */ :"r" (value));
+		break;
+	case 2:
+		asm("movq %0,%%db2"	: /* no output */ :"r" (value));
+		break;
+	case 3:
+		asm("movq %0,%%db3"	: /* no output */ :"r" (value));
+		break;
+	case 6:
+		asm("movq %0,%%db6"	: /* no output */ :"r" (value));
+		break;
+	case 7:
+		asm("movq %0,%%db7"	: /* no output */ :"r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+void init_IRQ(void)
+{
+	paravirt_ops.init_IRQ();
+}
+
+static void native_clts(void)
+{
+	asm volatile ("clts");
+}
+
+static unsigned long native_read_cr0(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr0,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static void native_write_cr0(unsigned long val)
+{
+	asm volatile("movq %0,%%cr0": :"r" (val));
+}
+
+static unsigned long native_read_cr2(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr2,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static void native_write_cr2(unsigned long val)
+{
+	asm volatile("movq %0,%%cr2": :"r" (val));
+}
+
+static unsigned long native_read_cr3(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr3,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static void native_write_cr3(unsigned long val)
+{
+	asm volatile("movq %0,%%cr3": :"r" (val));
+}
+
+static unsigned long native_read_cr4(void)
+{
+	unsigned long val;
+	asm volatile("movq %%cr4,%0\n\t" :"=r" (val));
+	return val;
+}
+
+static void native_write_cr4(unsigned long val)
+{
+	asm volatile("movq %0,%%cr4": :"r" (val));
+}
+
+static unsigned long native_save_fl(void)
+{
+	unsigned long f;
+	asm volatile("pushfq ; popq %0":"=g" (f): /* no input */);
+	return f;
+}
+
+static void native_restore_fl(unsigned long f)
+{
+	asm volatile("pushq %0 ; popfq": /* no output */
+			     :"g" (f)
+			     :"memory", "cc");
+}
+
+static void native_irq_disable(void)
+{
+	asm volatile("cli": : :"memory");
+}
+
+static void native_irq_enable(void)
+{
+	asm volatile("sti": : :"memory");
+}
+
+static void native_safe_halt(void)
+{
+	asm volatile("sti; hlt": : :"memory");
+}
+
+static void native_halt(void)
+{
+	asm volatile("hlt": : :"memory");
+}
+
+static void native_wbinvd(void)
+{
+	asm volatile("wbinvd": : :"memory");
+}
+
+static unsigned long native_read_msr(unsigned int msr, int *err)
+{
+	unsigned long val;
+
+	asm volatile("2: rdmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %3,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 8\n\t"
+		     "   .quad 2b,3b\n\t"
+		     ".previous"
+		     : "=r" (*err), "=A" (val)
+		     : "c" (msr), "i" (-EFAULT));
+
+	return val;
+}
+
+static int native_write_msr(unsigned int msr, u64 val)
+{
+	int err;
+	asm volatile("2: wrmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %4,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 8\n\t"
+		     "   .quad 2b,3b\n\t"
+		     ".previous"
+		     : "=a" (err)
+		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val>>32)),
+		       "i" (-EFAULT));
+	return err;
+}
+
+static u64 native_read_tsc(void)
+{
+	unsigned long val;
+	asm volatile("rdtsc" : "=A" (val));
+	return val;
+}
+
+static u64 native_read_pmc(void)
+{
+	unsigned long val;
+	asm volatile("rdpmc" : "=A" (val));
+	return val;
+}
+
+static void native_load_tr_desc(void)
+{
+	asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8));
+}
+
+static void native_load_gdt(const struct desc_struct *dtr)
+{
+	asm volatile("lgdt %w0"::"m" (*dtr));
+}
+
+static void native_load_idt(const struct desc_struct *dtr)
+{
+	asm volatile("lidt %w0"::"m" (*dtr));
+}
+
+static void native_store_gdt(struct desc_struct *dtr)
+{
+	asm ("sgdt %w0":"=m" (*dtr));
+}
+
+static void native_store_idt(struct desc_struct *dtr)
+{
+	asm ("sidt %w0":"=m" (*dtr));
+}
+
+static unsigned long native_store_tr(void)
+{
+	unsigned long tr;
+	asm ("str %w0":"=r" (tr));
+	return tr;
+}
+
+static void native_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+	u64 *gdt = (u64 *)(cpu_gdt(cpu) + GDT_ENTRY_TLS_MIN);
+	gdt[0] = t->tls_array[0];
+	gdt[1] = t->tls_array[1];
+	gdt[2] = t->tls_array[2];
+}
+
+static inline void native_write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
+{
+	u32 *lp = (u32 *)((char *)dt + entry*8);
+	lp[0] = entry_low;
+	lp[1] = entry_high;
+}
+
+static void native_write_ldt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static void native_write_gdt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static void native_write_idt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+	native_write_dt_entry(dt, entrynum, low, high);
+}
+
+static void native_load_rsp0(struct tss_struct *tss,
+				      struct thread_struct *thread)
+{
+	tss->rsp0 = thread->rsp0;
+}
+
+static void native_io_delay(void)
+{
+	asm volatile("outb %al,$0x80");
+}
+
+void native_pagetable_setup_start(pgd_t *base)
+{
+	int i;
+
+	/*
+	 * Init entries of the first-level page table to the
+	 * zero page, if they haven't already been set up.
+	 *
+	 * In a normal native boot, we'll be running on a
+	 * pagetable rooted in swapper_pg_dir, but not in PAE
+	 * mode, so this will end up clobbering the mappings
+	 * for the lower 24Mbytes of the address space,
+	 * without affecting the kernel address space.
+	 */
+	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+		set_pgd(&base[i],
+			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+	memset(&base[USER_PTRS_PER_PGD], 0, sizeof(pgd_t));
+}
+
+void native_pagetable_setup_done(pgd_t *base)
+{
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	set_pgd(&base[0], base[USER_PTRS_PER_PGD]);
+}
+
+
+static void native_flush_tlb(void)
+{
+	__native_flush_tlb();
+}
+
+/*
+ * Global pages have to be flushed a bit differently. Not a real
+ * performance problem because this does not happen often.
+ */
+static void native_flush_tlb_all(void)
+{
+	__native_flush_tlb_all();
+}
+
+static void native_flush_tlb_one(u64 addr)
+{
+	__native_flush_tlb_one(addr);
+}
+
+pte_t native_make_pte(unsigned long pte)
+{
+	return (pte_t){ pte };
+}
+
+pud_t native_make_pud(unsigned long pud)
+{
+	return (pud_t){ pud };
+}
+
+pmd_t native_make_pmd(unsigned long pmd)
+{
+	return (pmd_t){ pmd };
+}
+
+pgd_t native_make_pgd(unsigned long pgd)
+{
+	return (pgd_t){ pgd };
+}
+
+pte_t native_ptep_get_and_clear(struct mm_struct *mm, u64 addr,
+					 pte_t *ptep)
+{
+	return __pte(xchg(&(ptep)->pte, 0));
+}
+
+void native_set_pte_at(struct mm_struct *mm, u64 addr, pte_t *ptep,
+				pte_t pteval)
+{
+	native_set_pte(ptep,pteval);
+}
+
+void native_pte_clear(struct mm_struct *mm, u64 addr, pte_t *ptep)
+{
+	native_set_pte_at(mm,addr,ptep,__pte(0));
+}
+
+void native_pmd_clear(pmd_t *pmd)
+{
+	native_set_pmd(pmd,__pmd(0));
+}
+
+/* These are in entry.S */
+extern void native_iret(void);
+extern void native_irq_enable_sysexit(void);
+
+static int __init print_banner(void)
+{
+	paravirt_ops.banner();
+	return 0;
+}
+core_initcall(print_banner);
+
+/* We simply declare start_kernel to be the paravirt probe of last resort. */
+paravirt_probe(start_kernel);
+
+struct paravirt_ops paravirt_ops = {
+	.name = "bare hardware",
+	.paravirt_enabled = 0,
+	.kernel_rpl = 0,
+	.pgd_alignment = sizeof(pgd_t) * PTRS_PER_PGD,
+
+ 	.patch = native_patch,
+	.banner = default_banner,
+	.arch_setup = native_nop,
+	.memory_setup = setup_memory_region,
+	.get_wallclock = do_get_cmos_time,
+	.set_wallclock = do_set_rtc_mmss,
+	.time_init = time_init_hook,
+	.init_IRQ = native_init_IRQ,
+
+	.cpuid = native_cpuid,
+	.get_debugreg = native_get_debugreg,
+	.set_debugreg = native_set_debugreg,
+	.clts = native_clts,
+	.read_cr0 = native_read_cr0,
+	.write_cr0 = native_write_cr0,
+	.read_cr2 = native_read_cr2,
+	.write_cr2 = native_write_cr2,
+	.read_cr3 = native_read_cr3,
+	.write_cr3 = native_write_cr3,
+	.read_cr4 = native_read_cr4,
+	.write_cr4 = native_write_cr4,
+	.save_fl = native_save_fl,
+	.restore_fl = native_restore_fl,
+	.irq_disable = native_irq_disable,
+	.irq_enable = native_irq_enable,
+	.safe_halt = native_safe_halt,
+	.halt = native_halt,
+	.wbinvd = native_wbinvd,
+	.read_msr = native_read_msr,
+	.write_msr = native_write_msr,
+	.read_tsc = native_read_tsc,
+	.read_pmc = native_read_pmc,
+	.load_tr_desc = native_load_tr_desc,
+	.set_ldt = native_set_ldt,
+	.load_gdt = native_load_gdt,
+	.load_idt = native_load_idt,
+	.store_gdt = native_store_gdt,
+	.store_idt = native_store_idt,
+	.store_tr = native_store_tr,
+	.load_tls = native_load_tls,
+	.write_ldt_entry = native_write_ldt_entry,
+	.write_gdt_entry = native_write_gdt_entry,
+	.write_idt_entry = native_write_idt_entry,
+	.load_rsp0 = native_load_rsp0,
+
+	.io_delay = native_io_delay,
+	.const_udelay = __const_udelay,
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	.apic_write = native_apic_write,
+	.apic_read = native_apic_read,
+#endif
+	.set_lazy_mode = (void *)native_nop,
+
+	.pagetable_setup_start = native_pagetable_setup_start,
+	.pagetable_setup_done = native_pagetable_setup_done,
+
+	.flush_tlb_user = native_flush_tlb,
+	.flush_tlb_kernel = native_flush_tlb_all,
+	.flush_tlb_single = native_flush_tlb_one,
+
+	.alloc_pt = (void *)native_nop,
+	.alloc_pd = (void *)native_nop,
+	.alloc_pd_clone = (void *)native_nop,
+	.release_pt = (void *)native_nop,
+	.release_pd = (void *)native_nop,
+
+	.set_pte = native_set_pte,
+	.set_pte_at = native_set_pte_at,
+	.set_pmd = native_set_pmd,
+	.pte_update = (void *)native_nop,
+	.pte_update_defer = (void *)native_nop,
+
+	.ptep_get_and_clear = native_ptep_get_and_clear,
+
+	.set_pud = native_set_pud,
+	.pte_clear = native_pte_clear,
+	.pmd_clear = native_pmd_clear,
+	.pud_clear = native_pud_clear,
+
+	.pte_val = native_pte_val,
+	.pud_val = native_pud_val,
+	.pmd_val = native_pmd_val,
+	.pgd_val = native_pgd_val,
+
+	.make_pte = native_make_pte,
+	.make_pmd = native_make_pmd,
+	.make_pud = native_make_pud,
+	.make_pgd = native_make_pgd,
+
+	.irq_enable_sysexit = native_irq_enable_sysexit,
+	.iret = native_iret,
+
+	.dup_mmap = (void *)native_nop,
+	.exit_mmap = (void *)native_nop,
+	.activate_mm = (void *)native_nop,
+
+	.startup_ipi_hook = (void *)native_nop,
+};
+EXPORT_SYMBOL(paravirt_ops);
Index: linux-2.6.19-quilt/include/asm-x86_64/paravirt.h
===================================================================
--- /dev/null
+++ linux-2.6.19-quilt/include/asm-x86_64/paravirt.h
@@ -0,0 +1,641 @@
+#ifndef __ASM_PARAVIRT_H
+#define __ASM_PARAVIRT_H
+/* Various instructions on x86 need to be replaced for
+ * para-virtualization: those hooks are defined here. */
+#include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/page.h>
+#include <asm/types.h>
+#include <asm/pda.h>
+
+#ifdef CONFIG_PARAVIRT
+/* These are the most performance critical ops, so we want to be able to patch
+ * callers */
+#define PARAVIRT_IRQ_DISABLE 0
+#define PARAVIRT_IRQ_ENABLE 1
+#define PARAVIRT_RESTORE_FLAGS 2
+#define PARAVIRT_SAVE_FLAGS 3
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
+#define PARAVIRT_INTERRUPT_RETURN 5
+#define PARAVIRT_STI_SYSRETQ 6
+
+/* Bitmask of what can be clobbered: usually at least rax. */
+#define CLBR_NONE 0x0
+#define CLBR_RAX 0x1
+#define CLBR_RCX 0x2
+#define CLBR_RDX 0x4
+#define CLBR_ANY 0xf
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct thread_struct;
+struct desc_struct;
+struct tss_struct;
+struct mm_struct;
+
+struct paravirt_ops
+{
+	int paravirt_enabled;
+	unsigned int kernel_rpl;
+
+	int pgd_alignment;
+
+	const char *name;
+
+	/*
+	 * Patch may replace one of the defined code sequences with arbitrary
+	 * code, subject to the same register constraints.  This generally
+	 * means the code is not free to clobber any registers other than RAX.
+	 * The patch function should return the number of bytes of code
+	 * generated, as we nop pad the rest in generic code.
+	 */
+	unsigned (*patch)(u8 type, u16 clobber, void *firstinsn, unsigned len);
+
+	void (*arch_setup)(void);
+	void (*memory_setup)(void);
+	void (*init_IRQ)(void);
+
+	void (*pagetable_setup_start)(pgd_t *pgd_base);
+	void (*pagetable_setup_done)(pgd_t *pgd_base);
+
+	void (*banner)(void);
+
+	unsigned long (*get_wallclock)(void);
+	void (*set_wallclock)(unsigned long);
+	void (*time_init)(void);
+
+	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
+		      unsigned int *ecx, unsigned int *edx);
+
+	unsigned long (*get_debugreg)(int regno);
+	void (*set_debugreg)(int regno, unsigned long value);
+
+	void (*clts)(void);
+
+	unsigned long (*read_cr0)(void);
+	void (*write_cr0)(unsigned long);
+
+	unsigned long (*read_cr2)(void);
+	void (*write_cr2)(unsigned long);
+
+	unsigned long (*read_cr3)(void);
+	void (*write_cr3)(unsigned long);
+
+	unsigned long (*read_cr4)(void);
+	void (*write_cr4)(unsigned long);
+
+	unsigned long (*save_fl)(void);
+	void (*restore_fl)(unsigned long);
+	void (*irq_disable)(void);
+	void (*irq_enable)(void);
+	void (*safe_halt)(void);
+	void (*halt)(void);
+	void (*wbinvd)(void);
+
+	/* err = 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
+	u64 (*read_msr)(unsigned int msr, int *err);
+	int (*write_msr)(unsigned int msr, u64 val);
+
+	u64 (*read_tsc)(void);
+	u64 (*read_pmc)(void);
+
+	void (*load_tr_desc)(void);
+	void (*load_gdt)(const struct desc_struct *);
+	void (*load_idt)(const struct desc_struct *);
+	void (*store_gdt)(struct desc_struct *);
+	void (*store_idt)(struct desc_struct *);
+	void (*set_ldt)(const void *desc, unsigned entries);
+	unsigned long (*store_tr)(void);
+	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
+	void (*write_ldt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (*write_gdt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (*write_idt_entry)(void *dt, int entrynum,
+					 u32 low, u32 high);
+	void (*load_rsp0)(struct tss_struct *tss,
+				   struct thread_struct *thread);
+
+	void (*io_delay)(void);
+	void (*const_udelay)(unsigned long loops);
+
+	void (*activate_mm)(struct mm_struct *prev,
+				     struct mm_struct *next);
+	void (*dup_mmap)(struct mm_struct *oldmm,
+				  struct mm_struct *mm);
+	void (*exit_mmap)(struct mm_struct *mm);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	void (*apic_write)(unsigned long reg, unsigned int v);
+	unsigned int (*apic_read)(unsigned long reg);
+#endif
+
+	void (*flush_tlb_user)(void);
+	void (*flush_tlb_kernel)(void);
+	void (*flush_tlb_single)(u64 addr);
+
+	void (*alloc_pt)(u64 pfn);
+	void (*alloc_pd)(u64 pfn);
+	void (*alloc_pd_clone)(u64 pfn, u64 clonepfn, u64 start, u64 count);
+	void (*release_pt)(u64 pfn);
+	void (*release_pd)(u64 pfn);
+
+	void (*set_pte)(pte_t *ptep, pte_t pteval);
+	void (*set_pte_at)(struct mm_struct *mm, u64 addr, pte_t *ptep, pte_t pteval);
+	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
+	void (*set_pud)(pud_t *pudp, pud_t pudval);
+	void (*pte_update)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+	void (*pte_update_defer)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+
+	pte_t (*ptep_get_and_clear)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+
+	void (*pte_clear)(struct mm_struct *mm, u64 addr, pte_t *ptep);
+	void (*pmd_clear)(pmd_t *pmdp);
+	void (*pud_clear)(pud_t *pudp);
+
+	unsigned long (*pte_val)(pte_t);
+	unsigned long (*pud_val)(pud_t);
+	unsigned long (*pmd_val)(pmd_t);
+	unsigned long (*pgd_val)(pgd_t);
+
+	pte_t (*make_pte)(unsigned long pte);
+	pud_t (*make_pud)(unsigned long pud);
+	pmd_t (*make_pmd)(unsigned long pmd);
+	pgd_t (*make_pgd)(unsigned long pgd);
+
+	void (*set_lazy_mode)(int mode);
+
+	/* These two are jmp to, not actually called. */
+	void (*irq_enable_sysexit)(void);
+	void (*iret)(void);
+
+	void (*startup_ipi_hook)(int phys_apicid, unsigned long start_eip, unsigned long start_esp);
+};
+
+/* Mark a paravirt probe function. */
+#define paravirt_probe(fn)						\
+ static asmlinkage void (*__paravirtprobe_##fn)(void) __attribute_used__ \
+		__attribute__((__section__(".paravirtprobe"))) = fn
+
+extern struct paravirt_ops paravirt_ops;
+
+void native_pagetable_setup_start(pgd_t *pgd);
+
+pte_t native_make_pte(unsigned long pte);
+pud_t native_make_pud(unsigned long pud);
+pmd_t native_make_pmd(unsigned long pmd);
+pgd_t native_make_pgd(unsigned long pgd);
+
+#define paravirt_enabled() (paravirt_ops.paravirt_enabled)
+
+static inline void load_rsp0(struct tss_struct *tss,
+			     struct thread_struct *thread)
+{
+	paravirt_ops.load_rsp0(tss, thread);
+}
+
+#define ARCH_SETUP			paravirt_ops.arch_setup();
+static inline unsigned long get_wallclock(void)
+{
+	return paravirt_ops.get_wallclock();
+}
+
+static inline void set_wallclock(unsigned long nowtime)
+{
+	paravirt_ops.set_wallclock(nowtime);
+}
+
+static inline void do_time_init(void)
+{
+	return paravirt_ops.time_init();
+}
+
+/* The paravirtualized CPUID instruction. */
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
+#define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
+
+#define clts() paravirt_ops.clts()
+
+#define read_cr0() paravirt_ops.read_cr0()
+#define write_cr0(x) paravirt_ops.write_cr0(x)
+
+#define read_cr2() paravirt_ops.read_cr2()
+#define write_cr2(x) paravirt_ops.write_cr2(x)
+
+#define read_cr3() paravirt_ops.read_cr3()
+#define write_cr3(x) paravirt_ops.write_cr3(x)
+
+#define read_cr4() paravirt_ops.read_cr4()
+#define write_cr4(x) paravirt_ops.write_cr4(x)
+
+
+#define ptep_get_and_clear(mm,addr,xp)	\
+			(paravirt_ops.ptep_get_and_clear(mm,addr,xp))
+
+static inline void raw_safe_halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+
+static inline void halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+#define wbinvd() paravirt_ops.wbinvd()
+
+#define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
+
+#define rdmsr(msr,val1,val2) do {				\
+	int _err;						\
+	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	val1 = (u32)_l;						\
+	val2 = _l >> 32;					\
+} while(0)
+
+#define wrmsr(msr,val1,val2) do {				\
+	u64 _l = ((u64)(val2) << 32) | (val1);			\
+	paravirt_ops.write_msr((msr), _l);			\
+} while(0)
+
+#define rdmsrl(msr,val) do {					\
+	int _err;						\
+	val = paravirt_ops.read_msr((msr),&_err);		\
+} while(0)
+
+#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+#define wrmsr_safe(msr,a,b) ({					\
+	u64 _l = ((u64)(b) << 32) | (a);			\
+	paravirt_ops.write_msr((msr),_l);			\
+})
+
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({					\
+	int _err;						\
+	u64 _l = paravirt_ops.read_msr(msr,&_err);		\
+	(*a) = (u32)_l;						\
+	(*b) = _l >> 32;					\
+	_err; })
+
+#define rdtsc(low,high) do {					\
+	u64 _l = paravirt_ops.read_tsc();			\
+	low = (u32)_l;						\
+	high = _l >> 32;					\
+} while(0)
+
+#define rdtscl(low) do {					\
+	u64 _l = paravirt_ops.read_tsc();			\
+	low = (int)_l;						\
+} while(0)
+
+#define rdtscll(val) (val = paravirt_ops.read_tsc())
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+#define rdpmc(counter,low,high) do {				\
+	u64 _l = paravirt_ops.read_pmc();			\
+	low = (u32)_l;						\
+	high = _l >> 32;					\
+} while(0)
+
+#define load_TR_desc() (paravirt_ops.load_tr_desc())
+#define load_gdt(dtr) (paravirt_ops.load_gdt(dtr))
+#define load_idt(dtr) (paravirt_ops.load_idt(dtr))
+#define set_ldt(addr, entries) (paravirt_ops.set_ldt((addr), (entries)))
+#define store_gdt(dtr) (paravirt_ops.store_gdt(dtr))
+#define store_idt(dtr) (paravirt_ops.store_idt(dtr))
+#define store_tr(tr) ((tr) = paravirt_ops.store_tr())
+#define load_TLS(t,cpu) (paravirt_ops.load_tls((t),(cpu)))
+#define write_ldt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_ldt_entry((dt), (entry), (low), (high)))
+#define write_gdt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_gdt_entry((dt), (entry), (low), (high)))
+#define write_idt_entry(dt, entry, low, high)				\
+	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
+
+#define __pte(x)	paravirt_ops.make_pte(x)
+#define pte_val(x)	paravirt_ops.pte_val(x)
+
+#define __pgd(x)	paravirt_ops.make_pgd(x)
+#define pgd_val(x)	paravirt_ops.pgd_val(x)
+
+#define __pud(x)	paravirt_ops.make_pud(x)
+#define pud_val(x)	paravirt_ops.pud_val(x)
+
+#define __pmd(x)	paravirt_ops.make_pmd(x)
+#define pmd_val(x)	paravirt_ops.pmd_val(x)
+
+/* The paravirtualized I/O functions */
+static inline void slow_down_io(void) {
+	paravirt_ops.io_delay();
+#ifdef REALLY_SLOW_IO
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+	paravirt_ops.io_delay();
+#endif
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * Basic functions accessing APICs.
+ */
+static inline void apic_write(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write(reg,v);
+}
+
+static inline unsigned long apic_read(unsigned long reg)
+{
+	return paravirt_ops.apic_read(reg);
+}
+#endif
+
+static inline void paravirt_pagetable_setup_start(pgd_t *base)
+{
+	if (paravirt_ops.pagetable_setup_start)
+		(*paravirt_ops.pagetable_setup_start)(base);
+}
+
+static inline void paravirt_pagetable_setup_done(pgd_t *base)
+{
+	if (paravirt_ops.pagetable_setup_done)
+		(*paravirt_ops.pagetable_setup_done)(base);
+}
+
+void native_pte_clear(struct mm_struct *mm, u64 addr, pte_t *ptep);
+void native_pmd_clear(pmd_t *pmd);
+void native_nop(void);
+
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+	paravirt_ops.activate_mm(prev, next);
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+	paravirt_ops.dup_mmap(oldmm, mm);
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+	paravirt_ops.exit_mmap(mm);
+}
+
+#define __flush_tlb() paravirt_ops.flush_tlb_user()
+#define __flush_tlb_all() paravirt_ops.flush_tlb_kernel()
+#define __flush_tlb_one(addr) paravirt_ops.flush_tlb_single(addr)
+
+#define paravirt_alloc_pt(pfn) paravirt_ops.alloc_pt(pfn)
+#define paravirt_release_pt(pfn) paravirt_ops.release_pt(pfn)
+
+#define paravirt_alloc_pd(pfn) paravirt_ops.alloc_pd(pfn)
+#define paravirt_alloc_pd_clone(pfn, clonepfn, start, count) \
+	paravirt_ops.alloc_pd_clone(pfn, clonepfn, start, count)
+#define paravirt_release_pd(pfn) paravirt_ops.release_pd(pfn)
+
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	paravirt_ops.set_pte(ptep, pteval);
+}
+
+static inline void set_pte_at(struct mm_struct *mm, u64 addr, pte_t *ptep, pte_t pteval)
+{
+	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	paravirt_ops.set_pmd(pmdp, pmdval);
+}
+
+static inline void pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	paravirt_ops.pte_update(mm, addr, ptep);
+}
+
+static inline void pte_update_defer(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	paravirt_ops.pte_update_defer(mm, addr, ptep);
+}
+
+
+static inline void set_pud(pud_t *pudp, pud_t pudval)
+{
+	paravirt_ops.set_pud(pudp, pudval);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	paravirt_ops.pte_clear(mm, addr, ptep);
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	paravirt_ops.pmd_clear(pmdp);
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	paravirt_ops.pud_clear(pudp);
+}
+
+
+/* Lazy mode for batching updates / context switch */
+#define PARAVIRT_LAZY_NONE 0
+#define PARAVIRT_LAZY_MMU  1
+#define PARAVIRT_LAZY_CPU  2
+
+#define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
+#define arch_enter_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_CPU)
+#define arch_leave_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+
+#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+#define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_MMU)
+#define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+
+/* These all sit in the .parainstructions section to tell us what to patch. */
+struct paravirt_patch {
+	u8 *instr; 		/* original instructions */
+	u8 instrtype;		/* type of this instruction */
+	u8 len;			/* length of original instruction */
+	u16 clobbers;		/* what registers you may clobber */
+} __attribute__((aligned(8)));
+
+#define paravirt_alt(insn_string, typenum, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	".align 8\n"					\
+	"  .quad 771b\n"				\
+	"  .byte " __stringify(typenum) "\n"		\
+	"  .byte 772b-771b\n"				\
+	"  .short " __stringify(clobber) "\n"		\
+	".popsection"
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt("call *%1;",
+					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
+			     : "=a"(f): "m"(paravirt_ops.save_fl)
+			     : "memory", "cc");
+	return f;
+}
+
+static inline void raw_local_irq_restore(unsigned long f)
+{
+	__asm__ __volatile__(paravirt_alt("call *%1;", PARAVIRT_RESTORE_FLAGS,
+					CLBR_NONE)
+			     : : "D" (f) , "m" (paravirt_ops.restore_fl)
+			     : "memory", "cc");
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0;",
+					  PARAVIRT_IRQ_DISABLE, CLBR_NONE)
+			     : : "m" (paravirt_ops.irq_disable)
+			     : "memory", "cc");
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0;",
+					  PARAVIRT_IRQ_ENABLE, CLBR_NONE)
+			     : : "m" (paravirt_ops.irq_enable)
+			     : "memory", "cc");
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt( "call *%1;"
+					   "call *%2;",
+					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
+					  CLBR_NONE)
+			     : "=a"(f)
+			     : "m" (paravirt_ops.save_fl),
+			       "m" (paravirt_ops.irq_disable)
+			     : "memory", "cc");
+	return f;
+}
+
+
+
+/* Still x86-ish */
+#define CLI_STRING paravirt_alt("pushq %%rcx; pushq %%rdx;"		\
+		     "call *paravirt_ops+%c[irq_disable];"		\
+		     "popq %%rdx; popq %%rcx",				\
+		     PARAVIRT_IRQ_DISABLE, CLBR_RAX)
+
+#define STI_STRING paravirt_alt("pushq %%rcx; pushq %%rdx;"		\
+		     "call *paravirt_ops+%c[irq_enable];"		\
+		     "popq %%rdx; popq %%rcx",				\
+		     PARAVIRT_IRQ_ENABLE, CLBR_RAX)
+#define CLI_STI_CLOBBERS , "%rax"
+#define CLI_STI_INPUT_ARGS \
+	,								\
+	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
+	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
+
+#else  /* __ASSEMBLY__ */
+
+#define PARA_PATCH(ptype, clobbers, ops)	\
+771:;						\
+	ops;					\
+772:;						\
+	.pushsection .parainstructions,"a";	\
+	.align 8;				\
+	 .quad 771b;				\
+	 .byte ptype;				\
+	 .byte 772b-771b;			\
+	 .short clobbers;			\
+	.popsection
+
+#define INTERRUPT_RETURN				\
+	PARA_PATCH(PARAVIRT_INTERRUPT_RETURN, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_iret)
+
+#define DISABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_DISABLE, clobbers,	\
+	pushq %rcx; pushq %rdx;				\
+	call *paravirt_ops+PARAVIRT_irq_disable;	\
+	popq %rdx; popq %rcx)				\
+
+#define ENABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_ENABLE, clobbers,	\
+	pushq %rcx; pushq %rdx;				\
+	call *%cs:paravirt_ops+PARAVIRT_irq_enable;	\
+	popq %rdx; popq %rcx)
+
+#define ENABLE_INTERRUPTS_SYSRETQ			\
+	PARA_PATCH(PARAVIRT_STI_SYSRETQ, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit)
+
+#define GET_CR0_INTO_RAX			\
+	call *paravirt_ops+PARAVIRT_read_cr0
+
+#endif /* __ASSEMBLY__ */
+#else  /* !CONFIG_PARAVIRT */
+
+static inline void paravirt_pagetable_setup_start(pgd_t *base)
+{
+	int i;
+
+	/*
+	 * Init entries of the first-level page table to the
+	 * zero page, if they haven't already been set up.
+	 *
+	 * In a normal native boot, we'll be running on a
+	 * pagetable rooted in swapper_pg_dir, but not in PAE
+	 * mode, so this will end up clobbering the mappings
+	 * for the lower 24Mbytes of the address space,
+	 * without affecting the kernel address space.
+	 */
+	for (i = 0; i < USER_PTRS_PER_PGD; i++)
+		set_pgd(&base[i],
+			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+	memset(&base[USER_PTRS_PER_PGD], 0, sizeof(pgd_t));
+}
+
+static inline void paravirt_pagetable_setup_done(pgd_t *base)
+{
+	/*
+	 * Add low memory identity-mappings - SMP needs it when
+	 * starting up on an AP from real-mode. In the non-PAE
+	 * case we already have these mappings through head.S.
+	 * All user-space mappings are explicitly cleared after
+	 * SMP startup.
+	 */
+	set_pgd(&base[0], base[USER_PTRS_PER_PGD]);
+}
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+}
+
+static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
+				     struct mm_struct *mm)
+{
+}
+
+static inline void paravirt_exit_mmap(struct mm_struct *mm)
+{
+}
+
+#endif /* CONFIG_PARAVIRT */
+#endif	/* __ASM_PARAVIRT_H */
Index: linux-2.6.19-quilt/include/asm-x86_64/msr.h
===================================================================
--- linux-2.6.19-quilt.orig/include/asm-x86_64/msr.h
+++ linux-2.6.19-quilt/include/asm-x86_64/msr.h
@@ -2,6 +2,23 @@
 #define X86_64_MSR_H 1
 
 #ifndef __ASSEMBLY__
+
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				 unsigned int *ecx, unsigned int *edx)
+{
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+
+#define __cpuid native_cpuid
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -43,7 +60,6 @@
 		     : "c" (msr), "0" (a), "d" (b), "i" (-EFAULT)); \
 	ret__; })
 
-#define checking_wrmsrl(msr,val) wrmsr_safe(msr,(u32)(val),(u32)((val)>>32))
 
 #define rdmsr_safe(msr,a,b) \
 	({ int ret__;						\
@@ -66,8 +82,6 @@
 #define rdtscl(low) \
      __asm__ __volatile__ ("rdtsc" : "=a" (low) : : "edx")
 
-#define rdtscp(low,high,aux) \
-     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (low), "=d" (high), "=c" (aux))
 
 #define rdtscll(val) do { \
      unsigned int __a,__d; \
@@ -75,42 +89,49 @@
      (val) = ((unsigned long)__a) | (((unsigned long)__d)<<32); \
 } while(0)
 
+#define rdpmc(counter,low,high) \
+     __asm__ __volatile__("rdpmc" \
+			  : "=a" (low), "=d" (high) \
+			  : "c" (counter))
+
+#define rdtscp(low,high,aux) \
+     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (low), "=d" (high), "=c" (aux))
+
+#define rdtscpll(val, aux) do { \
+     unsigned long __a, __d; \
+     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (__a), "=d" (__d), "=c" (aux)); \
+     (val) = (__d << 32) | __a; \
+} while (0)
+
+#endif /* CONFIG_PARAVIRT */
+
+#define rdtscp(low,high,aux) \
+     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (low), "=d" (high), "=c" (aux))
+
 #define rdtscpll(val, aux) do { \
      unsigned long __a, __d; \
      asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (__a), "=d" (__d), "=c" (aux)); \
      (val) = (__d << 32) | __a; \
 } while (0)
 
+#define checking_wrmsrl(msr,val) wrmsr_safe(msr,(u32)(val),(u32)((val)>>32))
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define write_rdtscp_aux(val) wrmsr(0xc0000103, val, 0)
 
-#define rdpmc(counter,low,high) \
-     __asm__ __volatile__("rdpmc" \
-			  : "=a" (low), "=d" (high) \
-			  : "c" (counter))
-
-static inline void cpuid(int op, unsigned int *eax, unsigned int *ebx,
+static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx,
 			 unsigned int *ecx, unsigned int *edx)
 {
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op));
+	*eax = op;
+	__cpuid(eax, ebx, ecx, edx);
 }
-
 /* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
-	       	int *edx)
+static inline void cpuid_count(int op, int count,
+			 int *eax, int *ebx, int *ecx, int *edx)
 {
-	__asm__("cpuid"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (op), "c" (count));
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
 }
 
 /*
@@ -118,42 +139,26 @@ static inline void cpuid_count(int op, i
  */
 static inline unsigned int cpuid_eax(unsigned int op)
 {
-	unsigned int eax;
-
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (op)
-		: "bx", "cx", "dx");
+	unsigned int eax, ebx, ecx, edx;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return eax;
 }
 static inline unsigned int cpuid_ebx(unsigned int op)
 {
-	unsigned int eax, ebx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx)
-		: "0" (op)
-		: "cx", "dx" );
+	unsigned int eax, ebx, ecx, edx;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 static inline unsigned int cpuid_ecx(unsigned int op)
 {
-	unsigned int eax, ecx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=c" (ecx)
-		: "0" (op)
-		: "bx", "dx" );
+	unsigned int eax, ebx, ecx, edx;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return ecx;
 }
 static inline unsigned int cpuid_edx(unsigned int op)
 {
-	unsigned int eax, edx;
-
-	__asm__("cpuid"
-		: "=a" (eax), "=d" (edx)
-		: "0" (op)
-		: "bx", "cx");
+	unsigned int eax, ebx, ecx, edx;
+	__cpuid(&eax, &ebx, &ecx, &edx);
 	return edx;
 }
 
Index: linux-2.6.19-quilt/arch/i386/kernel/alternative.c
===================================================================
--- linux-2.6.19-quilt.orig/arch/i386/kernel/alternative.c
+++ linux-2.6.19-quilt/arch/i386/kernel/alternative.c
@@ -431,7 +431,9 @@ void __init alternative_instructions(voi
 	}
 #endif
 #ifdef CONFIG_PARAVIRT
+  #ifndef CONFIG_X86_64 /* Not working properly yet */
  	apply_paravirt(__start_parainstructions, __stop_parainstructions);
+  #endif
 #endif
 	local_irq_restore(flags);
 }

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--J2SCkAp4GZ/dPZZf--
