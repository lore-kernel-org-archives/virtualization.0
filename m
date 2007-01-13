From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 08/20] XEN-paravirt: paravirt pgd allocation alignment
Date: Fri, 12 Jan 2007 17:45:47 -0800
Message-ID: <20070113014647.898074336@goop.org>
References: <20070113014539.408244126@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=pgd-alignment.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -573,6 +573,7 @@ struct paravirt_ops paravirt_ops =3D {
 	.paravirt_enabled =3D 0,
 	.kernel_rpl =3D 0,
 	.shared_kernel_pmd =3D 1,	/* Only used when CONFIG_X86_PAE is set */
+	.pgd_alignment =3D sizeof(pgd_t) * PTRS_PER_PGD,
 =

  	.patch =3D native_patch,
 	.banner =3D default_banner,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -745,7 +745,7 @@ void __init pgtable_cache_init(void)
 	}
 	pgd_cache =3D kmem_cache_create("pgd",
 				      PTRS_PER_PGD*sizeof(pgd_t),
-				      PTRS_PER_PGD*sizeof(pgd_t),
+				      PGD_ALIGNMENT,
 				      0, NULL, NULL);
 	if (!pgd_cache)
 		panic("pgtable_cache_init(): Cannot create pgd cache");
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -33,9 +33,12 @@ struct mm_struct;
 struct mm_struct;
 struct paravirt_ops
 {
+ 	int paravirt_enabled;
 	unsigned int kernel_rpl;
+
 	int shared_kernel_pmd;
- 	int paravirt_enabled;
+	int pgd_alignment;
+
 	const char *name;
 =

 	/*
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -270,6 +270,12 @@ static inline void vmalloc_sync_all(void
 #define pte_update_defer(mm, addr, ptep)	do { } while (0)
 #endif
 =

+#ifdef CONFIG_PARAVIRT
+#define PGD_ALIGNMENT	(paravirt_ops.pgd_alignment)
+#else
+#define PGD_ALIGNMENT	(sizeof(pgd_t) * PTRS_PER_PGD)
+#endif
+
 /*
  * We only update the dirty/accessed state if we set
  * the dirty bit by hand in the kernel, since the hardware

-- =
