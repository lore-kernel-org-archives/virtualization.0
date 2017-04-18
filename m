From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v2 4/5] virtio-net: clean tx descriptors from rx napi
Date: Tue, 18 Apr 2017 16:21:07 -0400
Message-ID: <20170418202108.61920-5-willemdebruijn.kernel__12185.3419965648$1493077045$gmane$org@gmail.com>
References: <20170418202108.61920-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170418202108.61920-1-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, virtualization@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Willem de Bruijn <willemb@google.com>

Amortize the cost of virtual interrupts by doing both rx and tx work
on reception of a receive interrupt if tx napi is enabled. With
VIRTIO_F_EVENT_IDX, this suppresses most explicit tx completion
interrupts for bidirectional workloads.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/virtio_net.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 81a98de864e6..b14c82ce0032 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1072,12 +1072,33 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 	u64_stats_update_end(&stats->tx_syncp);
 }
 
+static void virtnet_poll_cleantx(struct receive_queue *rq)
+{
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	unsigned int index = vq2rxq(rq->vq);
+	struct send_queue *sq = &vi->sq[index];
+	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
+
+	if (!sq->napi.weight)
+		return;
+
+	if (__netif_tx_trylock(txq)) {
+		free_old_xmit_skbs(sq);
+		__netif_tx_unlock(txq);
+	}
+
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		netif_tx_wake_queue(txq);
+}
+
 static int virtnet_poll(struct napi_struct *napi, int budget)
 {
 	struct receive_queue *rq =
 		container_of(napi, struct receive_queue, napi);
 	unsigned int received;
 
+	virtnet_poll_cleantx(rq);
+
 	received = virtnet_receive(rq, budget);
 
 	/* Out of packets? */
-- 
2.12.2.816.g2cccc81164-goog
