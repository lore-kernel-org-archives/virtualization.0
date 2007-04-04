From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 07/20] Allow paravirt backend to choose kernel PMD sharing
Date: Wed, 04 Apr 2007 12:11:58 -0700
Message-ID: <20070404191205.392155702@goop.org>
References: <20070404191151.009821039@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=shared-kernel-pmd.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

Normally when running in PAE mode, the 4th PMD maps the kernel address
space, which can be shared among all processes (since they all need
the same kernel mappings).

Xen, however, does not allow guests to have the kernel pmd shared
between page tables, so parameterize pgtable.c to allow both modes of
operation.

There are several side-effects of this.  One is that vmalloc will
update the kernel address space mappings, and those updates need to be
propagated into all processes if the kernel mappings are not
intrinsically shared.  In the non-PAE case, this is done by
maintaining a pgd_list of all processes; this list is used when all
process pagetables must be updated.  pgd_list is threaded via
otherwise unused entries in the page structure for the pgd, which
means that the pgd must be page-sized for this to work.

Normally the PAE pgd is only 4x64 byte entries large, but Xen requires
the PAE pgd to page aligned anyway, so this patch forces the pgd to be
page aligned+sized when the kernel pmd is unshared, to accomodate both
these requirements.

Also, since there may be several distinct kernel pmds (if the
user/kernel split is below 3G), there's no point in allocating them
from a slab cache; they're just allocated with get_free_page and
initialized appropriately.  (Of course the could be cached if there is
just a single kernel pmd - which is the default with a 3G user/kernel
split - but it doesn't seem worthwhile to add yet another case into
this code).

[ Many thanks to wli for review comments. ]

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: William Lee Irwin III <wli@holomorphy.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Christoph Lameter <clameter@sgi.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/paravirt.c            |    1 =

 arch/i386/mm/fault.c                   |    6 +-
 arch/i386/mm/init.c                    |   18 +++++-
 arch/i386/mm/pageattr.c                |    2 =

 arch/i386/mm/pgtable.c                 |   84 ++++++++++++++++++++++++++--=
----
 include/asm-i386/paravirt.h            |    1 =

 include/asm-i386/pgtable-2level-defs.h |    2 =

 include/asm-i386/pgtable-2level.h      |    2 =

 include/asm-i386/pgtable-3level-defs.h |    6 ++
 include/asm-i386/pgtable-3level.h      |    2 =

 include/asm-i386/pgtable.h             |    7 ++
 11 files changed, 105 insertions(+), 26 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -604,6 +604,7 @@ struct paravirt_ops paravirt_ops =3D {
 	.name =3D "bare hardware",
 	.paravirt_enabled =3D 0,
 	.kernel_rpl =3D 0,
+	.shared_kernel_pmd =3D 1,	/* Only used when CONFIG_X86_PAE is set */
 =

  	.patch =3D native_patch,
 	.banner =3D default_banner,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -588,8 +588,7 @@ do_sigbus:
 	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
 }
 =

-#ifndef CONFIG_X86_PAE
-void vmalloc_sync_all(void)
+void _vmalloc_sync_all(void)
 {
 	/*
 	 * Note that races in the updates of insync and start aren't
@@ -600,6 +599,8 @@ void vmalloc_sync_all(void)
 	static DECLARE_BITMAP(insync, PTRS_PER_PGD);
 	static unsigned long start =3D TASK_SIZE;
 	unsigned long address;
+
+	BUG_ON(SHARED_KERNEL_PMD);
 =

 	BUILD_BUG_ON(TASK_SIZE & ~PGDIR_MASK);
 	for (address =3D start; address >=3D TASK_SIZE; address +=3D PGDIR_SIZE) {
@@ -623,4 +624,3 @@ void vmalloc_sync_all(void)
 			start =3D address + PGDIR_SIZE;
 	}
 }
-#endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -715,6 +715,8 @@ struct kmem_cache *pmd_cache;
 =

 void __init pgtable_cache_init(void)
 {
+	size_t pgd_size =3D PTRS_PER_PGD*sizeof(pgd_t);
+
 	if (PTRS_PER_PMD > 1) {
 		pmd_cache =3D kmem_cache_create("pmd",
 					PTRS_PER_PMD*sizeof(pmd_t),
@@ -724,13 +726,23 @@ void __init pgtable_cache_init(void)
 					NULL);
 		if (!pmd_cache)
 			panic("pgtable_cache_init(): cannot create pmd cache");
+
+		if (!SHARED_KERNEL_PMD) {
+			/* If we're in PAE mode and have a non-shared
+			   kernel pmd, then the pgd size must be a
+			   page size.  This is because the pgd_list
+			   links through the page structure, so there
+			   can only be one pgd per page for this to
+			   work. */
+			pgd_size =3D PAGE_SIZE;
+		}
 	}
 	pgd_cache =3D kmem_cache_create("pgd",
-				PTRS_PER_PGD*sizeof(pgd_t),
-				PTRS_PER_PGD*sizeof(pgd_t),
+				pgd_size,
+				pgd_size,
 				0,
 				pgd_ctor,
-				PTRS_PER_PMD =3D=3D 1 ? pgd_dtor : NULL);
+				(!SHARED_KERNEL_PMD) ? pgd_dtor : NULL);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/pageattr.c
+++ b/arch/i386/mm/pageattr.c
@@ -91,7 +91,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 	unsigned long flags;
 =

 	set_pte_atomic(kpte, pte); 	/* change init_mm */
-	if (PTRS_PER_PMD > 1)
+	if (SHARED_KERNEL_PMD)
 		return;
 =

 	spin_lock_irqsave(&pgd_lock, flags);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -238,35 +238,56 @@ static inline void pgd_list_del(pgd_t *p
 		set_page_private(next, (unsigned long)pprev);
 }
 =

+#if (PTRS_PER_PMD =3D=3D 1)
+/* Non-PAE pgd constructor */
 void pgd_ctor(void *pgd, struct kmem_cache *cache, unsigned long unused)
 {
 	unsigned long flags;
 =

-	if (PTRS_PER_PMD =3D=3D 1) {
-		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
-		spin_lock_irqsave(&pgd_lock, flags);
-	}
+	/* !PAE, no pagetable sharing */
+	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 =

 	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			KERNEL_PGD_PTRS);
 =

-	if (PTRS_PER_PMD > 1)
-		return;
+	spin_lock_irqsave(&pgd_lock, flags);
 =

 	/* must happen under lock */
 	paravirt_alloc_pd_clone(__pa(pgd) >> PAGE_SHIFT,
-			__pa(swapper_pg_dir) >> PAGE_SHIFT,
-			USER_PTRS_PER_PGD, PTRS_PER_PGD - USER_PTRS_PER_PGD);
+				__pa(swapper_pg_dir) >> PAGE_SHIFT,
+				USER_PTRS_PER_PGD,
+				KERNEL_PGD_PTRS);
 =

 	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
-
-/* never called when PTRS_PER_PMD > 1 */
+#else  /* PTRS_PER_PMD > 1 */
+/* PAE pgd constructor */
+void pgd_ctor(void *pgd, struct kmem_cache *cache, unsigned long unused)
+{
+	/* PAE, kernel PMD may be shared */
+
+	if (SHARED_KERNEL_PMD) {
+		clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
+				swapper_pg_dir + USER_PTRS_PER_PGD,
+				KERNEL_PGD_PTRS);
+	} else {
+		unsigned long flags;
+
+		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
+		spin_lock_irqsave(&pgd_lock, flags);
+		pgd_list_add(pgd);
+		spin_unlock_irqrestore(&pgd_lock, flags);
+	}
+}
+#endif	/* PTRS_PER_PMD */
+
 void pgd_dtor(void *pgd, struct kmem_cache *cache, unsigned long unused)
 {
 	unsigned long flags; /* can be called from interrupt context */
+
+	BUG_ON(SHARED_KERNEL_PMD);
 =

 	paravirt_release_pd(__pa(pgd) >> PAGE_SHIFT);
 	spin_lock_irqsave(&pgd_lock, flags);
@@ -274,6 +295,37 @@ void pgd_dtor(void *pgd, struct kmem_cac
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 =

+#define UNSHARED_PTRS_PER_PGD				\
+	(SHARED_KERNEL_PMD ? USER_PTRS_PER_PGD : PTRS_PER_PGD)
+
+/* If we allocate a pmd for part of the kernel address space, then
+   make sure its initialized with the appropriate kernel mappings.
+   Otherwise use a cached zeroed pmd.  */
+static pmd_t *pmd_cache_alloc(int idx)
+{
+	pmd_t *pmd;
+
+	if (idx >=3D USER_PTRS_PER_PGD) {
+		pmd =3D (pmd_t *)__get_free_page(GFP_KERNEL);
+
+		if (pmd)
+			memcpy(pmd,
+			       (void *)pgd_page_vaddr(swapper_pg_dir[idx]),
+			       sizeof(pmd_t) * PTRS_PER_PMD);
+	} else
+		pmd =3D kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+
+	return pmd;
+}
+
+static void pmd_cache_free(pmd_t *pmd, int idx)
+{
+	if (idx >=3D USER_PTRS_PER_PGD)
+		free_page((unsigned long)pmd);
+	else
+		kmem_cache_free(pmd_cache, pmd);
+}
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
@@ -282,10 +334,12 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (PTRS_PER_PMD =3D=3D 1 || !pgd)
 		return pgd;
 =

-	for (i =3D 0; i < USER_PTRS_PER_PGD; ++i) {
-		pmd_t *pmd =3D kmem_cache_alloc(pmd_cache, GFP_KERNEL);
+ 	for (i =3D 0; i < UNSHARED_PTRS_PER_PGD; ++i) {
+		pmd_t *pmd =3D pmd_cache_alloc(i);
+
 		if (!pmd)
 			goto out_oom;
+
 		paravirt_alloc_pd(__pa(pmd) >> PAGE_SHIFT);
 		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
 	}
@@ -296,7 +350,7 @@ out_oom:
 		pgd_t pgdent =3D pgd[i];
 		void* pmd =3D (void *)__va(pgd_val(pgdent)-1);
 		paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
-		kmem_cache_free(pmd_cache, pmd);
+		pmd_cache_free(pmd, i);
 	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
@@ -308,11 +362,11 @@ void pgd_free(pgd_t *pgd)
 =

 	/* in the PAE case user pgd entries are overwritten before usage */
 	if (PTRS_PER_PMD > 1)
-		for (i =3D 0; i < USER_PTRS_PER_PGD; ++i) {
+		for (i =3D 0; i < UNSHARED_PTRS_PER_PGD; ++i) {
 			pgd_t pgdent =3D pgd[i];
 			void* pmd =3D (void *)__va(pgd_val(pgdent)-1);
 			paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
-			kmem_cache_free(pmd_cache, pmd);
+			pmd_cache_free(pmd, i);
 		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -34,6 +34,7 @@ struct paravirt_ops
 struct paravirt_ops
 {
 	unsigned int kernel_rpl;
+	int shared_kernel_pmd;
  	int paravirt_enabled;
 	const char *name;
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable-2level-defs.h
+++ b/include/asm-i386/pgtable-2level-defs.h
@@ -1,5 +1,7 @@
 #ifndef _I386_PGTABLE_2LEVEL_DEFS_H
 #define _I386_PGTABLE_2LEVEL_DEFS_H
+
+#define SHARED_KERNEL_PMD	0
 =

 /*
  * traditional i386 two-level paging structure:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -65,6 +65,4 @@ static inline int pte_exec_kernel(pte_t =

 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 =

-void vmalloc_sync_all(void);
-
 #endif /* _I386_PGTABLE_2LEVEL_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable-3level-defs.h
+++ b/include/asm-i386/pgtable-3level-defs.h
@@ -1,5 +1,11 @@
 #ifndef _I386_PGTABLE_3LEVEL_DEFS_H
 #define _I386_PGTABLE_3LEVEL_DEFS_H
+
+#ifdef CONFIG_PARAVIRT
+#define SHARED_KERNEL_PMD	(paravirt_ops.shared_kernel_pmd)
+#else
+#define SHARED_KERNEL_PMD	1
+#endif
 =

 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -180,6 +180,4 @@ static inline pmd_t pfn_pmd(unsigned lon
 =

 #define __pmd_free_tlb(tlb, x)		do { } while (0)
 =

-#define vmalloc_sync_all() ((void)0)
-
 #endif /* _I386_PGTABLE_3LEVEL_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -244,6 +244,13 @@ static inline pte_t pte_mkwrite(pte_t pt
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |=3D _PAGE_RW; =
return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |=3D _PAGE_PSE; =
return pte; }
 =

+extern void _vmalloc_sync_all(void);
+static inline void vmalloc_sync_all(void)
+{
+	if (!SHARED_KERNEL_PMD)
+		_vmalloc_sync_all();
+}
+
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else

-- =
