From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 18/33] xen: xen: ignore RW mapping of RO pages
	in pagetable_init
Date: Tue, 22 May 2007 15:09:59 +0100
Message-ID: <20070522141252.360506293@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline;
	filename=xen-pagetable_init-ignore-ro-mappings.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "\"Eric W. Biederman\"" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When setting up the initial pagetable, which includes mappings of all
low physical memory, ignore a mapping which tries to set the RW bit on
an RO pte.  An RO pte indicates a page which is part of the current
pagetable, and so it cannot be allowed to become RW.

Once xen_pagetable_setup_done is called, set_pte reverts to its normal
behaviour.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Acked-by: Chris Wright <chrisw@sous-sol.org>
Cc: ebiederm@xmission.com (Eric W. Biederman)

---
 arch/i386/xen/enlighten.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

===================================================================
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -501,7 +501,7 @@ static void xen_write_cr3(unsigned long 
 
 /* Early in boot, while setting up the initial pagetable, assume
    everything is pinned. */
-static void xen_alloc_pt_init(struct mm_struct *mm, u32 pfn)
+static __init void xen_alloc_pt_init(struct mm_struct *mm, u32 pfn)
 {
 	BUG_ON(mem_map);	/* should only be used early */
 	make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
@@ -553,9 +553,31 @@ static void *xen_kmap_atomic_pte(struct 
 }
 #endif
 
+static __init pte_t mask_rw_pte(pte_t *ptep, pte_t pte)
+{
+	/* If there's an existing pte, then don't allow _PAGE_RW to be set */
+	if (pte_val_ma(*ptep) & _PAGE_PRESENT)
+		pte = __pte_ma(((pte_val_ma(*ptep) & _PAGE_RW) | ~_PAGE_RW) &
+			       pte_val_ma(pte));
+
+	return pte;
+}
+
+/* Init-time set_pte while constructing initial pagetables, which
+   doesn't allow RO pagetable pages to be remapped RW */
+static __init void xen_set_pte_init(pte_t *ptep, pte_t pte)
+{
+	pte = mask_rw_pte(ptep, pte);
+
+	xen_set_pte(ptep, pte);
+}
+
 static __init void xen_pagetable_setup_start(pgd_t *base)
 {
 	pgd_t *xen_pgd = (pgd_t *)xen_start_info->pt_base;
+
+	/* special set_pte for pagetable initialization */
+	paravirt_ops.set_pte = xen_set_pte_init;
 
 	init_mm.pgd = base;
 	/*
@@ -603,6 +625,7 @@ static __init void xen_pagetable_setup_d
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
 	paravirt_ops.alloc_pt = xen_alloc_pt;
+	paravirt_ops.set_pte = xen_set_pte;
 
 	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
 		/*
@@ -741,7 +764,7 @@ static const struct paravirt_ops xen_par
 	.kmap_atomic_pte = xen_kmap_atomic_pte,
 #endif
 
-	.set_pte = xen_set_pte,
+	.set_pte = NULL,	/* see xen_pagetable_setup_* */
 	.set_pte_at = xen_set_pte_at,
 	.set_pmd = xen_set_pmd,
 

-- 
