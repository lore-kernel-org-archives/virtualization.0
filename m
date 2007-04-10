From: Rusty Russell <rusty@rustcorp.com.au>
Subject: PATCH 7/8] lguest: the block driver
Date: Tue, 10 Apr 2007 21:12:08 +1000
Message-ID: <1176203528.26372.40.camel__33930.3735331216$1176205176$gmane$org@localhost.localdomain>
References: <1176203068.26372.21.camel@localhost.localdomain>
	<1176203130.26372.23.camel@localhost.localdomain>
	<1176203176.26372.25.camel@localhost.localdomain>
	<1176203231.26372.27.camel@localhost.localdomain>
	<1176203285.26372.29.camel@localhost.localdomain>
	<1176203333.26372.31.camel@localhost.localdomain>
	<1176203475.26372.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1176203475.26372.37.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Lguest block driver

A simple block driver for lguest.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/Makefile     |    1 =

 drivers/block/lguest_blk.c |  271 ++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 272 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -28,4 +28,5 @@ obj-$(CONFIG_VIODASD)		+=3D viodasd.o
 obj-$(CONFIG_VIODASD)		+=3D viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+=3D sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+=3D ub.o
+obj-$(CONFIG_LGUEST_GUEST)	+=3D lguest_blk.o
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/block/lguest_blk.c
@@ -0,0 +1,271 @@
+/* A simple block driver for lguest.
+ *
+ * Copyright 2006 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+ */
+//#define DEBUG
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/interrupt.h>
+#include <linux/lguest_bus.h>
+
+static char next_block_index =3D 'a';
+
+struct blockdev
+{
+	spinlock_t lock;
+
+	/* The disk structure for the kernel. */
+	struct gendisk *disk;
+
+	/* The major number for this disk. */
+	int major;
+	int irq;
+
+	unsigned long phys_addr;
+	/* The ioremap'ed block page. */
+	struct lguest_block_page *lb_page;
+
+	/* We only have a single request outstanding at a time. */
+	struct lguest_dma dma;
+	struct request *req;
+};
+
+/* Jens gave me this nice helper to end all chunks of a request. */
+static void end_entire_request(struct request *req, int uptodate)
+{
+	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
+		BUG();
+	add_disk_randomness(req->rq_disk);
+	blkdev_dequeue_request(req);
+	end_that_request_last(req, uptodate);
+}
+
+static irqreturn_t lgb_irq(int irq, void *_bd)
+{
+	struct blockdev *bd =3D _bd;
+	unsigned long flags;
+
+	if (!bd->req) {
+		pr_debug("No work!\n");
+		return IRQ_NONE;
+	}
+
+	if (!bd->lb_page->result) {
+		pr_debug("No result!\n");
+		return IRQ_NONE;
+	}
+
+	spin_lock_irqsave(&bd->lock, flags);
+	end_entire_request(bd->req, bd->lb_page->result =3D=3D 1);
+	bd->req =3D NULL;
+	bd->dma.used_len =3D 0;
+	blk_start_queue(bd->disk->queue);
+	spin_unlock_irqrestore(&bd->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static unsigned int req_to_dma(struct request *req, struct lguest_dma *dma)
+{
+	unsigned int i =3D 0, idx, len =3D 0;
+	struct bio *bio;
+
+	rq_for_each_bio(bio, req) {
+		struct bio_vec *bvec;
+		bio_for_each_segment(bvec, bio, idx) {
+			BUG_ON(i =3D=3D LGUEST_MAX_DMA_SECTIONS);
+			BUG_ON(!bvec->bv_len);
+			dma->addr[i] =3D page_to_phys(bvec->bv_page)
+				+ bvec->bv_offset;
+			dma->len[i] =3D bvec->bv_len;
+			len +=3D bvec->bv_len;
+			i++;
+		}
+	}
+	if (i < LGUEST_MAX_DMA_SECTIONS)
+		dma->len[i] =3D 0;
+	return len;
+}
+
+static void empty_dma(struct lguest_dma *dma)
+{
+	dma->len[0] =3D 0;
+}
+
+static void setup_req(struct blockdev *bd,
+		      int type, struct request *req, struct lguest_dma *dma)
+{
+	bd->lb_page->type =3D type;
+	bd->lb_page->sector =3D req->sector;
+	bd->lb_page->result =3D 0;
+	bd->req =3D req;
+	bd->lb_page->bytes =3D req_to_dma(req, dma);
+}
+
+static void do_write(struct blockdev *bd, struct request *req)
+{
+	struct lguest_dma send;
+
+	pr_debug("lgb: WRITE sector %li\n", (long)req->sector);
+	setup_req(bd, 1, req, &send);
+
+	hcall(LHCALL_SEND_DMA, bd->phys_addr, __pa(&send), 0);
+}
+
+static void do_read(struct blockdev *bd, struct request *req)
+{
+	struct lguest_dma ping;
+
+	pr_debug("lgb: READ sector %li\n", (long)req->sector);
+	setup_req(bd, 0, req, &bd->dma);
+
+	empty_dma(&ping);
+	hcall(LHCALL_SEND_DMA, bd->phys_addr, __pa(&ping), 0);
+}
+
+static void do_lgb_request(request_queue_t *q)
+{
+	struct blockdev *bd;
+	struct request *req;
+
+again:
+	req =3D elv_next_request(q);
+	if (!req)
+		return;
+
+	bd =3D req->rq_disk->private_data;
+	/* Sometimes we get repeated requests after blk_stop_queue. */
+	if (bd->req)
+		return;
+
+	if (!blk_fs_request(req)) {
+		pr_debug("Got non-command 0x%08x\n", req->cmd_type);
+		req->errors++;
+		end_entire_request(req, 0);
+		goto again;
+	}
+
+	if (rq_data_dir(req) =3D=3D WRITE)
+		do_write(bd, req);
+	else
+		do_read(bd, req);
+
+	/* Wait for interrupt to tell us it's done. */
+	blk_stop_queue(q);
+}
+
+static struct block_device_operations lguestblk_fops =3D {
+	.owner =3D THIS_MODULE,
+};
+
+static int lguestblk_probe(struct lguest_device *lgdev)
+{
+	struct blockdev *bd;
+	int err;
+	int irqflags =3D IRQF_SHARED;
+
+	bd =3D kmalloc(sizeof(*bd), GFP_KERNEL);
+	if (!bd)
+		return -ENOMEM;
+
+	spin_lock_init(&bd->lock);
+	bd->irq =3D lgdev->index+1;
+	bd->req =3D NULL;
+	bd->dma.used_len =3D 0;
+	bd->dma.len[0] =3D 0;
+	bd->phys_addr =3D (lguest_devices[lgdev->index].pfn << PAGE_SHIFT);
+
+	bd->lb_page =3D (void *)ioremap(bd->phys_addr, PAGE_SIZE);
+	if (!bd->lb_page) {
+		err =3D -ENOMEM;
+		goto out_free_bd;
+	}
+
+	bd->major =3D register_blkdev(0, "lguestblk");
+	if (bd->major < 0) {
+		err =3D bd->major;
+		goto out_unmap;
+	}
+
+	bd->disk =3D alloc_disk(1);
+	if (!bd->disk) {
+		err =3D -ENOMEM;
+		goto out_unregister_blkdev;
+	}
+
+	bd->disk->queue =3D blk_init_queue(do_lgb_request, &bd->lock);
+	if (!bd->disk->queue) {
+		err =3D -ENOMEM;
+		goto out_put_disk;
+	}
+
+	/* We can only handle a certain number of sg entries */
+	blk_queue_max_hw_segments(bd->disk->queue, LGUEST_MAX_DMA_SECTIONS);
+	/* Buffers must not cross page boundaries */
+	blk_queue_segment_boundary(bd->disk->queue, PAGE_SIZE-1);
+
+	sprintf(bd->disk->disk_name, "lgb%c", next_block_index++);
+	if (lguest_devices[lgdev->index].features & LGUEST_DEVICE_F_RANDOMNESS)
+		irqflags |=3D IRQF_SAMPLE_RANDOM;
+	err =3D request_irq(bd->irq, lgb_irq, irqflags, bd->disk->disk_name, bd);
+	if (err)
+		goto out_cleanup_queue;
+
+	hcall(LHCALL_BIND_DMA, bd->phys_addr, __pa(&bd->dma), (1<<8)+bd->irq);
+
+	bd->disk->major =3D bd->major;
+	bd->disk->first_minor =3D 0;
+	bd->disk->private_data =3D bd;
+	bd->disk->fops =3D &lguestblk_fops;
+	/* This is initialized to the disk size by the other end. */
+	set_capacity(bd->disk, bd->lb_page->num_sectors);
+	add_disk(bd->disk);
+
+	printk(KERN_INFO "%s: device %i at major %d\n",
+	       bd->disk->disk_name, lgdev->index, bd->major);
+
+	lgdev->private =3D bd;
+	return 0;
+
+out_cleanup_queue:
+	blk_cleanup_queue(bd->disk->queue);
+out_put_disk:
+	put_disk(bd->disk);
+out_unregister_blkdev:
+	unregister_blkdev(bd->major, "lguestblk");
+out_unmap:
+	iounmap(bd->lb_page);
+out_free_bd:
+	kfree(bd);
+	return err;
+}
+
+static struct lguest_driver lguestblk_drv =3D {
+	.name =3D "lguestblk",
+	.owner =3D THIS_MODULE,
+	.device_type =3D LGUEST_DEVICE_T_BLOCK,
+	.probe =3D lguestblk_probe,
+};
+
+static __init int lguestblk_init(void)
+{
+	return register_lguest_driver(&lguestblk_drv);
+}
+module_init(lguestblk_init);
+
+MODULE_DESCRIPTION("Lguest block driver");
+MODULE_LICENSE("GPL");
