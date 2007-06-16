From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 3/3] Virtio draft III: example block driver
Date: Sat, 16 Jun 2007 23:18:40 +1000
Message-ID: <1181999920.6237.263.camel__2957.51262824542$1182000005$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
	<1181999669.6237.257.camel@localhost.localdomain>
	<1181999825.6237.260.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181999825.6237.260.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

The block driver uses outbufs with sg[0] being the request information
(struct virtio_blk_outhdr) with the type, sector and inbuf id.  For a
write, the rest of the sg will contain the data to be written.

The first segment of the inbuf is a result code (struct
virtio_blk_inhdr).  For a read, the rest of the sg points to the input
buffer.

We accept the normal SCSI ioctls: they get handed through to the other
side which can then handle it or reply that it's unsupported.

Although we try to reply -ENOTTY on unsupported commands, the block
layer in its infinite wisdom suppressed the error so ioctl(fd,
CDROMEJECT) returns success to userspace.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/Makefile     |    1 
 drivers/block/virtio_blk.c |  385 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild       |    1 
 include/linux/virtio_blk.h |   39 ++++
 4 files changed, 426 insertions(+)

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
@@ -0,0 +1,383 @@
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
+	struct virtio_device *vdev;
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
+	struct scatterlist sg[2+MAX_PHYS_SEGMENTS];
+};
+
+struct virtblk_req
+{
+	struct list_head list;
+	struct request *req;
+	unsigned long out_id;
+	bool out_done, in_done;
+	int uptodate;
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
+static bool finish(struct virtio_blk *vblk, struct virtblk_req *vbr)
+{
+	if (!vbr->in_done || !vbr->out_done)
+		return false;
+	end_dequeued_request(vbr->req, vblk->disk->queue, vbr->uptodate);
+	list_del(&vbr->list);
+	mempool_free(vbr, vblk->pool);
+	return true;
+}
+
+/* We make sure they finished both the input and output buffers: otherwise
+ * they might still have read access after we free them. */
+static bool blk_out_done(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk = vdev->priv;
+	struct virtblk_req *vbr;
+	unsigned int len, finished = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vblk->lock, flags);
+	while ((vbr = vdev->ops->get_outbuf(vdev, &len)) != NULL) {
+		BUG_ON(vbr->out_done);
+		vbr->out_done = true;
+		finished += finish(vblk, vbr);
+	}
+	/* In case queue is stopped waiting for more buffers. */
+	if (finished)
+		blk_start_queue(vblk->disk->queue);
+	spin_unlock_irqrestore(&vblk->lock, flags);
+	return true;
+}
+
+static bool blk_in_done(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk = vdev->priv;
+	struct virtblk_req *vbr;
+	unsigned int len, finished = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vblk->lock, flags);
+
+	while ((vbr = vdev->ops->get_inbuf(vdev, &len)) != NULL) {
+		BUG_ON(vbr->in_done);
+
+		switch (vbr->in_hdr.status) {
+		case VIRTIO_BLK_S_OK:
+			vbr->uptodate = 1;
+			break;
+		case VIRTIO_BLK_S_UNSUPP:
+			vbr->uptodate = -ENOTTY;
+			break;
+		default:
+			vbr->uptodate = 0;
+			break;
+		}
+		vbr->in_done = true;
+		finished += finish(vblk, vbr);
+	}
+
+	/* In case queue is stopped waiting for more buffers. */
+	if (finished)
+		blk_start_queue(vblk->disk->queue);
+	spin_unlock_irqrestore(&vblk->lock, flags);
+	return true;
+}
+
+static bool do_write(request_queue_t *q, struct virtio_blk *vblk,
+		     struct virtblk_req *vbr)
+{
+	unsigned long num;
+
+	vbr->out_hdr.type |= VIRTIO_BLK_T_WRITE;
+
+	/* Set up for reply. */
+	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
+	vblk->sg[0].length = sizeof(vbr->in_hdr);
+	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg, 1,
+						     vbr);
+	if (IS_ERR_VALUE(vbr->out_hdr.id))
+		goto full;
+
+	/* First sg element points to output header. */
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+
+	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
+	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1+num,
+						  vbr);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
+	pr_debug("Write: %p in=%lu out=%lu\n", vbr,
+		 (long)vbr->out_hdr.id, (long)vbr->out_id);
+	list_add_tail(&vbr->list, &vblk->reqs);
+	return true;
+
+detach_inbuf_full:
+	vblk->vdev->ops->detach_inbuf(vblk->vdev, vbr->out_hdr.id);
+full:
+	return false;
+}
+
+static bool do_read(request_queue_t *q, struct virtio_blk *vblk,
+		    struct virtblk_req *vbr)
+{
+	unsigned long num;
+
+	vbr->out_hdr.type |= VIRTIO_BLK_T_READ;
+
+	/* Set up for reply. */
+	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
+	vblk->sg[0].length = sizeof(vbr->in_hdr);
+	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
+	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg,
+						     1+num, vbr);
+	if (IS_ERR_VALUE(vbr->out_hdr.id))
+		goto full;
+
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+
+	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1,
+						  vbr);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
+	pr_debug("Read: %p in=%lu out=%lu\n", vbr,
+		 (long)vbr->out_hdr.id, (long)vbr->out_id);
+	list_add_tail(&vbr->list, &vblk->reqs);
+	return true;
+
+detach_inbuf_full:
+	vblk->vdev->ops->detach_inbuf(vblk->vdev, vbr->out_hdr.id);
+full:
+	return false;
+}
+
+static bool do_scsi(request_queue_t *q, struct virtio_blk *vblk,
+		    struct virtblk_req *vbr)
+{
+	unsigned long num;
+
+	vbr->out_hdr.type |= VIRTIO_BLK_T_SCSI_CMD;
+
+	/* Set up for reply. */
+	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
+	vblk->sg[0].length = sizeof(vbr->in_hdr);
+	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg, 1,
+						     vbr);
+	if (IS_ERR_VALUE(vbr->out_hdr.id))
+		goto full;
+
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+	vblk->sg[1].page = virt_to_page(vbr->req->cmd);
+	vblk->sg[1].offset = offset_in_page(vbr->req->cmd);
+	vblk->sg[1].length = vbr->req->cmd_len;
+
+	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
+	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 2+num,
+						  vbr);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
+	pr_debug("Scsi: %p in=%lu out=%lu\n", vbr,
+		 (long)vbr->out_hdr.id, (long)vbr->out_id);
+	list_add_tail(&vbr->list, &vblk->reqs);
+	return true;
+
+detach_inbuf_full:
+	vblk->vdev->ops->detach_inbuf(vblk->vdev, vbr->out_hdr.id);
+full:
+	return false;
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
+		/* Actual type gets or'ed in do_scsi/do_write/do_read */
+		vbr->out_hdr.type = blk_barrier_rq(req)?VIRTIO_BLK_T_BARRIER:0;
+		vbr->out_hdr.sector = req->sector;
+		vbr->out_hdr.ioprio = req->ioprio;
+		vbr->out_done = vbr->in_done = false;
+
+		if (blk_pc_request(req)) {
+			if (!do_scsi(q, vblk, vbr))
+				goto stop;
+		} else if (blk_fs_request(req)) {
+			if (rq_data_dir(req) == WRITE) {
+				if (!do_write(q, vblk, vbr))
+					goto stop;
+			} else {
+				if (!do_read(q, vblk, vbr))
+					goto stop;
+			}
+		} else
+			/* We don't put anything else in the queue. */
+			BUG();
+		blkdev_dequeue_request(req);
+	}
+
+sync:
+	if (vblk)
+		vblk->vdev->ops->sync(vblk->vdev, VIRTIO_IN|VIRTIO_OUT);
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
+static struct virtio_driver_ops virtblk_ops = {
+	.in = blk_in_done,
+	.out = blk_out_done,
+};
+
+
+static struct block_device_operations virtblk_fops = {
+	.ioctl = virtblk_ioctl,
+	.owner = THIS_MODULE,
+};
+
+struct gendisk *virtblk_probe(struct virtio_device *vdev)
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
+	vblk->vdev = vdev;
+	vdev->priv = vblk;
+	vdev->driver_ops = &virtblk_ops;
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
@@ -0,0 +1,39 @@
+#ifndef _LINUX_VIRTIO_BLK_H
+#define _LINUX_VIRTIO_BLK_H
+#include <linux/types.h>
+
+#define VIRTIO_BLK_T_READ	0
+#define VIRTIO_BLK_T_WRITE 1
+#define VIRTIO_BLK_T_SCSI_CMD 3
+#define VIRTIO_BLK_T_BARRIER 0x80000000 /* Barrier before this op. */
+
+/* This is the first element of the scatter-gather list. */
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
+struct virtio_blk_inhdr
+{
+	unsigned char status;
+};
+
+#ifdef __KERNEL__
+struct gendisk;
+struct virtio_device;
+
+struct gendisk *virtblk_probe(struct virtio_device *vdev);
+void virtblk_remove(struct gendisk *disk);
+#endif /* __KERNEL__ */
+#endif /* _LINUX_VIRTIO_BLK_H */
