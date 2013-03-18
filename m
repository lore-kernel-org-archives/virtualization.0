From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 14/22] virtio_net: use simplified virtqueue accessors.
Date: Mon, 18 Mar 2013 20:04:45 +1030
Message-ID: <1363599293-23065-15-git-send-email-rusty@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We never add buffers with input and output parts, so use the new accessors.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f19865a..38c01d9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -443,7 +443,7 @@ static int add_recvbuf_small(struct receive_queue *rq, gfp_t gfp)
 
 	skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
 
-	err = virtqueue_add_buf(rq->vq, rq->sg, 0, 2, skb, gfp);
+	err = virtqueue_add_inbuf(rq->vq, rq->sg, 2, skb, gfp);
 	if (err < 0)
 		dev_kfree_skb(skb);
 
@@ -488,8 +488,8 @@ static int add_recvbuf_big(struct receive_queue *rq, gfp_t gfp)
 
 	/* chain first in list head */
 	first->private = (unsigned long)list;
-	err = virtqueue_add_buf(rq->vq, rq->sg, 0, MAX_SKB_FRAGS + 2,
-				first, gfp);
+	err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
+				  first, gfp);
 	if (err < 0)
 		give_pages(rq, first);
 
@@ -507,7 +507,7 @@ static int add_recvbuf_mergeable(struct receive_queue *rq, gfp_t gfp)
 
 	sg_init_one(rq->sg, page_address(page), PAGE_SIZE);
 
-	err = virtqueue_add_buf(rq->vq, rq->sg, 0, 1, page, gfp);
+	err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, page, gfp);
 	if (err < 0)
 		give_pages(rq, page);
 
@@ -710,8 +710,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 		sg_set_buf(sq->sg, &hdr->hdr, sizeof hdr->hdr);
 
 	num_sg = skb_to_sgvec(skb, sq->sg + 1, 0, skb->len) + 1;
-	return virtqueue_add_buf(sq->vq, sq->sg, num_sg,
-				 0, skb, GFP_ATOMIC);
+	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
1.7.10.4
