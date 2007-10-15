From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 12/12] xfs: eagerly remove vmap mappings to
	avoid upsetting Xen
Date: Mon, 15 Oct 2007 13:48:52 -0700
Message-ID: <20071015210115.506967748@goop.org>
References: <20071015204840.074767068@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=xen-xfs-unmap.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, xen-devel@lists.xensource.com, XFS masters <xfs-masters@oss.sgi.com>, Mark Williamson <mark.williamson@cl.cam.ac.uk>, David Chinner <dgc@sgi.com>, LKML <linux-kernel@vger.kernel.org>, Morten =?utf-8?q?B=C3=B8geskov?= <xen-users@morten.bogeskov.dk>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

XFS leaves stray mappings around when it vmaps memory to make it
virtually contigious.  This upsets Xen if one of those pages is being
recycled into a pagetable, since it finds an extra writable mapping of
the page.

This patch solves the problem in a brute force way, by making XFS
always eagerly unmap its mappings.  David Chinner says this shouldn't
have any performance impact on filesystems with default block sizes;
it will only affect filesystems with large block sizes.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: David Chinner <dgc@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: XFS masters <xfs-masters@oss.sgi.com>
Cc: Stable kernel <stable@kernel.org>
Cc: Morten =?utf-8?q?B=C3=B8geskov?= <xen-users@morten.bogeskov.dk>
Cc: Mark Williamson <mark.williamson@cl.cam.ac.uk>

---
 fs/xfs/linux-2.6/xfs_buf.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

===================================================================
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -186,6 +186,19 @@ free_address(
 	void		*addr)
 {
 	a_list_t	*aentry;
+
+#ifdef CONFIG_XEN
+	/*
+	 * Xen needs to be able to make sure it can get an exclusive
+	 * RO mapping of pages it wants to turn into a pagetable.  If
+	 * a newly allocated page is also still being vmap()ed by xfs,
+	 * it will cause pagetable construction to fail.  This is a
+	 * quick workaround to always eagerly unmap pages so that Xen
+	 * is happy.
+	 */
+	vunmap(addr);
+	return;
+#endif
 
 	aentry = kmalloc(sizeof(a_list_t), GFP_NOWAIT);
 	if (likely(aentry)) {

-- 
