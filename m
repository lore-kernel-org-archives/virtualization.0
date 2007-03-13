From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 30/34] Xen-pv_ops: Add early printk support via hvc console
Date: Tue, 13 Mar 2007 16:30:47 -0700
Message-ID: <20070313233034.995075558@goop.org>
References: <20070313233017.933601256@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-hvc-earlyprintk.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add early printk support via hvc console, enable using
"earlyprintk=3Dxen" on the kernel command line.

From: Gerd Hoffmann <kraxel@suse.de>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/x86_64/kernel/early_printk.c |    5 +++++
 drivers/xen/hvc-console.c         |   25 +++++++++++++++++++++++++
 include/xen/hvc-console.h         |    6 ++++++
 3 files changed, 36 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -6,6 +6,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/fcntl.h>
+#include <xen/hvc-console.h>
 =

 /* Simple VGA output */
 =

@@ -243,6 +244,10 @@ static int __init setup_early_printk(cha
  		simnow_init(buf + 6);
  		early_console =3D &simnow_console;
  		keep_early =3D 1;
+#ifdef CONFIG_XEN
+	} else if (!strncmp(buf, "xen", 3)) {
+ 		early_console =3D &xenboot_console;
+#endif
 	}
 	register_console(early_console);
 	return 0;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/xen/hvc-console.c
+++ b/drivers/xen/hvc-console.c
@@ -28,6 +28,7 @@
 #include <xen/page.h>
 #include <xen/events.h>
 #include <xen/interface/io/console.h>
+#include <xen/hvc-console.h>
 =

 #include "../char/hvc_console.h"
 =

@@ -132,3 +133,27 @@ module_init(xen_init);
 module_init(xen_init);
 module_exit(xen_fini);
 console_initcall(xen_cons_init);
+
+static void xenboot_write_console(struct console *console, const char *str=
ing,
+				  unsigned len)
+{
+	unsigned int linelen, off =3D 0;
+	const char *pos;
+
+	while (off < len && NULL !=3D (pos =3D strchr(string+off, '\n'))) {
+		linelen =3D pos-string+off;
+		if (off + linelen > len)
+			break;
+		write_console(0, string+off, linelen);
+		write_console(0, "\r\n", 2);
+		off +=3D linelen + 1;
+	}
+	if (off < len)
+		write_console(0, string+off, len-off);
+}
+
+struct console xenboot_console =3D {
+	.name		=3D "xenboot",
+	.write		=3D xenboot_write_console,
+	.flags		=3D CON_PRINTBUFFER | CON_BOOT,
+};
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/include/xen/hvc-console.h
@@ -0,0 +1,6 @@
+#ifndef XEN_HVC_CONSOLE_H
+#define XEN_HVC_CONSOLE_H
+
+extern struct console xenboot_console;
+
+#endif	/* XEN_HVC_CONSOLE_H */

-- =
