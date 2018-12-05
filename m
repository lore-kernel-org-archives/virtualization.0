From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 1/2] virtio-net: bql support
Date: Wed, 5 Dec 2018 17:54:15 -0500
Message-ID: <20181205225323.12555-2-mst__17174.1081904203$1544050348$gmane$org@redhat.com>
References: <20181205225323.12555-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181205225323.12555-1-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

When use_napi is set, let's enable BQLs.  Note: some of the issues are
similar to wifi.  It's worth considering whether something similar to
commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
benefitial.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cecfd77c9f3c..b657bde6b94b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1325,7 +1325,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq)
+static void free_old_xmit_skbs(struct send_queue *sq, struct netdev_queue *txq,
+			       bool use_napi)
 {
 	struct sk_buff *skb;
 	unsigned int len;
@@ -1347,6 +1348,9 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 	if (!packets)
 		return;
 
+	if (use_napi)
+		netdev_tx_completed_queue(txq, packets, bytes);
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
@@ -1364,7 +1368,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq);
+		free_old_xmit_skbs(sq, txq, true);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1440,7 +1444,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
 
 	__netif_tx_lock(txq, raw_smp_processor_id());
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, txq, true);
 	__netif_tx_unlock(txq);
 
 	virtqueue_napi_complete(napi, sq->vq, 0);
@@ -1505,13 +1509,15 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct send_queue *sq = &vi->sq[qnum];
 	int err;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
-	bool kick = !skb->xmit_more;
+	bool more = skb->xmit_more;
 	bool use_napi = sq->napi.weight;
+	unsigned int bytes = skb->len;
+	bool kick;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, txq, use_napi);
 
-	if (use_napi && kick)
+	if (use_napi && !more)
 		virtqueue_enable_cb_delayed(sq->vq);
 
 	/* timestamp packet in software */
@@ -1552,7 +1558,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq);
+			free_old_xmit_skbs(sq, txq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
@@ -1560,7 +1566,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	if (kick || netif_xmit_stopped(txq)) {
+	if (use_napi)
+		kick = __netdev_tx_sent_queue(txq, bytes, more);
+	else
+		kick = !more || netif_xmit_stopped(txq);
+
+	if (kick) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
 			sq->stats.kicks++;
-- 
MST
