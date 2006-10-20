From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 4/5] Fix bad mmu names.patch
Date: Thu, 19 Oct 2006 17:09:22 -0700
Message-ID: <200610200009.k9K09MvZ027576@zach-dev.vmware.com>
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
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Make parameter names match function argument names for the yet
to be defined pte_update_defer accessor.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r c7f79c35c160 include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Thu Oct 19 03:03:24 2006 -0700
+++ b/include/asm-i386/pgtable.h	Thu Oct 19 03:11:31 2006 -0700
@@ -275,7 +275,7 @@ do {									\
 do {									\
 	if (dirty) {							\
 		(ptep)->pte_low =3D (entry).pte_low;			\
-		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
+		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
 		flush_tlb_page(vma, address);				\
 	}								\
 } while (0)
@@ -305,7 +305,7 @@ do {									\
 	__dirty =3D pte_dirty(*(ptep));					\
 	if (__dirty) {							\
 		clear_bit(_PAGE_BIT_DIRTY, &(ptep)->pte_low);		\
-		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
+		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
 		flush_tlb_page(vma, address);				\
 	}								\
 	__dirty;							\
@@ -318,7 +318,7 @@ do {									\
 	__young =3D pte_young(*(ptep));					\
 	if (__young) {							\
 		clear_bit(_PAGE_BIT_ACCESSED, &(ptep)->pte_low);	\
-		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
+		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
 		flush_tlb_page(vma, address);				\
 	}								\
 	__young;							\
