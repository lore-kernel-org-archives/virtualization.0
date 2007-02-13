From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 06/21] Xen-paravirt: remove ctor for pgd cache
Date: Tue, 13 Feb 2007 14:17:35 -0800
Message-ID: <20070213221829.929261125@goop.org>
References: <20070213221729.772002682@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=remove-pgd-ctor.patch
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Remove the ctor for the pgd cache.  There's no point in having the
cache machinery do this via an indirect call when all pgd are freed in
the one place anyway.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -739,11 +739,9 @@ void __init pgtable_cache_init(void)
 			panic("pgtable_cache_init(): cannot create pmd cache");
 	}
 	pgd_cache =3D kmem_cache_create("pgd",
-				PTRS_PER_PGD*sizeof(pgd_t),
-				PTRS_PER_PGD*sizeof(pgd_t),
-				0,
-				pgd_ctor,
-				PTRS_PER_PMD =3D=3D 1 ? pgd_dtor : NULL);
+				      PTRS_PER_PGD*sizeof(pgd_t),
+				      PTRS_PER_PGD*sizeof(pgd_t),
+				      0, NULL, NULL);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -236,7 +236,7 @@ static inline void pgd_list_del(pgd_t *p
 		set_page_private(next, (unsigned long)pprev);
 }
 =

-void pgd_ctor(void *pgd, struct kmem_cache *cache, unsigned long unused)
+static void pgd_ctor(pgd_t *pgd)
 {
 	unsigned long flags;
 =

@@ -245,7 +245,7 @@ void pgd_ctor(void *pgd, struct kmem_cac
 		spin_lock_irqsave(&pgd_lock, flags);
 	}
 =

-	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
+	clone_pgd_range(pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
 			KERNEL_PGD_PTRS);
 =

@@ -261,10 +261,12 @@ void pgd_ctor(void *pgd, struct kmem_cac
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 =

-/* never called when PTRS_PER_PMD > 1 */
-void pgd_dtor(void *pgd, struct kmem_cache *cache, unsigned long unused)
+static void pgd_dtor(pgd_t *pgd)
 {
 	unsigned long flags; /* can be called from interrupt context */
+
+	if (PTRS_PER_PMD =3D=3D 1)
+		return;
 =

 	paravirt_release_pd(__pa(pgd) >> PAGE_SHIFT);
 	spin_lock_irqsave(&pgd_lock, flags);
@@ -276,6 +278,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd =3D kmem_cache_alloc(pgd_cache, GFP_KERNEL);
+
+	if (pgd)
+		pgd_ctor(pgd);
 =

 	if (PTRS_PER_PMD =3D=3D 1 || !pgd)
 		return pgd;
@@ -296,6 +301,7 @@ out_oom:
 		paravirt_release_pd(__pa(pmd) >> PAGE_SHIFT);
 		kmem_cache_free(pmd_cache, pmd);
 	}
+	pgd_dtor(pgd);
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -313,5 +319,6 @@ void pgd_free(pgd_t *pgd)
 			kmem_cache_free(pmd_cache, pmd);
 		}
 	/* in the non-PAE case, free_pgtables() clears user pgd entries */
+	pgd_dtor(pgd);
 	kmem_cache_free(pgd_cache, pgd);
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -41,8 +41,6 @@ extern struct page *pgd_list;
 extern struct page *pgd_list;
 =

 void pmd_ctor(void *, struct kmem_cache *, unsigned long);
-void pgd_ctor(void *, struct kmem_cache *, unsigned long);
-void pgd_dtor(void *, struct kmem_cache *, unsigned long);
 void pgtable_cache_init(void);
 void paging_init(void);
 =


-- =
