From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: pgd_alloc and [cd]tors
Date: Thu, 16 Nov 2006 17:28:58 -0800
Message-ID: <20061117012858.GJ1397@sequoia.sous-sol.org>
References: <455D0773.2050906@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <455D0773.2050906@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Is there any real use in having a ctor/dtor for the pgd cache?  Given
> that all pgd allocation happens via pgd_alloc/pgd_free, why not just
> fold the [cd]tor in?

I don't see their value either.

> I'm asking because Xen wants pgd[3] to be unshared in the PAE case, and
> it looks to me like the easiest way to handle that is by making
> pgd_alloc/free pv-ops and doing the appropriate thing in the Xen code. =

> Would need to sort out the vmalloc mapping replication as well, but I
> think that's pretty straightforward.

Here's an old patch from Zach that seems to address the issue at least
in part.  It from back when we were doing subarch, but I think you can
see the attempt.


commit edb15f3f5e925d649b4dd28b0b430bea1a4c8fb4
Author: Zachary Amsden <zach@vmware.com>
Date:   Wed Aug 24 14:43:14 2005 -0700

    [PATCH] Add pagetable allocation notifiers
    =

    Hooks are provided for the mach-XXX subarchitecture at the time prior t=
o a
    page being used as a page table at all levels, for PAE and non-PAE kern=
els.
    Note that in PAE mode, multiple PDP roots may exist on the same page wi=
th
    other data, so the root must be shadowed instead.  This is not a perfor=
mance
    issue, since PAE only uses 4 top level PDPEs.
    =

    The hooks are:
    =

    SetPagePTE(ppn) - indicates that a given physical page is going to be u=
sed
    as a page table.
    =

    SetPagePDE(ppn) - indicates that a given physical page is going to be u=
sed
    as a page directory.
    =

    ClearPageXXX(ppn) - indicates that the physical page is now done being
    used as a certain type of page.
    =

    These hooks can be used in two ways; for shadow mode, they serve as
    requests to pre-allocate and deallocate shadow page tables, and for
    direct page table mode, they serve as write protect/unprotect requests.
    =

    Signed-off-by: Zachary Amsden <zach@vmware.com>
    Signed-off-by: Chris Wright <chrisw@osdl.org>

diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index a65155e..853e5a9 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -59,6 +59,7 @@ static pmd_t * __init one_md_table_init(
 		=

 #ifdef CONFIG_X86_PAE
 	pmd_table =3D (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	SetPagePDE(virt_to_page(pmd_table));
 	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 	pud =3D pud_offset(pgd, 0);
 	if (pmd_table !=3D pmd_offset(pud, 0)) =

@@ -79,6 +80,7 @@ static pte_t * __init one_page_table_ini
 {
 	if (pmd_none(*pmd)) {
 		pte_t *page_table =3D (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		SetPagePTE(virt_to_page(page_table));
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		if (page_table !=3D pte_offset_kernel(pmd, 0))
 			BUG();	=

@@ -312,6 +314,7 @@ static void __init pagetable_init (void)
 #ifdef CONFIG_X86_PAE
 	int i;
 	/* Init entries of the first-level page table to the zero page */
+	SetPagePDE(virt_to_page(empty_zero_page));
 	for (i =3D 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
 #endif
diff --git a/arch/i386/mm/pageattr.c b/arch/i386/mm/pageattr.c
index f600fc2..3c674b5 100644
--- a/arch/i386/mm/pageattr.c
+++ b/arch/i386/mm/pageattr.c
@@ -52,6 +52,7 @@ static struct page *split_large_page(uns
 	address =3D __pa(address);
 	addr =3D address & LARGE_PAGE_MASK; =

 	pbase =3D (pte_t *)page_address(base);
+	SetPagePTE(virt_to_page(pbase));
 	for (i =3D 0; i < PTRS_PER_PTE; i++, addr +=3D PAGE_SIZE) {
                set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
                                           addr =3D=3D address ? prot : PAG=
E_KERNEL));
@@ -146,6 +147,7 @@ __change_page_attr(struct page *page, pg
 		BUG_ON(!page_count(kpte_page));
 =

 		if (cpu_has_pse && (page_count(kpte_page) =3D=3D 1)) {
+			ClearPagePTE(virt_to_page(kpte));
 			list_add(&kpte_page->lru, &df_list);
 			revert_page(kpte_page, address);
 		}
diff --git a/arch/i386/mm/pgtable.c b/arch/i386/mm/pgtable.c
index dcdce2c..dd41ce2 100644
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -209,6 +209,7 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 =

 	if (PTRS_PER_PMD =3D=3D 1) {
 		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+		SetPagePDE(virt_to_page(pgd));
 		spin_lock_irqsave(&pgd_lock, flags);
 	}
 =

@@ -227,6 +228,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 {
 	unsigned long flags; /* can be called from interrupt context */
 =

+	ClearPagePDE(virt_to_page(pgd));
 	spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
@@ -244,13 +246,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		pmd_t *pmd =3D kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
+		SetPagePDE(virt_to_page(pmd));
 		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
 	}
 	return pgd;
 =

 out_oom:
-	for (i--; i >=3D 0; i--)
+	for (i--; i >=3D 0; i--) {
+		ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
 		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -261,8 +266,10 @@ void pgd_free(pgd_t *pgd)
 =

 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i =3D 0; i < USER_PTRS_PER_PGD; ++i)
+		for (i =3D 0; i < USER_PTRS_PER_PGD; ++i) {
+			ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
 			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
diff --git a/include/asm-i386/mach-default/mach_pgalloc.h b/include/asm-i38=
6/mach-default/mach_pgalloc.h
index 68e9bae..5ab6fed 100644
--- a/include/asm-i386/mach-default/mach_pgalloc.h
+++ b/include/asm-i386/mach-default/mach_pgalloc.h
@@ -1,7 +1,40 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
 #ifndef __ASM_MACH_PGALLOC_H
 #define __ASM_MACH_PGALLOC_H
 =

+/*
+ * These hooks allow the hypervisor to be notified about page type
+ * transition events.
+ */
+
+#define SetPagePTE(_page)
+#define ClearPagePTE(_page)
+#define SetPagePDE(_page)
+#define ClearPagePDE(_page)
+
 #define SetPagesLDT(_va, _pages)
 #define ClearPagesLDT(_va, _pages)
 =

-#endif
+#endif /* _ASM_MACH_PGALLOC_H */
diff --git a/include/asm-i386/pgalloc.h b/include/asm-i386/pgalloc.h
index 0380c3d..d43978f 100644
--- a/include/asm-i386/pgalloc.h
+++ b/include/asm-i386/pgalloc.h
@@ -5,14 +5,22 @@
 #include <asm/fixmap.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
+#include <mach_pgalloc.h>
 =

-#define pmd_populate_kernel(mm, pmd, pte) \
-		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
+#define pmd_populate_kernel(mm, pmd, pte) 			\
+do {								\
+	SetPagePTE(virt_to_page(pte));				\
+	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)));		\
+} while (0)
 =

 #define pmd_populate(mm, pmd, pte) 				\
+do {								\
+	SetPagePTE(pte);					\
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
-			(unsigned long long) PAGE_SHIFT)))
+			(unsigned long long) PAGE_SHIFT)));	\
+} while (0)
+
 /*
  * Allocate and free page tables.
  */
@@ -33,7 +41,11 @@ static inline void pte_free(struct page
 }
 =

 =

-#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) 		\
+do {						\
+	tlb_remove_page((tlb),(pte));		\
+	ClearPagePTE(pte);			\
+} while (0)
 =

 #ifdef CONFIG_X86_PAE
 /*
