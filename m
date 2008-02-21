From: yamahata@valinux.co.jp
Subject: [PATCH 07/11] xen: make include/xen/page.h portable moving those
	definitions under asm dir.
Date: Thu, 21 Feb 2008 17:45:37 +0900
Message-ID: <20080221091002.526513000__35427.8535618961$1203629435$gmane$org@ls.local.valinux.co.jp>
References: <20080221084530.470680000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221212823.GK16885%yamahata@valinux.co.jp>
Resent-To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Disposition: inline;
	filename=0007-xen-make-include-xen-page.h-portable-moving-those-d.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Those definitions in include/asm/xen/page.h are arch specific.
ia64/xen wants to define its own version. So move them to arch specific
directory and keep include/xen/page.h in order not to break compilation.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/{ => asm-x86}/xen/page.h |    0 
 include/xen/page.h               |  181 +-------------------------------------
 2 files changed, 1 insertions(+), 180 deletions(-)
 copy include/{ => asm-x86}/xen/page.h (100%)

diff --git a/include/xen/page.h b/include/asm-x86/xen/page.h
similarity index 100%
copy from include/xen/page.h
copy to include/asm-x86/xen/page.h
diff --git a/include/xen/page.h b/include/xen/page.h
index 031ef22..eaf85fa 100644
--- a/include/xen/page.h
+++ b/include/xen/page.h
@@ -1,180 +1 @@
-#ifndef __XEN_PAGE_H
-#define __XEN_PAGE_H
-
-#include <linux/pfn.h>
-
-#include <asm/uaccess.h>
-#include <asm/pgtable.h>
-
-#include <xen/features.h>
-
-#ifdef CONFIG_X86_PAE
-/* Xen machine address */
-typedef struct xmaddr {
-	unsigned long long maddr;
-} xmaddr_t;
-
-/* Xen pseudo-physical address */
-typedef struct xpaddr {
-	unsigned long long paddr;
-} xpaddr_t;
-#else
-/* Xen machine address */
-typedef struct xmaddr {
-	unsigned long maddr;
-} xmaddr_t;
-
-/* Xen pseudo-physical address */
-typedef struct xpaddr {
-	unsigned long paddr;
-} xpaddr_t;
-#endif
-
-#define XMADDR(x)	((xmaddr_t) { .maddr = (x) })
-#define XPADDR(x)	((xpaddr_t) { .paddr = (x) })
-
-/**** MACHINE <-> PHYSICAL CONVERSION MACROS ****/
-#define INVALID_P2M_ENTRY	(~0UL)
-#define FOREIGN_FRAME_BIT	(1UL<<31)
-#define FOREIGN_FRAME(m)	((m) | FOREIGN_FRAME_BIT)
-
-extern unsigned long *phys_to_machine_mapping;
-
-static inline unsigned long pfn_to_mfn(unsigned long pfn)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return pfn;
-
-	return phys_to_machine_mapping[(unsigned int)(pfn)] &
-		~FOREIGN_FRAME_BIT;
-}
-
-static inline int phys_to_machine_mapping_valid(unsigned long pfn)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return 1;
-
-	return (phys_to_machine_mapping[pfn] != INVALID_P2M_ENTRY);
-}
-
-static inline unsigned long mfn_to_pfn(unsigned long mfn)
-{
-	unsigned long pfn;
-
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return mfn;
-
-#if 0
-	if (unlikely((mfn >> machine_to_phys_order) != 0))
-		return max_mapnr;
-#endif
-
-	pfn = 0;
-	/*
-	 * The array access can fail (e.g., device space beyond end of RAM).
-	 * In such cases it doesn't matter what we return (we return garbage),
-	 * but we must handle the fault without crashing!
-	 */
-	__get_user(pfn, &machine_to_phys_mapping[mfn]);
-
-	return pfn;
-}
-
-static inline xmaddr_t phys_to_machine(xpaddr_t phys)
-{
-	unsigned offset = phys.paddr & ~PAGE_MASK;
-	return XMADDR(PFN_PHYS((u64)pfn_to_mfn(PFN_DOWN(phys.paddr))) | offset);
-}
-
-static inline xpaddr_t machine_to_phys(xmaddr_t machine)
-{
-	unsigned offset = machine.maddr & ~PAGE_MASK;
-	return XPADDR(PFN_PHYS((u64)mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
-}
-
-/*
- * We detect special mappings in one of two ways:
- *  1. If the MFN is an I/O page then Xen will set the m2p entry
- *     to be outside our maximum possible pseudophys range.
- *  2. If the MFN belongs to a different domain then we will certainly
- *     not have MFN in our p2m table. Conversely, if the page is ours,
- *     then we'll have p2m(m2p(MFN))==MFN.
- * If we detect a special mapping then it doesn't have a 'struct page'.
- * We force !pfn_valid() by returning an out-of-range pointer.
- *
- * NB. These checks require that, for any MFN that is not in our reservation,
- * there is no PFN such that p2m(PFN) == MFN. Otherwise we can get confused if
- * we are foreign-mapping the MFN, and the other domain as m2p(MFN) == PFN.
- * Yikes! Various places must poke in INVALID_P2M_ENTRY for safety.
- *
- * NB2. When deliberately mapping foreign pages into the p2m table, you *must*
- *      use FOREIGN_FRAME(). This will cause pte_pfn() to choke on it, as we
- *      require. In all the cases we care about, the FOREIGN_FRAME bit is
- *      masked (e.g., pfn_to_mfn()) so behaviour there is correct.
- */
-static inline unsigned long mfn_to_local_pfn(unsigned long mfn)
-{
-	extern unsigned long max_mapnr;
-	unsigned long pfn = mfn_to_pfn(mfn);
-	if ((pfn < max_mapnr)
-	    && !xen_feature(XENFEAT_auto_translated_physmap)
-	    && (phys_to_machine_mapping[pfn] != mfn))
-		return max_mapnr; /* force !pfn_valid() */
-	return pfn;
-}
-
-static inline void set_phys_to_machine(unsigned long pfn, unsigned long mfn)
-{
-	if (xen_feature(XENFEAT_auto_translated_physmap)) {
-		BUG_ON(pfn != mfn && mfn != INVALID_P2M_ENTRY);
-		return;
-	}
-	phys_to_machine_mapping[pfn] = mfn;
-}
-
-/* VIRT <-> MACHINE conversion */
-#define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
-#define virt_to_mfn(v)		(pfn_to_mfn(PFN_DOWN(__pa(v))))
-#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
-
-#ifdef CONFIG_X86_PAE
-#define pte_mfn(_pte) (((_pte).pte_low >> PAGE_SHIFT) |			\
-		       (((_pte).pte_high & 0xfff) << (32-PAGE_SHIFT)))
-
-static inline pte_t mfn_pte(unsigned long page_nr, pgprot_t pgprot)
-{
-	pte_t pte;
-
-	pte.pte_high = (page_nr >> (32 - PAGE_SHIFT)) |
-		(pgprot_val(pgprot) >> 32);
-	pte.pte_high &= (__supported_pte_mask >> 32);
-	pte.pte_low = ((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
-	pte.pte_low &= __supported_pte_mask;
-
-	return pte;
-}
-
-static inline unsigned long long pte_val_ma(pte_t x)
-{
-	return x.pte;
-}
-#define pmd_val_ma(v) ((v).pmd)
-#define pud_val_ma(v) ((v).pgd.pgd)
-#define __pte_ma(x)	((pte_t) { .pte = (x) })
-#define __pmd_ma(x)	((pmd_t) { (x) } )
-#else  /* !X86_PAE */
-#define pte_mfn(_pte) ((_pte).pte_low >> PAGE_SHIFT)
-#define mfn_pte(pfn, prot)	__pte_ma(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
-#define pte_val_ma(x)	((x).pte)
-#define pmd_val_ma(v)	((v).pud.pgd.pgd)
-#define __pte_ma(x)	((pte_t) { (x) } )
-#endif	/* CONFIG_X86_PAE */
-
-#define pgd_val_ma(x)	((x).pgd)
-
-
-xmaddr_t arbitrary_virt_to_machine(unsigned long address);
-void make_lowmem_page_readonly(void *vaddr);
-void make_lowmem_page_readwrite(void *vaddr);
-
-#endif /* __XEN_PAGE_H */
+#include <asm/xen/page.h>
-- 
1.5.3

-- 
yamahata
