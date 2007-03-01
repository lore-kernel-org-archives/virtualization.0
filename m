From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 01/26] Xen-paravirt_ops: Fix typo in sync_constant_test_bit()s
	name.
Date: Thu, 01 Mar 2007 15:24:44 -0800
Message-ID: <20070301232525.663955593@goop.org>
References: <20070301232443.195603797@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=fix-sync-bitops.patch
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-i386/sync_bitops.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/sync_bitops.h
+++ b/include/asm-i386/sync_bitops.h
@@ -130,7 +130,7 @@ static inline int sync_test_and_change_b
 	return oldbit;
 }
 =

-static __always_inline int sync_const_test_bit(int nr, const volatile unsi=
gned long *addr)
+static __always_inline int sync_constant_test_bit(int nr, const volatile u=
nsigned long *addr)
 {
 	return ((1UL << (nr & 31)) &
 		(((const volatile unsigned int *)addr)[nr >> 5])) !=3D 0;

-- =
