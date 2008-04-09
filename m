From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 11/15] ia64/pv_ops: paravirtualize NR_IRQS
Date: Wed,  9 Apr 2008 13:49:04 +0900
Message-ID: <1207716549755-git-send-email-yamahata__26367.0652908788$1207717285$gmane$org@valinux.co.jp>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1207716548202-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Make NR_IRQ overridable by each pv instances.
Pv instance may need each own number of irqs so that
NR_IRQS should be the maximum number of nr_irqs each
pv instances need.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/irq.h          |   10 ++++++-
 include/asm-ia64/paravirt_irq.h |   49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 include/asm-ia64/paravirt_irq.h

diff --git a/include/asm-ia64/irq.h b/include/asm-ia64/irq.h
index a66d268..0463427 100644
--- a/include/asm-ia64/irq.h
+++ b/include/asm-ia64/irq.h
@@ -17,9 +17,15 @@
 #define NR_VECTORS	256
 
 #if (NR_VECTORS + 32 * NR_CPUS) < 1024
-#define NR_IRQS (NR_VECTORS + 32 * NR_CPUS)
+#define IA64_NATIVE_NR_IRQS (NR_VECTORS + 32 * NR_CPUS)
 #else
-#define NR_IRQS 1024
+#define IA64_NATIVE_NR_IRQS 1024
+#endif
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt_irq.h>
+#else
+#define NR_IRQS IA64_NATIVE_NR_IRQS
 #endif
 
 static __inline__ int
diff --git a/include/asm-ia64/paravirt_irq.h b/include/asm-ia64/paravirt_irq.h
new file mode 100644
index 0000000..7dedf2a
--- /dev/null
+++ b/include/asm-ia64/paravirt_irq.h
@@ -0,0 +1,49 @@
+/******************************************************************************
+ * include/asm-ia64/paravirt_irq.h
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
+#ifndef __ASM_PARAVIRT_IRQ_H
+#define __ASM_PARAVIRT_IRQ_H
+
+#ifdef CONFIG_PARAVIRT
+
+/* Determine the maximal NR_IRQ which each pv instances require.
+ * i.e. NR_IRQS = max(IA64_NATIVE_NR_IRQS, XEN_NR_IRQS, ...)
+ */
+
+#define NR_IRQS 1
+
+#if IA64_NATIVE_NR_IRQS > NR_IRQS
+#undef NR_IRQS
+#define NR_IRQS IA64_NATIVE_NR_IRQS
+#endif
+
+#ifdef CONFIG_XEN
+#include <asm/xen/irq.h>
+#if XEN_NR_IRQS > NR_IRQS
+#undef NR_IRQS
+#define NR_IRQS XEN_NR_IRQS
+#endif
+#endif /* CONFIG_XEN */
+
+#endif /* CONFIG_PARAVIRT */
+
+#endif /* __ASM_PARAVIRT_IRQ_H */
-- 
1.5.3
