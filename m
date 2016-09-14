From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 05/11] virtio_console: Rename jump labels in add_port()
Date: Wed, 14 Sep 2016 16:04:03 +0200
Message-ID: <85ca0841-c36d-12d2-b978-dbac04e19c5d__38876.9944118851$1473861899$gmane$org@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Sep 2016 14:53:00 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/virtio_console.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 768bbb7..40b8775 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1399,7 +1399,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port = kmalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		err = -ENOMEM;
-		goto fail;
+		goto send_control_message;
 	}
 	kref_init(&port->kref);
 
@@ -1434,7 +1434,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	if (err < 0) {
 		dev_err(&port->portdev->vdev->dev,
 			"Error %d adding cdev for port %u\n", err, id);
-		goto free_cdev;
+		goto delete_cdev;
 	}
 	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
 				  devt, port, "vport%up%u",
@@ -1444,7 +1444,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 		dev_err(&port->portdev->vdev->dev,
 			"Error %d creating device for port %u\n",
 			err, id);
-		goto free_cdev;
+		goto delete_cdev;
 	}
 
 	spin_lock_init(&port->inbuf_lock);
@@ -1456,7 +1456,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	if (!nr_added_bufs) {
 		dev_err(port->dev, "Error allocating inbufs\n");
 		err = -ENOMEM;
-		goto free_device;
+		goto destroy_device;
 	}
 
 	if (is_rproc_serial(port->portdev->vdev))
@@ -1473,7 +1473,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 		 */
 		err = init_port_console(port);
 		if (err)
-			goto free_inbufs;
+			goto free_buffers;
 	}
 
 	spin_lock_irq(&portdev->ports_lock);
@@ -1500,17 +1500,16 @@ static int add_port(struct ports_device *portdev, u32 id)
 							 &port_debugfs_ops);
 	}
 	return 0;
-
-free_inbufs:
+ free_buffers:
 	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
 		free_buf(buf, true);
-free_device:
+ destroy_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
-free_cdev:
+ delete_cdev:
 	cdev_del(port->cdev);
-free_port:
+ free_port:
 	kfree(port);
-fail:
+ send_control_message:
 	/* The host might want to notify management sw about port add failure */
 	__send_control_msg(portdev, id, VIRTIO_CONSOLE_PORT_READY, 0);
 	return err;
-- 
2.10.0
