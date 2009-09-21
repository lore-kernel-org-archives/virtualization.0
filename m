From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/6] virtio: make add_buf return capacity remaining
Date: Mon, 21 Sep 2009 16:28:19 +0930
Message-ID: <200909211628.19636.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: virtualization@lists.osdl.org
Cc: Dinesh Subhraveti <dineshs@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


This API change means that virtio_net can tell how much capacity
remains for buffers.  It's necessarily fuzzy, since
VIRTIO_RING_F_INDIRECT_DESC means we can fit any number of descriptors
in one, *if* we can kmalloc.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dinesh Subhraveti <dineshs@us.ibm.com>
---
 drivers/block/virtio_blk.c          |    2 +-
 drivers/char/hw_random/virtio-rng.c |    2 +-
 drivers/char/virtio_console.c       |    4 ++--
 drivers/net/virtio_net.c            |    8 ++++----
 drivers/virtio/virtio_balloon.c     |    2 +-
 drivers/virtio/virtio_ring.c        |    6 +++++-
 include/linux/virtio.h              |    2 +-
 net/9p/trans_virtio.c               |    2 +-
 8 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -139,7 +139,7 @@ static bool do_req(struct request_queue 
 		}
 	}
 
-	if (vblk->vq->vq_ops->add_buf(vblk->vq, vblk->sg, out, in, vbr)) {
+	if (vblk->vq->vq_ops->add_buf(vblk->vq, vblk->sg, out, in, vbr) < 0) {
 		mempool_free(vbr, vblk->pool);
 		return false;
 	}
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -51,7 +51,7 @@ static void register_buffer(void)
 
 	sg_init_one(&sg, random_data+data_left, RANDOM_DATA_SIZE-data_left);
 	/* There should always be room for one buffer. */
-	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, random_data) != 0)
+	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, random_data) < 0)
 		BUG();
 	vq->vq_ops->kick(vq);
 }
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -65,7 +65,7 @@ static int put_chars(u32 vtermno, const 
 
 	/* add_buf wants a token to identify this buffer: we hand it any
 	 * non-NULL pointer, since there's only ever one buffer. */
-	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) == 0) {
+	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) >= 0) {
 		/* Tell Host to go! */
 		out_vq->vq_ops->kick(out_vq);
 		/* Chill out until it's done with the buffer. */
@@ -85,7 +85,7 @@ static void add_inbuf(void)
 	sg_init_one(sg, inbuf, PAGE_SIZE);
 
 	/* We should always be able to add one buffer to an empty queue. */
-	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, inbuf) != 0)
+	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, inbuf) < 0)
 		BUG();
 	in_vq->vq_ops->kick(in_vq);
 }
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -320,7 +320,7 @@ static bool try_fill_recv_maxbufs(struct
 		skb_queue_head(&vi->recv, skb);
 
 		err = vi->rvq->vq_ops->add_buf(vi->rvq, sg, 0, num, skb);
-		if (err) {
+		if (err < 0) {
 			skb_unlink(skb, &vi->recv);
 			trim_pages(vi, skb);
 			kfree_skb(skb);
@@ -373,7 +373,7 @@ static bool try_fill_recv(struct virtnet
 		skb_queue_head(&vi->recv, skb);
 
 		err = vi->rvq->vq_ops->add_buf(vi->rvq, sg, 0, 1, skb);
-		if (err) {
+		if (err < 0) {
 			skb_unlink(skb, &vi->recv);
 			kfree_skb(skb);
 			break;
@@ -527,7 +527,7 @@ static int xmit_skb(struct virtnet_info 
 	num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
 
 	err = vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);
-	if (!err && !vi->free_in_tasklet)
+	if (err >= 0 && !vi->free_in_tasklet)
 		mod_timer(&vi->xmit_free_timer, jiffies + (HZ/10));
 
 	return err;
@@ -538,7 +538,7 @@ static void xmit_tasklet(unsigned long d
 	struct virtnet_info *vi = (void *)data;
 
 	netif_tx_lock_bh(vi->dev);
-	if (vi->last_xmit_skb && xmit_skb(vi, vi->last_xmit_skb) == 0) {
+	if (vi->last_xmit_skb && xmit_skb(vi, vi->last_xmit_skb) >= 0) {
 		vi->svq->vq_ops->kick(vi->svq);
 		vi->last_xmit_skb = NULL;
 	}
@@ -557,7 +557,7 @@ again:
 
 	/* If we has a buffer left over from last time, send it now. */
 	if (unlikely(vi->last_xmit_skb) &&
-	    xmit_skb(vi, vi->last_xmit_skb) != 0)
+	    xmit_skb(vi, vi->last_xmit_skb) < 0)
 		goto stop_queue;
 
 	vi->last_xmit_skb = NULL;
@@ -565,7 +565,7 @@ again:
 	/* Put new one in send queue and do transmit */
 	if (likely(skb)) {
 		__skb_queue_head(&vi->send, skb);
-		if (xmit_skb(vi, skb) != 0) {
+		if (xmit_skb(vi, skb) < 0) {
 			vi->last_xmit_skb = skb;
 			skb = NULL;
 			goto stop_queue;
@@ -668,7 +668,7 @@ static bool virtnet_send_command(struct 
 		sg_set_buf(&sg[i + 1], sg_virt(s), s->length);
 	sg_set_buf(&sg[out + in - 1], &status, sizeof(status));
 
-	BUG_ON(vi->cvq->vq_ops->add_buf(vi->cvq, sg, out, in, vi));
+	BUG_ON(vi->cvq->vq_ops->add_buf(vi->cvq, sg, out, in, vi) < 0);
 
 	vi->cvq->vq_ops->kick(vi->cvq);
 
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -84,7 +84,7 @@ static void tell_host(struct virtio_ball
 	init_completion(&vb->acked);
 
 	/* We should always be able to add one buffer to an empty queue. */
-	if (vq->vq_ops->add_buf(vq, &sg, 1, 0, vb) != 0)
+	if (vq->vq_ops->add_buf(vq, &sg, 1, 0, vb) < 0)
 		BUG();
 	vq->vq_ops->kick(vq);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -208,7 +208,11 @@ add_head:
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
-	return 0;
+
+	/* If we're indirect, we can fit many (assuming not OOM). */
+	if (vq->indirect)
+		return vq->num_free ? vq->vring.num : 0;
+	return vq->num_free;
 }
 
 static void vring_kick(struct virtqueue *_vq)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -34,7 +34,7 @@ struct virtqueue {
  *	out_num: the number of sg readable by other side
  *	in_num: the number of sg which are writable (after readable ones)
  *	data: the token identifying the buffer.
- *      Returns 0 or an error.
+ *      Returns remaining capacity of queue (sg segments) or a negative error.
  * @kick: update after add_buf
  *	vq: the struct virtqueue
  *	After one or more add_buf calls, invoke this to kick the other side.
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -200,7 +200,7 @@ p9_virtio_request(struct p9_client *clie
 
 	req->status = REQ_STATUS_SENT;
 
-	if (chan->vq->vq_ops->add_buf(chan->vq, chan->sg, out, in, req->tc)) {
+	if (chan->vq->vq_ops->add_buf(chan->vq, chan->sg, out, in, req->tc) < 0) {
 		P9_DPRINTK(P9_DEBUG_TRANS,
 			"9p debug: virtio rpc add_buf returned failure");
 		return -EIO;
