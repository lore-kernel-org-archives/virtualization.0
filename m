From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/3] Only export selected pv-ops feature structs
Date: Wed, 18 Nov 2009 01:13:11 +0100
Message-ID: <1258503192-14246-3-git-send-email-agraf__6310.42012614689$1258503251$gmane$org@suse.de>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258503192-14246-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm list <kvm@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

To really check for sure that we're not using any pv-ops code by accident,
we should make sure that we don't even export the structures used to access
pv-ops exported functions.

So let's surround the pv-ops structs by #ifdefs.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/x86/kernel/paravirt.c |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c8530bd..0619e7c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -124,11 +124,21 @@ static void *get_call_destination(u8 type)
 {
 	struct paravirt_patch_template tmpl = {
 		.pv_init_ops = pv_init_ops,
+#ifdef CONFIG_PARAVIRT_TIME
 		.pv_time_ops = pv_time_ops,
+#endif
+#ifdef CONFIG_PARAVIRT_CPU
 		.pv_cpu_ops = pv_cpu_ops,
+#endif
+#ifdef CONFIG_PARAVIRT_IRQ
 		.pv_irq_ops = pv_irq_ops,
+#endif
+#ifdef CONFIG_PARAVIRT_APIC
 		.pv_apic_ops = pv_apic_ops,
+#endif
+#ifdef CONFIG_PARAVIRT_MMU
 		.pv_mmu_ops = pv_mmu_ops,
+#endif
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 		.pv_lock_ops = pv_lock_ops,
 #endif
@@ -185,6 +195,7 @@ unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
 	return insn_len;
 }
 
+#ifdef CONFIG_PARAVIRT_MMU
 static void native_flush_tlb(void)
 {
 	__native_flush_tlb();
@@ -203,6 +214,7 @@ static void native_flush_tlb_single(unsigned long addr)
 {
 	__native_flush_tlb_single(addr);
 }
+#endif  /* CONFIG_PARAVIRT_MMU */
 
 /* These are in entry.S */
 extern void native_iret(void);
@@ -284,6 +296,7 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 	return percpu_read(paravirt_lazy_mode);
 }
 
+#ifdef CONFIG_PARAVIRT_MMU
 void arch_flush_lazy_mmu_mode(void)
 {
 	preempt_disable();
@@ -295,6 +308,7 @@ void arch_flush_lazy_mmu_mode(void)
 
 	preempt_enable();
 }
+#endif  /* CONFIG_PARAVIRT_MMU */
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
@@ -306,11 +320,16 @@ struct pv_info pv_info = {
 struct pv_init_ops pv_init_ops = {
 	.patch = native_patch,
 };
+EXPORT_SYMBOL_GPL(pv_info);
 
+#ifdef CONFIG_PARAVIRT_TIME
 struct pv_time_ops pv_time_ops = {
 	.sched_clock = native_sched_clock,
 };
+EXPORT_SYMBOL_GPL(pv_time_ops);
+#endif
 
+#ifdef CONFIG_PARAVIRT_IRQ
 struct pv_irq_ops pv_irq_ops = {
 	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
@@ -322,7 +341,10 @@ struct pv_irq_ops pv_irq_ops = {
 	.adjust_exception_frame = paravirt_nop,
 #endif
 };
+EXPORT_SYMBOL    (pv_irq_ops);
+#endif
 
+#ifdef CONFIG_PARAVIRT_CPU
 struct pv_cpu_ops pv_cpu_ops = {
 	.cpuid = native_cpuid,
 	.get_debugreg = native_get_debugreg,
@@ -383,12 +405,17 @@ struct pv_cpu_ops pv_cpu_ops = {
 	.start_context_switch = paravirt_nop,
 	.end_context_switch = paravirt_nop,
 };
+EXPORT_SYMBOL    (pv_cpu_ops);
+#endif
 
+#ifdef CONFIG_PARAVIRT_APIC
 struct pv_apic_ops pv_apic_ops = {
 #ifdef CONFIG_X86_LOCAL_APIC
 	.startup_ipi_hook = paravirt_nop,
 #endif
 };
+EXPORT_SYMBOL_GPL(pv_apic_ops);
+#endif
 
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
 /* 32-bit pagetable entries */
@@ -398,6 +425,7 @@ struct pv_apic_ops pv_apic_ops = {
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
 #endif
 
+#ifdef CONFIG_PARAVIRT_MMU
 struct pv_mmu_ops pv_mmu_ops = {
 
 	.read_cr2 = native_read_cr2,
@@ -470,10 +498,5 @@ struct pv_mmu_ops pv_mmu_ops = {
 
 	.set_fixmap = native_set_fixmap,
 };
-
-EXPORT_SYMBOL_GPL(pv_time_ops);
-EXPORT_SYMBOL    (pv_cpu_ops);
 EXPORT_SYMBOL    (pv_mmu_ops);
-EXPORT_SYMBOL_GPL(pv_apic_ops);
-EXPORT_SYMBOL_GPL(pv_info);
-EXPORT_SYMBOL    (pv_irq_ops);
+#endif
-- 
1.6.0.2
