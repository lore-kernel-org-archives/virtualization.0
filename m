From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/4] virtio: disable multiport console support.
Date: Tue, 30 Mar 2010 15:49:43 +1030
Message-ID: <201003301549.43186.rusty@rustcorp.com.au>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Unfortunately there proved to be at least one bug which requires an
ABI change, so we're best off not introducing multiport support until
2.6.35.

While I generally left the multiport code paths intact, I really wanted
to remove the ABI defines from the header, which meant some quite deep cuts.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
To: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |  274 -----------------------------------------
 include/linux/virtio_console.h |   19 --
 2 files changed, 4 insertions(+), 289 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -252,15 +252,10 @@ static bool is_console_port(struct port 
 	return false;
 }
 
+/* This is incomplete. */
 static inline bool use_multiport(struct ports_device *portdev)
 {
-	/*
-	 * This condition can be true when put_chars is called from
-	 * early_init
-	 */
-	if (!portdev->vdev)
-		return 0;
-	return portdev->vdev->features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+	return false;
 }
 
 static void free_buf(struct port_buffer *buf)
@@ -373,31 +368,8 @@ out:
 	return ret;
 }
 
-static ssize_t send_control_msg(struct port *port, unsigned int event,
-				unsigned int value)
-{
-	struct scatterlist sg[1];
-	struct virtio_console_control cpkt;
-	struct virtqueue *vq;
-	unsigned int len;
-
-	if (!use_multiport(port->portdev))
-		return 0;
-
-	cpkt.id = port->id;
-	cpkt.event = event;
-	cpkt.value = value;
-
-	vq = port->portdev->c_ovq;
-
-	sg_init_one(sg, &cpkt, sizeof(cpkt));
-	if (vq->vq_ops->add_buf(vq, sg, 1, 0, &cpkt) >= 0) {
-		vq->vq_ops->kick(vq);
-		while (!vq->vq_ops->get_buf(vq, &len))
-			cpu_relax();
-	}
-	return 0;
-}
+/* For when we support control messages. */
+#define send_control_msg(port, event, value) 0
 
 static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 {
@@ -882,142 +854,6 @@ static int remove_port(struct port *port
 	return 0;
 }
 
-/* Any private messages that the Host and Guest want to share */
-static void handle_control_message(struct ports_device *portdev,
-				   struct port_buffer *buf)
-{
-	struct virtio_console_control *cpkt;
-	struct port *port;
-	size_t name_size;
-	int err;
-
-	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
-
-	port = find_port_by_id(portdev, cpkt->id);
-	if (!port) {
-		/* No valid header at start of buffer.  Drop it. */
-		dev_dbg(&portdev->vdev->dev,
-			"Invalid index %u in control packet\n", cpkt->id);
-		return;
-	}
-
-	switch (cpkt->event) {
-	case VIRTIO_CONSOLE_CONSOLE_PORT:
-		if (!cpkt->value)
-			break;
-		if (is_console_port(port))
-			break;
-
-		init_port_console(port);
-		/*
-		 * Could remove the port here in case init fails - but
-		 * have to notify the host first.
-		 */
-		break;
-	case VIRTIO_CONSOLE_RESIZE:
-		if (!is_console_port(port))
-			break;
-		port->cons.hvc->irq_requested = 1;
-		resize_console(port);
-		break;
-	case VIRTIO_CONSOLE_PORT_OPEN:
-		port->host_connected = cpkt->value;
-		wake_up_interruptible(&port->waitqueue);
-		break;
-	case VIRTIO_CONSOLE_PORT_NAME:
-		/*
-		 * Skip the size of the header and the cpkt to get the size
-		 * of the name that was sent
-		 */
-		name_size = buf->len - buf->offset - sizeof(*cpkt) + 1;
-
-		port->name = kmalloc(name_size, GFP_KERNEL);
-		if (!port->name) {
-			dev_err(port->dev,
-				"Not enough space to store port name\n");
-			break;
-		}
-		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
-			name_size - 1);
-		port->name[name_size - 1] = 0;
-
-		/*
-		 * Since we only have one sysfs attribute, 'name',
-		 * create it only if we have a name for the port.
-		 */
-		err = sysfs_create_group(&port->dev->kobj,
-					 &port_attribute_group);
-		if (err) {
-			dev_err(port->dev,
-				"Error %d creating sysfs device attributes\n",
-				err);
-		} else {
-			/*
-			 * Generate a udev event so that appropriate
-			 * symlinks can be created based on udev
-			 * rules.
-			 */
-			kobject_uevent(&port->dev->kobj, KOBJ_CHANGE);
-		}
-		break;
-	case VIRTIO_CONSOLE_PORT_REMOVE:
-		/*
-		 * Hot unplug the port.  We don't decrement nr_ports
-		 * since we don't want to deal with extra complexities
-		 * of using the lowest-available port id: We can just
-		 * pick up the nr_ports number as the id and not have
-		 * userspace send it to us.  This helps us in two
-		 * ways:
-		 *
-		 * - We don't need to have a 'port_id' field in the
-		 *   config space when a port is hot-added.  This is a
-		 *   good thing as we might queue up multiple hotplug
-		 *   requests issued in our workqueue.
-		 *
-		 * - Another way to deal with this would have been to
-		 *   use a bitmap of the active ports and select the
-		 *   lowest non-active port from that map.  That
-		 *   bloats the already tight config space and we
-		 *   would end up artificially limiting the
-		 *   max. number of ports to sizeof(bitmap).  Right
-		 *   now we can support 2^32 ports (as the port id is
-		 *   stored in a u32 type).
-		 *
-		 */
-		remove_port(port);
-		break;
-	}
-}
-
-static void control_work_handler(struct work_struct *work)
-{
-	struct ports_device *portdev;
-	struct virtqueue *vq;
-	struct port_buffer *buf;
-	unsigned int len;
-
-	portdev = container_of(work, struct ports_device, control_work);
-	vq = portdev->c_ivq;
-
-	spin_lock(&portdev->cvq_lock);
-	while ((buf = vq->vq_ops->get_buf(vq, &len))) {
-		spin_unlock(&portdev->cvq_lock);
-
-		buf->len = len;
-		buf->offset = 0;
-
-		handle_control_message(portdev, buf);
-
-		spin_lock(&portdev->cvq_lock);
-		if (add_inbuf(portdev->c_ivq, buf) < 0) {
-			dev_warn(&portdev->vdev->dev,
-				 "Error adding buffer to queue\n");
-			free_buf(buf);
-		}
-	}
-	spin_unlock(&portdev->cvq_lock);
-}
-
 static void in_intr(struct virtqueue *vq)
 {
 	struct port *port;
@@ -1206,62 +1042,6 @@ fail:
 	return err;
 }
 
-/*
- * The workhandler for config-space updates.
- *
- * This is called when ports are hot-added.
- */
-static void config_work_handler(struct work_struct *work)
-{
-	struct virtio_console_config virtconconf;
-	struct ports_device *portdev;
-	struct virtio_device *vdev;
-	int err;
-
-	portdev = container_of(work, struct ports_device, config_work);
-
-	vdev = portdev->vdev;
-	vdev->config->get(vdev,
-			  offsetof(struct virtio_console_config, nr_ports),
-			  &virtconconf.nr_ports,
-			  sizeof(virtconconf.nr_ports));
-
-	if (portdev->config.nr_ports == virtconconf.nr_ports) {
-		/*
-		 * Port 0 got hot-added.  Since we already did all the
-		 * other initialisation for it, just tell the Host
-		 * that the port is ready if we find the port.  In
-		 * case the port was hot-removed earlier, we call
-		 * add_port to add the port.
-		 */
-		struct port *port;
-
-		port = find_port_by_id(portdev, 0);
-		if (!port)
-			add_port(portdev, 0);
-		else
-			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
-		return;
-	}
-	if (virtconconf.nr_ports > portdev->config.max_nr_ports) {
-		dev_warn(&vdev->dev,
-			 "More ports specified (%u) than allowed (%u)",
-			 portdev->config.nr_ports + 1,
-			 portdev->config.max_nr_ports);
-		return;
-	}
-	if (virtconconf.nr_ports < portdev->config.nr_ports)
-		return;
-
-	/* Hot-add ports */
-	while (virtconconf.nr_ports - portdev->config.nr_ports) {
-		err = add_port(portdev, portdev->config.nr_ports);
-		if (err)
-			break;
-		portdev->config.nr_ports++;
-	}
-}
-
 static int init_vqs(struct ports_device *portdev)
 {
 	vq_callback_t **io_callbacks;
@@ -1385,7 +1165,6 @@ static int __devinit virtcons_probe(stru
 	struct ports_device *portdev;
 	u32 i;
 	int err;
-	bool multiport;
 
 	portdev = kmalloc(sizeof(*portdev), GFP_KERNEL);
 	if (!portdev) {
@@ -1411,32 +1190,8 @@ static int __devinit virtcons_probe(stru
 		goto free;
 	}
 
-	multiport = false;
 	portdev->config.nr_ports = 1;
 	portdev->config.max_nr_ports = 1;
-	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
-		multiport = true;
-		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
-
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 nr_ports),
-				  &portdev->config.nr_ports,
-				  sizeof(portdev->config.nr_ports));
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 max_nr_ports),
-				  &portdev->config.max_nr_ports,
-				  sizeof(portdev->config.max_nr_ports));
-		if (portdev->config.nr_ports > portdev->config.max_nr_ports) {
-			dev_warn(&vdev->dev,
-				 "More ports (%u) specified than allowed (%u). Will init %u ports.",
-				 portdev->config.nr_ports,
-				 portdev->config.max_nr_ports,
-				 portdev->config.max_nr_ports);
-
-			portdev->config.nr_ports = portdev->config.max_nr_ports;
-		}
-	}
-
 	/* Let the Host know we support multiple ports.*/
 	vdev->config->finalize_features(vdev);
 
@@ -1449,22 +1204,6 @@ static int __devinit virtcons_probe(stru
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
 
-	if (multiport) {
-		unsigned int nr_added_bufs;
-
-		spin_lock_init(&portdev->cvq_lock);
-		INIT_WORK(&portdev->control_work, &control_work_handler);
-		INIT_WORK(&portdev->config_work, &config_work_handler);
-
-		nr_added_bufs = fill_queue(portdev->c_ivq, &portdev->cvq_lock);
-		if (!nr_added_bufs) {
-			dev_err(&vdev->dev,
-				"Error allocating buffers for control queue\n");
-			err = -ENOMEM;
-			goto free_vqs;
-		}
-	}
-
 	for (i = 0; i < portdev->config.nr_ports; i++)
 		add_port(portdev, i);
 
@@ -1472,10 +1211,6 @@ static int __devinit virtcons_probe(stru
 	early_put_chars = NULL;
 	return 0;
 
-free_vqs:
-	vdev->config->del_vqs(vdev);
-	kfree(portdev->in_vqs);
-	kfree(portdev->out_vqs);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
@@ -1521,7 +1256,6 @@ static struct virtio_device_id id_table[
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
-	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -12,7 +12,6 @@
 
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
-#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
 struct virtio_console_config {
 	/* colums of the screens */
@@ -25,24 +24,6 @@ struct virtio_console_config {
 	__u32 nr_ports;
 } __attribute__((packed));
 
-/*
- * A message that's passed between the Host and the Guest for a
- * particular port.
- */
-struct virtio_console_control {
-	__u32 id;		/* Port number */
-	__u16 event;		/* The kind of control event (see below) */
-	__u16 value;		/* Extra information for the key */
-};
-
-/* Some events for control messages */
-#define VIRTIO_CONSOLE_PORT_READY	0
-#define VIRTIO_CONSOLE_CONSOLE_PORT	1
-#define VIRTIO_CONSOLE_RESIZE		2
-#define VIRTIO_CONSOLE_PORT_OPEN	3
-#define VIRTIO_CONSOLE_PORT_NAME	4
-#define VIRTIO_CONSOLE_PORT_REMOVE	5
-
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 #endif /* __KERNEL__ */
