From: rusty@rustcorp.com.au
Subject: [patch 34/43] lguest: Block driver using virtio.
Date: Wed, 26 Sep 2007 16:36:52 +1000
Message-ID: <20070926063651.250184396@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=new-io-block.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Jens Axboe <jens.axboe@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The block driver uses scatter-gather lists with sg[0] being the
request information (struct virtio_blk_outhdr) with the type, sector
and inbuf id.  The next N sg entries are the bio itself, then the last
sg is the status byte.  Whether the N entries are in or out depends on
whether it's a read or a write.

We accept the normal (SCSI) ioctls: they get handed through to the other
side which can then handle it or reply that it's unsupported.  It's
not clear that this actually works in general, since I don't know
if blk_pc_request() requests have an accurate rq_data_dir().

Although we try to reply -ENOTTY on unsupported commands, ioctl(fd,
CDROMEJECT) returns success to userspace.  This needs a separate
patch.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/block/Kconfig      |    6 
 drivers/block/Makefile     |    1 
 drivers/block/virtio_blk.c |  327 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild       |    1 
 include/linux/virtio_blk.h |   51 ++++++
 5 files changed, 386 insertions(+)

===================================================================
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -443,4 +443,10 @@ config XEN_BLKDEV_FRONTEND
 	  block device driver.  It communicates with a back-end driver
 	  in another domain which drives the actual block device.
 
+config VIRTIO_BLK
+	tristate "Virtio block driver (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && VIRTIO
+	---help---
+	  This is the virtual block driver for lguest.  Say Y or M.
+
 endif # BLK_DEV
===================================================================
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
+obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
===================================================================
--- /dev/null
+++ b/drivers/block/virtio_blk.c
@@ -0,0 +1,327 @@
+//#define DEBUG
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/virtio.h>
+#include <linux/virtio_blk.h>
+#include <linux/virtio_blk.h>
+
+static unsigned char virtblk_index = 'a';
+struct virtio_blk
+{
+	spinlock_t lock;
+
+	struct virtio_device *vdev;
+	struct virtqueue *vq;
+
+	/* The disk structure for the kernel. */
+	struct gendisk *disk;
+
+	/* Request tracking. */
+	struct list_head reqs;
+
+	mempool_t *pool;
+
+	/* Scatterlist: can be too big for stack. */
+	struct scatterlist sg[3+MAX_PHYS_SEGMENTS];
+};
+
+struct virtblk_req
+{
+	struct list_head list;
+	struct request *req;
+	struct virtio_blk_outhdr out_hdr;
+	struct virtio_blk_inhdr in_hdr;
+};
+
+static void end_dequeued_request(struct request *req,
+				 struct request_queue *q, int uptodate)
+{
+	/* And so the insanity of the block layer infects us here. */
+	int nsectors = req->hard_nr_sectors;
+
+	if (blk_pc_request(req)) {
+		nsectors = (req->data_len + 511) >> 9;
+		if (!nsectors)
+			nsectors = 1;
+	}
+	if (end_that_request_first(req, uptodate, nsectors))
+		BUG();
+	add_disk_randomness(req->rq_disk);
+	end_that_request_last(req, uptodate);
+}
+
+static bool blk_done(struct virtqueue *vq)
+{
+	struct virtio_blk *vblk = vq->vdev->priv;
+	struct virtblk_req *vbr;
+	unsigned int len;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vblk->lock, flags);
+	while ((vbr = vblk->vq->vq_ops->get_buf(vblk->vq, &len)) != NULL) {
+		int uptodate;
+		switch (vbr->in_hdr.status) {
+		case VIRTIO_BLK_S_OK:
+			uptodate = 1;
+			break;
+		case VIRTIO_BLK_S_UNSUPP:
+			uptodate = -ENOTTY;
+			break;
+		default:
+			uptodate = 0;
+			break;
+		}
+
+		end_dequeued_request(vbr->req, vblk->disk->queue, uptodate);
+		list_del(&vbr->list);
+		mempool_free(vbr, vblk->pool);
+	}
+	/* In case queue is stopped waiting for more buffers. */
+	blk_start_queue(vblk->disk->queue);
+	spin_unlock_irqrestore(&vblk->lock, flags);
+	return true;
+}
+
+static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
+		   struct request *req)
+{
+	unsigned long num, out, in;
+	struct virtblk_req *vbr;
+
+	vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
+	if (!vbr)
+		/* When another request finishes we'll try again. */
+		return false;
+
+	vbr->req = req;
+	if (blk_fs_request(vbr->req)) {
+		vbr->out_hdr.type = 0;
+		vbr->out_hdr.sector = vbr->req->sector;
+		vbr->out_hdr.ioprio = vbr->req->ioprio;
+	} else if (blk_pc_request(vbr->req)) {
+		vbr->out_hdr.type = VIRTIO_BLK_T_SCSI_CMD;
+		vbr->out_hdr.sector = 0;
+		vbr->out_hdr.ioprio = vbr->req->ioprio;
+	} else {
+		/* We don't put anything else in the queue. */
+		BUG();
+	}
+
+	if (blk_barrier_rq(vbr->req))
+		vbr->out_hdr.type |= VIRTIO_BLK_T_BARRIER;
+
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
+	vblk->sg[num+1].page = virt_to_page(&vbr->in_hdr);
+	vblk->sg[num+1].offset = offset_in_page(&vbr->in_hdr);
+	vblk->sg[num+1].length = sizeof(vbr->in_hdr);
+
+	if (rq_data_dir(vbr->req) == WRITE) {
+		vbr->out_hdr.type |= VIRTIO_BLK_T_OUT;
+		out = 1 + num;
+		in = 1;
+	} else {
+		vbr->out_hdr.type |= VIRTIO_BLK_T_IN;
+		out = 1;
+		in = 1 + num;
+	}
+
+	if (vblk->vq->vq_ops->add_buf(vblk->vq, vblk->sg, out, in, vbr)) {
+		mempool_free(vbr, vblk->pool);
+		return false;
+	}
+
+	list_add_tail(&vbr->list, &vblk->reqs);
+	return true;
+}
+
+static void do_virtblk_request(struct request_queue *q)
+{
+	struct virtio_blk *vblk = NULL;
+	struct request *req;
+	unsigned int issued = 0;
+
+	while ((req = elv_next_request(q)) != NULL) {
+		vblk = req->rq_disk->private_data;
+		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
+
+		/* If this request fails, stop queue and wait for something to
+		   finish to restart it. */
+		if (!do_req(q, vblk, req)) {
+			blk_stop_queue(q);
+			break;
+		}
+		blkdev_dequeue_request(req);
+		issued++;
+	}
+
+	if (issued)
+		vblk->vq->vq_ops->kick(vblk->vq);
+}
+
+static int virtblk_ioctl(struct inode *inode, struct file *filp,
+			 unsigned cmd, unsigned long data)
+{
+	return scsi_cmd_ioctl(filp, inode->i_bdev->bd_disk->queue,
+			      inode->i_bdev->bd_disk, cmd,
+			      (void __user *)data);
+}
+
+static struct block_device_operations virtblk_fops = {
+	.ioctl = virtblk_ioctl,
+	.owner = THIS_MODULE,
+};
+
+static int virtblk_probe(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk;
+	int err, major;
+	void *token;
+	unsigned int len;
+	u64 cap;
+	u32 v;
+
+	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
+	if (!vblk) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&vblk->reqs);
+	spin_lock_init(&vblk->lock);
+	vblk->vdev = vdev;
+
+	/* We expect one virtqueue, for output. */
+	vblk->vq = vdev->config->find_vq(vdev, blk_done);
+	if (IS_ERR(vblk->vq)) {
+		err = PTR_ERR(vblk->vq);
+		goto out_free_vblk;
+	}
+
+	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
+	if (!vblk->pool) {
+		err = -ENOMEM;
+		goto out_free_vq;
+	}
+
+	major = register_blkdev(0, "virtblk");
+	if (major < 0) {
+		err = major;
+		goto out_mempool;
+	}
+
+	/* FIXME: How many partitions?  How long is a piece of string? */
+	vblk->disk = alloc_disk(1 << 4);
+	if (!vblk->disk) {
+		err = -ENOMEM;
+		goto out_unregister_blkdev;
+	}
+
+	vblk->disk->queue = blk_init_queue(do_virtblk_request, &vblk->lock);
+	if (!vblk->disk->queue) {
+		err = -ENOMEM;
+		goto out_put_disk;
+	}
+
+	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
+	vblk->disk->major = major;
+	vblk->disk->first_minor = 0;
+	vblk->disk->private_data = vblk;
+	vblk->disk->fops = &virtblk_fops;
+
+	/* If barriers are supported, tell block layer that queue is ordered */
+	token = vdev->config->find(vdev, VIRTIO_CONFIG_BLK_F, &len);
+	if (virtio_use_bit(vdev, token, len, VIRTIO_BLK_F_BARRIER))
+		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
+
+	err = virtio_config_val(vdev, VIRTIO_CONFIG_BLK_F_CAPACITY, &cap);
+	if (err) {
+		dev_err(&vdev->dev, "Bad/missing capacity in config\n");
+		goto out_put_disk;
+	}
+
+	/* If capacity is too big, truncate with warning. */
+	if ((sector_t)cap != cap) {
+		dev_warn(&vdev->dev, "Capacity %llu too large: truncating\n",
+			 (unsigned long long)cap);
+		cap = (sector_t)-1;
+	}
+	set_capacity(vblk->disk, cap);
+
+	err = virtio_config_val(vdev, VIRTIO_CONFIG_BLK_F_SIZE_MAX, &v);
+	if (!err)
+		blk_queue_max_segment_size(vblk->disk->queue, v);
+	else if (err != -ENOENT) {
+		dev_err(&vdev->dev, "Bad SIZE_MAX in config\n");
+		goto out_put_disk;
+	}
+
+	err = virtio_config_val(vdev, VIRTIO_CONFIG_BLK_F_SEG_MAX, &v);
+	if (!err)
+		blk_queue_max_hw_segments(vblk->disk->queue, v);
+	else if (err != -ENOENT) {
+		dev_err(&vdev->dev, "Bad SEG_MAX in config\n");
+		goto out_put_disk;
+	}
+
+	add_disk(vblk->disk);
+	return 0;
+
+out_put_disk:
+	put_disk(vblk->disk);
+out_unregister_blkdev:
+	unregister_blkdev(major, "virtblk");
+out_mempool:
+	mempool_destroy(vblk->pool);
+out_free_vq:
+	vdev->config->del_vq(vblk->vq);
+out_free_vblk:
+	kfree(vblk);
+out:
+	return err;
+}
+
+static void virtblk_remove(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk = vdev->priv;
+	int major = vblk->disk->major;
+
+	BUG_ON(!list_empty(&vblk->reqs));
+	blk_cleanup_queue(vblk->disk->queue);
+	put_disk(vblk->disk);
+	unregister_blkdev(major, "virtblk");
+	mempool_destroy(vblk->pool);
+	kfree(vblk);
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_blk = {
+	.driver.name =	KBUILD_MODNAME,
+	.driver.owner =	THIS_MODULE,
+	.id_table =	id_table,
+	.probe =	virtblk_probe,
+	.remove =	__devexit_p(virtblk_remove),
+};
+
+static int __init init(void)
+{
+	return register_virtio_driver(&virtio_blk);
+}
+
+static void __exit fini(void)
+{
+	unregister_virtio_driver(&virtio_blk);
+}
+module_init(init);
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio block driver");
+MODULE_LICENSE("GPL");
===================================================================
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -343,6 +343,7 @@ unifdef-y += utsname.h
 unifdef-y += utsname.h
 unifdef-y += videodev2.h
 unifdef-y += videodev.h
+unifdef-y += virtio_blk.h
 unifdef-y += wait.h
 unifdef-y += wanrouter.h
 unifdef-y += watchdog.h
===================================================================
--- /dev/null
+++ b/include/linux/virtio_blk.h
@@ -0,0 +1,51 @@
+#ifndef _LINUX_VIRTIO_BLK_H
+#define _LINUX_VIRTIO_BLK_H
+#include <linux/virtio_config.h>
+
+/* The ID for virtio_block */
+#define VIRTIO_ID_BLOCK	2
+
+/* Feature bits */
+#define VIRTIO_CONFIG_BLK_F	0x40
+#define VIRTIO_BLK_F_BARRIER	1	/* Does host support barriers? */
+
+/* The capacity (in 512-byte sectors). */
+#define VIRTIO_CONFIG_BLK_F_CAPACITY	0x41
+/* The maximum segment size. */
+#define VIRTIO_CONFIG_BLK_F_SIZE_MAX	0x42
+/* The maximum number of segments. */
+#define VIRTIO_CONFIG_BLK_F_SEG_MAX	0x43
+
+/* These two define direction. */
+#define VIRTIO_BLK_T_IN		0
+#define VIRTIO_BLK_T_OUT	1
+
+/* This bit says it's a scsi command, not an actual read or write. */
+#define VIRTIO_BLK_T_SCSI_CMD	2
+
+/* Barrier before this op. */
+#define VIRTIO_BLK_T_BARRIER	0x80000000
+
+/* This is the first element of the read scatter-gather list. */
+struct virtio_blk_outhdr
+{
+	/* VIRTIO_BLK_T* */
+	__u32 type;
+	/* io priority. */
+	__u32 ioprio;
+	/* Sector (ie. 512 byte offset) */
+	__u64 sector;
+	/* Where to put reply. */
+	__u64 id;
+};
+
+#define VIRTIO_BLK_S_OK		0
+#define VIRTIO_BLK_S_IOERR	1
+#define VIRTIO_BLK_S_UNSUPP	2
+
+/* This is the first element of the write scatter-gather list */
+struct virtio_blk_inhdr
+{
+	unsigned char status;
+};
+#endif /* _LINUX_VIRTIO_BLK_H */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
