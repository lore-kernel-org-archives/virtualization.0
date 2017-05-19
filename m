From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 07/10] paravirt: split pv_irq_ops for support of PARAVIRT_FULL
Date: Fri, 19 May 2017 17:47:43 +0200
Message-ID: <20170519154746.29389-8-jgross__17543.2245051072$1495208966$gmane$org@suse.com>
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

Move functions needed for fully paravirtualized guests only into a new
structure pvfull_irq_ops in paravirt_types_full.h, paravirt_full.h and
the associated vector into paravirt_full.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/irqflags.h            | 44 +++++++++++++++---------------
 arch/x86/include/asm/paravirt.h            | 15 ----------
 arch/x86/include/asm/paravirt_full.h       | 17 ++++++++++++
 arch/x86/include/asm/paravirt_types.h      |  8 +-----
 arch/x86/include/asm/paravirt_types_full.h | 10 +++++++
 arch/x86/kernel/asm-offsets.c              |  2 ++
 arch/x86/kernel/asm-offsets_64.c           |  5 ++--
 arch/x86/kernel/paravirt.c                 |  6 +---
 arch/x86/kernel/paravirt_full.c            |  9 ++++++
 arch/x86/lguest/boot.c                     |  2 +-
 arch/x86/xen/irq.c                         |  3 ++
 11 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c3319c20127c..2a6d7a675271 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -87,6 +87,26 @@ static inline notrace void arch_local_irq_enable(void)
 }
 
 /*
+ * For spinlocks, etc:
+ */
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags = arch_local_save_flags();
+	arch_local_irq_disable();
+	return flags;
+}
+#else
+
+#define ENABLE_INTERRUPTS(x)	sti
+#define DISABLE_INTERRUPTS(x)	cli
+
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifndef CONFIG_PARAVIRT_FULL
+#ifndef __ASSEMBLY__
+
+/*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
  */
@@ -104,30 +124,8 @@ static inline __cpuidle void halt(void)
 	native_halt();
 }
 
-/*
- * For spinlocks, etc:
- */
-static inline notrace unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags = arch_local_save_flags();
-	arch_local_irq_disable();
-	return flags;
-}
 #else
 
-#define ENABLE_INTERRUPTS(x)	sti
-#define DISABLE_INTERRUPTS(x)	cli
-
-#ifdef CONFIG_X86_64
-#define PARAVIRT_ADJUST_EXCEPTION_FRAME	/*  */
-#endif
-
-#endif /* __ASSEMBLY__ */
-#endif /* CONFIG_PARAVIRT */
-
-#ifndef CONFIG_PARAVIRT_FULL
-#ifdef __ASSEMBLY__
-
 #ifdef CONFIG_X86_64
 #define SWAPGS	swapgs
 /*
@@ -149,6 +147,8 @@ static inline notrace unsigned long arch_local_irq_save(void)
 	swapgs;					\
 	sysretl
 
+#define PARAVIRT_ADJUST_EXCEPTION_FRAME        /*  */
+
 #else
 #define INTERRUPT_RETURN		iret
 #define GET_CR0_INTO_EAX		movl %cr0, %eax
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2287a2465486..f1680e70162b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -39,16 +39,6 @@ static inline void write_cr3(unsigned long x)
 	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
 }
 
-static inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(pv_irq_ops.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(pv_irq_ops.halt);
-}
-
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
 
 static inline unsigned long long paravirt_sched_clock(void)
@@ -721,11 +711,6 @@ extern void default_banner(void);
 #define GET_CR2_INTO_RAX				\
 	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
 
-#define PARAVIRT_ADJUST_EXCEPTION_FRAME					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_adjust_exception_frame), \
-		  CLBR_NONE,						\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_adjust_exception_frame))
-
 #endif	/* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt_full.h b/arch/x86/include/asm/paravirt_full.h
index b3cf0960c161..64753ef1d36f 100644
--- a/arch/x86/include/asm/paravirt_full.h
+++ b/arch/x86/include/asm/paravirt_full.h
@@ -231,6 +231,16 @@ static inline void arch_end_context_switch(struct task_struct *next)
 	PVOP_VCALL1(pvfull_cpu_ops.end_context_switch, next);
 }
 
+static inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(pvfull_irq_ops.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(pvfull_irq_ops.halt);
+}
+
 #else /* __ASSEMBLY__ */
 
 #define INTERRUPT_RETURN						\
@@ -267,6 +277,13 @@ static inline void arch_end_context_switch(struct task_struct *next)
 	PARA_SITE(PARA_PATCH(pvfull_cpu_ops, PV_CPU_usergs_sysret64),	\
 		  CLBR_NONE,						\
 		  jmp PARA_INDIRECT(pvfull_cpu_ops+PV_CPU_usergs_sysret64))
+
+#define PARAVIRT_ADJUST_EXCEPTION_FRAME					\
+	PARA_SITE(PARA_PATCH(pvfull_irq_ops, PV_IRQ_adjust_exception_frame), \
+		  CLBR_NONE,						\
+		  call PARA_INDIRECT(pvfull_irq_ops +			\
+				     PV_IRQ_adjust_exception_frame))
+
 #endif  /* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e0fb1291bbdb..de95e6253516 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -120,13 +120,6 @@ struct pv_irq_ops {
 	struct paravirt_callee_save restore_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
-	void (*safe_halt)(void);
-	void (*halt)(void);
-
-#ifdef CONFIG_X86_64
-	void (*adjust_exception_frame)(void);
-#endif
 };
 
 struct pv_mmu_ops {
@@ -266,6 +259,7 @@ struct paravirt_patch_template {
 	struct pv_lock_ops pv_lock_ops;
 #ifdef CONFIG_PARAVIRT_FULL
 	struct pvfull_cpu_ops pvfull_cpu_ops;
+	struct pvfull_irq_ops pvfull_irq_ops;
 #endif
 };
 
diff --git a/arch/x86/include/asm/paravirt_types_full.h b/arch/x86/include/asm/paravirt_types_full.h
index 50635628f6e8..eabc0ecec8e4 100644
--- a/arch/x86/include/asm/paravirt_types_full.h
+++ b/arch/x86/include/asm/paravirt_types_full.h
@@ -77,6 +77,16 @@ struct pvfull_cpu_ops {
 	void (*end_context_switch)(struct task_struct *next);
 };
 
+struct pvfull_irq_ops {
+	void (*safe_halt)(void);
+	void (*halt)(void);
+
+#ifdef CONFIG_X86_64
+	void (*adjust_exception_frame)(void);
+#endif
+};
+
 extern struct pvfull_cpu_ops pvfull_cpu_ops;
+extern struct pvfull_irq_ops pvfull_irq_ops;
 
 #endif  /* _ASM_X86_PARAVIRT_TYPES_FULL_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 7b393e453333..a32148390e49 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -72,6 +72,8 @@ void common(void) {
 #ifdef CONFIG_PARAVIRT_FULL
 	OFFSET(PARAVIRT_PATCH_pvfull_cpu_ops, paravirt_patch_template,
 	       pvfull_cpu_ops);
+	OFFSET(PARAVIRT_PATCH_pvfull_irq_ops, paravirt_patch_template,
+	       pvfull_irq_ops);
 	OFFSET(PV_CPU_iret, pvfull_cpu_ops, iret);
 	OFFSET(PV_CPU_read_cr0, pvfull_cpu_ops, read_cr0);
 #endif
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index f4fe7d9ac0d9..9a09d7702efc 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -19,10 +19,9 @@ static char syscalls_ia32[] = {
 
 int main(void)
 {
-#ifdef CONFIG_PARAVIRT
-	OFFSET(PV_IRQ_adjust_exception_frame, pv_irq_ops, adjust_exception_frame);
-#endif
 #ifdef CONFIG_PARAVIRT_FULL
+	OFFSET(PV_IRQ_adjust_exception_frame, pvfull_irq_ops,
+	       adjust_exception_frame);
 	OFFSET(PV_CPU_usergs_sysret64, pvfull_cpu_ops, usergs_sysret64);
 	OFFSET(PV_CPU_swapgs, pvfull_cpu_ops, swapgs);
 	BLANK();
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6b90de65479e..8e22cfc73349 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -127,6 +127,7 @@ static void *get_call_destination(u8 type)
 #endif
 #ifdef CONFIG_PARAVIRT_FULL
 		.pvfull_cpu_ops = pvfull_cpu_ops,
+		.pvfull_irq_ops = pvfull_irq_ops,
 #endif
 	};
 	return *((void **)&tmpl + type);
@@ -296,11 +297,6 @@ __visible struct pv_irq_ops pv_irq_ops = {
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
-	.safe_halt = native_safe_halt,
-	.halt = native_halt,
-#ifdef CONFIG_X86_64
-	.adjust_exception_frame = paravirt_nop,
-#endif
 };
 
 __visible struct pv_cpu_ops pv_cpu_ops = {
diff --git a/arch/x86/kernel/paravirt_full.c b/arch/x86/kernel/paravirt_full.c
index 9b8708421cd2..353968da3ddc 100644
--- a/arch/x86/kernel/paravirt_full.c
+++ b/arch/x86/kernel/paravirt_full.c
@@ -74,9 +74,18 @@ __visible struct pvfull_cpu_ops pvfull_cpu_ops = {
 	.end_context_switch = paravirt_nop,
 };
 
+__visible struct pvfull_irq_ops pvfull_irq_ops = {
+	.safe_halt = native_safe_halt,
+	.halt = native_halt,
+#ifdef CONFIG_X86_64
+	.adjust_exception_frame = paravirt_nop,
+#endif
+};
+
 /* At this point, native_get/set_debugreg has real function entries */
 NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
 EXPORT_SYMBOL(pvfull_cpu_ops);
+EXPORT_SYMBOL_GPL(pvfull_irq_ops);
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index fa79dbe220ad..bf8773854ab0 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1404,7 +1404,7 @@ __init void lguest_init(void)
 	pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(lg_restore_fl);
 	pv_irq_ops.irq_disable = PV_CALLEE_SAVE(lguest_irq_disable);
 	pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(lg_irq_enable);
-	pv_irq_ops.safe_halt = lguest_safe_halt;
+	pvfull_irq_ops.safe_halt = lguest_safe_halt;
 
 	/* Setup operations */
 	pv_init_ops.patch = lguest_patch;
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 3b55ae664521..c9dba9d8cecf 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -120,7 +120,9 @@ static const struct pv_irq_ops xen_irq_ops __initconst = {
 	.restore_fl = PV_CALLEE_SAVE(xen_restore_fl),
 	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
 	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
+};
 
+static const struct pvfull_irq_ops xen_full_irq_ops __initconst = {
 	.safe_halt = xen_safe_halt,
 	.halt = xen_halt,
 #ifdef CONFIG_X86_64
@@ -131,5 +133,6 @@ static const struct pv_irq_ops xen_irq_ops __initconst = {
 void __init xen_init_irq_ops(void)
 {
 	pv_irq_ops = xen_irq_ops;
+	pvfull_irq_ops = xen_full_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
-- 
2.12.0
