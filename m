From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_blk: Dont waste major numbers
Date: Thu, 31 Jan 2008 15:53:53 +0100
Message-ID: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

currently virtio_blk uses one major number per device. While this works
quite well on most systems it is wasteful and will exhaust major numbers
on larger installations.

This patch allocates a major number on init and will use 16 minor numbers
for each disk. That will allow ~64k virtio_blk disks.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/block/virtio_blk.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

Index: kvm/drivers/block/virtio_blk.c
===================================================================
--- kvm.orig/drivers/block/virtio_blk.c
+++ kvm/drivers/block/virtio_blk.c
@@ -7,10 +7,13 @@
 #include <linux/scatterlist.h>
 
 #define VIRTIO_MAX_SG	(3+MAX_PHYS_SEGMENTS)
+#define PART_BITS 4
 
 MODULE_LICENSE("GPL");
 
 static unsigned char virtblk_index = 'a';
+static int major, minor;
+
 struct virtio_blk
 {
 	spinlock_t lock;
@@ -173,10 +176,13 @@ static struct block_device_operations vi
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
-	int err, major;
+	int err;
 	u64 cap;
 	u32 v;
 
+	if (minor >= 1 << MINORBITS)
+		return -ENOSPC;
+
 	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
 	if (!vblk) {
 		err = -ENOMEM;
@@ -200,17 +206,11 @@ static int virtblk_probe(struct virtio_d
 		goto out_free_vq;
 	}
 
-	major = register_blkdev(0, "virtblk");
-	if (major < 0) {
-		err = major;
-		goto out_mempool;
-	}
-
 	/* FIXME: How many partitions?  How long is a piece of string? */
-	vblk->disk = alloc_disk(1 << 4);
+	vblk->disk = alloc_disk(1 << PART_BITS);
 	if (!vblk->disk) {
 		err = -ENOMEM;
-		goto out_unregister_blkdev;
+		goto out_mempool;
 	}
 
 	vblk->disk->queue = blk_init_queue(do_virtblk_request, &vblk->lock);
@@ -221,10 +221,12 @@ static int virtblk_probe(struct virtio_d
 
 	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
 	vblk->disk->major = major;
-	vblk->disk->first_minor = 0;
+	vblk->disk->first_minor = minor;
 	vblk->disk->private_data = vblk;
 	vblk->disk->fops = &virtblk_fops;
 
+	minor += 1 << PART_BITS;
+
 	/* If barriers are supported, tell block layer that queue is ordered */
 	if (vdev->config->feature(vdev, VIRTIO_BLK_F_BARRIER))
 		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
@@ -260,8 +262,6 @@ static int virtblk_probe(struct virtio_d
 
 out_put_disk:
 	put_disk(vblk->disk);
-out_unregister_blkdev:
-	unregister_blkdev(major, "virtblk");
 out_mempool:
 	mempool_destroy(vblk->pool);
 out_free_vq:
@@ -302,11 +302,15 @@ static struct virtio_driver virtio_blk =
 
 static int __init init(void)
 {
+	major = register_blkdev(0, "virtblk");
+	if (major < 0)
+		return major;
 	return register_virtio_driver(&virtio_blk);
 }
 
 static void __exit fini(void)
 {
+	unregister_blkdev(major, "virtblk");
 	unregister_virtio_driver(&virtio_blk);
 }
 module_init(init);
