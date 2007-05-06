From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: paravirt_ops queue rebased
Date: Sun, 06 May 2007 13:12:27 -0500
Message-ID: <1178475147.3760.36.camel@mulgrave.il.steeleye.com>
References: <463E0E8D.3050806@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wcTwEqet9pnBB4l84jDV"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <463E0E8D.3050806@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


--=-wcTwEqet9pnBB4l84jDV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2007-05-06 at 10:21 -0700, Jeremy Fitzhardinge wrote:
> I just rebased my paravirt_ops patch queue to current git.  Looks like
> almost all the pre-req patches are now in, which is nice.
> 
> The only missing thing from your patches was you sched_clock patches and
> the sched_clock paravirt-op.  Are there still problems with either your
> sched_clock patch or the paravirt patch?  Should I resubmit the
> paravirt-sched_clock patch based on git?
> 
> The only other general patches before the Xen series I have left in my
> queue are:
> 
>     i386-common-smp.patch
>     i386-fix-voyager-build.patch
>     vsyscall-note-use-elfnote_h.patch

Just make sure it's the one I sent you, not your original one ... the
original one won't compile on voyager.

Since voyager is now completely broken in mainline (again) do you want
me to take these through the voyager tree?

James



--=-wcTwEqet9pnBB4l84jDV
Content-Disposition: attachment; filename=i386-common-smp.patch
Content-Type: text/x-patch; name=i386-common-smp.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Subject: i386: move common parts of smp into their own file

Several parts of kernel/smp.c and smpboot.c are generally useful for
other subarchitectures and paravirt_ops implementations, so make them
available for reuse.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>

---
 arch/i386/kernel/Makefile    |    1 
 arch/i386/kernel/smp.c       |   65 +++-------------------------------
 arch/i386/kernel/smpboot.c   |   22 -----------
 arch/i386/kernel/smpcommon.c |   79 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/processor.h |    4 ++
 5 files changed, 90 insertions(+), 81 deletions(-)

===================================================================
Index: BUILD-voyager/arch/i386/kernel/Makefile
===================================================================
--- BUILD-voyager.orig/arch/i386/kernel/Makefile	2007-05-05 21:21:48.000000000 -0500
+++ BUILD-voyager/arch/i386/kernel/Makefile	2007-05-05 21:27:48.000000000 -0500
@@ -19,6 +19,7 @@ obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o tsc_sync.o
+obj-$(CONFIG_SMP)		+= smpcommon.o
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
Index: BUILD-voyager/arch/i386/kernel/smp.c
===================================================================
--- BUILD-voyager.orig/arch/i386/kernel/smp.c	2007-05-05 21:21:48.000000000 -0500
+++ BUILD-voyager/arch/i386/kernel/smp.c	2007-05-05 21:27:48.000000000 -0500
@@ -468,7 +468,7 @@ void flush_tlb_all(void)
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-void native_smp_send_reschedule(int cpu)
+static void native_smp_send_reschedule(int cpu)
 {
 	WARN_ON(cpu_is_offline(cpu));
 	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
@@ -547,9 +547,10 @@ static void __smp_call_function(void (*f
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int native_smp_call_function_mask(cpumask_t mask,
-				  void (*func)(void *), void *info,
-				  int wait)
+static int
+native_smp_call_function_mask(cpumask_t mask,
+			      void (*func)(void *), void *info,
+			      int wait)
 {
 	struct call_data_struct data;
 	cpumask_t allbutself;
@@ -600,60 +601,6 @@ int native_smp_call_function_mask(cpumas
 	return 0;
 }
 
-/**
- * smp_call_function(): Run a function on all other CPUs.
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @nonatomic: Unused.
- * @wait: If true, wait (atomically) until function has completed on other CPUs.
- *
- * Returns 0 on success, else a negative status code.
- *
- * If @wait is true, then returns once @func has returned; otherwise
- * it returns just before the target cpu calls @func.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.
- */
-int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
-		      int wait)
-{
-	return smp_call_function_mask(cpu_online_map, func, info, wait);
-}
-EXPORT_SYMBOL(smp_call_function);
-
-/**
- * smp_call_function_single - Run a function on another CPU
- * @cpu: The target CPU.  Cannot be the calling CPU.
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @nonatomic: Unused.
- * @wait: If true, wait until function has completed on other CPUs.
- *
- * Returns 0 on success, else a negative status code.
- *
- * If @wait is true, then returns once @func has returned; otherwise
- * it returns just before the target cpu calls @func.
- */
-int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
-			     int nonatomic, int wait)
-{
-	/* prevent preemption and reschedule on another processor */
-	int ret;
-	int me = get_cpu();
-	if (cpu == me) {
-		WARN_ON(1);
-		put_cpu();
-		return -EBUSY;
-	}
-
-	ret = smp_call_function_mask(cpumask_of_cpu(cpu), func, info, wait);
-
-	put_cpu();
-	return ret;
-}
-EXPORT_SYMBOL(smp_call_function_single);
-
 static void stop_this_cpu (void * dummy)
 {
 	local_irq_disable();
@@ -671,7 +618,7 @@ static void stop_this_cpu (void * dummy)
  * this function calls the 'stop' function on all other CPUs in the system.
  */
 
-void native_smp_send_stop(void)
+static void native_smp_send_stop(void)
 {
 	/* Don't deadlock on the call lock in panic */
 	int nolock = !spin_trylock(&call_lock);
Index: BUILD-voyager/arch/i386/kernel/smpboot.c
===================================================================
--- BUILD-voyager.orig/arch/i386/kernel/smpboot.c	2007-05-05 21:21:48.000000000 -0500
+++ BUILD-voyager/arch/i386/kernel/smpboot.c	2007-05-05 21:27:48.000000000 -0500
@@ -99,9 +99,6 @@ EXPORT_SYMBOL(x86_cpu_to_apicid);
 
 u8 apicid_2_node[MAX_APICID];
 
-DEFINE_PER_CPU(unsigned long, this_cpu_off);
-EXPORT_PER_CPU_SYMBOL(this_cpu_off);
-
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -764,25 +761,6 @@ static inline struct task_struct * alloc
 #define alloc_idle_task(cpu) fork_idle(cpu)
 #endif
 
-/* Initialize the CPU's GDT.  This is either the boot CPU doing itself
-   (still using the master per-cpu area), or a CPU doing it for a
-   secondary which will soon come up. */
-static __cpuinit void init_gdt(int cpu)
-{
-	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
-
-	pack_descriptor((u32 *)&gdt[GDT_ENTRY_PERCPU].a,
-			(u32 *)&gdt[GDT_ENTRY_PERCPU].b,
-			__per_cpu_offset[cpu], 0xFFFFF,
-			0x80 | DESCTYPE_S | 0x2, 0x8);
-
-	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
-	per_cpu(cpu_number, cpu) = cpu;
-}
-
-/* Defined in head.S */
-extern struct Xgt_desc_struct early_gdt_descr;
-
 static int __cpuinit do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
Index: BUILD-voyager/arch/i386/kernel/smpcommon.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ BUILD-voyager/arch/i386/kernel/smpcommon.c	2007-05-05 21:27:48.000000000 -0500
@@ -0,0 +1,79 @@
+/*
+ * SMP stuff which is common to all sub-architectures.
+ */
+#include <linux/module.h>
+#include <asm/smp.h>
+
+DEFINE_PER_CPU(unsigned long, this_cpu_off);
+EXPORT_PER_CPU_SYMBOL(this_cpu_off);
+
+/* Initialize the CPU's GDT.  This is either the boot CPU doing itself
+   (still using the master per-cpu area), or a CPU doing it for a
+   secondary which will soon come up. */
+__cpuinit void init_gdt(int cpu)
+{
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+
+	pack_descriptor((u32 *)&gdt[GDT_ENTRY_PERCPU].a,
+			(u32 *)&gdt[GDT_ENTRY_PERCPU].b,
+			__per_cpu_offset[cpu], 0xFFFFF,
+			0x80 | DESCTYPE_S | 0x2, 0x8);
+
+	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
+	per_cpu(cpu_number, cpu) = cpu;
+}
+
+
+/**
+ * smp_call_function(): Run a function on all other CPUs.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @nonatomic: Unused.
+ * @wait: If true, wait (atomically) until function has completed on other CPUs.
+ *
+ * Returns 0 on success, else a negative status code.
+ *
+ * If @wait is true, then returns once @func has returned; otherwise
+ * it returns just before the target cpu calls @func.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.
+ */
+int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
+		      int wait)
+{
+	return smp_call_function_mask(cpu_online_map, func, info, wait);
+}
+EXPORT_SYMBOL(smp_call_function);
+
+/**
+ * smp_call_function_single - Run a function on another CPU
+ * @cpu: The target CPU.  Cannot be the calling CPU.
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @nonatomic: Unused.
+ * @wait: If true, wait until function has completed on other CPUs.
+ *
+ * Returns 0 on success, else a negative status code.
+ *
+ * If @wait is true, then returns once @func has returned; otherwise
+ * it returns just before the target cpu calls @func.
+ */
+int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
+			     int nonatomic, int wait)
+{
+	/* prevent preemption and reschedule on another processor */
+	int ret;
+	int me = get_cpu();
+	if (cpu == me) {
+		WARN_ON(1);
+		put_cpu();
+		return -EBUSY;
+	}
+
+	ret = smp_call_function_mask(cpumask_of_cpu(cpu), func, info, wait);
+
+	put_cpu();
+	return ret;
+}
+EXPORT_SYMBOL(smp_call_function_single);
Index: BUILD-voyager/include/asm-i386/processor.h
===================================================================
--- BUILD-voyager.orig/include/asm-i386/processor.h	2007-05-05 21:21:50.000000000 -0500
+++ BUILD-voyager/include/asm-i386/processor.h	2007-05-05 21:27:48.000000000 -0500
@@ -749,9 +749,13 @@ extern unsigned long boot_option_idle_ov
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
+/* Defined in head.S */
+extern struct Xgt_desc_struct early_gdt_descr;
+
 extern void cpu_set_gdt(int);
 extern void switch_to_new_gdt(void);
 extern void cpu_init(void);
+extern void init_gdt(int cpu);
 
 extern int force_mwait;
 

--=-wcTwEqet9pnBB4l84jDV
Content-Disposition: attachment; filename=i386-fix-voyager-build.patch
Content-Type: text/x-patch; name=i386-fix-voyager-build.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Subject: i386: fix voyager build

This adds an smp_ops for voyager, and hooks things up appropriately.
This is the first baby-step to making subarch runtime switchable.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>

---
 arch/i386/mach-voyager/voyager_smp.c |   73 ++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 29 deletions(-)

===================================================================
Index: BUILD-voyager/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- BUILD-voyager.orig/arch/i386/mach-voyager/voyager_smp.c	2007-05-05 21:21:48.000000000 -0500
+++ BUILD-voyager/arch/i386/mach-voyager/voyager_smp.c	2007-05-05 21:28:12.000000000 -0500
@@ -28,7 +28,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
-#include <asm/pda.h>
 
 /* TLB state -- visible externally, indexed physically */
 DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned = { &init_mm, 0 };
@@ -423,7 +422,7 @@ find_smp_config(void)
 	     VOYAGER_SUS_IN_CONTROL_PORT);
 
 	current_thread_info()->cpu = boot_cpu_id;
-	write_pda(cpu_number, boot_cpu_id);
+	x86_write_percpu(cpu_number, boot_cpu_id);
 }
 
 /*
@@ -436,7 +435,7 @@ smp_store_cpu_info(int id)
 
 	*c = boot_cpu_data;
 
-	identify_cpu(c);
+	identify_secondary_cpu(c);
 }
 
 /* set up the trampoline and return the physical address of the code */
@@ -460,7 +459,7 @@ start_secondary(void *unused)
 	/* external functions not defined in the headers */
 	extern void calibrate_delay(void);
 
-	secondary_cpu_init();
+	cpu_init();
 
 	/* OK, we're in the routine */
 	ack_CPI(VIC_CPU_BOOT_CPI);
@@ -573,7 +572,9 @@ do_boot_cpu(__u8 cpu)
 	/* init_tasks (in sched.c) is indexed logically */
 	stack_start.esp = (void *) idle->thread.esp;
 
-	init_gdt(cpu, idle);
+	init_gdt(cpu);
+ 	per_cpu(current_task, cpu) = idle;
+	early_gdt_descr.address = (unsigned long)get_cpu_gdt_table(cpu);
 	irq_ctx_init(cpu);
 
 	/* Note: Don't modify initial ss override */
@@ -860,8 +861,8 @@ smp_invalidate_interrupt(void)
 
 /* This routine is called with a physical cpu mask */
 static void
-flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
-						unsigned long va)
+voyager_flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
+			  unsigned long va)
 {
 	int stuck = 50000;
 
@@ -913,7 +914,7 @@ flush_tlb_current_task(void)
 	cpu_mask = cpus_addr(mm->cpu_vm_mask)[0] & ~(1 << smp_processor_id());
 	local_flush_tlb();
 	if (cpu_mask)
-		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
+		voyager_flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 
 	preempt_enable();
 }
@@ -935,7 +936,7 @@ flush_tlb_mm (struct mm_struct * mm)
 			leave_mm(smp_processor_id());
 	}
 	if (cpu_mask)
-		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
+		voyager_flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 
 	preempt_enable();
 }
@@ -956,7 +957,7 @@ void flush_tlb_page(struct vm_area_struc
 	}
 
 	if (cpu_mask)
-		flush_tlb_others(cpu_mask, mm, va);
+		voyager_flush_tlb_others(cpu_mask, mm, va);
 
 	preempt_enable();
 }
@@ -1045,11 +1046,12 @@ smp_call_function_interrupt(void)
 }
 
 static int
-__smp_call_function_mask (void (*func) (void *info), void *info, int retry,
-			  int wait, __u32 mask)
+voyager_smp_call_function_mask (cpumask_t cpumask, void (*func) (void *info),
+				void *info, int wait)
 {
 	struct call_data_struct data;
 
+	u32 mask = cpus_addr(cpumask)[0];
 	mask &= ~(1<<smp_processor_id());
 
 	if (!mask)
@@ -1084,47 +1086,6 @@ __smp_call_function_mask (void (*func) (
 	return 0;
 }
 
-/* Call this function on all CPUs using the function_interrupt above
-    <func> The function to run. This must be fast and non-blocking.
-    <info> An arbitrary pointer to pass to the function.
-    <retry> If true, keep retrying until ready.
-    <wait> If true, wait until function has completed on other CPUs.
-    [RETURNS] 0 on success, else a negative status code. Does not return until
-    remote CPUs are nearly ready to execute <<func>> or are or have executed.
-*/
-int
-smp_call_function(void (*func) (void *info), void *info, int retry,
-		   int wait)
-{
-	__u32 mask = cpus_addr(cpu_online_map)[0];
-
-	return __smp_call_function_mask(func, info, retry, wait, mask);
-}
-EXPORT_SYMBOL(smp_call_function);
-
-/*
- * smp_call_function_single - Run a function on another CPU
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @nonatomic: Currently unused.
- * @wait: If true, wait until function has completed on other CPUs.
- *
- * Retrurns 0 on success, else a negative status code.
- *
- * Does not return until the remote CPU is nearly ready to execute <func>
- * or is or has executed.
- */
-
-int
-smp_call_function_single(int cpu, void (*func) (void *info), void *info,
-			 int nonatomic, int wait)
-{
-	__u32 mask = 1 << cpu;
-
-	return __smp_call_function_mask(func, info, nonatomic, wait, mask);
-}
-EXPORT_SYMBOL(smp_call_function_single);
-
 /* Sorry about the name.  In an APIC based system, the APICs
  * themselves are programmed to send a timer interrupt.  This is used
  * by linux to reschedule the processor.  Voyager doesn't have this,
@@ -1238,8 +1199,8 @@ smp_alloc_memory(void)
 }
 
 /* send a reschedule CPI to one CPU by physical CPU number*/
-void
-smp_send_reschedule(int cpu)
+static void
+voyager_smp_send_reschedule(int cpu)
 {
 	send_one_CPI(cpu, VIC_RESCHEDULE_CPI);
 }
@@ -1268,8 +1229,8 @@ safe_smp_processor_id(void)
 }
 
 /* broadcast a halt to all other CPUs */
-void
-smp_send_stop(void)
+static void
+voyager_smp_send_stop(void)
 {
 	smp_call_function(smp_stop_cpu_function, NULL, 1, 1);
 }
@@ -1931,23 +1892,26 @@ smp_voyager_power_off(void *dummy)
 		smp_stop_cpu_function(NULL);
 }
 
-void __init
-smp_prepare_cpus(unsigned int max_cpus)
+static void __init
+voyager_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/* FIXME: ignore max_cpus for now */
 	smp_boot_cpus();
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+static void __devinit voyager_smp_prepare_boot_cpu(void)
 {
+	init_gdt(smp_processor_id());
+	switch_to_new_gdt();
+
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 	cpu_set(smp_processor_id(), cpu_possible_map);
 	cpu_set(smp_processor_id(), cpu_present_map);
 }
 
-int __devinit
-__cpu_up(unsigned int cpu)
+static int __devinit
+voyager_cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
 	if (cpu_isset(cpu, smp_commenced_mask))
@@ -1963,8 +1927,8 @@ __cpu_up(unsigned int cpu)
 	return 0;
 }
 
-void __init 
-smp_cpus_done(unsigned int max_cpus)
+static void __init
+voyager_smp_cpus_done(unsigned int max_cpus)
 {
 	zap_low_mappings();
 }
@@ -1973,5 +1937,16 @@ void __init
 smp_setup_processor_id(void)
 {
 	current_thread_info()->cpu = hard_smp_processor_id();
-	write_pda(cpu_number, hard_smp_processor_id());
+	x86_write_percpu(cpu_number, hard_smp_processor_id());
 }
+
+struct smp_ops smp_ops = {
+	.smp_prepare_boot_cpu = voyager_smp_prepare_boot_cpu,
+	.smp_prepare_cpus = voyager_smp_prepare_cpus,
+	.cpu_up = voyager_cpu_up,
+	.smp_cpus_done = voyager_smp_cpus_done,
+
+	.smp_send_stop = voyager_smp_send_stop,
+	.smp_send_reschedule = voyager_smp_send_reschedule,
+	.smp_call_function_mask = voyager_smp_call_function_mask,
+};

--=-wcTwEqet9pnBB4l84jDV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--=-wcTwEqet9pnBB4l84jDV--
