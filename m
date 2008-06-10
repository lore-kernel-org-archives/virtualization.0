From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 12/27] ia64/xen: add definitions necessary for xen event
	channel.
Date: Tue, 10 Jun 2008 16:47:08 +0900
Message-ID: <12130840443862-git-send-email-yamahata__34969.9789112948$1213085380$gmane$org@valinux.co.jp>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840433561-git-send-email-yamahata@valinux.co.jp>
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

Xen paravirtualizes interrupt as event channel.
This patch defines arch specific part of xen event channel.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/xen/events.h |   50 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-ia64/xen/events.h

diff --git a/include/asm-ia64/xen/events.h b/include/asm-ia64/xen/events.h
new file mode 100644
index 0000000..42bb0b5
--- /dev/null
+++ b/include/asm-ia64/xen/events.h
@@ -0,0 +1,50 @@
+/******************************************************************************
+ * include/asm-ia64/xen/events.h
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
+#ifndef _ASM_IA64_XEN_EVENTS_H
+#define _ASM_IA64_XEN_EVENTS_H
+
+enum ipi_vector {
+	XEN_RESCHEDULE_VECTOR,
+	XEN_IPI_VECTOR,
+	XEN_CMCP_VECTOR,
+	XEN_CPEP_VECTOR,
+
+	XEN_NR_IPIS,
+};
+
+static inline int xen_irqs_disabled(struct pt_regs *regs)
+{
+	return !(ia64_psr(regs)->i);
+}
+
+static inline void xen_do_IRQ(int irq, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	old_regs = set_irq_regs(regs);
+	irq_enter();
+	__do_IRQ(irq);
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+#define irq_ctx_init(cpu)	do { } while (0)
+
+#endif /* _ASM_IA64_XEN_EVENTS_H */
-- 
1.5.3
