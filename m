Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FE1E6DC2
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228080; cv=none; b=LEIKxJgP7HpQh7M9nPAwSofSuRuP4mczTrOg/0GXz5UmpFP0bYAyxRtqlRQEbwgOQx+POO3F/33fjXZXPBb4bASlmToSiqp9wg8T3VArBfHo/Dh2srCZe1p/A3uUtRSH0tCo078uOAmYlv9q3Qc6mJe81aGYvTtyElelA/7JD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228080; c=relaxed/simple;
	bh=suVFN18f6l88ll5bXCZiLUvgX6JmXNTjyUNOVTCHtl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zaxg4WLBY/gfAnNrgqWt5wughikQU9OdiXhEeQZT/RZqg91Wlgz305p4o54Z+jSiITLxV3gtOdE79RWI4vkZwA/A6yw7ZR39uTBee0gWeEmiWFArAte4YKuTYZCF7VbNurOYJQ98t+4jb58W+0vfF6xGWBMPeQdvJadDQkbGdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KVvBp0yY; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KVvBp0yY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733228075; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hM3NMjNyhiKp7OTl4GYAGnFmUrECoxmiKjcfQlgfIyg=;
	b=KVvBp0yY913T6o+qrHv0FD/8GGhwoFSDzpeOarRmOEs2Ym1O3xSTfSW8ale+tVSaA/bbg5w3a4yQZMyTr774wDqbCZO+MiCR3zoAYcLDZovmZ+ulMrTTeUWfHlmIVbdoSj3nJcfnMb8XRChrnzqRH8b1oO6+rGNB9Lr3VqeCD+o=
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0WKmboUc_1733228073 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 20:14:34 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 1/3] virtio-blk: add virtio-blk chardev support.
Date: Tue,  3 Dec 2024 20:14:22 +0800
Message-Id: <20241203121424.19887-2-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241203121424.19887-1-mengferry@linux.alibaba.com>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce character interfaces for block device (per-device), facilitating
access to block devices through io_uring I/O passsthrough.

Besides, vblk initialize only use kmalloc with GFP_KERNEL flag, but for
char device support, we should ensure cdev kobj must be zero before
initialize. So better initial this struct with __GFP_ZERO flag.

Now the character devices only named as

	- /dev/vdXc0

Currently, only one character interface is created for one actual
virtblk device, although it has been partitioned.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 drivers/block/virtio_blk.c | 84 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc105..3487aaa67514 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -17,6 +17,7 @@
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
 #include <uapi/linux/virtio_ring.h>
+#include <linux/cdev.h>
 
 #define PART_BITS 4
 #define VQ_NAME_LEN 16
@@ -25,6 +26,8 @@
 /* The maximum number of sg elements that fit into a virtqueue */
 #define VIRTIO_BLK_MAX_SG_ELEMS 32768
 
+#define VIRTBLK_MINORS		(1U << MINORBITS)
+
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define VIRTIO_BLK_INLINE_SG_CNT	0
 #else
@@ -45,6 +48,10 @@ MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
+static DEFINE_IDA(vd_chr_minor_ida);
+static dev_t vd_chr_devt;
+static struct class *vd_chr_class;
+
 static struct workqueue_struct *virtblk_wq;
 
 struct virtio_blk_vq {
@@ -84,6 +91,10 @@ struct virtio_blk {
 
 	/* For zoned device */
 	unsigned int zone_sectors;
+
+	/* For passthrough cmd */
+	struct cdev cdev;
+	struct device cdev_device;
 };
 
 struct virtblk_req {
@@ -1239,6 +1250,55 @@ static const struct blk_mq_ops virtio_mq_ops = {
 	.poll		= virtblk_poll,
 };
 
+static void virtblk_cdev_rel(struct device *dev)
+{
+	ida_free(&vd_chr_minor_ida, MINOR(dev->devt));
+}
+
+static void virtblk_cdev_del(struct cdev *cdev, struct device *cdev_device)
+{
+	cdev_device_del(cdev, cdev_device);
+	put_device(cdev_device);
+}
+
+static int virtblk_cdev_add(struct virtio_blk *vblk,
+		const struct file_operations *fops)
+{
+	struct cdev *cdev = &vblk->cdev;
+	struct device *cdev_device = &vblk->cdev_device;
+	int minor, ret;
+
+	minor = ida_alloc(&vd_chr_minor_ida, GFP_KERNEL);
+	if (minor < 0)
+		return minor;
+
+	cdev_device->parent = &vblk->vdev->dev;
+	cdev_device->devt = MKDEV(MAJOR(vd_chr_devt), minor);
+	cdev_device->class = vd_chr_class;
+	cdev_device->release = virtblk_cdev_rel;
+	device_initialize(cdev_device);
+
+	ret = dev_set_name(cdev_device, "%sc0", vblk->disk->disk_name);
+	if (ret)
+		goto err;
+
+	cdev_init(cdev, fops);
+	ret = cdev_device_add(cdev, cdev_device);
+	if (ret) {
+		put_device(cdev_device);
+		goto err;
+	}
+	return ret;
+
+err:
+	ida_free(&vd_chr_minor_ida, minor);
+	return ret;
+}
+
+static const struct file_operations virtblk_chr_fops = {
+	.owner		= THIS_MODULE,
+};
+
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
@@ -1456,7 +1516,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		goto out;
 	index = err;
 
-	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
+	vdev->priv = vblk = kzalloc(sizeof(*vblk), GFP_KERNEL);
 	if (!vblk) {
 		err = -ENOMEM;
 		goto out_free_index;
@@ -1544,6 +1604,10 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_cleanup_disk;
 
+	err = virtblk_cdev_add(vblk, &virtblk_chr_fops);
+	if (err)
+		goto out_cleanup_disk;
+
 	return 0;
 
 out_cleanup_disk:
@@ -1568,6 +1632,8 @@ static void virtblk_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
+	virtblk_cdev_del(&vblk->cdev, &vblk->cdev_device);
+
 	del_gendisk(vblk->disk);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
@@ -1674,13 +1740,27 @@ static int __init virtio_blk_init(void)
 		goto out_destroy_workqueue;
 	}
 
+	error = alloc_chrdev_region(&vd_chr_devt, 0, VIRTBLK_MINORS,
+				"vblk-generic");
+	if (error < 0)
+		goto unregister_chrdev;
+
+	vd_chr_class = class_create("vblk-generic");
+	if (IS_ERR(vd_chr_class)) {
+		error = PTR_ERR(vd_chr_class);
+		goto unregister_chrdev;
+	}
+
 	error = register_virtio_driver(&virtio_blk);
 	if (error)
 		goto out_unregister_blkdev;
+
 	return 0;
 
 out_unregister_blkdev:
 	unregister_blkdev(major, "virtblk");
+unregister_chrdev:
+	unregister_chrdev_region(vd_chr_devt, VIRTBLK_MINORS);
 out_destroy_workqueue:
 	destroy_workqueue(virtblk_wq);
 	return error;
@@ -1690,7 +1770,9 @@ static void __exit virtio_blk_fini(void)
 {
 	unregister_virtio_driver(&virtio_blk);
 	unregister_blkdev(major, "virtblk");
+	unregister_chrdev_region(vd_chr_devt, VIRTBLK_MINORS);
 	destroy_workqueue(virtblk_wq);
+	ida_destroy(&vd_chr_minor_ida);
 }
 module_init(virtio_blk_init);
 module_exit(virtio_blk_fini);
-- 
2.43.5

