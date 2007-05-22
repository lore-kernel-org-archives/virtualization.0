From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 16/33] xen: xen: add pinned page flag
Date: Tue, 22 May 2007 15:09:57 +0100
Message-ID: <20070522141252.222749334@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=xen-add-pinned-pageflag.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Xen-devel <xen-devel@lists.xensource.com>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add a new definition for PG_owner_priv_1 to define PG_pinned on Xen
pagetable pages.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/linux/page-flags.h |    5 +++++
 1 file changed, 5 insertions(+)

===================================================================
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -93,6 +93,7 @@
 
 /* PG_owner_priv_1 users should have descriptive aliases */
 #define PG_checked		PG_owner_priv_1 /* Used by some filesystems */
+#define PG_pinned		PG_owner_priv_1	/* Xen pinned pagetable */
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -170,6 +171,10 @@ static inline void SetPageUptodate(struc
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 #define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
+
+#define PagePinned(page)	test_bit(PG_pinned, &(page)->flags)
+#define SetPagePinned(page)	set_bit(PG_pinned, &(page)->flags)
+#define ClearPagePinned(page)	clear_bit(PG_pinned, &(page)->flags)
 
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)

-- 
