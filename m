From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 08/10] paravirt: split pv_mmu_ops for support of PARAVIRT_FULL
Date: Fri, 19 May 2017 17:47:44 +0200
Message-ID: <20170519154746.29389-9-jgross__6032.06323362446$1495209006$gmane$org@suse.com>
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
structure pvfull_mmu_ops in paravirt_types_full.h, paravirt_full.h and
the associated vector into paravirt_full.c.

.flush_tlb_others is left in pv_mmu_ops as hyperv support will use it
soon.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/fixmap.h              |   2 +-
 arch/x86/include/asm/mmu_context.h         |   4 +-
 arch/x86/include/asm/paravirt.h            | 442 ++---------------------------
 arch/x86/include/asm/paravirt_full.h       | 422 +++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt_types.h      | 117 +-------
 arch/x86/include/asm/paravirt_types_full.h | 116 ++++++++
 arch/x86/include/asm/pgalloc.h             |   2 +-
 arch/x86/include/asm/pgtable.h             |   8 +-
 arch/x86/include/asm/special_insns.h       |   6 +-
 arch/x86/include/asm/tlbflush.h            |   2 +-
 arch/x86/kernel/asm-offsets.c              |   4 +-
 arch/x86/kernel/head_64.S                  |   2 +-
 arch/x86/kernel/paravirt.c                 | 171 -----------
 arch/x86/kernel/paravirt_full.c            | 176 ++++++++++++
 arch/x86/kernel/paravirt_patch_32.c        |  12 +-
 arch/x86/kernel/paravirt_patch_64.c        |  16 +-
 arch/x86/lguest/boot.c                     |  36 +--
 arch/x86/xen/enlighten_pv.c                |   8 +-
 arch/x86/xen/mmu_pv.c                      |  34 +--
 19 files changed, 797 insertions(+), 783 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index b65155cc3760..dfef874cb9d6 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -149,7 +149,7 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
 void native_set_fixmap(enum fixed_addresses idx,
 		       phys_addr_t phys, pgprot_t flags);
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_FULL
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 68b329d77b3a..b38431024463 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -12,12 +12,12 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_FULL
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
 }
-#endif	/* !CONFIG_PARAVIRT */
+#endif	/* !CONFIG_PARAVIRT_FULL */
 
 #ifdef CONFIG_PERF_EVENTS
 extern struct static_key rdpmc_always_available;
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f1680e70162b..3b9960a5de4a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,28 +17,15 @@
 
 #ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt_full.h>
+#else
+
+static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
+{
+	return PARAVIRT_LAZY_NONE;
+}
+
 #endif
 
-static inline unsigned long read_cr2(void)
-{
-	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr2);
-}
-
-static inline void write_cr2(unsigned long x)
-{
-	PVOP_VCALL1(pv_mmu_ops.write_cr2, x);
-}
-
-static inline unsigned long read_cr3(void)
-{
-	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr3);
-}
-
-static inline void write_cr3(unsigned long x)
-{
-	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
-}
-
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
 
 static inline unsigned long long paravirt_sched_clock(void)
@@ -66,36 +53,11 @@ static inline void slow_down_io(void)
 #endif
 }
 
-static inline void paravirt_activate_mm(struct mm_struct *prev,
-					struct mm_struct *next)
-{
-	PVOP_VCALL2(pv_mmu_ops.activate_mm, prev, next);
-}
-
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
-{
-	PVOP_VCALL2(pv_mmu_ops.dup_mmap, oldmm, mm);
-}
-
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 	PVOP_VCALL1(pv_mmu_ops.exit_mmap, mm);
 }
 
-static inline void __flush_tlb(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.flush_tlb_user);
-}
-static inline void __flush_tlb_global(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
-}
-static inline void __flush_tlb_single(unsigned long addr)
-{
-	PVOP_VCALL1(pv_mmu_ops.flush_tlb_single, addr);
-}
-
 static inline void flush_tlb_others(const struct cpumask *cpumask,
 				    struct mm_struct *mm,
 				    unsigned long start,
@@ -104,375 +66,6 @@ static inline void flush_tlb_others(const struct cpumask *cpumask,
 	PVOP_VCALL4(pv_mmu_ops.flush_tlb_others, cpumask, mm, start, end);
 }
 
-static inline int paravirt_pgd_alloc(struct mm_struct *mm)
-{
-	return PVOP_CALL1(int, pv_mmu_ops.pgd_alloc, mm);
-}
-
-static inline void paravirt_pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	PVOP_VCALL2(pv_mmu_ops.pgd_free, mm, pgd);
-}
-
-static inline void paravirt_alloc_pte(struct mm_struct *mm, unsigned long pfn)
-{
-	PVOP_VCALL2(pv_mmu_ops.alloc_pte, mm, pfn);
-}
-static inline void paravirt_release_pte(unsigned long pfn)
-{
-	PVOP_VCALL1(pv_mmu_ops.release_pte, pfn);
-}
-
-static inline void paravirt_alloc_pmd(struct mm_struct *mm, unsigned long pfn)
-{
-	PVOP_VCALL2(pv_mmu_ops.alloc_pmd, mm, pfn);
-}
-
-static inline void paravirt_release_pmd(unsigned long pfn)
-{
-	PVOP_VCALL1(pv_mmu_ops.release_pmd, pfn);
-}
-
-static inline void paravirt_alloc_pud(struct mm_struct *mm, unsigned long pfn)
-{
-	PVOP_VCALL2(pv_mmu_ops.alloc_pud, mm, pfn);
-}
-static inline void paravirt_release_pud(unsigned long pfn)
-{
-	PVOP_VCALL1(pv_mmu_ops.release_pud, pfn);
-}
-
-static inline void paravirt_alloc_p4d(struct mm_struct *mm, unsigned long pfn)
-{
-	PVOP_VCALL2(pv_mmu_ops.alloc_p4d, mm, pfn);
-}
-
-static inline void paravirt_release_p4d(unsigned long pfn)
-{
-	PVOP_VCALL1(pv_mmu_ops.release_p4d, pfn);
-}
-
-static inline void pte_update(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
-{
-	PVOP_VCALL3(pv_mmu_ops.pte_update, mm, addr, ptep);
-}
-
-static inline pte_t __pte(pteval_t val)
-{
-	pteval_t ret;
-
-	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t,
-				   pv_mmu_ops.make_pte,
-				   val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pteval_t,
-				   pv_mmu_ops.make_pte,
-				   val);
-
-	return (pte_t) { .pte = ret };
-}
-
-static inline pteval_t pte_val(pte_t pte)
-{
-	pteval_t ret;
-
-	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t, pv_mmu_ops.pte_val,
-				   pte.pte, (u64)pte.pte >> 32);
-	else
-		ret = PVOP_CALLEE1(pteval_t, pv_mmu_ops.pte_val,
-				   pte.pte);
-
-	return ret;
-}
-
-static inline pgd_t __pgd(pgdval_t val)
-{
-	pgdval_t ret;
-
-	if (sizeof(pgdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pgdval_t, pv_mmu_ops.make_pgd,
-				   val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pgdval_t, pv_mmu_ops.make_pgd,
-				   val);
-
-	return (pgd_t) { ret };
-}
-
-static inline pgdval_t pgd_val(pgd_t pgd)
-{
-	pgdval_t ret;
-
-	if (sizeof(pgdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pgdval_t, pv_mmu_ops.pgd_val,
-				    pgd.pgd, (u64)pgd.pgd >> 32);
-	else
-		ret =  PVOP_CALLEE1(pgdval_t, pv_mmu_ops.pgd_val,
-				    pgd.pgd);
-
-	return ret;
-}
-
-#define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
-static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
-					   pte_t *ptep)
-{
-	pteval_t ret;
-
-	ret = PVOP_CALL3(pteval_t, pv_mmu_ops.ptep_modify_prot_start,
-			 mm, addr, ptep);
-
-	return (pte_t) { .pte = ret };
-}
-
-static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
-					   pte_t *ptep, pte_t pte)
-{
-	if (sizeof(pteval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
-	else
-		PVOP_VCALL4(pv_mmu_ops.ptep_modify_prot_commit,
-			    mm, addr, ptep, pte.pte);
-}
-
-static inline void set_pte(pte_t *ptep, pte_t pte)
-{
-	if (sizeof(pteval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_pte, ptep,
-			    pte.pte, (u64)pte.pte >> 32);
-	else
-		PVOP_VCALL2(pv_mmu_ops.set_pte, ptep,
-			    pte.pte);
-}
-
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	if (sizeof(pteval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_mmu_ops.set_pte_at(mm, addr, ptep, pte);
-	else
-		PVOP_VCALL4(pv_mmu_ops.set_pte_at, mm, addr, ptep, pte.pte);
-}
-
-static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-			      pmd_t *pmdp, pmd_t pmd)
-{
-	if (sizeof(pmdval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_mmu_ops.set_pmd_at(mm, addr, pmdp, pmd);
-	else
-		PVOP_VCALL4(pv_mmu_ops.set_pmd_at, mm, addr, pmdp,
-			    native_pmd_val(pmd));
-}
-
-static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
-			      pud_t *pudp, pud_t pud)
-{
-	if (sizeof(pudval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_mmu_ops.set_pud_at(mm, addr, pudp, pud);
-	else
-		PVOP_VCALL4(pv_mmu_ops.set_pud_at, mm, addr, pudp,
-			    native_pud_val(pud));
-}
-
-static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
-{
-	pmdval_t val = native_pmd_val(pmd);
-
-	if (sizeof(pmdval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_pmd, pmdp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(pv_mmu_ops.set_pmd, pmdp, val);
-}
-
-#if CONFIG_PGTABLE_LEVELS >= 3
-static inline pmd_t __pmd(pmdval_t val)
-{
-	pmdval_t ret;
-
-	if (sizeof(pmdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pmdval_t, pv_mmu_ops.make_pmd,
-				   val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pmdval_t, pv_mmu_ops.make_pmd,
-				   val);
-
-	return (pmd_t) { ret };
-}
-
-static inline pmdval_t pmd_val(pmd_t pmd)
-{
-	pmdval_t ret;
-
-	if (sizeof(pmdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pmdval_t, pv_mmu_ops.pmd_val,
-				    pmd.pmd, (u64)pmd.pmd >> 32);
-	else
-		ret =  PVOP_CALLEE1(pmdval_t, pv_mmu_ops.pmd_val,
-				    pmd.pmd);
-
-	return ret;
-}
-
-static inline void set_pud(pud_t *pudp, pud_t pud)
-{
-	pudval_t val = native_pud_val(pud);
-
-	if (sizeof(pudval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_pud, pudp,
-			    val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(pv_mmu_ops.set_pud, pudp,
-			    val);
-}
-#if CONFIG_PGTABLE_LEVELS >= 4
-static inline pud_t __pud(pudval_t val)
-{
-	pudval_t ret;
-
-	if (sizeof(pudval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pudval_t, pv_mmu_ops.make_pud,
-				   val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pudval_t, pv_mmu_ops.make_pud,
-				   val);
-
-	return (pud_t) { ret };
-}
-
-static inline pudval_t pud_val(pud_t pud)
-{
-	pudval_t ret;
-
-	if (sizeof(pudval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pudval_t, pv_mmu_ops.pud_val,
-				    pud.pud, (u64)pud.pud >> 32);
-	else
-		ret =  PVOP_CALLEE1(pudval_t, pv_mmu_ops.pud_val,
-				    pud.pud);
-
-	return ret;
-}
-
-static inline void pud_clear(pud_t *pudp)
-{
-	set_pud(pudp, __pud(0));
-}
-
-static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
-{
-	p4dval_t val = native_p4d_val(p4d);
-
-	if (sizeof(p4dval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_p4d, p4dp,
-			    val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(pv_mmu_ops.set_p4d, p4dp,
-			    val);
-}
-
-#if CONFIG_PGTABLE_LEVELS >= 5
-
-static inline p4d_t __p4d(p4dval_t val)
-{
-	p4dval_t ret = PVOP_CALLEE1(p4dval_t, pv_mmu_ops.make_p4d, val);
-
-	return (p4d_t) { ret };
-}
-
-static inline p4dval_t p4d_val(p4d_t p4d)
-{
-	return PVOP_CALLEE1(p4dval_t, pv_mmu_ops.p4d_val, p4d.p4d);
-}
-
-static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
-{
-	pgdval_t val = native_pgd_val(pgd);
-
-	PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp, val);
-}
-
-static inline void pgd_clear(pgd_t *pgdp)
-{
-	set_pgd(pgdp, __pgd(0));
-}
-
-#endif  /* CONFIG_PGTABLE_LEVELS == 5 */
-
-static inline void p4d_clear(p4d_t *p4dp)
-{
-	set_p4d(p4dp, __p4d(0));
-}
-
-#endif	/* CONFIG_PGTABLE_LEVELS == 4 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 3 */
-
-#ifdef CONFIG_X86_PAE
-/* Special-case pte-setting operations for PAE, which can't update a
-   64-bit pte atomically */
-static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
-{
-	PVOP_VCALL3(pv_mmu_ops.set_pte_atomic, ptep,
-		    pte.pte, pte.pte >> 32);
-}
-
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
-			     pte_t *ptep)
-{
-	PVOP_VCALL3(pv_mmu_ops.pte_clear, mm, addr, ptep);
-}
-
-static inline void pmd_clear(pmd_t *pmdp)
-{
-	PVOP_VCALL1(pv_mmu_ops.pmd_clear, pmdp);
-}
-#else  /* !CONFIG_X86_PAE */
-static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
-{
-	set_pte(ptep, pte);
-}
-
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
-			     pte_t *ptep)
-{
-	set_pte_at(mm, addr, ptep, __pte(0));
-}
-
-static inline void pmd_clear(pmd_t *pmdp)
-{
-	set_pmd(pmdp, __pmd(0));
-}
-#endif	/* CONFIG_X86_PAE */
-
-#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-static inline void arch_enter_lazy_mmu_mode(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.lazy_mode.enter);
-}
-
-static inline void arch_leave_lazy_mmu_mode(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.lazy_mode.leave);
-}
-
-static inline void arch_flush_lazy_mmu_mode(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.lazy_mode.flush);
-}
-
-static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
-				phys_addr_t phys, pgprot_t flags)
-{
-	pv_mmu_ops.set_fixmap(idx, phys, flags);
-}
-
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 
 static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
@@ -706,25 +299,22 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
-#ifdef CONFIG_X86_64
-
-#define GET_CR2_INTO_RAX				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
-
-#endif	/* CONFIG_X86_64 */
-
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
 #ifndef __ASSEMBLY__
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
-{
-}
-
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 }
 #endif /* __ASSEMBLY__ */
 #endif /* !CONFIG_PARAVIRT */
+
+#ifndef CONFIG_PARAVIRT_FULL
+#ifndef __ASSEMBLY__
+static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
+					  struct mm_struct *mm)
+{
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT_FULL */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_full.h b/arch/x86/include/asm/paravirt_full.h
index 64753ef1d36f..53f2eb436ba3 100644
--- a/arch/x86/include/asm/paravirt_full.h
+++ b/arch/x86/include/asm/paravirt_full.h
@@ -241,6 +241,425 @@ static inline void halt(void)
 	PVOP_VCALL0(pvfull_irq_ops.halt);
 }
 
+static inline unsigned long read_cr2(void)
+{
+	return PVOP_CALL0(unsigned long, pvfull_mmu_ops.read_cr2);
+}
+
+static inline void write_cr2(unsigned long x)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.write_cr2, x);
+}
+
+static inline unsigned long read_cr3(void)
+{
+	return PVOP_CALL0(unsigned long, pvfull_mmu_ops.read_cr3);
+}
+
+static inline void write_cr3(unsigned long x)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.write_cr3, x);
+}
+
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.activate_mm, prev, next);
+}
+
+static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
+					  struct mm_struct *mm)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.dup_mmap, oldmm, mm);
+}
+
+static inline void __flush_tlb(void)
+{
+	PVOP_VCALL0(pvfull_mmu_ops.flush_tlb_user);
+}
+
+static inline void __flush_tlb_global(void)
+{
+	PVOP_VCALL0(pvfull_mmu_ops.flush_tlb_kernel);
+}
+
+static inline void __flush_tlb_single(unsigned long addr)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.flush_tlb_single, addr);
+}
+
+static inline int paravirt_pgd_alloc(struct mm_struct *mm)
+{
+	return PVOP_CALL1(int, pvfull_mmu_ops.pgd_alloc, mm);
+}
+
+static inline void paravirt_pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.pgd_free, mm, pgd);
+}
+
+static inline void paravirt_alloc_pte(struct mm_struct *mm, unsigned long pfn)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.alloc_pte, mm, pfn);
+}
+
+static inline void paravirt_release_pte(unsigned long pfn)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.release_pte, pfn);
+}
+
+static inline void paravirt_alloc_pmd(struct mm_struct *mm, unsigned long pfn)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.alloc_pmd, mm, pfn);
+}
+
+static inline void paravirt_release_pmd(unsigned long pfn)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.release_pmd, pfn);
+}
+
+static inline void paravirt_alloc_pud(struct mm_struct *mm, unsigned long pfn)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.alloc_pud, mm, pfn);
+}
+
+static inline void paravirt_release_pud(unsigned long pfn)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.release_pud, pfn);
+}
+
+static inline void paravirt_alloc_p4d(struct mm_struct *mm, unsigned long pfn)
+{
+	PVOP_VCALL2(pvfull_mmu_ops.alloc_p4d, mm, pfn);
+}
+
+static inline void paravirt_release_p4d(unsigned long pfn)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.release_p4d, pfn);
+}
+
+static inline void pte_update(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
+{
+	PVOP_VCALL3(pvfull_mmu_ops.pte_update, mm, addr, ptep);
+}
+
+static inline pte_t __pte(pteval_t val)
+{
+	pteval_t ret;
+
+	if (sizeof(pteval_t) > sizeof(long))
+		ret = PVOP_CALLEE2(pteval_t,
+				   pvfull_mmu_ops.make_pte,
+				   val, (u64)val >> 32);
+	else
+		ret = PVOP_CALLEE1(pteval_t,
+				   pvfull_mmu_ops.make_pte,
+				   val);
+
+	return (pte_t) { .pte = ret };
+}
+
+static inline pteval_t pte_val(pte_t pte)
+{
+	pteval_t ret;
+
+	if (sizeof(pteval_t) > sizeof(long))
+		ret = PVOP_CALLEE2(pteval_t, pvfull_mmu_ops.pte_val,
+				   pte.pte, (u64)pte.pte >> 32);
+	else
+		ret = PVOP_CALLEE1(pteval_t, pvfull_mmu_ops.pte_val,
+				   pte.pte);
+
+	return ret;
+}
+
+static inline pgd_t __pgd(pgdval_t val)
+{
+	pgdval_t ret;
+
+	if (sizeof(pgdval_t) > sizeof(long))
+		ret = PVOP_CALLEE2(pgdval_t, pvfull_mmu_ops.make_pgd,
+				   val, (u64)val >> 32);
+	else
+		ret = PVOP_CALLEE1(pgdval_t, pvfull_mmu_ops.make_pgd,
+				   val);
+
+	return (pgd_t) { ret };
+}
+
+static inline pgdval_t pgd_val(pgd_t pgd)
+{
+	pgdval_t ret;
+
+	if (sizeof(pgdval_t) > sizeof(long))
+		ret =  PVOP_CALLEE2(pgdval_t, pvfull_mmu_ops.pgd_val,
+				    pgd.pgd, (u64)pgd.pgd >> 32);
+	else
+		ret =  PVOP_CALLEE1(pgdval_t, pvfull_mmu_ops.pgd_val,
+				    pgd.pgd);
+
+	return ret;
+}
+
+#define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
+static inline pte_t ptep_modify_prot_start(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	pteval_t ret;
+
+	ret = PVOP_CALL3(pteval_t, pvfull_mmu_ops.ptep_modify_prot_start,
+			 mm, addr, ptep);
+
+	return (pte_t) { .pte = ret };
+}
+
+static inline void ptep_modify_prot_commit(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep,
+					   pte_t pte)
+{
+	if (sizeof(pteval_t) > sizeof(long))
+		/* 5 arg words */
+		pvfull_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
+	else
+		PVOP_VCALL4(pvfull_mmu_ops.ptep_modify_prot_commit,
+			    mm, addr, ptep, pte.pte);
+}
+
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	if (sizeof(pteval_t) > sizeof(long))
+		PVOP_VCALL3(pvfull_mmu_ops.set_pte, ptep,
+			    pte.pte, (u64)pte.pte >> 32);
+	else
+		PVOP_VCALL2(pvfull_mmu_ops.set_pte, ptep,
+			    pte.pte);
+}
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
+{
+	if (sizeof(pteval_t) > sizeof(long))
+		/* 5 arg words */
+		pvfull_mmu_ops.set_pte_at(mm, addr, ptep, pte);
+	else
+		PVOP_VCALL4(pvfull_mmu_ops.set_pte_at, mm, addr, ptep, pte.pte);
+}
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+			      pmd_t *pmdp, pmd_t pmd)
+{
+	if (sizeof(pmdval_t) > sizeof(long))
+		/* 5 arg words */
+		pvfull_mmu_ops.set_pmd_at(mm, addr, pmdp, pmd);
+	else
+		PVOP_VCALL4(pvfull_mmu_ops.set_pmd_at, mm, addr, pmdp,
+			    native_pmd_val(pmd));
+}
+
+static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
+			      pud_t *pudp, pud_t pud)
+{
+	if (sizeof(pudval_t) > sizeof(long))
+		/* 5 arg words */
+		pvfull_mmu_ops.set_pud_at(mm, addr, pudp, pud);
+	else
+		PVOP_VCALL4(pvfull_mmu_ops.set_pud_at, mm, addr, pudp,
+			    native_pud_val(pud));
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	pmdval_t val = native_pmd_val(pmd);
+
+	if (sizeof(pmdval_t) > sizeof(long))
+		PVOP_VCALL3(pvfull_mmu_ops.set_pmd, pmdp, val, (u64)val >> 32);
+	else
+		PVOP_VCALL2(pvfull_mmu_ops.set_pmd, pmdp, val);
+}
+
+#if CONFIG_PGTABLE_LEVELS >= 3
+static inline pmd_t __pmd(pmdval_t val)
+{
+	pmdval_t ret;
+
+	if (sizeof(pmdval_t) > sizeof(long))
+		ret = PVOP_CALLEE2(pmdval_t, pvfull_mmu_ops.make_pmd,
+				   val, (u64)val >> 32);
+	else
+		ret = PVOP_CALLEE1(pmdval_t, pvfull_mmu_ops.make_pmd,
+				   val);
+
+	return (pmd_t) { ret };
+}
+
+static inline pmdval_t pmd_val(pmd_t pmd)
+{
+	pmdval_t ret;
+
+	if (sizeof(pmdval_t) > sizeof(long))
+		ret =  PVOP_CALLEE2(pmdval_t, pvfull_mmu_ops.pmd_val,
+				    pmd.pmd, (u64)pmd.pmd >> 32);
+	else
+		ret =  PVOP_CALLEE1(pmdval_t, pvfull_mmu_ops.pmd_val,
+				    pmd.pmd);
+
+	return ret;
+}
+
+static inline void set_pud(pud_t *pudp, pud_t pud)
+{
+	pudval_t val = native_pud_val(pud);
+
+	if (sizeof(pudval_t) > sizeof(long))
+		PVOP_VCALL3(pvfull_mmu_ops.set_pud, pudp,
+			    val, (u64)val >> 32);
+	else
+		PVOP_VCALL2(pvfull_mmu_ops.set_pud, pudp,
+			    val);
+}
+
+#if CONFIG_PGTABLE_LEVELS >= 4
+static inline pud_t __pud(pudval_t val)
+{
+	pudval_t ret;
+
+	if (sizeof(pudval_t) > sizeof(long))
+		ret = PVOP_CALLEE2(pudval_t, pvfull_mmu_ops.make_pud,
+				   val, (u64)val >> 32);
+	else
+		ret = PVOP_CALLEE1(pudval_t, pvfull_mmu_ops.make_pud,
+				   val);
+
+	return (pud_t) { ret };
+}
+
+static inline pudval_t pud_val(pud_t pud)
+{
+	pudval_t ret;
+
+	if (sizeof(pudval_t) > sizeof(long))
+		ret =  PVOP_CALLEE2(pudval_t, pvfull_mmu_ops.pud_val,
+				    pud.pud, (u64)pud.pud >> 32);
+	else
+		ret =  PVOP_CALLEE1(pudval_t, pvfull_mmu_ops.pud_val,
+				    pud.pud);
+
+	return ret;
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	set_pud(pudp, __pud(0));
+}
+
+static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
+{
+	p4dval_t val = native_p4d_val(p4d);
+
+	if (sizeof(p4dval_t) > sizeof(long))
+		PVOP_VCALL3(pvfull_mmu_ops.set_p4d, p4dp,
+			    val, (u64)val >> 32);
+	else
+		PVOP_VCALL2(pvfull_mmu_ops.set_p4d, p4dp,
+			    val);
+}
+
+#if CONFIG_PGTABLE_LEVELS >= 5
+static inline p4d_t __p4d(p4dval_t val)
+{
+	p4dval_t ret = PVOP_CALLEE1(p4dval_t, pvfull_mmu_ops.make_p4d, val);
+
+	return (p4d_t) { ret };
+}
+
+static inline p4dval_t p4d_val(p4d_t p4d)
+{
+	return PVOP_CALLEE1(p4dval_t, pvfull_mmu_ops.p4d_val, p4d.p4d);
+}
+
+static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	pgdval_t val = native_pgd_val(pgd);
+
+	PVOP_VCALL2(pvfull_mmu_ops.set_pgd, pgdp, val);
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	set_pgd(pgdp, __pgd(0));
+}
+
+#endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
+
+static inline void p4d_clear(p4d_t *p4dp)
+{
+	set_p4d(p4dp, __p4d(0));
+}
+
+#endif  /* CONFIG_PGTABLE_LEVELS >= 4 */
+
+#endif  /* CONFIG_PGTABLE_LEVELS >= 3 */
+
+#ifdef CONFIG_X86_PAE
+/* Special-case pte-setting operations for PAE, which can't update a
+   64-bit pte atomically */
+static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
+{
+	PVOP_VCALL3(pvfull_mmu_ops.set_pte_atomic, ptep,
+		    pte.pte, pte.pte >> 32);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep)
+{
+	PVOP_VCALL3(pvfull_mmu_ops.pte_clear, mm, addr, ptep);
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	PVOP_VCALL1(pvfull_mmu_ops.pmd_clear, pmdp);
+}
+#else  /* !CONFIG_X86_PAE */
+static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
+{
+	set_pte(ptep, pte);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep)
+{
+	set_pte_at(mm, addr, ptep, __pte(0));
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	set_pmd(pmdp, __pmd(0));
+}
+#endif  /* CONFIG_X86_PAE */
+
+#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+static inline void arch_enter_lazy_mmu_mode(void)
+{
+	PVOP_VCALL0(pvfull_mmu_ops.lazy_mode.enter);
+}
+
+static inline void arch_leave_lazy_mmu_mode(void)
+{
+	PVOP_VCALL0(pvfull_mmu_ops.lazy_mode.leave);
+}
+
+static inline void arch_flush_lazy_mmu_mode(void)
+{
+	PVOP_VCALL0(pvfull_mmu_ops.lazy_mode.flush);
+}
+
+static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
+				phys_addr_t phys, pgprot_t flags)
+{
+	pvfull_mmu_ops.set_fixmap(idx, phys, flags);
+}
+
 #else /* __ASSEMBLY__ */
 
 #define INTERRUPT_RETURN						\
@@ -284,6 +703,9 @@ static inline void halt(void)
 		  call PARA_INDIRECT(pvfull_irq_ops +			\
 				     PV_IRQ_adjust_exception_frame))
 
+#define GET_CR2_INTO_RAX						\
+	call PARA_INDIRECT(pvfull_mmu_ops+PV_MMU_read_cr2)
+
 #endif  /* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de95e6253516..b1ac2a5698b4 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -89,14 +89,6 @@ struct pv_init_ops {
 			  unsigned long addr, unsigned len);
 };
 
-
-struct pv_lazy_ops {
-	/* Set deferred update mode, used for batching operations. */
-	void (*enter)(void);
-	void (*leave)(void);
-	void (*flush)(void);
-};
-
 struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
 	unsigned long long (*steal_clock)(int cpu);
@@ -123,111 +115,11 @@ struct pv_irq_ops {
 };
 
 struct pv_mmu_ops {
-	unsigned long (*read_cr2)(void);
-	void (*write_cr2)(unsigned long);
-
-	unsigned long (*read_cr3)(void);
-	void (*write_cr3)(unsigned long);
-
-	/*
-	 * Hooks for intercepting the creation/use/destruction of an
-	 * mm_struct.
-	 */
-	void (*activate_mm)(struct mm_struct *prev,
-			    struct mm_struct *next);
-	void (*dup_mmap)(struct mm_struct *oldmm,
-			 struct mm_struct *mm);
 	void (*exit_mmap)(struct mm_struct *mm);
-
-
-	/* TLB operations */
-	void (*flush_tlb_user)(void);
-	void (*flush_tlb_kernel)(void);
-	void (*flush_tlb_single)(unsigned long addr);
 	void (*flush_tlb_others)(const struct cpumask *cpus,
 				 struct mm_struct *mm,
 				 unsigned long start,
 				 unsigned long end);
-
-	/* Hooks for allocating and freeing a pagetable top-level */
-	int  (*pgd_alloc)(struct mm_struct *mm);
-	void (*pgd_free)(struct mm_struct *mm, pgd_t *pgd);
-
-	/*
-	 * Hooks for allocating/releasing pagetable pages when they're
-	 * attached to a pagetable
-	 */
-	void (*alloc_pte)(struct mm_struct *mm, unsigned long pfn);
-	void (*alloc_pmd)(struct mm_struct *mm, unsigned long pfn);
-	void (*alloc_pud)(struct mm_struct *mm, unsigned long pfn);
-	void (*alloc_p4d)(struct mm_struct *mm, unsigned long pfn);
-	void (*release_pte)(unsigned long pfn);
-	void (*release_pmd)(unsigned long pfn);
-	void (*release_pud)(unsigned long pfn);
-	void (*release_p4d)(unsigned long pfn);
-
-	/* Pagetable manipulation functions */
-	void (*set_pte)(pte_t *ptep, pte_t pteval);
-	void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, pte_t pteval);
-	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
-	void (*set_pmd_at)(struct mm_struct *mm, unsigned long addr,
-			   pmd_t *pmdp, pmd_t pmdval);
-	void (*set_pud_at)(struct mm_struct *mm, unsigned long addr,
-			   pud_t *pudp, pud_t pudval);
-	void (*pte_update)(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep);
-
-	pte_t (*ptep_modify_prot_start)(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep);
-	void (*ptep_modify_prot_commit)(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, pte_t pte);
-
-	struct paravirt_callee_save pte_val;
-	struct paravirt_callee_save make_pte;
-
-	struct paravirt_callee_save pgd_val;
-	struct paravirt_callee_save make_pgd;
-
-#if CONFIG_PGTABLE_LEVELS >= 3
-#ifdef CONFIG_X86_PAE
-	void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
-	void (*pte_clear)(struct mm_struct *mm, unsigned long addr,
-			  pte_t *ptep);
-	void (*pmd_clear)(pmd_t *pmdp);
-
-#endif	/* CONFIG_X86_PAE */
-
-	void (*set_pud)(pud_t *pudp, pud_t pudval);
-
-	struct paravirt_callee_save pmd_val;
-	struct paravirt_callee_save make_pmd;
-
-#if CONFIG_PGTABLE_LEVELS >= 4
-	struct paravirt_callee_save pud_val;
-	struct paravirt_callee_save make_pud;
-
-	void (*set_p4d)(p4d_t *p4dp, p4d_t p4dval);
-
-#if CONFIG_PGTABLE_LEVELS >= 5
-	struct paravirt_callee_save p4d_val;
-	struct paravirt_callee_save make_p4d;
-
-	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
-#endif	/* CONFIG_PGTABLE_LEVELS >= 5 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 4 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 3 */
-
-	struct pv_lazy_ops lazy_mode;
-
-	/* dom0 ops */
-
-	/* Sometimes the physical address is a pfn, and sometimes its
-	   an mfn.  We can tell which is which from the index. */
-	void (*set_fixmap)(unsigned /* enum fixed_addresses */ idx,
-			   phys_addr_t phys, pgprot_t flags);
 };
 
 struct arch_spinlock;
@@ -260,6 +152,7 @@ struct paravirt_patch_template {
 #ifdef CONFIG_PARAVIRT_FULL
 	struct pvfull_cpu_ops pvfull_cpu_ops;
 	struct pvfull_irq_ops pvfull_irq_ops;
+	struct pvfull_mmu_ops pvfull_mmu_ops;
 #endif
 };
 
@@ -599,14 +492,6 @@ enum paravirt_lazy_mode {
 	PARAVIRT_LAZY_CPU,
 };
 
-enum paravirt_lazy_mode paravirt_get_lazy_mode(void);
-void paravirt_start_context_switch(struct task_struct *prev);
-void paravirt_end_context_switch(struct task_struct *next);
-
-void paravirt_enter_lazy_mmu(void);
-void paravirt_leave_lazy_mmu(void);
-void paravirt_flush_lazy_mmu(void);
-
 void _paravirt_nop(void);
 u32 _paravirt_ident_32(u32);
 u64 _paravirt_ident_64(u64);
diff --git a/arch/x86/include/asm/paravirt_types_full.h b/arch/x86/include/asm/paravirt_types_full.h
index eabc0ecec8e4..15d595a5f9d2 100644
--- a/arch/x86/include/asm/paravirt_types_full.h
+++ b/arch/x86/include/asm/paravirt_types_full.h
@@ -1,6 +1,13 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_FULL_H
 #define _ASM_X86_PARAVIRT_TYPES_FULL_H
 
+struct pv_lazy_ops {
+	/* Set deferred update mode, used for batching operations. */
+	void (*enter)(void);
+	void (*leave)(void);
+	void (*flush)(void);
+};
+
 struct pvfull_cpu_ops {
 	/* hooks for various privileged instructions */
 	unsigned long (*get_debugreg)(int regno);
@@ -86,7 +93,116 @@ struct pvfull_irq_ops {
 #endif
 };
 
+struct pvfull_mmu_ops {
+	unsigned long (*read_cr2)(void);
+	void (*write_cr2)(unsigned long);
+
+	unsigned long (*read_cr3)(void);
+	void (*write_cr3)(unsigned long);
+
+	/*
+	 * Hooks for intercepting the creation/use/destruction of an
+	 * mm_struct.
+	 */
+	void (*activate_mm)(struct mm_struct *prev,
+			    struct mm_struct *next);
+	void (*dup_mmap)(struct mm_struct *oldmm,
+			 struct mm_struct *mm);
+
+	/* TLB operations */
+	void (*flush_tlb_user)(void);
+	void (*flush_tlb_kernel)(void);
+	void (*flush_tlb_single)(unsigned long addr);
+
+	/* Hooks for allocating and freeing a pagetable top-level */
+	int  (*pgd_alloc)(struct mm_struct *mm);
+	void (*pgd_free)(struct mm_struct *mm, pgd_t *pgd);
+
+	/*
+	 * Hooks for allocating/releasing pagetable pages when they're
+	 * attached to a pagetable
+	 */
+	void (*alloc_pte)(struct mm_struct *mm, unsigned long pfn);
+	void (*alloc_pmd)(struct mm_struct *mm, unsigned long pfn);
+	void (*alloc_pud)(struct mm_struct *mm, unsigned long pfn);
+	void (*alloc_p4d)(struct mm_struct *mm, unsigned long pfn);
+	void (*release_pte)(unsigned long pfn);
+	void (*release_pmd)(unsigned long pfn);
+	void (*release_pud)(unsigned long pfn);
+	void (*release_p4d)(unsigned long pfn);
+
+	/* Pagetable manipulation functions */
+	void (*set_pte)(pte_t *ptep, pte_t pteval);
+	void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pteval);
+	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
+	void (*set_pmd_at)(struct mm_struct *mm, unsigned long addr,
+			   pmd_t *pmdp, pmd_t pmdval);
+	void (*set_pud_at)(struct mm_struct *mm, unsigned long addr,
+			   pud_t *pudp, pud_t pudval);
+	void (*pte_update)(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep);
+
+	pte_t (*ptep_modify_prot_start)(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep);
+	void (*ptep_modify_prot_commit)(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, pte_t pte);
+
+	struct paravirt_callee_save pte_val;
+	struct paravirt_callee_save make_pte;
+
+	struct paravirt_callee_save pgd_val;
+	struct paravirt_callee_save make_pgd;
+
+#if CONFIG_PGTABLE_LEVELS >= 3
+#ifdef CONFIG_X86_PAE
+	void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
+	void (*pte_clear)(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep);
+	void (*pmd_clear)(pmd_t *pmdp);
+
+#endif  /* CONFIG_X86_PAE */
+
+	void (*set_pud)(pud_t *pudp, pud_t pudval);
+
+	struct paravirt_callee_save pmd_val;
+	struct paravirt_callee_save make_pmd;
+
+#if CONFIG_PGTABLE_LEVELS >= 4
+	struct paravirt_callee_save pud_val;
+	struct paravirt_callee_save make_pud;
+
+	void (*set_p4d)(p4d_t *p4dp, p4d_t p4dval);
+
+#if CONFIG_PGTABLE_LEVELS >= 5
+	struct paravirt_callee_save p4d_val;
+	struct paravirt_callee_save make_p4d;
+
+	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
+#endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
+
+#endif  /* CONFIG_PGTABLE_LEVELS >= 4 */
+
+#endif  /* CONFIG_PGTABLE_LEVELS >= 3 */
+
+	struct pv_lazy_ops lazy_mode;
+
+	/* Sometimes the physical address is a pfn, and sometimes its
+	   an mfn.  We can tell which is which from the index. */
+	void (*set_fixmap)(unsigned /* enum fixed_addresses */ idx,
+			   phys_addr_t phys, pgprot_t flags);
+};
+
 extern struct pvfull_cpu_ops pvfull_cpu_ops;
 extern struct pvfull_irq_ops pvfull_irq_ops;
+extern struct pvfull_mmu_ops pvfull_mmu_ops;
+
+enum paravirt_lazy_mode paravirt_get_lazy_mode(void);
+void paravirt_start_context_switch(struct task_struct *prev);
+void paravirt_end_context_switch(struct task_struct *next);
+
+void paravirt_enter_lazy_mmu(void);
+void paravirt_leave_lazy_mmu(void);
+void paravirt_flush_lazy_mmu(void);
 
 #endif  /* _ASM_X86_PARAVIRT_TYPES_FULL_H */
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 71de65bb1791..5cff39bd7f6d 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -7,7 +7,7 @@
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define paravirt_pgd_alloc(mm)	__paravirt_pgd_alloc(mm)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index fad12c481bf9..60c8f2ac7fee 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -38,9 +38,9 @@ extern struct list_head pgd_list;
 
 extern struct mm_struct *pgd_page_get_mm(struct page *page);
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
-#else  /* !CONFIG_PARAVIRT */
+#else  /* !CONFIG_PARAVIRT_FULL */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
 #define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
 #define set_pmd_at(mm, addr, pmdp, pmd)	native_set_pmd_at(mm, addr, pmdp, pmd)
@@ -98,10 +98,6 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 #define pte_val(x)	native_pte_val(x)
 #define __pte(x)	native_make_pte(x)
 
-#endif	/* CONFIG_PARAVIRT */
-
-#ifndef CONFIG_PARAVIRT_FULL
-
 #define arch_end_context_switch(prev)	do {} while (0)
 
 #endif  /* CONFIG_PARAVIRT_FULL */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index ca3a3103791d..1ad38e40a770 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -135,7 +135,7 @@ static inline void native_wbinvd(void)
 
 extern asmlinkage void native_load_gs_index(unsigned);
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 
@@ -159,10 +159,6 @@ static inline void write_cr3(unsigned long x)
 	native_write_cr3(x);
 }
 
-#endif/* CONFIG_PARAVIRT */
-
-#ifndef CONFIG_PARAVIRT_FULL
-
 static inline unsigned long read_cr0(void)
 {
 	return native_read_cr0();
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6ed9ea469b48..6b0b6a1f231f 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -56,7 +56,7 @@ static inline void invpcid_flush_all_nonglobals(void)
 	__invpcid(0, 0, INVPCID_TYPE_ALL_NON_GLOBAL);
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/paravirt.h>
 #else
 #define __flush_tlb() __native_flush_tlb()
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index a32148390e49..18a5c06c007a 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -67,15 +67,17 @@ void common(void) {
 	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
 	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
 	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
-	OFFSET(PV_MMU_read_cr2, pv_mmu_ops, read_cr2);
 #endif
 #ifdef CONFIG_PARAVIRT_FULL
 	OFFSET(PARAVIRT_PATCH_pvfull_cpu_ops, paravirt_patch_template,
 	       pvfull_cpu_ops);
 	OFFSET(PARAVIRT_PATCH_pvfull_irq_ops, paravirt_patch_template,
 	       pvfull_irq_ops);
+	OFFSET(PARAVIRT_PATCH_pvfull_mmu_ops, paravirt_patch_template,
+	       pvfull_mmu_ops);
 	OFFSET(PV_CPU_iret, pvfull_cpu_ops, iret);
 	OFFSET(PV_CPU_read_cr0, pvfull_cpu_ops, read_cr0);
+	OFFSET(PV_MMU_read_cr2, pvfull_mmu_ops, read_cr2);
 #endif
 
 #ifdef CONFIG_XEN
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index ac9d327d2e42..f004edaf0d1f 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,7 +23,7 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_FULL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
 #define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 8e22cfc73349..6fb642572bff 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -28,12 +28,9 @@
 #include <asm/bug.h>
 #include <asm/paravirt.h>
 #include <asm/setup.h>
-#include <asm/pgtable.h>
 #include <asm/time.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
-#include <asm/fixmap.h>
 #include <asm/apic.h>
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
@@ -179,25 +176,6 @@ unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
 	return insn_len;
 }
 
-static void native_flush_tlb(void)
-{
-	__native_flush_tlb();
-}
-
-/*
- * Global pages have to be flushed a bit differently. Not a real
- * performance problem because this does not happen often.
- */
-static void native_flush_tlb_global(void)
-{
-	__native_flush_tlb_global();
-}
-
-static void native_flush_tlb_single(unsigned long addr)
-{
-	__native_flush_tlb_single(addr);
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -206,73 +184,6 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
-static DEFINE_PER_CPU(enum paravirt_lazy_mode, paravirt_lazy_mode) = PARAVIRT_LAZY_NONE;
-
-static inline void enter_lazy(enum paravirt_lazy_mode mode)
-{
-	BUG_ON(this_cpu_read(paravirt_lazy_mode) != PARAVIRT_LAZY_NONE);
-
-	this_cpu_write(paravirt_lazy_mode, mode);
-}
-
-static void leave_lazy(enum paravirt_lazy_mode mode)
-{
-	BUG_ON(this_cpu_read(paravirt_lazy_mode) != mode);
-
-	this_cpu_write(paravirt_lazy_mode, PARAVIRT_LAZY_NONE);
-}
-
-void paravirt_enter_lazy_mmu(void)
-{
-	enter_lazy(PARAVIRT_LAZY_MMU);
-}
-
-void paravirt_leave_lazy_mmu(void)
-{
-	leave_lazy(PARAVIRT_LAZY_MMU);
-}
-
-void paravirt_flush_lazy_mmu(void)
-{
-	preempt_disable();
-
-	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_MMU) {
-		arch_leave_lazy_mmu_mode();
-		arch_enter_lazy_mmu_mode();
-	}
-
-	preempt_enable();
-}
-
-void paravirt_start_context_switch(struct task_struct *prev)
-{
-	BUG_ON(preemptible());
-
-	if (this_cpu_read(paravirt_lazy_mode) == PARAVIRT_LAZY_MMU) {
-		arch_leave_lazy_mmu_mode();
-		set_ti_thread_flag(task_thread_info(prev), TIF_LAZY_MMU_UPDATES);
-	}
-	enter_lazy(PARAVIRT_LAZY_CPU);
-}
-
-void paravirt_end_context_switch(struct task_struct *next)
-{
-	BUG_ON(preemptible());
-
-	leave_lazy(PARAVIRT_LAZY_CPU);
-
-	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDATES))
-		arch_enter_lazy_mmu_mode();
-}
-
-enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
-{
-	if (in_interrupt())
-		return PARAVIRT_LAZY_NONE;
-
-	return this_cpu_read(paravirt_lazy_mode);
-}
-
 struct pv_info pv_info = {
 	.name = "bare hardware",
 	.kernel_rpl = 0,
@@ -303,91 +214,9 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 	.io_delay = native_io_delay,
 };
 
-#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
-/* 32-bit pagetable entries */
-#define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_32)
-#else
-/* 64-bit pagetable entries */
-#define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
-#endif
-
 struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
-
-	.read_cr2 = native_read_cr2,
-	.write_cr2 = native_write_cr2,
-	.read_cr3 = native_read_cr3,
-	.write_cr3 = native_write_cr3,
-
-	.flush_tlb_user = native_flush_tlb,
-	.flush_tlb_kernel = native_flush_tlb_global,
-	.flush_tlb_single = native_flush_tlb_single,
 	.flush_tlb_others = native_flush_tlb_others,
-
-	.pgd_alloc = __paravirt_pgd_alloc,
-	.pgd_free = paravirt_nop,
-
-	.alloc_pte = paravirt_nop,
-	.alloc_pmd = paravirt_nop,
-	.alloc_pud = paravirt_nop,
-	.alloc_p4d = paravirt_nop,
-	.release_pte = paravirt_nop,
-	.release_pmd = paravirt_nop,
-	.release_pud = paravirt_nop,
-	.release_p4d = paravirt_nop,
-
-	.set_pte = native_set_pte,
-	.set_pte_at = native_set_pte_at,
-	.set_pmd = native_set_pmd,
-	.set_pmd_at = native_set_pmd_at,
-	.pte_update = paravirt_nop,
-
-	.ptep_modify_prot_start = __ptep_modify_prot_start,
-	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
-
-#if CONFIG_PGTABLE_LEVELS >= 3
-#ifdef CONFIG_X86_PAE
-	.set_pte_atomic = native_set_pte_atomic,
-	.pte_clear = native_pte_clear,
-	.pmd_clear = native_pmd_clear,
-#endif
-	.set_pud = native_set_pud,
-	.set_pud_at = native_set_pud_at,
-
-	.pmd_val = PTE_IDENT,
-	.make_pmd = PTE_IDENT,
-
-#if CONFIG_PGTABLE_LEVELS >= 4
-	.pud_val = PTE_IDENT,
-	.make_pud = PTE_IDENT,
-
-	.set_p4d = native_set_p4d,
-
-#if CONFIG_PGTABLE_LEVELS >= 5
-	.p4d_val = PTE_IDENT,
-	.make_p4d = PTE_IDENT,
-
-	.set_pgd = native_set_pgd,
-#endif /* CONFIG_PGTABLE_LEVELS >= 5 */
-#endif /* CONFIG_PGTABLE_LEVELS >= 4 */
-#endif /* CONFIG_PGTABLE_LEVELS >= 3 */
-
-	.pte_val = PTE_IDENT,
-	.pgd_val = PTE_IDENT,
-
-	.make_pte = PTE_IDENT,
-	.make_pgd = PTE_IDENT,
-
-	.dup_mmap = paravirt_nop,
 	.exit_mmap = paravirt_nop,
-	.activate_mm = paravirt_nop,
-
-	.lazy_mode = {
-		.enter = paravirt_nop,
-		.leave = paravirt_nop,
-		.flush = paravirt_nop,
-	},
-
-	.set_fixmap = native_set_fixmap,
 };
 
 EXPORT_SYMBOL_GPL(pv_time_ops);
diff --git a/arch/x86/kernel/paravirt_full.c b/arch/x86/kernel/paravirt_full.c
index 353968da3ddc..b90dfa7428bd 100644
--- a/arch/x86/kernel/paravirt_full.c
+++ b/arch/x86/kernel/paravirt_full.c
@@ -19,12 +19,103 @@
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
 #include <asm/desc.h>
+#include <asm/pgalloc.h>
 #include <asm/processor.h>
+#include <asm/tlbflush.h>
 
 /* These are in entry.S */
 extern void native_iret(void);
 extern void native_usergs_sysret64(void);
 
+static DEFINE_PER_CPU(enum paravirt_lazy_mode, paravirt_lazy_mode) =
+	PARAVIRT_LAZY_NONE;
+
+static inline void enter_lazy(enum paravirt_lazy_mode mode)
+{
+	BUG_ON(this_cpu_read(paravirt_lazy_mode) != PARAVIRT_LAZY_NONE);
+
+	this_cpu_write(paravirt_lazy_mode, mode);
+}
+
+static void leave_lazy(enum paravirt_lazy_mode mode)
+{
+	BUG_ON(this_cpu_read(paravirt_lazy_mode) != mode);
+
+	this_cpu_write(paravirt_lazy_mode, PARAVIRT_LAZY_NONE);
+}
+
+void paravirt_enter_lazy_mmu(void)
+{
+	enter_lazy(PARAVIRT_LAZY_MMU);
+}
+
+void paravirt_leave_lazy_mmu(void)
+{
+	leave_lazy(PARAVIRT_LAZY_MMU);
+}
+
+void paravirt_flush_lazy_mmu(void)
+{
+	preempt_disable();
+
+	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_MMU) {
+		arch_leave_lazy_mmu_mode();
+		arch_enter_lazy_mmu_mode();
+	}
+
+	preempt_enable();
+}
+
+void paravirt_start_context_switch(struct task_struct *prev)
+{
+	BUG_ON(preemptible());
+
+	if (this_cpu_read(paravirt_lazy_mode) == PARAVIRT_LAZY_MMU) {
+		arch_leave_lazy_mmu_mode();
+		set_ti_thread_flag(task_thread_info(prev),
+				   TIF_LAZY_MMU_UPDATES);
+	}
+	enter_lazy(PARAVIRT_LAZY_CPU);
+}
+
+void paravirt_end_context_switch(struct task_struct *next)
+{
+	BUG_ON(preemptible());
+
+	leave_lazy(PARAVIRT_LAZY_CPU);
+
+	if (test_and_clear_ti_thread_flag(task_thread_info(next),
+					  TIF_LAZY_MMU_UPDATES))
+		arch_enter_lazy_mmu_mode();
+}
+
+enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
+{
+	if (in_interrupt())
+		return PARAVIRT_LAZY_NONE;
+
+	return this_cpu_read(paravirt_lazy_mode);
+}
+
+static void native_flush_tlb(void)
+{
+	__native_flush_tlb();
+}
+
+/*
+ * Global pages have to be flushed a bit differently. Not a real
+ * performance problem because this does not happen often.
+ */
+static void native_flush_tlb_global(void)
+{
+	__native_flush_tlb_global();
+}
+
+static void native_flush_tlb_single(unsigned long addr)
+{
+	__native_flush_tlb_single(addr);
+}
+
 __visible struct pvfull_cpu_ops pvfull_cpu_ops = {
 	.cpuid = native_cpuid,
 	.get_debugreg = native_get_debugreg,
@@ -82,6 +173,90 @@ __visible struct pvfull_irq_ops pvfull_irq_ops = {
 #endif
 };
 
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
+/* 32-bit pagetable entries */
+#define PTE_IDENT       __PV_IS_CALLEE_SAVE(_paravirt_ident_32)
+#else
+/* 64-bit pagetable entries */
+#define PTE_IDENT       __PV_IS_CALLEE_SAVE(_paravirt_ident_64)
+#endif
+
+struct pvfull_mmu_ops pvfull_mmu_ops = {
+	.read_cr2 = native_read_cr2,
+	.write_cr2 = native_write_cr2,
+	.read_cr3 = native_read_cr3,
+	.write_cr3 = native_write_cr3,
+
+	.flush_tlb_user = native_flush_tlb,
+	.flush_tlb_kernel = native_flush_tlb_global,
+	.flush_tlb_single = native_flush_tlb_single,
+
+	.pgd_alloc = __paravirt_pgd_alloc,
+	.pgd_free = paravirt_nop,
+
+	.alloc_pte = paravirt_nop,
+	.alloc_pmd = paravirt_nop,
+	.alloc_pud = paravirt_nop,
+	.alloc_p4d = paravirt_nop,
+	.release_pte = paravirt_nop,
+	.release_pmd = paravirt_nop,
+	.release_pud = paravirt_nop,
+	.release_p4d = paravirt_nop,
+
+	.set_pte = native_set_pte,
+	.set_pte_at = native_set_pte_at,
+	.set_pmd = native_set_pmd,
+	.set_pmd_at = native_set_pmd_at,
+	.pte_update = paravirt_nop,
+
+	.ptep_modify_prot_start = __ptep_modify_prot_start,
+	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+
+#if CONFIG_PGTABLE_LEVELS >= 3
+#ifdef CONFIG_X86_PAE
+	.set_pte_atomic = native_set_pte_atomic,
+	.pte_clear = native_pte_clear,
+	.pmd_clear = native_pmd_clear,
+#endif
+	.set_pud = native_set_pud,
+	.set_pud_at = native_set_pud_at,
+
+	.pmd_val = PTE_IDENT,
+	.make_pmd = PTE_IDENT,
+
+#if CONFIG_PGTABLE_LEVELS >= 4
+	.pud_val = PTE_IDENT,
+	.make_pud = PTE_IDENT,
+
+	.set_p4d = native_set_p4d,
+
+#if CONFIG_PGTABLE_LEVELS >= 5
+	.p4d_val = PTE_IDENT,
+	.make_p4d = PTE_IDENT,
+
+	.set_pgd = native_set_pgd,
+#endif /* CONFIG_PGTABLE_LEVELS >= 5 */
+#endif /* CONFIG_PGTABLE_LEVELS >= 4 */
+#endif /* CONFIG_PGTABLE_LEVELS >= 3 */
+
+	.pte_val = PTE_IDENT,
+	.pgd_val = PTE_IDENT,
+
+	.make_pte = PTE_IDENT,
+	.make_pgd = PTE_IDENT,
+
+	.dup_mmap = paravirt_nop,
+	.activate_mm = paravirt_nop,
+
+	.lazy_mode = {
+		.enter = paravirt_nop,
+		.leave = paravirt_nop,
+		.flush = paravirt_nop,
+	},
+
+	.set_fixmap = native_set_fixmap,
+};
+
 /* At this point, native_get/set_debugreg has real function entries */
 NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
@@ -89,3 +264,4 @@ NOKPROBE_SYMBOL(native_load_idt);
 
 EXPORT_SYMBOL(pvfull_cpu_ops);
 EXPORT_SYMBOL_GPL(pvfull_irq_ops);
+EXPORT_SYMBOL(pvfull_mmu_ops);
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index ccb75951aed5..b5f93cb0d05f 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -4,10 +4,10 @@ DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
 DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
 DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
 DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
 #ifdef CONFIG_PARAVIRT_FULL
+DEF_NATIVE(pvfull_mmu_ops, read_cr2, "mov %cr2, %eax");
+DEF_NATIVE(pvfull_mmu_ops, write_cr3, "mov %eax, %cr3");
+DEF_NATIVE(pvfull_mmu_ops, read_cr3, "mov %cr3, %eax");
 DEF_NATIVE(pvfull_cpu_ops, iret, "iret");
 #endif
 
@@ -47,10 +47,10 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_irq_ops, irq_enable);
 		PATCH_SITE(pv_irq_ops, restore_fl);
 		PATCH_SITE(pv_irq_ops, save_fl);
-		PATCH_SITE(pv_mmu_ops, read_cr2);
-		PATCH_SITE(pv_mmu_ops, read_cr3);
-		PATCH_SITE(pv_mmu_ops, write_cr3);
 #ifdef CONFIG_PARAVIRT_FULL
+		PATCH_SITE(pvfull_mmu_ops, read_cr2);
+		PATCH_SITE(pvfull_mmu_ops, read_cr3);
+		PATCH_SITE(pvfull_mmu_ops, write_cr3);
 		PATCH_SITE(pvfull_cpu_ops, iret);
 #endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 00d5c77d23a7..473688054f0b 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -6,15 +6,15 @@ DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
 DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
 DEF_NATIVE(pv_irq_ops, restore_fl, "pushq %rdi; popfq");
 DEF_NATIVE(pv_irq_ops, save_fl, "pushfq; popq %rax");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
-DEF_NATIVE(pv_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
 #ifdef CONFIG_PARAVIRT_FULL
+DEF_NATIVE(pvfull_mmu_ops, read_cr2, "movq %cr2, %rax");
+DEF_NATIVE(pvfull_mmu_ops, read_cr3, "movq %cr3, %rax");
+DEF_NATIVE(pvfull_mmu_ops, write_cr3, "movq %rdi, %cr3");
+DEF_NATIVE(pvfull_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
 DEF_NATIVE(pvfull_cpu_ops, wbinvd, "wbinvd");
 DEF_NATIVE(pvfull_cpu_ops, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(pvfull_cpu_ops, swapgs, "swapgs");
@@ -56,11 +56,11 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_irq_ops, save_fl);
 		PATCH_SITE(pv_irq_ops, irq_enable);
 		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_mmu_ops, read_cr2);
-		PATCH_SITE(pv_mmu_ops, read_cr3);
-		PATCH_SITE(pv_mmu_ops, write_cr3);
-		PATCH_SITE(pv_mmu_ops, flush_tlb_single);
 #ifdef CONFIG_PARAVIRT_FULL
+		PATCH_SITE(pvfull_mmu_ops, read_cr2);
+		PATCH_SITE(pvfull_mmu_ops, read_cr3);
+		PATCH_SITE(pvfull_mmu_ops, write_cr3);
+		PATCH_SITE(pvfull_mmu_ops, flush_tlb_single);
 		PATCH_SITE(pvfull_cpu_ops, usergs_sysret64);
 		PATCH_SITE(pvfull_cpu_ops, swapgs);
 		PATCH_SITE(pvfull_cpu_ops, wbinvd);
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index bf8773854ab0..b9757853cf79 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -753,7 +753,7 @@ static void lguest_pmd_clear(pmd_t *pmdp)
 #endif
 
 /*
- * Unfortunately for Lguest, the pv_mmu_ops for page tables were based on
+ * Unfortunately for Lguest, the pvfull_mmu_ops for page tables were based on
  * native page table operations.  On native hardware you can set a new page
  * table entry whenever you want, but if you want to remove one you have to do
  * a TLB flush (a TLB is a little cache of page table entries kept by the CPU).
@@ -1431,25 +1431,25 @@ __init void lguest_init(void)
 	pvfull_cpu_ops.end_context_switch = lguest_end_context_switch;
 
 	/* Pagetable management */
-	pv_mmu_ops.write_cr3 = lguest_write_cr3;
-	pv_mmu_ops.flush_tlb_user = lguest_flush_tlb_user;
-	pv_mmu_ops.flush_tlb_single = lguest_flush_tlb_single;
-	pv_mmu_ops.flush_tlb_kernel = lguest_flush_tlb_kernel;
-	pv_mmu_ops.set_pte = lguest_set_pte;
-	pv_mmu_ops.set_pte_at = lguest_set_pte_at;
-	pv_mmu_ops.set_pmd = lguest_set_pmd;
+	pvfull_mmu_ops.write_cr3 = lguest_write_cr3;
+	pvfull_mmu_ops.flush_tlb_user = lguest_flush_tlb_user;
+	pvfull_mmu_ops.flush_tlb_single = lguest_flush_tlb_single;
+	pvfull_mmu_ops.flush_tlb_kernel = lguest_flush_tlb_kernel;
+	pvfull_mmu_ops.set_pte = lguest_set_pte;
+	pvfull_mmu_ops.set_pte_at = lguest_set_pte_at;
+	pvfull_mmu_ops.set_pmd = lguest_set_pmd;
 #ifdef CONFIG_X86_PAE
-	pv_mmu_ops.set_pte_atomic = lguest_set_pte_atomic;
-	pv_mmu_ops.pte_clear = lguest_pte_clear;
-	pv_mmu_ops.pmd_clear = lguest_pmd_clear;
-	pv_mmu_ops.set_pud = lguest_set_pud;
+	pvfull_mmu_ops.set_pte_atomic = lguest_set_pte_atomic;
+	pvfull_mmu_ops.pte_clear = lguest_pte_clear;
+	pvfull_mmu_ops.pmd_clear = lguest_pmd_clear;
+	pvfull_mmu_ops.set_pud = lguest_set_pud;
 #endif
-	pv_mmu_ops.read_cr2 = lguest_read_cr2;
-	pv_mmu_ops.read_cr3 = lguest_read_cr3;
-	pv_mmu_ops.lazy_mode.enter = paravirt_enter_lazy_mmu;
-	pv_mmu_ops.lazy_mode.leave = lguest_leave_lazy_mmu_mode;
-	pv_mmu_ops.lazy_mode.flush = paravirt_flush_lazy_mmu;
-	pv_mmu_ops.pte_update = lguest_pte_update;
+	pvfull_mmu_ops.read_cr2 = lguest_read_cr2;
+	pvfull_mmu_ops.read_cr3 = lguest_read_cr3;
+	pvfull_mmu_ops.lazy_mode.enter = paravirt_enter_lazy_mmu;
+	pvfull_mmu_ops.lazy_mode.leave = lguest_leave_lazy_mmu_mode;
+	pvfull_mmu_ops.lazy_mode.flush = paravirt_flush_lazy_mmu;
+	pvfull_mmu_ops.pte_update = lguest_pte_update;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/* APIC read/write intercepts */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 89cd5cc5f1a2..9badad9f82e0 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1002,7 +1002,7 @@ void xen_setup_vcpu_info_placement(void)
 		pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
 		pv_irq_ops.irq_disable = __PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_mmu_ops.read_cr2 = xen_read_cr2_direct;
+		pvfull_mmu_ops.read_cr2 = xen_read_cr2_direct;
 	}
 }
 
@@ -1316,8 +1316,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 #endif
 
 	if (xen_feature(XENFEAT_mmu_pt_update_preserve_ad)) {
-		pv_mmu_ops.ptep_modify_prot_start = xen_ptep_modify_prot_start;
-		pv_mmu_ops.ptep_modify_prot_commit = xen_ptep_modify_prot_commit;
+		pvfull_mmu_ops.ptep_modify_prot_start =
+			xen_ptep_modify_prot_start;
+		pvfull_mmu_ops.ptep_modify_prot_commit =
+			xen_ptep_modify_prot_commit;
 	}
 
 	machine_ops = xen_machine_ops;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 7397d8b8459d..7be3e21a4dac 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2252,7 +2252,7 @@ static void __init xen_write_cr3_init(unsigned long cr3)
 	set_page_prot(initial_page_table, PAGE_KERNEL);
 	set_page_prot(initial_kernel_pmd, PAGE_KERNEL);
 
-	pv_mmu_ops.write_cr3 = &xen_write_cr3;
+	pvfull_mmu_ops.write_cr3 = &xen_write_cr3;
 }
 
 /*
@@ -2406,27 +2406,27 @@ static void __init xen_post_allocator_init(void)
 	if (xen_feature(XENFEAT_auto_translated_physmap))
 		return;
 
-	pv_mmu_ops.set_pte = xen_set_pte;
-	pv_mmu_ops.set_pmd = xen_set_pmd;
-	pv_mmu_ops.set_pud = xen_set_pud;
+	pvfull_mmu_ops.set_pte = xen_set_pte;
+	pvfull_mmu_ops.set_pmd = xen_set_pmd;
+	pvfull_mmu_ops.set_pud = xen_set_pud;
 #if CONFIG_PGTABLE_LEVELS >= 4
-	pv_mmu_ops.set_p4d = xen_set_p4d;
+	pvfull_mmu_ops.set_p4d = xen_set_p4d;
 #endif
 
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
-	pv_mmu_ops.alloc_pte = xen_alloc_pte;
-	pv_mmu_ops.alloc_pmd = xen_alloc_pmd;
-	pv_mmu_ops.release_pte = xen_release_pte;
-	pv_mmu_ops.release_pmd = xen_release_pmd;
+	pvfull_mmu_ops.alloc_pte = xen_alloc_pte;
+	pvfull_mmu_ops.alloc_pmd = xen_alloc_pmd;
+	pvfull_mmu_ops.release_pte = xen_release_pte;
+	pvfull_mmu_ops.release_pmd = xen_release_pmd;
 #if CONFIG_PGTABLE_LEVELS >= 4
-	pv_mmu_ops.alloc_pud = xen_alloc_pud;
-	pv_mmu_ops.release_pud = xen_release_pud;
+	pvfull_mmu_ops.alloc_pud = xen_alloc_pud;
+	pvfull_mmu_ops.release_pud = xen_release_pud;
 #endif
-	pv_mmu_ops.make_pte = PV_CALLEE_SAVE(xen_make_pte);
+	pvfull_mmu_ops.make_pte = PV_CALLEE_SAVE(xen_make_pte);
 
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.write_cr3 = &xen_write_cr3;
+	pvfull_mmu_ops.write_cr3 = &xen_write_cr3;
 	SetPagePinned(virt_to_page(level3_user_vsyscall));
 #endif
 	xen_mark_init_mm_pinned();
@@ -2440,7 +2440,7 @@ static void xen_leave_lazy_mmu(void)
 	preempt_enable();
 }
 
-static const struct pv_mmu_ops xen_mmu_ops __initconst = {
+static const struct pvfull_mmu_ops xen_mmu_ops __initconst = {
 	.read_cr2 = xen_read_cr2,
 	.write_cr2 = xen_write_cr2,
 
@@ -2450,7 +2450,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.flush_tlb_user = xen_flush_tlb,
 	.flush_tlb_kernel = xen_flush_tlb,
 	.flush_tlb_single = xen_flush_tlb_single,
-	.flush_tlb_others = xen_flush_tlb_others,
 
 	.pte_update = paravirt_nop,
 
@@ -2496,7 +2495,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 
 	.activate_mm = xen_activate_mm,
 	.dup_mmap = xen_dup_mmap,
-	.exit_mmap = xen_exit_mmap,
 
 	.lazy_mode = {
 		.enter = paravirt_enter_lazy_mmu,
@@ -2514,7 +2512,9 @@ void __init xen_init_mmu_ops(void)
 	if (xen_feature(XENFEAT_auto_translated_physmap))
 		return;
 
-	pv_mmu_ops = xen_mmu_ops;
+	pvfull_mmu_ops = xen_mmu_ops;
+	pv_mmu_ops.flush_tlb_others = xen_flush_tlb_others;
+	pv_mmu_ops.exit_mmap = xen_exit_mmap;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
-- 
2.12.0
