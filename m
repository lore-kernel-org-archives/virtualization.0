From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 46/50] ia64/xen: define xen related address conversion helper
	functions for domU
Date: Thu,  6 Mar 2008 03:19:01 +0900
Message-ID: <12047411464035-git-send-email-yamahata__16207.2208164775$1204743699$gmane$org@valinux.co.jp>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12047411453864-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/page.h     |    8 ++++++++
 include/asm-ia64/xen/page.h |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/xen/page.h

diff --git a/include/asm-ia64/page.h b/include/asm-ia64/page.h
index 4999a6c..5508dc2 100644
--- a/include/asm-ia64/page.h
+++ b/include/asm-ia64/page.h
@@ -227,4 +227,12 @@ get_order (unsigned long size)
 					 (((current->personality & READ_IMPLIES_EXEC) != 0)	\
 					  ? VM_EXEC : 0))
 
+/*
+ * XXX: to compile
+ * after pv_ops'fication of xen paravirtualization, this should be removed.
+ */
+#if !defined(__ASSEMBLY__) && defined(CONFIG_XEN)
+#include <asm/xen/page.h>
+#endif /* !__ASSEMBLY__ && CONFIG_XEN */
+
 #endif /* _ASM_IA64_PAGE_H */
diff --git a/include/asm-ia64/xen/page.h b/include/asm-ia64/xen/page.h
new file mode 100644
index 0000000..c562036
--- /dev/null
+++ b/include/asm-ia64/xen/page.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_IA64_XEN_PAGE_H
+#define _ASM_IA64_XEN_PAGE_H
+
+#include <linux/kernel.h>
+#include <asm/xen/hypervisor.h>
+#include <asm/xen/hypercall.h>
+#include <xen/features.h>
+#include <xen/interface/xen.h>
+
+static inline unsigned long mfn_to_pfn(unsigned long mfn)
+{
+	return mfn;
+}
+
+static inline unsigned long pfn_to_mfn(unsigned long pfn)
+{
+	return pfn;
+}
+
+static inline void *mfn_to_virt(unsigned long mfn)
+{
+	return __va(mfn << PAGE_SHIFT);
+}
+
+static inline unsigned long virt_to_mfn(void *virt)
+{
+	return __pa(virt) >> PAGE_SHIFT;
+}
+
+/* for tpmfront.c */
+static inline unsigned long virt_to_machine(void *virt)
+{
+	return __pa(virt);
+}
+
+static inline void set_phys_to_machine(unsigned long pfn, unsigned long mfn)
+{
+	/* nothing */
+}
+
+#endif /* _ASM_IA64_XEN_PAGE_H */
-- 
1.5.3
