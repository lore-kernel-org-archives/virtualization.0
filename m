From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 06/10] paravirt: split pv_cpu_ops for support of PARAVIRT_FULL
Date: Fri, 19 May 2017 17:47:42 +0200
Message-ID: <20170519154746.29389-7-jgross__21257.9408115291$1495208988$gmane$org@suse.com>
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
structure pvfull_cpu_ops in paravirt_types_full.h, paravirt_full.h and
the associated vector into paravirt_full.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/entry_64.S                  |   4 +-
 arch/x86/include/asm/debugreg.h            |   2 +-
 arch/x86/include/asm/desc.h                |   4 +-
 arch/x86/include/asm/irqflags.h            |  16 +-
 arch/x86/include/asm/msr.h                 |   4 +-
 arch/x86/include/asm/paravirt.h            | 257 +--------------------------
 arch/x86/include/asm/paravirt_full.h       | 269 +++++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt_types.h      |  78 +--------
 arch/x86/include/asm/paravirt_types_full.h |  78 +++++++++
 arch/x86/include/asm/pgtable.h             |   8 +-
 arch/x86/include/asm/processor.h           |   4 +-
 arch/x86/include/asm/special_insns.h       |  27 +--
 arch/x86/kernel/asm-offsets.c              |   9 +-
 arch/x86/kernel/asm-offsets_64.c           |   6 +-
 arch/x86/kernel/cpu/common.c               |   4 +-
 arch/x86/kernel/paravirt.c                 |  67 +------
 arch/x86/kernel/paravirt_full.c            |  66 +++++++
 arch/x86/kernel/paravirt_patch_32.c        |   8 +-
 arch/x86/kernel/paravirt_patch_64.c        |  18 +-
 arch/x86/lguest/boot.c                     |  38 ++--
 arch/x86/xen/enlighten_pv.c                |  14 +-
 21 files changed, 522 insertions(+), 459 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cd47214ff402..4e85e9c9a2f8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -42,12 +42,12 @@
 .code64
 .section .entry.text, "ax"
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 ENTRY(native_usergs_sysret64)
 	swapgs
 	sysretq
 ENDPROC(native_usergs_sysret64)
-#endif /* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 .macro TRACE_IRQS_IRETQ
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 12cb66f6d3a5..6477da0e4869 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -7,7 +7,7 @@
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_FULL
 /*
  * These special macros can be used to get or set a debugging register
  */
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index d0a21b12dd58..be2037db49a8 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -118,7 +118,7 @@ static inline int desc_empty(const void *ptr)
 	return !(desc[0] | desc[1]);
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define load_TR_desc()				native_load_tr_desc()
@@ -145,7 +145,7 @@ static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
 {
 }
-#endif	/* CONFIG_PARAVIRT */
+#endif	/* CONFIG_PARAVIRT_FULL */
 
 #define store_ldt(ldt) asm("sldt %0" : "=m"(ldt))
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index ac7692dcfa2e..c3319c20127c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -119,6 +119,16 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #define DISABLE_INTERRUPTS(x)	cli
 
 #ifdef CONFIG_X86_64
+#define PARAVIRT_ADJUST_EXCEPTION_FRAME	/*  */
+#endif
+
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifndef CONFIG_PARAVIRT_FULL
+#ifdef __ASSEMBLY__
+
+#ifdef CONFIG_X86_64
 #define SWAPGS	swapgs
 /*
  * Currently paravirt can't handle swapgs nicely when we
@@ -131,8 +141,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
  */
 #define SWAPGS_UNSAFE_STACK	swapgs
 
-#define PARAVIRT_ADJUST_EXCEPTION_FRAME	/*  */
-
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
@@ -143,13 +151,11 @@ static inline notrace unsigned long arch_local_irq_save(void)
 
 #else
 #define INTERRUPT_RETURN		iret
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
 #define GET_CR0_INTO_EAX		movl %cr0, %eax
 #endif
 
-
 #endif /* __ASSEMBLY__ */
-#endif /* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 #ifndef __ASSEMBLY__
 static inline int arch_irqs_disabled_flags(unsigned long flags)
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 898dba2e2e2c..7c715f811590 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -231,7 +231,7 @@ static inline unsigned long long native_read_pmc(int counter)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
@@ -294,7 +294,7 @@ do {							\
 
 #define rdpmcl(counter, val) ((val) = native_read_pmc(counter))
 
-#endif	/* !CONFIG_PARAVIRT */
+#endif	/* !CONFIG_PARAVIRT_FULL */
 
 /*
  * 64-bit version of wrmsr_safe():
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 419a3b991e72..2287a2465486 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -19,42 +19,6 @@
 #include <asm/paravirt_full.h>
 #endif
 
-static inline void load_sp0(struct tss_struct *tss,
-			     struct thread_struct *thread)
-{
-	PVOP_VCALL2(pv_cpu_ops.load_sp0, tss, thread);
-}
-
-/* The paravirtualized CPUID instruction. */
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-			   unsigned int *ecx, unsigned int *edx)
-{
-	PVOP_VCALL4(pv_cpu_ops.cpuid, eax, ebx, ecx, edx);
-}
-
-/*
- * These special macros can be used to get or set a debugging register
- */
-static inline unsigned long paravirt_get_debugreg(int reg)
-{
-	return PVOP_CALL1(unsigned long, pv_cpu_ops.get_debugreg, reg);
-}
-#define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
-static inline void set_debugreg(unsigned long val, int reg)
-{
-	PVOP_VCALL2(pv_cpu_ops.set_debugreg, reg, val);
-}
-
-static inline unsigned long read_cr0(void)
-{
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr0);
-}
-
-static inline void write_cr0(unsigned long x)
-{
-	PVOP_VCALL1(pv_cpu_ops.write_cr0, x);
-}
-
 static inline unsigned long read_cr2(void)
 {
 	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr2);
@@ -75,28 +39,6 @@ static inline void write_cr3(unsigned long x)
 	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
 }
 
-static inline unsigned long __read_cr4(void)
-{
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr4);
-}
-
-static inline void __write_cr4(unsigned long x)
-{
-	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
-}
-
-#ifdef CONFIG_X86_64
-static inline unsigned long read_cr8(void)
-{
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr8);
-}
-
-static inline void write_cr8(unsigned long x)
-{
-	PVOP_VCALL1(pv_cpu_ops.write_cr8, x);
-}
-#endif
-
 static inline void arch_safe_halt(void)
 {
 	PVOP_VCALL0(pv_irq_ops.safe_halt);
@@ -107,77 +49,8 @@ static inline void halt(void)
 	PVOP_VCALL0(pv_irq_ops.halt);
 }
 
-static inline void wbinvd(void)
-{
-	PVOP_VCALL0(pv_cpu_ops.wbinvd);
-}
-
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
 
-static inline u64 paravirt_read_msr(unsigned msr)
-{
-	return PVOP_CALL1(u64, pv_cpu_ops.read_msr, msr);
-}
-
-static inline void paravirt_write_msr(unsigned msr,
-				      unsigned low, unsigned high)
-{
-	return PVOP_VCALL3(pv_cpu_ops.write_msr, msr, low, high);
-}
-
-static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
-{
-	return PVOP_CALL2(u64, pv_cpu_ops.read_msr_safe, msr, err);
-}
-
-static inline int paravirt_write_msr_safe(unsigned msr,
-					  unsigned low, unsigned high)
-{
-	return PVOP_CALL3(int, pv_cpu_ops.write_msr_safe, msr, low, high);
-}
-
-#define rdmsr(msr, val1, val2)			\
-do {						\
-	u64 _l = paravirt_read_msr(msr);	\
-	val1 = (u32)_l;				\
-	val2 = _l >> 32;			\
-} while (0)
-
-#define wrmsr(msr, val1, val2)			\
-do {						\
-	paravirt_write_msr(msr, val1, val2);	\
-} while (0)
-
-#define rdmsrl(msr, val)			\
-do {						\
-	val = paravirt_read_msr(msr);		\
-} while (0)
-
-static inline void wrmsrl(unsigned msr, u64 val)
-{
-	wrmsr(msr, (u32)val, (u32)(val>>32));
-}
-
-#define wrmsr_safe(msr, a, b)	paravirt_write_msr_safe(msr, a, b)
-
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, a, b)				\
-({							\
-	int _err;					\
-	u64 _l = paravirt_read_msr_safe(msr, &_err);	\
-	(*a) = (u32)_l;					\
-	(*b) = _l >> 32;				\
-	_err;						\
-})
-
-static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
-{
-	int err;
-
-	*p = paravirt_read_msr_safe(msr, &err);
-	return err;
-}
-
 static inline unsigned long long paravirt_sched_clock(void)
 {
 	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
@@ -192,88 +65,6 @@ static inline u64 paravirt_steal_clock(int cpu)
 	return PVOP_CALL1(u64, pv_time_ops.steal_clock, cpu);
 }
 
-static inline unsigned long long paravirt_read_pmc(int counter)
-{
-	return PVOP_CALL1(u64, pv_cpu_ops.read_pmc, counter);
-}
-
-#define rdpmc(counter, low, high)		\
-do {						\
-	u64 _l = paravirt_read_pmc(counter);	\
-	low = (u32)_l;				\
-	high = _l >> 32;			\
-} while (0)
-
-#define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
-
-static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
-{
-	PVOP_VCALL2(pv_cpu_ops.alloc_ldt, ldt, entries);
-}
-
-static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
-{
-	PVOP_VCALL2(pv_cpu_ops.free_ldt, ldt, entries);
-}
-
-static inline void load_TR_desc(void)
-{
-	PVOP_VCALL0(pv_cpu_ops.load_tr_desc);
-}
-static inline void load_gdt(const struct desc_ptr *dtr)
-{
-	PVOP_VCALL1(pv_cpu_ops.load_gdt, dtr);
-}
-static inline void load_idt(const struct desc_ptr *dtr)
-{
-	PVOP_VCALL1(pv_cpu_ops.load_idt, dtr);
-}
-static inline void set_ldt(const void *addr, unsigned entries)
-{
-	PVOP_VCALL2(pv_cpu_ops.set_ldt, addr, entries);
-}
-static inline void store_idt(struct desc_ptr *dtr)
-{
-	PVOP_VCALL1(pv_cpu_ops.store_idt, dtr);
-}
-static inline unsigned long paravirt_store_tr(void)
-{
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.store_tr);
-}
-#define store_tr(tr)	((tr) = paravirt_store_tr())
-static inline void load_TLS(struct thread_struct *t, unsigned cpu)
-{
-	PVOP_VCALL2(pv_cpu_ops.load_tls, t, cpu);
-}
-
-#ifdef CONFIG_X86_64
-static inline void load_gs_index(unsigned int gs)
-{
-	PVOP_VCALL1(pv_cpu_ops.load_gs_index, gs);
-}
-#endif
-
-static inline void write_ldt_entry(struct desc_struct *dt, int entry,
-				   const void *desc)
-{
-	PVOP_VCALL3(pv_cpu_ops.write_ldt_entry, dt, entry, desc);
-}
-
-static inline void write_gdt_entry(struct desc_struct *dt, int entry,
-				   void *desc, int type)
-{
-	PVOP_VCALL4(pv_cpu_ops.write_gdt_entry, dt, entry, desc, type);
-}
-
-static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
-{
-	PVOP_VCALL3(pv_cpu_ops.write_idt_entry, dt, entry, g);
-}
-static inline void set_iopl_mask(unsigned mask)
-{
-	PVOP_VCALL1(pv_cpu_ops.set_iopl_mask, mask);
-}
-
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
@@ -670,17 +461,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 }
 #endif	/* CONFIG_X86_PAE */
 
-#define  __HAVE_ARCH_START_CONTEXT_SWITCH
-static inline void arch_start_context_switch(struct task_struct *prev)
-{
-	PVOP_VCALL1(pv_cpu_ops.start_context_switch, prev);
-}
-
-static inline void arch_end_context_switch(struct task_struct *next)
-{
-	PVOP_VCALL1(pv_cpu_ops.end_context_switch, next);
-}
-
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
 {
@@ -924,10 +704,6 @@ extern void default_banner(void);
 #include <asm/paravirt_full.h>
 #endif
 
-#define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
-
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
@@ -940,32 +716,7 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
-#ifdef CONFIG_X86_32
-#define GET_CR0_INTO_EAX				\
-	push %ecx; push %edx;				\
-	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
-	pop %edx; pop %ecx
-#else	/* !CONFIG_X86_32 */
-
-/*
- * If swapgs is used while the userspace stack is still current,
- * there's no way to call a pvop.  The PV replacement *must* be
- * inlined, or the swapgs instruction must be trapped and emulated.
- */
-#define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  swapgs)
-
-/*
- * Note: swapgs is very special, and in practise is either going to be
- * implemented with a single "swapgs" instruction or something very
- * special.  Either way, we don't need to save any registers for
- * it.
- */
-#define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
-		 )
+#ifdef CONFIG_X86_64
 
 #define GET_CR2_INTO_RAX				\
 	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
@@ -975,11 +726,7 @@ extern void default_banner(void);
 		  CLBR_NONE,						\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_adjust_exception_frame))
 
-#define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
-		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
-#endif	/* CONFIG_X86_32 */
+#endif	/* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
diff --git a/arch/x86/include/asm/paravirt_full.h b/arch/x86/include/asm/paravirt_full.h
index 1cabcfff6791..b3cf0960c161 100644
--- a/arch/x86/include/asm/paravirt_full.h
+++ b/arch/x86/include/asm/paravirt_full.h
@@ -1,4 +1,273 @@
 #ifndef _ASM_X86_PARAVIRT_FULL_H
 #define _ASM_X86_PARAVIRT_FULL_H
 
+#ifndef __ASSEMBLY__
+
+static inline void load_sp0(struct tss_struct *tss,
+			    struct thread_struct *thread)
+{
+	PVOP_VCALL2(pvfull_cpu_ops.load_sp0, tss, thread);
+}
+
+/* The paravirtualized CPUID instruction. */
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	PVOP_VCALL4(pvfull_cpu_ops.cpuid, eax, ebx, ecx, edx);
+}
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+static inline unsigned long paravirt_get_debugreg(int reg)
+{
+	return PVOP_CALL1(unsigned long, pvfull_cpu_ops.get_debugreg, reg);
+}
+#define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
+static inline void set_debugreg(unsigned long val, int reg)
+{
+	PVOP_VCALL2(pvfull_cpu_ops.set_debugreg, reg, val);
+}
+
+static inline unsigned long read_cr0(void)
+{
+	return PVOP_CALL0(unsigned long, pvfull_cpu_ops.read_cr0);
+}
+
+static inline void write_cr0(unsigned long x)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.write_cr0, x);
+}
+
+static inline unsigned long __read_cr4(void)
+{
+	return PVOP_CALL0(unsigned long, pvfull_cpu_ops.read_cr4);
+}
+
+static inline void __write_cr4(unsigned long x)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.write_cr4, x);
+}
+
+#ifdef CONFIG_X86_64
+static inline unsigned long read_cr8(void)
+{
+	return PVOP_CALL0(unsigned long, pvfull_cpu_ops.read_cr8);
+}
+
+static inline void write_cr8(unsigned long x)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.write_cr8, x);
+}
+#endif
+
+static inline void wbinvd(void)
+{
+	PVOP_VCALL0(pvfull_cpu_ops.wbinvd);
+}
+
+static inline u64 paravirt_read_msr(unsigned msr)
+{
+	return PVOP_CALL1(u64, pvfull_cpu_ops.read_msr, msr);
+}
+
+static inline void paravirt_write_msr(unsigned msr,
+				      unsigned low, unsigned high)
+{
+	return PVOP_VCALL3(pvfull_cpu_ops.write_msr, msr, low, high);
+}
+
+static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
+{
+	return PVOP_CALL2(u64, pvfull_cpu_ops.read_msr_safe, msr, err);
+}
+
+static inline int paravirt_write_msr_safe(unsigned msr,
+					  unsigned low, unsigned high)
+{
+	return PVOP_CALL3(int, pvfull_cpu_ops.write_msr_safe, msr, low, high);
+}
+
+#define rdmsr(msr, val1, val2)			\
+do {						\
+	u64 _l = paravirt_read_msr(msr);	\
+	val1 = (u32)_l;				\
+	val2 = _l >> 32;			\
+} while (0)
+
+#define wrmsr(msr, val1, val2)			\
+do {						\
+	paravirt_write_msr(msr, val1, val2);	\
+} while (0)
+
+#define rdmsrl(msr, val)			\
+do {						\
+	val = paravirt_read_msr(msr);		\
+} while (0)
+
+static inline void wrmsrl(unsigned msr, u64 val)
+{
+	wrmsr(msr, (u32)val, (u32)(val>>32));
+}
+
+#define wrmsr_safe(msr, a, b)	paravirt_write_msr_safe(msr, a, b)
+
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr, a, b)				\
+({							\
+	int _err;					\
+	u64 _l = paravirt_read_msr_safe(msr, &_err);	\
+	(*a) = (u32)_l;					\
+	(*b) = _l >> 32;				\
+	_err;						\
+})
+
+static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
+{
+	int err;
+
+	*p = paravirt_read_msr_safe(msr, &err);
+	return err;
+}
+
+static inline unsigned long long paravirt_read_pmc(int counter)
+{
+	return PVOP_CALL1(u64, pvfull_cpu_ops.read_pmc, counter);
+}
+
+#define rdpmc(counter, low, high)		\
+do {						\
+	u64 _l = paravirt_read_pmc(counter);	\
+	low = (u32)_l;				\
+	high = _l >> 32;			\
+} while (0)
+
+#define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
+
+static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
+{
+	PVOP_VCALL2(pvfull_cpu_ops.alloc_ldt, ldt, entries);
+}
+
+static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
+{
+	PVOP_VCALL2(pvfull_cpu_ops.free_ldt, ldt, entries);
+}
+
+static inline void load_TR_desc(void)
+{
+	PVOP_VCALL0(pvfull_cpu_ops.load_tr_desc);
+}
+
+static inline void load_gdt(const struct desc_ptr *dtr)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.load_gdt, dtr);
+}
+
+static inline void load_idt(const struct desc_ptr *dtr)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.load_idt, dtr);
+}
+
+static inline void set_ldt(const void *addr, unsigned entries)
+{
+	PVOP_VCALL2(pvfull_cpu_ops.set_ldt, addr, entries);
+}
+
+static inline void store_idt(struct desc_ptr *dtr)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.store_idt, dtr);
+}
+
+static inline unsigned long paravirt_store_tr(void)
+{
+	return PVOP_CALL0(unsigned long, pvfull_cpu_ops.store_tr);
+}
+
+#define store_tr(tr)	((tr) = paravirt_store_tr())
+
+static inline void load_TLS(struct thread_struct *t, unsigned cpu)
+{
+	PVOP_VCALL2(pvfull_cpu_ops.load_tls, t, cpu);
+}
+
+#ifdef CONFIG_X86_64
+static inline void load_gs_index(unsigned int gs)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.load_gs_index, gs);
+}
+#endif
+
+static inline void write_ldt_entry(struct desc_struct *dt, int entry,
+				   const void *desc)
+{
+	PVOP_VCALL3(pvfull_cpu_ops.write_ldt_entry, dt, entry, desc);
+}
+
+static inline void write_gdt_entry(struct desc_struct *dt, int entry,
+				   void *desc, int type)
+{
+	PVOP_VCALL4(pvfull_cpu_ops.write_gdt_entry, dt, entry, desc, type);
+}
+
+static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
+{
+	PVOP_VCALL3(pvfull_cpu_ops.write_idt_entry, dt, entry, g);
+}
+
+static inline void set_iopl_mask(unsigned mask)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.set_iopl_mask, mask);
+}
+
+#define  __HAVE_ARCH_START_CONTEXT_SWITCH
+static inline void arch_start_context_switch(struct task_struct *prev)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.start_context_switch, prev);
+}
+
+static inline void arch_end_context_switch(struct task_struct *next)
+{
+	PVOP_VCALL1(pvfull_cpu_ops.end_context_switch, next);
+}
+
+#else /* __ASSEMBLY__ */
+
+#define INTERRUPT_RETURN						\
+	PARA_SITE(PARA_PATCH(pvfull_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
+		  jmp PARA_INDIRECT(pvfull_cpu_ops+PV_CPU_iret))
+
+#ifdef CONFIG_X86_32
+#define GET_CR0_INTO_EAX						\
+	push %ecx; push %edx;						\
+	call PARA_INDIRECT(pvfull_cpu_ops+PV_CPU_read_cr0);		\
+	pop %edx; pop %ecx
+#else   /* !CONFIG_X86_32 */
+
+/*
+ * If swapgs is used while the userspace stack is still current,
+ * there's no way to call a pvop.  The PV replacement *must* be
+ * inlined, or the swapgs instruction must be trapped and emulated.
+ */
+#define SWAPGS_UNSAFE_STACK						\
+	PARA_SITE(PARA_PATCH(pvfull_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
+		  swapgs)
+
+/*
+ * Note: swapgs is very special, and in practise is either going to be
+ * implemented with a single "swapgs" instruction or something very
+ * special.  Either way, we don't need to save any registers for
+ * it.
+ */
+#define SWAPGS								\
+	PARA_SITE(PARA_PATCH(pvfull_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
+		  call PARA_INDIRECT(pvfull_cpu_ops+PV_CPU_swapgs))
+
+#define USERGS_SYSRET64							\
+	PARA_SITE(PARA_PATCH(pvfull_cpu_ops, PV_CPU_usergs_sysret64),	\
+		  CLBR_NONE,						\
+		  jmp PARA_INDIRECT(pvfull_cpu_ops+PV_CPU_usergs_sysret64))
+#endif  /* CONFIG_X86_32 */
+
+#endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_PARAVIRT_FULL_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index dbb0e69cd5c6..e0fb1291bbdb 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -103,82 +103,7 @@ struct pv_time_ops {
 };
 
 struct pv_cpu_ops {
-	/* hooks for various privileged instructions */
-	unsigned long (*get_debugreg)(int regno);
-	void (*set_debugreg)(int regno, unsigned long value);
-
-	unsigned long (*read_cr0)(void);
-	void (*write_cr0)(unsigned long);
-
-	unsigned long (*read_cr4)(void);
-	void (*write_cr4)(unsigned long);
-
-#ifdef CONFIG_X86_64
-	unsigned long (*read_cr8)(void);
-	void (*write_cr8)(unsigned long);
-#endif
-
-	/* Segment descriptor handling */
-	void (*load_tr_desc)(void);
-	void (*load_gdt)(const struct desc_ptr *);
-	void (*load_idt)(const struct desc_ptr *);
-	/* store_gdt has been removed. */
-	void (*store_idt)(struct desc_ptr *);
-	void (*set_ldt)(const void *desc, unsigned entries);
-	unsigned long (*store_tr)(void);
-	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
-#ifdef CONFIG_X86_64
-	void (*load_gs_index)(unsigned int idx);
-#endif
-	void (*write_ldt_entry)(struct desc_struct *ldt, int entrynum,
-				const void *desc);
-	void (*write_gdt_entry)(struct desc_struct *,
-				int entrynum, const void *desc, int size);
-	void (*write_idt_entry)(gate_desc *,
-				int entrynum, const gate_desc *gate);
-	void (*alloc_ldt)(struct desc_struct *ldt, unsigned entries);
-	void (*free_ldt)(struct desc_struct *ldt, unsigned entries);
-
-	void (*load_sp0)(struct tss_struct *tss, struct thread_struct *t);
-
-	void (*set_iopl_mask)(unsigned mask);
-
-	void (*wbinvd)(void);
 	void (*io_delay)(void);
-
-	/* cpuid emulation, mostly so that caps bits can be disabled */
-	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
-		      unsigned int *ecx, unsigned int *edx);
-
-	/* Unsafe MSR operations.  These will warn or panic on failure. */
-	u64 (*read_msr)(unsigned int msr);
-	void (*write_msr)(unsigned int msr, unsigned low, unsigned high);
-
-	/*
-	 * Safe MSR operations.
-	 * read sets err to 0 or -EIO.  write returns 0 or -EIO.
-	 */
-	u64 (*read_msr_safe)(unsigned int msr, int *err);
-	int (*write_msr_safe)(unsigned int msr, unsigned low, unsigned high);
-
-	u64 (*read_pmc)(int counter);
-
-	/*
-	 * Switch to usermode gs and return to 64-bit usermode using
-	 * sysret.  Only used in 64-bit kernels to return to 64-bit
-	 * processes.  Usermode register state, including %rsp, must
-	 * already be restored.
-	 */
-	void (*usergs_sysret64)(void);
-
-	/* Normal iret.  Jump to this with the standard iret stack
-	   frame set up. */
-	void (*iret)(void);
-
-	void (*swapgs)(void);
-
-	void (*start_context_switch)(struct task_struct *prev);
-	void (*end_context_switch)(struct task_struct *next);
 };
 
 struct pv_irq_ops {
@@ -339,6 +264,9 @@ struct paravirt_patch_template {
 	struct pv_irq_ops pv_irq_ops;
 	struct pv_mmu_ops pv_mmu_ops;
 	struct pv_lock_ops pv_lock_ops;
+#ifdef CONFIG_PARAVIRT_FULL
+	struct pvfull_cpu_ops pvfull_cpu_ops;
+#endif
 };
 
 extern struct pv_info pv_info;
diff --git a/arch/x86/include/asm/paravirt_types_full.h b/arch/x86/include/asm/paravirt_types_full.h
index 69c048324e70..50635628f6e8 100644
--- a/arch/x86/include/asm/paravirt_types_full.h
+++ b/arch/x86/include/asm/paravirt_types_full.h
@@ -1,4 +1,82 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_FULL_H
 #define _ASM_X86_PARAVIRT_TYPES_FULL_H
 
+struct pvfull_cpu_ops {
+	/* hooks for various privileged instructions */
+	unsigned long (*get_debugreg)(int regno);
+	void (*set_debugreg)(int regno, unsigned long value);
+
+	unsigned long (*read_cr0)(void);
+	void (*write_cr0)(unsigned long);
+
+	unsigned long (*read_cr4)(void);
+	void (*write_cr4)(unsigned long);
+
+#ifdef CONFIG_X86_64
+	unsigned long (*read_cr8)(void);
+	void (*write_cr8)(unsigned long);
+#endif
+
+	/* Segment descriptor handling */
+	void (*load_tr_desc)(void);
+	void (*load_gdt)(const struct desc_ptr *);
+	void (*load_idt)(const struct desc_ptr *);
+	void (*store_idt)(struct desc_ptr *);
+	void (*set_ldt)(const void *desc, unsigned entries);
+	unsigned long (*store_tr)(void);
+	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
+#ifdef CONFIG_X86_64
+	void (*load_gs_index)(unsigned int idx);
+#endif
+	void (*write_ldt_entry)(struct desc_struct *ldt, int entrynum,
+				const void *desc);
+	void (*write_gdt_entry)(struct desc_struct *,
+				int entrynum, const void *desc, int size);
+	void (*write_idt_entry)(gate_desc *,
+				int entrynum, const gate_desc *gate);
+	void (*alloc_ldt)(struct desc_struct *ldt, unsigned entries);
+	void (*free_ldt)(struct desc_struct *ldt, unsigned entries);
+
+	void (*load_sp0)(struct tss_struct *tss, struct thread_struct *t);
+
+	void (*set_iopl_mask)(unsigned mask);
+
+	void (*wbinvd)(void);
+
+	/* cpuid emulation, mostly so that caps bits can be disabled */
+	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
+		      unsigned int *ecx, unsigned int *edx);
+
+	/* Unsafe MSR operations.  These will warn or panic on failure. */
+	u64 (*read_msr)(unsigned int msr);
+	void (*write_msr)(unsigned int msr, unsigned low, unsigned high);
+
+	/*
+	 * Safe MSR operations.
+	 * read sets err to 0 or -EIO.  write returns 0 or -EIO.
+	 */
+	u64 (*read_msr_safe)(unsigned int msr, int *err);
+	int (*write_msr_safe)(unsigned int msr, unsigned low, unsigned high);
+
+	u64 (*read_pmc)(int counter);
+
+	/*
+	 * Switch to usermode gs and return to 64-bit usermode using
+	 * sysret.  Only used in 64-bit kernels to return to 64-bit
+	 * processes.  Usermode register state, including %rsp, must
+	 * already be restored.
+	 */
+	void (*usergs_sysret64)(void);
+
+	/* Normal iret.  Jump to this with the std iret stack frame set up. */
+	void (*iret)(void);
+
+	void (*swapgs)(void);
+
+	void (*start_context_switch)(struct task_struct *prev);
+	void (*end_context_switch)(struct task_struct *next);
+};
+
+extern struct pvfull_cpu_ops pvfull_cpu_ops;
+
 #endif  /* _ASM_X86_PARAVIRT_TYPES_FULL_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f5af95a0c6b8..fad12c481bf9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -98,10 +98,14 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 #define pte_val(x)	native_pte_val(x)
 #define __pte(x)	native_make_pte(x)
 
-#define arch_end_context_switch(prev)	do {} while(0)
-
 #endif	/* CONFIG_PARAVIRT */
 
+#ifndef CONFIG_PARAVIRT_FULL
+
+#define arch_end_context_switch(prev)	do {} while (0)
+
+#endif  /* CONFIG_PARAVIRT_FULL */
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3cada998a402..9592c47f52bc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -531,7 +531,7 @@ static inline unsigned long current_top_of_stack(void)
 #endif
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define __cpuid			native_cpuid
@@ -543,7 +543,7 @@ static inline void load_sp0(struct tss_struct *tss,
 }
 
 #define set_iopl_mask native_set_iopl_mask
-#endif /* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_FULL */
 
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 12af3e35edfa..ca3a3103791d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -139,16 +139,6 @@ extern asmlinkage void native_load_gs_index(unsigned);
 #include <asm/paravirt.h>
 #else
 
-static inline unsigned long read_cr0(void)
-{
-	return native_read_cr0();
-}
-
-static inline void write_cr0(unsigned long x)
-{
-	native_write_cr0(x);
-}
-
 static inline unsigned long read_cr2(void)
 {
 	return native_read_cr2();
@@ -169,6 +159,20 @@ static inline void write_cr3(unsigned long x)
 	native_write_cr3(x);
 }
 
+#endif/* CONFIG_PARAVIRT */
+
+#ifndef CONFIG_PARAVIRT_FULL
+
+static inline unsigned long read_cr0(void)
+{
+	return native_read_cr0();
+}
+
+static inline void write_cr0(unsigned long x)
+{
+	native_write_cr0(x);
+}
+
 static inline unsigned long __read_cr4(void)
 {
 	return native_read_cr4();
@@ -203,7 +207,8 @@ static inline void load_gs_index(unsigned selector)
 
 #endif
 
-#endif/* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_FULL */
+
 
 static inline void clflush(volatile void *__p)
 {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index de827d6ac8c2..7b393e453333 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -64,14 +64,17 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_PATCH_pv_cpu_ops, paravirt_patch_template, pv_cpu_ops);
 	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
 	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
 	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
-	OFFSET(PV_CPU_iret, pv_cpu_ops, iret);
-	OFFSET(PV_CPU_read_cr0, pv_cpu_ops, read_cr0);
 	OFFSET(PV_MMU_read_cr2, pv_mmu_ops, read_cr2);
 #endif
+#ifdef CONFIG_PARAVIRT_FULL
+	OFFSET(PARAVIRT_PATCH_pvfull_cpu_ops, paravirt_patch_template,
+	       pvfull_cpu_ops);
+	OFFSET(PV_CPU_iret, pvfull_cpu_ops, iret);
+	OFFSET(PV_CPU_read_cr0, pvfull_cpu_ops, read_cr0);
+#endif
 
 #ifdef CONFIG_XEN
 	BLANK();
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 99332f550c48..f4fe7d9ac0d9 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -21,8 +21,10 @@ int main(void)
 {
 #ifdef CONFIG_PARAVIRT
 	OFFSET(PV_IRQ_adjust_exception_frame, pv_irq_ops, adjust_exception_frame);
-	OFFSET(PV_CPU_usergs_sysret64, pv_cpu_ops, usergs_sysret64);
-	OFFSET(PV_CPU_swapgs, pv_cpu_ops, swapgs);
+#endif
+#ifdef CONFIG_PARAVIRT_FULL
+	OFFSET(PV_CPU_usergs_sysret64, pvfull_cpu_ops, usergs_sysret64);
+	OFFSET(PV_CPU_swapgs, pvfull_cpu_ops, swapgs);
 	BLANK();
 #endif
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c8b39870f33e..53081df88420 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1017,10 +1017,10 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	 * ESPFIX issue, we can change this.
 	 */
 #ifdef CONFIG_X86_32
-# ifdef CONFIG_PARAVIRT
+# ifdef CONFIG_PARAVIRT_FULL
 	do {
 		extern void native_iret(void);
-		if (pv_cpu_ops.iret == native_iret)
+		if (pvfull_cpu_ops.iret == native_iret)
 			set_cpu_bug(c, X86_BUG_ESPFIX);
 	} while (0);
 # else
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index b8b23b3f24c2..6b90de65479e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -24,12 +24,9 @@
 #include <linux/efi.h>
 #include <linux/bcd.h>
 #include <linux/highmem.h>
-#include <linux/kprobes.h>
 
 #include <asm/bug.h>
 #include <asm/paravirt.h>
-#include <asm/debugreg.h>
-#include <asm/desc.h>
 #include <asm/setup.h>
 #include <asm/pgtable.h>
 #include <asm/time.h>
@@ -128,6 +125,9 @@ static void *get_call_destination(u8 type)
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 		.pv_lock_ops = pv_lock_ops,
 #endif
+#ifdef CONFIG_PARAVIRT_FULL
+		.pvfull_cpu_ops = pvfull_cpu_ops,
+#endif
 	};
 	return *((void **)&tmpl + type);
 }
@@ -150,10 +150,12 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
-	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
-		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret64))
+#ifdef CONFIG_PARAVIRT_FULL
+	else if (type == PARAVIRT_PATCH(pvfull_cpu_ops.iret) ||
+		 type == PARAVIRT_PATCH(pvfull_cpu_ops.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insnbuf, opfunc, addr, len);
+#endif
 	else
 		/* Otherwise call the function; assume target could
 		   clobber any caller-save reg */
@@ -203,10 +205,6 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
-/* These are in entry.S */
-extern void native_iret(void);
-extern void native_usergs_sysret64(void);
-
 static DEFINE_PER_CPU(enum paravirt_lazy_mode, paravirt_lazy_mode) = PARAVIRT_LAZY_NONE;
 
 static inline void enter_lazy(enum paravirt_lazy_mode mode)
@@ -306,60 +304,9 @@ __visible struct pv_irq_ops pv_irq_ops = {
 };
 
 __visible struct pv_cpu_ops pv_cpu_ops = {
-	.cpuid = native_cpuid,
-	.get_debugreg = native_get_debugreg,
-	.set_debugreg = native_set_debugreg,
-	.read_cr0 = native_read_cr0,
-	.write_cr0 = native_write_cr0,
-	.read_cr4 = native_read_cr4,
-	.write_cr4 = native_write_cr4,
-#ifdef CONFIG_X86_64
-	.read_cr8 = native_read_cr8,
-	.write_cr8 = native_write_cr8,
-#endif
-	.wbinvd = native_wbinvd,
-	.read_msr = native_read_msr,
-	.write_msr = native_write_msr,
-	.read_msr_safe = native_read_msr_safe,
-	.write_msr_safe = native_write_msr_safe,
-	.read_pmc = native_read_pmc,
-	.load_tr_desc = native_load_tr_desc,
-	.set_ldt = native_set_ldt,
-	.load_gdt = native_load_gdt,
-	.load_idt = native_load_idt,
-	.store_idt = native_store_idt,
-	.store_tr = native_store_tr,
-	.load_tls = native_load_tls,
-#ifdef CONFIG_X86_64
-	.load_gs_index = native_load_gs_index,
-#endif
-	.write_ldt_entry = native_write_ldt_entry,
-	.write_gdt_entry = native_write_gdt_entry,
-	.write_idt_entry = native_write_idt_entry,
-
-	.alloc_ldt = paravirt_nop,
-	.free_ldt = paravirt_nop,
-
-	.load_sp0 = native_load_sp0,
-
-#ifdef CONFIG_X86_64
-	.usergs_sysret64 = native_usergs_sysret64,
-#endif
-	.iret = native_iret,
-	.swapgs = native_swapgs,
-
-	.set_iopl_mask = native_set_iopl_mask,
 	.io_delay = native_io_delay,
-
-	.start_context_switch = paravirt_nop,
-	.end_context_switch = paravirt_nop,
 };
 
-/* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_get_debugreg);
-NOKPROBE_SYMBOL(native_set_debugreg);
-NOKPROBE_SYMBOL(native_load_idt);
-
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
 /* 32-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_32)
diff --git a/arch/x86/kernel/paravirt_full.c b/arch/x86/kernel/paravirt_full.c
index 0c7de64129c5..9b8708421cd2 100644
--- a/arch/x86/kernel/paravirt_full.c
+++ b/arch/x86/kernel/paravirt_full.c
@@ -13,4 +13,70 @@
     GNU General Public License for more details.
 */
 
+#include <linux/percpu.h>
+#include <linux/kprobes.h>
+
 #include <asm/paravirt.h>
+#include <asm/debugreg.h>
+#include <asm/desc.h>
+#include <asm/processor.h>
+
+/* These are in entry.S */
+extern void native_iret(void);
+extern void native_usergs_sysret64(void);
+
+__visible struct pvfull_cpu_ops pvfull_cpu_ops = {
+	.cpuid = native_cpuid,
+	.get_debugreg = native_get_debugreg,
+	.set_debugreg = native_set_debugreg,
+	.read_cr0 = native_read_cr0,
+	.write_cr0 = native_write_cr0,
+	.read_cr4 = native_read_cr4,
+	.write_cr4 = native_write_cr4,
+#ifdef CONFIG_X86_64
+	.read_cr8 = native_read_cr8,
+	.write_cr8 = native_write_cr8,
+#endif
+	.wbinvd = native_wbinvd,
+	.read_msr = native_read_msr,
+	.write_msr = native_write_msr,
+	.read_msr_safe = native_read_msr_safe,
+	.write_msr_safe = native_write_msr_safe,
+	.read_pmc = native_read_pmc,
+	.load_tr_desc = native_load_tr_desc,
+	.set_ldt = native_set_ldt,
+	.load_gdt = native_load_gdt,
+	.load_idt = native_load_idt,
+	.store_idt = native_store_idt,
+	.store_tr = native_store_tr,
+	.load_tls = native_load_tls,
+#ifdef CONFIG_X86_64
+	.load_gs_index = native_load_gs_index,
+#endif
+	.write_ldt_entry = native_write_ldt_entry,
+	.write_gdt_entry = native_write_gdt_entry,
+	.write_idt_entry = native_write_idt_entry,
+
+	.alloc_ldt = paravirt_nop,
+	.free_ldt = paravirt_nop,
+
+	.load_sp0 = native_load_sp0,
+
+#ifdef CONFIG_X86_64
+	.usergs_sysret64 = native_usergs_sysret64,
+#endif
+	.iret = native_iret,
+	.swapgs = native_swapgs,
+
+	.set_iopl_mask = native_set_iopl_mask,
+
+	.start_context_switch = paravirt_nop,
+	.end_context_switch = paravirt_nop,
+};
+
+/* At this point, native_get/set_debugreg has real function entries */
+NOKPROBE_SYMBOL(native_get_debugreg);
+NOKPROBE_SYMBOL(native_set_debugreg);
+NOKPROBE_SYMBOL(native_load_idt);
+
+EXPORT_SYMBOL(pvfull_cpu_ops);
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 553acbbb4d32..ccb75951aed5 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -4,10 +4,12 @@ DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
 DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
 DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
 DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
-DEF_NATIVE(pv_cpu_ops, iret, "iret");
 DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
+#ifdef CONFIG_PARAVIRT_FULL
+DEF_NATIVE(pvfull_cpu_ops, iret, "iret");
+#endif
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
@@ -45,10 +47,12 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_irq_ops, irq_enable);
 		PATCH_SITE(pv_irq_ops, restore_fl);
 		PATCH_SITE(pv_irq_ops, save_fl);
-		PATCH_SITE(pv_cpu_ops, iret);
 		PATCH_SITE(pv_mmu_ops, read_cr2);
 		PATCH_SITE(pv_mmu_ops, read_cr3);
 		PATCH_SITE(pv_mmu_ops, write_cr3);
+#ifdef CONFIG_PARAVIRT_FULL
+		PATCH_SITE(pvfull_cpu_ops, iret);
+#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 11aaf1eaa0e4..00d5c77d23a7 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -10,14 +10,16 @@ DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
 DEF_NATIVE(pv_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
-DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
-
-DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
+#ifdef CONFIG_PARAVIRT_FULL
+DEF_NATIVE(pvfull_cpu_ops, wbinvd, "wbinvd");
+DEF_NATIVE(pvfull_cpu_ops, usergs_sysret64, "swapgs; sysretq");
+DEF_NATIVE(pvfull_cpu_ops, swapgs, "swapgs");
+#endif
+
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
 DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %rax, %rax");
@@ -54,13 +56,15 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_irq_ops, save_fl);
 		PATCH_SITE(pv_irq_ops, irq_enable);
 		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_cpu_ops, usergs_sysret64);
-		PATCH_SITE(pv_cpu_ops, swapgs);
 		PATCH_SITE(pv_mmu_ops, read_cr2);
 		PATCH_SITE(pv_mmu_ops, read_cr3);
 		PATCH_SITE(pv_mmu_ops, write_cr3);
 		PATCH_SITE(pv_mmu_ops, flush_tlb_single);
-		PATCH_SITE(pv_cpu_ops, wbinvd);
+#ifdef CONFIG_PARAVIRT_FULL
+		PATCH_SITE(pvfull_cpu_ops, usergs_sysret64);
+		PATCH_SITE(pvfull_cpu_ops, swapgs);
+		PATCH_SITE(pvfull_cpu_ops, wbinvd);
+#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index 99472698c931..fa79dbe220ad 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1410,25 +1410,25 @@ __init void lguest_init(void)
 	pv_init_ops.patch = lguest_patch;
 
 	/* Intercepts of various CPU instructions */
-	pv_cpu_ops.load_gdt = lguest_load_gdt;
-	pv_cpu_ops.cpuid = lguest_cpuid;
-	pv_cpu_ops.load_idt = lguest_load_idt;
-	pv_cpu_ops.iret = lguest_iret;
-	pv_cpu_ops.load_sp0 = lguest_load_sp0;
-	pv_cpu_ops.load_tr_desc = lguest_load_tr_desc;
-	pv_cpu_ops.set_ldt = lguest_set_ldt;
-	pv_cpu_ops.load_tls = lguest_load_tls;
-	pv_cpu_ops.get_debugreg = lguest_get_debugreg;
-	pv_cpu_ops.set_debugreg = lguest_set_debugreg;
-	pv_cpu_ops.read_cr0 = lguest_read_cr0;
-	pv_cpu_ops.write_cr0 = lguest_write_cr0;
-	pv_cpu_ops.read_cr4 = lguest_read_cr4;
-	pv_cpu_ops.write_cr4 = lguest_write_cr4;
-	pv_cpu_ops.write_gdt_entry = lguest_write_gdt_entry;
-	pv_cpu_ops.write_idt_entry = lguest_write_idt_entry;
-	pv_cpu_ops.wbinvd = lguest_wbinvd;
-	pv_cpu_ops.start_context_switch = paravirt_start_context_switch;
-	pv_cpu_ops.end_context_switch = lguest_end_context_switch;
+	pvfull_cpu_ops.load_gdt = lguest_load_gdt;
+	pvfull_cpu_ops.cpuid = lguest_cpuid;
+	pvfull_cpu_ops.load_idt = lguest_load_idt;
+	pvfull_cpu_ops.iret = lguest_iret;
+	pvfull_cpu_ops.load_sp0 = lguest_load_sp0;
+	pvfull_cpu_ops.load_tr_desc = lguest_load_tr_desc;
+	pvfull_cpu_ops.set_ldt = lguest_set_ldt;
+	pvfull_cpu_ops.load_tls = lguest_load_tls;
+	pvfull_cpu_ops.get_debugreg = lguest_get_debugreg;
+	pvfull_cpu_ops.set_debugreg = lguest_set_debugreg;
+	pvfull_cpu_ops.read_cr0 = lguest_read_cr0;
+	pvfull_cpu_ops.write_cr0 = lguest_write_cr0;
+	pvfull_cpu_ops.read_cr4 = lguest_read_cr4;
+	pvfull_cpu_ops.write_cr4 = lguest_write_cr4;
+	pvfull_cpu_ops.write_gdt_entry = lguest_write_gdt_entry;
+	pvfull_cpu_ops.write_idt_entry = lguest_write_idt_entry;
+	pvfull_cpu_ops.wbinvd = lguest_wbinvd;
+	pvfull_cpu_ops.start_context_switch = paravirt_start_context_switch;
+	pvfull_cpu_ops.end_context_switch = lguest_end_context_switch;
 
 	/* Pagetable management */
 	pv_mmu_ops.write_cr3 = lguest_write_cr3;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 7cd442690f9d..89cd5cc5f1a2 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1072,7 +1072,7 @@ static const struct pv_init_ops xen_init_ops __initconst = {
 	.patch = xen_patch,
 };
 
-static const struct pv_cpu_ops xen_cpu_ops __initconst = {
+static const struct pvfull_cpu_ops xen_cpu_ops __initconst = {
 	.cpuid = xen_cpuid,
 
 	.set_debugreg = xen_set_debugreg,
@@ -1125,7 +1125,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.load_sp0 = xen_load_sp0,
 
 	.set_iopl_mask = xen_set_iopl_mask,
-	.io_delay = xen_io_delay,
 
 	/* Xen takes care of %gs when switching to usermode for us */
 	.swapgs = paravirt_nop,
@@ -1236,14 +1235,14 @@ static void __init xen_boot_params_init_edd(void)
  */
 static void xen_setup_gdt(int cpu)
 {
-	pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry_boot;
-	pv_cpu_ops.load_gdt = xen_load_gdt_boot;
+	pvfull_cpu_ops.write_gdt_entry = xen_write_gdt_entry_boot;
+	pvfull_cpu_ops.load_gdt = xen_load_gdt_boot;
 
 	setup_stack_canary_segment(0);
 	switch_to_new_gdt(0);
 
-	pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry;
-	pv_cpu_ops.load_gdt = xen_load_gdt;
+	pvfull_cpu_ops.write_gdt_entry = xen_write_gdt_entry;
+	pvfull_cpu_ops.load_gdt = xen_load_gdt;
 }
 
 static void __init xen_dom0_set_legacy_features(void)
@@ -1270,7 +1269,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
 	pv_init_ops = xen_init_ops;
-	pv_cpu_ops = xen_cpu_ops;
+	pvfull_cpu_ops = xen_cpu_ops;
+	pv_cpu_ops.io_delay = xen_io_delay;
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
 
-- 
2.12.0
