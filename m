From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/6] virtio_net: use virtqueue_xxx wrappers
Date: Mon, 12 Apr 2010 16:19:04 +0300
Message-ID: <1b4845f70cf04fe46e074f7e74606105d8523e90.1271078235.git.mst@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Switch virtio_net to new virtqueue_xxx wrappers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fb783c..e00944b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -119,7 +119,7 @@ static void skb_xmit_done(struct virtqueue *svq)
 	struct virtnet_info *vi = svq->vdev->priv;
 
 	/* Suppress further interrupts. */
-	svq->vq_ops->disable_cb(svq);
+	virtqueue_disable_cb(svq);
 
 	/* We were probably waiting for more output buffers. */
 	netif_wake_queue(vi->dev);
@@ -207,7 +207,7 @@ static int receive_mergeable(struct virtnet_info *vi, struct sk_buff *skb)
 			return -EINVAL;
 		}
 
-		page = vi->rvq->vq_ops->get_buf(vi->rvq, &len);
+		page = virtqueue_get_buf(vi->rvq, &len);
 		if (!page) {
 			pr_debug("%s: rx error: %d buffers missing\n",
 				 skb->dev->name, hdr->mhdr.num_buffers);
@@ -338,7 +338,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, gfp_t gfp)
 
 	skb_to_sgvec(skb, sg + 1, 0, skb->len);
 
-	err = vi->rvq->vq_ops->add_buf(vi->rvq, sg, 0, 2, skb);
+	err = virtqueue_add_buf(vi->rvq, sg, 0, 2, skb);
 	if (err < 0)
 		dev_kfree_skb(skb);
 
@@ -384,7 +384,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, gfp_t gfp)
 
 	/* chain first in list head */
 	first->private = (unsigned long)list;
-	err = vi->rvq->vq_ops->add_buf(vi->rvq, sg, 0, MAX_SKB_FRAGS + 2,
+	err = virtqueue_add_buf(vi->rvq, sg, 0, MAX_SKB_FRAGS + 2,
 				       first);
 	if (err < 0)
 		give_pages(vi, first);
@@ -404,7 +404,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi, gfp_t gfp)
 
 	sg_init_one(&sg, page_address(page), PAGE_SIZE);
 
-	err = vi->rvq->vq_ops->add_buf(vi->rvq, &sg, 0, 1, page);
+	err = virtqueue_add_buf(vi->rvq, &sg, 0, 1, page);
 	if (err < 0)
 		give_pages(vi, page);
 
@@ -433,7 +433,7 @@ static bool try_fill_recv(struct virtnet_info *vi, gfp_t gfp)
 	} while (err > 0);
 	if (unlikely(vi->num > vi->max))
 		vi->max = vi->num;
-	vi->rvq->vq_ops->kick(vi->rvq);
+	virtqueue_kick(vi->rvq);
 	return !oom;
 }
 
@@ -442,7 +442,7 @@ static void skb_recv_done(struct virtqueue *rvq)
 	struct virtnet_info *vi = rvq->vdev->priv;
 	/* Schedule NAPI, Suppress further interrupts if successful. */
 	if (napi_schedule_prep(&vi->napi)) {
-		rvq->vq_ops->disable_cb(rvq);
+		virtqueue_disable_cb(rvq);
 		__napi_schedule(&vi->napi);
 	}
 }
@@ -471,7 +471,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 again:
 	while (received < budget &&
-	       (buf = vi->rvq->vq_ops->get_buf(vi->rvq, &len)) != NULL) {
+	       (buf = virtqueue_get_buf(vi->rvq, &len)) != NULL) {
 		receive_buf(vi->dev, buf, len);
 		--vi->num;
 		received++;
@@ -485,9 +485,9 @@ again:
 	/* Out of packets? */
 	if (received < budget) {
 		napi_complete(napi);
-		if (unlikely(!vi->rvq->vq_ops->enable_cb(vi->rvq)) &&
+		if (unlikely(!virtqueue_enable_cb(vi->rvq)) &&
 		    napi_schedule_prep(napi)) {
-			vi->rvq->vq_ops->disable_cb(vi->rvq);
+			virtqueue_disable_cb(vi->rvq);
 			__napi_schedule(napi);
 			goto again;
 		}
@@ -501,7 +501,7 @@ static unsigned int free_old_xmit_skbs(struct virtnet_info *vi)
 	struct sk_buff *skb;
 	unsigned int len, tot_sgs = 0;
 
-	while ((skb = vi->svq->vq_ops->get_buf(vi->svq, &len)) != NULL) {
+	while ((skb = virtqueue_get_buf(vi->svq, &len)) != NULL) {
 		pr_debug("Sent skb %p\n", skb);
 		vi->dev->stats.tx_bytes += skb->len;
 		vi->dev->stats.tx_packets++;
@@ -557,7 +557,7 @@ static int xmit_skb(struct virtnet_info *vi, struct sk_buff *skb)
 		sg_set_buf(sg, &hdr->hdr, sizeof hdr->hdr);
 
 	hdr->num_sg = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
-	return vi->svq->vq_ops->add_buf(vi->svq, sg, hdr->num_sg, 0, skb);
+	return virtqueue_add_buf(vi->svq, sg, hdr->num_sg, 0, skb);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -576,14 +576,14 @@ again:
 	if (unlikely(capacity < 0)) {
 		netif_stop_queue(dev);
 		dev_warn(&dev->dev, "Unexpected full queue\n");
-		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
-			vi->svq->vq_ops->disable_cb(vi->svq);
+		if (unlikely(!virtqueue_enable_cb(vi->svq))) {
+			virtqueue_disable_cb(vi->svq);
 			netif_start_queue(dev);
 			goto again;
 		}
 		return NETDEV_TX_BUSY;
 	}
-	vi->svq->vq_ops->kick(vi->svq);
+	virtqueue_kick(vi->svq);
 
 	/* Don't wait up for transmitted skbs to be freed. */
 	skb_orphan(skb);
@@ -593,12 +593,12 @@ again:
 	 * before it gets out of hand.  Naturally, this wastes entries. */
 	if (capacity < 2+MAX_SKB_FRAGS) {
 		netif_stop_queue(dev);
-		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
+		if (unlikely(!virtqueue_enable_cb(vi->svq))) {
 			/* More just got used, free them then recheck. */
 			capacity += free_old_xmit_skbs(vi);
 			if (capacity >= 2+MAX_SKB_FRAGS) {
 				netif_start_queue(dev);
-				vi->svq->vq_ops->disable_cb(vi->svq);
+				virtqueue_disable_cb(vi->svq);
 			}
 		}
 	}
@@ -643,7 +643,7 @@ static int virtnet_open(struct net_device *dev)
 	 * now.  virtnet_poll wants re-enable the queue, so we disable here.
 	 * We synchronize against interrupts via NAPI_STATE_SCHED */
 	if (napi_schedule_prep(&vi->napi)) {
-		vi->rvq->vq_ops->disable_cb(vi->rvq);
+		virtqueue_disable_cb(vi->rvq);
 		__napi_schedule(&vi->napi);
 	}
 	return 0;
@@ -680,15 +680,15 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 		sg_set_buf(&sg[i + 1], sg_virt(s), s->length);
 	sg_set_buf(&sg[out + in - 1], &status, sizeof(status));
 
-	BUG_ON(vi->cvq->vq_ops->add_buf(vi->cvq, sg, out, in, vi) < 0);
+	BUG_ON(virtqueue_add_buf(vi->cvq, sg, out, in, vi) < 0);
 
-	vi->cvq->vq_ops->kick(vi->cvq);
+	virtqueue_kick(vi->cvq);
 
 	/*
 	 * Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
-	while (!vi->cvq->vq_ops->get_buf(vi->cvq, &tmp))
+	while (!virtqueue_get_buf(vi->cvq, &tmp))
 		cpu_relax();
 
 	return status == VIRTIO_NET_OK;
@@ -1004,13 +1004,13 @@ static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
 	while (1) {
-		buf = vi->svq->vq_ops->detach_unused_buf(vi->svq);
+		buf = virtqueue_detach_unused_buf(vi->svq);
 		if (!buf)
 			break;
 		dev_kfree_skb(buf);
 	}
 	while (1) {
-		buf = vi->rvq->vq_ops->detach_unused_buf(vi->rvq);
+		buf = virtqueue_detach_unused_buf(vi->rvq);
 		if (!buf)
 			break;
 		if (vi->mergeable_rx_bufs || vi->big_packets)
-- 
1.7.0.2.280.gc6f05
