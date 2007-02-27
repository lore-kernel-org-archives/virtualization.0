From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 03/26] Xen-paravirt_ops: use paravirt_nop to
	consistently mark no-op operations
Date: Tue, 27 Feb 2007 00:13:40 -0800
Message-ID: <20070227081630.070333501@goop.org>
References: <20070227081337.434798469@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-nop.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Add a _paravirt_nop function for use as a stub for no-op operations,
and paravirt_nop #defined void * version to make using it easier
(since all its uses are as a void *).

This is useful to allow the patcher to automatically identify noop
operations so it can simply nop out the callsite.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/paravirt.c |   22 +++++++++++-----------
 include/asm-i386/paravirt.h |    3 +++
 2 files changed, 14 insertions(+), 11 deletions(-)

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -34,7 +34,7 @@
 #include <asm/tlbflush.h>
 
 /* nop stub */
-static void native_nop(void)
+void _paravirt_nop(void)
 {
 }
 
@@ -489,7 +489,7 @@ struct paravirt_ops paravirt_ops = {
 
  	.patch = native_patch,
 	.banner = default_banner,
-	.arch_setup = native_nop,
+	.arch_setup = paravirt_nop,
 	.memory_setup = machine_specific_memory_setup,
 	.get_wallclock = native_get_wallclock,
 	.set_wallclock = native_set_wallclock,
@@ -544,23 +544,23 @@ struct paravirt_ops paravirt_ops = {
 	.setup_boot_clock = setup_boot_APIC_clock,
 	.setup_secondary_clock = setup_secondary_APIC_clock,
 #endif
-	.set_lazy_mode = (void *)native_nop,
+	.set_lazy_mode = paravirt_nop,
 
 	.flush_tlb_user = native_flush_tlb,
 	.flush_tlb_kernel = native_flush_tlb_global,
 	.flush_tlb_single = native_flush_tlb_single,
 
-	.alloc_pt = (void *)native_nop,
-	.alloc_pd = (void *)native_nop,
-	.alloc_pd_clone = (void *)native_nop,
-	.release_pt = (void *)native_nop,
-	.release_pd = (void *)native_nop,
+	.alloc_pt = paravirt_nop,
+	.alloc_pd = paravirt_nop,
+	.alloc_pd_clone = paravirt_nop,
+	.release_pt = paravirt_nop,
+	.release_pd = paravirt_nop,
 
 	.set_pte = native_set_pte,
 	.set_pte_at = native_set_pte_at,
 	.set_pmd = native_set_pmd,
-	.pte_update = (void *)native_nop,
-	.pte_update_defer = (void *)native_nop,
+	.pte_update = paravirt_nop,
+	.pte_update_defer = paravirt_nop,
 #ifdef CONFIG_X86_PAE
 	.set_pte_atomic = native_set_pte_atomic,
 	.set_pte_present = native_set_pte_present,
@@ -572,7 +572,7 @@ struct paravirt_ops paravirt_ops = {
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 
-	.startup_ipi_hook = (void *)native_nop,
+	.startup_ipi_hook = paravirt_nop,
 };
 
 /*
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -422,6 +422,9 @@ static inline void pmd_clear(pmd_t *pmdp
 #define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_MMU)
 #define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
 
+void _paravirt_nop(void);
+#define paravirt_nop	((void *)_paravirt_nop)
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch {
 	u8 *instr; 		/* original instructions */

-- 
