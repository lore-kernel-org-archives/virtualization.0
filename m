From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example
	block driver
Date: Sat, 02 Jun 2007 19:28:02 +1000
Message-ID: <1180776482.9228.22.camel__44725.4856735983$1180776599$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<1180654765.10999.6.camel@localhost.localdomain>
	<465FC65C.6020905@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465FC65C.6020905@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-06-01 at 09:10 +0200, Carsten Otte wrote:
> Rusty Russell wrote:
> > What's the overhead in doing both?
> With regard to compute power needed, almost none. The penalty is 
> latency, not overhead: A small request may sit on the request queue to 
> wait for other work to arrive until the queue gets unplugged. This 
> penality is compensated by the benefit of a good chance that more 
> requests will be merged during this time period.
> If we have this method both in host and guest, we have twice the 
> penalty with no added benefit.

Indeed, but as it turns out that the draft block driver is appealingly
naive in this respect: the caller can invoke "elevator_init(disk->queue,
"noop")".  See the extract from the lguest implementation below (which
doesn't do this, but could).

Is the noop scheduler significantly worse than hooking directly into
q->make_request_fn?

> A third way out of that situation is to do queueing between guest and 
> host: on the first bio, guest does a hypercall. When the next bio 
> arrives, guest sees that the host has not finished processing the 
> queue yet and pushes another buffer without doing a notification. 
> We've also implemented this, with the result that our host stack was 
> quick enough to practically always process the bio before the guest 
> had the chance to submit another one. Performance was a nightmare, so 
> we discontinued pursuing that idea.

Interesting!  This kind of implementation becomes quite natural with
shared memory so the guest can see an "ack" from the host: if the
previous notification hasn't been acked, it doesn't send another one.

Such a scheme has application beyond block devices and (this is what I'm
really interested in): should be easy to implement under virtio_ops.

Thanks!
Rusty.

+/* Example block driver code. */
+#include <linux/virtio_blk.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
+static irqreturn_t lguest_virtblk_interrupt(int irq, void *_lgv)
+{
+	struct lguest_virtio_device *lgv = _lgv;
+
+	return virtblk_interrupt(lgv->priv);
+}
+
+static int lguest_virtblk_probe(struct lguest_device *lgdev)
+{
+	struct lguest_virtio_device *lgv;
+	struct gendisk *disk;
+	unsigned long sectors;
+	int err, irqf, i;
+
+	lgv = kmalloc(sizeof(*lgv), GFP_KERNEL);
+	if (!lgv)
+		return -ENOMEM;
+
+	memset(lgv, 0, sizeof(*lgv));
+
+	lgdev->private = lgv;
+	lgv->lg = lgdev;
+
+	/* Map is input page followed by output page */
+	lgv->in.p = lguest_map(lguest_devices[lgdev->index].pfn<<PAGE_SHIFT,2);
+	if (!lgv->in.p) {
+		err = -ENOMEM;
+		goto free_lgv;
+	}
+	lgv->out.p = lgv->in.p + 1;
+	/* Page is initially used to pass capacity. */
+	sectors = *(unsigned long *)lgv->in.p;
+	*(unsigned long *)lgv->in.p = 0;
+
+	/* Put everything in free lists. */
+	lgv->in.avail = lgv->out.avail = NUM_DESCS;
+	for (i = 0; i < NUM_DESCS-1; i++) {
+		lgv->in.p->desc[i].next = i+1;
+		lgv->out.p->desc[i].next = i+1;
+	}
+
+	lgv->vdev.ops = &lguest_virtio_ops;
+	lgv->vdev.dev = &lgdev->dev;
+
+	lgv->priv = disk = virtblk_probe(&lgv->vdev);
+	if (IS_ERR(lgv->priv)) {
+		err = PTR_ERR(lgv->priv);
+		goto unmap;
+	}
+	set_capacity(disk, sectors);
+	blk_queue_max_hw_segments(disk->queue, NUM_DESCS-1);
+
+	if (lguest_devices[lgv->lg->index].features&LGUEST_DEVICE_F_RANDOMNESS)
+		irqf = IRQF_SAMPLE_RANDOM;
+	else
+		irqf = 0;
+
+	err = request_irq(lgdev_irq(lgv->lg), lguest_virtblk_interrupt, irqf,
+			  disk->disk_name, lgv);
+	if (err)
+		goto remove;
+
+	add_disk(disk);
+	printk("Virtblk device %s registered\n", disk->disk_name);
+	return 0;
+
+remove:
+	virtblk_remove(disk);
+unmap:
+	lguest_unmap(lgv->in.p);
+free_lgv:
+	kfree(lgv);
+	return err;
+}
+
+static struct lguest_driver lguest_virtblk_drv = {
+	.name = "lguestvirtblk",
+	.owner = THIS_MODULE,
+	.device_type = LGUEST_DEVICE_T_VIRTBLK,
+	.probe = lguest_virtblk_probe,
+};
+
+static __init int lguest_virtblk_init(void)
+{
+	return register_lguest_driver(&lguest_virtblk_drv);
+}
+device_initcall(lguest_virtblk_init);
+
+MODULE_LICENSE("GPL");
