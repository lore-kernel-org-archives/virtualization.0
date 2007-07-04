From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] Virtio draft IV: the block driver
Date: Wed, 04 Jul 2007 14:19:25 +1000
Message-ID: <1183522765.6110.40.camel@localhost.localdomain>
References: <1183522348.6110.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183522348.6110.37.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jens Axboe <jens.axboe@oracle.com>
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

Although we try to reply -ENOTTY on unsupported commands, the block
layer in its infinite wisdom suppressed the error so ioctl(fd,
CDROMEJECT) returns success to userspace.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/Makefile     |    1 
 drivers/block/virtio_blk.c |  253 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild       |    1 
 include/linux/virtio_blk.h |   45 +++++++
 4 files changed, 300 insertions(+)

===================================================================
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.
 obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.o
 obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
 obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
+obj-y				+= virtio_blk.o
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
===================================================================
--- /dev/null
+++ b/drivers/block/virtio_blk.c
@@ -0,0 +1,253 @@
+#define DEBUG
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/virtio.h>
+#include <linux/virtio_blk.h>
+
+static unsigned char virtblk_index = 'a';
+struct virtio_blk
+{
+	spinlock_t lock;
+
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
+				 request_queue_t *q, int uptodate)
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
+	struct virtio_blk *vblk = vq->priv;
+	struct virtblk_req *vbr;
+	unsigned int len;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vblk->lock, flags);
+	while ((vbr = vq->ops->get_buf(vq, &len)) != NULL) {
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
+static bool do_req(request_queue_t *q, struct virtio_blk *vblk,
+		   struct virtblk_req *vbr)
+{
+	unsigned long num, out_num, in_num;
+
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
+		out_num = 1 + num;
+		in_num = 1;
+	} else {
+		vbr->out_hdr.type |= VIRTIO_BLK_T_IN;
+		out_num = 1;
+		in_num = 1 + num;
+	}
+
+	if (vblk->vq->ops->add_buf(vblk->vq, vblk->sg, out_num, in_num, vbr))
+		return false;
+
+	list_add_tail(&vbr->list, &vblk->reqs);
+	return true;
+}
+
+static void do_virtblk_request(request_queue_t *q)
+{
+	struct virtio_blk *vblk = NULL;
+	struct request *req;
+	struct virtblk_req *vbr;
+
+	while ((req = elv_next_request(q)) != NULL) {
+		vblk = req->rq_disk->private_data;
+
+		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
+		if (!vbr)
+			goto stop;
+
+		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
+		vbr->req = req;
+		if (!do_req(q, vblk, vbr))
+			goto stop;
+		blkdev_dequeue_request(req);
+	}
+
+sync:
+	if (vblk)
+		vblk->vq->ops->sync(vblk->vq);
+	return;
+
+stop:
+	/* Queue full?  Wait. */
+	blk_stop_queue(q);
+	mempool_free(vbr, vblk->pool);
+	goto sync;
+}
+
+static int virtblk_ioctl(struct inode *inode, struct file *filp,
+			 unsigned cmd, unsigned long data)
+{
+	return scsi_cmd_ioctl(filp, inode->i_bdev->bd_disk, cmd,
+			      (void __user *)data);
+}
+
+static struct block_device_operations virtblk_fops = {
+	.ioctl = virtblk_ioctl,
+	.owner = THIS_MODULE,
+};
+
+struct gendisk *virtblk_probe(struct virtqueue *vq)
+{
+	struct virtio_blk *vblk;
+	int err, major;
+
+	vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
+	if (!vblk) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&vblk->reqs);
+	spin_lock_init(&vblk->lock);
+	vblk->vq = vq;
+	vq->cb = blk_done;
+	vq->priv = vblk;
+
+	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
+	if (!vblk->pool) {
+		err = -ENOMEM;
+		goto out_free_vblk;
+	}
+
+	major = register_blkdev(0, "virtblk");
+	if (major < 0) {
+		err = major;
+		goto out_mempool;
+	}
+
+	/* FIXME: How many partitions?  How long is a piece of string? */
+	vblk->disk = alloc_disk(1 << 3);
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
+	blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
+
+	/* Caller can do blk_queue_max_hw_segments(), set_capacity()
+	 * etc then add_disk(). */
+	return vblk->disk;
+
+out_put_disk:
+	put_disk(vblk->disk);
+out_unregister_blkdev:
+	unregister_blkdev(major, "virtblk");
+out_mempool:
+	mempool_destroy(vblk->pool);
+out_free_vblk:
+	kfree(vblk);
+out:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(virtblk_probe);
+
+void virtblk_remove(struct gendisk *disk)
+{
+	struct virtio_blk *vblk = disk->private_data;
+	int major = vblk->disk->major;
+
+	BUG_ON(!list_empty(&vblk->reqs));
+	blk_cleanup_queue(vblk->disk->queue);
+	put_disk(vblk->disk);
+	unregister_blkdev(major, "virtblk");
+	mempool_destroy(vblk->pool);
+	kfree(vblk);
+}
+EXPORT_SYMBOL_GPL(virtblk_remove);
===================================================================
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -341,6 +341,7 @@ unifdef-y += utsname.h
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
@@ -0,0 +1,45 @@
+#ifndef _LINUX_VIRTIO_BLK_H
+#define _LINUX_VIRTIO_BLK_H
+#include <linux/types.h>
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
+
+#ifdef __KERNEL__
+struct gendisk;
+struct virtio_device;
+
+struct gendisk *virtblk_probe(struct virtqueue *vq);
+void virtblk_remove(struct gendisk *disk);
+#endif /* __KERNEL__ */
+#endif /* _LINUX_VIRTIO_BLK_H */
