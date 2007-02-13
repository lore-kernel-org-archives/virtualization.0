From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 08/21] Xen-paravirt: Allow paravirt backend to select PGD
	allocation alignment
Date: Tue, 13 Feb 2007 14:17:37 -0800
Message-ID: <20070213221830.082009033@goop.org>
References: <20070213221729.772002682@goop.org>
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
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Xen requires pgds to be page-aligned, so make this a parameter which
can be set in the paravirt_ops structure.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

--
 arch/i386/kernel/paravirt.c |    1 +
 arch/i386/mm/init.c         |    2 +-
 include/asm-i386/paravirt.h |    5 ++++-
 include/asm-i386/pgtable.h  |    6 ++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

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
