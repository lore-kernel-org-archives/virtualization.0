From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next] virtio-net: avoid unnecessary sg initialzation
Date: Thu, 27 Aug 2015 14:53:06 +0800
Message-ID: <1440658386-9544-1-git-send-email-jasowang__15529.8832491555$1440658424$gmane$org@redhat.com>
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
To: mst@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Usually an skb does not have up to MAX_SKB_FRAGS frags. So no need to
initialize the unuse part of sg. This patch initialize the sg based on
the real number it will used:

- during xmit, it could be inferred from nr_frags and can_push.
- for small receive buffer, it will also be 2.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 53f5660..c006ae4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -540,7 +540,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	skb_put(skb, GOOD_PACKET_LEN);
 
 	hdr = skb_vnet_hdr(skb);
-	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
+	sg_init_table(rq->sg, 2);
 	sg_set_buf(rq->sg, hdr, vi->hdr_len);
 	skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
 
@@ -893,7 +893,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	if (vi->mergeable_rx_bufs)
 		hdr->num_buffers = 0;
 
-	sg_init_table(sq->sg, MAX_SKB_FRAGS + 2);
+	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
 		__skb_push(skb, hdr_len);
 		num_sg = skb_to_sgvec(skb, sq->sg, 0, skb->len);
-- 
2.1.4
