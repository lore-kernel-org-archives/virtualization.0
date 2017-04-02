From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 3/3] virtio-net: clean tx descriptors from rx napi
Date: Sun,  2 Apr 2017 16:10:12 -0400
Message-ID: <20170402201012.76473-4-willemdebruijn.kernel__41456.0242127211$1493076920$gmane$org@gmail.com>
References: <20170402201012.76473-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170402201012.76473-1-willemdebruijn.kernel@gmail.com>
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
 drivers/net/virtio_net.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 95d938e82080..af830eb212bf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1030,12 +1030,34 @@ static int virtnet_receive(struct receive_queue *rq, int budget)
 	return received;
 }
 
+static void free_old_xmit_skbs(struct send_queue *sq);
+
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
+	__netif_tx_lock(txq, smp_processor_id());
+	free_old_xmit_skbs(sq);
+	__netif_tx_unlock(txq);
+
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		netif_wake_subqueue(vi->dev, vq2txq(sq->vq));
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
2.12.2.564.g063fe858b8-goog
