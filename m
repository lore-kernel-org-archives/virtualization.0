From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 7/8] virtio: console: remove global var
Date: Tue, 10 Nov 2009 16:57:30 +1030
Message-ID: <44216.3370586515$1257834633@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Now we can use an allocation function to remove our global console variable.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |   58 ++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -45,9 +45,6 @@ static LIST_HEAD(ports_by_vtermno);
 /* The lock on the port list. */
 static DEFINE_SPINLOCK(ports_by_vtermno_lock);
 
-/* We have one port ready to go immediately, for a console. */
-static struct port console;
-
 /* This is the very early put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
 
@@ -211,6 +208,30 @@ int __init virtio_cons_early_init(int (*
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
+static struct port *__devinit alloc_port(u32 vtermno)
+{
+	struct port *port = kmalloc(sizeof *port, GFP_KERNEL);
+
+	if (!port)
+		return NULL;
+
+	port->used_len = port->offset = 0;
+	port->inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
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
+	kfree(port->inbuf);
+	kfree(port);
+}
+
 /* Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
  *
@@ -224,20 +245,18 @@ static int __devinit virtcons_probe(stru
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	int err;
-	struct port *port = &console;
+	struct port *port;
+
+	port = alloc_port(0);
+	if (!port) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	/* Attach this port to this virtio_device, and vice-versa. */
 	port->vdev = vdev;
 	vdev->priv = port;
 
-	/* This is the scratch page we use to receive console input */
-	port->used_len = 0;
-	port->inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!port->inbuf) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
 	/* Find the queues. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
 	if (err)
@@ -246,16 +265,17 @@ static int __devinit virtcons_probe(stru
 	port->in_vq = vqs[0];
 	port->out_vq = vqs[1];
 
-	/* The first argument of hvc_alloc() is the virtual console number, so
-	 * we use zero.  The second argument is the parameter for the
-	 * notification mechanism (like irq number). We currently leave this
-	 * as zero, virtqueues have implicit notifications.
+	/*
+	 * The second argument is the parameter for the notification mechanism
+	 * (like irq number). We currently leave this as zero, virtqueues have
+	 * implicit notifications.
 	 *
 	 * The third argument is a "struct hv_ops" containing the put_chars()
 	 * get_chars(), notifier_add() and notifier_del() pointers.
 	 * The final argument is the output buffer size: we can do any size,
-	 * so we put PAGE_SIZE here. */
-	port->hvc = hvc_alloc(0, 0, &hv_ops, PAGE_SIZE);
+	 * so we put PAGE_SIZE here.
+	 */
+	port->hvc = hvc_alloc(port->vtermno, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(port->hvc)) {
 		err = PTR_ERR(port->hvc);
 		goto free_vqs;
@@ -276,7 +296,7 @@ static int __devinit virtcons_probe(stru
 free_vqs:
 	vdev->config->del_vqs(vdev);
 free:
-	kfree(port->inbuf);
+	free_port(port);
 fail:
 	return err;
 }
