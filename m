From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 1/9] 00mm1 remove read hazard from cow.patch
Date: Fri, 11 Aug 2006 02:17:04 -0700
Message-ID: <200608110917.k7B9H3Zw023324@zach-dev.vmware.com>
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

We don't want to read PTEs directly like this after they have been
modified, as a lazy MMU implementation of direct page tables may not
have written the updated PTE back to memory yet.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: linux-mm@kvack.org

---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -466,7 +466,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 */
 	if (is_cow_mapping(vm_flags)) {
 		ptep_set_wrprotect(src_mm, addr, src_pte);
-		pte =3D *src_pte;
+		pte =3D pte_wrprotect(pte);
 	}
 =

 	/*
