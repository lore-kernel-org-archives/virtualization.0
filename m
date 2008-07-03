From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] ia64/pv_ops/xen: implement xen pv_iosapic_ops.
Date: Thu,  3 Jul 2008 15:54:57 +0900
Message-ID: <12150681061988-git-send-email-yamahata__25158.0322081738$1215070470$gmane$org@valinux.co.jp>
References: <1215068105921-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1215068105921-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

implement xen pv_iosapic_ops for xen paravirtualized
iosapic.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/xen/xen_pv_ops.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/xen/xen_pv_ops.c b/arch/ia64/xen/xen_pv_ops.c
index 1ba4617..6978131 100644
--- a/arch/ia64/xen/xen_pv_ops.c
+++ b/arch/ia64/xen/xen_pv_ops.c
@@ -292,6 +292,57 @@ const struct pv_cpu_asm_switch xen_cpu_asm_switch = {
 };
 
 /***************************************************************************
+ * pv_iosapic_ops
+ * iosapic read/write hooks.
+ */
+static void
+xen_pcat_compat_init(void)
+{
+	/* nothing */
+}
+
+static struct irq_chip*
+xen_iosapic_get_irq_chip(unsigned long trigger)
+{
+	return NULL;
+}
+
+static unsigned int
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
+static void
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
+static const struct pv_iosapic_ops xen_iosapic_ops __initdata = {
+	.pcat_compat_init = xen_pcat_compat_init,
+	.get_irq_chip = xen_iosapic_get_irq_chip,
+
+	.__read = xen_iosapic_read,
+	.__write = xen_iosapic_write,
+};
+
+/***************************************************************************
  * pv_ops initialization
  */
 
@@ -302,6 +353,7 @@ xen_setup_pv_ops(void)
 	pv_info = xen_info;
 	pv_init_ops = xen_init_ops;
 	pv_cpu_ops = xen_cpu_ops;
+	pv_iosapic_ops = xen_iosapic_ops;
 
 	paravirt_cpu_asm_init(&xen_cpu_asm_switch);
 }
-- 
1.5.3
