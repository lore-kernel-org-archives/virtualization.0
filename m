From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [rfc/patch] use hvc for xen console
Date: Tue, 13 Feb 2007 11:38:14 +0100
Message-ID: <45D19516.4080109@suse.de>
References: <45D1949E.1000809@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080703040306050100060306"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D1949E.1000809@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Xen devel list <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------080703040306050100060306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gerd Hoffmann wrote:
>   Hi,
> 
> Here is a patch (on top of the paravirt patch queue) which makes xen

Oops, forgot the patch here is it ...

--------------080703040306050100060306
Content-Type: text/plain;
 name="hvc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hvc"

---
 arch/i386/Kconfig.debug       |   24 ++++----
 arch/i386/xen/Kconfig         |    1 
 drivers/char/hvc_console.c    |    4 +
 drivers/xen/console/Makefile  |    3 -
 drivers/xen/console/hvc_xen.c |  124 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 13 deletions(-)

Index: paravirt-2.6.20-hg749/arch/i386/Kconfig.debug
===================================================================
--- paravirt-2.6.20-hg749.orig/arch/i386/Kconfig.debug
+++ paravirt-2.6.20-hg749/arch/i386/Kconfig.debug
@@ -6,18 +6,18 @@ config TRACE_IRQFLAGS_SUPPORT
 
 source "lib/Kconfig.debug"
 
-config EARLY_PRINTK
-	bool "Early printk" if EMBEDDED && DEBUG_KERNEL
-	default y
-	help
-	  Write kernel log output directly into the VGA buffer or to a serial
-	  port.
-
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized. For normal operation
-	  it is not recommended because it looks ugly and doesn't cooperate
-	  with klogd/syslogd or the X server. You should normally N here,
-	  unless you want to debug such a crash.
+#config EARLY_PRINTK
+#	bool "Early printk" if EMBEDDED && DEBUG_KERNEL
+#	default y
+#	help
+#	  Write kernel log output directly into the VGA buffer or to a serial
+#	  port.
+#
+#	  This is useful for kernel debugging when your machine crashes very
+#	  early before the console code is initialized. For normal operation
+#	  it is not recommended because it looks ugly and doesn't cooperate
+#	  with klogd/syslogd or the X server. You should normally N here,
+#	  unless you want to debug such a crash.
 
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
Index: paravirt-2.6.20-hg749/arch/i386/xen/Kconfig
===================================================================
--- paravirt-2.6.20-hg749.orig/arch/i386/xen/Kconfig
+++ paravirt-2.6.20-hg749/arch/i386/xen/Kconfig
@@ -5,6 +5,7 @@
 config XEN
 	bool "Enable support for Xen hypervisor"
 	depends PARAVIRT
+	select HVC_DRIVER
 	default y
 	help
 	  This is the Linux Xen port.
Index: paravirt-2.6.20-hg749/drivers/char/hvc_console.c
===================================================================
--- paravirt-2.6.20-hg749.orig/drivers/char/hvc_console.c
+++ paravirt-2.6.20-hg749/drivers/char/hvc_console.c
@@ -49,6 +49,10 @@
 
 #define TIMEOUT		(10)
 
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
+
 /*
  * Wait this long per iteration while trying to push buffered data to the
  * hypervisor before allowing the tty to complete a close operation.
Index: paravirt-2.6.20-hg749/drivers/xen/console/Makefile
===================================================================
--- paravirt-2.6.20-hg749.orig/drivers/xen/console/Makefile
+++ paravirt-2.6.20-hg749/drivers/xen/console/Makefile
@@ -1,2 +1,3 @@
 
-obj-y	:= console.o xencons_ring.o
+#obj-y	:= console.o xencons_ring.o
+obj-y	:= hvc_xen.o xencons_ring.o
Index: paravirt-2.6.20-hg749/drivers/xen/console/hvc_xen.c
===================================================================
--- /dev/null
+++ paravirt-2.6.20-hg749/drivers/xen/console/hvc_xen.c
@@ -0,0 +1,124 @@
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
+#include <xen/xencons.h>
+#include <asm/hypervisor.h>
+
+#include "../../char/hvc_console.h"
+
+#define HVC_COOKIE   0x58656e /* "Xen" in hex */
+#define HVC_READBUF       256
+
+static DEFINE_SPINLOCK(lock);
+static struct hvc_struct *hvc;
+static char rbuf[HVC_READBUF];
+static int rin, rout;
+
+static int write_console(uint32_t vtermno, const char *buf, int count)
+{
+	int rc;
+
+	rc = xencons_ring_send(buf, count);
+	return rc;
+}
+
+static int read_console(uint32_t vtermno, char *buf, int len)
+{
+	unsigned long flags;
+	int count;
+
+	spin_lock_irqsave(&lock, flags);
+	count = rin - rout;
+	if (count > len)
+		count = len;
+	if (count) {
+		memcpy(buf, rbuf + rout, count);
+		rout += count;
+		if (rin == rout)
+			rin = 0, rout = 0;
+	}
+	spin_unlock_irqrestore(&lock, flags);
+	return count;
+}
+
+void xencons_rx(char *buf, unsigned len)
+{
+	unsigned long flags;
+	int count;
+
+	spin_lock_irqsave(&lock, flags);
+	count = HVC_READBUF - rin;
+	if (count > len)
+		count = len;
+	memcpy(rbuf + rin, buf, count);
+	rin += count;
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+void xencons_tx(void)
+{
+	/* make xencons_ring.c happy */
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
+	xencons_ring_init();
+	hp = hvc_alloc(HVC_COOKIE, 0 /* NO_IRQ */, &hvc_ops, HVC_READBUF);
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

--------------080703040306050100060306
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------080703040306050100060306--
