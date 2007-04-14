From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 24/28] paravirt: drop unused ptep_get_and_clear
Date: Sat, 14 Apr 2007 13:42:18 -0700
Message-ID: <20070414204925.182354919@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753883AbXDNVVB@vger.kernel.org>
Content-Disposition: inline; filename=pte-drop-ptep_get_and_clear-paravirt-op.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

In shadow mode hypervisors, ptep_get_and_clear achieves the desired
purpose of keeping the shadows in sync by issuing a native_get_and_clear,
followed by a call to pte_update, which indicates the PTE has been
modified.

Direct mode hypervisors (Xen) have no need for this anyway, and will trap
the update using writable pagetables.

This means no hypervisor makes use of ptep_get_and_clear; there is no
reason to have it in the paravirt-ops structure.  Change confusing
terminology about raw vs. native functions into consistent use of
native_pte_xxx for operations which do not invoke paravirt-ops.

Signed-off-by: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/paravirt.c |    2 --
 include/asm-i386/paravirt.h |   13 +------------
 include/asm-i386/pgtable.h  |    4 +---
 3 files changed, 2 insertions(+), 17 deletions(-)

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -315,8 +315,6 @@ struct paravirt_ops paravirt_ops = {
 	.pte_update = paravirt_nop,
 	.pte_update_defer = paravirt_nop,
 
-	.ptep_get_and_clear = native_ptep_get_and_clear,
-
 #ifdef CONFIG_HIGHPTE
 	.kmap_atomic_pte = kmap_atomic,
 #endif
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -187,8 +187,6 @@ struct paravirt_ops
 	void (*pte_update)(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 	void (*pte_update_defer)(struct mm_struct *mm,
 				 unsigned long addr, pte_t *ptep);
-
- 	pte_t (*ptep_get_and_clear)(pte_t *ptep);
 
 #ifdef CONFIG_HIGHPTE
 	void *(*kmap_atomic_pte)(struct page *page, enum km_type type);
@@ -859,12 +857,8 @@ static inline void pmd_clear(pmd_t *pmdp
 	PVOP_VCALL1(pmd_clear, pmdp);
 }
 
-static inline pte_t raw_ptep_get_and_clear(pte_t *p)
-{
-	unsigned long long val = PVOP_CALL1(unsigned long long, ptep_get_and_clear, p);
-	return (pte_t) { val, val >> 32 };
-}
 #else  /* !CONFIG_X86_PAE */
+
 static inline pte_t __pte(unsigned long val)
 {
 	return (pte_t) { PVOP_CALL1(unsigned long, make_pte, val) };
@@ -899,11 +893,6 @@ static inline void set_pmd(pmd_t *pmdp, 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
 	PVOP_VCALL2(set_pmd, pmdp, pmdval.pud.pgd.pgd);
-}
-
-static inline pte_t raw_ptep_get_and_clear(pte_t *p)
-{
-	return (pte_t) { PVOP_CALL1(unsigned long, ptep_get_and_clear, p) };
 }
 #endif	/* CONFIG_X86_PAE */
 
===================================================================
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -265,8 +265,6 @@ static inline pte_t pte_mkhuge(pte_t pte
  */
 #define pte_update(mm, addr, ptep)		do { } while (0)
 #define pte_update_defer(mm, addr, ptep)	do { } while (0)
-
-#define raw_ptep_get_and_clear(xp)     native_ptep_get_and_clear(xp)
 #endif
 
 /*
@@ -340,7 +338,7 @@ do {									\
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = raw_ptep_get_and_clear(ptep);
+	pte_t pte = native_ptep_get_and_clear(ptep);
 	pte_update(mm, addr, ptep);
 	return pte;
 }

-- 
