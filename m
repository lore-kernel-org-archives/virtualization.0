From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 26/33] ia64/pv_ops/xen: define the nubmer of irqs which xen
	needs.
Date: Fri, 17 Oct 2008 11:18:06 +0900
Message-ID: <1224209893-2032-27-git-send-email-yamahata__38853.6898572513$1224214093$gmane$org@valinux.co.jp>
References: <1224209893-2032-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1224209893-2032-1-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, mingo@elte.hu, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

define arch/ia64/include/asm/xen/irq.h to define the number of
irqs which xen needs.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/include/asm/xen/irq.h |   44 +++++++++++++++++++++++++++++++++++++++
 arch/ia64/kernel/nr-irqs.c      |    1 +
 2 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 arch/ia64/include/asm/xen/irq.h

diff --git a/arch/ia64/include/asm/xen/irq.h b/arch/ia64/include/asm/xen/irq.h
new file mode 100644
index 0000000..a904509
--- /dev/null
+++ b/arch/ia64/include/asm/xen/irq.h
@@ -0,0 +1,44 @@
+/******************************************************************************
+ * arch/ia64/include/asm/xen/irq.h
+ *
+ * Copyright (c) 2008 Isaku Yamahata <yamahata at valinux co jp>
+ *                    VA Linux Systems Japan K.K.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef _ASM_IA64_XEN_IRQ_H
+#define _ASM_IA64_XEN_IRQ_H
+
+/*
+ * The flat IRQ space is divided into two regions:
+ *  1. A one-to-one mapping of real physical IRQs. This space is only used
+ *     if we have physical device-access privilege. This region is at the
+ *     start of the IRQ space so that existing device drivers do not need
+ *     to be modified to translate physical IRQ numbers into our IRQ space.
+ *  3. A dynamic mapping of inter-domain and Xen-sourced virtual IRQs. These
+ *     are bound using the provided bind/unbind functions.
+ */
+
+#define XEN_PIRQ_BASE		0
+#define XEN_NR_PIRQS		256
+
+#define XEN_DYNIRQ_BASE		(XEN_PIRQ_BASE + XEN_NR_PIRQS)
+#define XEN_NR_DYNIRQS		(NR_CPUS * 8)
+
+#define XEN_NR_IRQS		(XEN_NR_PIRQS + XEN_NR_DYNIRQS)
+
+#endif /* _ASM_IA64_XEN_IRQ_H */
diff --git a/arch/ia64/kernel/nr-irqs.c b/arch/ia64/kernel/nr-irqs.c
index 8273afc..ee56457 100644
--- a/arch/ia64/kernel/nr-irqs.c
+++ b/arch/ia64/kernel/nr-irqs.c
@@ -10,6 +10,7 @@
 #include <linux/kbuild.h>
 #include <linux/threads.h>
 #include <asm/native/irq.h>
+#include <asm/xen/irq.h>
 
 void foo(void)
 {
-- 
1.6.0.2
