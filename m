From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 09:28:16 +1000
Message-ID: <1187652496.19435.141.camel__26401.8725757071$1187652630$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <ghaskins@novell.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-08-17 at 09:50 -0400, Gregory Haskins wrote:
> On Fri, 2007-08-17 at 17:43 +1000, Rusty Russell wrote:
> > Well, for cache reasons you should really try to avoid having both sides
> > write to the same data.  Hence two separate cache-aligned regions is
> > better than one region and a flip bit.
> 
> While I certainly can see what you mean about the cache implications for
> a bit-flip design, I don't see how you can get away with not having both
> sides write to the same memory in other designs either.  Wouldn't you
> still have to adjust descriptors from one ring to the other?  E.g.
> wouldn't both sides be writing descriptor pointer data in this case, or
> am I missing something?

Hi Gregory,

	You can have separate produced and consumed counters: see for example
Van Jacobson's Netchannels presentation
http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf page 23.

	This single consumed count isn't sufficient if you can consume
out-of-order: for that you really want a second "reply" ringbuffer
indicating what buffers are consumed.

> > Yeah, I fear grant tables too.  But in any scheme, the descriptors imply
> > permission, so with a little careful design and implementation it should
> > "just work"...
> > 
> 
> I am certainly looking forward to hearing more of your ideas in this
> area.  Very interesting, indeed....

Well, the simplest scheme I think is a ring buffer of descriptors, eg:

	struct io_desc {
		unsigned long pfn;
		u16 len;
		u16 offset;
	}

	struct io_ring {
		unsigned int prod_idx;
		struct io_desc desc[NUM_DESCS];
	}

Now if we want to chain buffers but differentiate separate buffers, we
need a "continues" flag, but we can probably overload bits somehow for
that (no 32 bit machine has 64k pages, and 64 bit machines have space
for a 32 it flag).  I ended up using a separate page of descriptors and
the ring simply referred to them, but I'm not really sure.

A second "used" ring for the receiver to say what's finished completes
the picture.  So much so that we don't need an explicit "consumed" ring,
see code:

--- a/include/linux/lguest_launcher.h
+++ b/include/linux/lguest_launcher.h
@@ -90,6 +90,8 @@ struct lguest_device_desc {
 #define LGUEST_DEVICE_T_CONSOLE	1
 #define LGUEST_DEVICE_T_NET	2
 #define LGUEST_DEVICE_T_BLOCK	3
+#define LGUEST_DEVICE_T_VIRTNET	8
+#define LGUEST_DEVICE_T_VIRTBLK	9
 
 	/* The specific features of this device: these depends on device type
 	 * except for LGUEST_DEVICE_F_RANDOMNESS. */
@@ -124,4 +126,28 @@ enum lguest_req
 	LHREQ_IRQ, /* + irq */
 	LHREQ_BREAK, /* + on/off flag (on blocks until someone does off) */
 };
+
+/* This marks a buffer as being the start (and active) */
+#define LGUEST_DESC_F_HEAD	1
+/* This marks a buffer as continuing via the next field. */
+#define LGUEST_DESC_F_NEXT	2
+/* This marks a buffer as write-only (otherwise read-only). */
+#define LGUEST_DESC_F_WRITE	4
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

--- /dev/null
+++ b/drivers/lguest/lguest_virtio.c
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
+#define BAD_SIDE(lvq, fmt...)			\
+	do { dev_err(&lvq->lg->dev, fmt); BUG(); } while(0)
+#define START_USE(lvq) \
+	do { if ((lvq)->in_use) panic("in_use = %i\n", (lvq)->in_use); (lvq)->in_use = __LINE__; mb(); } while(0)
+#define END_USE(lvq) \
+	do { BUG_ON(!(lvq)->in_use); (lvq)->in_use = 0; mb(); } while(0)
+#else
+#define BAD_SIDE(lvq, fmt...)			\
+	do { dev_err(&lvq->lg->dev, fmt); (lvq)->broken = true; } while(0)
+#define START_USE(lvq)
+#define END_USE(lvq)
+#endif
+
+struct desc_pages
+{
+	/* Page of descriptors. */
+	struct lguest_desc desc[NUM_DESCS];
+
+	/* Next page: how we tell other side what buffers are available. */
+	unsigned int avail_idx;
+	unsigned int available[NUM_DESCS];
+	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
+
+	/* Third page: how other side tells us what's used. */
+	unsigned int used_idx;
+	struct lguest_used used[NUM_DESCS];
+};
+
+struct lguest_virtqueue
+{
+	struct virtqueue vq;
+
+	/* Actual memory layout for this queue */
+	struct desc_pages *d;
+
+	struct lguest_device *lg;
+
+	/* Other side has made a mess, don't try any more. */
+	bool broken;
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
+static inline struct lguest_virtqueue *vq_to_lvq(struct virtqueue *vq)
+{
+	return container_of(vq, struct lguest_virtqueue, vq);
+}
+
+static int lguest_add_buf(struct virtqueue *vq,
+			  struct scatterlist sg[],
+			  unsigned int out_num,
+			  unsigned int in_num,
+			  void *data)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+	unsigned int i, head, uninitialized_var(prev);
+
+	BUG_ON(data == NULL);
+	BUG_ON(out_num + in_num > NUM_DESCS);
+	BUG_ON(out_num + in_num == 0);
+
+	START_USE(lvq);
+
+	if (lvq->num_free < out_num + in_num) {
+		pr_debug("Can't add buf len %i - avail = %i\n",
+			 out_num + in_num, lvq->num_free);
+		END_USE(lvq);
+		return -ENOSPC;
+	}
+
+	/* We're about to use some buffers from the free list. */
+	lvq->num_free -= out_num + in_num;
+
+	head = lvq->free_head;
+	for (i = lvq->free_head; out_num; i=lvq->d->desc[i].next, out_num--) {
+		lvq->d->desc[i].flags = LGUEST_DESC_F_NEXT;
+		lvq->d->desc[i].pfn = page_to_pfn(sg[0].page);
+		lvq->d->desc[i].offset = sg[0].offset;
+		lvq->d->desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	for (; in_num; i = lvq->d->desc[i].next, in_num--) {
+		lvq->d->desc[i].flags = LGUEST_DESC_F_NEXT|LGUEST_DESC_F_WRITE;
+		lvq->d->desc[i].pfn = page_to_pfn(sg[0].page);
+		lvq->d->desc[i].offset = sg[0].offset;
+		lvq->d->desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	/* Last one doesn't continue. */
+	lvq->d->desc[prev].flags &= ~LGUEST_DESC_F_NEXT;
+
+	/* Update free pointer */
+	lvq->free_head = i;
+
+	lvq->data[head] = data;
+
+	/* Make head is only set after descriptor has been written. */
+	wmb();
+	lvq->d->desc[head].flags |= LGUEST_DESC_F_HEAD;
+
+	/* Advertise it in available array. */
+	lvq->d->available[(lvq->d->avail_idx + lvq->num_added++) % NUM_DESCS]
+		= head;
+
+	pr_debug("Added buffer head %i to %p\n", head, lvq);
+	END_USE(lvq);
+	return 0;
+}
+
+static void lguest_sync(struct virtqueue *vq)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+
+	START_USE(lvq);
+	/* LGUEST_DESC_F_HEAD needs to be set before we say they're avail. */
+	wmb();
+
+	lvq->d->avail_idx += lvq->num_added;
+	lvq->num_added = 0;
+
+	/* Prod other side to tell it about changes. */
+	hcall(LHCALL_NOTIFY, lguest_devices[lvq->lg->index].pfn, 0, 0);
+	END_USE(lvq);
+}
+
+static void __detach_buf(struct lguest_virtqueue *lvq, unsigned int head)
+{
+	unsigned int i;
+
+	lvq->d->desc[head].flags &= ~LGUEST_DESC_F_HEAD;
+	/* Make sure other side has seen that it's detached. */
+	wmb();
+	/* Put back on free list: find end */
+	i = head;
+	while (lvq->d->desc[i].flags&LGUEST_DESC_F_NEXT) {
+		i = lvq->d->desc[i].next;
+		lvq->num_free++;
+	}
+
+	lvq->d->desc[i].next = lvq->free_head;
+	lvq->free_head = head;
+	/* Plus final descriptor */
+	lvq->num_free++;
+}
+
+static int lguest_detach_buf(struct virtqueue *vq, void *data)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+	unsigned int i;
+
+	for (i = 0; i < NUM_DESCS; i++) {
+		if (lvq->data[i] == data
+		    && (lvq->d->desc[i].flags & LGUEST_DESC_F_HEAD)) {
+			__detach_buf(lvq, i);
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+static bool more_used(const struct lguest_virtqueue *lvq)
+{
+	return lvq->last_used_idx != lvq->d->used_idx;
+}
+
+static void *lguest_get_buf(struct virtqueue *vq, unsigned int *len)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+	unsigned int i;
+
+	START_USE(lvq);
+
+	if (!more_used(lvq)) {
+		END_USE(lvq);
+		return NULL;
+	}
+
+	/* Don't let them make us do infinite work. */
+	if (unlikely(lvq->d->used_idx > lvq->last_used_idx + NUM_DESCS)) {
+		BAD_SIDE(lvq, "Too many descriptors");
+		return NULL;
+	}
+
+	i = lvq->d->used[lvq->last_used_idx%NUM_DESCS].id;
+	*len = lvq->d->used[lvq->last_used_idx%NUM_DESCS].len;
+
+	if (unlikely(i >= NUM_DESCS)) {
+		BAD_SIDE(lvq, "id %u out of range\n", i);
+		return NULL;
+	}
+	if (unlikely(!(lvq->d->desc[i].flags & LGUEST_DESC_F_HEAD))) {
+		BAD_SIDE(lvq, "id %u is not a head!\n", i);
+		return NULL;
+	}
+
+	__detach_buf(lvq, i);
+	lvq->last_used_idx++;
+	BUG_ON(!lvq->data[i]);
+	END_USE(lvq);
+	return lvq->data[i];
+}
+
+static bool lguest_restart(struct virtqueue *vq)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+
+	START_USE(lvq);
+	BUG_ON(lvq->running);
+
+	if (likely(!more_used(lvq)) || unlikely(lvq->broken))
+		lvq->running = true;
+
+	END_USE(lvq);
+	return lvq->running;
+}
+
+static irqreturn_t lguest_virtqueue_interrupt(int irq, void *_lvq)
+{
+	struct lguest_virtqueue *lvq = _lvq;
+
+	pr_debug("virtqueue interrupt for %p\n", lvq);
+
+	if (unlikely(lvq->broken))
+		return IRQ_HANDLED;
+
+	if (lvq->running && more_used(lvq)) {
+		pr_debug("virtqueue callback for %p (%p)\n", lvq, lvq->vq.cb);
+		lvq->running = lvq->vq.cb(&lvq->vq);
+	} else
+		pr_debug("virtqueue %p no more used\n", lvq);
+
+	return IRQ_HANDLED;
+}
