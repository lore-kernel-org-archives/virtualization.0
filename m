From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 12/14] virtio: console: Use cdev_alloc() instead of cdev_init()
Date: Thu,  2 Sep 2010 18:20:59 +0530
Message-ID: <d9d93cad417ea875a1bff1dab58f2bd4222bbba7.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This moves to using cdev on the heap instead of it being embedded in the
ports struct. This helps individual refcounting and will allow us to
properly remove cdev structs after hot-unplugs and close operations.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index af44332..0c4dc26 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -184,7 +184,7 @@ struct port {
 	struct console cons;
 
 	/* Each port associates with a separate char device */
-	struct cdev cdev;
+	struct cdev *cdev;
 	struct device *dev;
 
 	/* A waitqueue for poll() or blocking read operations */
@@ -235,7 +235,7 @@ static struct port *find_port_by_devt_in_portdev(struct ports_device *portdev,
 
 	spin_lock_irqsave(&portdev->ports_lock, flags);
 	list_for_each_entry(port, &portdev->ports, list)
-		if (port->cdev.dev == dev)
+		if (port->cdev->dev == dev)
 			goto out;
 	port = NULL;
 out:
@@ -1081,14 +1081,20 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
 
-	cdev_init(&port->cdev, &port_fops);
+	port->cdev = cdev_alloc();
+	if (!port->cdev) {
+		dev_err(&port->portdev->vdev->dev, "Error allocating cdev\n");
+		err = -ENOMEM;
+		goto free_port;
+	}
+	port->cdev->ops = &port_fops;
 
 	devt = MKDEV(portdev->chr_major, id);
-	err = cdev_add(&port->cdev, devt, 1);
+	err = cdev_add(port->cdev, devt, 1);
 	if (err < 0) {
 		dev_err(&port->portdev->vdev->dev,
 			"Error %d adding cdev for port %u\n", err, id);
-		goto free_port;
+		goto free_cdev;
 	}
 	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
 				  devt, port, "vport%up%u",
@@ -1153,7 +1159,7 @@ free_inbufs:
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
 free_cdev:
-	cdev_del(&port->cdev);
+	cdev_del(port->cdev);
 free_port:
 	kfree(port);
 fail:
@@ -1197,7 +1203,7 @@ static void remove_port(struct port *port)
 	}
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
 	device_destroy(pdrvdata.class, port->dev->devt);
-	cdev_del(&port->cdev);
+	cdev_del(port->cdev);
 
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
-- 
1.7.2.2
