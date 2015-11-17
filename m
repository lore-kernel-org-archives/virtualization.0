From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] paravirt: remove paravirt ops pmd_update_defer and
	pte_update_defer
Date: Tue, 17 Nov 2015 15:46:43 +0100
Message-ID: <1447771603-9918-1-git-send-email-jgross@suse.com>
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

pte_update_defer can be removed as it is always set to the same
function as pte_update. So any usage of pte_update_defer() can be
replaced by pte_update().

pmd_update_defer is always set to paravirt_nop, so it can just be
nuked.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       | 12 ------------
 arch/x86/include/asm/paravirt_types.h |  4 ----
 arch/x86/include/asm/pgtable.h        |  9 +--------
 arch/x86/kernel/paravirt.c            |  2 --
 arch/x86/lguest/boot.c                |  1 -
 arch/x86/mm/pgtable.c                 |  3 +--
 arch/x86/xen/mmu.c                    |  1 -
 7 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 10d0596..10c39b9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -381,18 +381,6 @@ static inline void pmd_update(struct mm_struct *mm, unsigned long addr,
 	PVOP_VCALL3(pv_mmu_ops.pmd_update, mm, addr, pmdp);
 }
 
-static inline void pte_update_defer(struct mm_struct *mm, unsigned long addr,
-				    pte_t *ptep)
-{
-	PVOP_VCALL3(pv_mmu_ops.pte_update_defer, mm, addr, ptep);
-}
-
-static inline void pmd_update_defer(struct mm_struct *mm, unsigned long addr,
-				    pmd_t *pmdp)
-{
-	PVOP_VCALL3(pv_mmu_ops.pmd_update_defer, mm, addr, pmdp);
-}
-
 static inline pte_t __pte(pteval_t val)
 {
 	pteval_t ret;
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 31247b5..274727e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -274,12 +274,8 @@ struct pv_mmu_ops {
 			   pmd_t *pmdp, pmd_t pmdval);
 	void (*pte_update)(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep);
-	void (*pte_update_defer)(struct mm_struct *mm,
-				 unsigned long addr, pte_t *ptep);
 	void (*pmd_update)(struct mm_struct *mm, unsigned long addr,
 			   pmd_t *pmdp);
-	void (*pmd_update_defer)(struct mm_struct *mm,
-				 unsigned long addr, pmd_t *pmdp);
 
 	pte_t (*ptep_modify_prot_start)(struct mm_struct *mm, unsigned long addr,
 					pte_t *ptep);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6ec0c8b..5126367 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -69,9 +69,7 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 #define pmd_clear(pmd)			native_pmd_clear(pmd)
 
 #define pte_update(mm, addr, ptep)              do { } while (0)
-#define pte_update_defer(mm, addr, ptep)        do { } while (0)
 #define pmd_update(mm, addr, ptep)              do { } while (0)
-#define pmd_update_defer(mm, addr, ptep)        do { } while (0)
 
 #define pgd_val(x)	native_pgd_val(x)
 #define __pgd(x)	native_make_pgd(x)
@@ -731,14 +729,9 @@ static inline void native_set_pmd_at(struct mm_struct *mm, unsigned long addr,
  * updates should either be sets, clears, or set_pte_atomic for P->P
  * transitions, which means this hook should only be called for user PTEs.
  * This hook implies a P->P protection or access change has taken place, which
- * requires a subsequent TLB flush.  The notification can optionally be delayed
- * until the TLB flush event by using the pte_update_defer form of the
- * interface, but care must be taken to assure that the flush happens while
- * still holding the same page table lock so that the shadow and primary pages
- * do not become out of sync on SMP.
+ * requires a subsequent TLB flush.
  */
 #define pte_update(mm, addr, ptep)		do { } while (0)
-#define pte_update_defer(mm, addr, ptep)	do { } while (0)
 #endif
 
 /*
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c2130ae..3ac7b85 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -444,9 +444,7 @@ struct pv_mmu_ops pv_mmu_ops = {
 	.set_pmd = native_set_pmd,
 	.set_pmd_at = native_set_pmd_at,
 	.pte_update = paravirt_nop,
-	.pte_update_defer = paravirt_nop,
 	.pmd_update = paravirt_nop,
-	.pmd_update_defer = paravirt_nop,
 
 	.ptep_modify_prot_start = __ptep_modify_prot_start,
 	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index a0d09f6..a1900d4 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1472,7 +1472,6 @@ __init void lguest_init(void)
 	pv_mmu_ops.lazy_mode.leave = lguest_leave_lazy_mmu_mode;
 	pv_mmu_ops.lazy_mode.flush = paravirt_flush_lazy_mmu;
 	pv_mmu_ops.pte_update = lguest_pte_update;
-	pv_mmu_ops.pte_update_defer = lguest_pte_update;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/* APIC read/write intercepts */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index fb0a9dd..3d8fc45 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -414,7 +414,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 
 	if (changed && dirty) {
 		*ptep = entry;
-		pte_update_defer(vma->vm_mm, address, ptep);
+		pte_update(vma->vm_mm, address, ptep);
 	}
 
 	return changed;
@@ -431,7 +431,6 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 
 	if (changed && dirty) {
 		*pmdp = entry;
-		pmd_update_defer(vma->vm_mm, address, pmdp);
 		/*
 		 * We had a write-protection fault here and changed the pmd
 		 * to to more permissive. No need to flush the TLB for that,
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index ac161db..896dc14 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -2436,7 +2436,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.flush_tlb_others = xen_flush_tlb_others,
 
 	.pte_update = paravirt_nop,
-	.pte_update_defer = paravirt_nop,
 
 	.pgd_alloc = xen_pgd_alloc,
 	.pgd_free = xen_pgd_free,
-- 
2.6.2
