From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 28/34] Xen-pv_ops: Xen SMP guest support
Date: Tue, 13 Mar 2007 16:30:45 -0700
Message-ID: <20070313233034.586018620@goop.org>
References: <20070313233017.933601256@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-smp.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a fairly straightforward Xen implementation of smp_ops.  One
thing this must to is carefully set up all the various sibling and
core maps so that the smp scheduler setup works properly (the setup is
very simple, since vcpus don't have any siblings or multiple cores).

Xen has its own IPI mechanisms, and has no dependency on any
APIC-based IPI.  The smp_ops hooks and the flush_tlb_others pv_op
allow a Xen guest to avoid all APIC code in arch/i386 (the only apic
operation is a single apic_read for the apic version number).

One subtle point which needs to be addressed is unpinning pagetables
when another cpu may have a lazy tlb reference to the pagetable. Xen
will not allow an in-use pagetable to be unpinned, so we must find any
other cpus with a reference to the pagetable and get them to shoot
down their references.

[ brcl, mingo: Would you mind having a close look at the code in
  xen_exit_mm and drop_mm_ref? - Thanks ]

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/smpboot.c                         |    2 =

 arch/i386/xen/Makefile                             |    6 =

 arch/i386/xen/enlighten.c                          |  115 ++++--
 arch/i386/xen/events.c                             |   78 ++++
 arch/i386/xen/mmu.c                                |   41 +-
 arch/i386/xen/mmu.h                                |    9 =

 arch/i386/xen/setup.c                              |    9 =

 arch/i386/xen/smp.c                                |  382 ++++++++++++++++=
++++
 arch/i386/xen/time.c                               |    9 =

 arch/i386/xen/xen-ops.h                            |   24 +
 include/asm-i386/mach-default/irq_vectors_limits.h |    2 =

 include/asm-i386/smp.h                             |    2 =

 include/xen/events.h                               |   27 +
 13 files changed, 650 insertions(+), 56 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -150,7 +150,7 @@ void __init smp_alloc_memory(void)
  * a given CPU
  */
 =

-static void __cpuinit smp_store_cpu_info(int id)
+void __cpuinit smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c =3D cpu_data + id;
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/Makefile
+++ b/arch/i386/xen/Makefile
@@ -1,2 +1,4 @@ obj-y		:=3D enlighten.o setup.o events.o t
-obj-y		:=3D enlighten.o setup.o events.o time.o \
-			features.o mmu.o multicalls.o
+obj-y	:=3D enlighten.o setup.o events.o time.o \
+		features.o mmu.o multicalls.o
+
+obj-$(CONFIG_SMP)	+=3D smp.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 =

 #include <xen/interface/xen.h>
+#include <xen/interface/vcpu.h>
 #include <xen/features.h>
 #include <xen/page.h>
 =

@@ -25,6 +26,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
+#include <asm/smp.h>
 =

 #include "xen-ops.h"
 #include "mmu.h"
@@ -156,10 +158,10 @@ static void xen_safe_halt(void)
 =

 static void xen_halt(void)
 {
-#if 0
 	if (irqs_disabled())
 		HYPERVISOR_vcpu_op(VCPUOP_down, smp_processor_id(), NULL);
-#endif
+	else
+		xen_safe_halt();
 }
 =

 static void xen_set_lazy_mode(int mode)
@@ -296,6 +298,32 @@ static void xen_write_idt_entry(void *dt
 	}
 }
 =

+static void xen_convert_trap_info(const struct Xgt_desc_struct *desc,
+				  struct trap_info *traps)
+{
+	unsigned in, out, count;
+
+	count =3D desc->size / 8;
+	BUG_ON(count > 256);
+
+	for(in =3D out =3D 0; in < count; in++) {
+		const u32 *entry =3D (u32 *)(desc->address + in * 8);
+
+		if (cvt_gate_to_trap(in, entry[0], entry[1], &traps[out]))
+			out++;
+	}
+	traps[out].address =3D 0;
+}
+
+void xen_copy_trap_info(struct trap_info *traps)
+{
+	const struct Xgt_desc_struct *desc =3D &get_cpu_var(idt_desc);
+
+	xen_convert_trap_info(desc, traps);
+
+	put_cpu_var(idt_desc);
+}
+
 /* Load a new IDT into Xen.  In principle this can be per-CPU, so we
    hold a spinlock to protect the static traps[] array (static because
    it avoids allocation, and saves stack space). */
@@ -303,23 +331,13 @@ static void xen_load_idt(const struct Xg
 {
 	static DEFINE_SPINLOCK(lock);
 	static struct trap_info traps[257];
-
 	int cpu =3D smp_processor_id();
-	unsigned in, out, count;
 =

 	per_cpu(idt_desc, cpu) =3D *desc;
 =

-	count =3D desc->size / 8;
-	BUG_ON(count > 256);
-
 	spin_lock(&lock);
-	for(in =3D out =3D 0; in < count; in++) {
-		const u32 *entry =3D (u32 *)(desc->address + in * 8);
-
-		if (cvt_gate_to_trap(in, entry[0], entry[1], &traps[out]))
-			out++;
-	}
-	traps[out].address =3D 0;
+
+	xen_convert_trap_info(desc, traps);
 =

 	xen_mc_flush();
 	if (HYPERVISOR_set_trap_table(traps))
@@ -376,7 +394,13 @@ static void xen_io_delay(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 static unsigned long xen_apic_read(unsigned long reg)
 {
+	WARN_ON(1);
 	return 0;
+}
+
+static void xen_apic_write(unsigned long reg, unsigned long val)
+{
+	WARN_ON(1);
 }
 #endif
 =

@@ -408,6 +432,40 @@ static void xen_flush_tlb_single(u32 add
 		BUG();
 }
 =

+static void xen_flush_tlb_others(const cpumask_t *cpus, struct mm_struct *=
mm,
+				 unsigned long va)
+{
+	struct mmuext_op op;
+	cpumask_t cpumask =3D *cpus;
+
+	/*
+	 * A couple of (to be removed) sanity checks:
+	 *
+	 * - current CPU must not be in mask
+	 * - mask must exist :)
+	 */
+	BUG_ON(cpus_empty(cpumask));
+	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
+	BUG_ON(!mm);
+
+	/* If a CPU which we ran on has gone down, OK. */
+	cpus_and(cpumask, cpumask, cpu_online_map);
+	if (cpus_empty(cpumask))
+		return;
+
+	if (va =3D=3D TLB_FLUSH_ALL) {
+		op.cmd =3D MMUEXT_TLB_FLUSH_MULTI;
+		op.arg2.vcpumask =3D (void *)cpus;
+	} else {
+		op.cmd =3D MMUEXT_INVLPG_MULTI;
+		op.arg1.linear_addr =3D va;
+		op.arg2.vcpumask =3D (void *)cpus;
+	}
+
+	if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF))
+		BUG();
+}
+
 static unsigned long xen_read_cr2(void)
 {
 	return read_pda(xen.vcpu)->arch.cr2;
@@ -418,14 +476,6 @@ static void xen_write_cr4(unsigned long =

 	/* never allow TSC to be disabled */
 	native_write_cr4(cr4 & ~X86_CR4_TSD);
 }
-
-/*
- * Page-directory addresses above 4GB do not fit into architectural %cr3.
- * When accessing %cr3, or equivalent field in vcpu_guest_context, guests
- * must use the following accessor macros to pack/unpack valid MFNs.
- */
-#define xen_pfn_to_cr3(pfn) (((unsigned)(pfn) << 12) | ((unsigned)(pfn) >>=
 20))
-#define xen_cr3_to_pfn(cr3) (((unsigned)(cr3) >> 12) | ((unsigned)(cr3) <<=
 20))
 =

 static unsigned long xen_read_cr3(void)
 {
@@ -667,8 +717,8 @@ static const struct paravirt_ops xen_par
 	.get_scheduled_cycles =3D native_read_tsc,
 =

 #ifdef CONFIG_X86_LOCAL_APIC
-	.apic_write =3D paravirt_nop,
-	.apic_write_atomic =3D paravirt_nop,
+	.apic_write =3D xen_apic_write,
+	.apic_write_atomic =3D xen_apic_write,
 	.apic_read =3D xen_apic_read,
 	.setup_boot_clock =3D paravirt_nop,
 	.setup_secondary_clock =3D paravirt_nop,
@@ -677,6 +727,7 @@ static const struct paravirt_ops xen_par
 	.flush_tlb_user =3D xen_flush_tlb,
 	.flush_tlb_kernel =3D xen_flush_tlb_global,
 	.flush_tlb_single =3D xen_flush_tlb_single,
+	.flush_tlb_others =3D xen_flush_tlb_others,
 =

 	.pte_update =3D paravirt_nop,
 	.pte_update_defer =3D paravirt_nop,
@@ -722,6 +773,19 @@ static const struct paravirt_ops xen_par
 	.startup_ipi_hook =3D paravirt_nop,
 };
 =

+#ifdef CONFIG_SMP
+static const struct smp_ops xen_smp_ops __initdata =3D {
+	.smp_prepare_boot_cpu =3D xen_smp_prepare_boot_cpu,
+	.smp_prepare_cpus =3D xen_smp_prepare_cpus,
+	.cpu_up =3D xen_cpu_up,
+	.smp_cpus_done =3D xen_smp_cpus_done,
+
+	.smp_send_stop =3D xen_smp_send_stop,
+	.smp_send_reschedule =3D xen_smp_send_reschedule,
+	.smp_call_function_mask =3D xen_smp_call_function_mask,
+};
+#endif	/* CONFIG_SMP */
+
 /* First C function to be called on Xen boot */
 static asmlinkage void __init xen_start_kernel(void)
 {
@@ -735,6 +799,9 @@ static asmlinkage void __init xen_start_
 =

 	/* Install Xen paravirt ops */
 	paravirt_ops =3D xen_paravirt_ops;
+#ifdef CONFIG_SMP
+	smp_ops =3D xen_smp_ops;
+#endif
 =

 	xen_setup_features();
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/events.c
+++ b/arch/i386/xen/events.c
@@ -24,6 +24,9 @@ static DEFINE_SPINLOCK(irq_mapping_updat
 /* IRQ <-> VIRQ mapping. */
 static DEFINE_PER_CPU(int, virq_to_irq[NR_VIRQS]) =3D {[0 ... NR_VIRQS-1] =
=3D -1};
 =

+/* IRQ <-> IPI mapping */
+static DEFINE_PER_CPU(int, ipi_to_irq[XEN_NR_IPIS]) =3D {[0 ... XEN_NR_IPI=
S-1] =3D -1};
+
 /* Packed IRQ information: binding type, sub-type index, and event channel=
. */
 struct packed_irq
 {
@@ -35,7 +38,13 @@ static struct packed_irq irq_info[NR_IRQ
 static struct packed_irq irq_info[NR_IRQS];
 =

 /* Binding types. */
-enum { IRQT_UNBOUND, IRQT_PIRQ, IRQT_VIRQ, IRQT_IPI, IRQT_EVTCHN };
+enum {
+	IRQT_UNBOUND,
+	IRQT_PIRQ,
+	IRQT_VIRQ,
+	IRQT_IPI,
+	IRQT_EVTCHN
+};
 =

 /* Convenient shorthand for packed representation of an unbound IRQ. */
 #define IRQ_UNBOUND	mk_irq_info(IRQT_UNBOUND, 0, 0)
@@ -236,6 +245,43 @@ static int bind_evtchn_to_irq(unsigned i
 	return irq;
 }
 =

+static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
+{
+	struct evtchn_bind_ipi bind_ipi;
+	int evtchn, irq;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	if ((irq =3D per_cpu(ipi_to_irq, cpu)[ipi]) =3D=3D -1) {
+		if ((irq =3D find_unbound_irq()) < 0)
+			goto out;
+
+		dynamic_irq_init(irq);
+		set_irq_chip_and_handler_name(irq, &xen_dynamic_chip,
+					      handle_level_irq, "ipi");
+
+		bind_ipi.vcpu =3D cpu;
+		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_ipi,
+						&bind_ipi) !=3D 0)
+			BUG();
+		evtchn =3D bind_ipi.port;
+
+		evtchn_to_irq[evtchn] =3D irq;
+		irq_info[irq] =3D mk_irq_info(IRQT_IPI, ipi, evtchn);
+
+		per_cpu(ipi_to_irq, cpu)[ipi] =3D irq;
+
+		bind_evtchn_to_cpu(evtchn, cpu);
+	}
+
+	irq_bindcount[irq]++;
+
+ out:
+	spin_unlock(&irq_mapping_update_lock);
+	return irq;
+}
+
+
 static int bind_virq_to_irq(unsigned int virq, unsigned int cpu)
 {
 	struct evtchn_bind_virq bind_virq;
@@ -343,12 +389,42 @@ int bind_virq_to_irqhandler(unsigned int
 }
 EXPORT_SYMBOL_GPL(bind_virq_to_irqhandler);
 =

+int bind_ipi_to_irqhandler(enum ipi_vector ipi,
+			   unsigned int cpu,
+			   irq_handler_t handler,
+			   unsigned long irqflags,
+			   const char *devname,
+			   void *dev_id)
+{
+	int irq, retval;
+
+	irq =3D bind_ipi_to_irq(ipi, cpu);
+	if (irq < 0)
+		return irq;
+
+	retval =3D request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval !=3D 0) {
+		unbind_from_irq(irq);
+		return retval;
+	}
+
+	return irq;
+}
+
 void unbind_from_irqhandler(unsigned int irq, void *dev_id)
 {
 	free_irq(irq, dev_id);
 	unbind_from_irq(irq);
 }
 EXPORT_SYMBOL_GPL(unbind_from_irqhandler);
+
+void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
+{
+	int irq =3D per_cpu(ipi_to_irq, cpu)[vector];
+	BUG_ON(irq < 0);
+	notify_remote_via_irq(irq);
+}
+
 =

 /*
   Search the CPUs pending events bitmasks.  For each one found, map
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/mmu.c
+++ b/arch/i386/xen/mmu.c
@@ -443,27 +443,38 @@ void xen_dup_mmap(struct mm_struct *oldm
 	spin_unlock(&mm->page_table_lock);
 }
 =

-void xen_exit_mmap(struct mm_struct *mm)
-{
-	struct task_struct *tsk =3D current;
-
-	task_lock(tsk);
-
-	/*
-	 * We aggressively remove defunct pgd from cr3. We execute unmap_vmas()
-	 * *much* faster this way, as no tlb flushes means bigger wrpt batches.
-	 */
-	if (tsk->active_mm =3D=3D mm) {
-		tsk->active_mm =3D &init_mm;
+/*
+ * We aggressively remove defunct pgd from cr3. We execute unmap_vmas()
+ * *much* faster this way.
+ */
+static void drop_mm_ref(void *info)
+{
+	struct mm_struct *mm =3D info;
+
+	task_lock(current);
+	if (current->active_mm =3D=3D mm) {
+		current->active_mm =3D &init_mm;
 		atomic_inc(&init_mm.mm_count);
 =

-		switch_mm(mm, &init_mm, tsk);
+		switch_mm(mm, &init_mm, current);
 =

 		atomic_dec(&mm->mm_count);
 		BUG_ON(atomic_read(&mm->mm_count) =3D=3D 0);
 	}
-
-	task_unlock(tsk);
+	task_unlock(current);
+
+	BUG_ON(cpu_isset(smp_processor_id(), mm->cpu_vm_mask));
+}
+
+void xen_exit_mmap(struct mm_struct *mm)
+{
+	drop_mm_ref(mm);
+
+#ifdef CONFIG_SMP
+	if (!cpus_empty(mm->cpu_vm_mask))
+		xen_smp_call_function_mask(mm->cpu_vm_mask, drop_mm_ref,
+					   mm, 1);
+#endif	/* CONFIG_SMP */
 =

 	xen_pgd_unpin(mm->pgd);
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/mmu.h
+++ b/arch/i386/xen/mmu.h
@@ -2,6 +2,15 @@
 =

 #include <linux/linkage.h>
 #include <asm/page.h>
+
+/*
+ * Page-directory addresses above 4GB do not fit into architectural %cr3.
+ * When accessing %cr3, or equivalent field in vcpu_guest_context, guests
+ * must use the following accessor macros to pack/unpack valid MFNs.
+ */
+#define xen_pfn_to_cr3(pfn) (((unsigned)(pfn) << 12) | ((unsigned)(pfn) >>=
 20))
+#define xen_cr3_to_pfn(cr3) (((unsigned)(cr3) >> 12) | ((unsigned)(cr3) <<=
 20))
+
 =

 void set_pte_mfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/setup.c
+++ b/arch/i386/xen/setup.c
@@ -15,10 +15,6 @@
 #include <xen/features.h>
 =

 #include "xen-ops.h"
-
-/* These are code, but not functions.  Defined in entry.S */
-extern const char xen_hypervisor_callback[];
-extern const char xen_failsafe_callback[];
 =

 static __initdata struct shared_info init_shared;
 =

@@ -92,4 +88,9 @@ void __init xen_arch_setup(void)
 	pm_idle =3D xen_idle;
 =

 	vdso_enabled =3D 1;	/* enable by default */
+
+#ifdef CONFIG_SMP
+	/* fill cpus_possible with all available cpus */
+	xen_fill_possible_map();
+#endif
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/arch/i386/xen/smp.c
@@ -0,0 +1,382 @@
+#include <linux/sched.h>
+#include <linux/err.h>
+
+#include <asm/paravirt.h>
+#include <asm/smp.h>
+#include <asm/desc.h>
+#include <asm/pgtable.h>
+#include <asm/cpu.h>
+
+#include <xen/interface/xen.h>
+#include <xen/interface/vcpu.h>
+
+#include <asm/xen/interface.h>
+#include <asm/xen/hypercall.h>
+
+#include <xen/page.h>
+#include <xen/events.h>
+
+#include "xen-ops.h"
+#include "mmu.h"
+
+static cpumask_t cpu_initialized_map;
+static DEFINE_PER_CPU(int, resched_irq);
+static DEFINE_PER_CPU(int, callfunc_irq);
+
+/*
+ * Structure and data for smp_call_function(). This is designed to minimise
+ * static memory requirements. It also looks cleaner.
+ */
+static DEFINE_SPINLOCK(call_lock);
+
+struct call_data_struct {
+	void (*func) (void *info);
+	void *info;
+	atomic_t started;
+	atomic_t finished;
+	int wait;
+};
+
+static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id);
+
+static struct call_data_struct *call_data;
+
+/*
+ * Reschedule call back. Nothing to do,
+ * all the work is done automatically when
+ * we return from the interrupt.
+ */
+static irqreturn_t xen_reschedule_interrupt(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+/* VCPUs are single-cored, and have no siblings */
+static void set_cpu_sibling_map(int cpu)
+{
+	struct cpuinfo_x86 *c =3D &cpu_data[cpu];
+
+	cpu_set(cpu, cpu_sibling_map[cpu]);
+	cpu_set(cpu, c->llc_shared_map);
+	cpu_core_map[cpu] =3D cpu_sibling_map[cpu];
+	c->booted_cores =3D 1;
+}
+
+static void remove_siblinginfo(int cpu)
+{
+	struct cpuinfo_x86 *c =3D &cpu_data[cpu];
+
+	cpus_clear(cpu_sibling_map[cpu]);
+	cpus_clear(cpu_core_map[cpu]);
+	c->booted_cores =3D 0;
+	c->phys_proc_id =3D 0;
+	c->cpu_core_id =3D 0;
+}
+
+static void cpu_bringup_and_idle(void)
+{
+	int cpu =3D smp_processor_id();
+
+	secondary_cpu_init();
+	xen_setup_timer();
+
+	preempt_disable();
+	per_cpu(cpu_state, cpu) =3D CPU_ONLINE;
+
+	/* We can take interrupts now: we're officially "up". */
+	local_irq_enable();
+
+	wmb();
+	cpu_idle();
+}
+
+static void cpu_initialize_context(unsigned int cpu, struct task_struct *i=
dle)
+{
+	struct vcpu_guest_context ctxt;
+	struct Xgt_desc_struct *gdt_descr =3D &per_cpu(cpu_gdt_descr, cpu);
+
+	if (cpu_test_and_set(cpu, cpu_initialized_map))
+		return;
+
+	memset(&ctxt, 0, sizeof(ctxt));
+
+	ctxt.flags =3D VGCF_IN_KERNEL;
+	ctxt.user_regs.ds =3D __USER_DS;
+	ctxt.user_regs.es =3D __USER_DS;
+	ctxt.user_regs.fs =3D __KERNEL_PDA;
+	ctxt.user_regs.gs =3D 0;
+	ctxt.user_regs.ss =3D __KERNEL_DS;
+	ctxt.user_regs.eip =3D (unsigned long)cpu_bringup_and_idle;
+	ctxt.user_regs.eflags =3D X86_EFLAGS_IF | 0x1000; /* IOPL_RING1 */
+
+	memset(&ctxt.fpu_ctxt, 0, sizeof(ctxt.fpu_ctxt));
+
+	xen_copy_trap_info(ctxt.trap_ctxt);
+
+	ctxt.ldt_ents =3D 0;
+
+	make_lowmem_page_readonly((void *)gdt_descr->address);
+
+	ctxt.gdt_frames[0] =3D virt_to_mfn(gdt_descr->address);
+	ctxt.gdt_ents      =3D gdt_descr->size / 8;
+
+	ctxt.user_regs.cs =3D __KERNEL_CS;
+	ctxt.user_regs.esp =3D idle->thread.esp0 - sizeof(struct pt_regs);
+
+	ctxt.kernel_ss =3D __KERNEL_DS;
+	ctxt.kernel_sp =3D idle->thread.esp0;
+
+	ctxt.event_callback_cs     =3D __KERNEL_CS;
+	ctxt.event_callback_eip    =3D (unsigned long)xen_hypervisor_callback;
+	ctxt.failsafe_callback_cs  =3D __KERNEL_CS;
+	ctxt.failsafe_callback_eip =3D (unsigned long)xen_failsafe_callback;
+
+	ctxt.ctrlreg[3] =3D xen_pfn_to_cr3(virt_to_mfn(swapper_pg_dir));
+
+	if (HYPERVISOR_vcpu_op(VCPUOP_initialise, cpu, &ctxt))
+		BUG();
+}
+
+static int xen_smp_intr_init(unsigned int cpu)
+{
+	int rc;
+	const char *resched_name, *callfunc_name;
+
+	per_cpu(resched_irq, cpu) =3D per_cpu(callfunc_irq, cpu) =3D -1;
+
+	resched_name =3D kasprintf(GFP_KERNEL, "resched%d", cpu);
+	rc =3D bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
+				    cpu,
+				    xen_reschedule_interrupt,
+				    SA_INTERRUPT,
+				    resched_name,
+				    NULL);
+	if (rc < 0)
+		goto fail;
+	per_cpu(resched_irq, cpu) =3D rc;
+
+	callfunc_name =3D kasprintf(GFP_KERNEL, "callfunc%d", cpu);
+	rc =3D bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_VECTOR,
+				    cpu,
+				    xen_call_function_interrupt,
+				    SA_INTERRUPT,
+				    callfunc_name,
+				    NULL);
+	if (rc < 0)
+		goto fail;
+	per_cpu(callfunc_irq, cpu) =3D rc;
+
+	return 0;
+
+ fail:
+	if (per_cpu(resched_irq, cpu) >=3D 0)
+		unbind_from_irqhandler(per_cpu(resched_irq, cpu), NULL);
+	if (per_cpu(callfunc_irq, cpu) >=3D 0)
+		unbind_from_irqhandler(per_cpu(callfunc_irq, cpu), NULL);
+	return rc;
+}
+
+void __init xen_fill_possible_map(void)
+{
+	int i, rc;
+
+	for_each_possible_cpu(i)
+	    if (i !=3D smp_processor_id())
+		return;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		rc =3D HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL);
+		if (rc >=3D 0)
+			cpu_set(i, cpu_possible_map);
+	}
+}
+
+void __init xen_smp_prepare_boot_cpu(void)
+{
+	int cpu;
+
+	BUG_ON(smp_processor_id() !=3D 0);
+	native_smp_prepare_boot_cpu();
+
+	smp_store_cpu_info(0);
+
+	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+	}
+
+	xen_fill_possible_map();  /* should already be done */
+}
+
+void xen_smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned cpu;
+
+	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+	}
+
+	set_cpu_sibling_map(0);
+
+	if (xen_smp_intr_init(0))
+		BUG();
+
+	cpu_initialized_map =3D cpumask_of_cpu(0);
+
+	/* Restrict the possible_map according to max_cpus. */
+	while ((num_possible_cpus() > 1) && (num_possible_cpus() > max_cpus)) {
+		for (cpu =3D NR_CPUS-1; !cpu_isset(cpu, cpu_possible_map); cpu--)
+			continue;
+		cpu_clear(cpu, cpu_possible_map);
+	}
+
+	for_each_possible_cpu (cpu) {
+		struct task_struct *idle;
+
+		if (cpu =3D=3D 0)
+			continue;
+
+		idle =3D fork_idle(cpu);
+		if (IS_ERR(idle))
+			panic("failed fork for CPU %d", cpu);
+
+		cpu_set(cpu, cpu_present_map);
+	}
+
+	//init_xenbus_allowed_cpumask();
+}
+
+int xen_cpu_up(unsigned int cpu)
+{
+	struct task_struct *idle =3D idle_task(cpu);
+	int rc;
+
+#if 0
+	rc =3D cpu_up_check(cpu);
+	if (rc)
+		return rc;
+#endif
+
+	init_gdt(cpu, idle);
+	irq_ctx_init(cpu);
+
+	cpu_initialize_context(cpu, idle);
+
+	if (num_online_cpus() =3D=3D 1)
+		alternatives_smp_switch(1);
+
+	/* This must be done before setting cpu_online_map */
+	smp_store_cpu_info(cpu);
+	set_cpu_sibling_map(cpu);
+	wmb();
+
+	rc =3D xen_smp_intr_init(cpu);
+	if (rc) {
+		remove_siblinginfo(cpu);
+		return rc;
+	}
+
+	cpu_set(cpu, cpu_online_map);
+
+	rc =3D HYPERVISOR_vcpu_op(VCPUOP_up, cpu, NULL);
+	BUG_ON(rc);
+
+	return 0;
+}
+
+void xen_smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+void xen_smp_send_stop(void)
+{
+}
+
+void xen_smp_send_reschedule(int cpu)
+{
+	xen_send_IPI_one(cpu, XEN_RESCHEDULE_VECTOR);
+}
+
+
+static void xen_send_IPI_mask(cpumask_t mask, enum ipi_vector vector)
+{
+	unsigned cpu;
+
+	cpus_and(mask, mask, cpu_online_map);
+
+	for_each_cpu_mask(cpu, mask)
+		xen_send_IPI_one(cpu, vector);
+}
+
+static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id)
+{
+	void (*func) (void *info) =3D call_data->func;
+	void *info =3D call_data->info;
+	int wait =3D call_data->wait;
+
+	/*
+	 * Notify initiating CPU that I've grabbed the data and am
+	 * about to execute the function
+	 */
+	mb();
+	atomic_inc(&call_data->started);
+	/*
+	 * At this point the info structure may be out of scope unless wait=3D=3D1
+	 */
+	irq_enter();
+	(*func)(info);
+	irq_exit();
+
+	if (wait) {
+		mb();
+		atomic_inc(&call_data->finished);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int xen_smp_call_function_mask(cpumask_t mask, void (*func)(void *),
+			       void *info, int wait)
+{
+	struct call_data_struct data;
+	int cpus;
+
+	/* Holding any lock stops cpus from going down. */
+	spin_lock(&call_lock);
+
+	cpu_clear(smp_processor_id(), mask);
+
+	cpus =3D cpus_weight(mask);
+	if (!cpus) {
+		spin_unlock(&call_lock);
+		return 0;
+	}
+
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
+	data.func =3D func;
+	data.info =3D info;
+	atomic_set(&data.started, 0);
+	data.wait =3D wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	call_data =3D &data;
+	mb();
+
+	/* Send a message to all other CPUs and wait for them to respond */
+	xen_send_IPI_mask(mask, XEN_CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) !=3D cpus)
+		cpu_relax();
+
+	if (wait)
+		while (atomic_read(&data.finished) !=3D cpus)
+			cpu_relax();
+	spin_unlock(&call_lock);
+
+	return 0;
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/time.c
+++ b/arch/i386/xen/time.c
@@ -359,8 +359,9 @@ static const struct clock_event_device *
 static const struct clock_event_device *xen_clockevent =3D &xen_timerop_cl=
ockevent;
 static irq_handler_t xen_timer_interrupt =3D xen_timerop_timer_interrupt;
 =

-static void xen_setup_timer(int cpu)
-{
+void xen_setup_timer(void)
+{
+	int cpu =3D smp_processor_id();
 	const char *name;
 	struct clock_event_device *evt;
 	int irq;
@@ -407,5 +408,5 @@ __init void xen_time_init(void)
 =

 	tsc_disable =3D 0;
 =

-	xen_setup_timer(cpu);
-}
+	xen_setup_timer();
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/xen-ops.h
+++ b/arch/i386/xen/xen-ops.h
@@ -2,6 +2,13 @@
 #define XEN_OPS_H
 =

 #include <linux/init.h>
+#include <linux/percpu.h>
+
+/* These are code, but not functions.  Defined in entry.S */
+extern const char xen_hypervisor_callback[];
+extern const char xen_failsafe_callback[];
+
+void xen_copy_trap_info(struct trap_info *traps);
 =

 extern struct start_info *xen_start_info;
 extern struct shared_info *HYPERVISOR_shared_info;
@@ -14,6 +21,7 @@ void __init xen_time_init(void);
 void __init xen_time_init(void);
 unsigned long xen_get_wallclock(void);
 int xen_set_wallclock(unsigned long time);
+void xen_setup_timer(void);
 =

 void xen_mark_init_mm_pinned(void);
 =

@@ -27,5 +35,21 @@ static inline unsigned xen_get_lazy_mode
 	return ret;
 }
 =

+void __init xen_fill_possible_map(void);
+
+void xen_smp_prepare_boot_cpu(void);
+void xen_smp_prepare_cpus(unsigned int max_cpus);
+int xen_cpu_up(unsigned int cpu);
+void xen_smp_cpus_done(unsigned int max_cpus);
+
+void xen_smp_send_stop(void);
+void xen_smp_send_reschedule(int cpu);
+int xen_smp_call_function (void (*func) (void *info), void *info, int nona=
tomic,
+			   int wait);
+int xen_smp_call_function_single(int cpu, void (*func) (void *info), void =
*info,
+				 int nonatomic, int wait);
+
+int xen_smp_call_function_mask(cpumask_t mask, void (*func)(void *),
+			       void *info, int wait);
 =

 #endif /* XEN_OPS_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/mach-default/irq_vectors_limits.h
+++ b/include/asm-i386/mach-default/irq_vectors_limits.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_IRQ_VECTORS_LIMITS_H
 #define _ASM_IRQ_VECTORS_LIMITS_H
 =

-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) || defined(CONFIG_PARAVIRT)
 #define NR_IRQS 224
 # if (224 >=3D 32 * NR_CPUS)
 # define NR_IRQ_VECTORS NR_IRQS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -146,6 +146,8 @@ extern void __cpu_die(unsigned int cpu);
 extern void __cpu_die(unsigned int cpu);
 extern unsigned int num_processors;
 =

+void __cpuinit smp_store_cpu_info(int id);
+
 #endif /* !__ASSEMBLY__ */
 =

 #else /* CONFIG_SMP */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -1,15 +1,32 @@
 #ifndef _XEN_EVENTS_H
 #define _XEN_EVENTS_H
 =

-#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <xen/interface/event_channel.h>
+#include <asm/xen/hypercall.h>
+
+enum ipi_vector {
+	XEN_RESCHEDULE_VECTOR,
+	XEN_CALL_FUNCTION_VECTOR,
+
+	XEN_NR_IPIS,
+};
 =

 int bind_evtchn_to_irqhandler(unsigned int evtchn,
-			      irqreturn_t (*handler)(int, void *),
+			      irq_handler_t handler,
 			      unsigned long irqflags, const char *devname,
 			      void *dev_id);
 int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
-			    irqreturn_t (*handler)(int, void *),
-			    unsigned long irqflags, const char *devname, void *dev_id);
+			    irq_handler_t handler,
+			    unsigned long irqflags, const char *devname,
+			    void *dev_id);
+int bind_ipi_to_irqhandler(enum ipi_vector ipi,
+			   unsigned int cpu,
+			   irq_handler_t handler,
+			   unsigned long irqflags,
+			   const char *devname,
+			   void *dev_id);
 =

 /*
  * Common unbind function for all event sources. Takes IRQ to unbind from.
@@ -17,6 +34,8 @@ int bind_virq_to_irqhandler(unsigned int
  * made with bind_evtchn_to_irqhandler()).
  */
 void unbind_from_irqhandler(unsigned int irq, void *dev_id);
+
+void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector);
 =

 static inline void notify_remote_via_evtchn(int port)
 {

-- =
