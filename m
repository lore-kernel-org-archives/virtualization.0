From: arnd@arndb.de
Subject: [RFC 3/4] Convert virtio_blk to new virtio bus
Date: Fri, 06 Jul 2007 14:42:03 +0200
Message-ID: <20070706125717.760125899@arndb.de>
References: <20070706124200.988637662@arndb.de>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=virtblock-iobus.diff
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Similar to the virtio_net patch, this converts the
block driver from draft III. The virtio config space
here contains the block device size and the
max_hw_segments setting.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Index: linux-2.6/drivers/block/virtio_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/virtio_blk.c
+++ linux-2.6/drivers/block/virtio_blk.c
@@ -66,7 +66,7 @@ static bool finish(struct virtio_blk *vb
  * they might still have read access after we free them. */
 static bool blk_out_done(struct virtio_device *vdev)
 {
-	struct virtio_blk *vblk = vdev->priv;
+	struct virtio_blk *vblk = vdev->dev.driver_data;
 	struct virtblk_req *vbr;
 	unsigned int len, finished = 0;
 	unsigned long flags;
@@ -86,7 +86,7 @@ static bool blk_out_done(struct virtio_d
 
 static bool blk_in_done(struct virtio_device *vdev)
 {
-	struct virtio_blk *vblk = vdev->priv;
+	struct virtio_blk *vblk = vdev->dev.driver_data;
 	struct virtblk_req *vbr;
 	unsigned int len, finished = 0;
 	unsigned long flags;
@@ -290,22 +290,20 @@ static int virtblk_ioctl(struct inode *i
 			      (void __user *)data);
 }
 
-static struct virtio_driver_ops virtblk_ops = {
-	.in = blk_in_done,
-	.out = blk_out_done,
-};
-
-
 static struct block_device_operations virtblk_fops = {
 	.ioctl = virtblk_ioctl,
 	.owner = THIS_MODULE,
 };
 
-struct gendisk *virtblk_probe(struct virtio_device *vdev)
+static int virtblk_probe(struct device *dev)
 {
+	struct virtio_device *vdev = to_virtio_dev(dev);
 	struct virtio_blk *vblk;
+	struct virtio_blk_config *config;
 	int err, major;
 
+	config = (void *)&vdev->config.driver;
+
 	vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
 	if (!vblk) {
 		err = -ENOMEM;
@@ -315,8 +313,7 @@ struct gendisk *virtblk_probe(struct vir
 	INIT_LIST_HEAD(&vblk->reqs);
 	spin_lock_init(&vblk->lock);
 	vblk->vdev = vdev;
-	vdev->priv = vblk;
-	vdev->driver_ops = &virtblk_ops;
+	vdev->dev.driver_data = vblk;
 
 	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
 	if (!vblk->pool) {
@@ -350,10 +347,12 @@ struct gendisk *virtblk_probe(struct vir
 	vblk->disk->fops = &virtblk_fops;
 
 	blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
+	set_capacity(vblk->disk, config->capacity);
+	blk_queue_max_hw_segments(vblk->disk->queue, config->max_hw_segments);
 
 	/* Caller can do blk_queue_max_hw_segments(), set_capacity()
 	 * etc then add_disk(). */
-	return vblk->disk;
+	return 0;
 
 out_put_disk:
 	put_disk(vblk->disk);
@@ -364,13 +363,12 @@ out_mempool:
 out_free_vblk:
 	kfree(vblk);
 out:
-	return ERR_PTR(err);
+	return err;
 }
-EXPORT_SYMBOL_GPL(virtblk_probe);
 
-void virtblk_remove(struct gendisk *disk)
+static int virtblk_remove(struct device *dev)
 {
-	struct virtio_blk *vblk = disk->private_data;
+	struct virtio_blk *vblk = dev->driver_data;
 	int major = vblk->disk->major;
 
 	BUG_ON(!list_empty(&vblk->reqs));
@@ -379,5 +377,36 @@ void virtblk_remove(struct gendisk *disk
 	unregister_blkdev(major, "virtblk");
 	mempool_destroy(vblk->pool);
 	kfree(vblk);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(virtblk_remove);
+
+static struct virtio_device_id virtblk_ids[] = {
+	{ .device_type = "block" },
+	{ },
+};
+
+static struct virtio_driver virtblk_driver = {
+	.drv = {
+		.name = "virtblk",
+		.owner = THIS_MODULE,
+		.probe = virtblk_probe,
+		.remove = virtblk_remove,
+	},
+	.ids = virtblk_ids,
+	.in = blk_in_done,
+	.out = blk_out_done,
+};
+
+static int __init virtblk_init(void)
+{
+	return virtio_driver_register(&virtblk_driver);
+}
+module_init(virtblk_init);
+
+static void __exit virtblk_exit(void)
+{
+	virtio_driver_unregister(&virtblk_driver);
+}
+module_exit(virtblk_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-2.6/include/linux/virtio_blk.h
===================================================================
--- linux-2.6.orig/include/linux/virtio_blk.h
+++ linux-2.6/include/linux/virtio_blk.h
@@ -29,11 +29,10 @@ struct virtio_blk_inhdr
 	unsigned char status;
 };
 
-#ifdef __KERNEL__
-struct gendisk;
-struct virtio_device;
+struct virtio_blk_config
+{
+	unsigned long long capacity;
+	unsigned long max_hw_segments;
+};
 
-struct gendisk *virtblk_probe(struct virtio_device *vdev);
-void virtblk_remove(struct gendisk *disk);
-#endif /* __KERNEL__ */
 #endif /* _LINUX_VIRTIO_BLK_H */

--
