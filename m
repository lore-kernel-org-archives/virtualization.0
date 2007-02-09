From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 8/10] lguest: console driver.
Date: Fri, 09 Feb 2007 20:23:09 +1100
Message-ID: <1171012989.2718.46.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	<1171012458.2718.30.camel@localhost.localdomain>
	<1171012693.2718.37.camel@localhost.localdomain>
	<1171012761.2718.40.camel@localhost.localdomain>
	<1171012827.2718.42.camel@localhost.localdomain>
	<1171012941.2718.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171012941.2718.44.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

A trivial driver to have a basic lguest console, using the hvc_console
infrastructure.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_HVC_CONSOLE)	+=3D hvc_vio.o h
 obj-$(CONFIG_HVC_CONSOLE)	+=3D hvc_vio.o hvsi.o
 obj-$(CONFIG_HVC_ISERIES)	+=3D hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+=3D hvc_rtas.o
+obj-$(CONFIG_LGUEST_GUEST)	+=3D hvc_lguest.o
 obj-$(CONFIG_HVC_DRIVER)	+=3D hvc_console.o
 obj-$(CONFIG_RAW_DRIVER)	+=3D raw.o
 obj-$(CONFIG_SGI_SNSC)		+=3D snsc.o snsc_event.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/char/hvc_lguest.c
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+ */
+#include <linux/err.h>
+#include <linux/init.h>
+#include <asm/lguest_device.h>
+#include "hvc_console.h"
+
+static int cons_irq;
+static int cons_offset;
+static char inbuf[256];
+static struct lguest_dma cons_input =3D { .used_len =3D 0,
+					.addr[0] =3D __pa(inbuf),
+					.len[0] =3D sizeof(inbuf),
+					.len[1] =3D 0 };
+
+static int get_chars(u32 vtermno, char *buf, int count)
+{
+	if (!cons_input.used_len)
+		return 0;
+
+	if (cons_input.used_len - cons_offset < count)
+		count =3D cons_input.used_len - cons_offset;
+
+	memcpy(buf, inbuf + cons_offset, count);
+	cons_offset +=3D count;
+	if (cons_offset =3D=3D cons_input.used_len) {
+		cons_offset =3D 0;
+		cons_input.used_len =3D 0;
+	}
+	return count;
+}
+
+static int put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct lguest_dma dma;
+
+	/* FIXME: what if it's over a page boundary? */
+	dma.len[0] =3D count;
+	dma.len[1] =3D 0;
+	dma.addr[0] =3D __pa(buf);
+
+	hcall(LHCALL_SEND_DMA, 4, __pa(&dma), 0);
+	return count;
+}
+
+struct hv_ops lguest_cons =3D {
+	.get_chars =3D get_chars,
+	.put_chars =3D put_chars,
+};
+
+static int __init cons_init(void)
+{
+	if (strcmp(paravirt_ops.name, "lguest") !=3D 0)
+		return 0;
+
+	return hvc_instantiate(0, 0, &lguest_cons);
+}
+console_initcall(cons_init);
+
+static int lguestcons_probe(struct lguest_device *lhdev)
+{
+	cons_irq =3D lhdev->index+1;
+	lhdev->private =3D hvc_alloc(0, cons_irq, &lguest_cons, 256);
+	if (IS_ERR(lhdev->private))
+		return PTR_ERR(lhdev->private);
+
+	if (!hcall(LHCALL_BIND_DMA, 0, __pa(&cons_input), (1<<8)+cons_irq))
+		printk("lguest console: failed to bind buffer.\n");
+	return 0;
+}
+
+static struct lguest_driver lguestcons_drv =3D {
+	.name =3D "lguestcons",
+	.owner =3D THIS_MODULE,
+	.device_type =3D LGUEST_DEVICE_T_CONSOLE,
+	.probe =3D lguestcons_probe,
+};
+
+static int __init hvc_lguest_init(void)
+{
+	return register_lguest_driver(&lguestcons_drv);
+}
+module_init(hvc_lguest_init);
