From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 07/33] xen: paravirt: export __supported_pte_mask
Date: Tue, 22 May 2007 15:09:48 +0100
Message-ID: <20070522141251.429681560@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-export-supported_pte_mask.patch
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

__supported_pte_mask is needed when constructing pte values.  Xen
device drivers need to do this to make mappings of foreign pages (ie,
pages granted to us by other domains).

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/i386/mm/init.c |    1 +
 1 file changed, 1 insertion(+)

===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -473,6 +473,7 @@ void zap_low_mappings (void)
 
 static int disable_nx __initdata = 0;
 u64 __supported_pte_mask __read_mostly = ~_PAGE_NX;
+EXPORT_SYMBOL_GPL(__supported_pte_mask);
 
 /*
  * noexec = on|off

-- 
