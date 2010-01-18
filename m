From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 11/32] virtio: console: don't assume a single console port.
Date: Mon, 18 Jan 2010 19:15:05 +0530
Message-ID: <1263822326-24208-12-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-11-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   74 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e52ee11..6bbf707 100644
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
 struct port_buffer {
 	char *buf;
 
@@ -40,8 +58,15 @@ struct port {
 	/* The current buffer from which data has to be fed to readers */
 	struct port_buffer *inbuf;
 
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
@@ -50,6 +75,22 @@ static struct port console;
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
 static void free_buf(struct port_buffer *buf)
 {
 	kfree(buf->buf);
@@ -120,14 +161,16 @@ static void add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 static int put_chars(u32 vtermno, const char *buf, int count)
 {
 	struct scatterlist sg[1];
-	unsigned int len;
 	struct port *port;
+	unsigned int len;
+
+	port = find_port_by_vtermno(vtermno);
+	if (!port)
+		return 0;
 
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	port = &console;
-
 	/* This is a convenient routine to initialize a single-elem sg list */
 	sg_init_one(sg, buf, count);
 
@@ -155,7 +198,10 @@ static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
 
-	port = &console;
+
+	port = find_port_by_vtermno(vtermno);
+	if (!port)
+		return 0;
 
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
@@ -201,14 +247,17 @@ static void virtcons_apply_config(struct virtio_device *dev)
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
@@ -313,6 +362,11 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		goto free_vqs;
 	}
 
+	/* Add to vtermno list. */
+	spin_lock_irq(&pdrvdata_lock);
+	list_add(&port->list, &pdrvdata.consoles);
+	spin_unlock_irq(&pdrvdata_lock);
+
 	/* Register the input buffer the first time. */
 	add_inbuf(port->in_vq, port->inbuf);
 
@@ -349,6 +403,8 @@ static struct virtio_driver virtio_console = {
 
 static int __init init(void)
 {
+	INIT_LIST_HEAD(&pdrvdata.consoles);
+
 	return register_virtio_driver(&virtio_console);
 }
 module_init(init);
-- 
1.6.2.5
