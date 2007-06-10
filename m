From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: More virtio users
Date: Sun, 10 Jun 2007 22:37:40 +1000
Message-ID: <1181479060.16428.37.camel__18132.2734257721$1181518150$gmane$org@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466BB34B.9050105@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466BB34B.9050105@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Jens Axboe <jens.axboe@oracle.com>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-06-10 at 11:16 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > Lguest doesn't have a framebuffer, so maybe this is a good thing for me
> > to hack on, but I promised myself I'd finish NAPI for the net device,
> > and tag for block device first.
> >   
> 
> If you're touching the block device, passing a request's io priority to 
> the host can be useful.

OK, here's the interdiff.  I still don't handle non-fs requests, but I
haven't seen any yet.  I should probably BUG_ON() there and wait for
Jens to scream...

Changes:
1) Make virtio_blk.h userspace-friendly.
2) /dev/vbN -> /dev/vdN
3) Ordered tags, handed thru to other end.
4) Hand ioprio to other end, too.

diff -u b/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
--- b/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c	Sun Jun 10 22:09:10 2007 +1000
@@ -33,18 +33,19 @@
 	struct virtio_blk_inhdr in_hdr;
 };
 
-/* Jens gave me this nice helper to end all chunks of a request. */
-static void end_dequeued_request(struct request *req, int uptodate)
+static void end_tagged_request(struct request *req,
+			       request_queue_t *q, int uptodate)
 {
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
 	add_disk_randomness(req->rq_disk);
+	blk_queue_end_tag(q, req);
 	end_that_request_last(req, uptodate);
 }
 
 static void finish(struct virtio_blk *vblk, struct virtblk_req *vbr)
 {
-	end_dequeued_request(vbr->req, !vbr->failed);
+	end_tagged_request(vbr->req, vblk->disk->queue, !vbr->failed);
 	list_del(&vbr->list);
 	mempool_free(vbr, vblk->pool);
 	/* In case queue is stopped waiting for more buffers. */
@@ -120,7 +121,7 @@
 		goto detach_inbuf_full;
 
 	pr_debug("Write: %p in=%lu out=%lu\n", vbr,
-		 vbr->out_hdr.id, vbr->out_id);
+		 (long)vbr->out_hdr.id, (long)vbr->out_id);
 	list_add_tail(&vbr->list, &vblk->reqs);
 	return true;
 
@@ -157,7 +158,7 @@
 		goto detach_inbuf_full;
 
 	pr_debug("Read: %p in=%lu out=%lu\n", vbr,
-		 vbr->out_hdr.id, vbr->out_id);
+		 (long)vbr->out_hdr.id, (long)vbr->out_id);
 	list_add_tail(&vbr->list, &vblk->reqs);
 	return true;
 
@@ -178,10 +179,9 @@
 
 		/* FIXME: handle these iff capable. */
 		if (!blk_fs_request(req)) {
-			pr_debug("Got non-command 0x%08x\n", req->cmd_type);
+			printk("Got non-command 0x%08x\n", req->cmd_type);
 			req->errors++;
-			blkdev_dequeue_request(req);
-			end_dequeued_request(req, 0);
+			end_tagged_request(req, vblk->disk->queue, 0);
 			continue;
 		}
 
@@ -193,6 +193,8 @@
 		vbr->req = req;
 		vbr->out_hdr.type = rq_data_dir(req);
 		vbr->out_hdr.sector = req->sector;
+		vbr->out_hdr.tag = req->tag;
+		vbr->out_hdr.ioprio = req->ioprio;
 
 		if (rq_data_dir(req) == WRITE) {
 			if (!do_write(q, vblk, vbr))
@@ -201,7 +203,6 @@
 			if (!do_read(q, vblk, vbr))
 				goto stop;
 		}
-		blkdev_dequeue_request(req);
 	}
 
 sync:
@@ -261,16 +262,25 @@
 		goto out_put_disk;
 	}
 
-	sprintf(vblk->disk->disk_name, "vb%c", virtblk_index++);
+	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
 	vblk->disk->major = major;
 	vblk->disk->first_minor = 0;
 	vblk->disk->private_data = vblk;
 	vblk->disk->fops = &virtblk_fops;
 
+	err = blk_queue_init_tags(vblk->disk->queue, 100 /* FIXME */, NULL);
+	if (err)
+		goto out_cleanup_queue;
+
+	blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
+	blk_queue_prep_rq(vblk->disk->queue, blk_queue_start_tag);
+
 	/* Caller can do blk_queue_max_hw_segments(), set_capacity()
 	 * etc then add_disk(). */
 	return vblk->disk;
 
+out_cleanup_queue:
+	blk_cleanup_queue(vblk->disk->queue);
 out_put_disk:
 	put_disk(vblk->disk);
 out_unregister_blkdev:
diff -u b/include/linux/virtio_blk.h b/include/linux/virtio_blk.h
--- b/include/linux/virtio_blk.h
+++ b/include/linux/virtio_blk.h	Sun Jun 10 22:09:10 2007 +1000
@@ -3,26 +3,31 @@
 #include <linux/types.h>
-struct gendisk;
-struct virtio_device;
-struct hd_geometry;
 
 /* This is the first element of the scatter-gather list. */
 struct virtio_blk_outhdr
 {
 	/* 0 == read, 1 == write */
-	u32 type;
+	__u32 type;
+	/* Ordered tag. */
+	__u16 tag;
+	/* Linux's ioprio. */
+	__u16 ioprio;
 	/* Sector (ie. 512 byte offset) */
-	unsigned long sector;
+	__u64 sector;
 	/* Where to put reply. */
-	unsigned long id;
+	__u64 id;
 };
 
 struct virtio_blk_inhdr
 {
 	/* 1 = OK, 0 = not ok. */
-	unsigned long status;
+	unsigned char status;
 };
 
+#ifdef __KERNEL__
+struct gendisk;
+struct virtio_device;
+
 struct gendisk *virtblk_probe(struct virtio_device *vdev);
 void virtblk_remove(struct gendisk *disk);
-
+#endif /* __KERNEL__ */
 #endif /* _LINUX_VIRTIO_BLK_H */
only in patch2:
unchanged:
--- a/include/linux/Kbuild	Sun Jun 10 18:25:37 2007 +1000
+++ b/include/linux/Kbuild	Sun Jun 10 22:09:10 2007 +1000
@@ -341,6 +341,7 @@ unifdef-y += utsname.h
 unifdef-y += utsname.h
 unifdef-y += videodev2.h
 unifdef-y += videodev.h
+unifdef-y += virtio_blk.h
 unifdef-y += wait.h
 unifdef-y += wanrouter.h
 unifdef-y += watchdog.h
