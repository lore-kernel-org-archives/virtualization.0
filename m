From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 12/31] virtio: console: remove global var
Date: Tue, 22 Dec 2009 20:04:22 +0530
Message-ID: <1261492481-19817-13-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-8-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-9-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-10-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-11-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-12-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-12-git-send-email-amit.shah@redhat.com>
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

From: Rusty Russell <rusty@rustcorp.com.au>

Now we can use an allocation function to remove our global console variable.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   67 ++++++++++++++++++++++++++++-------------
 1 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fded596..5c0ce16 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -32,6 +32,18 @@
  * across multiple devices and multiple ports per device.
  */
 struct ports_driver_data {
+	/*
+	 * This is used to keep track of the number of hvc consoles
+	 * spawned by this driver.  This number is given as the first
+	 * argument to hvc_alloc().  To correctly map an initial
+	 * console spawned via hvc_instantiate to the console being
+	 * hooked up via hvc_alloc, we need to pass the same vtermno.
+	 *
+	 * We also just assume the first console being initialised was
+	 * the first one that got used as the initial console.
+	 */
+	unsigned int next_vtermno;
+
 	/* All the console devices handled by this driver */
 	struct list_head consoles;
 };
@@ -69,9 +81,6 @@ struct port {
 	u32 vtermno;
 };
 
-/* We have one port ready to go immediately, for a console. */
-static struct port console;
-
 /* This is the very early arch-specified put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
 
@@ -299,6 +308,30 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
+static struct port *__devinit add_port(u32 vtermno)
+{
+	struct port *port;
+
+	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return NULL;
+
+	port->inbuf = alloc_buf(PAGE_SIZE);
+	if (!port->inbuf) {
+		kfree(port);
+		return NULL;
+	}
+	port->hvc = NULL;
+	port->vtermno = vtermno;
+	return port;
+}
+
+static void free_port(struct port *port)
+{
+	free_buf(port->inbuf);
+	kfree(port);
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.  At this stage we set up the output virtqueue.
@@ -318,24 +351,16 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	struct port *port;
 	int err;
 
-	port = &console;
-	if (port->vdev) {
-		dev_warn(&port->vdev->dev,
-			 "Multiple virtio-console devices not supported yet\n");
-		return -EEXIST;
+	port = add_port(pdrvdata.next_vtermno);
+	if (!port) {
+		err = -ENOMEM;
+		goto fail;
 	}
 
 	/* Attach this port to this virtio_device, and vice-versa. */
 	port->vdev = vdev;
 	vdev->priv = port;
 
-	/* This is the scratch page we use to receive console input */
-	port->inbuf = alloc_buf(PAGE_SIZE);
-	if (!port->inbuf) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
 	/* Find the queues. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
 	if (err)
@@ -346,17 +371,16 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	/*
 	 * The first argument of hvc_alloc() is the virtual console
-	 * number, so we use zero.  The second argument is the
-	 * parameter for the notification mechanism (like irq
-	 * number). We currently leave this as zero, virtqueues have
-	 * implicit notifications.
+	 * number.  The second argument is the parameter for the
+	 * notification mechanism (like irq number).  We currently
+	 * leave this as zero, virtqueues have implicit notifications.
 	 *
 	 * The third argument is a "struct hv_ops" containing the
 	 * put_chars(), get_chars(), notifier_add() and notifier_del()
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	port->hvc = hvc_alloc(0, 0, &hv_ops, PAGE_SIZE);
+	port->hvc = hvc_alloc(port->vtermno, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(port->hvc)) {
 		err = PTR_ERR(port->hvc);
 		goto free_vqs;
@@ -364,6 +388,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	/* Add to vtermno list. */
 	spin_lock_irq(&pdrvdata_lock);
+	pdrvdata.next_vtermno++;
 	list_add(&port->list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 
@@ -377,7 +402,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 free_vqs:
 	vdev->config->del_vqs(vdev);
 free:
-	free_buf(port->inbuf);
+	free_port(port);
 fail:
 	return err;
 }
-- 
1.6.2.5
