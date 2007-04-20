From: Zachary Amsden <zach@vmware.com>
Subject: [RFC, PATCH 3/5] Paravirt_ops pure functions.patch
Date: Thu, 19 Apr 2007 18:52:44 -0700 (PDT)
Message-ID: <20070420015244.652B6BFC@zach-dev2.vmware.com>
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
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <petr@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chaz Masden <zamsden@gmail.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Make paravirt-ops be a pure function pointer struct; we already have
assembly code which uses arithmetic by 4 bytes, which means arbitrary
structures are not possible here, and they are not needed.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r a6889086a657 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/paravirt.c	Thu Apr 19 15:53:44 2007 -0700
@@ -35,6 +35,19 @@
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
 
+/* Modules may need to know if paravirt is active */
+int paravirt_enabled;
+EXPORT_SYMBOL(paravirt_enabled);
+
+/* GPLd modules might want to determine and call into backend functions */
+char *paravirt_backend = "bare hardware";
+EXPORT_SYMBOL_GPL(paravirt_backend);
+
+/* Disable PMD sharing; externally set */
+#ifdef CONFIG_X86_PAE
+int use_shared_kernel_pmd = 1;
+#endif
+
 /* nop stub */
 void _paravirt_nop(void)
 {
@@ -43,7 +56,7 @@ static void __init default_banner(void)
 static void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
-	       paravirt_ops.name);
+	       paravirt_backend);
 }
 
 char *memory_setup(void)
@@ -230,11 +243,6 @@ core_initcall(print_banner);
 core_initcall(print_banner);
 
 struct paravirt_ops paravirt_ops = {
-	.name = "bare hardware",
-	.paravirt_enabled = 0,
-	.kernel_rpl = 0,
-	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
-
  	.patch = native_patch,
 	.banner = default_banner,
 	.arch_setup = paravirt_nop,
diff -r a6889086a657 arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/apm.c	Thu Apr 19 15:59:56 2007 -0700
@@ -2198,7 +2198,7 @@ static int __init apm_init(void)
 
 	dmi_check_system(apm_dmi_table);
 
-	if (apm_info.bios.version == 0 || paravirt_enabled()) {
+	if (apm_info.bios.version == 0 || paravirt_enabled) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
 		return -ENODEV;
 	}
diff -r a6889086a657 arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/asm-offsets.c	Thu Apr 19 15:58:06 2007 -0700
@@ -108,7 +108,6 @@ void foo(void)
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_enabled, paravirt_ops, paravirt_enabled);
 	OFFSET(PARAVIRT_irq_disable, paravirt_ops, irq_disable);
 	OFFSET(PARAVIRT_irq_enable, paravirt_ops, irq_enable);
 	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
diff -r a6889086a657 arch/i386/kernel/cpu/bugs.c
--- a/arch/i386/kernel/cpu/bugs.c	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/cpu/bugs.c	Thu Apr 19 15:59:27 2007 -0700
@@ -86,7 +86,7 @@ static void __init check_fpu(void)
 
 static void __init check_hlt(void)
 {
-	if (paravirt_enabled())
+	if (paravirt_enabled)
 		return;
 
 	printk(KERN_INFO "Checking 'hlt' instruction... ");
diff -r a6889086a657 arch/i386/kernel/cpu/intel.c
--- a/arch/i386/kernel/cpu/intel.c	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/cpu/intel.c	Thu Apr 19 15:59:42 2007 -0700
@@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
 	 * Note that the workaround only should be initialized once...
 	 */
 	c->f00f_bug = 0;
-	if (!paravirt_enabled() && c->x86 == 5) {
+	if (!paravirt_enabled && c->x86 == 5) {
 		static int f00f_workaround_enabled = 0;
 
 		c->f00f_bug = 1;
diff -r a6889086a657 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/entry.S	Thu Apr 19 15:58:47 2007 -0700
@@ -436,7 +436,7 @@ ldt_ss:
 	 * is still available to implement the setting of the high
 	 * 16-bits in the INTERRUPT_RETURN paravirt-op.
 	 */
-	cmpl $0, paravirt_ops+PARAVIRT_enabled
+	cmpl $0, paravirt_enabled
 	jne restore_nocheck
 #endif
 
diff -r a6889086a657 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Apr 19 15:44:49 2007 -0700
+++ b/arch/i386/kernel/vmi.c	Thu Apr 19 16:00:31 2007 -0700
@@ -714,7 +714,6 @@ do {								\
  */
 static inline int __init activate_vmi(void)
 {
-	short kernel_cs;
 	u64 reloc;
 	const struct vmi_relocation_info *rel = (struct vmi_relocation_info *)&reloc;
 
@@ -722,13 +721,11 @@ static inline int __init activate_vmi(vo
 		printk(KERN_ERR "VMI ROM failed to initialize!");
 		return 0;
 	}
-	savesegment(cs, kernel_cs);
-
-	paravirt_ops.paravirt_enabled = 1;
-	paravirt_ops.kernel_rpl = kernel_cs & SEGMENT_RPL_MASK;
+
+	paravirt_enabled = 1;
+	paravirt_backend = "vmi";
 
 	paravirt_ops.patch = vmi_patch;
-	paravirt_ops.name = "vmi";
 
 	/*
 	 * Many of these operations are ABI compatible with VMI.
diff -r a6889086a657 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Apr 19 15:44:49 2007 -0700
+++ b/include/asm-i386/paravirt.h	Thu Apr 19 16:03:53 2007 -0700
@@ -35,11 +35,6 @@ enum paravirt_lazy_mode {
 
 struct paravirt_ops
 {
-	unsigned int kernel_rpl;
-	int shared_kernel_pmd;
- 	int paravirt_enabled;
-	const char *name;
-
 	/*
 	 * Patch may replace one of the defined code sequences with arbitrary
 	 * code, subject to the same register constraints.  This generally
@@ -420,10 +415,8 @@ unsigned paravirt_patch_insns(void *site
 		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)),	\
 		    [_arg5] "mr" ((u32)(arg5)))
 
-static inline int paravirt_enabled(void)
-{
-	return paravirt_ops.paravirt_enabled;
-}
+extern int paravirt_enabled;
+extern char *paravirt_backend;
 
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
@@ -531,7 +524,12 @@ static inline void wbinvd(void)
 	PVOP_VCALL0(wbinvd);
 }
 
-#define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
+#define get_kernel_rpl() 			\
+({						\
+	short kernel_cs;			\
+	savesegment(cs, kernel_cs);		\
+	(kernel_cs & SEGMENT_RPL_MASK);		\
+})
 
 static inline u64 paravirt_read_msr(unsigned msr, int *err)
 {
@@ -799,6 +797,8 @@ static inline void pte_update_defer(stru
 }
 
 #ifdef CONFIG_X86_PAE
+extern int use_shared_kernel_pmd;
+
 static inline pte_t __pte(unsigned long long val)
 {
 	unsigned long long ret = PVOP_CALL2(unsigned long long, make_pte,
diff -r a6889086a657 include/asm-i386/pgtable-3level-defs.h
--- a/include/asm-i386/pgtable-3level-defs.h	Thu Apr 19 15:44:49 2007 -0700
+++ b/include/asm-i386/pgtable-3level-defs.h	Thu Apr 19 15:47:10 2007 -0700
@@ -2,7 +2,7 @@
 #define _I386_PGTABLE_3LEVEL_DEFS_H
 
 #ifdef CONFIG_PARAVIRT
-#define SHARED_KERNEL_PMD	(paravirt_ops.shared_kernel_pmd)
+#define SHARED_KERNEL_PMD	use_shared_kernel_pmd
 #else
 #define SHARED_KERNEL_PMD	1
 #endif
diff -r a6889086a657 include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Thu Apr 19 15:44:49 2007 -0700
+++ b/include/asm-i386/processor.h	Thu Apr 19 16:01:09 2007 -0700
@@ -578,7 +578,7 @@ static inline void native_set_iopl_mask(
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-#define paravirt_enabled() 0
+#define paravirt_enabled 0
 #define __cpuid native_cpuid
 
 static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
