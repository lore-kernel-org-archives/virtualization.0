From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net 2/7] virtio_net: Don't call free_old_xmit_skbs for
	xdp_frames
Date: Tue, 29 Jan 2019 09:45:54 +0900
Message-ID: <1548722759-2470-3-git-send-email-makita.toshiaki__8165.76310187287$1548742661$gmane$org@lab.ntt.co.jp>
References: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When napi_tx is enabled, virtnet_poll_cleantx() called
free_old_xmit_skbs() even for xdp send queue.
This is bogus since the queue has xdp_frames, not sk_buffs, thus mangled
device tx bytes counters because skb->len is meaningless value, and even
triggered oops due to general protection fault on freeing them.

Since xdp send queues do not aquire locks, old xdp_frames should be
freed only in virtnet_xdp_xmit(), so just skip free_old_xmit_skbs() for
xdp send queues.

Similarly virtnet_poll_tx() called free_old_xmit_skbs(). This NAPI
handler is called even without calling start_xmit() because cb for tx is
by default enabled. Once the handler is called, it enabled the cb again,
and then the handler would be called again. We don't need this handler
for XDP, so don't enable cb as well as not calling free_old_xmit_skbs().

Also, we need to disable tx NAPI when disabling XDP, so
virtnet_poll_tx() can safely access curr_queue_pairs and
xdp_queue_pairs, which are not atomically updated while disabling XDP.

Fixes: b92f1e6751a6 ("virtio-net: transmit napi")
Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 49 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e4c5d4..046f955 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1358,6 +1358,16 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
+static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
+{
+	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
+		return false;
+	else if (q < vi->curr_queue_pairs)
+		return true;
+	else
+		return false;
+}
+
 static void virtnet_poll_cleantx(struct receive_queue *rq)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
@@ -1365,7 +1375,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	struct send_queue *sq = &vi->sq[index];
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
 
-	if (!sq->napi.weight)
+	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
 		return;
 
 	if (__netif_tx_trylock(txq)) {
@@ -1442,8 +1452,16 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct send_queue *sq = container_of(napi, struct send_queue, napi);
 	struct virtnet_info *vi = sq->vq->vdev->priv;
-	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
+	unsigned int index = vq2txq(sq->vq);
+	struct netdev_queue *txq;
 
+	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
+		/* We don't need to enable cb for XDP */
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
+	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	free_old_xmit_skbs(sq, true);
 	__netif_tx_unlock(txq);
@@ -2402,9 +2420,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	}
 
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
-	if (netif_running(dev))
-		for (i = 0; i < vi->max_queue_pairs; i++)
+	if (netif_running(dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
 			napi_disable(&vi->rq[i].napi);
+			virtnet_napi_tx_disable(&vi->sq[i].napi);
+		}
+	}
 
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
@@ -2423,16 +2444,22 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		if (netif_running(dev))
+		if (netif_running(dev)) {
 			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
+					       &vi->sq[i].napi);
+		}
 	}
 
 	return 0;
 
 err:
 	if (netif_running(dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++)
+		for (i = 0; i < vi->max_queue_pairs; i++) {
 			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
+					       &vi->sq[i].napi);
+		}
 	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
@@ -2615,16 +2642,6 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
-static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
-{
-	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
-		return false;
-	else if (q < vi->curr_queue_pairs)
-		return true;
-	else
-		return false;
-}
-
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
-- 
1.8.3.1
