From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net 4/7] virtio_net: Fix out of bounds access of sq
Date: Tue, 29 Jan 2019 09:45:56 +0900
Message-ID: <1548722759-2470-5-git-send-email-makita.toshiaki__39460.6924893864$1548742691$gmane$org@lab.ntt.co.jp>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When XDP is disabled, curr_queue_pairs + smp_processor_id() can be
larger than max_queue_pairs.
There is no guarantee that we have enough XDP send queues dedicated for
each cpu when XDP is disabled, so do not count drops on sq in that case.

Fixes: 5b8f3c8d30a6 ("virtio_net: Add XDP related stats")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0e1a369..669b65c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -491,20 +491,17 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	int ret, err;
 	int i;
 
-	sq = virtnet_xdp_sq(vi);
-
-	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
-		ret = -EINVAL;
-		drops = n;
-		goto out;
-	}
-
 	/* Only allow ndo_xdp_xmit if XDP is loaded on dev, as this
 	 * indicate XDP resources have been successfully allocated.
 	 */
 	xdp_prog = rcu_dereference(rq->xdp_prog);
-	if (!xdp_prog) {
-		ret = -ENXIO;
+	if (!xdp_prog)
+		return -ENXIO;
+
+	sq = virtnet_xdp_sq(vi);
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
+		ret = -EINVAL;
 		drops = n;
 		goto out;
 	}
-- 
1.8.3.1
