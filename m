From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 20/32] xen: Use the hvc console infrastructure for Xen
	console
Date: Sun, 29 Apr 2007 10:28:55 -0700
Message-ID: <20070429172914.517811000@goop.org>
References: <20070429172835.284784000@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-hvc-console.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Olof Johansson <olof@lixom.net>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Implement a Xen back-end for hvc console.

From: Gerd Hoffmann <kraxel@suse.de>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/i386/xen/events.c |    3 -
 drivers/Makefile       |    3 +
 drivers/char/Kconfig   |    8 ++
 drivers/char/Makefile  |    1 
 drivers/char/hvc_xen.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/xen/events.h   |    1 
 6 files changed, 149 insertions(+), 1 deletion(-)

===================================================================
--- a/arch/i386/xen/events.c
+++ b/arch/i386/xen/events.c
@@ -221,7 +221,7 @@ static int find_unbound_irq(void)
 	return irq;
 }
 
-static int bind_evtchn_to_irq(unsigned int evtchn)
+int bind_evtchn_to_irq(unsigned int evtchn)
 {
 	int irq;
 
@@ -246,6 +246,7 @@ static int bind_evtchn_to_irq(unsigned i
 
 	return irq;
 }
+EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
 static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 {
===================================================================
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -14,6 +14,9 @@ obj-$(CONFIG_ACPI)		+= acpi/
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
 obj-$(CONFIG_ARM_AMBA)		+= amba/
+
+# Xen is the default console when running as a guest
+obj-$(CONFIG_XEN)		+= xen/
 
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
===================================================================
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -650,6 +650,14 @@ config HVC_BEAT
 	help
 	  Toshiba's Cell Reference Set Beat Console device driver
 
+config HVC_XEN
+	bool "Xen Hypervisor Console support"
+	depends on XEN
+	select HVC_DRIVER
+	default y
+	help
+	  Xen virtual console device driver
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES
===================================================================
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_HVC_ISERIES)	+= hvc_iseries
 obj-$(CONFIG_HVC_ISERIES)	+= hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
 obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
+obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
===================================================================
--- /dev/null
+++ b/drivers/char/hvc_xen.c
@@ -0,0 +1,134 @@
+/*
+ * xen console driver interface to hvc_console.c
+ *
+ * (c) 2007 Gerd Hoffmann <kraxel@suse.de>
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include <asm/xen/hypervisor.h>
+#include <xen/page.h>
+#include <xen/events.h>
+#include <xen/interface/io/console.h>
+
+#include "hvc_console.h"
+
+#define HVC_COOKIE   0x58656e /* "Xen" in hex */
+
+static struct hvc_struct *hvc;
+static int xencons_irq;
+
+/* ------------------------------------------------------------------ */
+
+static inline struct xencons_interface *xencons_interface(void)
+{
+	return mfn_to_virt(xen_start_info->console.domU.mfn);
+}
+
+static inline void notify_daemon(void)
+{
+	/* Use evtchn: this is called early, before irq is set up. */
+	notify_remote_via_evtchn(xen_start_info->console.domU.evtchn);
+}
+
+static int write_console(uint32_t vtermno, const char *data, int len)
+{
+	struct xencons_interface *intf = xencons_interface();
+	XENCONS_RING_IDX cons, prod;
+	int sent = 0;
+
+	cons = intf->out_cons;
+	prod = intf->out_prod;
+	mb();
+	BUG_ON((prod - cons) > sizeof(intf->out));
+
+	while ((sent < len) && ((prod - cons) < sizeof(intf->out)))
+		intf->out[MASK_XENCONS_IDX(prod++, intf->out)] = data[sent++];
+
+	wmb();
+	intf->out_prod = prod;
+
+	notify_daemon();
+	return sent;
+}
+
+static int read_console(uint32_t vtermno, char *buf, int len)
+{
+	struct xencons_interface *intf = xencons_interface();
+	XENCONS_RING_IDX cons, prod;
+	int recv = 0;
+
+	cons = intf->in_cons;
+	prod = intf->in_prod;
+	mb();
+	BUG_ON((prod - cons) > sizeof(intf->in));
+
+	while (cons != prod && recv < len)
+		buf[recv++] = intf->in[MASK_XENCONS_IDX(cons++,intf->in)];
+
+	mb();
+	intf->in_cons = cons;
+
+	notify_daemon();
+	return recv;
+}
+
+static struct hv_ops hvc_ops = {
+	.get_chars = read_console,
+	.put_chars = write_console,
+};
+
+static int __init xen_init(void)
+{
+	struct hvc_struct *hp;
+
+	if (!is_running_on_xen())
+		return 0;
+
+	xencons_irq = bind_evtchn_to_irq(xen_start_info->console.domU.evtchn);
+	if (xencons_irq < 0)
+		xencons_irq = 0 /* NO_IRQ */;
+	hp = hvc_alloc(HVC_COOKIE, xencons_irq, &hvc_ops, 256);
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+
+	hvc = hp;
+	return 0;
+}
+
+static void __exit xen_fini(void)
+{
+	if (hvc)
+		hvc_remove(hvc);
+}
+
+static int xen_cons_init(void)
+{
+	if (!is_running_on_xen())
+		return 0;
+
+	hvc_instantiate(HVC_COOKIE, 0, &hvc_ops);
+	return 0;
+}
+
+module_init(xen_init);
+module_exit(xen_fini);
+console_initcall(xen_cons_init);
===================================================================
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -13,6 +13,7 @@ enum ipi_vector {
 	XEN_NR_IPIS,
 };
 
+int bind_evtchn_to_irq(unsigned int evtchn);
 int bind_evtchn_to_irqhandler(unsigned int evtchn,
 			      irq_handler_t handler,
 			      unsigned long irqflags, const char *devname,

-- 
