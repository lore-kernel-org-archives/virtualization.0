From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 09/10] paravirt: split pv_info for support of PARAVIRT_FULL
Date: Fri, 19 May 2017 17:47:45 +0200
Message-ID: <20170519154746.29389-10-jgross__16060.9398074032$1495208951$gmane$org@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Move members needed for fully paravirtualized guests only into a new
structure pvfull_info in paravirt_types_full.h, paravirt_full.h and
the associated vector into paravirt_full.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/boot/compressed/misc.h             |  1 +
 arch/x86/include/asm/paravirt.h             |  2 --
 arch/x86/include/asm/paravirt_full.h        |  2 ++
 arch/x86/include/asm/paravirt_types.h       |  7 -------
 arch/x86/include/asm/paravirt_types_full.h  | 10 ++++++++++
 arch/x86/include/asm/pgtable-3level_types.h |  4 ++--
 arch/x86/include/asm/ptrace.h               |  5 +++--
 arch/x86/include/asm/segment.h              |  2 +-
 arch/x86/kernel/paravirt.c                  |  9 ++-------
 arch/x86/kernel/paravirt_full.c             | 10 ++++++++++
 arch/x86/lguest/boot.c                      |  4 ++--
 arch/x86/xen/enlighten_pv.c                 | 12 ++++++------
 12 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 1c8355eadbd1..007b58f3d985 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,6 +9,7 @@
  */
 #undef CONFIG_PARAVIRT
 #undef CONFIG_PARAVIRT_SPINLOCKS
+#undef CONFIG_PARAVIRT_FULL
 #undef CONFIG_KASAN
 
 #include <linux/linkage.h>
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 3b9960a5de4a..55e0c1807df2 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -26,8 +26,6 @@ static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 #endif
 
-#define get_kernel_rpl()  (pv_info.kernel_rpl)
-
 static inline unsigned long long paravirt_sched_clock(void)
 {
 	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
diff --git a/arch/x86/include/asm/paravirt_full.h b/arch/x86/include/asm/paravirt_full.h
index 53f2eb436ba3..95d1c21bbef7 100644
--- a/arch/x86/include/asm/paravirt_full.h
+++ b/arch/x86/include/asm/paravirt_full.h
@@ -3,6 +3,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define get_kernel_rpl()	(pvfull_info.kernel_rpl)
+
 static inline void load_sp0(struct tss_struct *tss,
 			    struct thread_struct *thread)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b1ac2a5698b4..34753d10ebbc 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -66,13 +66,6 @@ struct paravirt_callee_save {
 
 /* general info */
 struct pv_info {
-	unsigned int kernel_rpl;
-	int shared_kernel_pmd;
-
-#ifdef CONFIG_X86_64
-	u16 extra_user_64bit_cs;  /* __USER_CS if none */
-#endif
-
 	const char *name;
 };
 
diff --git a/arch/x86/include/asm/paravirt_types_full.h b/arch/x86/include/asm/paravirt_types_full.h
index 15d595a5f9d2..b1f91fad5842 100644
--- a/arch/x86/include/asm/paravirt_types_full.h
+++ b/arch/x86/include/asm/paravirt_types_full.h
@@ -1,6 +1,15 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_FULL_H
 #define _ASM_X86_PARAVIRT_TYPES_FULL_H
 
+struct pvfull_info {
+	unsigned int kernel_rpl;
+	int shared_kernel_pmd;
+
+#ifdef CONFIG_X86_64
+	u16 extra_user_64bit_cs;	/* __USER_CS if none */
+#endif
+};
+
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
 	void (*enter)(void);
@@ -193,6 +202,7 @@ struct pvfull_mmu_ops {
 			   phys_addr_t phys, pgprot_t flags);
 };
 
+extern struct pvfull_info pvfull_info;
 extern struct pvfull_cpu_ops pvfull_cpu_ops;
 extern struct pvfull_irq_ops pvfull_irq_ops;
 extern struct pvfull_mmu_ops pvfull_mmu_ops;
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index b8a4341faafa..fdf132570189 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -19,8 +19,8 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLY__ */
 
-#ifdef CONFIG_PARAVIRT
-#define SHARED_KERNEL_PMD	(pv_info.shared_kernel_pmd)
+#ifdef CONFIG_PARAVIRT_FULL
+#define SHARED_KERNEL_PMD	(pvfull_info.shared_kernel_pmd)
 #else
 #define SHARED_KERNEL_PMD	1
 #endif
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 2b5d686ea9f3..81d73663c497 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -118,7 +118,7 @@ static inline int v8086_mode(struct pt_regs *regs)
 #ifdef CONFIG_X86_64
 static inline bool user_64bit_mode(struct pt_regs *regs)
 {
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_FULL
 	/*
 	 * On non-paravirt systems, this is the only long mode CPL 3
 	 * selector.  We do not allow long mode selectors in the LDT.
@@ -126,7 +126,8 @@ static inline bool user_64bit_mode(struct pt_regs *regs)
 	return regs->cs == __USER_CS;
 #else
 	/* Headers are too twisted for this to go in paravirt.h. */
-	return regs->cs == __USER_CS || regs->cs == pv_info.extra_user_64bit_cs;
+	return regs->cs == __USER_CS ||
+	       regs->cs == pvfull_info.extra_user_64bit_cs;
 #endif
 }
 
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 1549caa098f0..1c8f320934d1 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -210,7 +210,7 @@
 
 #endif
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_FULL
 # define get_kernel_rpl()		0
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6fb642572bff..42da2fde1fef 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -125,6 +125,7 @@ static void *get_call_destination(u8 type)
 #ifdef CONFIG_PARAVIRT_FULL
 		.pvfull_cpu_ops = pvfull_cpu_ops,
 		.pvfull_irq_ops = pvfull_irq_ops,
+		.pvfull_mmu_ops = pvfull_mmu_ops,
 #endif
 	};
 	return *((void **)&tmpl + type);
@@ -186,12 +187,6 @@ static u64 native_steal_clock(int cpu)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
-	.kernel_rpl = 0,
-	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
-
-#ifdef CONFIG_X86_64
-	.extra_user_64bit_cs = __USER_CS,
-#endif
 };
 
 struct pv_init_ops pv_init_ops = {
@@ -222,5 +217,5 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 EXPORT_SYMBOL_GPL(pv_time_ops);
 EXPORT_SYMBOL    (pv_cpu_ops);
 EXPORT_SYMBOL    (pv_mmu_ops);
-EXPORT_SYMBOL_GPL(pv_info);
+EXPORT_SYMBOL    (pv_info);
 EXPORT_SYMBOL    (pv_irq_ops);
diff --git a/arch/x86/kernel/paravirt_full.c b/arch/x86/kernel/paravirt_full.c
index b90dfa7428bd..b65d19d8d9d7 100644
--- a/arch/x86/kernel/paravirt_full.c
+++ b/arch/x86/kernel/paravirt_full.c
@@ -116,6 +116,15 @@ static void native_flush_tlb_single(unsigned long addr)
 	__native_flush_tlb_single(addr);
 }
 
+struct pvfull_info pvfull_info = {
+	.kernel_rpl = 0,
+	.shared_kernel_pmd = 1, /* Only used when CONFIG_X86_PAE is set */
+
+#ifdef CONFIG_X86_64
+	.extra_user_64bit_cs = __USER_CS,
+#endif
+};
+
 __visible struct pvfull_cpu_ops pvfull_cpu_ops = {
 	.cpuid = native_cpuid,
 	.get_debugreg = native_get_debugreg,
@@ -262,6 +271,7 @@ NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
+EXPORT_SYMBOL_GPL(pvfull_info);
 EXPORT_SYMBOL(pvfull_cpu_ops);
 EXPORT_SYMBOL_GPL(pvfull_irq_ops);
 EXPORT_SYMBOL(pvfull_mmu_ops);
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index b9757853cf79..86b8b1a0c99e 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1390,9 +1390,9 @@ __init void lguest_init(void)
 	/* We're under lguest. */
 	pv_info.name = "lguest";
 	/* We're running at privilege level 1, not 0 as normal. */
-	pv_info.kernel_rpl = 1;
+	pvfull_info.kernel_rpl = 1;
 	/* Everyone except Xen runs with this set. */
-	pv_info.shared_kernel_pmd = 1;
+	pvfull_info.shared_kernel_pmd = 1;
 
 	/*
 	 * We set up all the lguest overrides for sensitive operations.  These
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 9badad9f82e0..dcf1b4183c49 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1059,13 +1059,12 @@ static unsigned xen_patch(u8 type, u16 clobbers, void *insnbuf,
 	return ret;
 }
 
-static const struct pv_info xen_info __initconst = {
+static const struct pvfull_info xen_info __initconst = {
 	.shared_kernel_pmd = 0,
 
 #ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = FLAT_USER_CS64,
 #endif
-	.name = "Xen",
 };
 
 static const struct pv_init_ops xen_init_ops __initconst = {
@@ -1267,7 +1266,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	xen_setup_machphys_mapping();
 
 	/* Install Xen paravirt ops */
-	pv_info = xen_info;
+	pvfull_info = xen_info;
+	pv_info.name = "Xen";
 	pv_init_ops = xen_init_ops;
 	pvfull_cpu_ops = xen_cpu_ops;
 	pv_cpu_ops.io_delay = xen_io_delay;
@@ -1358,11 +1358,11 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* keep using Xen gdt for now; no urgent need to change it */
 
 #ifdef CONFIG_X86_32
-	pv_info.kernel_rpl = 1;
+	pvfull_info.kernel_rpl = 1;
 	if (xen_feature(XENFEAT_supervisor_mode_kernel))
-		pv_info.kernel_rpl = 0;
+		pvfull_info.kernel_rpl = 0;
 #else
-	pv_info.kernel_rpl = 0;
+	pvfull_info.kernel_rpl = 0;
 #endif
 	/* set the limit of our address space */
 	xen_reserve_top();
-- 
2.12.0
