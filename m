From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 26/28]xen: handle external requests for shutdown,
	reboot and sysrq
Date: Thu, 10 May 2007 17:07:09 -0700
Message-ID: <20070511001209.268040000@goop.org>
References: <20070511000643.025196000@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-management.patch
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The guest domain can be asked to shutdown or reboot itself, or have a
sysrq key injected, via xenbus.  This patch adds a watcher for those
events, and does the appropriate action.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/xen/Makefile |    2 
 arch/i386/xen/manage.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)

===================================================================
--- a/arch/i386/xen/Makefile
+++ b/arch/i386/xen/Makefile
@@ -1,4 +1,4 @@ obj-y		:= enlighten.o setup.o features.o
 obj-y		:= enlighten.o setup.o features.o multicalls.o mmu.o \
-			events.o time.o
+			events.o time.o manage.o
 
 obj-$(CONFIG_SMP)	+= smp.o
===================================================================
--- /dev/null
+++ b/arch/i386/xen/manage.c
@@ -0,0 +1,143 @@
+/*
+ * Handle extern requests for shutdown, reboot and sysrq
+ */
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/reboot.h>
+#include <linux/sysrq.h>
+
+#include <xen/xenbus.h>
+
+#define SHUTDOWN_INVALID  -1
+#define SHUTDOWN_POWEROFF  0
+#define SHUTDOWN_SUSPEND   2
+/* Code 3 is SHUTDOWN_CRASH, which we don't use because the domain can only
+ * report a crash, not be instructed to crash!
+ * HALT is the same as POWEROFF, as far as we're concerned.  The tools use
+ * the distinction when we return the reason code to them.
+ */
+#define SHUTDOWN_HALT      4
+
+/* Ignore multiple shutdown requests. */
+static int shutting_down = SHUTDOWN_INVALID;
+
+static void shutdown_handler(struct xenbus_watch *watch,
+			     const char **vec, unsigned int len)
+{
+	char *str;
+	struct xenbus_transaction xbt;
+	int err;
+
+	if (shutting_down != SHUTDOWN_INVALID)
+		return;
+
+ again:
+	err = xenbus_transaction_start(&xbt);
+	if (err)
+		return;
+
+	str = (char *)xenbus_read(xbt, "control", "shutdown", NULL);
+	/* Ignore read errors and empty reads. */
+	if (XENBUS_IS_ERR_READ(str)) {
+		xenbus_transaction_end(xbt, 1);
+		return;
+	}
+
+	xenbus_write(xbt, "control", "shutdown", "");
+
+	err = xenbus_transaction_end(xbt, 0);
+	if (err == -EAGAIN) {
+		kfree(str);
+		goto again;
+	}
+
+	if (strcmp(str, "poweroff") == 0 ||
+	    strcmp(str, "halt") == 0)
+		orderly_poweroff(false);
+	else if (strcmp(str, "reboot") == 0)
+		ctrl_alt_del();
+	else {
+		printk("Ignoring shutdown request: %s\n", str);
+		shutting_down = SHUTDOWN_INVALID;
+	}
+
+	kfree(str);
+}
+
+static void sysrq_handler(struct xenbus_watch *watch, const char **vec,
+			  unsigned int len)
+{
+	char sysrq_key = '\0';
+	struct xenbus_transaction xbt;
+	int err;
+
+ again:
+	err = xenbus_transaction_start(&xbt);
+	if (err)
+		return;
+	if (!xenbus_scanf(xbt, "control", "sysrq", "%c", &sysrq_key)) {
+		printk(KERN_ERR "Unable to read sysrq code in "
+		       "control/sysrq\n");
+		xenbus_transaction_end(xbt, 1);
+		return;
+	}
+
+	if (sysrq_key != '\0')
+		xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+
+	err = xenbus_transaction_end(xbt, 0);
+	if (err == -EAGAIN)
+		goto again;
+
+	if (sysrq_key != '\0')
+		handle_sysrq(sysrq_key, NULL);
+}
+
+static struct xenbus_watch shutdown_watch = {
+	.node = "control/shutdown",
+	.callback = shutdown_handler
+};
+
+static struct xenbus_watch sysrq_watch = {
+	.node = "control/sysrq",
+	.callback = sysrq_handler
+};
+
+static int setup_shutdown_watcher(void)
+{
+	int err;
+
+	err = register_xenbus_watch(&shutdown_watch);
+	if (err) {
+		printk(KERN_ERR "Failed to set shutdown watcher\n");
+		return err;
+	}
+
+	err = register_xenbus_watch(&sysrq_watch);
+	if (err) {
+		printk(KERN_ERR "Failed to set sysrq watcher\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int shutdown_event(struct notifier_block *notifier,
+			  unsigned long event,
+			  void *data)
+{
+	setup_shutdown_watcher();
+	return NOTIFY_DONE;
+}
+
+static int __init setup_shutdown_event(void)
+{
+	static struct notifier_block xenstore_notifier = {
+		.notifier_call = shutdown_event
+	};
+	register_xenstore_notifier(&xenstore_notifier);
+
+	return 0;
+}
+
+subsys_initcall(setup_shutdown_event);

-- 
