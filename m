From: Paolo Abeni <pabeni@redhat.com>
Subject: [net-next v2] virtio_net: replace netdev_alloc_skb_ip_align() with
	napi_alloc_skb()
Date: Fri, 18 Mar 2016 16:42:48 +0100
Message-ID: <98c94ca899603eb4212c44aa1a658825198ed49a.1458290241.git.pabeni__2757.21449074826$1458315804$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Hannes Frederic Sowa <hannes@stressinduktion.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This gives small but noticeable rx performance improvement (2-3%)
and will allow exploiting future napi improvement.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

--
 v2: replace also netdev_alloc_skb_ip_align() invocation in
	add_recvbuf_small(), suggested by Venkatesh Srinivas
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fb0eae4..100e039 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -260,7 +260,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	p = page_address(page) + offset;
 
 	/* copy small packet so we can reuse these pages for small data */
-	skb = netdev_alloc_skb_ip_align(vi->dev, GOOD_COPY_LEN);
+	skb = napi_alloc_skb(&rq->napi, GOOD_COPY_LEN);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -541,7 +541,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	int err;
 
-	skb = __netdev_alloc_skb_ip_align(vi->dev, GOOD_PACKET_LEN, gfp);
+	skb = __napi_alloc_skb(&rq->napi, GOOD_PACKET_LEN, gfp);
 	if (unlikely(!skb))
 		return -ENOMEM;
 
-- 
1.8.3.1
