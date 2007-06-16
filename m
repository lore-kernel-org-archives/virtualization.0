From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Lguest implemention of virtio draft III
Date: Sat, 16 Jun 2007 23:28:34 +1000
Message-ID: <1182000514.6237.273.camel__6647.15859243206$1182000631$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
	<1181999669.6237.257.camel@localhost.localdomain>
	<1181999825.6237.260.camel@localhost.localdomain>
	<1181999920.6237.263.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181999920.6237.263.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a bonus patch for those wondering how a virtio implementation
can look.  I have two, this is the more efficient one (needs some
modification for inter-guest though: it assumes the other end does all
the accessing of our memory.  It's currently tacked on to the existing
lguest I/O mechanism as a demonstration, rather than replacing it.

It shows that it's possible to implement virtio without internal
locking.

Userspace server-side code isn't included.
===
This allows zero-copy from guest <-> host.  It uses a page of
descriptors, a page to say what descriptors to use, and a page to say
what's been used: one each set for inbufs and one for outbufs.

TODO:
1) More polishing
2) Get rid of old I/O
3) Inter-guest I/O implementation

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/Makefile         |    2 
 drivers/lguest/hypercalls.c     |    4 
 drivers/lguest/lguest_virtio.c  |  511 +++++++++++++++++++++++++++++++++++++++
 include/linux/lguest.h          |    3 
 include/linux/lguest_launcher.h |   24 +
 6 files changed, 948 insertions(+), 5 deletions(-)

--- a/drivers/lguest/Makefile
+++ b/drivers/lguest/Makefile
@@ -1,5 +1,5 @@
 # Guest requires the paravirt_ops replacement and the bus driver.
-obj-$(CONFIG_LGUEST_GUEST) += lguest.o lguest_asm.o lguest_bus.o
+obj-$(CONFIG_LGUEST_GUEST) += lguest.o lguest_asm.o lguest_bus.o lguest_virtio.o
 
 # Host requires the other files, which can be a module.
 obj-$(CONFIG_LGUEST)	+= lg.o
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -86,6 +86,10 @@ static void do_hcall(struct lguest *lg, 
 		break;
 	case LHCALL_HALT:
 		lg->halted = 1;
+		break;
+	case LHCALL_NOTIFY:
+		lg->pending_key = regs->edx << PAGE_SHIFT;
+		lg->dma_is_pending = 1;
 		break;
 	default:
 		kill_guest(lg, "Bad hypercall %li\n", regs->eax);
===================================================================
--- /dev/null
+++ b/drivers/lguest/lguest_virtio.c
@@ -0,0 +1,511 @@
+/* Descriptor-based virtio backend using lguest. */
+
+/* FIXME: Put "running" in shared page so other side really doesn't
+ * send us interrupts.  Then we would never need to "fail" restart.
+ * If there are more buffers when we set "running", simply ping other
+ * side.  It would interrupt us back again.
+ */
+#define DEBUG
+#include <linux/lguest.h>
+#include <linux/lguest_bus.h>
+#include <linux/virtio.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+#define NUM_DESCS (PAGE_SIZE / sizeof(struct lguest_desc))
+
+#ifdef DEBUG
+/* For development, we want to crash whenever the other side is bad. */
+#define BAD_SIDE(lgv, fmt...)			\
+	do { dev_err(lgv->vdev.dev, fmt); BUG(); } while(0)
+#define START_USE(di) \
+	do { if ((di)->in_use) panic("in_use = %i\n", (di)->in_use); (di)->in_use = __LINE__; mb(); } while(0)
+#define END_USE(di) \
+	do { BUG_ON(!(di)->in_use); (di)->in_use = 0; mb(); } while(0)
+#else
+#define BAD_SIDE(lgv, fmt...)			\
+	do { dev_err(lgv->vdev.dev, fmt); (lgv)->broken = true; } while(0)
+#define START_USE(di)
+#define END_USE(di)
+#endif
+
+/* FIXME: make the device mem layout a struct, not a set of pointers */
+struct desc_info
+{
+	/* Page of descriptors. */
+	struct lguest_desc *desc;
+	/* How we tell other side what buffers are available. */
+	unsigned int *avail_idx;
+	unsigned int *available;
+	/* How other side tells us what's used. */
+	unsigned int *used_idx;
+	struct lguest_used *used;
+
+	/* Number of free buffers */
+	unsigned int num_free;
+	/* Head of free buffer list. */
+	unsigned int free_head;
+	/* Number we've added since last sync. */
+	unsigned int num_added;
+
+	/* Last used index we've seen. */
+	unsigned int last_used_idx;
+
+	/* Unless they told us to stop */
+	bool running;
+
+#ifdef DEBUG
+	/* They're supposed to lock for us. */
+	unsigned int in_use;
+#endif
+
+	/* Tokens for callbacks. */
+	void *data[NUM_DESCS];
+};
+
+/* FIXME: When doing this for real, vdev will go straight into lguest_device */
+struct lguest_virtio_device
+{
+	struct virtio_device vdev;
+	struct lguest_device *lg;
+	void *priv;
+
+	/* Other side has made a mess, don't try any more. */
+	bool broken;
+
+	struct desc_info in, out;
+};
+
+static inline struct lguest_virtio_device *
+vdev_to_lgv(struct virtio_device *vdev)
+{
+	return container_of(vdev, struct lguest_virtio_device, vdev);
+}
+
+static unsigned long add_buf(struct desc_info *di,
+			     const struct scatterlist *sg,
+			     unsigned int num,
+			     void *data)
+{
+	unsigned int i, head, uninitialized_var(prev);
+
+	BUG_ON(data == NULL);
+	START_USE(di);
+
+	if (di->num_free < num) {
+		pr_debug("Can't add buf len %i - avail = %i\n", num,
+			 di->num_free);
+		END_USE(di);
+		return -ENOSPC;
+	}
+
+	/* We're about to use some buffers from the free list. */
+	di->num_free -= num;
+
+	head = di->free_head;
+	for (i = di->free_head; num; i = di->desc[i].next, num--) {
+		di->desc[i].flags |= LGUEST_DESC_F_NEXT;
+		di->desc[i].pfn = page_to_pfn(sg[0].page);
+		di->desc[i].offset = sg[0].offset;
+		di->desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	/* Last one doesn't continue. */
+	di->desc[prev].flags &= ~LGUEST_DESC_F_NEXT;
+
+	/* Update free pointer */
+	di->free_head = i;
+
+	di->data[head] = data;
+
+	/* Make sure it's all visible to other side before setting head. */
+	wmb();
+	di->desc[head].flags |= LGUEST_DESC_F_HEAD;
+
+	/* Put it in available array for advertising. */
+	di->available[(*di->avail_idx + di->num_added++) % NUM_DESCS] = head;
+
+	pr_debug("Added buffer head %i\n", head);
+	END_USE(di);
+	return head;
+}
+
+static unsigned long lguest_add_outbuf(struct virtio_device *vdev,
+				       const struct scatterlist sg[],
+				       unsigned int num,
+				       void *data)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	BUG_ON(num > NUM_DESCS);
+	BUG_ON(num == 0);
+
+	return add_buf(&lgv->out, sg, num, data);
+}
+
+static unsigned long lguest_add_inbuf(struct virtio_device *vdev,
+				      struct scatterlist sg[],
+				      unsigned int num,
+				      void *data)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	BUG_ON(num > NUM_DESCS);
+	BUG_ON(num == 0);
+
+	return add_buf(&lgv->in, sg, num, data);
+}
+
+static void lguest_sync(struct virtio_device *vdev, enum virtio_dir inout)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	if (inout & VIRTIO_IN)
+		START_USE(&lgv->in);
+	if (inout & VIRTIO_OUT)
+		START_USE(&lgv->out);
+	/* LGUEST_DESC_F_HEAD needs to be set before we say they're avail. */
+	wmb();
+
+	if (inout & VIRTIO_IN) {
+		*lgv->in.avail_idx += lgv->in.num_added;
+		lgv->in.num_added = 0;
+	}
+	if (inout & VIRTIO_OUT) {
+		*lgv->out.avail_idx += lgv->out.num_added;
+		lgv->out.num_added = 0;
+	}
+
+	/* Prod other side to tell it about changes. */
+	hcall(LHCALL_NOTIFY, lguest_devices[lgv->lg->index].pfn, 0, 0);
+	if (inout & VIRTIO_IN)
+		END_USE(&lgv->in);
+	if (inout & VIRTIO_OUT)
+		END_USE(&lgv->out);
+}
+
+static void detach_buf(struct desc_info *di, int id)
+{
+	unsigned int i;
+
+	BUG_ON(id >= NUM_DESCS);
+	BUG_ON(!(di->desc[id].flags & LGUEST_DESC_F_HEAD));
+
+	di->desc[id].flags &= ~LGUEST_DESC_F_HEAD;
+	/* Make sure other side has seen that it's detached. */
+	wmb();
+
+	/* Put back on free list: find end */
+	for (i = id; di->desc[i].flags&LGUEST_DESC_F_NEXT; i=di->desc[i].next)
+		di->num_free++;
+
+	di->desc[i].next = di->free_head;
+	di->free_head = id;
+	/* Plus final descriptor */
+	di->num_free++;
+}
+
+static void lguest_detach_outbuf(struct virtio_device *vdev, unsigned long id)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	START_USE(&lgv->out);
+	detach_buf(&lgv->out, id);
+	END_USE(&lgv->out);
+}
+
+static void lguest_detach_inbuf(struct virtio_device *vdev, unsigned long id)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	START_USE(&lgv->in);
+	detach_buf(&lgv->in, id);
+	END_USE(&lgv->in);
+}
+
+static bool more_used(struct desc_info *di)
+{
+	return di->last_used_idx != *di->used_idx;
+}
+
+static void *get_buf(struct desc_info *di, struct lguest_virtio_device *lgv,
+		     unsigned int *len)
+{
+	unsigned int id;
+
+	START_USE(di);
+
+	if (!more_used(di)) {
+		END_USE(di);
+		return NULL;
+	}
+
+	/* Don't let them make us do infinite work. */
+	if (unlikely(*di->used_idx > di->last_used_idx + NUM_DESCS)) {
+		BAD_SIDE(lgv, "Too many descriptors");
+		return NULL;
+	}
+
+	id = di->used[di->last_used_idx%NUM_DESCS].id;
+	*len = di->used[di->last_used_idx%NUM_DESCS].len;
+
+	if (unlikely(id >= NUM_DESCS)) {
+		BAD_SIDE(lgv, "id %u out of range\n", id);
+		return NULL;
+	}
+	if (unlikely(!(di->desc[id].flags & LGUEST_DESC_F_HEAD))) {
+		BAD_SIDE(lgv, "id %u is not a head!\n", id);
+		return NULL;
+	}
+
+	detach_buf(di, id);
+	di->last_used_idx++;
+	BUG_ON(!di->data[id]);
+	END_USE(di);
+	return di->data[id];
+}
+
+static void *lguest_get_outbuf(struct virtio_device *vdev, unsigned int *len)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	return get_buf(&lgv->out, lgv, len);
+}
+
+static void *lguest_get_inbuf(struct virtio_device *vdev, unsigned int *len)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	return get_buf(&lgv->in, lgv, len);
+}
+
+static bool lguest_restart_in(struct virtio_device *vdev)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	START_USE(&lgv->in);
+	BUG_ON(lgv->in.running);
+
+	if (likely(!more_used(&lgv->in)) || unlikely(lgv->broken))
+		lgv->in.running = true;
+
+	END_USE(&lgv->in);
+	return lgv->in.running;
+}
+
+static bool lguest_restart_out(struct virtio_device *vdev)
+{
+	struct lguest_virtio_device *lgv = vdev_to_lgv(vdev);
+
+	START_USE(&lgv->out);
+	BUG_ON(lgv->out.running);
+
+	if (likely(!more_used(&lgv->in)) || unlikely(lgv->broken))
+		lgv->in.running = true;
+
+	END_USE(&lgv->out);
+	return lgv->in.running;
+}
+
+static irqreturn_t lguest_virtio_interrupt(int irq, void *_lgv)
+{
+	struct lguest_virtio_device *lgv = _lgv;
+
+	if (unlikely(lgv->broken))
+		return IRQ_HANDLED;
+
+	if (lgv->out.running && more_used(&lgv->out))
+		lgv->out.running = lgv->vdev.driver_ops->out(&lgv->vdev);
+
+	if (lgv->in.running && more_used(&lgv->in))
+		lgv->in.running = lgv->vdev.driver_ops->in(&lgv->vdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct virtio_ops lguest_virtio_ops = {
+	.add_outbuf = lguest_add_outbuf,
+	.add_inbuf = lguest_add_inbuf,
+	.sync = lguest_sync,
+	.detach_outbuf = lguest_detach_outbuf,
+	.detach_inbuf = lguest_detach_inbuf,
+	.get_outbuf = lguest_get_outbuf,
+	.get_inbuf = lguest_get_inbuf,
+	.restart_in = lguest_restart_in,
+	.restart_out = lguest_restart_out,
+};
+
+static struct lguest_virtio_device *lg_new_virtio(struct lguest_device *lgdev)
+{
+	struct lguest_virtio_device *lgv;
+	void *mem;
+	unsigned int i;
+
+	lgv = kmalloc(sizeof(*lgv), GFP_KERNEL);
+	if (!lgv)
+		return NULL;
+
+	memset(lgv, 0, sizeof(*lgv));
+
+	lgdev->private = lgv;
+	lgv->lg = lgdev;
+
+	/* Device mem is input pages followed by output pages */
+	mem = lguest_map(lguest_devices[lgdev->index].pfn<<PAGE_SHIFT, 6);
+	if (!mem)
+		goto free_lgv;
+	lgv->in.desc = mem;
+	lgv->in.avail_idx = mem + PAGE_SIZE;
+	lgv->in.available = (void *)(lgv->in.avail_idx + 1);
+	lgv->in.used_idx = mem + PAGE_SIZE*2;
+	lgv->in.used = (void *)(lgv->in.used_idx + 1);
+	lgv->out.desc = mem + PAGE_SIZE*3;
+	lgv->out.avail_idx = mem + PAGE_SIZE*4;
+	lgv->out.available = (void *)(lgv->out.avail_idx + 1);
+	lgv->out.used_idx = mem + PAGE_SIZE*5;
+	lgv->out.used = (void *)(lgv->out.used_idx + 1);
+
+	lgv->in.last_used_idx = lgv->out.last_used_idx = 0;
+	lgv->in.num_added = lgv->out.num_added = 0;
+	lgv->in.running = lgv->out.running = true;
+
+	/* Put everything in free lists. */
+	lgv->in.num_free = lgv->out.num_free = NUM_DESCS;
+	for (i = 0; i < NUM_DESCS-1; i++) {
+		lgv->in.desc[i].next = i+1;
+		lgv->out.desc[i].next = i+1;
+	}
+
+	lgv->vdev.ops = &lguest_virtio_ops;
+	lgv->vdev.dev = &lgdev->dev;
+	lgv->broken = false;
+	return lgv;
+
+free_lgv:
+	kfree(lgv);
+	return NULL;;
+}
+
+static void lg_destroy_virtio(struct lguest_virtio_device *lgv)
+{
+	lguest_unmap(lgv->in.desc);
+	kfree(lgv);
+}
+
+/* It's nice to have the name for the interrupt, so we do this separately
+ * from lg_new_virtio(). */
+static int lg_setup_interrupt(struct lguest_virtio_device *lgv,
+			      const char *name)
+{
+	int irqf;
+
+	if (lguest_devices[lgv->lg->index].features&LGUEST_DEVICE_F_RANDOMNESS)
+		irqf = IRQF_SAMPLE_RANDOM;
+	else
+		irqf = 0;
+
+	return request_irq(lgdev_irq(lgv->lg), lguest_virtio_interrupt, irqf,
+			   name, lgv);
+}
+
+/* Example network driver code. */
+#include <linux/virtio_net.h>
+#include <linux/etherdevice.h>
+
+static int lguest_virtnet_probe(struct lguest_device *lgdev)
+{
+	struct lguest_virtio_device *lgv;
+	struct net_device *dev;
+	u8 mac[ETH_ALEN];
+	int err;
+
+	lgv = lg_new_virtio(lgdev);
+	if (!lgv)
+		return -ENOMEM;
+
+	random_ether_addr(mac);
+	lgv->priv = dev = virtnet_probe(&lgv->vdev, mac);
+	if (IS_ERR(lgv->priv)) {
+		err = PTR_ERR(lgv->priv);
+		goto destroy;
+	}
+	err = lg_setup_interrupt(lgv, dev->name);
+	if (err)
+		goto unprobe;
+	return 0;
+
+unprobe:
+	virtnet_remove(dev);
+destroy:
+	lg_destroy_virtio(lgv);
+	return err;
+}
+
+static struct lguest_driver lguest_virtnet_drv = {
+	.name = "lguestvirtnet",
+	.owner = THIS_MODULE,
+	.device_type = LGUEST_DEVICE_T_VIRTNET,
+	.probe = lguest_virtnet_probe,
+};
+
+static __init int lguest_virtnet_init(void)
+{
+	return register_lguest_driver(&lguest_virtnet_drv);
+}
+device_initcall(lguest_virtnet_init);
+
+/* Example block driver code. */
+#include <linux/virtio_blk.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
+static int lguest_virtblk_probe(struct lguest_device *lgdev)
+{
+	struct lguest_virtio_device *lgv;
+	struct gendisk *disk;
+	unsigned long sectors;
+	int err;
+
+	lgv = lg_new_virtio(lgdev);
+	if (!lgv)
+		return -ENOMEM;
+
+	/* Page is initially used to pass capacity. */
+	sectors = *(unsigned long *)lgv->in.desc;
+	*(unsigned long *)lgv->in.desc = 0;
+
+	lgv->priv = disk = virtblk_probe(&lgv->vdev);
+	if (IS_ERR(lgv->priv)) {
+		err = PTR_ERR(lgv->priv);
+		goto destroy;
+	}
+	set_capacity(disk, sectors);
+	blk_queue_max_hw_segments(disk->queue, NUM_DESCS-1);
+
+	err = lg_setup_interrupt(lgv, disk->disk_name);
+	if (err)
+		goto unprobe;
+	add_disk(disk);
+	return 0;
+
+unprobe:
+	virtblk_remove(disk);
+destroy:
+	lg_destroy_virtio(lgv);
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
===================================================================
--- a/include/linux/lguest.h
+++ b/include/linux/lguest.h
@@ -23,6 +23,9 @@
 #define LHCALL_SET_PTE		14
 #define LHCALL_SET_PMD		15
 #define LHCALL_LOAD_TLS		16
+
+/* Experimental hcalls for new I/O */
+#define LHCALL_NOTIFY	100 /* pfn */
 
 #define LG_CLOCK_MIN_DELTA	100UL
 #define LG_CLOCK_MAX_DELTA	ULONG_MAX
===================================================================
--- a/include/linux/lguest_launcher.h
+++ b/include/linux/lguest_launcher.h
@@ -44,6 +44,8 @@ struct lguest_device_desc {
 #define LGUEST_DEVICE_T_CONSOLE	1
 #define LGUEST_DEVICE_T_NET	2
 #define LGUEST_DEVICE_T_BLOCK	3
+#define LGUEST_DEVICE_T_VIRTNET	8
+#define LGUEST_DEVICE_T_VIRTBLK	9
 
 	u16 features;
 #define LGUEST_NET_F_NOCSUM		0x4000 /* Don't bother checksumming */
@@ -70,4 +72,26 @@ enum lguest_req
 	LHREQ_IRQ, /* + irq */
 	LHREQ_BREAK, /* + on/off flag (on blocks until someone does off) */
 };
+
+/* This marks a buffer as being the start (and active) */
+#define LGUEST_DESC_F_HEAD	1
+/* This marks a buffer as continuing via the next field. */
+#define LGUEST_DESC_F_NEXT	2
+
+/* Virtio descriptors */
+struct lguest_desc
+{
+	unsigned long pfn;
+	unsigned long len;
+	u16 offset;
+	u16 flags;
+	/* We chain unused descriptors via this, too */
+	u32 next;
+};
+
+struct lguest_used
+{
+	unsigned int id;
+	unsigned int len;
+};
 #endif /* _ASM_LGUEST_USER */
