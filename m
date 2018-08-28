From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 13/15] x86/paravirt: move the pv_irq_ops under the
	PARAVIRT_XXL umbrella
Date: Tue, 28 Aug 2018 09:40:24 +0200
Message-ID: <20180828074026.820-14-jgross__28079.3098420419$1535442546$gmane$org@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

All of the paravirt ops defined in pv_irq_ops are for Xen PV guests
or VSMP only. Define them only if CONFIG_PARAVIRT_XXL is set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- put all irq ops under XXL (Peter Zijlstra)
---
 arch/x86/include/asm/irqflags.h       | 8 +-------
 arch/x86/include/asm/paravirt.h       | 6 +++---
 arch/x86/include/asm/paravirt_types.h | 3 ++-
 arch/x86/kernel/asm-offsets.c         | 2 +-
 arch/x86/kernel/asm-offsets_64.c      | 2 +-
 arch/x86/kernel/paravirt.c            | 2 +-
 arch/x86/kernel/paravirt_patch_32.c   | 4 ++--
 arch/x86/kernel/paravirt_patch_64.c   | 4 +++-
 arch/x86/kernel/vsmp_64.c             | 2 +-
 9 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c5e74ba2c95e..d84517184841 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -63,7 +63,7 @@ static inline __cpuidle void native_halt(void)
 
 #endif
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #ifndef __ASSEMBLY__
@@ -125,13 +125,7 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(x)		pushfq; popq %rax
 #endif
-#endif
-#endif /* __ASSEMBLY__ */
-#endif /* CONFIG_PARAVIRT */
 
-#ifndef CONFIG_PARAVIRT_XXL
-#ifdef __ASSEMBLY__
-#ifdef CONFIG_X86_64
 #define SWAPGS	swapgs
 /*
  * Currently paravirt can't handle swapgs nicely when we
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 686a68004b5f..512433c56c33 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -91,7 +91,6 @@ static inline void write_cr8(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr8, x);
 }
 #endif
-#endif
 
 static inline void arch_safe_halt(void)
 {
@@ -103,7 +102,6 @@ static inline void halt(void)
 	PVOP_VCALL0(irq.halt);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
 static inline void wbinvd(void)
 {
 	PVOP_VCALL0(cpu.wbinvd);
@@ -770,6 +768,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #define __PV_IS_CALLEE_SAVE(func)			\
 	((struct paravirt_callee_save) { func })
 
+#ifdef CONFIG_PARAVIRT_XXL
 static inline notrace unsigned long arch_local_save_flags(void)
 {
 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
@@ -798,6 +797,7 @@ static inline notrace unsigned long arch_local_irq_save(void)
 	arch_local_irq_disable();
 	return f;
 }
+#endif
 
 
 /* Make sure as little as possible of this mess escapes. */
@@ -884,7 +884,6 @@ extern void default_banner(void);
 	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_iret);)
-#endif
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(PV_IRQ_irq_disable),			\
@@ -899,6 +898,7 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
+#endif
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 30ee6538442c..44738bf39584 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -184,6 +184,7 @@ struct pv_cpu_ops {
 } __no_randomize_layout;
 
 struct pv_irq_ops {
+#ifdef CONFIG_PARAVIRT_XXL
 	/*
 	 * Get/set interrupt state.  save_fl and restore_fl are only
 	 * expected to use X86_EFLAGS_IF; all other bits
@@ -200,7 +201,7 @@ struct pv_irq_ops {
 
 	void (*safe_halt)(void);
 	void (*halt)(void);
-
+#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 0fe233d98d17..28e7572ff74d 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -66,9 +66,9 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
+#ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
-#ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
 #endif
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 2a15d420a84d..ddced33184b5 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -25,9 +25,9 @@ int main(void)
 	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
 	       cpu.usergs_sysret64);
 	OFFSET(PV_CPU_swapgs, paravirt_patch_template, cpu.swapgs);
-#endif
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
+#endif
 #endif
 	BLANK();
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index d29b46621543..d48124be3b01 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -373,7 +373,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.start_context_switch = paravirt_nop,
 	.cpu.end_context_switch = paravirt_nop,
-#endif
 
 	/* Irq ops. */
 	.irq.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
@@ -382,6 +381,7 @@ struct paravirt_patch_template pv_ops = {
 	.irq.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
 	.irq.safe_halt = native_safe_halt,
 	.irq.halt = native_halt,
+#endif
 
 	/* Mmu ops. */
 	.mmu.read_cr2 = native_read_cr2,
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 5a20aa56efc0..1d44705c6528 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/paravirt.h>
 
+#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(irq, irq_disable, "cli");
 DEF_NATIVE(irq, irq_enable, "sti");
 DEF_NATIVE(irq, restore_fl, "push %eax; popf");
 DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
-#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(cpu, iret, "iret");
 #endif
 DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
@@ -43,11 +43,11 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			end = end_##ops##_##x;			\
 			goto patch_site
 	switch (type) {
+#ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, irq_disable);
 		PATCH_SITE(irq, irq_enable);
 		PATCH_SITE(irq, restore_fl);
 		PATCH_SITE(irq, save_fl);
-#ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(cpu, iret);
 #endif
 		PATCH_SITE(mmu, read_cr2);
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 461aba038ada..b00937963a0f 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -3,10 +3,12 @@
 #include <asm/asm-offsets.h>
 #include <linux/stringify.h>
 
+#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(irq, irq_disable, "cli");
 DEF_NATIVE(irq, irq_enable, "sti");
 DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
 DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
+#endif
 DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
@@ -51,11 +53,11 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			end = end_##ops##_##x;			\
 			goto patch_site
 	switch(type) {
+#ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(irq, restore_fl);
 		PATCH_SITE(irq, save_fl);
 		PATCH_SITE(irq, irq_enable);
 		PATCH_SITE(irq, irq_disable);
-#ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(cpu, usergs_sysret64);
 		PATCH_SITE(cpu, swapgs);
 		PATCH_SITE(cpu, wbinvd);
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 789918d78697..1eae5af491c2 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -26,7 +26,7 @@
 
 #define TOPOLOGY_REGISTER_OFFSET 0x10
 
-#if defined CONFIG_PCI && defined CONFIG_PARAVIRT
+#if defined CONFIG_PCI && defined CONFIG_PARAVIRT_XXL
 /*
  * Interrupt control on vSMPowered systems:
  * ~AC is a shadow of IF.  If IF is 'on' AC should be 'off'
-- 
2.16.4
