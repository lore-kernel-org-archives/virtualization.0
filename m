From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH net] virtio_net: Account for tx bytes and packets on sending
	xdp_frames
Date: Thu, 31 Jan 2019 20:40:30 +0900
Message-ID: <1548934830-2389-1-git-send-email-makita.toshiaki__30451.7165802949$1548967560$gmane$org@lab.ntt.co.jp>
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
To: "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Previously virtnet_xdp_xmit() did not account for device tx counters,
which caused confusions.
To be consistent with SKBs, account them on freeing xdp_frames.

Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/virtio_net.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2594481..4cfceb7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -503,6 +503,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
 	unsigned int len;
+	int packets = 0;
+	int bytes = 0;
 	int drops = 0;
 	int kicks = 0;
 	int ret, err;
@@ -526,10 +528,18 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 
 	/* Free up any pending old buffers before queueing new ones. */
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (likely(is_xdp_frame(ptr)))
-			xdp_return_frame(ptr_to_xdp(ptr));
-		else
-			napi_consume_skb(ptr, false);
+		if (likely(is_xdp_frame(ptr))) {
+			struct xdp_frame *frame = ptr_to_xdp(ptr);
+
+			bytes += frame->len;
+			xdp_return_frame(frame);
+		} else {
+			struct sk_buff *skb = ptr;
+
+			bytes += skb->len;
+			napi_consume_skb(skb, false);
+		}
+		packets++;
 	}
 
 	for (i = 0; i < n; i++) {
@@ -549,6 +559,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 out:
 	u64_stats_update_begin(&sq->stats.syncp);
+	sq->stats.bytes += bytes;
+	sq->stats.packets += packets;
 	sq->stats.xdp_tx += n;
 	sq->stats.xdp_tx_drops += drops;
 	sq->stats.kicks += kicks;
-- 
1.8.3.1
