From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] paravirt: remove unused pv_apic_ops structure
Date: Tue, 17 Nov 2015 14:44:32 +0100
Message-ID: <1447767872-16730-1-git-send-email-jgross@suse.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, xen-devel@lists.xen.org, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com
Cc: Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

The only member of that structure is startup_ipi_hook which is always
set to paravirt_nop.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       |  9 ---------
 arch/x86/include/asm/paravirt_types.h | 10 ----------
 arch/x86/include/asm/smp.h            |  3 ---
 arch/x86/kernel/paravirt.c            |  8 --------
 arch/x86/kernel/smpboot.c             |  7 -------
 arch/x86/xen/enlighten.c              |  7 -------
 6 files changed, 44 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 10d0596..4d7f080 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -285,15 +285,6 @@ static inline void slow_down_io(void)
 #endif
 }
 
-#ifdef CONFIG_SMP
-static inline void startup_ipi_hook(int phys_apicid, unsigned long start_eip,
-				    unsigned long start_esp)
-{
-	PVOP_VCALL3(pv_apic_ops.startup_ipi_hook,
-		    phys_apicid, start_eip, start_esp);
-}
-#endif
-
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 31247b5..b0e603b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -215,14 +215,6 @@ struct pv_irq_ops {
 #endif
 };
 
-struct pv_apic_ops {
-#ifdef CONFIG_X86_LOCAL_APIC
-	void (*startup_ipi_hook)(int phys_apicid,
-				 unsigned long start_eip,
-				 unsigned long start_esp);
-#endif
-};
-
 struct pv_mmu_ops {
 	unsigned long (*read_cr2)(void);
 	void (*write_cr2)(unsigned long);
@@ -354,7 +346,6 @@ struct paravirt_patch_template {
 	struct pv_time_ops pv_time_ops;
 	struct pv_cpu_ops pv_cpu_ops;
 	struct pv_irq_ops pv_irq_ops;
-	struct pv_apic_ops pv_apic_ops;
 	struct pv_mmu_ops pv_mmu_ops;
 	struct pv_lock_ops pv_lock_ops;
 };
@@ -364,7 +355,6 @@ extern struct pv_init_ops pv_init_ops;
 extern struct pv_time_ops pv_time_ops;
 extern struct pv_cpu_ops pv_cpu_ops;
 extern struct pv_irq_ops pv_irq_ops;
-extern struct pv_apic_ops pv_apic_ops;
 extern struct pv_mmu_ops pv_mmu_ops;
 extern struct pv_lock_ops pv_lock_ops;
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 222a6a3..c16ddf9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -74,9 +74,6 @@ struct smp_ops {
 extern void set_cpu_sibling_map(int cpu);
 
 #ifdef CONFIG_SMP
-#ifndef CONFIG_PARAVIRT
-#define startup_ipi_hook(phys_apicid, start_eip, start_esp) do { } while (0)
-#endif
 extern struct smp_ops smp_ops;
 
 static inline void smp_send_stop(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c2130ae..f3b79b2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -133,7 +133,6 @@ static void *get_call_destination(u8 type)
 		.pv_time_ops = pv_time_ops,
 		.pv_cpu_ops = pv_cpu_ops,
 		.pv_irq_ops = pv_irq_ops,
-		.pv_apic_ops = pv_apic_ops,
 		.pv_mmu_ops = pv_mmu_ops,
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 		.pv_lock_ops = pv_lock_ops,
@@ -403,12 +402,6 @@ NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
-struct pv_apic_ops pv_apic_ops = {
-#ifdef CONFIG_X86_LOCAL_APIC
-	.startup_ipi_hook = paravirt_nop,
-#endif
-};
-
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
 /* 32-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_32)
@@ -492,6 +485,5 @@ struct pv_mmu_ops pv_mmu_ops = {
 EXPORT_SYMBOL_GPL(pv_time_ops);
 EXPORT_SYMBOL    (pv_cpu_ops);
 EXPORT_SYMBOL    (pv_mmu_ops);
-EXPORT_SYMBOL_GPL(pv_apic_ops);
 EXPORT_SYMBOL_GPL(pv_info);
 EXPORT_SYMBOL    (pv_irq_ops);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 892ee2e5..4df7777 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -629,13 +629,6 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 		num_starts = 0;
 
 	/*
-	 * Paravirt / VMI wants a startup IPI hook here to set up the
-	 * target processor state.
-	 */
-	startup_ipi_hook(phys_apicid, (unsigned long) start_secondary,
-			 stack_start);
-
-	/*
 	 * Run STARTUP IPI loop.
 	 */
 	pr_debug("#startup loops: %d\n", num_starts);
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 5774800..4334e511 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1265,12 +1265,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.end_context_switch = xen_end_context_switch,
 };
 
-static const struct pv_apic_ops xen_apic_ops __initconst = {
-#ifdef CONFIG_X86_LOCAL_APIC
-	.startup_ipi_hook = paravirt_nop,
-#endif
-};
-
 static void xen_reboot(int reason)
 {
 	struct sched_shutdown r = { .reason = reason };
@@ -1536,7 +1530,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
 	pv_init_ops = xen_init_ops;
-	pv_apic_ops = xen_apic_ops;
 	if (!xen_pvh_domain()) {
 		pv_cpu_ops = xen_cpu_ops;
 
-- 
2.6.2
