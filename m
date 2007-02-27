From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 01/26] Xen-paravirt_ops: Fix typo in sync_constant_test_bit()s name.
Date: Tue, 27 Feb 2007 00:13:38 -0800
Message-ID: <20070227081629.356512263@goop.org>
References: <20070227081337.434798469@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932819AbXB0IiW@vger.kernel.org>
Content-Disposition: inline; filename=fix-sync-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-i386/sync_bitops.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/include/asm-i386/sync_bitops.h
+++ b/include/asm-i386/sync_bitops.h
@@ -130,7 +130,7 @@ static inline int sync_test_and_change_b
 	return oldbit;
 }
 
-static __always_inline int sync_const_test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline int sync_constant_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & 31)) &
 		(((const volatile unsigned int *)addr)[nr >> 5])) != 0;

-- 
