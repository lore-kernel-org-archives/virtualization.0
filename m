From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC] first cut at splitting up paravirt_ops
Date: Mon, 09 Jul 2007 17:19:02 -0700
Message-ID: <4692D076.6060204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Here's a first attempt at splitting up paravirt_ops into more specific 
chunks.  Its pretty clunky and chunky; mostly just a lot of 
replacement.  The grouping of ops is very first cut; I'm open to 
suggestions about what groups should exist and what ops they each should 
contain.

The only slightly subtle part is that I've kept the structures wrapped 
in a paravirt_ops structure, primarily so that we can still use offsetof 
for generating patching IDs.  The paravirt_ops is static, and I extract 
the sub-groups with global aliases which can be individually exported.

Patch against 2.6.22-rc6-mm1.

    J

---
 arch/i386/kernel/alternative.c         |    4 
 arch/i386/kernel/asm-offsets.c         |   12 
 arch/i386/kernel/entry.S               |    2 
 arch/i386/kernel/paravirt.c            |  311 +++++++++------
 arch/i386/kernel/vmi.c                 |  168 ++++----
 arch/i386/xen/enlighten.c              |  149 ++++---
 drivers/char/hvc_lguest.c              |    2 
 drivers/lguest/core.c                  |    3 
 drivers/lguest/lguest.c                |  110 +++--
 drivers/lguest/lguest_bus.c            |    2 
 include/asm-i386/paravirt.h            |  638 ++++++++++++++++----------------
 include/asm-i386/pgtable-3level-defs.h |    2 
 12 files changed, 762 insertions(+), 641 deletions(-)

===================================================================
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -352,8 +352,8 @@ void apply_paravirt(struct paravirt_patc
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
-		used = paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
-					  p->len);
+		used = pv_init_ops.patch(p->instrtype, p->clobbers, p->instr,
+					 p->len);
 
 		BUG_ON(used > p->len);
 
===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -118,12 +118,12 @@ void foo(void)
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_enabled, paravirt_ops, paravirt_enabled);
-	OFFSET(PARAVIRT_irq_disable, paravirt_ops, irq_disable);
-	OFFSET(PARAVIRT_irq_enable, paravirt_ops, irq_enable);
-	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
-	OFFSET(PARAVIRT_iret, paravirt_ops, iret);
-	OFFSET(PARAVIRT_read_cr0, paravirt_ops, read_cr0);
+	OFFSET(PARAVIRT_enabled, pv_info, paravirt_enabled);
+	OFFSET(PARAVIRT_irq_disable, pv_irq_ops, irq_disable);
+	OFFSET(PARAVIRT_irq_enable, pv_irq_ops, irq_enable);
+	OFFSET(PARAVIRT_irq_enable_sysexit, pv_cpu_ops, irq_enable_sysexit);
+	OFFSET(PARAVIRT_iret, pv_cpu_ops, iret);
+	OFFSET(PARAVIRT_read_cr0, pv_cpu_ops, read_cr0);
 #endif
 
 #ifdef CONFIG_XEN
===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -436,7 +436,7 @@ ldt_ss:
 	 * is still available to implement the setting of the high
 	 * 16-bits in the INTERRUPT_RETURN paravirt-op.
 	 */
-	cmpl $0, paravirt_ops+PARAVIRT_enabled
+	cmpl $0, pv_info+PARAVIRT_enabled
 	jne restore_nocheck
 #endif
 
===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -34,6 +34,8 @@
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
 
+static struct paravirt_ops paravirt_ops;
+
 /* nop stub */
 void _paravirt_nop(void)
 {
@@ -42,12 +44,12 @@ static void __init default_banner(void)
 static void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
-	       paravirt_ops.name);
+	       pv_info.name);
 }
 
 char *memory_setup(void)
 {
-	return paravirt_ops.memory_setup();
+	return pv_init_ops.memory_setup();
 }
 
 /* Simple instruction patching code. */
@@ -75,31 +77,34 @@ static unsigned native_patch(u8 type, u1
 	unsigned ret;
 
 	switch(type) {
-#define SITE(x)	case PARAVIRT_PATCH(x):	start = start_##x; end = end_##x; goto patch_site
-		SITE(irq_disable);
-		SITE(irq_enable);
-		SITE(restore_fl);
-		SITE(save_fl);
-		SITE(iret);
-		SITE(irq_enable_sysexit);
-		SITE(read_cr2);
-		SITE(read_cr3);
-		SITE(write_cr3);
-		SITE(clts);
-		SITE(read_tsc);
+#define SITE(ops,x)				\
+		case PARAVIRT_PATCH(ops.x):				\
+			start = start_##x; end = end_##x; goto patch_site
+
+		SITE(pv_irq_ops, irq_disable);
+		SITE(pv_irq_ops, irq_enable);
+		SITE(pv_irq_ops, restore_fl);
+		SITE(pv_irq_ops, save_fl);
+		SITE(pv_cpu_ops, iret);
+		SITE(pv_cpu_ops, irq_enable_sysexit);
+		SITE(pv_mmu_ops, read_cr2);
+		SITE(pv_mmu_ops, read_cr3);
+		SITE(pv_mmu_ops, write_cr3);
+		SITE(pv_cpu_ops, clts);
+		SITE(pv_cpu_ops, read_tsc);
 #undef SITE
 
 	patch_site:
 		ret = paravirt_patch_insns(insns, len, start, end);
 		break;
 
-	case PARAVIRT_PATCH(make_pgd):
-	case PARAVIRT_PATCH(make_pte):
-	case PARAVIRT_PATCH(pgd_val):
-	case PARAVIRT_PATCH(pte_val):
+	case PARAVIRT_PATCH(pv_mmu_ops.make_pgd):
+	case PARAVIRT_PATCH(pv_mmu_ops.make_pte):
+	case PARAVIRT_PATCH(pv_mmu_ops.pgd_val):
+	case PARAVIRT_PATCH(pv_mmu_ops.pte_val):
 #ifdef CONFIG_X86_PAE
-	case PARAVIRT_PATCH(make_pmd):
-	case PARAVIRT_PATCH(pmd_val):
+	case PARAVIRT_PATCH(pv_mmu_ops.make_pmd):
+	case PARAVIRT_PATCH(pv_mmu_ops.pmd_val):
 #endif
 		/* These functions end up returning exactly what
 		   they're passed, in the same registers. */
@@ -167,8 +172,8 @@ unsigned paravirt_patch_default(u8 type,
 	else if (opfunc == paravirt_nop)
 		/* If the operation is a nop, then nop the callsite */
 		ret = paravirt_patch_nop();
-	else if (type == PARAVIRT_PATCH(iret) ||
-		 type == PARAVIRT_PATCH(irq_enable_sysexit))
+	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
+		 type == PARAVIRT_PATCH(pv_cpu_ops.irq_enable_sysexit))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(opfunc, site, len);
 	else
@@ -195,7 +200,7 @@ unsigned paravirt_patch_insns(void *site
 
 void init_IRQ(void)
 {
-	paravirt_ops.init_IRQ();
+	pv_init_ops.init_IRQ();
 }
 
 static void native_flush_tlb(void)
@@ -223,7 +228,7 @@ extern void native_irq_enable_sysexit(vo
 
 static int __init print_banner(void)
 {
-	paravirt_ops.banner();
+	pv_init_ops.banner();
 	return 0;
 }
 core_initcall(print_banner);
@@ -263,120 +268,166 @@ int paravirt_disable_iospace(void)
 	return ret;
 }
 
-struct paravirt_ops paravirt_ops = {
-	.name = "bare hardware",
-	.paravirt_enabled = 0,
-	.kernel_rpl = 0,
-	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
-
- 	.patch = native_patch,
-	.banner = default_banner,
-	.arch_setup = paravirt_nop,
-	.memory_setup = machine_specific_memory_setup,
-	.get_wallclock = native_get_wallclock,
-	.set_wallclock = native_set_wallclock,
-	.time_init = hpet_time_init,
-	.init_IRQ = native_init_IRQ,
-
-	.cpuid = native_cpuid,
-	.get_debugreg = native_get_debugreg,
-	.set_debugreg = native_set_debugreg,
-	.clts = native_clts,
-	.read_cr0 = native_read_cr0,
-	.write_cr0 = native_write_cr0,
-	.read_cr2 = native_read_cr2,
-	.write_cr2 = native_write_cr2,
-	.read_cr3 = native_read_cr3,
-	.write_cr3 = native_write_cr3,
-	.read_cr4 = native_read_cr4,
-	.read_cr4_safe = native_read_cr4_safe,
-	.write_cr4 = native_write_cr4,
-	.save_fl = native_save_fl,
-	.restore_fl = native_restore_fl,
-	.irq_disable = native_irq_disable,
-	.irq_enable = native_irq_enable,
-	.safe_halt = native_safe_halt,
-	.halt = native_halt,
-	.wbinvd = native_wbinvd,
-	.read_msr = native_read_msr_safe,
-	.write_msr = native_write_msr_safe,
-	.read_tsc = native_read_tsc,
-	.read_pmc = native_read_pmc,
-	.sched_clock = native_sched_clock,
-	.get_cpu_khz = native_calculate_cpu_khz,
-	.load_tr_desc = native_load_tr_desc,
-	.set_ldt = native_set_ldt,
-	.load_gdt = native_load_gdt,
-	.load_idt = native_load_idt,
-	.store_gdt = native_store_gdt,
-	.store_idt = native_store_idt,
-	.store_tr = native_store_tr,
-	.load_tls = native_load_tls,
-	.write_ldt_entry = write_dt_entry,
-	.write_gdt_entry = write_dt_entry,
-	.write_idt_entry = write_dt_entry,
-	.load_esp0 = native_load_esp0,
-
-	.set_iopl_mask = native_set_iopl_mask,
-	.io_delay = native_io_delay,
-
+static struct paravirt_ops paravirt_ops = {
+	.pv_info = {
+		.name = "bare hardware",
+		.paravirt_enabled = 0,
+		.kernel_rpl = 0,
+		.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
+	},
+
+	.pv_init_ops = {
+		 .patch = native_patch,
+		 .banner = default_banner,
+		 .arch_setup = paravirt_nop,
+		 .memory_setup = machine_specific_memory_setup,
+		 .time_init = hpet_time_init,
+		 .init_IRQ = native_init_IRQ,
+		 .pagetable_setup_start = native_pagetable_setup_start,
+		 .pagetable_setup_done = native_pagetable_setup_done,
+
+	 },
+
+	.pv_time_ops = {
+		 .get_wallclock = native_get_wallclock,
+		 .set_wallclock = native_set_wallclock,
+		 .sched_clock = native_sched_clock,
+		 .get_cpu_khz = native_calculate_cpu_khz,
+	 },
+
+	.pv_irq_ops = {
+		 .save_fl = native_save_fl,
+		 .restore_fl = native_restore_fl,
+		 .irq_disable = native_irq_disable,
+		 .irq_enable = native_irq_enable,
+		 .safe_halt = native_safe_halt,
+		 .halt = native_halt,
+	 },
+
+	.pv_cpu_ops = {
+		 .cpuid = native_cpuid,
+		 .get_debugreg = native_get_debugreg,
+		 .set_debugreg = native_set_debugreg,
+		 .clts = native_clts,
+		 .read_cr0 = native_read_cr0,
+		 .write_cr0 = native_write_cr0,
+		 .read_cr4 = native_read_cr4,
+		 .read_cr4_safe = native_read_cr4_safe,
+		 .write_cr4 = native_write_cr4,
+		 .wbinvd = native_wbinvd,
+		 .read_msr = native_read_msr_safe,
+		 .write_msr = native_write_msr_safe,
+		 .read_tsc = native_read_tsc,
+		 .read_pmc = native_read_pmc,
+		 .load_tr_desc = native_load_tr_desc,
+		 .set_ldt = native_set_ldt,
+		 .load_gdt = native_load_gdt,
+		 .load_idt = native_load_idt,
+		 .store_gdt = native_store_gdt,
+		 .store_idt = native_store_idt,
+		 .store_tr = native_store_tr,
+		 .load_tls = native_load_tls,
+		 .write_ldt_entry = write_dt_entry,
+		 .write_gdt_entry = write_dt_entry,
+		 .write_idt_entry = write_dt_entry,
+		 .load_esp0 = native_load_esp0,
+
+		 .irq_enable_sysexit = native_irq_enable_sysexit,
+		 .iret = native_iret,
+
+		 .set_iopl_mask = native_set_iopl_mask,
+		 .io_delay = native_io_delay,
+	 },
+
+	.pv_apic_ops = {
 #ifdef CONFIG_X86_LOCAL_APIC
-	.apic_write = native_apic_write,
-	.apic_write_atomic = native_apic_write_atomic,
-	.apic_read = native_apic_read,
-	.setup_boot_clock = setup_boot_APIC_clock,
-	.setup_secondary_clock = setup_secondary_APIC_clock,
-	.startup_ipi_hook = paravirt_nop,
+		 .apic_write = native_apic_write,
+		 .apic_write_atomic = native_apic_write_atomic,
+		 .apic_read = native_apic_read,
+		 .setup_boot_clock = setup_boot_APIC_clock,
+		 .setup_secondary_clock = setup_secondary_APIC_clock,
+		 .startup_ipi_hook = paravirt_nop,
 #endif
-	.set_lazy_mode = paravirt_nop,
-
-	.pagetable_setup_start = native_pagetable_setup_start,
-	.pagetable_setup_done = native_pagetable_setup_done,
-
-	.flush_tlb_user = native_flush_tlb,
-	.flush_tlb_kernel = native_flush_tlb_global,
-	.flush_tlb_single = native_flush_tlb_single,
-	.flush_tlb_others = native_flush_tlb_others,
-
-	.alloc_pt = paravirt_nop,
-	.alloc_pd = paravirt_nop,
-	.alloc_pd_clone = paravirt_nop,
-	.release_pt = paravirt_nop,
-	.release_pd = paravirt_nop,
-
-	.set_pte = native_set_pte,
-	.set_pte_at = native_set_pte_at,
-	.set_pmd = native_set_pmd,
-	.pte_update = paravirt_nop,
-	.pte_update_defer = paravirt_nop,
+	 },
+
+	.pv_misc_ops = {
+		 .set_lazy_mode = paravirt_nop,
+	 },
+
+	.pv_mmu_ops = {
+		 .read_cr2 = native_read_cr2,
+		 .write_cr2 = native_write_cr2,
+		 .read_cr3 = native_read_cr3,
+		 .write_cr3 = native_write_cr3,
+
+		 .flush_tlb_user = native_flush_tlb,
+		 .flush_tlb_kernel = native_flush_tlb_global,
+		 .flush_tlb_single = native_flush_tlb_single,
+		 .flush_tlb_others = native_flush_tlb_others,
+
+		 .alloc_pt = paravirt_nop,
+		 .alloc_pd = paravirt_nop,
+		 .alloc_pd_clone = paravirt_nop,
+		 .release_pt = paravirt_nop,
+		 .release_pd = paravirt_nop,
+
+		 .set_pte = native_set_pte,
+		 .set_pte_at = native_set_pte_at,
+		 .set_pmd = native_set_pmd,
+		 .pte_update = paravirt_nop,
+		 .pte_update_defer = paravirt_nop,
 
 #ifdef CONFIG_HIGHPTE
-	.kmap_atomic_pte = kmap_atomic,
+		 .kmap_atomic_pte = kmap_atomic,
 #endif
 
 #ifdef CONFIG_X86_PAE
-	.set_pte_atomic = native_set_pte_atomic,
-	.set_pte_present = native_set_pte_present,
-	.set_pud = native_set_pud,
-	.pte_clear = native_pte_clear,
-	.pmd_clear = native_pmd_clear,
-
-	.pmd_val = native_pmd_val,
-	.make_pmd = native_make_pmd,
+		 .set_pte_atomic = native_set_pte_atomic,
+		 .set_pte_present = native_set_pte_present,
+		 .set_pud = native_set_pud,
+		 .pte_clear = native_pte_clear,
+		 .pmd_clear = native_pmd_clear,
+
+		 .pmd_val = native_pmd_val,
+		 .make_pmd = native_make_pmd,
 #endif
 
-	.pte_val = native_pte_val,
-	.pgd_val = native_pgd_val,
-
-	.make_pte = native_make_pte,
-	.make_pgd = native_make_pgd,
-
-	.irq_enable_sysexit = native_irq_enable_sysexit,
-	.iret = native_iret,
-
-	.dup_mmap = paravirt_nop,
-	.exit_mmap = paravirt_nop,
-	.activate_mm = paravirt_nop,
+		 .pte_val = native_pte_val,
+		 .pgd_val = native_pgd_val,
+
+		 .make_pte = native_make_pte,
+		 .make_pgd = native_make_pgd,
+
+		 .dup_mmap = paravirt_nop,
+		 .exit_mmap = paravirt_nop,
+		 .activate_mm = paravirt_nop,
+	 },
 };
 
-EXPORT_SYMBOL(paravirt_ops);
+static void __init __used pv_aliases(void)
+{
+	/* These asm statements need to be wrapped in a function just
+	 * so we can pass args to them; they are completely constant,
+	 * and this function is never executed. */
+#define substructure(inner)						\
+	asm(".data; .globl %0; %0 = paravirt_ops+%c1; .previous"	\
+	    : : "m" (inner),						\
+	    "i" (offsetof(struct paravirt_ops, inner)))
+
+	substructure(pv_info);
+	substructure(pv_init_ops);
+	substructure(pv_misc_ops);
+	substructure(pv_time_ops);
+	substructure(pv_cpu_ops);
+	substructure(pv_irq_ops);
+	substructure(pv_apic_ops);
+	substructure(pv_mmu_ops);
+
+#undef substructure
+}
+
+EXPORT_SYMBOL_GPL(pv_time_ops);
+EXPORT_SYMBOL_GPL(pv_cpu_ops);
+EXPORT_SYMBOL_GPL(pv_mmu_ops);
+EXPORT_SYMBOL_GPL(pv_apic_ops);
+EXPORT_SYMBOL    (pv_irq_ops);
===================================================================
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -132,17 +132,17 @@ static unsigned vmi_patch(u8 type, u16 c
 static unsigned vmi_patch(u8 type, u16 clobbers, void *insns, unsigned len)
 {
 	switch (type) {
-		case PARAVIRT_PATCH(irq_disable):
+		case PARAVIRT_PATCH(pv_irq_ops.irq_disable):
 			return patch_internal(VMI_CALL_DisableInterrupts, len, insns);
-		case PARAVIRT_PATCH(irq_enable):
+		case PARAVIRT_PATCH(pv_irq_ops.irq_enable):
 			return patch_internal(VMI_CALL_EnableInterrupts, len, insns);
-		case PARAVIRT_PATCH(restore_fl):
+		case PARAVIRT_PATCH(pv_irq_ops.restore_fl):
 			return patch_internal(VMI_CALL_SetInterruptMask, len, insns);
-		case PARAVIRT_PATCH(save_fl):
+		case PARAVIRT_PATCH(pv_irq_ops.save_fl):
 			return patch_internal(VMI_CALL_GetInterruptMask, len, insns);
-		case PARAVIRT_PATCH(iret):
+		case PARAVIRT_PATCH(pv_cpu_ops.iret):
 			return patch_internal(VMI_CALL_IRET, len, insns);
-		case PARAVIRT_PATCH(irq_enable_sysexit):
+		case PARAVIRT_PATCH(pv_cpu_ops.irq_enable_sysexit):
 			return patch_internal(VMI_CALL_SYSEXIT, len, insns);
 		default:
 			break;
@@ -684,9 +684,9 @@ do {								\
 	reloc = call_vrom_long_func(vmi_rom, get_reloc,		\
 				    VMI_CALL_##vmicall);	\
 	if (rel->type == VMI_RELOCATION_CALL_REL) 		\
-		paravirt_ops.opname = (void *)rel->eip;		\
+		opname = (void *)rel->eip;			\
 	else if (rel->type == VMI_RELOCATION_NOP) 		\
-		paravirt_ops.opname = (void *)vmi_nop;		\
+		opname = (void *)vmi_nop;			\
 	else if (rel->type != VMI_RELOCATION_NONE)		\
 		printk(KERN_WARNING "VMI: Unknown relocation "	\
 				    "type %d for " #vmicall"\n",\
@@ -706,7 +706,7 @@ do {								\
 				    VMI_CALL_##vmicall);	\
 	BUG_ON(rel->type == VMI_RELOCATION_JUMP_REL);		\
 	if (rel->type == VMI_RELOCATION_CALL_REL) {		\
-		paravirt_ops.opname = wrapper;			\
+		opname = wrapper;				\
 		vmi_ops.cache = (void *)rel->eip;		\
 	}							\
 } while (0)
@@ -726,11 +726,11 @@ static inline int __init activate_vmi(vo
 	}
 	savesegment(cs, kernel_cs);
 
-	paravirt_ops.paravirt_enabled = 1;
-	paravirt_ops.kernel_rpl = kernel_cs & SEGMENT_RPL_MASK;
-
-	paravirt_ops.patch = vmi_patch;
-	paravirt_ops.name = "vmi";
+	pv_info.paravirt_enabled = 1;
+	pv_info.kernel_rpl = kernel_cs & SEGMENT_RPL_MASK;
+	pv_info.name = "vmi";
+
+	pv_init_ops.patch = vmi_patch;
 
 	/*
 	 * Many of these operations are ABI compatible with VMI.
@@ -748,26 +748,26 @@ static inline int __init activate_vmi(vo
 	 */
 
 	/* CPUID is special, so very special it gets wrapped like a present */
-	para_wrap(cpuid, vmi_cpuid, cpuid, CPUID);
-
-	para_fill(clts, CLTS);
-	para_fill(get_debugreg, GetDR);
-	para_fill(set_debugreg, SetDR);
-	para_fill(read_cr0, GetCR0);
-	para_fill(read_cr2, GetCR2);
-	para_fill(read_cr3, GetCR3);
-	para_fill(read_cr4, GetCR4);
-	para_fill(write_cr0, SetCR0);
-	para_fill(write_cr2, SetCR2);
-	para_fill(write_cr3, SetCR3);
-	para_fill(write_cr4, SetCR4);
-	para_fill(save_fl, GetInterruptMask);
-	para_fill(restore_fl, SetInterruptMask);
-	para_fill(irq_disable, DisableInterrupts);
-	para_fill(irq_enable, EnableInterrupts);
-
-	para_fill(wbinvd, WBINVD);
-	para_fill(read_tsc, RDTSC);
+	para_wrap(pv_cpu_ops.cpuid, vmi_cpuid, cpuid, CPUID);
+
+	para_fill(pv_cpu_ops.clts, CLTS);
+	para_fill(pv_cpu_ops.get_debugreg, GetDR);
+	para_fill(pv_cpu_ops.set_debugreg, SetDR);
+	para_fill(pv_cpu_ops.read_cr0, GetCR0);
+	para_fill(pv_mmu_ops.read_cr2, GetCR2);
+	para_fill(pv_mmu_ops.read_cr3, GetCR3);
+	para_fill(pv_cpu_ops.read_cr4, GetCR4);
+	para_fill(pv_cpu_ops.write_cr0, SetCR0);
+	para_fill(pv_mmu_ops.write_cr2, SetCR2);
+	para_fill(pv_mmu_ops.write_cr3, SetCR3);
+	para_fill(pv_cpu_ops.write_cr4, SetCR4);
+	para_fill(pv_irq_ops.save_fl, GetInterruptMask);
+	para_fill(pv_irq_ops.restore_fl, SetInterruptMask);
+	para_fill(pv_irq_ops.irq_disable, DisableInterrupts);
+	para_fill(pv_irq_ops.irq_enable, EnableInterrupts);
+
+	para_fill(pv_cpu_ops.wbinvd, WBINVD);
+	para_fill(pv_cpu_ops.read_tsc, RDTSC);
 
 	/* The following we emulate with trap and emulate for now */
 	/* paravirt_ops.read_msr = vmi_rdmsr */
@@ -775,29 +775,29 @@ static inline int __init activate_vmi(vo
 	/* paravirt_ops.rdpmc = vmi_rdpmc */
 
 	/* TR interface doesn't pass TR value, wrap */
-	para_wrap(load_tr_desc, vmi_set_tr, set_tr, SetTR);
+	para_wrap(pv_cpu_ops.load_tr_desc, vmi_set_tr, set_tr, SetTR);
 
 	/* LDT is special, too */
-	para_wrap(set_ldt, vmi_set_ldt, _set_ldt, SetLDT);
-
-	para_fill(load_gdt, SetGDT);
-	para_fill(load_idt, SetIDT);
-	para_fill(store_gdt, GetGDT);
-	para_fill(store_idt, GetIDT);
-	para_fill(store_tr, GetTR);
-	paravirt_ops.load_tls = vmi_load_tls;
-	para_fill(write_ldt_entry, WriteLDTEntry);
-	para_fill(write_gdt_entry, WriteGDTEntry);
-	para_fill(write_idt_entry, WriteIDTEntry);
-	para_wrap(load_esp0, vmi_load_esp0, set_kernel_stack, UpdateKernelStack);
-	para_fill(set_iopl_mask, SetIOPLMask);
-	para_fill(io_delay, IODelay);
-	para_wrap(set_lazy_mode, vmi_set_lazy_mode, set_lazy_mode, SetLazyMode);
+	para_wrap(pv_cpu_ops.set_ldt, vmi_set_ldt, _set_ldt, SetLDT);
+
+	para_fill(pv_cpu_ops.load_gdt, SetGDT);
+	para_fill(pv_cpu_ops.load_idt, SetIDT);
+	para_fill(pv_cpu_ops.store_gdt, GetGDT);
+	para_fill(pv_cpu_ops.store_idt, GetIDT);
+	para_fill(pv_cpu_ops.store_tr, GetTR);
+	pv_cpu_ops.load_tls = vmi_load_tls;
+	para_fill(pv_cpu_ops.write_ldt_entry, WriteLDTEntry);
+	para_fill(pv_cpu_ops.write_gdt_entry, WriteGDTEntry);
+	para_fill(pv_cpu_ops.write_idt_entry, WriteIDTEntry);
+	para_wrap(pv_cpu_ops.load_esp0, vmi_load_esp0, set_kernel_stack, UpdateKernelStack);
+	para_fill(pv_cpu_ops.set_iopl_mask, SetIOPLMask);
+	para_fill(pv_cpu_ops.io_delay, IODelay);
+	para_wrap(pv_misc_ops.set_lazy_mode, vmi_set_lazy_mode, set_lazy_mode, SetLazyMode);
 
 	/* user and kernel flush are just handled with different flags to FlushTLB */
-	para_wrap(flush_tlb_user, vmi_flush_tlb_user, _flush_tlb, FlushTLB);
-	para_wrap(flush_tlb_kernel, vmi_flush_tlb_kernel, _flush_tlb, FlushTLB);
-	para_fill(flush_tlb_single, InvalPage);
+	para_wrap(pv_mmu_ops.flush_tlb_user, vmi_flush_tlb_user, _flush_tlb, FlushTLB);
+	para_wrap(pv_mmu_ops.flush_tlb_kernel, vmi_flush_tlb_kernel, _flush_tlb, FlushTLB);
+	para_fill(pv_mmu_ops.flush_tlb_single, InvalPage);
 
 	/*
 	 * Until a standard flag format can be agreed on, we need to
@@ -813,41 +813,41 @@ static inline int __init activate_vmi(vo
 #endif
 
 	if (vmi_ops.set_pte) {
-		paravirt_ops.set_pte = vmi_set_pte;
-		paravirt_ops.set_pte_at = vmi_set_pte_at;
-		paravirt_ops.set_pmd = vmi_set_pmd;
+		pv_mmu_ops.set_pte = vmi_set_pte;
+		pv_mmu_ops.set_pte_at = vmi_set_pte_at;
+		pv_mmu_ops.set_pmd = vmi_set_pmd;
 #ifdef CONFIG_X86_PAE
-		paravirt_ops.set_pte_atomic = vmi_set_pte_atomic;
-		paravirt_ops.set_pte_present = vmi_set_pte_present;
-		paravirt_ops.set_pud = vmi_set_pud;
-		paravirt_ops.pte_clear = vmi_pte_clear;
-		paravirt_ops.pmd_clear = vmi_pmd_clear;
+		pv_mmu_ops.set_pte_atomic = vmi_set_pte_atomic;
+		pv_mmu_ops.set_pte_present = vmi_set_pte_present;
+		pv_mmu_ops.set_pud = vmi_set_pud;
+		pv_mmu_ops.pte_clear = vmi_pte_clear;
+		pv_mmu_ops.pmd_clear = vmi_pmd_clear;
 #endif
 	}
 
 	if (vmi_ops.update_pte) {
-		paravirt_ops.pte_update = vmi_update_pte;
-		paravirt_ops.pte_update_defer = vmi_update_pte_defer;
+		pv_mmu_ops.pte_update = vmi_update_pte;
+		pv_mmu_ops.pte_update_defer = vmi_update_pte_defer;
 	}
 
 	vmi_ops.allocate_page = vmi_get_function(VMI_CALL_AllocatePage);
 	if (vmi_ops.allocate_page) {
-		paravirt_ops.alloc_pt = vmi_allocate_pt;
-		paravirt_ops.alloc_pd = vmi_allocate_pd;
-		paravirt_ops.alloc_pd_clone = vmi_allocate_pd_clone;
+		pv_mmu_ops.alloc_pt = vmi_allocate_pt;
+		pv_mmu_ops.alloc_pd = vmi_allocate_pd;
+		pv_mmu_ops.alloc_pd_clone = vmi_allocate_pd_clone;
 	}
 
 	vmi_ops.release_page = vmi_get_function(VMI_CALL_ReleasePage);
 	if (vmi_ops.release_page) {
-		paravirt_ops.release_pt = vmi_release_pt;
-		paravirt_ops.release_pd = vmi_release_pd;
+		pv_mmu_ops.release_pt = vmi_release_pt;
+		pv_mmu_ops.release_pd = vmi_release_pd;
 	}
 
 	/* Set linear is needed in all cases */
 	vmi_ops.set_linear_mapping = vmi_get_function(VMI_CALL_SetLinearMapping);
 #ifdef CONFIG_HIGHPTE
 	if (vmi_ops.set_linear_mapping)
-		paravirt_ops.kmap_atomic_pte = vmi_kmap_atomic_pte;
+		pv_mmu_ops.kmap_atomic_pte = vmi_kmap_atomic_pte;
 #endif
 
 	/*
@@ -857,17 +857,17 @@ static inline int __init activate_vmi(vo
 	 * the backend.  They are performance critical anyway, so requiring
 	 * a patch is not a big problem.
 	 */
-	paravirt_ops.irq_enable_sysexit = (void *)0xfeedbab0;
-	paravirt_ops.iret = (void *)0xbadbab0;
+	pv_cpu_ops.irq_enable_sysexit = (void *)0xfeedbab0;
+	pv_cpu_ops.iret = (void *)0xbadbab0;
 
 #ifdef CONFIG_SMP
-	para_wrap(startup_ipi_hook, vmi_startup_ipi_hook, set_initial_ap_state, SetInitialAPState);
+	para_wrap(pv_apic_ops.startup_ipi_hook, vmi_startup_ipi_hook, set_initial_ap_state, SetInitialAPState);
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	para_fill(apic_read, APICRead);
-	para_fill(apic_write, APICWrite);
-	para_fill(apic_write_atomic, APICWrite);
+	para_fill(pv_apic_ops.apic_read, APICRead);
+	para_fill(pv_apic_ops.apic_write, APICWrite);
+	para_fill(pv_apic_ops.apic_write_atomic, APICWrite);
 #endif
 
 	/*
@@ -885,15 +885,15 @@ static inline int __init activate_vmi(vo
 		vmi_timer_ops.set_alarm = vmi_get_function(VMI_CALL_SetAlarm);
 		vmi_timer_ops.cancel_alarm =
 			 vmi_get_function(VMI_CALL_CancelAlarm);
-		paravirt_ops.time_init = vmi_time_init;
-		paravirt_ops.get_wallclock = vmi_get_wallclock;
-		paravirt_ops.set_wallclock = vmi_set_wallclock;
+		pv_init_ops.time_init = vmi_time_init;
+		pv_time_ops.get_wallclock = vmi_get_wallclock;
+		pv_time_ops.set_wallclock = vmi_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
-		paravirt_ops.setup_boot_clock = vmi_time_bsp_init;
-		paravirt_ops.setup_secondary_clock = vmi_time_ap_init;
-#endif
-		paravirt_ops.sched_clock = vmi_sched_clock;
- 		paravirt_ops.get_cpu_khz = vmi_cpu_khz;
+		pv_apic_ops.setup_boot_clock = vmi_time_bsp_init;
+		pv_apic_ops.setup_secondary_clock = vmi_time_ap_init;
+#endif
+		pv_time_ops.sched_clock = vmi_sched_clock;
+ 		pv_time_ops.get_cpu_khz = vmi_cpu_khz;
 
 		/* We have true wallclock functions; disable CMOS clock sync */
 		no_sync_cmos_clock = 1;
@@ -902,7 +902,7 @@ static inline int __init activate_vmi(vo
 		disable_vmi_timer = 1;
 	}
 
-	para_fill(safe_halt, Halt);
+	para_fill(pv_irq_ops.safe_halt, Halt);
 
 	/*
 	 * Alternative instruction rewriting doesn't happen soon enough
===================================================================
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -117,7 +117,7 @@ static void __init xen_banner(void)
 static void __init xen_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
-	       paravirt_ops.name);
+	       pv_info.name);
 	printk(KERN_INFO "Hypervisor signature: %s\n", xen_start_info->magic);
 }
 
@@ -746,7 +746,7 @@ static __init void xen_pagetable_setup_s
 	pgd_t *xen_pgd = (pgd_t *)xen_start_info->pt_base;
 
 	/* special set_pte for pagetable initialization */
-	paravirt_ops.set_pte = xen_set_pte_init;
+	pv_mmu_ops.set_pte = xen_set_pte_init;
 
 	init_mm.pgd = base;
 	/*
@@ -793,8 +793,8 @@ static __init void xen_pagetable_setup_d
 {
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
-	paravirt_ops.alloc_pt = xen_alloc_pt;
-	paravirt_ops.set_pte = xen_set_pte;
+	pv_mmu_ops.alloc_pt = xen_alloc_pt;
+	pv_mmu_ops.set_pte = xen_set_pte;
 
 	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
 		/*
@@ -842,12 +842,12 @@ void __init xen_setup_vcpu_info_placemen
 	if (have_vcpu_info_placement) {
 		printk(KERN_INFO "Xen: using vcpu_info placement\n");
 
-		paravirt_ops.save_fl = xen_save_fl_direct;
-		paravirt_ops.restore_fl = xen_restore_fl_direct;
-		paravirt_ops.irq_disable = xen_irq_disable_direct;
-		paravirt_ops.irq_enable = xen_irq_enable_direct;
-		paravirt_ops.read_cr2 = xen_read_cr2_direct;
-		paravirt_ops.iret = xen_iret_direct;
+		pv_irq_ops.save_fl = xen_save_fl_direct;
+		pv_irq_ops.restore_fl = xen_restore_fl_direct;
+		pv_irq_ops.irq_disable = xen_irq_disable_direct;
+		pv_irq_ops.irq_enable = xen_irq_enable_direct;
+		pv_mmu_ops.read_cr2 = xen_read_cr2_direct;
+		pv_cpu_ops.iret = xen_iret_direct;
 	}
 }
 
@@ -858,8 +858,8 @@ static unsigned xen_patch(u8 type, u16 c
 
 	start = end = reloc = NULL;
 
-#define SITE(x)								\
-	case PARAVIRT_PATCH(x):						\
+#define SITE(op, x)							\
+	case PARAVIRT_PATCH(op.x):						\
 	if (have_vcpu_info_placement) {					\
 		start = (char *)xen_##x##_direct;			\
 		end = xen_##x##_direct_end;				\
@@ -868,10 +868,10 @@ static unsigned xen_patch(u8 type, u16 c
 	goto patch_site
 
 	switch(type) {
-		SITE(irq_enable);
-		SITE(irq_disable);
-		SITE(save_fl);
-		SITE(restore_fl);
+		SITE(pv_irq_ops, irq_enable);
+		SITE(pv_irq_ops, irq_disable);
+		SITE(pv_irq_ops, save_fl);
+		SITE(pv_irq_ops, restore_fl);
 #undef SITE
 
 	patch_site:
@@ -902,26 +902,35 @@ static unsigned xen_patch(u8 type, u16 c
 	return ret;
 }
 
-static const struct paravirt_ops xen_paravirt_ops __initdata = {
+static const struct pv_info xen_info __initdata = {
 	.paravirt_enabled = 1,
 	.shared_kernel_pmd = 0,
 
 	.name = "Xen",
+};
+
+static const struct pv_init_ops xen_init_ops __initdata = {
+	.patch = xen_patch,
+
 	.banner = xen_banner,
-
-	.patch = xen_patch,
-
 	.memory_setup = xen_memory_setup,
 	.arch_setup = xen_arch_setup,
 	.init_IRQ = xen_init_IRQ,
 	.post_allocator_init = xen_mark_init_mm_pinned,
-
 	.time_init = xen_time_init,
+
+	.pagetable_setup_start = xen_pagetable_setup_start,
+	.pagetable_setup_done = xen_pagetable_setup_done,
+};
+
+static const struct pv_time_ops xen_time_ops __initdata = {
 	.set_wallclock = xen_set_wallclock,
 	.get_wallclock = xen_get_wallclock,
 	.get_cpu_khz = xen_cpu_khz,
 	.sched_clock = xen_sched_clock,
-
+};
+
+static const struct pv_cpu_ops xen_cpu_ops __initdata = {
 	.cpuid = xen_cpuid,
 
 	.set_debugreg = xen_set_debugreg,
@@ -931,51 +940,50 @@ static const struct paravirt_ops xen_par
 
 	.read_cr0 = native_read_cr0,
 	.write_cr0 = native_write_cr0,
-
-	.read_cr2 = xen_read_cr2,
-	.write_cr2 = xen_write_cr2,
-
-	.read_cr3 = xen_read_cr3,
-	.write_cr3 = xen_write_cr3,
 
 	.read_cr4 = native_read_cr4,
 	.read_cr4_safe = native_read_cr4_safe,
 	.write_cr4 = xen_write_cr4,
 
+	.wbinvd = native_wbinvd,
+
+	.read_msr = native_read_msr_safe,
+	.write_msr = native_write_msr_safe,
+	.read_tsc = native_read_tsc,
+	.read_pmc = native_read_pmc,
+
+	.iret = (void *)&hypercall_page[__HYPERVISOR_iret],
+	.irq_enable_sysexit = NULL,  /* never called */
+
+	.load_tr_desc = paravirt_nop,
+	.set_ldt = xen_set_ldt,
+	.load_gdt = xen_load_gdt,
+	.load_idt = xen_load_idt,
+	.load_tls = xen_load_tls,
+
+	.store_gdt = native_store_gdt,
+	.store_idt = native_store_idt,
+	.store_tr = xen_store_tr,
+
+	.write_ldt_entry = xen_write_ldt_entry,
+	.write_gdt_entry = xen_write_gdt_entry,
+	.write_idt_entry = xen_write_idt_entry,
+	.load_esp0 = xen_load_esp0,
+
+	.set_iopl_mask = xen_set_iopl_mask,
+	.io_delay = xen_io_delay,
+};
+
+static const struct pv_irq_ops xen_irq_ops __initdata = {
 	.save_fl = xen_save_fl,
 	.restore_fl = xen_restore_fl,
 	.irq_disable = xen_irq_disable,
 	.irq_enable = xen_irq_enable,
 	.safe_halt = xen_safe_halt,
 	.halt = xen_halt,
-	.wbinvd = native_wbinvd,
-
-	.read_msr = native_read_msr_safe,
-	.write_msr = native_write_msr_safe,
-	.read_tsc = native_read_tsc,
-	.read_pmc = native_read_pmc,
-
-	.iret = (void *)&hypercall_page[__HYPERVISOR_iret],
-	.irq_enable_sysexit = NULL,  /* never called */
-
-	.load_tr_desc = paravirt_nop,
-	.set_ldt = xen_set_ldt,
-	.load_gdt = xen_load_gdt,
-	.load_idt = xen_load_idt,
-	.load_tls = xen_load_tls,
-
-	.store_gdt = native_store_gdt,
-	.store_idt = native_store_idt,
-	.store_tr = xen_store_tr,
-
-	.write_ldt_entry = xen_write_ldt_entry,
-	.write_gdt_entry = xen_write_gdt_entry,
-	.write_idt_entry = xen_write_idt_entry,
-	.load_esp0 = xen_load_esp0,
-
-	.set_iopl_mask = xen_set_iopl_mask,
-	.io_delay = xen_io_delay,
-
+};
+
+static const struct pv_apic_ops xen_apic_ops __initdata = {
 #ifdef CONFIG_X86_LOCAL_APIC
 	.apic_write = xen_apic_write,
 	.apic_write_atomic = xen_apic_write,
@@ -984,6 +992,14 @@ static const struct paravirt_ops xen_par
 	.setup_secondary_clock = paravirt_nop,
 	.startup_ipi_hook = paravirt_nop,
 #endif
+};
+
+static const struct pv_mmu_ops xen_mmu_ops __initdata = {
+	.read_cr2 = xen_read_cr2,
+	.write_cr2 = xen_write_cr2,
+
+	.read_cr3 = xen_read_cr3,
+	.write_cr3 = xen_write_cr3,
 
 	.flush_tlb_user = xen_flush_tlb,
 	.flush_tlb_kernel = xen_flush_tlb,
@@ -992,9 +1008,6 @@ static const struct paravirt_ops xen_par
 
 	.pte_update = paravirt_nop,
 	.pte_update_defer = paravirt_nop,
-
-	.pagetable_setup_start = xen_pagetable_setup_start,
-	.pagetable_setup_done = xen_pagetable_setup_done,
 
 	.alloc_pt = xen_alloc_pt_init,
 	.release_pt = xen_release_pt,
@@ -1030,7 +1043,9 @@ static const struct paravirt_ops xen_par
 	.activate_mm = xen_activate_mm,
 	.dup_mmap = xen_dup_mmap,
 	.exit_mmap = xen_exit_mmap,
-
+};
+
+static const struct pv_misc_ops xen_misc_ops __initdata = {
 	.set_lazy_mode = xen_set_lazy_mode,
 };
 
@@ -1113,7 +1128,15 @@ void __init xen_start_kernel(void)
 	phys_to_machine_mapping = (unsigned long *)xen_start_info->mfn_list;
 
 	/* Install Xen paravirt ops */
-	paravirt_ops = xen_paravirt_ops;
+	pv_info = xen_info;
+	pv_init_ops = xen_init_ops;
+	pv_time_ops = xen_time_ops;
+	pv_cpu_ops = xen_cpu_ops;
+	pv_irq_ops = xen_irq_ops;
+	pv_apic_ops = xen_apic_ops;
+	pv_mmu_ops = xen_mmu_ops;
+	pv_misc_ops = xen_misc_ops;
+
 	machine_ops = xen_machine_ops;
 
 #ifdef CONFIG_SMP
@@ -1140,9 +1163,9 @@ void __init xen_start_kernel(void)
 	xen_setup_vcpu_info_placement();
 #endif
 
-	paravirt_ops.kernel_rpl = 1;
+	pv_info.kernel_rpl = 1;
 	if (xen_feature(XENFEAT_supervisor_mode_kernel))
-		paravirt_ops.kernel_rpl = 0;
+		pv_info.kernel_rpl = 0;
 
 	/* set the limit of our address space */
 	xen_reserve_top();
===================================================================
--- a/drivers/char/hvc_lguest.c
+++ b/drivers/char/hvc_lguest.c
@@ -66,7 +66,7 @@ static struct hv_ops lguest_cons = {
 
 static int __init cons_init(void)
 {
-	if (strcmp(paravirt_ops.name, "lguest") != 0)
+	if (strcmp(pv_info.name, "lguest") != 0)
 		return 0;
 
 	return hvc_instantiate(0, 0, &lguest_cons);
===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -14,7 +14,6 @@
 #include <asm/uaccess.h>
 #include <asm/poll.h>
 #include <asm/highmem.h>
-#include <asm/asm-offsets.h>
 #include <asm/i387.h>
 #include "lg.h"
 
@@ -413,7 +412,7 @@ static int __init init(void)
 	int err;
 
 	if (paravirt_enabled()) {
-		printk("lguest is afraid of %s\n", paravirt_ops.name);
+		printk("lguest is afraid of %s\n", pv_info.name);
 		return -EPERM;
 	}
 
===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -508,10 +508,10 @@ static const struct lguest_insns
 {
 	const char *start, *end;
 } lguest_insns[] = {
-	[PARAVIRT_PATCH(irq_disable)] = { lgstart_cli, lgend_cli },
-	[PARAVIRT_PATCH(irq_enable)] = { lgstart_sti, lgend_sti },
-	[PARAVIRT_PATCH(restore_fl)] = { lgstart_popf, lgend_popf },
-	[PARAVIRT_PATCH(save_fl)] = { lgstart_pushf, lgend_pushf },
+	[PARAVIRT_PATCH(pv_irq_ops.irq_disable)] = { lgstart_cli, lgend_cli },
+	[PARAVIRT_PATCH(pv_irq_ops.irq_enable)] = { lgstart_sti, lgend_sti },
+	[PARAVIRT_PATCH(pv_irq_ops.restore_fl)] = { lgstart_popf, lgend_popf },
+	[PARAVIRT_PATCH(pv_irq_ops.save_fl)] = { lgstart_pushf, lgend_pushf },
 };
 static unsigned lguest_patch(u8 type, u16 clobber, void *insns, unsigned len)
 {
@@ -538,53 +538,65 @@ __init void lguest_init(void *boot)
 	memcpy(boot_command_line, __va(boot_params.hdr.cmd_line_ptr),
 	       COMMAND_LINE_SIZE);
 
-	paravirt_ops.name = "lguest";
-	paravirt_ops.paravirt_enabled = 1;
-	paravirt_ops.kernel_rpl = 1;
-
-	paravirt_ops.save_fl = save_fl;
-	paravirt_ops.restore_fl = restore_fl;
-	paravirt_ops.irq_disable = irq_disable;
-	paravirt_ops.irq_enable = irq_enable;
-	paravirt_ops.load_gdt = lguest_load_gdt;
-	paravirt_ops.memory_setup = lguest_memory_setup;
-	paravirt_ops.cpuid = lguest_cpuid;
-	paravirt_ops.write_cr3 = lguest_write_cr3;
-	paravirt_ops.flush_tlb_user = lguest_flush_tlb_user;
-	paravirt_ops.flush_tlb_single = lguest_flush_tlb_single;
-	paravirt_ops.flush_tlb_kernel = lguest_flush_tlb_kernel;
-	paravirt_ops.set_pte = lguest_set_pte;
-	paravirt_ops.set_pte_at = lguest_set_pte_at;
-	paravirt_ops.set_pmd = lguest_set_pmd;
+	pv_info.name = "lguest";
+	pv_info.paravirt_enabled = 1;
+	pv_info.kernel_rpl = 1;
+
+	pv_irq_ops.save_fl = save_fl;
+	pv_irq_ops.restore_fl = restore_fl;
+	pv_irq_ops.irq_disable = irq_disable;
+	pv_irq_ops.irq_enable = irq_enable;
+
+	pv_cpu_ops.load_gdt = lguest_load_gdt;
+	pv_init_ops.memory_setup = lguest_memory_setup;
+	pv_cpu_ops.cpuid = lguest_cpuid;
+
+	pv_mmu_ops.write_cr3 = lguest_write_cr3;
+	pv_mmu_ops.flush_tlb_user = lguest_flush_tlb_user;
+	pv_mmu_ops.flush_tlb_single = lguest_flush_tlb_single;
+	pv_mmu_ops.flush_tlb_kernel = lguest_flush_tlb_kernel;
+	pv_mmu_ops.set_pte = lguest_set_pte;
+	pv_mmu_ops.set_pte_at = lguest_set_pte_at;
+	pv_mmu_ops.set_pmd = lguest_set_pmd;
+
 #ifdef CONFIG_X86_LOCAL_APIC
-	paravirt_ops.apic_write = lguest_apic_write;
-	paravirt_ops.apic_write_atomic = lguest_apic_write;
-	paravirt_ops.apic_read = lguest_apic_read;
+	pv_apic_ops.apic_write = lguest_apic_write;
+	pv_apic_ops.apic_write_atomic = lguest_apic_write;
+	pv_apic_ops.apic_read = lguest_apic_read;
 #endif
-	paravirt_ops.load_idt = lguest_load_idt;
-	paravirt_ops.iret = lguest_iret;
-	paravirt_ops.load_esp0 = lguest_load_esp0;
-	paravirt_ops.load_tr_desc = lguest_load_tr_desc;
-	paravirt_ops.set_ldt = lguest_set_ldt;
-	paravirt_ops.load_tls = lguest_load_tls;
-	paravirt_ops.set_debugreg = lguest_set_debugreg;
-	paravirt_ops.clts = lguest_clts;
-	paravirt_ops.read_cr0 = lguest_read_cr0;
-	paravirt_ops.write_cr0 = lguest_write_cr0;
-	paravirt_ops.init_IRQ = lguest_init_IRQ;
-	paravirt_ops.read_cr2 = lguest_read_cr2;
-	paravirt_ops.read_cr3 = lguest_read_cr3;
-	paravirt_ops.read_cr4 = lguest_read_cr4;
-	paravirt_ops.write_cr4 = lguest_write_cr4;
-	paravirt_ops.write_gdt_entry = lguest_write_gdt_entry;
-	paravirt_ops.write_idt_entry = lguest_write_idt_entry;
-	paravirt_ops.patch = lguest_patch;
-	paravirt_ops.safe_halt = lguest_safe_halt;
-	paravirt_ops.get_wallclock = lguest_get_wallclock;
-	paravirt_ops.time_init = lguest_time_init;
-	paravirt_ops.set_lazy_mode = lguest_lazy_mode;
-	paravirt_ops.wbinvd = lguest_wbinvd;
-	paravirt_ops.get_cpu_khz = lguest_get_cpu_khz;
+
+	pv_cpu_ops.load_idt = lguest_load_idt;
+	pv_cpu_ops.iret = lguest_iret;
+	pv_cpu_ops.load_esp0 = lguest_load_esp0;
+	pv_cpu_ops.load_tr_desc = lguest_load_tr_desc;
+	pv_cpu_ops.set_ldt = lguest_set_ldt;
+	pv_cpu_ops.load_tls = lguest_load_tls;
+	pv_cpu_ops.set_debugreg = lguest_set_debugreg;
+	pv_cpu_ops.clts = lguest_clts;
+	pv_cpu_ops.read_cr0 = lguest_read_cr0;
+	pv_cpu_ops.write_cr0 = lguest_write_cr0;
+
+	pv_init_ops.init_IRQ = lguest_init_IRQ;
+
+	pv_mmu_ops.read_cr2 = lguest_read_cr2;
+	pv_mmu_ops.read_cr3 = lguest_read_cr3;
+
+	pv_cpu_ops.read_cr4 = lguest_read_cr4;
+	pv_cpu_ops.write_cr4 = lguest_write_cr4;
+	pv_cpu_ops.write_gdt_entry = lguest_write_gdt_entry;
+	pv_cpu_ops.write_idt_entry = lguest_write_idt_entry;
+
+	pv_init_ops.patch = lguest_patch;
+
+	pv_irq_ops.safe_halt = lguest_safe_halt;
+
+	pv_time_ops.get_wallclock = lguest_get_wallclock;
+	pv_init_ops.time_init = lguest_time_init;
+
+	pv_misc_ops.set_lazy_mode = lguest_lazy_mode;
+
+	pv_cpu_ops.wbinvd = lguest_wbinvd;
+	pv_time_ops.get_cpu_khz = lguest_get_cpu_khz;
 
 	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
 
===================================================================
--- a/drivers/lguest/lguest_bus.c
+++ b/drivers/lguest/lguest_bus.c
@@ -132,7 +132,7 @@ static void scan_devices(void)
 
 static int __init lguest_bus_init(void)
 {
-	if (strcmp(paravirt_ops.name, "lguest") != 0)
+	if (strcmp(pv_info.name, "lguest") != 0)
 		return 0;
 
 	/* Devices are in page above top of "normal" mem. */
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -35,202 +35,231 @@ enum paravirt_lazy_mode {
 
 struct paravirt_ops
 {
-	unsigned int kernel_rpl;
-	int shared_kernel_pmd;
- 	int paravirt_enabled;
-	const char *name;
-
-	/*
-	 * Patch may replace one of the defined code sequences with arbitrary
-	 * code, subject to the same register constraints.  This generally
-	 * means the code is not free to clobber any registers other than EAX.
-	 * The patch function should return the number of bytes of code
-	 * generated, as we nop pad the rest in generic code.
-	 */
-	unsigned (*patch)(u8 type, u16 clobber, void *firstinsn, unsigned len);
-
-	/* Basic arch-specific setup */
-	void (*arch_setup)(void);
-	char *(*memory_setup)(void);
-	void (*post_allocator_init)(void);
-
-	void (*init_IRQ)(void);
-	void (*time_init)(void);
-
-	/*
-	 * Called before/after init_mm pagetable setup. setup_start
-	 * may reset %cr3, and may pre-install parts of the pagetable;
-	 * pagetable setup is expected to preserve any existing
-	 * mapping.
-	 */
-	void (*pagetable_setup_start)(pgd_t *pgd_base);
-	void (*pagetable_setup_done)(pgd_t *pgd_base);
-
-	/* Print a banner to identify the environment */
-	void (*banner)(void);
-
-	/* Set and set time of day */
-	unsigned long (*get_wallclock)(void);
-	int (*set_wallclock)(unsigned long);
-
-	/* cpuid emulation, mostly so that caps bits can be disabled */
-	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
-		      unsigned int *ecx, unsigned int *edx);
-
-	/* hooks for various privileged instructions */
-	unsigned long (*get_debugreg)(int regno);
-	void (*set_debugreg)(int regno, unsigned long value);
-
-	void (*clts)(void);
-
-	unsigned long (*read_cr0)(void);
-	void (*write_cr0)(unsigned long);
-
-	unsigned long (*read_cr2)(void);
-	void (*write_cr2)(unsigned long);
-
-	unsigned long (*read_cr3)(void);
-	void (*write_cr3)(unsigned long);
-
-	unsigned long (*read_cr4_safe)(void);
-	unsigned long (*read_cr4)(void);
-	void (*write_cr4)(unsigned long);
-
-	/*
-	 * Get/set interrupt state.  save_fl and restore_fl are only
-	 * expected to use X86_EFLAGS_IF; all other bits
-	 * returned from save_fl are undefined, and may be ignored by
-	 * restore_fl.
-	 */
-	unsigned long (*save_fl)(void);
-	void (*restore_fl)(unsigned long);
-	void (*irq_disable)(void);
-	void (*irq_enable)(void);
-	void (*safe_halt)(void);
-	void (*halt)(void);
-
-	void (*wbinvd)(void);
-
-	/* MSR, PMC and TSR operations.
-	   err = 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
-	u64 (*read_msr)(unsigned int msr, int *err);
-	int (*write_msr)(unsigned int msr, u64 val);
-
-	u64 (*read_tsc)(void);
-	u64 (*read_pmc)(void);
- 	unsigned long long (*sched_clock)(void);
-	unsigned long (*get_cpu_khz)(void);
-
-	/* Segment descriptor handling */
-	void (*load_tr_desc)(void);
-	void (*load_gdt)(const struct Xgt_desc_struct *);
-	void (*load_idt)(const struct Xgt_desc_struct *);
-	void (*store_gdt)(struct Xgt_desc_struct *);
-	void (*store_idt)(struct Xgt_desc_struct *);
-	void (*set_ldt)(const void *desc, unsigned entries);
-	unsigned long (*store_tr)(void);
-	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
-	void (*write_ldt_entry)(struct desc_struct *,
-				int entrynum, u32 low, u32 high);
-	void (*write_gdt_entry)(struct desc_struct *,
-				int entrynum, u32 low, u32 high);
-	void (*write_idt_entry)(struct desc_struct *,
-				int entrynum, u32 low, u32 high);
-	void (*load_esp0)(struct tss_struct *tss, struct thread_struct *t);
-
-	void (*set_iopl_mask)(unsigned mask);
-	void (*io_delay)(void);
-
-	/*
-	 * Hooks for intercepting the creation/use/destruction of an
-	 * mm_struct.
-	 */
-	void (*activate_mm)(struct mm_struct *prev,
-			    struct mm_struct *next);
-	void (*dup_mmap)(struct mm_struct *oldmm,
-			 struct mm_struct *mm);
-	void (*exit_mmap)(struct mm_struct *mm);
-
+	/* general info */
+	struct pv_info {
+		unsigned int kernel_rpl;
+		int shared_kernel_pmd;
+		int paravirt_enabled;
+		const char *name;
+	} pv_info;
+
+	struct pv_init_ops {
+		/*
+		 * Patch may replace one of the defined code sequences with arbitrary
+		 * code, subject to the same register constraints.  This generally
+		 * means the code is not free to clobber any registers other than EAX.
+		 * The patch function should return the number of bytes of code
+		 * generated, as we nop pad the rest in generic code.
+		 */
+		unsigned (*patch)(u8 type, u16 clobber, void *firstinsn, unsigned len);
+
+		/* Basic arch-specific setup */
+		void (*arch_setup)(void);
+		char *(*memory_setup)(void);
+		void (*post_allocator_init)(void);
+
+		void (*init_IRQ)(void);
+		void (*time_init)(void);
+
+		/*
+		 * Called before/after init_mm pagetable setup. setup_start
+		 * may reset %cr3, and may pre-install parts of the pagetable;
+		 * pagetable setup is expected to preserve any existing
+		 * mapping.
+		 */
+		void (*pagetable_setup_start)(pgd_t *pgd_base);
+		void (*pagetable_setup_done)(pgd_t *pgd_base);
+
+		/* Print a banner to identify the environment */
+		void (*banner)(void);
+	} pv_init_ops;
+
+
+	struct pv_misc_ops {
+		/* Set deferred update mode, used for batching operations. */
+		void (*set_lazy_mode)(enum paravirt_lazy_mode mode);
+	} pv_misc_ops;
+
+	struct pv_time_ops {
+		/* Set and set time of day */
+		unsigned long (*get_wallclock)(void);
+		int (*set_wallclock)(unsigned long);
+
+		unsigned long long (*sched_clock)(void);
+		unsigned long (*get_cpu_khz)(void);
+	} pv_time_ops;
+
+	struct pv_cpu_ops {
+		/* hooks for various privileged instructions */
+		unsigned long (*get_debugreg)(int regno);
+		void (*set_debugreg)(int regno, unsigned long value);
+
+		void (*clts)(void);
+
+		unsigned long (*read_cr0)(void);
+		void (*write_cr0)(unsigned long);
+
+		unsigned long (*read_cr4_safe)(void);
+		unsigned long (*read_cr4)(void);
+		void (*write_cr4)(unsigned long);
+
+		/* Segment descriptor handling */
+		void (*load_tr_desc)(void);
+		void (*load_gdt)(const struct Xgt_desc_struct *);
+		void (*load_idt)(const struct Xgt_desc_struct *);
+		void (*store_gdt)(struct Xgt_desc_struct *);
+		void (*store_idt)(struct Xgt_desc_struct *);
+		void (*set_ldt)(const void *desc, unsigned entries);
+		unsigned long (*store_tr)(void);
+		void (*load_tls)(struct thread_struct *t, unsigned int cpu);
+		void (*write_ldt_entry)(struct desc_struct *,
+					int entrynum, u32 low, u32 high);
+		void (*write_gdt_entry)(struct desc_struct *,
+					int entrynum, u32 low, u32 high);
+		void (*write_idt_entry)(struct desc_struct *,
+					int entrynum, u32 low, u32 high);
+		void (*load_esp0)(struct tss_struct *tss, struct thread_struct *t);
+
+		void (*set_iopl_mask)(unsigned mask);
+
+		void (*wbinvd)(void);
+		void (*io_delay)(void);
+
+		/* cpuid emulation, mostly so that caps bits can be disabled */
+		void (*cpuid)(unsigned int *eax, unsigned int *ebx,
+			      unsigned int *ecx, unsigned int *edx);
+
+		/* MSR, PMC and TSR operations.
+		   err = 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
+		u64 (*read_msr)(unsigned int msr, int *err);
+		int (*write_msr)(unsigned int msr, u64 val);
+
+		u64 (*read_tsc)(void);
+		u64 (*read_pmc)(void);
+
+		/* These two are jmp to, not actually called. */
+		void (*irq_enable_sysexit)(void);
+		void (*iret)(void);
+	} pv_cpu_ops;
+
+	struct pv_irq_ops {
+		/*
+		 * Get/set interrupt state.  save_fl and restore_fl are only
+		 * expected to use X86_EFLAGS_IF; all other bits
+		 * returned from save_fl are undefined, and may be ignored by
+		 * restore_fl.
+		 */
+		unsigned long (*save_fl)(void);
+		void (*restore_fl)(unsigned long);
+		void (*irq_disable)(void);
+		void (*irq_enable)(void);
+		void (*safe_halt)(void);
+		void (*halt)(void);
+	} pv_irq_ops;
+
+	struct pv_apic_ops {
 #ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * Direct APIC operations, principally for VMI.  Ideally
-	 * these shouldn't be in this interface.
-	 */
-	void (*apic_write)(unsigned long reg, unsigned long v);
-	void (*apic_write_atomic)(unsigned long reg, unsigned long v);
-	unsigned long (*apic_read)(unsigned long reg);
-	void (*setup_boot_clock)(void);
-	void (*setup_secondary_clock)(void);
-
-	void (*startup_ipi_hook)(int phys_apicid,
-				 unsigned long start_eip,
-				 unsigned long start_esp);
+		/*
+		 * Direct APIC operations, principally for VMI.  Ideally
+		 * these shouldn't be in this interface.
+		 */
+		void (*apic_write)(unsigned long reg, unsigned long v);
+		void (*apic_write_atomic)(unsigned long reg, unsigned long v);
+		unsigned long (*apic_read)(unsigned long reg);
+		void (*setup_boot_clock)(void);
+		void (*setup_secondary_clock)(void);
+
+		void (*startup_ipi_hook)(int phys_apicid,
+					 unsigned long start_eip,
+					 unsigned long start_esp);
 #endif
-
-	/* TLB operations */
-	void (*flush_tlb_user)(void);
-	void (*flush_tlb_kernel)(void);
-	void (*flush_tlb_single)(unsigned long addr);
-	void (*flush_tlb_others)(const cpumask_t *cpus, struct mm_struct *mm,
-				 unsigned long va);
-
-	/* Hooks for allocating/releasing pagetable pages */
-	void (*alloc_pt)(struct mm_struct *mm, u32 pfn);
-	void (*alloc_pd)(u32 pfn);
-	void (*alloc_pd_clone)(u32 pfn, u32 clonepfn, u32 start, u32 count);
-	void (*release_pt)(u32 pfn);
-	void (*release_pd)(u32 pfn);
-
-	/* Pagetable manipulation functions */
-	void (*set_pte)(pte_t *ptep, pte_t pteval);
-	void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, pte_t pteval);
-	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
-	void (*pte_update)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-	void (*pte_update_defer)(struct mm_struct *mm,
-				 unsigned long addr, pte_t *ptep);
+	} pv_apic_ops;
+
+	struct pv_mmu_ops {
+		unsigned long (*read_cr2)(void);
+		void (*write_cr2)(unsigned long);
+
+		unsigned long (*read_cr3)(void);
+		void (*write_cr3)(unsigned long);
+
+		/*
+		 * Hooks for intercepting the creation/use/destruction of an
+		 * mm_struct.
+		 */
+		void (*activate_mm)(struct mm_struct *prev,
+				    struct mm_struct *next);
+		void (*dup_mmap)(struct mm_struct *oldmm,
+				 struct mm_struct *mm);
+		void (*exit_mmap)(struct mm_struct *mm);
+
+
+		/* TLB operations */
+		void (*flush_tlb_user)(void);
+		void (*flush_tlb_kernel)(void);
+		void (*flush_tlb_single)(unsigned long addr);
+		void (*flush_tlb_others)(const cpumask_t *cpus, struct mm_struct *mm,
+					 unsigned long va);
+
+		/* Hooks for allocating/releasing pagetable pages */
+		void (*alloc_pt)(struct mm_struct *mm, u32 pfn);
+		void (*alloc_pd)(u32 pfn);
+		void (*alloc_pd_clone)(u32 pfn, u32 clonepfn, u32 start, u32 count);
+		void (*release_pt)(u32 pfn);
+		void (*release_pd)(u32 pfn);
+
+		/* Pagetable manipulation functions */
+		void (*set_pte)(pte_t *ptep, pte_t pteval);
+		void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pteval);
+		void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
+		void (*pte_update)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+		void (*pte_update_defer)(struct mm_struct *mm,
+					 unsigned long addr, pte_t *ptep);
+
+#ifdef CONFIG_X86_PAE
+		void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
+		void (*set_pte_present)(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
+		void (*set_pud)(pud_t *pudp, pud_t pudval);
+		void (*pte_clear)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+		void (*pmd_clear)(pmd_t *pmdp);
+
+		unsigned long long (*pte_val)(pte_t);
+		unsigned long long (*pmd_val)(pmd_t);
+		unsigned long long (*pgd_val)(pgd_t);
+
+		pte_t (*make_pte)(unsigned long long pte);
+		pmd_t (*make_pmd)(unsigned long long pmd);
+		pgd_t (*make_pgd)(unsigned long long pgd);
+#else
+		unsigned long (*pte_val)(pte_t);
+		unsigned long (*pgd_val)(pgd_t);
+
+		pte_t (*make_pte)(unsigned long pte);
+		pgd_t (*make_pgd)(unsigned long pgd);
+#endif
 
 #ifdef CONFIG_HIGHPTE
-	void *(*kmap_atomic_pte)(struct page *page, enum km_type type);
+		void *(*kmap_atomic_pte)(struct page *page, enum km_type type);
 #endif
-
-#ifdef CONFIG_X86_PAE
-	void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
- 	void (*set_pte_present)(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
-	void (*set_pud)(pud_t *pudp, pud_t pudval);
- 	void (*pte_clear)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-	void (*pmd_clear)(pmd_t *pmdp);
-
-	unsigned long long (*pte_val)(pte_t);
-	unsigned long long (*pmd_val)(pmd_t);
-	unsigned long long (*pgd_val)(pgd_t);
-
-	pte_t (*make_pte)(unsigned long long pte);
-	pmd_t (*make_pmd)(unsigned long long pmd);
-	pgd_t (*make_pgd)(unsigned long long pgd);
-#else
-	unsigned long (*pte_val)(pte_t);
-	unsigned long (*pgd_val)(pgd_t);
-
-	pte_t (*make_pte)(unsigned long pte);
-	pgd_t (*make_pgd)(unsigned long pgd);
-#endif
-
-	/* Set deferred update mode, used for batching operations. */
-	void (*set_lazy_mode)(enum paravirt_lazy_mode mode);
-
-	/* These two are jmp to, not actually called. */
-	void (*irq_enable_sysexit)(void);
-	void (*iret)(void);
+	} pv_mmu_ops;
 };
 
-extern struct paravirt_ops paravirt_ops;
+extern struct pv_info pv_info;
+extern struct pv_init_ops pv_init_ops;
+extern struct pv_misc_ops pv_misc_ops;
+extern struct pv_time_ops pv_time_ops;
+extern struct pv_cpu_ops pv_cpu_ops;
+extern struct pv_irq_ops pv_irq_ops;
+extern struct pv_apic_ops pv_apic_ops;
+extern struct pv_mmu_ops pv_mmu_ops;
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_ops, x) / sizeof(void *))
 
-#define paravirt_type(type)					\
-	[paravirt_typenum] "i" (PARAVIRT_PATCH(type))
+#define paravirt_type(op)				\
+	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
+	[paravirt_opptr] "m" (op)
+
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -270,7 +299,7 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_ops structure, and can therefore be freely
  * converted back into a structure offset.
  */
-#define PARAVIRT_CALL	"call *(paravirt_ops+%c[paravirt_typenum]*4);"
+#define PARAVIRT_CALL	"call *%[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls into a paravirt_ops
@@ -405,36 +434,36 @@ int paravirt_disable_iospace(void);
 
 static inline int paravirt_enabled(void)
 {
-	return paravirt_ops.paravirt_enabled;
+	return pv_info.paravirt_enabled;
 }
 
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
-	PVOP_VCALL2(load_esp0, tss, thread);
-}
-
-#define ARCH_SETUP			paravirt_ops.arch_setup();
+	PVOP_VCALL2(pv_cpu_ops.load_esp0, tss, thread);
+}
+
+#define ARCH_SETUP			pv_init_ops.arch_setup();
 static inline unsigned long get_wallclock(void)
 {
-	return PVOP_CALL0(unsigned long, get_wallclock);
+	return PVOP_CALL0(unsigned long, pv_time_ops.get_wallclock);
 }
 
 static inline int set_wallclock(unsigned long nowtime)
 {
-	return PVOP_CALL1(int, set_wallclock, nowtime);
+	return PVOP_CALL1(int, pv_time_ops.set_wallclock, nowtime);
 }
 
 static inline void (*choose_time_init(void))(void)
 {
-	return paravirt_ops.time_init;
+	return pv_init_ops.time_init;
 }
 
 /* The paravirtualized CPUID instruction. */
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
-	PVOP_VCALL4(cpuid, eax, ebx, ecx, edx);
+	PVOP_VCALL4(pv_cpu_ops.cpuid, eax, ebx, ecx, edx);
 }
 
 /*
@@ -442,87 +471,87 @@ static inline void __cpuid(unsigned int 
  */
 static inline unsigned long paravirt_get_debugreg(int reg)
 {
-	return PVOP_CALL1(unsigned long, get_debugreg, reg);
+	return PVOP_CALL1(unsigned long, pv_cpu_ops.get_debugreg, reg);
 }
 #define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
 static inline void set_debugreg(unsigned long val, int reg)
 {
-	PVOP_VCALL2(set_debugreg, reg, val);
+	PVOP_VCALL2(pv_cpu_ops.set_debugreg, reg, val);
 }
 
 static inline void clts(void)
 {
-	PVOP_VCALL0(clts);
+	PVOP_VCALL0(pv_cpu_ops.clts);
 }
 
 static inline unsigned long read_cr0(void)
 {
-	return PVOP_CALL0(unsigned long, read_cr0);
+	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr0);
 }
 
 static inline void write_cr0(unsigned long x)
 {
-	PVOP_VCALL1(write_cr0, x);
+	PVOP_VCALL1(pv_cpu_ops.write_cr0, x);
 }
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, read_cr2);
+	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
 {
-	PVOP_VCALL1(write_cr2, x);
+	PVOP_VCALL1(pv_mmu_ops.write_cr2, x);
 }
 
 static inline unsigned long read_cr3(void)
 {
-	return PVOP_CALL0(unsigned long, read_cr3);
+	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr3);
 }
 
 static inline void write_cr3(unsigned long x)
 {
-	PVOP_VCALL1(write_cr3, x);
+	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
 }
 
 static inline unsigned long read_cr4(void)
 {
-	return PVOP_CALL0(unsigned long, read_cr4);
+	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr4);
 }
 static inline unsigned long read_cr4_safe(void)
 {
-	return PVOP_CALL0(unsigned long, read_cr4_safe);
+	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr4_safe);
 }
 
 static inline void write_cr4(unsigned long x)
 {
-	PVOP_VCALL1(write_cr4, x);
+	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
 }
 
 static inline void raw_safe_halt(void)
 {
-	PVOP_VCALL0(safe_halt);
+	PVOP_VCALL0(pv_irq_ops.safe_halt);
 }
 
 static inline void halt(void)
 {
-	PVOP_VCALL0(safe_halt);
+	PVOP_VCALL0(pv_irq_ops.safe_halt);
 }
 
 static inline void wbinvd(void)
 {
-	PVOP_VCALL0(wbinvd);
-}
-
-#define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
+	PVOP_VCALL0(pv_cpu_ops.wbinvd);
+}
+
+#define get_kernel_rpl()  (pv_info.kernel_rpl)
 
 static inline u64 paravirt_read_msr(unsigned msr, int *err)
 {
-	return PVOP_CALL2(u64, read_msr, msr, err);
+	return PVOP_CALL2(u64, pv_cpu_ops.read_msr, msr, err);
 }
 static inline int paravirt_write_msr(unsigned msr, unsigned low, unsigned high)
 {
-	return PVOP_CALL3(int, write_msr, msr, low, high);
+	return PVOP_CALL3(int, pv_cpu_ops.write_msr, msr, low, high);
 }
 
 /* These should all do BUG_ON(_err), but our headers are too tangled. */
@@ -556,7 +585,7 @@ static inline int paravirt_write_msr(uns
 
 static inline u64 paravirt_read_tsc(void)
 {
-	return PVOP_CALL0(u64, read_tsc);
+	return PVOP_CALL0(u64, pv_cpu_ops.read_tsc);
 }
 
 #define rdtscl(low) do {			\
@@ -568,15 +597,15 @@ static inline u64 paravirt_read_tsc(void
 
 static inline unsigned long long paravirt_sched_clock(void)
 {
-	return PVOP_CALL0(unsigned long long, sched_clock);
-}
-#define calculate_cpu_khz() (paravirt_ops.get_cpu_khz())
+	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
+}
+#define calculate_cpu_khz() (pv_time_ops.get_cpu_khz())
 
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 static inline unsigned long long paravirt_read_pmc(int counter)
 {
-	return PVOP_CALL1(u64, read_pmc, counter);
+	return PVOP_CALL1(u64, pv_cpu_ops.read_pmc, counter);
 }
 
 #define rdpmc(counter,low,high) do {		\
@@ -587,61 +616,61 @@ static inline unsigned long long paravir
 
 static inline void load_TR_desc(void)
 {
-	PVOP_VCALL0(load_tr_desc);
+	PVOP_VCALL0(pv_cpu_ops.load_tr_desc);
 }
 static inline void load_gdt(const struct Xgt_desc_struct *dtr)
 {
-	PVOP_VCALL1(load_gdt, dtr);
+	PVOP_VCALL1(pv_cpu_ops.load_gdt, dtr);
 }
 static inline void load_idt(const struct Xgt_desc_struct *dtr)
 {
-	PVOP_VCALL1(load_idt, dtr);
+	PVOP_VCALL1(pv_cpu_ops.load_idt, dtr);
 }
 static inline void set_ldt(const void *addr, unsigned entries)
 {
-	PVOP_VCALL2(set_ldt, addr, entries);
+	PVOP_VCALL2(pv_cpu_ops.set_ldt, addr, entries);
 }
 static inline void store_gdt(struct Xgt_desc_struct *dtr)
 {
-	PVOP_VCALL1(store_gdt, dtr);
+	PVOP_VCALL1(pv_cpu_ops.store_gdt, dtr);
 }
 static inline void store_idt(struct Xgt_desc_struct *dtr)
 {
-	PVOP_VCALL1(store_idt, dtr);
+	PVOP_VCALL1(pv_cpu_ops.store_idt, dtr);
 }
 static inline unsigned long paravirt_store_tr(void)
 {
-	return PVOP_CALL0(unsigned long, store_tr);
+	return PVOP_CALL0(unsigned long, pv_cpu_ops.store_tr);
 }
 #define store_tr(tr)	((tr) = paravirt_store_tr())
 static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 {
-	PVOP_VCALL2(load_tls, t, cpu);
+	PVOP_VCALL2(pv_cpu_ops.load_tls, t, cpu);
 }
 static inline void write_ldt_entry(void *dt, int entry, u32 low, u32 high)
 {
-	PVOP_VCALL4(write_ldt_entry, dt, entry, low, high);
+	PVOP_VCALL4(pv_cpu_ops.write_ldt_entry, dt, entry, low, high);
 }
 static inline void write_gdt_entry(void *dt, int entry, u32 low, u32 high)
 {
-	PVOP_VCALL4(write_gdt_entry, dt, entry, low, high);
+	PVOP_VCALL4(pv_cpu_ops.write_gdt_entry, dt, entry, low, high);
 }
 static inline void write_idt_entry(void *dt, int entry, u32 low, u32 high)
 {
-	PVOP_VCALL4(write_idt_entry, dt, entry, low, high);
+	PVOP_VCALL4(pv_cpu_ops.write_idt_entry, dt, entry, low, high);
 }
 static inline void set_iopl_mask(unsigned mask)
 {
-	PVOP_VCALL1(set_iopl_mask, mask);
+	PVOP_VCALL1(pv_cpu_ops.set_iopl_mask, mask);
 }
 
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void) {
-	paravirt_ops.io_delay();
+	pv_cpu_ops.io_delay();
 #ifdef REALLY_SLOW_IO
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
+	pv_cpu_ops.io_delay();
+	pv_cpu_ops.io_delay();
+	pv_cpu_ops.io_delay();
 #endif
 }
 
@@ -651,121 +680,121 @@ static inline void slow_down_io(void) {
  */
 static inline void apic_write(unsigned long reg, unsigned long v)
 {
-	PVOP_VCALL2(apic_write, reg, v);
+	PVOP_VCALL2(pv_apic_ops.apic_write, reg, v);
 }
 
 static inline void apic_write_atomic(unsigned long reg, unsigned long v)
 {
-	PVOP_VCALL2(apic_write_atomic, reg, v);
+	PVOP_VCALL2(pv_apic_ops.apic_write_atomic, reg, v);
 }
 
 static inline unsigned long apic_read(unsigned long reg)
 {
-	return PVOP_CALL1(unsigned long, apic_read, reg);
+	return PVOP_CALL1(unsigned long, pv_apic_ops.apic_read, reg);
 }
 
 static inline void setup_boot_clock(void)
 {
-	PVOP_VCALL0(setup_boot_clock);
+	PVOP_VCALL0(pv_apic_ops.setup_boot_clock);
 }
 
 static inline void setup_secondary_clock(void)
 {
-	PVOP_VCALL0(setup_secondary_clock);
+	PVOP_VCALL0(pv_apic_ops.setup_secondary_clock);
 }
 #endif
 
 static inline void paravirt_post_allocator_init(void)
 {
-	if (paravirt_ops.post_allocator_init)
-		(*paravirt_ops.post_allocator_init)();
+	if (pv_init_ops.post_allocator_init)
+		(*pv_init_ops.post_allocator_init)();
 }
 
 static inline void paravirt_pagetable_setup_start(pgd_t *base)
 {
-	if (paravirt_ops.pagetable_setup_start)
-		(*paravirt_ops.pagetable_setup_start)(base);
+	if (pv_init_ops.pagetable_setup_start)
+		(*pv_init_ops.pagetable_setup_start)(base);
 }
 
 static inline void paravirt_pagetable_setup_done(pgd_t *base)
 {
-	if (paravirt_ops.pagetable_setup_done)
-		(*paravirt_ops.pagetable_setup_done)(base);
+	if (pv_init_ops.pagetable_setup_done)
+		(*pv_init_ops.pagetable_setup_done)(base);
 }
 
 #ifdef CONFIG_SMP
 static inline void startup_ipi_hook(int phys_apicid, unsigned long start_eip,
 				    unsigned long start_esp)
 {
-	PVOP_VCALL3(startup_ipi_hook, phys_apicid, start_eip, start_esp);
+	PVOP_VCALL3(pv_apic_ops.startup_ipi_hook, phys_apicid, start_eip, start_esp);
 }
 #endif
 
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
-	PVOP_VCALL2(activate_mm, prev, next);
+	PVOP_VCALL2(pv_mmu_ops.activate_mm, prev, next);
 }
 
 static inline void arch_dup_mmap(struct mm_struct *oldmm,
 				 struct mm_struct *mm)
 {
-	PVOP_VCALL2(dup_mmap, oldmm, mm);
+	PVOP_VCALL2(pv_mmu_ops.dup_mmap, oldmm, mm);
 }
 
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
-	PVOP_VCALL1(exit_mmap, mm);
+	PVOP_VCALL1(pv_mmu_ops.exit_mmap, mm);
 }
 
 static inline void __flush_tlb(void)
 {
-	PVOP_VCALL0(flush_tlb_user);
+	PVOP_VCALL0(pv_mmu_ops.flush_tlb_user);
 }
 static inline void __flush_tlb_global(void)
 {
-	PVOP_VCALL0(flush_tlb_kernel);
+	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
 }
 static inline void __flush_tlb_single(unsigned long addr)
 {
-	PVOP_VCALL1(flush_tlb_single, addr);
+	PVOP_VCALL1(pv_mmu_ops.flush_tlb_single, addr);
 }
 
 static inline void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 				    unsigned long va)
 {
-	PVOP_VCALL3(flush_tlb_others, &cpumask, mm, va);
+	PVOP_VCALL3(pv_mmu_ops.flush_tlb_others, &cpumask, mm, va);
 }
 
 static inline void paravirt_alloc_pt(struct mm_struct *mm, unsigned pfn)
 {
-	PVOP_VCALL2(alloc_pt, mm, pfn);
+	PVOP_VCALL2(pv_mmu_ops.alloc_pt, mm, pfn);
 }
 static inline void paravirt_release_pt(unsigned pfn)
 {
-	PVOP_VCALL1(release_pt, pfn);
+	PVOP_VCALL1(pv_mmu_ops.release_pt, pfn);
 }
 
 static inline void paravirt_alloc_pd(unsigned pfn)
 {
-	PVOP_VCALL1(alloc_pd, pfn);
+	PVOP_VCALL1(pv_mmu_ops.alloc_pd, pfn);
 }
 
 static inline void paravirt_alloc_pd_clone(unsigned pfn, unsigned clonepfn,
 					   unsigned start, unsigned count)
 {
-	PVOP_VCALL4(alloc_pd_clone, pfn, clonepfn, start, count);
+	PVOP_VCALL4(pv_mmu_ops.alloc_pd_clone, pfn, clonepfn, start, count);
 }
 static inline void paravirt_release_pd(unsigned pfn)
 {
-	PVOP_VCALL1(release_pd, pfn);
+	PVOP_VCALL1(pv_mmu_ops.release_pd, pfn);
 }
 
 #ifdef CONFIG_HIGHPTE
 static inline void *kmap_atomic_pte(struct page *page, enum km_type type)
 {
 	unsigned long ret;
-	ret = PVOP_CALL2(unsigned long, kmap_atomic_pte, page, type);
+	ret = PVOP_CALL2(unsigned long, pv_mmu_ops.kmap_atomic_pte, page, type);
 	return (void *)ret;
 }
 #endif
@@ -773,162 +802,167 @@ static inline void pte_update(struct mm_
 static inline void pte_update(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
-	PVOP_VCALL3(pte_update, mm, addr, ptep);
+	PVOP_VCALL3(pv_mmu_ops.pte_update, mm, addr, ptep);
 }
 
 static inline void pte_update_defer(struct mm_struct *mm, unsigned long addr,
 				    pte_t *ptep)
 {
-	PVOP_VCALL3(pte_update_defer, mm, addr, ptep);
+	PVOP_VCALL3(pv_mmu_ops.pte_update_defer, mm, addr, ptep);
 }
 
 #ifdef CONFIG_X86_PAE
 static inline pte_t __pte(unsigned long long val)
 {
-	unsigned long long ret = PVOP_CALL2(unsigned long long, make_pte,
+	unsigned long long ret = PVOP_CALL2(unsigned long long, pv_mmu_ops.make_pte,
 					    val, val >> 32);
 	return (pte_t) { ret, ret >> 32 };
 }
 
 static inline pmd_t __pmd(unsigned long long val)
 {
-	return (pmd_t) { PVOP_CALL2(unsigned long long, make_pmd, val, val >> 32) };
+	return (pmd_t) { PVOP_CALL2(unsigned long long, pv_mmu_ops.make_pmd,
+				    val, val >> 32) };
 }
 
 static inline pgd_t __pgd(unsigned long long val)
 {
-	return (pgd_t) { PVOP_CALL2(unsigned long long, make_pgd, val, val >> 32) };
+	return (pgd_t) { PVOP_CALL2(unsigned long long, pv_mmu_ops.make_pgd,
+				    val, val >> 32) };
 }
 
 static inline unsigned long long pte_val(pte_t x)
 {
-	return PVOP_CALL2(unsigned long long, pte_val, x.pte_low, x.pte_high);
+	return PVOP_CALL2(unsigned long long, pv_mmu_ops.pte_val,
+			  x.pte_low, x.pte_high);
 }
 
 static inline unsigned long long pmd_val(pmd_t x)
 {
-	return PVOP_CALL2(unsigned long long, pmd_val, x.pmd, x.pmd >> 32);
+	return PVOP_CALL2(unsigned long long, pv_mmu_ops.pmd_val,
+			  x.pmd, x.pmd >> 32);
 }
 
 static inline unsigned long long pgd_val(pgd_t x)
 {
-	return PVOP_CALL2(unsigned long long, pgd_val, x.pgd, x.pgd >> 32);
+	return PVOP_CALL2(unsigned long long, pv_mmu_ops.pgd_val,
+			  x.pgd, x.pgd >> 32);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	PVOP_VCALL3(set_pte, ptep, pteval.pte_low, pteval.pte_high);
+	PVOP_VCALL3(pv_mmu_ops.set_pte, ptep, pteval.pte_low, pteval.pte_high);
 }
 
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval)
 {
 	/* 5 arg words */
-	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+	pv_mmu_ops.set_pte_at(mm, addr, ptep, pteval);
 }
 
 static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
 {
-	PVOP_VCALL3(set_pte_atomic, ptep, pteval.pte_low, pteval.pte_high);
+	PVOP_VCALL3(pv_mmu_ops.set_pte_atomic, ptep, pteval.pte_low, pteval.pte_high);
 }
 
 static inline void set_pte_present(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
 	/* 5 arg words */
-	paravirt_ops.set_pte_present(mm, addr, ptep, pte);
+	pv_mmu_ops.set_pte_present(mm, addr, ptep, pte);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
-	PVOP_VCALL3(set_pmd, pmdp, pmdval.pmd, pmdval.pmd >> 32);
+	PVOP_VCALL3(pv_mmu_ops.set_pmd, pmdp, pmdval.pmd, pmdval.pmd >> 32);
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pudval)
 {
-	PVOP_VCALL3(set_pud, pudp, pudval.pgd.pgd, pudval.pgd.pgd >> 32);
+	PVOP_VCALL3(pv_mmu_ops.set_pud, pudp, pudval.pgd.pgd, pudval.pgd.pgd >> 32);
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	PVOP_VCALL3(pte_clear, mm, addr, ptep);
+	PVOP_VCALL3(pv_mmu_ops.pte_clear, mm, addr, ptep);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	PVOP_VCALL1(pmd_clear, pmdp);
+	PVOP_VCALL1(pv_mmu_ops.pmd_clear, pmdp);
 }
 
 #else  /* !CONFIG_X86_PAE */
 
 static inline pte_t __pte(unsigned long val)
 {
-	return (pte_t) { PVOP_CALL1(unsigned long, make_pte, val) };
+	return (pte_t) { PVOP_CALL1(unsigned long, pv_mmu_ops.make_pte, val) };
 }
 
 static inline pgd_t __pgd(unsigned long val)
 {
-	return (pgd_t) { PVOP_CALL1(unsigned long, make_pgd, val) };
+	return (pgd_t) { PVOP_CALL1(unsigned long, pv_mmu_ops.make_pgd, val) };
 }
 
 static inline unsigned long pte_val(pte_t x)
 {
-	return PVOP_CALL1(unsigned long, pte_val, x.pte_low);
+	return PVOP_CALL1(unsigned long, pv_mmu_ops.pte_val, x.pte_low);
 }
 
 static inline unsigned long pgd_val(pgd_t x)
 {
-	return PVOP_CALL1(unsigned long, pgd_val, x.pgd);
+	return PVOP_CALL1(unsigned long, pv_mmu_ops.pgd_val, x.pgd);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	PVOP_VCALL2(set_pte, ptep, pteval.pte_low);
+	PVOP_VCALL2(pv_mmu_ops.set_pte, ptep, pteval.pte_low);
 }
 
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval)
 {
-	PVOP_VCALL4(set_pte_at, mm, addr, ptep, pteval.pte_low);
+	PVOP_VCALL4(pv_mmu_ops.set_pte_at, mm, addr, ptep, pteval.pte_low);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
-	PVOP_VCALL2(set_pmd, pmdp, pmdval.pud.pgd.pgd);
+	PVOP_VCALL2(pv_mmu_ops.set_pmd, pmdp, pmdval.pud.pgd.pgd);
 }
 #endif	/* CONFIG_X86_PAE */
 
 #define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
 static inline void arch_enter_lazy_cpu_mode(void)
 {
-	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_CPU);
+	PVOP_VCALL1(pv_misc_ops.set_lazy_mode, PARAVIRT_LAZY_CPU);
 }
 
 static inline void arch_leave_lazy_cpu_mode(void)
 {
-	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_NONE);
+	PVOP_VCALL1(pv_misc_ops.set_lazy_mode, PARAVIRT_LAZY_NONE);
 }
 
 static inline void arch_flush_lazy_cpu_mode(void)
 {
-	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_FLUSH);
+	PVOP_VCALL1(pv_misc_ops.set_lazy_mode, PARAVIRT_LAZY_FLUSH);
 }
 
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_MMU);
+	PVOP_VCALL1(pv_misc_ops.set_lazy_mode, PARAVIRT_LAZY_MMU);
 }
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
-	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_NONE);
+	PVOP_VCALL1(pv_misc_ops.set_lazy_mode, PARAVIRT_LAZY_NONE);
 }
 
 static inline void arch_flush_lazy_mmu_mode(void)
 {
-	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_FLUSH);
+	PVOP_VCALL1(pv_misc_ops.set_lazy_mode, PARAVIRT_LAZY_FLUSH);
 }
 
 void _paravirt_nop(void);
@@ -953,7 +987,7 @@ static inline unsigned long __raw_local_
 				  PARAVIRT_CALL
 				  "popl %%edx; popl %%ecx")
 		     : "=a"(f)
-		     : paravirt_type(save_fl),
+		     : paravirt_type(pv_irq_ops.save_fl),
 		       paravirt_clobber(CLBR_EAX)
 		     : "memory", "cc");
 	return f;
@@ -966,7 +1000,7 @@ static inline void raw_local_irq_restore
 				  "popl %%edx; popl %%ecx")
 		     : "=a"(f)
 		     : "0"(f),
-		       paravirt_type(restore_fl),
+		       paravirt_type(pv_irq_ops.restore_fl),
 		       paravirt_clobber(CLBR_EAX)
 		     : "memory", "cc");
 }
@@ -977,7 +1011,7 @@ static inline void raw_local_irq_disable
 				  PARAVIRT_CALL
 				  "popl %%edx; popl %%ecx")
 		     :
-		     : paravirt_type(irq_disable),
+		     : paravirt_type(pv_irq_ops.irq_disable),
 		       paravirt_clobber(CLBR_EAX)
 		     : "memory", "eax", "cc");
 }
@@ -988,7 +1022,7 @@ static inline void raw_local_irq_enable(
 				  PARAVIRT_CALL
 				  "popl %%edx; popl %%ecx")
 		     :
-		     : paravirt_type(irq_enable),
+		     : paravirt_type(pv_irq_ops.irq_enable),
 		       paravirt_clobber(CLBR_EAX)
 		     : "memory", "eax", "cc");
 }
@@ -1004,13 +1038,13 @@ static inline unsigned long __raw_local_
 
 #define CLI_STRING							\
 	_paravirt_alt("pushl %%ecx; pushl %%edx;"			\
-		      "call *paravirt_ops+%c[paravirt_cli_type]*4;"	\
+		      "call *%[paravirt_cli_opptr];"			\
 		      "popl %%edx; popl %%ecx",				\
 		      "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
 
 #define STI_STRING							\
 	_paravirt_alt("pushl %%ecx; pushl %%edx;"			\
-		      "call *paravirt_ops+%c[paravirt_sti_type]*4;"	\
+		      "call *%[paravirt_sti_opptr];"			\
 		      "popl %%edx; popl %%ecx",				\
 		      "%c[paravirt_sti_type]", "%c[paravirt_clobber]")
 
@@ -1018,7 +1052,9 @@ static inline unsigned long __raw_local_
 #define CLI_STI_INPUT_ARGS						\
 	,								\
 	[paravirt_cli_type] "i" (PARAVIRT_PATCH(irq_disable)),		\
+	[paravirt_cli_opptr] "m" (pv_irq_ops.irq_disable),		\
 	[paravirt_sti_type] "i" (PARAVIRT_PATCH(irq_enable)),		\
+	[paravirt_sti_opptr] "i" (pv_irq_ops.irq_enable),		\
 	paravirt_clobber(CLBR_EAX)
 
 /* Make sure as little as possible of this mess escapes. */
@@ -1053,27 +1089,27 @@ 772:;						\
 
 #define INTERRUPT_RETURN					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_iret), CLBR_NONE,		\
-		  jmp *%cs:paravirt_ops+PARAVIRT_iret)
+		  jmp *%cs:pv_cpu_ops+PARAVIRT_iret)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_irq_disable), clobbers,		\
 		  pushl %eax; pushl %ecx; pushl %edx;			\
-		  call *%cs:paravirt_ops+PARAVIRT_irq_disable;		\
+		  call *%cs:pv_irq_ops+PARAVIRT_irq_disable;		\
 		  popl %edx; popl %ecx; popl %eax)			\
 
 #define ENABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_irq_enable), clobbers,		\
 		  pushl %eax; pushl %ecx; pushl %edx;			\
-		  call *%cs:paravirt_ops+PARAVIRT_irq_enable;		\
+		  call *%cs:pv_irq_ops+PARAVIRT_irq_enable;		\
 		  popl %edx; popl %ecx; popl %eax)
 
 #define ENABLE_INTERRUPTS_SYSEXIT					\
 	PARA_SITE(PARA_PATCH(PARAVIRT_irq_enable_sysexit), CLBR_NONE,	\
-		  jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit)
+		  jmp *%cs:pv_cpu_ops+PARAVIRT_irq_enable_sysexit)
 
 #define GET_CR0_INTO_EAX			\
 	push %ecx; push %edx;			\
-	call *paravirt_ops+PARAVIRT_read_cr0;	\
+	call *pv_cpu_ops+PARAVIRT_read_cr0;	\
 	pop %edx; pop %ecx
 
 #endif /* __ASSEMBLY__ */
===================================================================
--- a/include/asm-i386/pgtable-3level-defs.h
+++ b/include/asm-i386/pgtable-3level-defs.h
@@ -2,7 +2,7 @@
 #define _I386_PGTABLE_3LEVEL_DEFS_H
 
 #ifdef CONFIG_PARAVIRT
-#define SHARED_KERNEL_PMD	(paravirt_ops.shared_kernel_pmd)
+#define SHARED_KERNEL_PMD	(pv_info.shared_kernel_pmd)
 #else
 #define SHARED_KERNEL_PMD	1
 #endif
