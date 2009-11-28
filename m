From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 07/28] virtio: console: don't assume a single console port.
Date: Sat, 28 Nov 2009 12:20:30 +0530
Message-ID: <1259391051-7752-8-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-7-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Keep a list of all ports being used as a console, and provide a lock
and a lookup function.  The hvc callbacks only give us a vterm number,
so we need to map this.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   72 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2bbdbf5..c133bf6 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -17,10 +17,28 @@
  */
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_console.h>
 #include "hvc_console.h"
 
+/*
+ * This is a global struct for storing common data for all the devices
+ * this driver handles.
+ *
+ * Mainly, it has a linked list for all the consoles in one place so
+ * that callbacks from hvc for get_chars(), put_chars() work properly
+ * across multiple devices and multiple ports per device.
+ */
+struct ports_driver_data {
+	/* All the console devices handled by this driver */
+	struct list_head consoles;
+};
+static struct ports_driver_data pdrvdata;
+
+DEFINE_SPINLOCK(pdrvdata_lock);
+
 struct port {
 	struct virtqueue *in_vq, *out_vq;
 	struct virtio_device *vdev;
@@ -28,8 +46,15 @@ struct port {
 	char *inbuf;
 	unsigned int used_len, offset;
 
+	/* For console ports, hvc != NULL and these are valid. */
 	/* The hvc device */
 	struct hvc_struct *hvc;
+
+	/* We'll place all consoles in a list in the pdrvdata struct */
+	struct list_head list;
+
+	/* Our vterm number. */
+	u32 vtermno;
 };
 
 /* We have one port ready to go immediately, for a console. */
@@ -38,6 +63,22 @@ static struct port console;
 /* This is the very early arch-specified put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
 
+static struct port *find_port_by_vtermno(u32 vtermno)
+{
+	struct port *port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdrvdata_lock, flags);
+	list_for_each_entry(port, &pdrvdata.consoles, list) {
+		if (port->vtermno == vtermno)
+			goto out;
+	}
+	port = NULL;
+out:
+	spin_unlock_irqrestore(&pdrvdata_lock, flags);
+	return port;
+}
+
 /*
  * The put_chars() callback is pretty straightforward.
  *
@@ -49,8 +90,12 @@ static int (*early_put_chars)(u32, const char *, int);
 static int put_chars(u32 vtermno, const char *buf, int count)
 {
 	struct scatterlist sg[1];
+	struct port *port;
 	unsigned int len;
-	struct port *port = &console;
+
+	port = find_port_by_vtermno(vtermno);
+	if (!port)
+		return 0;
 
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
@@ -95,7 +140,11 @@ static void add_inbuf(struct port *port)
  */
 static int get_chars(u32 vtermno, char *buf, int count)
 {
-	struct port *port = &console;
+	struct port *port;
+
+	port = find_port_by_vtermno(vtermno);
+	if (!port)
+		return 0;
 
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
@@ -142,14 +191,17 @@ static void virtcons_apply_config(struct virtio_device *dev)
 	}
 }
 
-/*
- * we support only one console, the hvc struct is a global var We set
- * the configuration at this point, since we now have a tty
- */
+/* We set the configuration at this point, since we now have a tty */
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
+	struct port *port;
+
+	port = find_port_by_vtermno(hp->vtermno);
+	if (!port)
+		return -EINVAL;
+
 	hp->irq_requested = 1;
-	virtcons_apply_config(console.vdev);
+	virtcons_apply_config(port->vdev);
 
 	return 0;
 }
@@ -255,6 +307,11 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		goto free_vqs;
 	}
 
+	/* Add to vtermno list. */
+	spin_lock_irq(&pdrvdata_lock);
+	list_add(&port->list, &pdrvdata.consoles);
+	spin_unlock_irq(&pdrvdata_lock);
+
 	/* Register the input buffer the first time. */
 	add_inbuf(port);
 
@@ -291,6 +348,7 @@ static struct virtio_driver virtio_console = {
 
 static int __init init(void)
 {
+	INIT_LIST_HEAD(&pdrvdata.consoles);
 	return register_virtio_driver(&virtio_console);
 }
 module_init(init);
-- 
1.6.2.5
