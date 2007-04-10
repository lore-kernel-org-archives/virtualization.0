From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 5/10] Paravirt kmap_atomic_pte tidy.patch
Date: Mon, 9 Apr 2007 17:06:14 -0700
Message-ID: <200704100006.l3A06Enx020620@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Don't implement native_kmap_atomic_pte for !HIGHPTE case; it is never neede=
d,
never called, and leaving it in is just plain confusing.  Making it isolated
to the config where it is used may help find bugs.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 5c03805411a6 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Fri Apr 06 14:43:30 2007 -0700
+++ b/arch/i386/kernel/paravirt.c	Fri Apr 06 14:43:37 2007 -0700
@@ -217,13 +217,6 @@ static void native_flush_tlb_single(unsi
 {
 	__native_flush_tlb_single(addr);
 }
-
-#ifndef CONFIG_HIGHPTE
-static void *native_kmap_atomic_pte(struct page *page, enum km_type type)
-{
-	return kmap_atomic(page, type);
-}
-#endif
 =

 /* These are in entry.S */
 extern void native_iret(void);
@@ -324,7 +317,9 @@ struct paravirt_ops paravirt_ops =3D {
 =

 	.ptep_get_and_clear =3D native_ptep_get_and_clear,
 =

-	.kmap_atomic_pte =3D native_kmap_atomic_pte,
+#ifdef CONFIG_HIGHPTE
+	.kmap_atomic_pte =3D kmap_atomic,
+#endif
 =

 #ifdef CONFIG_X86_PAE
 	.set_pte_atomic =3D native_set_pte_atomic,
diff -r 5c03805411a6 include/asm-i386/highmem.h
--- a/include/asm-i386/highmem.h	Fri Apr 06 14:43:30 2007 -0700
+++ b/include/asm-i386/highmem.h	Fri Apr 06 14:43:37 2007 -0700
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
diff -r 5c03805411a6 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Fri Apr 06 14:43:30 2007 -0700
+++ b/include/asm-i386/paravirt.h	Fri Apr 06 14:43:37 2007 -0700
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
@@ -892,12 +894,14 @@ static inline void paravirt_release_pd(u
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
