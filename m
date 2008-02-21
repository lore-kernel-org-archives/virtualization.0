From: yamahata@valinux.co.jp
Subject: [PATCH 21/28] ia64/xen: define xen related address conversion helper
	functions for domU
Date: Thu, 21 Feb 2008 18:17:52 +0900
Message-ID: <20080221091905.122606000__27443.5476320379$1203635230$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GV17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0021-ia64-xen-define-xen-related-address-conversion-help.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/page.h     |   11 +++++++++++
 include/asm-ia64/xen/page.h |   19 +++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/xen/page.h

diff --git a/include/asm-ia64/page.h b/include/asm-ia64/page.h
index 4999a6c..effd2af 100644
--- a/include/asm-ia64/page.h
+++ b/include/asm-ia64/page.h
@@ -227,4 +227,15 @@ get_order (unsigned long size)
 					 (((current->personality & READ_IMPLIES_EXEC) != 0)	\
 					  ? VM_EXEC : 0))
 
+#ifndef __ASSEMBLY__
+
+#include <linux/kernel.h>
+
+#ifdef CONFIG_XEN
+
+#include <asm/xen/page.h>
+
+#endif /* CONFIG_XEN */
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_IA64_PAGE_H */
diff --git a/include/asm-ia64/xen/page.h b/include/asm-ia64/xen/page.h
new file mode 100644
index 0000000..9ab8148
--- /dev/null
+++ b/include/asm-ia64/xen/page.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_IA64_MADDR_H
+#define _ASM_IA64_MADDR_H
+
+#include <linux/kernel.h>
+#include <asm/xen/hypervisor.h>
+#include <asm/xen/hypercall.h>
+#include <xen/features.h>
+#include <xen/interface/xen.h>
+
+#define mfn_to_pfn(mfn) (mfn)
+#define pfn_to_mfn(pfn) (pfn)
+
+#define mfn_to_virt(mfn) (__va((mfn) << PAGE_SHIFT))
+#define virt_to_mfn(virt) (__pa(virt) >> PAGE_SHIFT)
+#define virt_to_machine(virt) __pa(virt) /* for tpmfront.c */
+
+#define set_phys_to_machine(pfn, mfn) do { } while (0)
+
+#endif /* _ASM_IA64_MADDR_H */
-- 
1.5.3

-- 
yamahata
