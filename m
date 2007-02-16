From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: xen hvc console
Date: Fri, 16 Feb 2007 16:16:02 +0100
Message-ID: <45D5CAB2.3000204@suse.de>
References: <45D4E1AB.3020408@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070008010308030806000006"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D4E1AB.3020408@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------070008010308030806000006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:
> I had a quick try to make it work, but no success thus far.  Should it
> be enough to apply the patch and then boot with "console=/dev/hvc0"?

Patch updates ;)

xen-kill-earlyprintk-hacks.patch
	reverse the hackish early_console bits for xen

early-printk-boot-console.patch
	some generic early printk & boot console fixups
	(already sent to lkml).

xen-hvc-console.patch
	slightly updated xen-hvc-console patch, CONFIG_EARLY_PRINTK
	isn't commented out any more.

xen-hvc-earlyprintk.patch
	add early printk support via hvc console, enable using
	"earlyprintk=xen" on the kernel command line.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>


--------------070008010308030806000006
Content-Type: text/x-patch;
 name="xen-kill-earlyprintk-hacks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-kill-earlyprintk-hacks.patch"

---
 arch/i386/kernel/early_printk.c |    2 --
 drivers/xen/console/console.c   |    4 ++++
 init/main.c                     |    2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: paravirt-2.6.20-hg770/arch/i386/kernel/early_printk.c
===================================================================
--- paravirt-2.6.20-hg770.orig/arch/i386/kernel/early_printk.c
+++ paravirt-2.6.20-hg770/arch/i386/kernel/early_printk.c
@@ -1,4 +1,2 @@
 
-#ifndef CONFIG_XEN
 #include "../../x86_64/kernel/early_printk.c"
-#endif
Index: paravirt-2.6.20-hg770/drivers/xen/console/console.c
===================================================================
--- paravirt-2.6.20-hg770.orig/drivers/xen/console/console.c
+++ paravirt-2.6.20-hg770/drivers/xen/console/console.c
@@ -142,6 +142,8 @@ static void kcons_write_dom0(struct cons
 	}
 }
 
+#if 0
+
 void early_printk(const char *fmt, ...)
 {
 	va_list args;
@@ -183,6 +185,8 @@ void __init disable_early_printk(void)
 	early_console_initialized = 0;
 }
 
+#endif
+
 static struct tty_driver *kcons_device(struct console *c, int *index)
 {
 	*index = 0;
Index: paravirt-2.6.20-hg770/init/main.c
===================================================================
--- paravirt-2.6.20-hg770.orig/init/main.c
+++ paravirt-2.6.20-hg770/init/main.c
@@ -507,8 +507,6 @@ asmlinkage void __init start_kernel(void
 	unwind_init();
 	lockdep_init();
 
-	//setup_early_printk(NULL);
-
 	local_irq_disable();
 	early_boot_irqs_off();
 	early_init_irq_lock_class();



--------------070008010308030806000006
Content-Type: text/x-patch;
 name="early-printk-boot-console.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="early-printk-boot-console.patch"

---
 arch/x86_64/kernel/early_printk.c |   20 +++++---------------
 drivers/char/tty_io.c             |    5 -----
 kernel/printk.c                   |   26 ++++++++++++++++----------
 3 files changed, 21 insertions(+), 30 deletions(-)

Index: paravirt-2.6.20-hg770/arch/x86_64/kernel/early_printk.c
===================================================================
--- paravirt-2.6.20-hg770.orig/arch/x86_64/kernel/early_printk.c
+++ paravirt-2.6.20-hg770/arch/x86_64/kernel/early_printk.c
@@ -244,22 +244,12 @@ static int __init setup_early_printk(cha
  		early_console = &simnow_console;
  		keep_early = 1;
 	}
+
+	if (keep_early)
+		early_console->flags &= ~CON_BOOT;
+	else
+		early_console->flags |= CON_BOOT;
 	register_console(early_console);
 	return 0;
 }
-
 early_param("earlyprintk", setup_early_printk);
-
-void __init disable_early_printk(void)
-{
-	if (!early_console_initialized || !early_console)
-		return;
-	if (!keep_early) {
-		printk("disabling early console\n");
-		unregister_console(early_console);
-		early_console_initialized = 0;
-	} else {
-		printk("keeping early console\n");
-	}
-}
-
Index: paravirt-2.6.20-hg770/kernel/printk.c
===================================================================
--- paravirt-2.6.20-hg770.orig/kernel/printk.c
+++ paravirt-2.6.20-hg770/kernel/printk.c
@@ -931,8 +931,16 @@ void register_console(struct console *co
 {
 	int i;
 	unsigned long flags;
+	struct console *bootconsole = NULL;
 
-	if (preferred_console < 0)
+	if (console_drivers) {
+		if (console->flags & CON_BOOT)
+			return;
+		if (console_drivers->flags & CON_BOOT)
+			bootconsole = console_drivers;
+	}
+
+	if (preferred_console < 0 || bootconsole || !console_drivers)
 		preferred_console = selected_console;
 
 	/*
@@ -978,8 +986,11 @@ void register_console(struct console *co
 	if (!(console->flags & CON_ENABLED))
 		return;
 
-	if (console_drivers && (console_drivers->flags & CON_BOOT)) {
-		unregister_console(console_drivers);
+	if (bootconsole) {
+		printk(KERN_INFO "console handover: boot [%s%d] -> real [%s%d]\n",
+		       bootconsole->name, bootconsole->index,
+		       console->name, console->index);
+		unregister_console(bootconsole);
 		console->flags &= ~CON_PRINTBUFFER;
 	}
 
@@ -1030,16 +1041,11 @@ int unregister_console(struct console *c
 		}
 	}
 
-	/* If last console is removed, we re-enable picking the first
-	 * one that gets registered. Without that, pmac early boot console
-	 * would prevent fbcon from taking over.
-	 *
+	/*
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.
 	 */
-	if (console_drivers == NULL)
-		preferred_console = selected_console;
-	else if (console->flags & CON_CONSDEV)
+	if (console_drivers != NULL && console->flags & CON_CONSDEV)
 		console_drivers->flags |= CON_CONSDEV;
 
 	release_console_sem();
Index: paravirt-2.6.20-hg770/drivers/char/tty_io.c
===================================================================
--- paravirt-2.6.20-hg770.orig/drivers/char/tty_io.c
+++ paravirt-2.6.20-hg770/drivers/char/tty_io.c
@@ -141,8 +141,6 @@ static DECLARE_MUTEX(allocated_ptys_lock
 static int ptmx_open(struct inode *, struct file *);
 #endif
 
-extern void disable_early_printk(void);
-
 static void initialize_tty_struct(struct tty_struct *tty);
 
 static ssize_t tty_read(struct file *, char __user *, size_t, loff_t *);
@@ -3881,9 +3879,6 @@ void __init console_init(void)
 	 * set up the console device so that later boot sequences can 
 	 * inform about problems etc..
 	 */
-#ifdef CONFIG_EARLY_PRINTK
-	disable_early_printk();
-#endif
 	call = __con_initcall_start;
 	while (call < __con_initcall_end) {
 		(*call)();



--------------070008010308030806000006
Content-Type: text/x-patch;
 name="xen-hvc-console.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-hvc-console.patch"

From: Gerd Hoffmann <kraxel@suse.de>

---
 arch/i386/xen/Kconfig         |    1 
 arch/i386/xen/events.c        |    3 
 drivers/char/hvc_console.c    |    4 +
 drivers/xen/console/Makefile  |    3 
 drivers/xen/console/hvc_xen.c |  135 ++++++++++++++++++++++++++++++++++++++++++
 include/xen/events.h          |    1 
 6 files changed, 145 insertions(+), 2 deletions(-)

Index: paravirt-2.6.20-hg770/arch/i386/xen/Kconfig
===================================================================
--- paravirt-2.6.20-hg770.orig/arch/i386/xen/Kconfig
+++ paravirt-2.6.20-hg770/arch/i386/xen/Kconfig
@@ -5,6 +5,7 @@
 config XEN
 	bool "Enable support for Xen hypervisor"
 	depends PARAVIRT
+	select HVC_DRIVER
 	default y
 	help
 	  This is the Linux Xen port.
Index: paravirt-2.6.20-hg770/drivers/char/hvc_console.c
===================================================================
--- paravirt-2.6.20-hg770.orig/drivers/char/hvc_console.c
+++ paravirt-2.6.20-hg770/drivers/char/hvc_console.c
@@ -49,6 +49,10 @@
 
 #define TIMEOUT		(10)
 
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
+
 /*
  * Wait this long per iteration while trying to push buffered data to the
  * hypervisor before allowing the tty to complete a close operation.
Index: paravirt-2.6.20-hg770/drivers/xen/console/Makefile
===================================================================
--- paravirt-2.6.20-hg770.orig/drivers/xen/console/Makefile
+++ paravirt-2.6.20-hg770/drivers/xen/console/Makefile
@@ -1,2 +1,3 @@
 
-obj-y	:= console.o xencons_ring.o
+#obj-y	:= console.o xencons_ring.o
+obj-y	:= hvc_xen.o
Index: paravirt-2.6.20-hg770/drivers/xen/console/hvc_xen.c
===================================================================
--- /dev/null
+++ paravirt-2.6.20-hg770/drivers/xen/console/hvc_xen.c
@@ -0,0 +1,135 @@
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
+#include <xen/xencons.h>
+#include <xen/interface/io/console.h>
+
+#include "../../char/hvc_console.h"
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
Index: paravirt-2.6.20-hg770/arch/i386/xen/events.c
===================================================================
--- paravirt-2.6.20-hg770.orig/arch/i386/xen/events.c
+++ paravirt-2.6.20-hg770/arch/i386/xen/events.c
@@ -209,7 +209,7 @@ static int find_unbound_irq(void)
 	return irq;
 }
 
-static int bind_evtchn_to_irq(unsigned int evtchn)
+int bind_evtchn_to_irq(unsigned int evtchn)
 {
 	int irq;
 
@@ -233,6 +233,7 @@ static int bind_evtchn_to_irq(unsigned i
 
 	return irq;
 }
+EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
 static int bind_virq_to_irq(unsigned int virq, unsigned int cpu)
 {
Index: paravirt-2.6.20-hg770/include/xen/events.h
===================================================================
--- paravirt-2.6.20-hg770.orig/include/xen/events.h
+++ paravirt-2.6.20-hg770/include/xen/events.h
@@ -5,6 +5,7 @@
 #include <xen/interface/event_channel.h>
 #include <asm/xen/hypercall.h>
 
+int bind_evtchn_to_irq(unsigned int evtchn);
 int bind_evtchn_to_irqhandler(unsigned int evtchn,
 			      irqreturn_t (*handler)(int, void *),
 			      unsigned long irqflags, const char *devname,



--------------070008010308030806000006
Content-Type: text/x-patch;
 name="xen-hvc-earlyprintk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-hvc-earlyprintk.patch"

---
 arch/x86_64/kernel/early_printk.c |    8 ++++++++
 drivers/xen/console/hvc_xen.c     |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

Index: paravirt-2.6.20-hg770/arch/x86_64/kernel/early_printk.c
===================================================================
--- paravirt-2.6.20-hg770.orig/arch/x86_64/kernel/early_printk.c
+++ paravirt-2.6.20-hg770/arch/x86_64/kernel/early_printk.c
@@ -197,6 +197,10 @@ static struct console simnow_console = {
 	.index =	-1,
 };
 
+#ifdef CONFIG_XEN
+extern struct console xenboot_console;
+#endif
+
 /* Direct interface for emergencies */
 struct console *early_console = &early_vga_console;
 static int early_console_initialized = 0;
@@ -243,6 +247,10 @@ static int __init setup_early_printk(cha
  		simnow_init(buf + 6);
  		early_console = &simnow_console;
  		keep_early = 1;
+#ifdef CONFIG_XEN
+	} else if (!strncmp(buf, "xen", 3)) {
+ 		early_console = &xenboot_console;
+#endif
 	}
 
 	if (keep_early)
Index: paravirt-2.6.20-hg770/drivers/xen/console/hvc_xen.c
===================================================================
--- paravirt-2.6.20-hg770.orig/drivers/xen/console/hvc_xen.c
+++ paravirt-2.6.20-hg770/drivers/xen/console/hvc_xen.c
@@ -133,3 +133,27 @@ static int xen_cons_init(void)
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



--------------070008010308030806000006
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------070008010308030806000006--
