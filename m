From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 19/28]xen: Add early printk support via hvc
	console
Date: Thu, 10 May 2007 17:07:02 -0700
Message-ID: <20070511001204.948444000@goop.org>
References: <20070511000643.025196000@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=xen-hvc-earlyprintk.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Add early printk support via hvc console, enable using
"earlyprintk=xen" on the kernel command line.

From: Gerd Hoffmann <kraxel@suse.de>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Acked-by: Ingo Molnar <mingo@elte.hu>

---
 arch/x86_64/kernel/early_printk.c |    5 +++++
 drivers/char/hvc_xen.c            |   25 +++++++++++++++++++++++++
 drivers/xen/Makefile              |    1 +
 include/xen/hvc-console.h         |    6 ++++++
 4 files changed, 37 insertions(+)

===================================================================
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -6,6 +6,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/fcntl.h>
+#include <xen/hvc-console.h>
 
 /* Simple VGA output */
 
@@ -242,6 +243,10 @@ static int __init setup_early_printk(cha
  		simnow_init(buf + 6);
  		early_console = &simnow_console;
  		keep_early = 1;
+#ifdef CONFIG_XEN
+	} else if (!strncmp(buf, "xen", 3)) {
+ 		early_console = &xenboot_console;
+#endif
 	}
 	register_console(early_console);
 	return 0;
===================================================================
--- a/drivers/char/hvc_xen.c
+++ b/drivers/char/hvc_xen.c
@@ -28,6 +28,7 @@
 #include <xen/page.h>
 #include <xen/events.h>
 #include <xen/interface/io/console.h>
+#include <xen/hvc-console.h>
 
 #include "hvc_console.h"
 
@@ -132,3 +133,27 @@ module_init(xen_init);
 module_init(xen_init);
 module_exit(xen_fini);
 console_initcall(xen_cons_init);
+
+static void xenboot_write_console(struct console *console, const char *string,
+				  unsigned len)
+{
+	unsigned int linelen, off = 0;
+	const char *pos;
+
+	while (off < len && NULL != (pos = strchr(string+off, '\n'))) {
+		linelen = pos-string+off;
+		if (off + linelen > len)
+			break;
+		write_console(0, string+off, linelen);
+		write_console(0, "\r\n", 2);
+		off += linelen + 1;
+	}
+	if (off < len)
+		write_console(0, string+off, len-off);
+}
+
+struct console xenboot_console = {
+	.name		= "xenboot",
+	.write		= xenboot_write_console,
+	.flags		= CON_PRINTBUFFER | CON_BOOT,
+};
===================================================================
--- /dev/null
+++ b/drivers/xen/Makefile
@@ -0,0 +1,1 @@
+obj-y	+= grant-table.o
===================================================================
--- /dev/null
+++ b/include/xen/hvc-console.h
@@ -0,0 +1,6 @@
+#ifndef XEN_HVC_CONSOLE_H
+#define XEN_HVC_CONSOLE_H
+
+extern struct console xenboot_console;
+
+#endif	/* XEN_HVC_CONSOLE_H */

-- 
