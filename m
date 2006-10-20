From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 3/5] Fix missing pte update.patch
Date: Thu, 19 Oct 2006 17:09:22 -0700
Message-ID: <200610200009.k9K09M1g027570@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946739AbWJTAKc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

diff -r f1dd818c2f06 include/asm-i386/pgtable-2level.h
--- a/include/asm-i386/pgtable-2level.h	Thu Oct 19 03:03:09 2006 -0700
+++ b/include/asm-i386/pgtable-2level.h	Thu Oct 19 03:03:18 2006 -0700
@@ -22,8 +22,7 @@
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
+#define raw_ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
diff -r f1dd818c2f06 include/asm-i386/pgtable-3level.h
--- a/include/asm-i386/pgtable-3level.h	Thu Oct 19 03:03:09 2006 -0700
+++ b/include/asm-i386/pgtable-3level.h	Thu Oct 19 03:03:18 2006 -0700
@@ -119,8 +119,7 @@ static inline void pmd_clear(pmd_t *pmd)
 	*(tmp + 1) = 0;
 }
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+static inline pte_t raw_ptep_get_and_clear(pte_t *ptep)
 {
 	pte_t res;
 
diff -r f1dd818c2f06 include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Thu Oct 19 03:03:09 2006 -0700
+++ b/include/asm-i386/pgtable.h	Thu Oct 19 03:03:18 2006 -0700
@@ -324,6 +324,14 @@ do {									\
 	__young;							\
 })
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = raw_ptep_get_and_clear(ptep);
+	pte_update(mm, addr, ptep);
+	return pte;
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
 {
