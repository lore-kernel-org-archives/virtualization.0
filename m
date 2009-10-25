From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-net: fix data corruption with OOM
Date: Sun, 25 Oct 2009 19:03:40 +0200
Message-ID: <20091025170340.GA22099__39769.8599765592$1256490423$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

virtio net used to unlink skbs from send queues on error,
but ever since 48925e372f04f5e35fec6269127c62b2c71ab794
we do not do this. This causes guest data corruption and crashes
with vhost since net core can requeue the skb or free it without
it being taken off the list.

This patch fixes this by queueing the skb after successfull
transmit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Rusty, here's a fix for another data corrupter I saw.
This fixes a regression from 2.6.31, so definitely
2.6.32 I think. Comments?

 drivers/net/virtio_net.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8d00976..be459e1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -517,8 +517,7 @@ again:
 	/* Free up any pending old buffers before queueing new ones. */
 	free_old_xmit_skbs(vi);
 
-	/* Put new one in send queue and do transmit */
-	__skb_queue_head(&vi->send, skb);
+	/* Try to transmit */
 	capacity = xmit_skb(vi, skb);
 
 	/* This can happen with OOM and indirect buffers. */
@@ -532,8 +531,11 @@ again:
 		}
 		return NETDEV_TX_BUSY;
 	}
-
 	vi->svq->vq_ops->kick(vi->svq);
+
+	/* Put new one in send queue */
+	__skb_queue_head(&vi->send, skb);
+
 	/* Don't wait up for transmitted skbs to be freed. */
 	skb_orphan(skb);
 	nf_reset(skb);
-- 
1.6.5.rc2
