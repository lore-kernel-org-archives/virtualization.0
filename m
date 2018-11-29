From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] virtio-net: keep vnet header zeroed after processing XDP
Date: Thu, 29 Nov 2018 13:53:16 +0800
Message-ID: <20181129055316.24090-1-jasowang__10467.3381349587$1543470684$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We copy vnet header unconditionally in page_to_skb() this is wrong
since XDP may modify the packet data. So let's keep a zeroed vnet
header for not confusing the conversion between vnet header and skb
metadata.

In the future, we should able to detect whether or not the packet was
modified and keep using the vnet header when packet was not touched.

Fixes: f600b6905015 ("virtio_net: Add XDP support")
Reported-by: Pavel Popa <pashinho1990@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cecfd77c9f3c..ea672145f6a6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -365,7 +365,8 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   struct receive_queue *rq,
 				   struct page *page, unsigned int offset,
-				   unsigned int len, unsigned int truesize)
+				   unsigned int len, unsigned int truesize,
+				   bool hdr_valid)
 {
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
@@ -387,7 +388,8 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
 
-	memcpy(hdr, p, hdr_len);
+	if (hdr_valid)
+		memcpy(hdr, p, hdr_len);
 
 	len -= hdr_len;
 	offset += hdr_padded_len;
@@ -739,7 +741,8 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE);
+	struct sk_buff *skb = page_to_skb(vi, rq, page, 0, len,
+					  PAGE_SIZE, true);
 
 	stats->bytes += len - vi->hdr_len;
 	if (unlikely(!skb))
@@ -842,7 +845,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				rcu_read_unlock();
 				put_page(page);
 				head_skb = page_to_skb(vi, rq, xdp_page,
-						       offset, len, PAGE_SIZE);
+						       offset, len,
+						       PAGE_SIZE, false);
 				return head_skb;
 			}
 			break;
@@ -898,7 +902,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		goto err_skb;
 	}
 
-	head_skb = page_to_skb(vi, rq, page, offset, len, truesize);
+	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog);
 	curr_skb = head_skb;
 
 	if (unlikely(!curr_skb))
-- 
2.17.1
