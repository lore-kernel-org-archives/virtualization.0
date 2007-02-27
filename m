From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 06/26] Xen-paravirt_ops: paravirt_ops: allocate
	a fixmap slot
Date: Tue, 27 Feb 2007 00:13:43 -0800
Message-ID: <20070227081631.122933982@goop.org>
References: <20070227081337.434798469@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-fixmap.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Allocate a fixmap slot for use by a paravirt_ops implementation.  Xen
uses this to map the hypervisor's shared info page, which doesn't have
a pseudo-physical page number, and therefore can't be mapped
ordinarily.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-i386/fixmap.h |    3 +++
 1 file changed, 3 insertions(+)

===================================================================
--- a/include/asm-i386/fixmap.h
+++ b/include/asm-i386/fixmap.h
@@ -86,6 +86,9 @@ enum fixed_addresses {
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
+#ifdef CONFIG_PARAVIRT
+	FIX_PARAVIRT,
+#endif
 	__end_of_permanent_fixed_addresses,
 	/* temporary boot-time mappings, used before ioremap() is functional */
 #define NR_FIX_BTMAPS	16

-- 
