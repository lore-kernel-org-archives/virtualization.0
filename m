From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 13/31] virtio: console: struct ports for multiple ports per
	device.
Date: Tue, 22 Dec 2009 20:04:23 +0530
Message-ID: <1261492481-19817-14-git-send-email-amit.shah@redhat.com>
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
	<1261492481-19817-13-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-13-git-send-email-amit.shah@redhat.com>
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

Rather than assume a single port, add a 'struct ports_device' which
stores data related to all the ports for that device.

Currently, there's only one port and is hooked up with hvc, but that
will change.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  152 ++++++++++++++++++++++++-----------------
 1 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5c0ce16..bef9554 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -51,6 +51,15 @@ static struct ports_driver_data pdrvdata;
 
 DEFINE_SPINLOCK(pdrvdata_lock);
 
+/*
+ * This is a per-device struct that stores data common to all the
+ * ports for that device (vdev->priv).
+ */
+struct ports_device {
+	struct virtqueue *in_vq, *out_vq;
+	struct virtio_device *vdev;
+};
+
 struct port_buffer {
 	char *buf;
 
@@ -63,13 +72,17 @@ struct port_buffer {
 	size_t offset;
 };
 
+/* This struct holds the per-port data */
 struct port {
-	struct virtqueue *in_vq, *out_vq;
-	struct virtio_device *vdev;
+	/* Pointer to the parent virtio_console device */
+	struct ports_device *portdev;
 
 	/* The current buffer from which data has to be fed to readers */
 	struct port_buffer *inbuf;
 
+	/* The IO vqs for this port */
+	struct virtqueue *in_vq, *out_vq;
+
 	/* For console ports, hvc != NULL and these are valid. */
 	/* The hvc device */
 	struct hvc_struct *hvc;
@@ -152,6 +165,7 @@ static void *get_inbuf(struct port *port)
 static void add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 {
 	struct scatterlist sg[1];
+
 	sg_init_one(sg, buf->buf, buf->size);
 
 	if (vq->vq_ops->add_buf(vq, sg, 0, 1, buf) < 0)
@@ -171,6 +185,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 {
 	struct scatterlist sg[1];
 	struct port *port;
+	struct virtqueue *out_vq;
 	unsigned int len;
 
 	port = find_port_by_vtermno(vtermno);
@@ -180,14 +195,15 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
+	out_vq = port->out_vq;
 	/* This is a convenient routine to initialize a single-elem sg list */
 	sg_init_one(sg, buf, count);
 
 	/* This shouldn't fail: if it does, we lose chars. */
-	if (port->out_vq->vq_ops->add_buf(port->out_vq, sg, 1, 0, port) >= 0) {
+	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, port) >= 0) {
 		/* Tell Host to go! */
-		port->out_vq->vq_ops->kick(port->out_vq);
-		while (!port->out_vq->vq_ops->get_buf(port->out_vq, &len))
+		out_vq->vq_ops->kick(out_vq);
+		while (!out_vq->vq_ops->get_buf(out_vq, &len))
 			cpu_relax();
 	}
 
@@ -207,7 +223,6 @@ static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
 
-
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return 0;
@@ -242,7 +257,6 @@ static int get_chars(u32 vtermno, char *buf, int count)
  */
 static void virtcons_apply_config(struct virtio_device *dev)
 {
-	struct port *port = dev->priv;
 	struct winsize ws;
 
 	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
@@ -252,7 +266,9 @@ static void virtcons_apply_config(struct virtio_device *dev)
 		dev->config->get(dev,
 				 offsetof(struct virtio_console_config, rows),
 				 &ws.ws_row, sizeof(u16));
-		hvc_resize(port->hvc, ws);
+		/* This is the pre-multiport style: we use control messages
+		 * these days which specify the port.  So this means port 0. */
+		hvc_resize(find_port_by_vtermno(0)->hvc, ws);
 	}
 }
 
@@ -266,7 +282,7 @@ static int notifier_add_vio(struct hvc_struct *hp, int data)
 		return -EINVAL;
 
 	hp->irq_requested = 1;
-	virtcons_apply_config(port->vdev);
+	virtcons_apply_config(port->portdev->vdev);
 
 	return 0;
 }
@@ -278,9 +294,13 @@ static void notifier_del_vio(struct hvc_struct *hp, int data)
 
 static void hvc_handle_input(struct virtqueue *vq)
 {
-	struct port *port = vq->vdev->priv;
+	struct port *port;
+	bool activity = false;
+
+	list_for_each_entry(port, &pdrvdata.consoles, list)
+		activity |= hvc_poll(port->hvc);
 
-	if (hvc_poll(port->hvc))
+	if (activity)
 		hvc_kick();
 }
 
@@ -308,66 +328,26 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
-static struct port *__devinit add_port(u32 vtermno)
-{
-	struct port *port;
-
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
-	if (!port)
-		return NULL;
-
-	port->inbuf = alloc_buf(PAGE_SIZE);
-	if (!port->inbuf) {
-		kfree(port);
-		return NULL;
-	}
-	port->hvc = NULL;
-	port->vtermno = vtermno;
-	return port;
-}
-
-static void free_port(struct port *port)
+static int __devinit add_port(struct ports_device *portdev)
 {
-	free_buf(port->inbuf);
-	kfree(port);
-}
-
-/*
- * Once we're further in boot, we get probed like any other virtio
- * device.  At this stage we set up the output virtqueue.
- *
- * To set up and manage our virtual console, we call hvc_alloc().
- * Since we never remove the console device we never need this pointer
- * again.
- *
- * Finally we put our input buffer in the input queue, ready to
- * receive.
- */
-static int __devinit virtcons_probe(struct virtio_device *vdev)
-{
-	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
-	const char *names[] = { "input", "output" };
-	struct virtqueue *vqs[2];
 	struct port *port;
 	int err;
 
-	port = add_port(pdrvdata.next_vtermno);
+	port = kmalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		err = -ENOMEM;
 		goto fail;
 	}
 
-	/* Attach this port to this virtio_device, and vice-versa. */
-	port->vdev = vdev;
-	vdev->priv = port;
+	port->portdev = portdev;
+	port->in_vq = portdev->in_vq;
+	port->out_vq = portdev->out_vq;
 
-	/* Find the queues. */
-	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
-	if (err)
-		goto free;
-
-	port->in_vq = vqs[0];
-	port->out_vq = vqs[1];
+	port->inbuf = alloc_buf(PAGE_SIZE);
+	if (!port->inbuf) {
+		err = -ENOMEM;
+		goto free_port;
+	}
 
 	/*
 	 * The first argument of hvc_alloc() is the virtual console
@@ -380,10 +360,11 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
+	port->vtermno = pdrvdata.next_vtermno;
 	port->hvc = hvc_alloc(port->vtermno, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(port->hvc)) {
 		err = PTR_ERR(port->hvc);
-		goto free_vqs;
+		goto free_inbuf;
 	}
 
 	/* Add to vtermno list. */
@@ -395,6 +376,51 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	/* Register the input buffer the first time. */
 	add_inbuf(port->in_vq, port->inbuf);
 
+	return 0;
+
+free_inbuf:
+	free_buf(port->inbuf);
+free_port:
+	kfree(port);
+fail:
+	return err;
+}
+
+/*
+ * Once we're further in boot, we get probed like any other virtio
+ * device.
+ */
+static int __devinit virtcons_probe(struct virtio_device *vdev)
+{
+	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
+	const char *names[] = { "input", "output" };
+	struct virtqueue *vqs[2];
+	struct ports_device *portdev;
+	int err;
+
+	portdev = kmalloc(sizeof(*portdev), GFP_KERNEL);
+	if (!portdev) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	/* Attach this portdev to this virtio_device, and vice-versa. */
+	portdev->vdev = vdev;
+	vdev->priv = portdev;
+
+	/* Find the queues. */
+	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
+	if (err)
+		goto free;
+
+	portdev->in_vq = vqs[0];
+	portdev->out_vq = vqs[1];
+
+	/* We only have one port. */
+	err = add_port(portdev);
+	if (err)
+		goto free_vqs;
+
 	/* Start using the new console output. */
 	early_put_chars = NULL;
 	return 0;
@@ -402,7 +428,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 free_vqs:
 	vdev->config->del_vqs(vdev);
 free:
-	free_port(port);
+	kfree(portdev);
 fail:
 	return err;
 }
-- 
1.6.2.5
