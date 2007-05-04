From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 11/29] xen: ignore RW mapping of RO pages in pagetable_init
Date: Fri, 04 May 2007 16:21:02 -0700
Message-ID: <20070504232120.156706062@goop.org>
References: <20070504232051.411946839@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=xen-pagetable_init-ignore-ro-mappings.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, "\"Eric W. Biederman\"" <ebiederm@xmission.com>
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
@@ -635,7 +635,7 @@ static void xen_write_cr3(unsigned long 
 
 /* Early in boot, while setting up the initial pagetable, assume
    everything is pinned. */
-static void xen_alloc_pt_init(struct mm_struct *mm, u32 pfn)
+static __init void xen_alloc_pt_init(struct mm_struct *mm, u32 pfn)
 {
 	BUG_ON(mem_map);	/* should only be used early */
 	make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
@@ -687,9 +687,31 @@ static void *xen_kmap_atomic_pte(struct 
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
@@ -737,6 +759,7 @@ static __init void xen_pagetable_setup_d
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
 	paravirt_ops.alloc_pt = xen_alloc_pt;
+	paravirt_ops.set_pte = xen_set_pte;
 
 	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
 		/*
@@ -919,7 +942,7 @@ static const struct paravirt_ops xen_par
 	.dup_mmap = xen_dup_mmap,
 	.exit_mmap = xen_exit_mmap,
 
-	.set_pte = xen_set_pte,
+	.set_pte = NULL,	/* see xen_pagetable_setup_* */
 	.set_pte_at = xen_set_pte_at,
 	.set_pmd = xen_set_pmd,
 

-- 
