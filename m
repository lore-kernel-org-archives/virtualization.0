From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 18/24] Xen-paravirt_ops: Some generic early
	printk & boot console fixups
Date: Wed, 21 Feb 2007 12:53:12 -0800
Message-ID: <20070221205323.842917348@goop.org>
References: <20070221205254.169835700@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=early-printk-boot-console.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Some generic early printk & boot console fixups
(already sent to lkml).

From: Gerd Hoffmann <kraxel@suse.de>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86_64/kernel/early_printk.c |   20 +++++---------------
 drivers/char/tty_io.c             |    5 -----
 kernel/printk.c                   |   26 ++++++++++++++++----------
 3 files changed, 21 insertions(+), 30 deletions(-)

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

-- 
