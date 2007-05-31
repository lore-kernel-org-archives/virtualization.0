From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 3/3] virtio infrastructure: example block driver
Date: Thu, 31 May 2007 22:21:31 +1000
Message-ID: <1180614091.11133.63.camel__3563.68900179422$1180614154$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180614044.11133.61.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <cborntra@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Example block driver using virtio.

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
 drivers/block/virtio_blk.c |  269 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_blk.h |   29 ++++
 3 files changed, 299 insertions(+)

diff -r 8f6c1b0efb6a drivers/block/Makefile
--- a/drivers/block/Makefile	Thu May 31 17:54:08 2007 +1000
+++ b/drivers/block/Makefile	Thu May 31 17:54:13 2007 +1000
@@ -20,6 +20,7 @@ obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.
 obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.o
 obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
 obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
+obj-y				+= virtio_blk.o
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
diff -r 8f6c1b0efb6a drivers/block/virtio_blk.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/block/virtio_blk.c	Thu May 31 17:55:12 2007 +1000
@@ -0,0 +1,270 @@
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
+	spinlock_t lock;
+
+	/* The disk structure for the kernel. */
+	struct gendisk *disk;
+
+	/* Request tracking (by inbuf id). */
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
+	struct virtio_blk_outhdr out_hdr;
+	struct virtio_blk_inhdr in_hdr;
+	unsigned long in_used;
+};
+
+/* Jens gave me this nice helper to end all chunks of a request. */
+static void end_entire_request(struct request *req, int uptodate)
+{
+	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
+		BUG();
+	add_disk_randomness(req->rq_disk);
+	end_that_request_last(req, uptodate);
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
+						     &vbr->in_used);
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
+						  NULL);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
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
+						     1+num, &vbr->in_used);
+	if (IS_ERR_VALUE(vbr->out_hdr.id))
+		goto full;
+
+	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
+	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
+	vblk->sg[0].length = sizeof(vbr->out_hdr);
+
+	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1,
+						  NULL);
+	if (IS_ERR_VALUE(vbr->out_id))
+		goto detach_inbuf_full;
+
+	pr_debug("%s: read at offset %lu %lu->%lu\n",
+		 vblk->disk->disk_name,
+		 vbr->out_hdr.sector*512, vbr->out_id, vbr->out_hdr.id);
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
+			end_entire_request(req, 0);
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
+		vbr->in_used = 0;
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
+		virtio_sync(vblk->vdev);
+	return;
+
+stop:
+	/* Queue full?  Wait. */
+	blk_stop_queue(q);
+	mempool_free(vbr, vblk->pool);
+	goto sync;
+}
+
+int virtblk_interrupt(struct gendisk *disk)
+{
+	struct virtio_blk *vblk = disk->private_data;
+	struct virtblk_req *i, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vblk->lock, flags);
+	list_for_each_entry_safe(i, next, &vblk->reqs, list) {
+		/* Reply hasn't come back? */
+		if (!i->in_used)
+			continue;
+		/* Make sure other side can no longer read/write */
+		vblk->vdev->ops->detach_outbuf(vblk->vdev, i->out_id);
+		vblk->vdev->ops->detach_inbuf(vblk->vdev, i->out_hdr.id);
+		pr_debug("%s: finished request %lu %s\n", disk->disk_name,
+			  i->out_id, i->in_hdr.status == 1 ? "OK" : "FAILED");
+		/* Finish and free request */
+		end_entire_request(i->req, i->in_hdr.status == 1);
+		list_del(&i->list);
+		mempool_free(i, vblk->pool);
+	}
+	blk_start_queue(disk->queue);
+	spin_unlock_irqrestore(&vblk->lock, flags);
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(virtblk_interrupt);
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
+	spin_lock_init(&vblk->lock);
+	INIT_LIST_HEAD(&vblk->reqs);
+	vblk->vdev = vdev;
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
diff -r 8f6c1b0efb6a include/linux/virtio_blk.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/linux/virtio_blk.h	Thu May 31 17:54:13 2007 +1000
@@ -0,0 +1,29 @@
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
+int virtblk_interrupt(struct gendisk *disk);
+void virtblk_remove(struct gendisk *disk);
+
+#endif /* _LINUX_VIRTIO_BLK_H */
