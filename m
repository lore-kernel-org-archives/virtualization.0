From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/6] virtio: fix tx_ stats in virtio_net
Date: Wed, 23 Apr 2008 23:56:07 -0500
Message-ID: <200804241456.07551.rusty__42789.3909313299$1209013257$gmane$org@rustcorp.com.au>
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
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


get_buf() gives the length written by the other side, which will be
zero.  We want to add the skb length.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -r 51bdbdc4f199 drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Thu Apr 10 15:55:52 2008 +1000
+++ b/drivers/net/virtio_net.c	Mon Apr 14 11:13:45 2008 +1000
@@ -221,7 +221,7 @@ static void free_old_xmit_skbs(struct vi
 	while ((skb = vi->svq->vq_ops->get_buf(vi->svq, &len)) != NULL) {
 		pr_debug("Sent skb %p\n", skb);
 		__skb_unlink(skb, &vi->send);
-		vi->dev->stats.tx_bytes += len;
+		vi->dev->stats.tx_bytes += skb->len;
 		vi->dev->stats.tx_packets++;
 		kfree_skb(skb);
 	}
