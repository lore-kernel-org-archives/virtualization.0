From: akpm@linux-foundation.org
Subject: [patch 6/9] lguest: the console driver
Date: Wed, 09 May 2007 02:51:38 -0700
Message-ID: <200705090951.l499pcB2020403@shell0.pdx.osdl.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756774AbXEIJxj@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, akpm@linux-foundation.org, rusty@rustcorp.com.au, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

A simple console driver for lguest.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/char/Makefile     |    1 
 drivers/char/hvc_lguest.c |   99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff -puN drivers/char/Makefile~lguest-the-console-driver drivers/char/Makefile
--- a/drivers/char/Makefile~lguest-the-console-driver
+++ a/drivers/char/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += am
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
+obj-$(CONFIG_LGUEST_GUEST)	+= hvc_lguest.o
 obj-$(CONFIG_HVC_ISERIES)	+= hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
 obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
diff -puN /dev/null drivers/char/hvc_lguest.c
--- /dev/null
+++ a/drivers/char/hvc_lguest.c
@@ -0,0 +1,99 @@
+/* Simple console for lguest.
+ *
+ * Copyright (C) 2006 Rusty Russell, IBM Corporation
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
+ */
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/lguest_bus.h>
+#include "hvc_console.h"
+
+static char inbuf[256];
+static struct lguest_dma cons_input = { .used_len = 0,
+					.addr[0] = __pa(inbuf),
+					.len[0] = sizeof(inbuf),
+					.len[1] = 0 };
+
+static int put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct lguest_dma dma;
+
+	/* FIXME: what if it's over a page boundary? */
+	dma.len[0] = count;
+	dma.len[1] = 0;
+	dma.addr[0] = __pa(buf);
+
+	hcall(LHCALL_SEND_DMA, LGUEST_CONSOLE_DMA_KEY, __pa(&dma), 0);
+	return count;
+}
+
+static int get_chars(u32 vtermno, char *buf, int count)
+{
+	static int cons_offset;
+
+	if (!cons_input.used_len)
+		return 0;
+
+	if (cons_input.used_len - cons_offset < count)
+		count = cons_input.used_len - cons_offset;
+
+	memcpy(buf, inbuf + cons_offset, count);
+	cons_offset += count;
+	if (cons_offset == cons_input.used_len) {
+		cons_offset = 0;
+		cons_input.used_len = 0;
+	}
+	return count;
+}
+
+struct hv_ops lguest_cons = {
+	.get_chars = get_chars,
+	.put_chars = put_chars,
+};
+
+static int __init cons_init(void)
+{
+	if (strcmp(paravirt_ops.name, "lguest") != 0)
+		return 0;
+
+	return hvc_instantiate(0, 0, &lguest_cons);
+}
+console_initcall(cons_init);
+
+static int lguestcons_probe(struct lguest_device *lgdev)
+{
+	lgdev->private = hvc_alloc(0, lgdev->index+1, &lguest_cons, 256);
+	if (IS_ERR(lgdev->private))
+		return PTR_ERR(lgdev->private);
+
+	if (!hcall(LHCALL_BIND_DMA, LGUEST_CONSOLE_DMA_KEY, __pa(&cons_input),
+		   (1<<8) + lgdev->index+1))
+		printk("lguest console: failed to bind buffer.\n");
+	return 0;
+}
+
+static struct lguest_driver lguestcons_drv = {
+	.name = "lguestcons",
+	.owner = THIS_MODULE,
+	.device_type = LGUEST_DEVICE_T_CONSOLE,
+	.probe = lguestcons_probe,
+};
+
+static int __init hvc_lguest_init(void)
+{
+	return register_lguest_driver(&lguestcons_drv);
+}
+module_init(hvc_lguest_init);
_
