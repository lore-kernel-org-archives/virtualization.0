From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 8/8] virtio: console: struct ports for multiple ports per
	device.
Date: Tue, 10 Nov 2009 16:57:30 +1030
Message-ID: <2924.61249414391$1257834876@news.gmane.org>
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


Rather than assume a single port, add a 'struct ports' with an array
of ports.  Currently, there's always only one, but that will change.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |   77 +++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -39,6 +39,13 @@ struct port {
 	u32 vtermno;
 };
 
+/* This is vdev->priv. */
+struct ports {
+	/* We use a simple array. */
+	unsigned int num_ports;
+	struct port port[0];
+};
+
 /* The list of ports. */
 static LIST_HEAD(ports_by_vtermno);
 
@@ -122,8 +129,11 @@ static int get_chars(u32 vtermno, char *
 
 	/* No more in buffer?  See if they've (re)used it. */
 	if (port->offset == port->used_len) {
-		if (!port->in_vq->vq_ops->get_buf(port->in_vq, &port->used_len))
+		unsigned int len;
+
+		if (!port->in_vq->vq_ops->get_buf(port->in_vq, &len))
 			return 0;
+		port->used_len = len;
 		port->offset = 0;
 	}
 
@@ -148,7 +158,7 @@ static int get_chars(u32 vtermno, char *
  */
 static void virtcons_apply_config(struct virtio_device *dev)
 {
-	struct port *port = dev->priv;
+	struct ports *ports = dev->priv;
 	struct winsize ws;
 
 	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
@@ -158,7 +168,9 @@ static void virtcons_apply_config(struct
 		dev->config->get(dev,
 				 offsetof(struct virtio_console_config, rows),
 				 &ws.ws_row, sizeof(u16));
-		hvc_resize(port->hvc, ws);
+		/* This is the pre-multiport style: we use control messages
+		 * these days which specify the port.  So this means port 0. */
+		hvc_resize(ports->port[0].hvc, ws);
 	}
 }
 
@@ -181,9 +193,14 @@ static void notifier_del_vio(struct hvc_
 
 static void hvc_handle_input(struct virtqueue *vq)
 {
-	struct port *port = vq->vdev->priv;
+	struct ports *ports = vq->vdev->priv;
+	unsigned int i;
+	bool activity = false;
 
-	if (hvc_poll(port->hvc))
+	for (i = 0; i < ports->num_ports; i++)
+		activity |= hvc_poll(ports->port[i].hvc);
+
+	if (activity)
 		hvc_kick();
 }
 
@@ -208,28 +225,37 @@ int __init virtio_cons_early_init(int (*
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
-static struct port *__devinit alloc_port(u32 vtermno)
+static struct ports *__devinit alloc_ports(unsigned int num)
 {
-	struct port *port = kmalloc(sizeof *port, GFP_KERNEL);
+	struct ports *ports;
+	int i;
 
-	if (!port)
+	ports = kmalloc(sizeof *ports + sizeof(ports->port[0]) * num,
+			GFP_KERNEL);
+	if (!ports)
 		return NULL;
 
-	port->used_len = port->offset = 0;
-	port->inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!port->inbuf) {
-		kfree(port);
-		return NULL;
+	ports->num_ports = num;
+	for (i = 0; i < ports->num_ports; i++) {
+		ports->port[i].used_len = ports->port[i].offset = 0;
+		ports->port[i].inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (unlikely(!ports->port[i].inbuf)) {
+			while (--i >= 0)
+				kfree(ports->port[i].inbuf);
+			kfree(ports);
+			return NULL;
+		}
 	}
-	port->hvc = NULL;
-	port->vtermno = vtermno;
-	return port;
+	return ports;
 }
 
-static void free_port(struct port *port)
+static void free_ports(struct ports *ports)
 {
-	kfree(port->inbuf);
-	kfree(port);
+	unsigned int i;
+
+	for (i = 0; i < ports->num_ports; i++)
+		kfree(ports->port[i].inbuf);
+	kfree(ports);
 }
 
 /* Once we're further in boot, we get probed like any other virtio device.
@@ -245,17 +271,21 @@ static int __devinit virtcons_probe(stru
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	int err;
+	struct ports *ports;
 	struct port *port;
 
-	port = alloc_port(0);
-	if (!port) {
+	ports = alloc_ports(1);
+	if (!ports) {
 		err = -ENOMEM;
 		goto fail;
 	}
 
+	/* Convenience variable since we only have one port. */
+	port = &ports->port[0];
+
 	/* Attach this port to this virtio_device, and vice-versa. */
 	port->vdev = vdev;
-	vdev->priv = port;
+	vdev->priv = ports;
 
 	/* Find the queues. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
@@ -275,6 +305,7 @@ static int __devinit virtcons_probe(stru
 	 * The final argument is the output buffer size: we can do any size,
 	 * so we put PAGE_SIZE here.
 	 */
+	port->vtermno = 0;
 	port->hvc = hvc_alloc(port->vtermno, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(port->hvc)) {
 		err = PTR_ERR(port->hvc);
@@ -296,7 +327,7 @@ static int __devinit virtcons_probe(stru
 free_vqs:
 	vdev->config->del_vqs(vdev);
 free:
-	free_port(port);
+	free_ports(ports);
 fail:
 	return err;
 }
