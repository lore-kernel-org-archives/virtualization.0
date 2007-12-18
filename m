From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio_net and SMP guests
Date: Tue, 18 Dec 2007 17:51:24 +1100
Message-ID: <200712181751.24692.rusty__47242.6460161389$1197960916$gmane$org@rustcorp.com.au>
References: <200712141312.05562.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712141312.05562.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 14 December 2007 23:12:05 Christian Borntraeger wrote:
> Rusty, Anthony, Dor,
>
> I need your brain power :-)
>
> On smp guests I have seen a problem with virtio (the version in curent
> Avi's git) which do not occur on single processor guests:
>
> kernel BUG at /space/kvm/drivers/virtio/virtio_ring.c:228!
> illegal operation: 0001 [#1]
> Modules linked in: ipv6
> CPU:    2    Not tainted
> Process swapper (pid: 0, task: 000000000f83e038, ksp: 000000000f877d70)
> Krnl PSW : 0704000180000000 000000000045df2a (vring_restart+0x5a/0x70)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:0 PM:0 EA:3
> Krnl GPRS: 00000000c0a80101 0000000000000000 000000000eb35000
> 0000000010005800 000000000045ded0 000000000000192f 000000000eb21000
> 000000000eb21000 000000000000000e 000000000eb21900 000000000eb21920
> 000000000f867cb8 0700000000d9b058 0000000000000010 000000000045c06a
> 000000000f867cb8 Krnl Code: 000000000045df1e: e3b0b0700004       lg     
> %r11,112(%r11) 000000000045df24: 07fe               bcr     15,%r14
>            000000000045df26: a7f40001           brc     15,45df28
>
>           >000000000045df2a: a7f4ffe1           brc     15,45deec
>
>            000000000045df2e: e31020300004       lg      %r1,48(%r2)
>            000000000045df34: a7480000           lhi     %r4,0
>            000000000045df38: 96011001           oi      1(%r1),1
>            000000000045df3c: a7f4ffef           brc     15,45df1a
> Call Trace:
> ([<000000000045c016>] virtnet_poll+0x96/0x42c)
>  [<000000000048cda2>] net_rx_action+0xca/0x150
>  [<0000000000137f7a>] __do_softirq+0x9e/0x130
>  [<00000000001105d6>] do_softirq+0xae/0xb4
>  [<0000000000138182>] irq_exit+0x96/0x9c
>  [<000000000010d710>] do_extint+0xcc/0xf8
>  [<00000000001135d0>] ext_no_vtime+0x16/0x1a
>  [<000000000010a57e>] cpu_idle+0x216/0x238
>
>
> I think there is a valid code path, triggering this bug:
>
> 	CPU1						CPU2
> -----------------------				-----------------------
> - virtnet_poll found no
>   more packets on queue
> - netif_rx_complete allow
>   poll to be called
> - vq_ops->restart is called
> - vq Interrupts are enabled
> 	.		     <new packets arrive>
> <vcpu is scheduled away>
> 	.					- interrupt is delivered
> 	.					- poll is called
> 	.					- poll work is done
> 	.					- netif_rx_complete
> 	.					- vq_ops->restart is called
> 	.					- check if vq interrupts are
> 	.					  enable --> BUG

Shouldn't this be BUG()ing in START_USE()?  Or did you disable that because
of previous false positives?

virtnet_poll() should not be reentering, AFAICT.  virtio relies on the caller
to ensure it never calls two virtio functions on the same queue
simultaneously, and virtio_net in turn relies on the core net code to enforce
this.

So, how did this happen?

Looks like we can have an interrupt on one CPU, which does:

	if (vq->vq.callback && !vq->vq.callback(&vq->vq))
		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;

The callback schedules the softirq to run, which usually runs on same CPU...
but if somehow it runs somewhere else, it could hit restart before the flag
is set.  This means removing the BUG_ON() is bad, because we could restart,
and then set the NO_INTERRUPT flag from the handler, and stall.

Note that interrupt suppression is advisory, so we can be sloppy on the
setting side.

To me this points to doing interrupt suppression a different way.  If we
have a ->disable_cb() virtio function, and call it before we call
netif_rx_schedule, does that fix it?

How's this?
Rusty.

---
virtio: explicit enable_cb/disable_cb rather than callback return.

It seems that virtio_net wants to disable callbacks (interrupts) before
calling netif_rx_schedule(), so we can't use the return value to do so.

Rename "restart" to "cb_enable" and introduce "cb_disable" hook: callback
now returns void, rather than a boolean.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 0eabf082c13a drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c	Tue Dec 18 13:51:13 2007 +1100
+++ b/drivers/block/virtio_blk.c	Tue Dec 18 15:49:18 2007 +1100
@@ -36,7 +36,7 @@ struct virtblk_req
 	struct virtio_blk_inhdr in_hdr;
 };
 
-static bool blk_done(struct virtqueue *vq)
+static void blk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
 	struct virtblk_req *vbr;
@@ -65,7 +65,6 @@ static bool blk_done(struct virtqueue *v
 	/* In case queue is stopped waiting for more buffers. */
 	blk_start_queue(vblk->disk->queue);
 	spin_unlock_irqrestore(&vblk->lock, flags);
-	return true;
 }
 
 static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
diff -r 0eabf082c13a drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c	Tue Dec 18 13:51:13 2007 +1100
+++ b/drivers/lguest/lguest_device.c	Tue Dec 18 15:49:18 2007 +1100
@@ -193,7 +193,7 @@ static void lg_notify(struct virtqueue *
  * So we provide devices with a "find virtqueue and set it up" function. */
 static struct virtqueue *lg_find_vq(struct virtio_device *vdev,
 				    unsigned index,
-				    bool (*callback)(struct virtqueue *vq))
+				    void (*callback)(struct virtqueue *vq))
 {
 	struct lguest_device *ldev = to_lgdev(vdev);
 	struct lguest_vq_info *lvq;
diff -r 0eabf082c13a drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Tue Dec 18 13:51:13 2007 +1100
+++ b/drivers/net/virtio_net.c	Tue Dec 18 15:49:18 2007 +1100
@@ -59,13 +59,12 @@ static inline void vnet_hdr_to_sg(struct
 	sg_init_one(sg, skb_vnet_hdr(skb), sizeof(struct virtio_net_hdr));
 }
 
-static bool skb_xmit_done(struct virtqueue *rvq)
+static void skb_xmit_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
 
 	/* In case we were waiting for output buffers. */
 	netif_wake_queue(vi->dev);
-	return true;
 }
 
 static void receive_skb(struct net_device *dev, struct sk_buff *skb,
@@ -177,12 +176,12 @@ static void try_fill_recv(struct virtnet
 	vi->rvq->vq_ops->kick(vi->rvq);
 }
 
-static bool skb_recv_done(struct virtqueue *rvq)
+static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
+	/* Suppress further interrupts. */
+	rvq->vq_ops->disable_cb(rvq);
 	netif_rx_schedule(vi->dev, &vi->napi);
-	/* Suppress further interrupts. */
-	return false;
 }
 
 static int virtnet_poll(struct napi_struct *napi, int budget)
@@ -208,7 +207,7 @@ again:
 	/* Out of packets? */
 	if (received < budget) {
 		netif_rx_complete(vi->dev, napi);
-		if (unlikely(!vi->rvq->vq_ops->restart(vi->rvq))
+		if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq))
 		    && netif_rx_reschedule(vi->dev, napi))
 			goto again;
 	}
diff -r 0eabf082c13a drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c	Tue Dec 18 13:51:13 2007 +1100
+++ b/drivers/virtio/virtio_pci.c	Tue Dec 18 15:49:18 2007 +1100
@@ -190,7 +190,7 @@ static irqreturn_t vp_interrupt(int irq,
 
 /* the config->find_vq() implementation */
 static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
-				    bool (*callback)(struct virtqueue *vq))
+				    void (*callback)(struct virtqueue *vq))
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
diff -r 0eabf082c13a drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c	Tue Dec 18 13:51:13 2007 +1100
+++ b/drivers/virtio/virtio_ring.c	Tue Dec 18 15:49:18 2007 +1100
@@ -220,7 +220,17 @@ static void *vring_get_buf(struct virtqu
 	return ret;
 }
 
-static bool vring_restart(struct virtqueue *_vq)
+static void vring_disable_cb(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	START_USE(vq);
+	BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
+	vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	END_USE(vq);
+}
+
+static bool vring_enable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -254,8 +264,8 @@ irqreturn_t vring_interrupt(int irq, voi
 		return IRQ_HANDLED;
 
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
-	if (vq->vq.callback && !vq->vq.callback(&vq->vq))
-		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	if (vq->vq.callback)
+		vq->vq.callback(&vq->vq);
 
 	return IRQ_HANDLED;
 }
@@ -266,7 +276,8 @@ static struct virtqueue_ops vring_vq_ops
 	.add_buf = vring_add_buf,
 	.get_buf = vring_get_buf,
 	.kick = vring_kick,
-	.restart = vring_restart,
+	.disable_cb = vring_disable_cb,
+	.enable_cb = vring_enable_cb,
 	.shutdown = vring_shutdown,
 };
 
@@ -274,7 +285,7 @@ struct virtqueue *vring_new_virtqueue(un
 				      struct virtio_device *vdev,
 				      void *pages,
 				      void (*notify)(struct virtqueue *),
-				      bool (*callback)(struct virtqueue *))
+				      void (*callback)(struct virtqueue *))
 {
 	struct vring_virtqueue *vq;
 	unsigned int i;
diff -r 0eabf082c13a include/linux/virtio.h
--- a/include/linux/virtio.h	Tue Dec 18 13:51:13 2007 +1100
+++ b/include/linux/virtio.h	Tue Dec 18 15:49:18 2007 +1100
@@ -11,15 +11,13 @@
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
  * @callback: the function to call when buffers are consumed (can be NULL).
- *    If this returns false, callbacks are suppressed until vq_ops->restart
- *    is called.
  * @vdev: the virtio device this queue was created for.
  * @vq_ops: the operations for this virtqueue (see below).
  * @priv: a pointer for the virtqueue implementation to use.
  */
 struct virtqueue
 {
-	bool (*callback)(struct virtqueue *vq);
+	void (*callback)(struct virtqueue *vq);
 	struct virtio_device *vdev;
 	struct virtqueue_ops *vq_ops;
 	void *priv;
@@ -41,7 +39,9 @@ struct virtqueue
  *	vq: the struct virtqueue we're talking about.
  *	len: the length written into the buffer
  *	Returns NULL or the "data" token handed to add_buf.
- * @restart: restart callbacks after callback returned false.
+ * @disable_cb: disable callbacks
+ *	vq: the struct virtqueue we're talking about.
+ * @enable_cb: restart callbacks after disable_cb.
  *	vq: the struct virtqueue we're talking about.
  *	This returns "false" (and doesn't re-enable) if there are pending
  *	buffers in the queue, to avoid a race.
@@ -65,7 +65,8 @@ struct virtqueue_ops {
 
 	void *(*get_buf)(struct virtqueue *vq, unsigned int *len);
 
-	bool (*restart)(struct virtqueue *vq);
+	void (*disable_cb)(struct virtqueue *vq);
+	bool (*enable_cb)(struct virtqueue *vq);
 
 	void (*shutdown)(struct virtqueue *vq);
 };
diff -r 0eabf082c13a include/linux/virtio_config.h
--- a/include/linux/virtio_config.h	Tue Dec 18 13:51:13 2007 +1100
+++ b/include/linux/virtio_config.h	Tue Dec 18 15:49:18 2007 +1100
@@ -61,7 +61,7 @@ struct virtio_config_ops
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
 				     unsigned index,
-				     bool (*callback)(struct virtqueue *));
+				     void (*callback)(struct virtqueue *));
 	void (*del_vq)(struct virtqueue *vq);
 };
 
diff -r 0eabf082c13a include/linux/virtio_ring.h
--- a/include/linux/virtio_ring.h	Tue Dec 18 13:51:13 2007 +1100
+++ b/include/linux/virtio_ring.h	Tue Dec 18 15:49:18 2007 +1100
@@ -114,7 +114,7 @@ struct virtqueue *vring_new_virtqueue(un
 				      struct virtio_device *vdev,
 				      void *pages,
 				      void (*notify)(struct virtqueue *vq),
-				      bool (*callback)(struct virtqueue *vq));
+				      void (*callback)(struct virtqueue *vq));
 void vring_del_virtqueue(struct virtqueue *vq);
 
 irqreturn_t vring_interrupt(int irq, void *_vq);
