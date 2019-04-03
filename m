From: Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH] virtio-net: Fix some minor formatting errors
Date: Wed,  3 Apr 2019 12:10:13 +0300
Message-ID: <20190403091013.16847-1-yuval.shaia__31022.4927075737$1555717702$gmane$org@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/net/virtio_net.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 07c1e81087b2..be1188815c72 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1587,7 +1587,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev->stats.tx_fifo_errors++;
 		if (net_ratelimit())
 			dev_warn(&dev->dev,
-				 "Unexpected TXQ (%d) queue failure: %d\n", qnum, err);
+				 "Unexpected TXQ (%d) queue failure: %d\n",
+				 qnum, err);
 		dev->stats.tx_dropped++;
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
@@ -2383,7 +2384,7 @@ static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
 				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
-		dev_warn(&vi->dev->dev, "Fail to set guest offload. \n");
+		dev_warn(&vi->dev->dev, "Fail to set guest offload.\n");
 		return -EINVAL;
 	}
 
@@ -3114,8 +3115,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 			/* Should never trigger: MTU was previously validated
 			 * in virtnet_validate.
 			 */
-			dev_err(&vdev->dev, "device MTU appears to have changed "
-				"it is now %d < %d", mtu, dev->min_mtu);
+			dev_err(&vdev->dev,
+				"device MTU appears to have changed it is now %d < %d",
+				mtu, dev->min_mtu);
 			goto free;
 		}
 
-- 
2.19.1
