From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 0/3] Virtio draft III
Date: Sat, 16 Jun 2007 23:12:32 +1000
Message-ID: <1181999552.6237.255.camel__19964.977380778$1181999667$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181217762.14054.192.camel@localhost.localdomain>
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

In this episode, Rusty tries to NAPI-ize the driver and discovers that
virtio callbacks are a bad idea: NAPI needs to turn interrupts off and
still be able to query for new incoming packets.

Changes to core:
1) Back to "interrupt" model with get_inbuf()/get_outbuf() calls.
2) Clearer rules for locking: in calls cannot overlap, out calls cannot
overlap, but in can overlap out.
3) Methods for suppressing/enabling "interrupt" calls.

Changes to example net driver:
1) NAPI, locking is now correct (and there is none)

Changes to example block driver:
1) Relay SCSI ioctls (particularly CDROMEJECT) for optional server
support (VIRTIO_BLK_T_SCSI_CMD).
2) /dev/vb -> /dev/vd.
3) Barrier support.
4) Header w/ definitions can be included from userspace.

Here's the inter-diff for the three:

diff -u b/include/linux/virtio.h b/include/linux/virtio.h
--- b/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -7,69 +7,109 @@
 /**
  * virtio_device - description and routines to drive a virtual device.
- * @lock: the lock to hold before calling any functions.
  * @dev: the underlying struct device.
  * @ops: the operations for this virtual device.
+ * @driver_ops: set by the driver for callbacks.
  * @priv: private pointer for the driver to use.
  */
 struct virtio_device {
-	spinlock_t lock;
 	struct device *dev;
 	struct virtio_ops *ops;
+	struct virtio_driver_ops *driver_ops;
 	void *priv;
 };
 
 /**
+ * virtio_driver_ops - driver callbacks for a virtual device.
+ * @in: inbufs have been completed.
+ *	Usually called from an interrupt handler.
+ *	Return false to suppress further inbuf callbacks.
+ * @out: outbufs have been completed.
+ *	Usually called from an interrupt handler.
+ *	Return false to suppress further outbuf callbacks.
+ */
+struct virtio_driver_ops {
+	bool (*in)(struct virtio_device *dev);
+	bool (*out)(struct virtio_device *dev);
+};
+
+enum virtio_dir {
+	VIRTIO_IN = 0x1,
+	VIRTIO_OUT = 0x2,
+};
+
+/**
  * virtio_ops - virtio abstraction layer
  * @add_outbuf: prepare to send data to the other end:
  *	vdev: the virtio_device
  *	sg: the description of the buffer(s).
  *	num: the size of the sg array.
- *	cb: the function to call once the outbuf is finished & detached.
- *	data: the token to hand to the cb function.
- *      Returns a unique id or an error.  Note that the callback will be
- *	called with the lock held, and possibly in an interrupt handler.
+ *	data: the token returned by the get_outbuf function.
+ *      Returns a unique id or an error.
  * @add_inbuf: prepare to receive data from the other end:
  *	vdev: the virtio_device
  *	sg: the description of the buffer(s).
  *	num: the size of the sg array.
- *	cb: the function to call once the inbuf is finished & detached.
- *	data: the token to hand to the cb function.
- *      Returns a unique id or an error (eg. -ENOSPC).  Note that the
- *	callback will be called with the lock held, and possibly in an
- *	interrupt handler.
- * @sync: update after add_inbuf/add_outbuf
+ *	data: the token returned by the get_inbuf function.
+ *      Returns a unique id or an error (eg. -ENOSPC).
+ * @sync: update after add_inbuf and/or add_outbuf
  *	vdev: the virtio_device we're talking about.
+ *	inout: VIRTIO_IN and/or VIRTIO_OUT
  *	After one or more add_inbuf/add_outbuf calls, invoke this to kick
  *	the virtio layer.
+ * @get_outbuf: get the next used outbuf.
+ *	vdev: the virtio_device we're talking about.
+ *	len: the length written into the outbuf
+ *	Returns NULL or the "data" token handed to add_outbuf (which has been
+ *	detached).
+ * @get_inbuf: get the next used inbuf.
+ *	vdev: the virtio_device we're talking about.
+ *	len: the length read from the inbuf
+ *	Returns NULL or the "data" token handed to add_inbuf (which has been
+ *	detached).
  * @detach_outbuf: make sure sent sg can no longer be read.
  *	vdev: the virtio_device we're talking about.
  *	id: the id returned from add_outbuf.
- *	This is not necessary (or valid!) if the outbuf callback has
- *	already fired.
+ *	This is usually used for shutdown.  Don't try to detach twice.
  * @detach_inbuf: make sure sent sg can no longer be written to.
  *	vdev: the virtio_device we're talking about.
  *	id: the id returned from add_inbuf.
- *	This is not necessary (or valid!) if the outbuf callback has
- *	already fired.
+ *	This is usually used for shutdown.  Don't try to detach twice.
+ * @restart_in: restart calls to driver_ops->in after it returned false.
+ *	vdev: the virtio_device we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	inbufs, to avoid a race.
+ * @restart_out: restart calls to driver_ops->out after it returned false.
+ *	vdev: the virtio_device we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	outbufs, to avoid a race.
+ *
+ * Locking rules are straightforward: the driver is responsible for
+ * locking.  Outbuf operations can be called in parallel to inbuf
+ * operations, but no two outbuf operations nor two inbuf operations
+ * may be invoked simultaneously.
+ *
+ * All operations can be called in any context.
  */
 struct virtio_ops {
 	unsigned long (*add_outbuf)(struct virtio_device *vdev,
 				    const struct scatterlist sg[],
 				    unsigned int num,
-				    void (*cb)(struct virtio_device *vdev,
-					       void *data, unsigned len),
 				    void *data);
 
 	unsigned long (*add_inbuf)(struct virtio_device *vdev,
 				   struct scatterlist sg[],
 				   unsigned int num,
-				   void (*cb)(struct virtio_device *vdev,
-					      void *data, unsigned len),
 				   void *data);
 
-	void (*sync)(struct virtio_device *vdev);
+	void (*sync)(struct virtio_device *vdev, enum virtio_dir inout);
+
+	void *(*get_outbuf)(struct virtio_device *vdev, unsigned int *len);
+	void *(*get_inbuf)(struct virtio_device *vdev, unsigned int *len);
 
 	void (*detach_outbuf)(struct virtio_device *vdev, unsigned long id);
 	void (*detach_inbuf)(struct virtio_device *vdev, unsigned long id);
+
+	bool (*restart_in)(struct virtio_device *vdev);
+	bool (*restart_out)(struct virtio_device *vdev);
 };
 #endif /* _LINUX_VIRTIO_H */
diff -u b/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- b/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,29 +33,21 @@
 	struct virtio_device *vdev;
 	struct net_device *ndev;
 
+	/* Number of input buffers, and max we've ever had. */
+	unsigned int num, max;
+
 	/* Receive & send queues. */
 	struct sk_buff_head recv;
 	struct sk_buff_head send;
-
-	/* Transmitted packets waiting to be freed */
-	struct sk_buff_head free;
 };
 
-static void skb_xmit_done(struct virtio_device *vdev, void *_skb, unsigned len)
+static bool skb_xmit_done(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
-	struct sk_buff *skb = _skb;
-
-	assert_spin_locked(&vdev->lock);
-
-	__skb_unlink(skb, &vi->send);
-	vi->ndev->stats.tx_bytes += len;
-	vi->ndev->stats.tx_packets++;
-	__skb_queue_head(&vi->free, skb);
 
-	pr_debug("Sent skb %p\n", skb);
 	/* In case we were waiting for output buffers. */
 	netif_wake_queue(vi->ndev);
+	return true;
 }
 
 static void receive_skb(struct net_device *dev, struct sk_buff *skb,
@@ -78,48 +70,90 @@
 	netif_rx(skb);
 }
 
-static void skb_recv_done(struct virtio_device *, void *, unsigned);
-static int try_fill_recv(struct virtnet_info *vi)
+static void try_fill_recv(struct virtnet_info *vi)
 {
 	struct sk_buff *skb;
 	struct scatterlist sg[MAX_SKB_FRAGS];
-	unsigned long num, id;
-
-	assert_spin_locked(&vi->vdev->lock);
+	unsigned long sgnum, id;
 
-	skb = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
-	if (unlikely(!skb))
-		return -ENOMEM;
+	for (;;) {
+		skb = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
+		if (unlikely(!skb))
+			break;
+
+		skb_put(skb, MAX_PACKET_LEN);
+		sgnum = skb_to_sgvec(skb, sg, 0, skb->len);
+		skb_queue_head(&vi->recv, skb);
+
+		id = vi->vdev->ops->add_inbuf(vi->vdev, sg, sgnum, skb);
+		if (IS_ERR_VALUE(id)) {
+			skb_unlink(skb, &vi->recv);
+			kfree_skb(skb);
+			break;
+		}
+		vi->num++;
+	}
+	if (unlikely(vi->num > vi->max))
+		vi->max = vi->num;
+	vi->vdev->ops->sync(vi->vdev, VIRTIO_IN);
+}
 
-	skb_put(skb, MAX_PACKET_LEN);
-	num = skb_to_sgvec(skb, sg, 0, skb->len);
-	skb_queue_head(&vi->recv, skb);
+static bool skb_recv_done(struct virtio_device *vdev)
+{
+	struct virtnet_info *vi = vdev->priv;
 
-	id = vi->vdev->ops->add_inbuf(vi->vdev, sg, num, skb_recv_done, skb);
-	if (IS_ERR_VALUE(id)) {
-		skb_unlink(skb, &vi->recv);
-		kfree_skb(skb);
-		return id;
-	}
-	return 0;
+	netif_rx_schedule(vi->ndev);
+	/* Suppress further interrupts. */
+	return false;
 }
 
-static void skb_recv_done(struct virtio_device *vdev, void *_skb, unsigned len)
+static int virtnet_poll(struct net_device *dev, int *budget)
 {
-	struct virtnet_info *vi = vdev->priv;
-	struct sk_buff *skb = _skb;
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct sk_buff *skb = NULL;
+	unsigned int len, received = 0;
 
-	assert_spin_locked(&vdev->lock);
-	__skb_unlink(skb, &vi->recv);
-	receive_skb(vi->ndev, skb, len);
-	try_fill_recv(vi);
+again:
+	while (received < dev->quota &&
+	       (skb = vi->vdev->ops->get_inbuf(vi->vdev, &len)) != NULL) {
+		__skb_unlink(skb, &vi->recv);
+		receive_skb(vi->ndev, skb, len);
+		vi->num--;
+		received++;
+	}
+
+        dev->quota -= received;
+        *budget -= received;
+
+	/* FIXME: If we oom and completely run out of inbufs, we need
+	 * to start a timer trying to fill more. */
+	if (vi->num < vi->max / 2)
+		try_fill_recv(vi);
+
+	/* Still more work to do? */
+	if (skb)
+		return 1; /* not done */
+
+	netif_rx_complete(dev);
+	if (unlikely(!vi->vdev->ops->restart_in(vi->vdev))
+	    && netif_rx_reschedule(dev, received))
+		goto again;
+
+	return 0;
 }
 
-static void free_old_skbs(struct sk_buff_head *free)
+static void free_old_xmit_skbs(struct virtnet_info *vi)
 {
 	struct sk_buff *skb;
-	while ((skb = __skb_dequeue(free)) != NULL)
+	unsigned int len;
+
+	while ((skb = vi->vdev->ops->get_outbuf(vi->vdev, &len)) != NULL) {
+		pr_debug("Sent skb %p\n", skb);
+		__skb_unlink(skb, &vi->send);
+		vi->ndev->stats.tx_bytes += len;
+		vi->ndev->stats.tx_packets++;
 		kfree_skb(skb);
+	}
 }
 
 static int start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -128,19 +162,16 @@
 	unsigned long num, id;
 	struct scatterlist sg[MAX_SKB_FRAGS];
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
-	unsigned long flags;
 
 	pr_debug("%s: xmit %p %02x:%02x:%02x:%02x:%02x:%02x\n",
 		 dev->name, skb,
 		 dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]);
 
-	spin_lock_irqsave(&vi->vdev->lock, flags);
-	/* Free any transmitted packets: not supposed to do it in interrupt */
-	free_old_skbs(&vi->free);
+	free_old_xmit_skbs(vi);
 
 	num = skb_to_sgvec(skb, sg, 0, skb->len);
 	__skb_queue_head(&vi->send, skb);
-	id = vi->vdev->ops->add_outbuf(vi->vdev, sg, num, skb_xmit_done, skb);
+	id = vi->vdev->ops->add_outbuf(vi->vdev, sg, num, skb);
 	if (IS_ERR_VALUE(id)) {
 		pr_debug("%s: virtio not prepared to send\n", dev->name);
 		skb_unlink(skb, &vi->send);
@@ -148,8 +179,7 @@
 		return NETDEV_TX_BUSY;
 	}
 	SKB_ID(skb) = id;
-	vi->vdev->ops->sync(vi->vdev);
-	spin_unlock_irqrestore(&vi->vdev->lock, flags);
+	vi->vdev->ops->sync(vi->vdev, VIRTIO_OUT);
 
 	return 0;
 }
@@ -157,16 +187,12 @@
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int i, err;
 
-	spin_lock_irq(&vi->vdev->lock);
-	for (i = 0; (err = try_fill_recv(vi)) == 0; i++);
-	vi->vdev->ops->sync(vi->vdev);
-	spin_unlock_irq(&vi->vdev->lock);
+	try_fill_recv(vi);
 
 	/* If we didn't even get one input buffer, we're useless. */
-	if (i == 0)
-		return err;
+	if (vi->num == 0)
+		return -ENOMEM;
 
 	return 0;
 }
@@ -176,20 +202,26 @@
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct sk_buff *skb;
 
-	spin_lock_irq(&vi->vdev->lock);
+	/* networking core has neutered skb_xmit_done/skb_recv_done, so don't
+	 * worry about races vs. get_buf(). */
 	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
 		vi->vdev->ops->detach_inbuf(vi->vdev, SKB_ID(skb));
 		kfree_skb(skb);
+		vi->num--;
 	}
 	while ((skb = __skb_dequeue(&vi->send)) != NULL) {
 		vi->vdev->ops->detach_outbuf(vi->vdev, SKB_ID(skb));
 		kfree_skb(skb);
 	}
-	free_old_skbs(&vi->free);
-	spin_unlock_irq(&vi->vdev->lock);
+	BUG_ON(vi->num != 0);
 	return 0;
 }
 
+static struct virtio_driver_ops virtnet_ops = {
+	.in = skb_recv_done,
+	.out = skb_xmit_done,
+};
+
 struct net_device *virtnet_probe(struct virtio_device *vdev,
 				 const u8 mac[ETH_ALEN])
 {
@@ -207,16 +239,18 @@
 	memcpy(dev->dev_addr, mac, ETH_ALEN);
 	dev->open = virtnet_open;
 	dev->stop = virtnet_close;
+	dev->poll = virtnet_poll;
 	dev->hard_start_xmit = start_xmit;
+	dev->weight = 16;
 	SET_NETDEV_DEV(dev, vdev->dev);
 
 	vi = netdev_priv(dev);
 	vi->vdev = vdev;
 	vi->ndev = dev;
 	vdev->priv = vi;
+	vdev->driver_ops = &virtnet_ops;
 	skb_queue_head_init(&vi->recv);
 	skb_queue_head_init(&vi->send);
-	skb_queue_head_init(&vi->free);
 
 	err = register_netdev(dev);
 	if (err) {
diff -u b/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
--- b/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1,4 +1,4 @@
-//#define DEBUG
+#define DEBUG
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
@@ -8,6 +8,8 @@
 static unsigned char virtblk_index = 'a';
 struct virtio_blk
 {
+	spinlock_t lock;
+
 	struct virtio_device *vdev;
 
 	/* The disk structure for the kernel. */
@@ -19,7 +21,7 @@
 	mempool_t *pool;
 
 	/* Scatterlist: can be too big for stack. */
-	struct scatterlist sg[1+MAX_PHYS_SEGMENTS];
+	struct scatterlist sg[2+MAX_PHYS_SEGMENTS];
 };
 
 struct virtblk_req
@@ -28,68 +30,94 @@
 	struct request *req;
 	unsigned long out_id;
 	bool out_done, in_done;
-	bool failed;
+	int uptodate;
 	struct virtio_blk_outhdr out_hdr;
 	struct virtio_blk_inhdr in_hdr;
 };
 
-/* Jens gave me this nice helper to end all chunks of a request. */
-static void end_dequeued_request(struct request *req, int uptodate)
+static void end_dequeued_request(struct request *req,
+				 request_queue_t *q, int uptodate)
 {
-	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
+	/* And so the insanity of the block layer infects us here. */
+	int nsectors = req->hard_nr_sectors;
+
+	if (blk_pc_request(req)) {
+		nsectors = (req->data_len + 511) >> 9;
+		if (!nsectors)
+			nsectors = 1;
+		printk("uptodate = %i\n", uptodate);
+	}
+	if (end_that_request_first(req, uptodate, nsectors))
 		BUG();
 	add_disk_randomness(req->rq_disk);
 	end_that_request_last(req, uptodate);
 }
 
-static void finish(struct virtio_blk *vblk, struct virtblk_req *vbr)
+static bool finish(struct virtio_blk *vblk, struct virtblk_req *vbr)
 {
-	end_dequeued_request(vbr->req, !vbr->failed);
+	if (!vbr->in_done || !vbr->out_done)
+		return false;
+	end_dequeued_request(vbr->req, vblk->disk->queue, vbr->uptodate);
 	list_del(&vbr->list);
 	mempool_free(vbr, vblk->pool);
-	/* In case queue is stopped waiting for more buffers. */
-	blk_start_queue(vblk->disk->queue);
+	return true;
 }
 
 /* We make sure they finished both the input and output buffers: otherwise
  * they might still have read access after we free them. */
-static void blk_out_done(struct virtio_device *vdev, void *_vbr, unsigned len)
+static bool blk_out_done(struct virtio_device *vdev)
 {
-	struct virtblk_req *vbr = _vbr;
 	struct virtio_blk *vblk = vdev->priv;
+	struct virtblk_req *vbr;
+	unsigned int len, finished = 0;
+	unsigned long flags;
 
-	assert_spin_locked(&vblk->vdev->lock);
-
-	BUG_ON(vbr->out_done);
-	vbr->out_done = true;
-	if (vbr->in_done)
-		finish(vblk, vbr);
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
 }
 
-static void blk_in_done(struct virtio_device *vdev, void *_vbr, unsigned len)
+static bool blk_in_done(struct virtio_device *vdev)
 {
-	struct virtblk_req *vbr = _vbr;
 	struct virtio_blk *vblk = vdev->priv;
-	unsigned long expected_len;
+	struct virtblk_req *vbr;
+	unsigned int len, finished = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vblk->lock, flags);
 
-	assert_spin_locked(&vblk->vdev->lock);
+	while ((vbr = vdev->ops->get_inbuf(vdev, &len)) != NULL) {
+		BUG_ON(vbr->in_done);
 
-	expected_len = sizeof(vbr->in_hdr);
-	if (vbr->out_hdr.type == READ)
-		expected_len += vbr->req->hard_nr_sectors*512;
-
-	if (unlikely(len != expected_len)) {
-		dev_err(vblk->vdev->dev, "short reply %u not %lu",
-			len, expected_len);
-		vbr->failed = true;
-	} else if (unlikely(vbr->in_hdr.status != 1)) {
-		vbr->failed = true;
+		switch (vbr->in_hdr.status) {
+		case VIRTIO_BLK_S_OK:
+			vbr->uptodate = 1;
+			break;
+		case VIRTIO_BLK_S_UNSUPP:
+			printk("Request was unsupported\n");
+			vbr->uptodate = -ENOTTY;
+			break;
+		default:
+			vbr->uptodate = 0;
+			break;
+		}
+		vbr->in_done = true;
+		finished += finish(vblk, vbr);
 	}
 
-	BUG_ON(vbr->in_done);
-	vbr->in_done = true;
-	if (vbr->out_done)
-		finish(vblk, vbr);
+	/* In case queue is stopped waiting for more buffers. */
+	if (finished)
+		blk_start_queue(vblk->disk->queue);
+	spin_unlock_irqrestore(&vblk->lock, flags);
+	return true;
 }
 
 static bool do_write(request_queue_t *q, struct virtio_blk *vblk,
@@ -97,12 +125,14 @@
 {
 	unsigned long num;
 
+	vbr->out_hdr.type |= VIRTIO_BLK_T_WRITE;
+
 	/* Set up for reply. */
 	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
 	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
 	vblk->sg[0].length = sizeof(vbr->in_hdr);
 	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg, 1,
-						     blk_in_done, vbr);
+						     vbr);
 	if (IS_ERR_VALUE(vbr->out_hdr.id))
 		goto full;
 
@@ -112,15 +142,13 @@
 	vblk->sg[0].length = sizeof(vbr->out_hdr);
 
 	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
-	vbr->out_done = vbr->in_done = false;
-	vbr->failed = false;
 	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1+num,
-						  blk_out_done, vbr);
+						  vbr);
 	if (IS_ERR_VALUE(vbr->out_id))
 		goto detach_inbuf_full;
 
 	pr_debug("Write: %p in=%lu out=%lu\n", vbr,
-		 vbr->out_hdr.id, vbr->out_id);
+		 (long)vbr->out_hdr.id, (long)vbr->out_id);
 	list_add_tail(&vbr->list, &vblk->reqs);
 	return true;
 
@@ -135,13 +163,15 @@
 {
 	unsigned long num;
 
+	vbr->out_hdr.type |= VIRTIO_BLK_T_READ;
+
 	/* Set up for reply. */
 	vblk->sg[0].page = virt_to_page(&vbr->in_hdr);
 	vblk->sg[0].offset = offset_in_page(&vbr->in_hdr);
 	vblk->sg[0].length = sizeof(vbr->in_hdr);
 	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
 	vbr->out_hdr.id = vblk->vdev->ops->add_inbuf(vblk->vdev, vblk->sg,
-						     1+num, blk_in_done, vbr);
+						     1+num, vbr);
 	if (IS_ERR_VALUE(vbr->out_hdr.id))
 		goto full;
 
@@ -149,15 +179,53 @@
 	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
 	vblk->sg[0].length = sizeof(vbr->out_hdr);
 
-	vbr->out_done = vbr->in_done = false;
-	vbr->failed = false;
 	vbr->out_id = vblk->vdev->ops->add_outbuf(vblk->vdev, vblk->sg, 1,
-						  blk_out_done, vbr);
+						  vbr);
 	if (IS_ERR_VALUE(vbr->out_id))
 		goto detach_inbuf_full;
 
 	pr_debug("Read: %p in=%lu out=%lu\n", vbr,
-		 vbr->out_hdr.id, vbr->out_id);
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
 	list_add_tail(&vbr->list, &vblk->reqs);
 	return true;
 
@@ -176,37 +244,38 @@
 	while ((req = elv_next_request(q)) != NULL) {
 		vblk = req->rq_disk->private_data;
 
-		/* FIXME: handle these iff capable. */
-		if (!blk_fs_request(req)) {
-			pr_debug("Got non-command 0x%08x\n", req->cmd_type);
-			req->errors++;
-			blkdev_dequeue_request(req);
-			end_dequeued_request(req, 0);
-			continue;
-		}
-
 		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
 		if (!vbr)
 			goto stop;
 
 		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
 		vbr->req = req;
-		vbr->out_hdr.type = rq_data_dir(req);
+		/* Actual type gets or'ed in do_scsi/do_write/do_read */
+		vbr->out_hdr.type = blk_barrier_rq(req)?VIRTIO_BLK_T_BARRIER:0;
 		vbr->out_hdr.sector = req->sector;
+		vbr->out_hdr.ioprio = req->ioprio;
+		vbr->out_done = vbr->in_done = false;
 
-		if (rq_data_dir(req) == WRITE) {
-			if (!do_write(q, vblk, vbr))
-				goto stop;
-		} else {
-			if (!do_read(q, vblk, vbr))
+		if (blk_pc_request(req)) {
+			if (!do_scsi(q, vblk, vbr))
 				goto stop;
-		}
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
 		blkdev_dequeue_request(req);
 	}
 
 sync:
 	if (vblk)
-		vblk->vdev->ops->sync(vblk->vdev);
+		vblk->vdev->ops->sync(vblk->vdev, VIRTIO_IN|VIRTIO_OUT);
 	return;
 
 stop:
@@ -216,7 +285,21 @@
 	goto sync;
 }
 
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
 static struct block_device_operations virtblk_fops = {
+	.ioctl = virtblk_ioctl,
 	.owner = THIS_MODULE,
 };
 
@@ -232,8 +315,10 @@
 	}
 
 	INIT_LIST_HEAD(&vblk->reqs);
+	spin_lock_init(&vblk->lock);
 	vblk->vdev = vdev;
 	vdev->priv = vblk;
+	vdev->driver_ops = &virtblk_ops;
 
 	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
 	if (!vblk->pool) {
@@ -254,19 +339,20 @@
 		goto out_unregister_blkdev;
 	}
 
-	vblk->disk->queue = blk_init_queue(do_virtblk_request,
-					   &vblk->vdev->lock);
+	vblk->disk->queue = blk_init_queue(do_virtblk_request, &vblk->lock);
 	if (!vblk->disk->queue) {
 		err = -ENOMEM;
 		goto out_put_disk;
 	}
 
-	sprintf(vblk->disk->disk_name, "vb%c", virtblk_index++);
+	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
 	vblk->disk->major = major;
 	vblk->disk->first_minor = 0;
 	vblk->disk->private_data = vblk;
 	vblk->disk->fops = &virtblk_fops;
 
+	blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
+
 	/* Caller can do blk_queue_max_hw_segments(), set_capacity()
 	 * etc then add_disk(). */
 	return vblk->disk;
diff -u b/include/linux/virtio_blk.h b/include/linux/virtio_blk.h
--- b/include/linux/virtio_blk.h
+++ b/include/linux/virtio_blk.h
@@ -3,26 +3,37 @@
 #include <linux/types.h>
-struct gendisk;
-struct virtio_device;
-struct hd_geometry;
+
+#define VIRTIO_BLK_T_READ	0
+#define VIRTIO_BLK_T_WRITE 1
+#define VIRTIO_BLK_T_SCSI_CMD 3
+#define VIRTIO_BLK_T_BARRIER 0x80000000 /* Barrier before this op. */
 
 /* This is the first element of the scatter-gather list. */
 struct virtio_blk_outhdr
 {
-	/* 0 == read, 1 == write */
-	u32 type;
+	/* VIRTIO_BLK_T* */
+	__u32 type;
+	/* io priority. */
+	__u32 ioprio;
 	/* Sector (ie. 512 byte offset) */
-	unsigned long sector;
+	__u64 sector;
 	/* Where to put reply. */
-	unsigned long id;
+	__u64 id;
 };
 
+#define VIRTIO_BLK_S_OK		0
+#define VIRTIO_BLK_S_IOERR	1
+#define VIRTIO_BLK_S_UNSUPP	2
+
 struct virtio_blk_inhdr
 {
-	/* 1 = OK, 0 = not ok. */
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
