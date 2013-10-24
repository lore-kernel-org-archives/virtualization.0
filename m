From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 3/9] virtio_net: verify if virtqueue_kick() succeeded
Date: Thu, 24 Oct 2013 17:23:14 +0200
Message-ID: <1382628200-42956-4-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Verify if a host kick succeeded by checking return value of virtqueue_kick().

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/net/virtio_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ab2e5d0..6584e3a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -542,7 +542,8 @@ static bool try_fill_recv(struct receive_queue *rq, gfp_t gfp)
 	} while (rq->vq->num_free);
 	if (unlikely(rq->num > rq->max))
 		rq->max = rq->num;
-	virtqueue_kick(rq->vq);
+	if (unlikely(!virtqueue_kick(rq->vq)))
+		return false;
 	return !oom;
 }
 
@@ -728,7 +729,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	err = xmit_skb(sq, skb);
 
 	/* This should not happen! */
-	if (unlikely(err)) {
+	if (unlikely(err) || unlikely(!virtqueue_kick(sq->vq))) {
 		dev->stats.tx_fifo_errors++;
 		if (net_ratelimit())
 			dev_warn(&dev->dev,
@@ -737,7 +738,6 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
-	virtqueue_kick(sq->vq);
 
 	/* Don't wait up for transmitted skbs to be freed. */
 	skb_orphan(skb);
@@ -796,7 +796,8 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	BUG_ON(virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC)
 	       < 0);
 
-	virtqueue_kick(vi->cvq);
+	if (unlikely(!virtqueue_kick(vi->cvq)))
+		return status == VIRTIO_NET_OK;
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
-- 
1.8.3.1
