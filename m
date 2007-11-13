From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: fix module/device unloading
Date: Tue, 13 Nov 2007 17:35:14 +1100
Message-ID: <200711131735.14501.rusty__18320.9285060459$1194935837$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio code never hooked through the ->remove callback.  Although
noone supports device removal at the moment, this code is already
needed for module unloading.

This of course also revealed bugs in virtio_blk, virtio_net and lguest
unloading paths.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r e631b63b0e8c drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c	Tue Nov 13 13:57:47 2007 +1100
+++ b/drivers/block/virtio_blk.c	Tue Nov 13 14:05:50 2007 +1100
@@ -223,7 +223,7 @@ static int virtblk_probe(struct virtio_d
 	err = virtio_config_val(vdev, VIRTIO_CONFIG_BLK_F_CAPACITY, &cap);
 	if (err) {
 		dev_err(&vdev->dev, "Bad/missing capacity in config\n");
-		goto out_put_disk;
+		goto out_cleanup_queue;
 	}
 
 	/* If capacity is too big, truncate with warning. */
@@ -239,7 +239,7 @@ static int virtblk_probe(struct virtio_d
 		blk_queue_max_segment_size(vblk->disk->queue, v);
 	else if (err != -ENOENT) {
 		dev_err(&vdev->dev, "Bad SIZE_MAX in config\n");
-		goto out_put_disk;
+		goto out_cleanup_queue;
 	}
 
 	err = virtio_config_val(vdev, VIRTIO_CONFIG_BLK_F_SEG_MAX, &v);
@@ -247,12 +247,14 @@ static int virtblk_probe(struct virtio_d
 		blk_queue_max_hw_segments(vblk->disk->queue, v);
 	else if (err != -ENOENT) {
 		dev_err(&vdev->dev, "Bad SEG_MAX in config\n");
-		goto out_put_disk;
+		goto out_cleanup_queue;
 	}
 
 	add_disk(vblk->disk);
 	return 0;
 
+out_cleanup_queue:
+	blk_cleanup_queue(vblk->disk->queue);
 out_put_disk:
 	put_disk(vblk->disk);
 out_unregister_blkdev:
@@ -277,6 +279,8 @@ static void virtblk_remove(struct virtio
 	put_disk(vblk->disk);
 	unregister_blkdev(major, "virtblk");
 	mempool_destroy(vblk->pool);
+	/* There should be nothing in the queue now, so no need to shutdown */
+	vdev->config->del_vq(vblk->vq);
 	kfree(vblk);
 }
 
diff -r e631b63b0e8c drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c	Tue Nov 13 13:57:47 2007 +1100
+++ b/drivers/lguest/lguest_device.c	Tue Nov 13 14:05:50 2007 +1100
@@ -247,6 +247,8 @@ static void lg_del_vq(struct virtqueue *
 {
 	struct lguest_vq_info *lvq = vq->priv;
 
+	/* Release the interrupt */
+	free_irq(lvq->config.irq, vq);
 	/* Tell virtio_ring.c to free the virtqueue. */
 	vring_del_virtqueue(vq);
 	/* Unmap the pages containing the ring. */
diff -r e631b63b0e8c drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Tue Nov 13 13:57:47 2007 +1100
+++ b/drivers/net/virtio_net.c	Tue Nov 13 14:05:50 2007 +1100
@@ -404,8 +404,12 @@ free:
 
 static void virtnet_remove(struct virtio_device *vdev)
 {
-	unregister_netdev(vdev->priv);
-	free_netdev(vdev->priv);
+	struct virtnet_info *vi = vdev->priv;
+
+	vdev->config->del_vq(vi->svq);
+	vdev->config->del_vq(vi->rvq);
+	unregister_netdev(vi->dev);
+	free_netdev(vi->dev);
 }
 
 static struct virtio_device_id id_table[] = {
diff -r e631b63b0e8c drivers/virtio/virtio.c
--- a/drivers/virtio/virtio.c	Tue Nov 13 13:57:47 2007 +1100
+++ b/drivers/virtio/virtio.c	Tue Nov 13 14:05:50 2007 +1100
@@ -96,10 +96,23 @@ static int virtio_dev_probe(struct devic
 	return err;
 }
 
+static int virtio_dev_remove(struct device *_d)
+{
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_driver *drv = container_of(dev->dev.driver,
+						 struct virtio_driver, driver);
+
+	dev->config->set_status(dev, dev->config->get_status(dev)
+				& ~VIRTIO_CONFIG_S_DRIVER);
+	drv->remove(dev);
+	return 0;
+}
+
 int register_virtio_driver(struct virtio_driver *driver)
 {
 	driver->driver.bus = &virtio_bus;
 	driver->driver.probe = virtio_dev_probe;
+	driver->driver.remove = virtio_dev_remove;
 	return driver_register(&driver->driver);
 }
 EXPORT_SYMBOL_GPL(register_virtio_driver);
