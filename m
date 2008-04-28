From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/4] virtio: wean net driver off NETDEV_TX_BUSY
Date: Tue, 29 Apr 2008 01:16:05 +1000
Message-ID: <200804290116.05951.rusty__23558.1903056756$1209396337$gmane$org@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

Herbert tells me that returning NETDEV_TX_BUSY from hard_start_xmit is
seen as a poor thing to do; we should cache the packet and stop the queue.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   58 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff -r 26ba2dd67f46 drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Tue Apr 22 13:03:07 2008 +1000
+++ b/drivers/net/virtio_net.c	Thu Apr 24 12:05:24 2008 +1000
@@ -40,6 +40,9 @@ struct virtnet_info
 	struct virtqueue *rvq, *svq;
 	struct net_device *dev;
 	struct napi_struct napi;
+
+	/* The skb we couldn't send because buffers were full. */
+	struct sk_buff *last_xmit_skb;
 
 	/* Number of input buffers, and max we've ever had. */
 	unsigned int num, max;
@@ -227,17 +230,16 @@ static void free_old_xmit_skbs(struct vi
 	}
 }
 
-static int start_xmit(struct sk_buff *skb, struct net_device *dev)
+static int xmit_skb(struct virtnet_info *vi, struct sk_buff *skb)
 {
-	struct virtnet_info *vi = netdev_priv(dev);
-	int num, err;
+	int num;
 	struct scatterlist sg[2+MAX_SKB_FRAGS];
 	struct virtio_net_hdr *hdr;
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 
 	sg_init_table(sg, 2+MAX_SKB_FRAGS);
 
-	pr_debug("%s: xmit %p " MAC_FMT "\n", dev->name, skb,
+	pr_debug("%s: xmit %p " MAC_FMT "\n", vi->dev->name, skb,
 		 dest[0], dest[1], dest[2],
 		 dest[3], dest[4], dest[5]);
 
@@ -272,30 +274,50 @@ static int start_xmit(struct sk_buff *sk
 
 	vnet_hdr_to_sg(sg, skb);
 	num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
-	__skb_queue_head(&vi->send, skb);
+
+	return vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);
+}
+
+static int start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
 
 again:
 	/* Free up any pending old buffers before queueing new ones. */
 	free_old_xmit_skbs(vi);
-	err = vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);
-	if (err) {
-		pr_debug("%s: virtio not prepared to send\n", dev->name);
-		netif_stop_queue(dev);
 
-		/* Activate callback for using skbs: if this returns false it
-		 * means some were used in the meantime. */
-		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
-			vi->svq->vq_ops->disable_cb(vi->svq);
-			netif_start_queue(dev);
-			goto again;
+	/* If we has a buffer left over from last time, send it now. */
+	if (vi->last_xmit_skb) {
+		if (xmit_skb(vi, vi->last_xmit_skb) != 0) {
+			/* Drop this skb: we only queue one. */
+			kfree_skb(skb);
+			goto stop_queue;
 		}
-		__skb_unlink(skb, &vi->send);
+		vi->last_xmit_skb = NULL;
+	}
 
-		return NETDEV_TX_BUSY;
+	/* Put new one in send queue and do transmit */
+	__skb_queue_head(&vi->send, skb);
+	if (xmit_skb(vi, skb) != 0) {
+		vi->last_xmit_skb = skb;
+		goto stop_queue;
 	}
+done:
 	vi->svq->vq_ops->kick(vi->svq);
+	return NETDEV_TX_OK;
 
-	return 0;
+stop_queue:
+	pr_debug("%s: virtio not prepared to send\n", dev->name);
+	netif_stop_queue(dev);
+
+	/* Activate callback for using skbs: if this returns false it
+	 * means some were used in the meantime. */
+	if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
+		vi->svq->vq_ops->disable_cb(vi->svq);
+		netif_start_queue(dev);
+		goto again;
+	}
+	goto done;
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
