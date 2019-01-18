From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] virtio_net: bulk free tx skbs
Date: Thu, 17 Jan 2019 23:20:07 -0500
Message-ID: <20190118041842.24067-1-mst__41336.8453308523$1547811650$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
safe to call in a non-napi context as long as the napi_budget flag is
correct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
	rebase on master.

lightly tested on developer's box.

 drivers/net/virtio_net.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 023725086046..8fadd8eaf601 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1330,7 +1330,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq)
+static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
 	struct sk_buff *skb;
 	unsigned int len;
@@ -1343,7 +1343,7 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 		bytes += skb->len;
 		packets++;
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, in_napi);
 	}
 
 	/* Avoid overhead when no packets have been processed
@@ -1369,7 +1369,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq);
+		free_old_xmit_skbs(sq, true);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1445,7 +1445,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
 
 	__netif_tx_lock(txq, raw_smp_processor_id());
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, true);
 	__netif_tx_unlock(txq);
 
 	virtqueue_napi_complete(napi, sq->vq, 0);
@@ -1514,7 +1514,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, false);
 
 	if (use_napi && kick)
 		virtqueue_enable_cb_delayed(sq->vq);
@@ -1557,7 +1557,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq);
+			free_old_xmit_skbs(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
-- 
MST
