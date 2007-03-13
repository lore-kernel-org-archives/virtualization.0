From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 26/34] Xen-pv_ops: Complete pagetable pinning for Xen
Date: Tue, 13 Mar 2007 16:30:43 -0700
Message-ID: <20070313233034.177789862@goop.org>
References: <20070313233017.933601256@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-pinned-pagetables.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Xen has a notion of pinned pagetables, which are pagetables that
remain read-only to the guest and are validated by the hypervisor.
This makes context switches much cheaper, because the hypervisor
doesn't need to revalidate the pagetable each time.

This patch adds a PG_pinned flag for pagetable pages so we can tell if
it has been pinned or not.  This allows various pagetable update
optimisations.

This also adds a mm parameter to the alloc_pt pv_op, so that Xen can
see if we're adding a page to a pinned pagetable.  This is not
necessary for alloc_pd or release_p[dt], which is fortunate because it
isn't available at all callsites.

This also adds a new paravirt hook which is called during setup once
the zones and memory allocator have been initialized.  When the
init_mm pagetable is first built, the struct page array does not yet
exist, and so there's nowhere to put he init_mm pagetable's PG_pinned
flags.  Once the zones are initialized and the struct page array
exists, we can set the PG_pinned flags for those pages.

This patch also adds the Xen support for pte pages allocated out of
highmem (highpte), principly by implementing xen_kmap_atomic_pte.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Zach Amsden <zach@vmware.com>

---
 arch/i386/kernel/setup.c    |    3 =

 arch/i386/kernel/vmi.c      |    2 =

 arch/i386/mm/init.c         |    2 =

 arch/i386/mm/pageattr.c     |    2 =

 arch/i386/xen/enlighten.c   |  104 +++++++++++----
 arch/i386/xen/mmu.c         |  290 ++++++++++++++++++++++++++-------------=
----
 arch/i386/xen/mmu.h         |    2 =

 arch/i386/xen/xen-ops.h     |    2 =

 include/asm-i386/paravirt.h |   12 +
 include/asm-i386/pgalloc.h  |    6 =

 include/asm-i386/setup.h    |    4 =

 include/linux/page-flags.h  |    5 =

 12 files changed, 284 insertions(+), 150 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -607,9 +607,12 @@ void __init setup_arch(char **cmdline_p)
 	sparse_init();
 	zone_sizes_init();
 =

+
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
+
+	paravirt_post_allocator_init();
 =

 	dmi_scan_machine();
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -364,7 +364,7 @@ static void vmi_map_pt_hook(int type, pt
 	vmi_ops.set_linear_mapping((type - KM_PTE0)+1, (u32)va, 1, pfn);
 }
 =

-static void vmi_allocate_pt(u32 pfn)
+static void vmi_allocate_pt(struct mm_struct *mm, u32 pfn)
 {
 	vmi_set_page_type(pfn, VMI_PAGE_L1);
 	vmi_ops.allocate_page(pfn, VMI_PAGE_L1, 0, 0, 0);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -86,7 +86,7 @@ static pte_t * __init one_page_table_ini
 	if (pmd_none(*pmd)) {
 		pte_t *page_table =3D (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 =

-		paravirt_alloc_pt(__pa(page_table) >> PAGE_SHIFT);
+		paravirt_alloc_pt(&init_mm, __pa(page_table) >> PAGE_SHIFT);
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		BUG_ON(page_table !=3D pte_offset_kernel(pmd, 0));
 	}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/pageattr.c
+++ b/arch/i386/mm/pageattr.c
@@ -60,7 +60,7 @@ static struct page *split_large_page(uns
 	address =3D __pa(address);
 	addr =3D address & LARGE_PAGE_MASK; =

 	pbase =3D (pte_t *)page_address(base);
-	paravirt_alloc_pt(page_to_pfn(base));
+	paravirt_alloc_pt(&init_mm, page_to_pfn(base));
 	for (i =3D 0; i < PTRS_PER_PTE; i++, addr +=3D PAGE_SIZE) {
                set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
                                           addr =3D=3D address ? prot : ref=
_prot));
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -8,6 +8,9 @@
 #include <linux/sched.h>
 #include <linux/bootmem.h>
 #include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/page-flags.h>
+#include <linux/highmem.h>
 =

 #include <xen/interface/xen.h>
 #include <xen/features.h>
@@ -457,31 +460,56 @@ static void xen_write_cr3(unsigned long =

 	}
 }
 =

-static void xen_alloc_pt(u32 pfn)
-{
-	/* XXX pfn isn't necessarily a lowmem page */
+/* Early in boot, while setting up the initial pagetable, assume
+   everything is pinned. */
+static void xen_alloc_pt_init(struct mm_struct *mm, u32 pfn)
+{
+	BUG_ON(mem_map);	/* should only be used early */
 	make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
 }
 =

-static void xen_alloc_pd(u32 pfn)
-{
-	make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
-}
-
-static void xen_release_pd(u32 pfn)
-{
-	make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
-}
-
+/* This needs to make sure the new pte page is pinned iff its being
+   attached to a pinned pagetable. */
+static void xen_alloc_pt(struct mm_struct *mm, u32 pfn)
+{
+	struct page *page =3D pfn_to_page(pfn);
+
+	if (PagePinned(virt_to_page(mm->pgd))) {
+		SetPagePinned(page);
+
+		if (!PageHighMem(page))
+			make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
+		else
+			/* make sure there are no stray mappings of
+			   this page */
+			kmap_flush_unused();
+	}
+}
+
+/* This should never happen until we're OK to use struct page */
 static void xen_release_pt(u32 pfn)
 {
-	make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
-}
-
-static void xen_alloc_pd_clone(u32 pfn, u32 clonepfn,
-					u32 start, u32 count)
-{
-	xen_alloc_pd(pfn);
+	struct page *page =3D pfn_to_page(pfn);
+
+	if (PagePinned(page)) {
+		if (!PageHighMem(page))
+			make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
+	}
+}
+
+static void *xen_kmap_atomic_pte(struct page *page, enum km_type type)
+{
+	pgprot_t prot =3D PAGE_KERNEL;
+
+	if (PagePinned(page))
+		prot =3D PAGE_KERNEL_RO;
+
+	if (0 && PageHighMem(page))
+		printk("mapping highpte %lx type %d prot %s\n",
+		       page_to_pfn(page), type,
+		       (unsigned long)pgprot_val(prot) & _PAGE_RW ? "WRITE" : "READ");
+
+	return _kmap_atomic(page, type, prot);
 }
 =

 static __init void xen_pagetable_setup_start(pgd_t *base)
@@ -508,7 +536,7 @@ static __init void xen_pagetable_setup_s
 				memcpy(pmd, (void *)pgd_page_vaddr(xen_pgd[i]),
 				       PAGE_SIZE);
 =

-				xen_alloc_pd(PFN_DOWN(__pa(pmd)));
+				make_lowmem_page_readonly(pmd);
 =

 				set_pgd(&base[i], __pgd(1 + __pa(pmd)));
 			} else
@@ -529,6 +557,10 @@ static __init void xen_pagetable_setup_s
 =

 static __init void xen_pagetable_setup_done(pgd_t *base)
 {
+	/* This will work as long as patching hasn't happened yet
+	   (which it hasn't) */
+	paravirt_ops.alloc_pt =3D xen_alloc_pt;
+
 	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
 		/* Create a mapping for the shared info page.
 		   Should be set_fixmap(), but shared_info is a machine
@@ -544,9 +576,22 @@ static __init void xen_pagetable_setup_d
 		HYPERVISOR_shared_info =3D
 			(struct shared_info *)__va(xen_start_info->shared_info);
 =

-	xen_pgd_pin(base);
-
-	write_pda(xen.vcpu, &HYPERVISOR_shared_info->vcpu_info[smp_processor_id()=
]);
+	/* Actually pin the pagetable down, but we can't set PG_pinned yet because
+	   the page structures don't exist yet. */
+	{
+		struct mmuext_op op;
+#ifdef CONFIG_X86_PAE
+		op.cmd =3D MMUEXT_PIN_L3_TABLE;
+#else
+		op.cmd =3D MMUEXT_PIN_L3_TABLE;
+#endif
+		op.arg1.mfn =3D pfn_to_mfn(PFN_DOWN(__pa(base)));
+		if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF))
+			BUG();
+	}
+
+	write_pda(xen.vcpu,
+		  &HYPERVISOR_shared_info->vcpu_info[smp_processor_id()]);
 }
 =

 static const struct paravirt_ops xen_paravirt_ops __initdata =3D {
@@ -563,6 +608,7 @@ static const struct paravirt_ops xen_par
 	.init_IRQ =3D xen_init_IRQ,
 	.time_init =3D xen_time_init,
 	.init_pda =3D xen_init_pda,
+	.post_allocator_init =3D xen_mark_init_mm_pinned,
 =

 	.cpuid =3D xen_cpuid,
 =

@@ -647,11 +693,13 @@ static const struct paravirt_ops xen_par
 	.set_pte_at =3D xen_set_pte_at,
 	.set_pmd =3D xen_set_pmd,
 =

-	.alloc_pt =3D xen_alloc_pt,
-	.alloc_pd =3D xen_alloc_pd,
-	.alloc_pd_clone =3D xen_alloc_pd_clone,
-	.release_pd =3D xen_release_pd,
+	.alloc_pt =3D xen_alloc_pt_init,
 	.release_pt =3D xen_release_pt,
+	.alloc_pd =3D paravirt_nop,
+	.alloc_pd_clone =3D paravirt_nop,
+	.release_pd =3D paravirt_nop,
+
+	.kmap_atomic_pte =3D xen_kmap_atomic_pte,
 =

 	.pte_val =3D xen_pte_val,
 	.pgd_val =3D xen_pgd_val,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/mmu.c
+++ b/arch/i386/xen/mmu.c
@@ -1,4 +1,5 @@
-//#include <linux/bug.h>
+#include <linux/highmem.h>
+
 #include <asm/bug.h>
 =

 #include <asm/pgtable.h>
@@ -6,11 +7,14 @@
 #include <asm/mmu_context.h>
 =

 #include <asm/xen/hypercall.h>
+#include <asm/xen/hypervisor.h>
 #include <asm/paravirt.h>
 =

 #include <xen/page.h>
 #include <xen/interface/xen.h>
 =

+#include "multicalls.h"
+
 #include "mmu.h"
 =

 xmaddr_t arbitrary_virt_to_machine(unsigned long address)
@@ -49,23 +53,6 @@ void make_lowmem_page_readwrite(void *va
 =

 	if(HYPERVISOR_update_va_mapping(address, ptev, 0))
 		BUG();
-}
-
-
-void xen_set_pte(pte_t *ptep, pte_t pte)
-{
-#if 1
-	struct mmu_update u;
-
-	u.ptr =3D virt_to_machine(ptep).maddr;
-	u.val =3D pte_val_ma(pte);
-	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
-		BUG();
-#else
-	ptep->pte_high =3D pte.pte_high;
-	smp_wmb();
-	ptep->pte_low =3D pte.pte_low;
-#endif
 }
 =

 void xen_set_pmd(pmd_t *ptr, pmd_t val)
@@ -77,18 +64,6 @@ void xen_set_pmd(pmd_t *ptr, pmd_t val)
 	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
 		BUG();
 }
-
-#ifdef CONFIG_X86_PAE
-void xen_set_pud(pud_t *ptr, pud_t val)
-{
-	struct mmu_update u;
-
-	u.ptr =3D virt_to_machine(ptr).maddr;
-	u.val =3D pud_val_ma(val);
-	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
-		BUG();
-}
-#endif
 =

 /*
  * Associate a virtual page frame with a given physical page frame
@@ -136,20 +111,33 @@ void xen_set_pte_at(struct mm_struct *mm
 }
 =

 #ifdef CONFIG_X86_PAE
+void xen_set_pud(pud_t *ptr, pud_t val)
+{
+	struct mmu_update u;
+
+	u.ptr =3D virt_to_machine(ptr).maddr;
+	u.val =3D pud_val_ma(val);
+	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
+		BUG();
+}
+
+void xen_set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high =3D pte.pte_high;
+	smp_wmb();
+	ptep->pte_low =3D pte.pte_low;
+}
+
 void xen_set_pte_atomic(pte_t *ptep, pte_t pte)
 {
 	set_64bit((u64 *)ptep, pte_val_ma(pte));
 }
 =

-void xen_pte_clear(struct mm_struct *mm, unsigned long addr,pte_t *ptep)
-{
-#if 1
+void xen_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
 	ptep->pte_low =3D 0;
 	smp_wmb();
 	ptep->pte_high =3D 0;
-#else
-	set_64bit((u64 *)ptep, 0);
-#endif
 }
 =

 void xen_pmd_clear(pmd_t *pmdp)
@@ -221,6 +209,11 @@ pte_t xen_ptep_get_and_clear(pte_t *ptep
 	return res;
 }
 #else  /* !PAE */
+void xen_set_pte(pte_t *ptep, pte_t pte)
+{
+	*ptep =3D pte;
+}
+
 unsigned long xen_pte_val(pte_t pte)
 {
 	unsigned long ret =3D pte.pte_low;
@@ -229,12 +222,6 @@ unsigned long xen_pte_val(pte_t pte)
 		ret =3D machine_to_phys(XMADDR(ret)).paddr;
 =

 	return ret;
-}
-
-unsigned long xen_pmd_val(pmd_t pmd)
-{
-	BUG();
-	return 0;
 }
 =

 unsigned long xen_pgd_val(pgd_t pgd)
@@ -253,12 +240,6 @@ pte_t xen_make_pte(unsigned long pte)
 	return (pte_t){ pte };
 }
 =

-pmd_t xen_make_pmd(unsigned long pmd)
-{
-	BUG();
-	return __pmd(0);
-}
-
 pgd_t xen_make_pgd(unsigned long pgd)
 {
 	if (pgd & _PAGE_PRESENT)
@@ -274,109 +255,192 @@ pte_t xen_ptep_get_and_clear(pte_t *ptep
 #endif	/* CONFIG_X86_PAE */
 =

 =

-
-static void pgd_walk_set_prot(void *pt, pgprot_t flags)
-{
-	unsigned long pfn =3D PFN_DOWN(__pa(pt));
-
-	if (HYPERVISOR_update_va_mapping((unsigned long)pt,
-					 pfn_pte(pfn, flags), 0) < 0)
-		BUG();
-}
-
-static void pgd_walk(pgd_t *pgd_base, pgprot_t flags)
+/*
+  (Yet another) pagetable walker.  This one is intended for pinning a
+  pagetable.  This means that it walks a pagetable and calls the
+  callback function on each page it finds making up the page table,
+  at every level.  It walks the entire pagetable, but it only bothers
+  pinning pte pages which are below pte_limit.  In the normal case
+  this will be TASK_SIZE, but at boot we need to pin up to
+  FIXADDR_TOP.  But the important bit is that we don't pin beyond
+  there, because then we start getting into Xen's ptes.
+*/
+static int pgd_walk(pgd_t *pgd_base, int (*func)(struct page *, unsigned),
+		    unsigned long limit)
 {
 	pgd_t *pgd =3D pgd_base;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int    g, u, m;
+	int flush =3D 0;
+	unsigned long addr =3D 0;
+	unsigned long pgd_next;
+
+	BUG_ON(limit > FIXADDR_TOP);
 =

 	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return;
-
-	for (g =3D 0; g < USER_PTRS_PER_PGD; g++, pgd++) {
-		if (pgd_none(*pgd))
+		return 0;
+
+	for (; addr !=3D FIXADDR_TOP; pgd++, addr =3D pgd_next) {
+		pud_t *pud;
+		unsigned long pud_limit, pud_next;
+
+		pgd_next =3D pud_limit =3D pgd_addr_end(addr, FIXADDR_TOP);
+
+		if (!pgd_val(*pgd))
 			continue;
+
 		pud =3D pud_offset(pgd, 0);
 =

 		if (PTRS_PER_PUD > 1) /* not folded */
-			pgd_walk_set_prot(pud,flags);
-
-		for (u =3D 0; u < PTRS_PER_PUD; u++, pud++) {
+			flush |=3D (*func)(virt_to_page(pud), 0);
+
+		for (; addr !=3D pud_limit; pud++, addr =3D pud_next) {
+			pmd_t *pmd;
+			unsigned long pmd_limit;
+
+			pud_next =3D pud_addr_end(addr, pud_limit);
+
+			if (pud_next < limit)
+				pmd_limit =3D pud_next;
+			else
+				pmd_limit =3D limit;
+
 			if (pud_none(*pud))
 				continue;
+
 			pmd =3D pmd_offset(pud, 0);
 =

 			if (PTRS_PER_PMD > 1) /* not folded */
-				pgd_walk_set_prot(pmd,flags);
-
-			for (m =3D 0; m < PTRS_PER_PMD; m++, pmd++) {
+				flush |=3D (*func)(virt_to_page(pmd), 0);
+
+			for (; addr !=3D pmd_limit; pmd++) {
+				addr +=3D (PAGE_SIZE * PTRS_PER_PTE);
+				if ((pmd_limit-1) < (addr-1))
+					addr =3D pmd_limit;
+
 				if (pmd_none(*pmd))
 					continue;
 =

-				/* This can get called before mem_map
-				   is set up, so we assume nothing is
-				   highmem at that point. */
-				if (mem_map =3D=3D NULL ||
-				    !PageHighMem(pmd_page(*pmd))) {
-					pte =3D pte_offset_kernel(pmd,0);
-					pgd_walk_set_prot(pte,flags);
-				}
+				flush |=3D (*func)(pmd_page(*pmd), 0);
 			}
 		}
 	}
 =

-	if (HYPERVISOR_update_va_mapping((unsigned long)pgd_base,
-					 pfn_pte(PFN_DOWN(__pa(pgd_base)),
-						 flags),
-					 UVMF_TLB_FLUSH) < 0)
-		BUG();
-}
-
-
-/* This is called just after a mm has been duplicated from its parent,
-   but it has not been used yet.  We need to make sure that its
-   pagetable is all read-only, and can be pinned. */
+	flush |=3D (*func)(virt_to_page(pgd_base), UVMF_TLB_FLUSH);
+
+	return flush;
+}
+
+static int pin_page(struct page *page, unsigned flags)
+{
+	unsigned pgfl =3D test_and_set_bit(PG_pinned, &page->flags);
+	int flush;
+
+	if (pgfl)
+		flush =3D 0;		/* already pinned */
+	else if (PageHighMem(page))
+		/* kmaps need flushing if we found an unpinned
+		   highpage */
+		flush =3D 1;
+	else {
+		void *pt =3D lowmem_page_address(page);
+		unsigned long pfn =3D page_to_pfn(page);
+		struct multicall_space mcs =3D xen_mc_entry(0);
+
+		flush =3D 0;
+
+		MULTI_update_va_mapping(mcs.mc, (unsigned long)pt,
+					pfn_pte(pfn, PAGE_KERNEL_RO),
+					flags);
+	}
+
+	return flush;
+}
+
+/* This is called just after a mm has been created, but it has not
+   been used yet.  We need to make sure that its pagetable is all
+   read-only, and can be pinned. */
 void xen_pgd_pin(pgd_t *pgd)
 {
-	struct mmuext_op op;
-
-	pgd_walk(pgd, PAGE_KERNEL_RO);
-
-#if defined(CONFIG_X86_PAE)
-	op.cmd =3D MMUEXT_PIN_L3_TABLE;
+	struct multicall_space mcs;
+	struct mmuext_op *op;
+
+	if (pgd_walk(pgd, pin_page, TASK_SIZE))
+		kmap_flush_unused();
+
+	mcs =3D xen_mc_entry(sizeof(*op));
+	op =3D mcs.args;
+
+#ifdef CONFIG_X86_PAE
+	op->cmd =3D MMUEXT_PIN_L3_TABLE;
 #else
-	op.cmd =3D MMUEXT_PIN_L2_TABLE;
+	op->cmd =3D MMUEXT_PIN_L2_TABLE;
 #endif
-	op.arg1.mfn =3D pfn_to_mfn(PFN_DOWN(__pa(pgd)));
-	if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0)
-		BUG();
+	op->arg1.mfn =3D pfn_to_mfn(PFN_DOWN(__pa(pgd)));
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	xen_mc_flush();
+}
+
+/* The init_mm pagetable is really pinned as soon as its created, but
+   that's before we have page structures to store the bits.  So do all
+   the book-keeping now. */
+static __init int mark_pinned(struct page *page, unsigned flags)
+{
+	SetPagePinned(page);
+	return 0;
+}
+
+void __init xen_mark_init_mm_pinned(void)
+{
+	pgd_walk(init_mm.pgd, mark_pinned, FIXADDR_TOP);
+}
+
+static int unpin_page(struct page *page, unsigned flags)
+{
+	unsigned pgfl =3D test_and_clear_bit(PG_pinned, &page->flags);
+
+	if (pgfl && !PageHighMem(page)) {
+		void *pt =3D lowmem_page_address(page);
+		unsigned long pfn =3D page_to_pfn(page);
+		struct multicall_space mcs =3D xen_mc_entry(0);
+
+		MULTI_update_va_mapping(mcs.mc, (unsigned long)pt,
+					pfn_pte(pfn, PAGE_KERNEL),
+					flags);
+	}
+
+	return 0;		/* never need to flush on unpin */
 }
 =

 /* Release a pagetables pages back as normal RW */
-void xen_pgd_unpin(pgd_t *pgd)
-{
-	struct mmuext_op op;
-
-	op.cmd =3D MMUEXT_UNPIN_TABLE;
-	op.arg1.mfn =3D pfn_to_mfn(PFN_DOWN(__pa(pgd)));
-
-	if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0)
-		BUG();
-
-	pgd_walk(pgd, PAGE_KERNEL);
+static void xen_pgd_unpin(pgd_t *pgd)
+{
+	struct mmuext_op *op;
+	struct multicall_space mcs =3D xen_mc_entry(sizeof(*op));
+
+	op =3D mcs.args;
+	op->cmd =3D MMUEXT_UNPIN_TABLE;
+	op->arg1.mfn =3D pfn_to_mfn(PFN_DOWN(__pa(pgd)));
+
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	pgd_walk(pgd, unpin_page, TASK_SIZE);
+
+	xen_mc_flush();
 }
 =

 =

 void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
+	spin_lock(&next->page_table_lock);
 	xen_pgd_pin(next->pgd);
+	spin_unlock(&next->page_table_lock);
 }
 =

 void xen_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
+	spin_lock(&mm->page_table_lock);
 	xen_pgd_pin(mm->pgd);
+	spin_unlock(&mm->page_table_lock);
 }
 =

 void xen_exit_mmap(struct mm_struct *mm)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/mmu.h
+++ b/arch/i386/xen/mmu.h
@@ -17,7 +17,7 @@ pte_t xen_ptep_get_and_clear(pte_t *ptep
 pte_t xen_ptep_get_and_clear(pte_t *ptep);
 =

 void xen_pgd_pin(pgd_t *pgd);
-void xen_pgd_unpin(pgd_t *pgd);
+//void xen_pgd_unpin(pgd_t *pgd);
 =

 #ifdef CONFIG_X86_PAE
 unsigned long long xen_pte_val(pte_t);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/xen/xen-ops.h
+++ b/arch/i386/xen/xen-ops.h
@@ -15,6 +15,8 @@ unsigned long xen_get_wallclock(void);
 unsigned long xen_get_wallclock(void);
 int xen_set_wallclock(unsigned long time);
 =

+void xen_mark_init_mm_pinned(void);
+
 void stop_hz_timer(void);
 void start_hz_timer(void);
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -275,6 +275,8 @@ struct paravirt_ops
 =

 	void (*arch_setup)(void);
 	char *(*memory_setup)(void);
+	void (*post_allocator_init)(void);
+
 	void (*init_IRQ)(void);
 	void (*init_pda)(struct i386_pda *, int cpu);
 =

@@ -360,7 +362,7 @@ struct paravirt_ops
 	void (*flush_tlb_kernel)(void);
 	void (*flush_tlb_single)(u32 addr);
 =

-	void (*alloc_pt)(u32 pfn);
+	void (*alloc_pt)(struct mm_struct *mm, u32 pfn);
 	void (*alloc_pd)(u32 pfn);
 	void (*alloc_pd_clone)(u32 pfn, u32 clonepfn, u32 start, u32 count);
 	void (*release_pt)(u32 pfn);
@@ -650,6 +652,12 @@ static inline void setup_secondary_clock
 }
 #endif
 =

+static inline void paravirt_post_allocator_init(void)
+{
+	if (paravirt_ops.post_allocator_init)
+		(*paravirt_ops.post_allocator_init)();
+}
+
 static inline void paravirt_pagetable_setup_start(pgd_t *base)
 {
 	if (paravirt_ops.pagetable_setup_start)
@@ -697,7 +705,7 @@ static inline void paravirt_init_pda(str
 #define __flush_tlb_global()	PVOP_VCALL0(flush_tlb_kernel)
 #define __flush_tlb_single(addr) PVOP_VCALL1(flush_tlb_single, addr)
 =

-#define paravirt_alloc_pt(pfn)	PVOP_VCALL1(alloc_pt, pfn)
+#define paravirt_alloc_pt(mm, pfn)	PVOP_VCALL2(alloc_pt, mm, pfn)
 #define paravirt_release_pt(pfn) PVOP_VCALL1(release_pt, pfn)
 =

 #define paravirt_alloc_pd(pfn)	PVOP_VCALL1(alloc_pd, pfn)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgalloc.h
+++ b/include/asm-i386/pgalloc.h
@@ -8,7 +8,7 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-#define paravirt_alloc_pt(pfn) do { } while (0)
+#define paravirt_alloc_pt(mm, pfn) do { } while (0)
 #define paravirt_alloc_pd(pfn) do { } while (0)
 #define paravirt_alloc_pd(pfn) do { } while (0)
 #define paravirt_alloc_pd_clone(pfn, clonepfn, start, count) do { } while =
(0)
@@ -18,13 +18,13 @@
 =

 #define pmd_populate_kernel(mm, pmd, pte)			\
 do {								\
-	paravirt_alloc_pt(__pa(pte) >> PAGE_SHIFT);		\
+	paravirt_alloc_pt(mm, __pa(pte) >> PAGE_SHIFT);		\
 	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)));		\
 } while (0)
 =

 #define pmd_populate(mm, pmd, pte) 				\
 do {								\
-	paravirt_alloc_pt(page_to_pfn(pte));			\
+	paravirt_alloc_pt(mm, page_to_pfn(pte));		\
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
 			(unsigned long long) PAGE_SHIFT)));	\
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -79,6 +79,10 @@ void __init add_memory_region(unsigned l
 =

 extern unsigned long init_pg_tables_end;
 =

+#ifndef CONFIG_PARAVIRT
+#define paravirt_post_allocator_init()	do {} while(0)
+#endif
+
 #endif /* __ASSEMBLY__ */
 =

 #endif  /*  __KERNEL__  */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -93,6 +93,7 @@
 =

 /* PG_owner_priv_1 users should have descriptive aliases */
 #define PG_checked		PG_owner_priv_1 /* Used by some filesystems */
+#define PG_pinned		PG_owner_priv_1	/* Xen pinned pagetable */
 =

 #if (BITS_PER_LONG > 32)
 /*
@@ -170,6 +171,10 @@ static inline void SetPageUptodate(struc
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 #define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
+
+#define PagePinned(page)	test_bit(PG_pinned, &(page)->flags)
+#define SetPagePinned(page)	set_bit(PG_pinned, &(page)->flags)
+#define ClearPagePinned(page)	clear_bit(PG_pinned, &(page)->flags)
 =

 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)

-- =
