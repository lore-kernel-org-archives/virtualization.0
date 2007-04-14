From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 19/28] Dont implement native_kmap_atomic_pte for !HIGHPTE
Date: Sat, 14 Apr 2007 13:42:13 -0700
Message-ID: <20070414204924.796018144@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-kmap_atomic_pte-tidy.patch
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Don't implement native_kmap_atomic_pte for !HIGHPTE case; it is never neede=
d,
never called, and leaving it in is just plain confusing.  Making it isolated
to the config where it is used may help find bugs.

From: Zachary Amsden <zach@vmware.com>
Signed-off-by: Zachary Amsden <zach@vmware.com>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/paravirt.c |    4 +---
 include/asm-i386/highmem.h  |    5 -----
 include/asm-i386/paravirt.h |    4 ++++
 3 files changed, 5 insertions(+), 8 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -318,9 +318,7 @@ struct paravirt_ops paravirt_ops =3D {
 	.ptep_get_and_clear =3D native_ptep_get_and_clear,
 =

 #ifdef CONFIG_HIGHPTE
-	.kmap_atomic_pte =3D native_kmap_atomic_pte,
-#else
-	.kmap_atomic_pte =3D paravirt_nop,
+	.kmap_atomic_pte =3D kmap_atomic,
 #endif
 =

 #ifdef CONFIG_X86_PAE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/highmem.h
+++ b/include/asm-i386/highmem.h
@@ -74,11 +74,6 @@ void *kmap_atomic_pfn(unsigned long pfn,
 void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
 struct page *kmap_atomic_to_page(void *ptr);
 =

-static inline void *native_kmap_atomic_pte(struct page *page, enum km_type=
 type)
-{
-	return kmap_atomic(page, type);
-}
-
 #ifndef CONFIG_PARAVIRT
 #define kmap_atomic_pte(page, type)	kmap_atomic(page, type)
 #endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -190,7 +190,9 @@ struct paravirt_ops
 =

  	pte_t (*ptep_get_and_clear)(pte_t *ptep);
 =

+#ifdef CONFIG_HIGHPTE
 	void *(*kmap_atomic_pte)(struct page *page, enum km_type type);
+#endif
 =

 #ifdef CONFIG_X86_PAE
 	void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
@@ -759,12 +761,14 @@ static inline void paravirt_release_pd(u
 	PVOP_VCALL1(release_pd, pfn);
 }
 =

+#ifdef CONFIG_HIGHPTE
 static inline void *kmap_atomic_pte(struct page *page, enum km_type type)
 {
 	unsigned long ret;
 	ret =3D PVOP_CALL2(unsigned long, kmap_atomic_pte, page, type);
 	return (void *)ret;
 }
+#endif
 =

 static inline void pte_update(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)

-- =
