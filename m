From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/paravirt: remove no longer used paravirt functions
Date: Mon,  4 Sep 2017 12:25:27 +0200
Message-ID: <20170904102527.25409-1-jgross__45795.4954276376$1504520812$gmane$org@suse.com>
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
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

With removal of lguest some of the paravirt functions are no longer
needed. Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/desc.h           |  3 +--
 arch/x86/include/asm/paravirt.h       | 37 -----------------------------------
 arch/x86/include/asm/paravirt_types.h |  9 ---------
 arch/x86/include/asm/pgtable.h        | 27 ++++---------------------
 arch/x86/include/asm/special_insns.h  | 10 +++++-----
 arch/x86/kernel/paravirt.c            |  5 -----
 arch/x86/kvm/vmx.c                    |  2 +-
 arch/x86/mm/pgtable.c                 |  7 +------
 arch/x86/xen/enlighten_pv.c           |  2 --
 arch/x86/xen/mmu_pv.c                 |  2 --
 10 files changed, 12 insertions(+), 92 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index d0a21b12dd58..f6630e73843c 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -128,7 +128,6 @@ static inline int desc_empty(const void *ptr)
 #define load_ldt(ldt)				asm volatile("lldt %0"::"m" (ldt))
 
 #define store_gdt(dtr)				native_store_gdt(dtr)
-#define store_idt(dtr)				native_store_idt(dtr)
 #define store_tr(tr)				(tr = native_store_tr())
 
 #define load_TLS(t, cpu)			native_load_tls(t, cpu)
@@ -248,7 +247,7 @@ static inline void native_store_gdt(struct desc_ptr *dtr)
 	asm volatile("sgdt %0":"=m" (*dtr));
 }
 
-static inline void native_store_idt(struct desc_ptr *dtr)
+static inline void store_idt(struct desc_ptr *dtr)
 {
 	asm volatile("sidt %0":"=m" (*dtr));
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 9ccac1926587..c5e3e4d6ac16 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -71,11 +71,6 @@ static inline void write_cr3(unsigned long x)
 	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
 }
 
-static inline unsigned long __read_cr4(void)
-{
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr4);
-}
-
 static inline void __write_cr4(unsigned long x)
 {
 	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
@@ -228,10 +223,6 @@ static inline void set_ldt(const void *addr, unsigned entries)
 {
 	PVOP_VCALL2(pv_cpu_ops.set_ldt, addr, entries);
 }
-static inline void store_idt(struct desc_ptr *dtr)
-{
-	PVOP_VCALL1(pv_cpu_ops.store_idt, dtr);
-}
 static inline unsigned long paravirt_store_tr(void)
 {
 	return PVOP_CALL0(unsigned long, pv_cpu_ops.store_tr);
@@ -365,12 +356,6 @@ static inline void paravirt_release_p4d(unsigned long pfn)
 	PVOP_VCALL1(pv_mmu_ops.release_p4d, pfn);
 }
 
-static inline void pte_update(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
-{
-	PVOP_VCALL3(pv_mmu_ops.pte_update, mm, addr, ptep);
-}
-
 static inline pte_t __pte(pteval_t val)
 {
 	pteval_t ret;
@@ -472,28 +457,6 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 		PVOP_VCALL4(pv_mmu_ops.set_pte_at, mm, addr, ptep, pte.pte);
 }
 
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
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	pmdval_t val = native_pmd_val(pmd);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 9ffc36bfe4cd..680624a13c69 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -107,7 +107,6 @@ struct pv_cpu_ops {
 	unsigned long (*read_cr0)(void);
 	void (*write_cr0)(unsigned long);
 
-	unsigned long (*read_cr4)(void);
 	void (*write_cr4)(unsigned long);
 
 #ifdef CONFIG_X86_64
@@ -119,8 +118,6 @@ struct pv_cpu_ops {
 	void (*load_tr_desc)(void);
 	void (*load_gdt)(const struct desc_ptr *);
 	void (*load_idt)(const struct desc_ptr *);
-	/* store_gdt has been removed. */
-	void (*store_idt)(struct desc_ptr *);
 	void (*set_ldt)(const void *desc, unsigned entries);
 	unsigned long (*store_tr)(void);
 	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
@@ -248,12 +245,6 @@ struct pv_mmu_ops {
 	void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, pte_t pteval);
 	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
-	void (*set_pmd_at)(struct mm_struct *mm, unsigned long addr,
-			   pmd_t *pmdp, pmd_t pmdval);
-	void (*set_pud_at)(struct mm_struct *mm, unsigned long addr,
-			   pud_t *pudp, pud_t pudval);
-	void (*pte_update)(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep);
 
 	pte_t (*ptep_modify_prot_start)(struct mm_struct *mm, unsigned long addr,
 					pte_t *ptep);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 77037b6f1caa..bb8e9ea7deb4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -43,8 +43,6 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 #else  /* !CONFIG_PARAVIRT */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
 #define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
-#define set_pmd_at(mm, addr, pmdp, pmd)	native_set_pmd_at(mm, addr, pmdp, pmd)
-#define set_pud_at(mm, addr, pudp, pud)	native_set_pud_at(mm, addr, pudp, pud)
 
 #define set_pte_atomic(ptep, pte)					\
 	native_set_pte_atomic(ptep, pte)
@@ -75,8 +73,6 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 #define pte_clear(mm, addr, ptep)	native_pte_clear(mm, addr, ptep)
 #define pmd_clear(pmd)			native_pmd_clear(pmd)
 
-#define pte_update(mm, addr, ptep)              do { } while (0)
-
 #define pgd_val(x)	native_pgd_val(x)
 #define __pgd(x)	native_make_pgd(x)
 
@@ -965,31 +961,18 @@ static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
 	native_set_pte(ptep, pte);
 }
 
-static inline void native_set_pmd_at(struct mm_struct *mm, unsigned long addr,
-				     pmd_t *pmdp , pmd_t pmd)
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+			      pmd_t *pmdp, pmd_t pmd)
 {
 	native_set_pmd(pmdp, pmd);
 }
 
-static inline void native_set_pud_at(struct mm_struct *mm, unsigned long addr,
-				     pud_t *pudp, pud_t pud)
+static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
+			      pud_t *pudp, pud_t pud)
 {
 	native_set_pud(pudp, pud);
 }
 
-#ifndef CONFIG_PARAVIRT
-/*
- * Rules for using pte_update - it must be called after any PTE update which
- * has not been done using the set_pte / clear_pte interfaces.  It is used by
- * shadow mode hypervisors to resynchronize the shadow page tables.  Kernel PTE
- * updates should either be sets, clears, or set_pte_atomic for P->P
- * transitions, which means this hook should only be called for user PTEs.
- * This hook implies a P->P protection or access change has taken place, which
- * requires a subsequent TLB flush.
- */
-#define pte_update(mm, addr, ptep)		do { } while (0)
-#endif
-
 /*
  * We only update the dirty/accessed state if we set
  * the dirty bit by hand in the kernel, since the hardware
@@ -1017,7 +1000,6 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep)
 {
 	pte_t pte = native_ptep_get_and_clear(ptep);
-	pte_update(mm, addr, ptep);
 	return pte;
 }
 
@@ -1044,7 +1026,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
-	pte_update(mm, addr, ptep);
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 9efaabf5b54b..a24dfcf79f4a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -135,6 +135,11 @@ static inline void native_wbinvd(void)
 
 extern asmlinkage void native_load_gs_index(unsigned);
 
+static inline unsigned long __read_cr4(void)
+{
+	return native_read_cr4();
+}
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
@@ -173,11 +178,6 @@ static inline void write_cr3(unsigned long x)
 	native_write_cr3(x);
 }
 
-static inline unsigned long __read_cr4(void)
-{
-	return native_read_cr4();
-}
-
 static inline void __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index bc0a849589bb..0b338ec7e9d2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -330,7 +330,6 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 	.set_debugreg = native_set_debugreg,
 	.read_cr0 = native_read_cr0,
 	.write_cr0 = native_write_cr0,
-	.read_cr4 = native_read_cr4,
 	.write_cr4 = native_write_cr4,
 #ifdef CONFIG_X86_64
 	.read_cr8 = native_read_cr8,
@@ -346,7 +345,6 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 	.set_ldt = native_set_ldt,
 	.load_gdt = native_load_gdt,
 	.load_idt = native_load_idt,
-	.store_idt = native_store_idt,
 	.store_tr = native_store_tr,
 	.load_tls = native_load_tls,
 #ifdef CONFIG_X86_64
@@ -414,8 +412,6 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 	.set_pte = native_set_pte,
 	.set_pte_at = native_set_pte_at,
 	.set_pmd = native_set_pmd,
-	.set_pmd_at = native_set_pmd_at,
-	.pte_update = paravirt_nop,
 
 	.ptep_modify_prot_start = __ptep_modify_prot_start,
 	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
@@ -427,7 +423,6 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 	.pmd_clear = native_pmd_clear,
 #endif
 	.set_pud = native_set_pud,
-	.set_pud_at = native_set_pud_at,
 
 	.pmd_val = PTE_IDENT,
 	.make_pmd = PTE_IDENT,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c6ef2940119b..d7762e779952 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5163,7 +5163,7 @@ static void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	vmcs_write16(HOST_SS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
 	vmcs_write16(HOST_TR_SELECTOR, GDT_ENTRY_TSS*8);  /* 22.2.4 */
 
-	native_store_idt(&dt);
+	store_idt(&dt);
 	vmcs_writel(HOST_IDTR_BASE, dt.address);   /* 22.2.4 */
 	vmx->host_idt_base = dt.address;
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 508a708eb9a6..942391b5b639 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -426,10 +426,8 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	int changed = !pte_same(*ptep, entry);
 
-	if (changed && dirty) {
+	if (changed && dirty)
 		*ptep = entry;
-		pte_update(vma->vm_mm, address, ptep);
-	}
 
 	return changed;
 }
@@ -486,9 +484,6 @@ int ptep_test_and_clear_young(struct vm_area_struct *vma,
 		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
 					 (unsigned long *) &ptep->pte);
 
-	if (ret)
-		pte_update(vma->vm_mm, addr, ptep);
-
 	return ret;
 }
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 811e4ddb3f37..a204a95200d3 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1056,7 +1056,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.read_cr0 = xen_read_cr0,
 	.write_cr0 = xen_write_cr0,
 
-	.read_cr4 = native_read_cr4,
 	.write_cr4 = xen_write_cr4,
 
 #ifdef CONFIG_X86_64
@@ -1091,7 +1090,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.alloc_ldt = xen_alloc_ldt,
 	.free_ldt = xen_free_ldt,
 
-	.store_idt = native_store_idt,
 	.store_tr = xen_store_tr,
 
 	.write_ldt_entry = xen_write_ldt_entry,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index cab28cf2cffb..5f61b7e2e6b2 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2430,8 +2430,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.flush_tlb_single = xen_flush_tlb_single,
 	.flush_tlb_others = xen_flush_tlb_others,
 
-	.pte_update = paravirt_nop,
-
 	.pgd_alloc = xen_pgd_alloc,
 	.pgd_free = xen_pgd_free,
 
-- 
2.12.3
