From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 2/3] Virtio draft II: example block driver
Date: Thu, 07 Jun 2007 22:05:20 +1000
Message-ID: <1181217920.14054.196.camel__14842.7977845587$1181217996$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181217867.14054.195.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181217867.14054.195.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

The block driver uses outbufs with sg[0] being the request information
(struct virtio_blk_outhdr) with the type, sector and inbuf id.  For a
write, the rest of the sg will contain the data to be written.

The first segment of the inbuf is a result code (struct
virtio_blk_inhdr).  For a read, the rest of the sg points to the input
buffer.

TODO:
	1) Ordered tag support.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/Makefile     |    1 
 drivers/block/virtio_blk.c |  299 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_blk.h |   28 ++++
 3 files changed, 328 insertions(+)

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
@@ -0,0 +1,299 @@
+//#define DEBUG
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/virtio.h>
+#include <linux/virtio_blk.h>
+
+static unsigned char virtblk_index = 'a';
+struct virtio_blk
+{
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
+	struct scatterlist sg[1+MAX_PHYS_SEGMENTS];
+};
+
+struct virtblk_req
+{
+	struct list_head list;
+	struct request *req;
+	unsigned long out_id;
+	bool out_done, in_done;
+	bool failed;
+	struct virtio_blk_outhdr out_hdr;
+	struct virtio_blk_inhdr in_hdr;
+};
+
+/* Jens gave me this nice helper to end all chunks of a request. */
+static void end_dequeued_request(struct request *req, int uptodate)
+{
+	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
+		BUG();
+	add_disk_randomness(req->rq_disk);
+	end_that_request_last(req, uptodate);
+}
+
+static void finish(struct virtio_blk *vblk, struct virtblk_req *vbr)
+{
+	end_dequeued_request(vbr->req, !vbr->failed);
+	list_del(&vbr->list);
+	mempool_free(vbr, vblk->pool);
+	/* In case queue is stopped waiting for more buffers. */
+	blk_start_queue(vblk->disk->queue);
+}
+
+/* We make sure they finished both the input and output buffers: otherwise
+ * they might still have read access after we free them. */
+static void blk_out_done(struct virtio_device *vdev, void *_vbr, unsigned len)
+{
+	struct virtblk_req *vbr = _vbr;
+	struct virtio_blk *vblk = vdev->priv;
+
+	assert_spin_locked(&vblk->vdev->lock);
+
+	BUG_ON(vbr->out_done);
+	vbr->out_done = true;
+	if (vbr->in_done)
+		finish(vblk, vbr);
+}
+
+static void blk_in_done(struct virtio_device *vdev, void *_vbr, unsigned len)
+{
+	struct virtblk_req *vbr = _vbr;
+	struct virtio_blk *vblk = vdev->priv;
+	unsigned long expected_len;
+
+	assert_spin_locked(&vblk->vdev->lock);
+
+	expected_len = sizeof(vbr->in_hdr);
+	if (vbr->out_hdr.type == READ)
+		expected_len += vbr->req->hard_nr_sectors*512;
+
+	if (unlikely(len != expected_len)) {
+		dev_err(vblk->vdev->dev, "short reply %u not %lu",
+			len, expected_len);
+		vbr->failed = true;
+	} else if (unlikely(vbr->in_hdr.status != 1)) {
+		vbr->failed = true;
+	}
+
+	BUG_ON(vbr->in_done);
+	vbr->in_done = true;
+	if (vbr->out_done)
+		finish(vblk, vbr);
+}
+
+static bool do_write(request_queue_t *q, struct virtio_blk *vblk,
+		     struct virtblk_req *vbr)
+{
+	unsigned long num;
+
+	/* Set up for reply. */
+	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
+	vblk->sg[0].length = sizeof(vbr->in_hdr);
+	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg, 1,
+						     blk_in_done, vbr);
+	if (IS_ERR_VALUE(vbr->out_hdr.id))
+		goto full;
+
+	/* First sg element points to output header. */
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+
+	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
+	vbr->out_done = vbr->in_done = false;
+	vbr->failed = false;
+	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1+num,
+						  blk_out_done, vbr);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
+	pr_debug("Write: %p in=%lu out=%lu\n", vbr,
+		 vbr->out_hdr.id, vbr->out_id);
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
+	/* Set up for reply. */
+	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
+	vblk->sg[0].length = sizeof(vbr->in_hdr);
+	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
+	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg,
+						     1+num, blk_in_done, vbr);
+	if (IS_ERR_VALUE(vbr->out_hdr.id))
+		goto full;
+
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+
+	vbr->out_done = vbr->in_done = false;
+	vbr->failed = false;
+	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1,
+						  blk_out_done, vbr);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
+	pr_debug("Read: %p in=%lu out=%lu\n", vbr,
+		 vbr->out_hdr.id, vbr->out_id);
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
+		/* FIXME: handle these iff capable. */
+		if (!blk_fs_request(req)) {
+			pr_debug("Got non-command 0x%08x\n", req->cmd_type);
+			req->errors++;
+			blkdev_dequeue_request(req);
+			end_dequeued_request(req, 0);
+			continue;
+		}
+
+		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
+		if (!vbr)
+			goto stop;
+
+		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
+		vbr->req = req;
+		vbr->out_hdr.type = rq_data_dir(req);
+		vbr->out_hdr.sector = req->sector;
+
+		if (rq_data_dir(req) == WRITE) {
+			if (!do_write(q, vblk, vbr))
+				goto stop;
+		} else {
+			if (!do_read(q, vblk, vbr))
+				goto stop;
+		}
+		blkdev_dequeue_request(req);
+	}
+
+sync:
+	if (vblk)
+		vblk->vdev->ops->sync(vblk->vdev);
+	return;
+
+stop:
+	/* Queue full?  Wait. */
+	blk_stop_queue(q);
+	mempool_free(vbr, vblk->pool);
+	goto sync;
+}
+
+static struct block_device_operations virtblk_fops = {
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
+	vblk->vdev = vdev;
+	vdev->priv = vblk;
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
+	vblk->disk->queue = blk_init_queue(do_virtblk_request,
+					   &vblk->vdev->lock);
+	if (!vblk->disk->queue) {
+		err = -ENOMEM;
+		goto out_put_disk;
+	}
+
+	sprintf(vblk->disk->disk_name, "vb%c", virtblk_index++);
+	vblk->disk->major = major;
+	vblk->disk->first_minor = 0;
+	vblk->disk->private_data = vblk;
+	vblk->disk->fops = &virtblk_fops;
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
--- /dev/null
+++ b/include/linux/virtio_blk.h
@@ -0,0 +1,28 @@
+#ifndef _LINUX_VIRTIO_BLK_H
+#define _LINUX_VIRTIO_BLK_H
+#include <linux/types.h>
+struct gendisk;
+struct virtio_device;
+struct hd_geometry;
+
+/* This is the first element of the scatter-gather list. */
+struct virtio_blk_outhdr
+{
+	/* 0 == read, 1 == write */
+	u32 type;
+	/* Sector (ie. 512 byte offset) */
+	unsigned long sector;
+	/* Where to put reply. */
+	unsigned long id;
+};
+
+struct virtio_blk_inhdr
+{
+	/* 1 = OK, 0 = not ok. */
+	unsigned long status;
+};
+
+struct gendisk *virtblk_probe(struct virtio_device *vdev);
+void virtblk_remove(struct gendisk *disk);
+
+#endif /* _LINUX_VIRTIO_BLK_H */
