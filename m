From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 01/20] XEN-paravirt: Fix typo in
	sync_constant_test_bit()s name.
Date: Fri, 12 Jan 2007 17:45:40 -0800
Message-ID: <20070113014647.100536225@goop.org>
References: <20070113014539.408244126@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=fix-sync-bitops.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@osdl.org>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Fix typo in sync_constant_test_bit()s name.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

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
