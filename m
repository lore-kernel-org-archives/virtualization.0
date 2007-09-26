From: rusty@rustcorp.com.au
Subject: [patch 12/43] lguest: Only start khvcd when someone uses
	hvc_console driver.
Date: Wed, 26 Sep 2007 16:36:30 +1000
Message-ID: <20070926063647.059111284@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=fix-hvc-thread.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Dave Jones <davej@codemonkey.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Anton Blanchard <anton@au1.ibm.com>, virtualization@lists.linux-foundation.org, paulus <paulus@au1.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This changes hvc_init() to be called only when someone actually uses
the hvc_console driver.

hvc_console used to only be for pSeries and iSeries: now lguest and
Xen both want it built-in in case the kernel is a guest under one of
those, even though usually it will be a native boot.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anton Blanchard <anton@au1.ibm.com>
Cc: paulus <paulus@au1.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Jones <davej@codemonkey.org.uk>
---
 drivers/char/Kconfig       |    4 +-
 drivers/char/hvc_console.c |   66 ++++++++++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff -r 3c2969068458 drivers/char/Kconfig
--- a/drivers/char/Kconfig	Wed Sep 26 14:46:19 2007 +1000
+++ b/drivers/char/Kconfig	Wed Sep 26 14:46:50 2007 +1000
@@ -568,8 +568,8 @@ config HVC_DRIVER
 config HVC_DRIVER
 	bool
 	help
-	  Users of pSeries machines that want to utilize the hvc console front-end
-	  module for their backend console driver should select this option.
+	  Generic "hypervisor virtual console" infrastructure for various
+	  hypervisors (pSeries, iSeries, Xen, lguest).
 	  It will automatically be selected if one of the back-end console drivers
 	  is selected.
 
diff -r 3c2969068458 drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c	Wed Sep 26 14:46:19 2007 +1000
+++ b/drivers/char/hvc_console.c	Wed Sep 26 14:46:21 2007 +1000
@@ -68,6 +68,8 @@ static struct task_struct *hvc_task;
 
 /* Picks up late kicks after list walk but before schedule() */
 static int hvc_kicked;
+
+static int hvc_init(void);
 
 #ifdef CONFIG_MAGIC_SYSRQ
 static int sysrq_pressed;
@@ -754,6 +756,13 @@ struct hvc_struct __devinit *hvc_alloc(u
 	struct hvc_struct *hp;
 	int i;
 
+	/* We wait until a driver actually comes along */
+	if (!hvc_driver) {
+		int err = hvc_init();
+		if (err)
+			return ERR_PTR(err);
+	}
+
 	hp = kmalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
 			GFP_KERNEL);
 	if (!hp)
@@ -829,16 +838,18 @@ int __devexit hvc_remove(struct hvc_stru
 	return 0;
 }
 
-/* Driver initialization.  Follow console initialization.  This is where the TTY
- * interfaces start to become available. */
-static int __init hvc_init(void)
+/* Driver initialization: called as soon as someone uses hvc_alloc(). */
+static int hvc_init(void)
 {
 	struct tty_driver *drv;
+	int err;
 
 	/* We need more than hvc_count adapters due to hotplug additions. */
 	drv = alloc_tty_driver(HVC_ALLOC_TTY_ADAPTERS);
-	if (!drv)
-		return -ENOMEM;
+	if (!drv) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	drv->owner = THIS_MODULE;
 	drv->driver_name = "hvc";
@@ -854,30 +865,43 @@ static int __init hvc_init(void)
 	 * added later. */
 	hvc_task = kthread_run(khvcd, NULL, "khvcd");
 	if (IS_ERR(hvc_task)) {
-		panic("Couldn't create kthread for console.\n");
-		put_tty_driver(drv);
-		return -EIO;
-	}
-
-	if (tty_register_driver(drv))
-		panic("Couldn't register hvc console driver\n");
-
+		printk(KERN_ERR "Couldn't create kthread for console.\n");
+		err = PTR_ERR(hvc_task);
+		goto put_tty;
+	}
+
+	err = tty_register_driver(drv);
+	if (err) {
+		printk(KERN_ERR "Couldn't register hvc console driver\n");
+		goto stop_thread;
+	}
+
+	/* FIXME: This mb() seems completely random.  Remove it. */
 	mb();
 	hvc_driver = drv;
 	return 0;
-}
-module_init(hvc_init);
+
+put_tty:
+	put_tty_driver(hvc_driver);
+stop_thread:
+	kthread_stop(hvc_task);
+	hvc_task = NULL;
+out:
+	return err;
+}
 
 /* This isn't particularly necessary due to this being a console driver
  * but it is nice to be thorough.
  */
 static void __exit hvc_exit(void)
 {
-	kthread_stop(hvc_task);
-
-	tty_unregister_driver(hvc_driver);
-	/* return tty_struct instances allocated in hvc_init(). */
-	put_tty_driver(hvc_driver);
-	unregister_console(&hvc_con_driver);
+	if (hvc_driver) {
+		kthread_stop(hvc_task);
+
+		tty_unregister_driver(hvc_driver);
+		/* return tty_struct instances allocated in hvc_init(). */
+		put_tty_driver(hvc_driver);
+		unregister_console(&hvc_con_driver);
+	}
 }
 module_exit(hvc_exit);

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
