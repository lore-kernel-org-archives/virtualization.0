From: yamahata@valinux.co.jp
Subject: [PATCH 18/28] ia64/xen: iosapic paravirtualization
Date: Thu, 21 Feb 2008 18:17:49 +0900
Message-ID: <20080221091904.215973000__2840.99742207236$1203635224$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GS17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0018-ia64-xen-iosapic-paravirtualization.patch
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
 arch/ia64/kernel/iosapic.c |   89 ++++++++++++++++++++++++++++++++++++++++---
 include/asm-ia64/iosapic.h |    2 +
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index 398e2fd..5915d7e 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -157,6 +157,79 @@ static unsigned char pcat_compat __devinitdata;	/* 8259 compatibility flag */
 static int iosapic_kmalloc_ok;
 static LIST_HEAD(free_rte_list);
 
+#ifdef CONFIG_XEN
+#include <xen/interface/xen.h>
+#include <xen/interface/physdev.h>
+#include <asm/xen/hypervisor.h>
+static inline unsigned int
+xen_iosapic_read(char __iomem *iosapic, unsigned int reg)
+{
+	struct physdev_apic apic_op;
+	int ret;
+
+	apic_op.apic_physbase = (unsigned long)iosapic -
+					__IA64_UNCACHED_OFFSET;
+	apic_op.reg = reg;
+	ret = HYPERVISOR_physdev_op(PHYSDEVOP_apic_read, &apic_op);
+	if (ret)
+		return ret;
+	return apic_op.value;
+}
+
+static inline void
+xen_iosapic_write(char __iomem *iosapic, unsigned int reg, u32 val)
+{
+	struct physdev_apic apic_op;
+
+	apic_op.apic_physbase = (unsigned long)iosapic -
+					__IA64_UNCACHED_OFFSET;
+	apic_op.reg = reg;
+	apic_op.value = val;
+	HYPERVISOR_physdev_op(PHYSDEVOP_apic_write, &apic_op);
+}
+
+static inline unsigned int
+__iosapic_read(char __iomem *iosapic, unsigned int reg)
+{
+	if (!is_running_on_xen()) {
+		writel(reg, iosapic + IOSAPIC_REG_SELECT);
+		return readl(iosapic + IOSAPIC_WINDOW);
+	} else
+		return xen_iosapic_read(iosapic, reg);
+}
+
+static inline void
+__iosapic_write(char __iomem *iosapic, unsigned int reg, u32 val)
+{
+	if (!is_running_on_xen()) {
+		writel(reg, iosapic + IOSAPIC_REG_SELECT);
+		writel(val, iosapic + IOSAPIC_WINDOW);
+	} else
+		xen_iosapic_write(iosapic, reg, val);
+}
+
+int xen_assign_irq_vector(int irq)
+{
+	struct physdev_irq irq_op;
+
+	irq_op.irq = irq;
+	if (HYPERVISOR_physdev_op(PHYSDEVOP_alloc_irq_vector, &irq_op))
+		return -ENOSPC;
+
+	return irq_op.vector;
+}
+
+void xen_free_irq_vector(int vector)
+{
+	struct physdev_irq irq_op;
+
+	irq_op.vector = vector;
+	if (HYPERVISOR_physdev_op(PHYSDEVOP_free_irq_vector, &irq_op))
+		printk(KERN_WARNING "%s: xen_free_irq_vecotr fail vector=%d\n",
+		       __func__, vector);
+}
+#endif /* XEN */
+
 static inline void
 iosapic_write(struct iosapic *iosapic, unsigned int reg, u32 val)
 {
@@ -269,19 +342,15 @@ nop (unsigned int irq)
 	/* do nothing... */
 }
 
-
 #ifdef CONFIG_KEXEC
 void
 kexec_disable_iosapic(void)
 {
 	struct iosapic_intr_info *info;
 	struct iosapic_rte_info *rte;
-	ia64_vector vec;
-	int irq;
-
-	for (irq = 0; irq < NR_IRQS; irq++) {
-		info = &iosapic_intr_info[irq];
-		vec = irq_to_vector(irq);
+	u8 vec = 0;
+	for (info = iosapic_intr_info; info <
+			iosapic_intr_info + IA64_NUM_VECTORS; ++info, ++vec) {
 		list_for_each_entry(rte, &info->rtes,
 				rte_list) {
 			iosapic_write(rte->iosapic,
@@ -635,6 +704,9 @@ register_intr (unsigned int gsi, int irq, unsigned char delivery,
 	iosapic_intr_info[irq].dmode    = delivery;
 	iosapic_intr_info[irq].trigger  = trigger;
 
+	if (is_running_on_xen())
+		return 0;
+
 	if (trigger == IOSAPIC_EDGE)
 		irq_type = &irq_type_iosapic_edge;
 	else
@@ -987,6 +1059,9 @@ iosapic_system_init (int system_pcat_compat)
 	}
 
 	pcat_compat = system_pcat_compat;
+	if (is_running_on_xen())
+		return;
+
 	if (pcat_compat) {
 		/*
 		 * Disable the compatibility mode interrupts (8259 style),
diff --git a/include/asm-ia64/iosapic.h b/include/asm-ia64/iosapic.h
index a3a4288..7ed8e4f 100644
--- a/include/asm-ia64/iosapic.h
+++ b/include/asm-ia64/iosapic.h
@@ -55,6 +55,7 @@
 
 #define NR_IOSAPICS			256
 
+#ifndef CONFIG_XEN
 static inline unsigned int __iosapic_read(char __iomem *iosapic, unsigned int reg)
 {
 	writel(reg, iosapic + IOSAPIC_REG_SELECT);
@@ -66,6 +67,7 @@ static inline void __iosapic_write(char __iomem *iosapic, unsigned int reg, u32
 	writel(reg, iosapic + IOSAPIC_REG_SELECT);
 	writel(val, iosapic + IOSAPIC_WINDOW);
 }
+#endif
 
 static inline void iosapic_eoi(char __iomem *iosapic, u32 vector)
 {
-- 
1.5.3

-- 
yamahata
