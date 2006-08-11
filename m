From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 2/9] 00mm2 pte clear not present.patch
Date: Fri, 11 Aug 2006 02:17:41 -0700
Message-ID: <200608110917.k7B9Hf5i023330@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Change pte_clear_full to a more appropriately named pte_clear_not_present,
allowing optimizations when not-present mapping changes need not be
reflected in the hardware TLB for protected page table modes.  There is
also another case that can use it in the fremap code.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-generic/pgtable.h |    4 ++--
 mm/fremap.c                   |    2 +-
 mm/memory.c                   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -110,8 +110,13 @@ do {				  					  \
 })
 #endif
 =

-#ifndef __HAVE_ARCH_PTE_CLEAR_FULL
-#define pte_clear_full(__mm, __address, __ptep, __full)			\
+/*
+ * Some architectures may be able to avoid expensive synchronization
+ * primitives when modifications are made to PTE's which are already
+ * not present, or in the process of an address space destruction.
+ */
+#ifndef __HAVE_ARCH_PTE_CLEAR_NOT_PRESENT_FULL
+#define pte_clear_not_present_full(__mm, __address, __ptep, __full)	\
 do {									\
 	pte_clear((__mm), (__address), (__ptep));			\
 } while (0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -39,7 +39,7 @@ static int zap_pte(struct mm_struct *mm,
 	} else {
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(mm, addr, ptep);
+		pte_clear_not_present_full(mm, addr, ptep, 0);
 	}
 	return !!page;
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -689,7 +689,7 @@ static unsigned long zap_pte_range(struc
 			continue;
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
-		pte_clear_full(mm, addr, pte, tlb->fullmm);
+		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr +=3D PAGE_SIZE, (addr !=3D end && *zap_work > 0));
 =

 	add_mm_rss(mm, file_rss, anon_rss);
