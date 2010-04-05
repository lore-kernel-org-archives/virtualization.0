From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 06/10] virtio: console: Move code around for future patches
Date: Mon,  5 Apr 2010 19:24:10 +0530
Message-ID: <1270475654-399-7-git-send-email-amit.shah@redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-2-git-send-email-amit.shah@redhat.com>
	<1270475654-399-3-git-send-email-amit.shah@redhat.com>
	<1270475654-399-4-git-send-email-amit.shah@redhat.com>
	<1270475654-399-5-git-send-email-amit.shah@redhat.com>
	<1270475654-399-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-6-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We're going to use add_port() from handle_control_message() in the next
patch.

Move the add_port() and fill_queue(), which depends on it, above
handle_control_message() to avoid forward declarations.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  264 ++++++++++++++++++++---------------------
 1 files changed, 131 insertions(+), 133 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0473221..fd98861 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -862,6 +862,137 @@ static const struct file_operations port_debugfs_ops = {
 	.read  = debugfs_read,
 };
 
+static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
+{
+	struct port_buffer *buf;
+	unsigned int nr_added_bufs;
+	int ret;
+
+	nr_added_bufs = 0;
+	do {
+		buf = alloc_buf(PAGE_SIZE);
+		if (!buf)
+			break;
+
+		spin_lock_irq(lock);
+		ret = add_inbuf(vq, buf);
+		if (ret < 0) {
+			spin_unlock_irq(lock);
+			free_buf(buf);
+			break;
+		}
+		nr_added_bufs++;
+		spin_unlock_irq(lock);
+	} while (ret > 0);
+
+	return nr_added_bufs;
+}
+
+static int add_port(struct ports_device *portdev, u32 id)
+{
+	char debugfs_name[16];
+	struct port *port;
+	struct port_buffer *buf;
+	dev_t devt;
+	unsigned int nr_added_bufs;
+	int err;
+
+	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	if (!port) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	port->portdev = portdev;
+	port->id = id;
+
+	port->name = NULL;
+	port->inbuf = NULL;
+	port->cons.hvc = NULL;
+
+	port->host_connected = port->guest_connected = false;
+
+	port->in_vq = portdev->in_vqs[port->id];
+	port->out_vq = portdev->out_vqs[port->id];
+
+	cdev_init(&port->cdev, &port_fops);
+
+	devt = MKDEV(portdev->chr_major, id);
+	err = cdev_add(&port->cdev, devt, 1);
+	if (err < 0) {
+		dev_err(&port->portdev->vdev->dev,
+			"Error %d adding cdev for port %u\n", err, id);
+		goto free_port;
+	}
+	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
+				  devt, port, "vport%up%u",
+				  port->portdev->drv_index, id);
+	if (IS_ERR(port->dev)) {
+		err = PTR_ERR(port->dev);
+		dev_err(&port->portdev->vdev->dev,
+			"Error %d creating device for port %u\n",
+			err, id);
+		goto free_cdev;
+	}
+
+	spin_lock_init(&port->inbuf_lock);
+	init_waitqueue_head(&port->waitqueue);
+
+	/* Fill the in_vq with buffers so the host can send us data. */
+	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
+	if (!nr_added_bufs) {
+		dev_err(port->dev, "Error allocating inbufs\n");
+		err = -ENOMEM;
+		goto free_device;
+	}
+
+	/*
+	 * If we're not using multiport support, this has to be a console port
+	 */
+	if (!use_multiport(port->portdev)) {
+		err = init_port_console(port);
+		if (err)
+			goto free_inbufs;
+	}
+
+	spin_lock_irq(&portdev->ports_lock);
+	list_add_tail(&port->list, &port->portdev->ports);
+	spin_unlock_irq(&portdev->ports_lock);
+
+	/*
+	 * Tell the Host we're set so that it can send us various
+	 * configuration parameters for this port (eg, port name,
+	 * caching, whether this is a console port, etc.)
+	 */
+	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
+
+	if (pdrvdata.debugfs_dir) {
+		/*
+		 * Finally, create the debugfs file that we can use to
+		 * inspect a port's state at any time
+		 */
+		sprintf(debugfs_name, "vport%up%u",
+			port->portdev->drv_index, id);
+		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
+							 pdrvdata.debugfs_dir,
+							 port,
+							 &port_debugfs_ops);
+	}
+	return 0;
+
+free_inbufs:
+	while ((buf = port->in_vq->vq_ops->detach_unused_buf(port->in_vq)))
+		free_buf(buf);
+free_device:
+	device_destroy(pdrvdata.class, port->dev->devt);
+free_cdev:
+	cdev_del(&port->cdev);
+free_port:
+	kfree(port);
+fail:
+	return err;
+}
+
 /* Remove all port-specific data. */
 static int remove_port(struct port *port)
 {
@@ -1100,139 +1231,6 @@ static void config_intr(struct virtio_device *vdev)
 	resize_console(find_port_by_id(portdev, 0));
 }
 
-static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
-{
-	struct port_buffer *buf;
-	unsigned int nr_added_bufs;
-	int ret;
-
-	nr_added_bufs = 0;
-	do {
-		buf = alloc_buf(PAGE_SIZE);
-		if (!buf)
-			break;
-
-		spin_lock_irq(lock);
-		ret = add_inbuf(vq, buf);
-		if (ret < 0) {
-			spin_unlock_irq(lock);
-			free_buf(buf);
-			break;
-		}
-		nr_added_bufs++;
-		spin_unlock_irq(lock);
-	} while (ret > 0);
-
-	return nr_added_bufs;
-}
-
-static int add_port(struct ports_device *portdev, u32 id)
-{
-	char debugfs_name[16];
-	struct port *port;
-	struct port_buffer *buf;
-	dev_t devt;
-	unsigned int nr_added_bufs;
-	int err;
-
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
-	if (!port) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
-	port->portdev = portdev;
-	port->id = id;
-
-	port->name = NULL;
-	port->inbuf = NULL;
-	port->cons.hvc = NULL;
-
-	port->host_connected = port->guest_connected = false;
-
-	port->in_vq = portdev->in_vqs[port->id];
-	port->out_vq = portdev->out_vqs[port->id];
-
-	cdev_init(&port->cdev, &port_fops);
-
-	devt = MKDEV(portdev->chr_major, id);
-	err = cdev_add(&port->cdev, devt, 1);
-	if (err < 0) {
-		dev_err(&port->portdev->vdev->dev,
-			"Error %d adding cdev for port %u\n", err, id);
-		goto free_port;
-	}
-	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
-				  devt, port, "vport%up%u",
-				  port->portdev->drv_index, id);
-	if (IS_ERR(port->dev)) {
-		err = PTR_ERR(port->dev);
-		dev_err(&port->portdev->vdev->dev,
-			"Error %d creating device for port %u\n",
-			err, id);
-		goto free_cdev;
-	}
-
-	spin_lock_init(&port->inbuf_lock);
-	init_waitqueue_head(&port->waitqueue);
-
-	/* Fill the in_vq with buffers so the host can send us data. */
-	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
-	if (!nr_added_bufs) {
-		dev_err(port->dev, "Error allocating inbufs\n");
-		err = -ENOMEM;
-		goto free_device;
-	}
-
-	/*
-	 * If we're not using multiport support, this has to be a console port
-	 */
-	if (!use_multiport(port->portdev)) {
-		err = init_port_console(port);
-		if (err)
-			goto free_inbufs;
-	}
-
-	spin_lock_irq(&portdev->ports_lock);
-	list_add_tail(&port->list, &port->portdev->ports);
-	spin_unlock_irq(&portdev->ports_lock);
-
-	/*
-	 * Tell the Host we're set so that it can send us various
-	 * configuration parameters for this port (eg, port name,
-	 * caching, whether this is a console port, etc.)
-	 */
-	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
-
-	if (pdrvdata.debugfs_dir) {
-		/*
-		 * Finally, create the debugfs file that we can use to
-		 * inspect a port's state at any time
-		 */
-		sprintf(debugfs_name, "vport%up%u",
-			port->portdev->drv_index, id);
-		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
-							 pdrvdata.debugfs_dir,
-							 port,
-							 &port_debugfs_ops);
-	}
-	return 0;
-
-free_inbufs:
-	while ((buf = port->in_vq->vq_ops->detach_unused_buf(port->in_vq)))
-		free_buf(buf);
-free_device:
-	device_destroy(pdrvdata.class, port->dev->devt);
-free_cdev:
-	cdev_del(&port->cdev);
-free_port:
-	kfree(port);
-fail:
-	/* The host might want to notify management sw about port add failure */
-	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 0);
-	return err;
-}
-
 static int init_vqs(struct ports_device *portdev)
 {
 	vq_callback_t **io_callbacks;
-- 
1.6.2.5
