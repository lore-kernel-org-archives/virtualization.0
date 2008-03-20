From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 02/15] preparation: host memory management changes for
	s390 kvm
Date: Thu, 20 Mar 2008 17:24:44 +0100
Message-ID: <1206030284.6690.53.camel__9973.30107861689$1206030524$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>, Linux Memory Management List <linux-mm@kvack.org>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch changes the s390 memory management defintions to use the pgste field
for dirty and reference bit tracking of host and guest code. Usually on s390, 
dirty and referenced are tracked in storage keys, which belong to the physical
page. This changes with virtualization: The guest and host dirty/reference bits
are defined to be the logical OR of the values for the mapping and the physical
page. This patch implements the necessary changes in pgtable.h for s390.


There is a common code change in mm/rmap.c, the call to page_test_and_clear_young
must be moved. This is a no-op for all architecture but s390. page_referenced
checks the referenced bits for the physiscal page and for all mappings:
o The physical page is checked with page_test_and_clear_young.
o The mappings are checked with ptep_test_and_clear_young and friends.

Without pgstes (the current implementation on Linux s390) the physical page
check is implemented but the mapping callbacks are no-ops because dirty 
and referenced are not tracked in the s390 page tables. The pgstes introduces 
guest and host dirty and reference bits for s390 in the host mapping. These
mapping must be checked before page_test_and_clear_young resets the reference
bit. 

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 include/asm-s390/pgtable.h |  109 +++++++++++++++++++++++++++++++++++++++++++--
 mm/rmap.c                  |    7 +-
 2 files changed, 110 insertions(+), 6 deletions(-)

Index: kvm/include/asm-s390/pgtable.h
===================================================================
--- kvm.orig/include/asm-s390/pgtable.h
+++ kvm/include/asm-s390/pgtable.h
@@ -30,6 +30,7 @@
  */
 #ifndef __ASSEMBLY__
 #include <linux/mm_types.h>
+#include <asm/atomic.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
 
@@ -258,6 +259,13 @@ extern char empty_zero_page[PAGE_SIZE];
  * swap pte is 1011 and 0001, 0011, 0101, 0111 are invalid.
  */
 
+/* Page status extended for virtualization */
+#define _PAGE_RCP_PCL	0x0080000000000000UL
+#define _PAGE_RCP_HR	0x0040000000000000UL
+#define _PAGE_RCP_HC	0x0020000000000000UL
+#define _PAGE_RCP_GR	0x0004000000000000UL
+#define _PAGE_RCP_GC	0x0002000000000000UL
+
 #ifndef __s390x__
 
 /* Bits in the segment table address-space-control-element */
@@ -513,6 +521,67 @@ static inline int pte_file(pte_t pte)
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(a,b)  (pte_val(a) == pte_val(b))
 
+static inline void rcp_lock(pte_t *ptep)
+{
+#ifdef CONFIG_PGSTE
+	atomic64_t *rcp = (atomic64_t *) (ptep + PTRS_PER_PTE);
+	preempt_disable();
+	atomic64_set_mask(_PAGE_RCP_PCL, rcp);
+#endif
+}
+
+static inline void rcp_unlock(pte_t *ptep)
+{
+#ifdef CONFIG_PGSTE
+	atomic64_t *rcp = (atomic64_t *) (ptep + PTRS_PER_PTE);
+	atomic64_clear_mask(_PAGE_RCP_PCL, rcp);
+	preempt_enable();
+#endif
+}
+
+static inline void rcp_set_bits(pte_t *ptep, unsigned long val)
+{
+#ifdef CONFIG_PGSTE
+	*(unsigned long *) (ptep + PTRS_PER_PTE) |= val;
+#endif
+}
+
+static inline int rcp_test_and_clear_bits(pte_t *ptep, unsigned long val)
+{
+#ifdef CONFIG_PGSTE
+	unsigned long ret;
+
+	ret = *(unsigned long *) (ptep + PTRS_PER_PTE);
+	*(unsigned long *) (ptep + PTRS_PER_PTE) &= ~val;
+	return (ret & val) == val;
+#else
+	return 0;
+#endif
+}
+
+
+/* forward declaration for SetPageUptodate in page-flags.h*/
+static inline void page_clear_dirty(struct page *page);
+#include <linux/page-flags.h>
+
+static inline void ptep_rcp_copy(pte_t *ptep)
+{
+#ifdef CONFIG_PGSTE
+	struct page *page = virt_to_page(pte_val(*ptep));
+	unsigned int skey;
+
+	skey = page_get_storage_key(page_to_phys(page));
+	if (skey & _PAGE_CHANGED)
+		rcp_set_bits(ptep, _PAGE_RCP_GC);
+	if (skey & _PAGE_REFERENCED)
+		rcp_set_bits(ptep, _PAGE_RCP_GR);
+	if (rcp_test_and_clear_bits(ptep, _PAGE_RCP_HC))
+		SetPageDirty(page);
+	if (rcp_test_and_clear_bits(ptep, _PAGE_RCP_HR))
+		SetPageReferenced(page);
+#endif
+}
+
 /*
  * query functions pte_write/pte_dirty/pte_young only work if
  * pte_present() is true. Undefined behaviour if not..
@@ -599,6 +668,8 @@ static inline void pmd_clear(pmd_t *pmd)
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
+	if (mm->context.pgstes)
+		ptep_rcp_copy(ptep);
 	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
 	if (mm->context.noexec)
 		pte_val(ptep[PTRS_PER_PTE]) = _PAGE_TYPE_EMPTY;
@@ -667,6 +738,22 @@ static inline pte_t pte_mkyoung(pte_t pt
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_PGSTE
+	unsigned long physpage;
+	int young;
+
+	if (!vma->vm_mm->context.pgstes)
+		return 0;
+	physpage = pte_val(*ptep) & PAGE_MASK;
+
+	young = ((page_get_storage_key(physpage) & _PAGE_REFERENCED) != 0);
+	rcp_lock(ptep);
+	if (young)
+		rcp_set_bits(ptep, _PAGE_RCP_GR);
+	young |= rcp_test_and_clear_bits(ptep, _PAGE_RCP_HR);
+	rcp_unlock(ptep);
+	return young;
+#endif
 	return 0;
 }
 
@@ -674,7 +761,13 @@ static inline int ptep_test_and_clear_yo
 static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 					 unsigned long address, pte_t *ptep)
 {
-	/* No need to flush TLB; bits are in storage key */
+	/* No need to flush TLB
+	 * On s390 reference bits are in storage key and never in TLB
+	 * With virtualization we handle the reference bit, without we
+	 * we can simply return */
+#ifdef CONFIG_PGSTE
+	return ptep_test_and_clear_young(vma, address, ptep);
+#endif
 	return 0;
 }
 
@@ -693,15 +786,25 @@ static inline void __ptep_ipte(unsigned 
 			: "=m" (*ptep) : "m" (*ptep),
 			  "a" (pto), "a" (address));
 	}
-	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
 }
 
 static inline void ptep_invalidate(struct mm_struct *mm,
 				   unsigned long address, pte_t *ptep)
 {
+	if (mm->context.pgstes) {
+		rcp_lock(ptep);
+		__ptep_ipte(address, ptep);
+		ptep_rcp_copy(ptep);
+		pte_val(*ptep) = _PAGE_TYPE_EMPTY;
+		rcp_unlock(ptep);
+		return;
+	}
 	__ptep_ipte(address, ptep);
-	if (mm->context.noexec)
+	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
+	if (mm->context.noexec) {
 		__ptep_ipte(address, ptep + PTRS_PER_PTE);
+		pte_val(*(ptep + PTRS_PER_PTE)) = _PAGE_TYPE_EMPTY;
+	}
 }
 
 /*
Index: kvm/mm/rmap.c
===================================================================
--- kvm.orig/mm/rmap.c
+++ kvm/mm/rmap.c
@@ -411,9 +411,6 @@ int page_referenced(struct page *page, i
 {
 	int referenced = 0;
 
-	if (page_test_and_clear_young(page))
-		referenced++;
-
 	if (TestClearPageReferenced(page))
 		referenced++;
 
@@ -431,6 +428,10 @@ int page_referenced(struct page *page, i
 			unlock_page(page);
 		}
 	}
+
+	if (page_test_and_clear_young(page))
+		referenced++;
+
 	return referenced;
 }
