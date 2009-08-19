From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 2/2] virtio_net: Use can_add_buf to test for enough room to
	add
Date: Wed, 19 Aug 2009 13:55:24 +0530
Message-ID: <1250670324-8426-2-git-send-email-amit.shah@redhat.com>
References: <1250670324-8426-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1250670324-8426-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use the can_add_buf virtqueue operation to test if
there's room to add another buf to the queue.

Saves us one cycle of alloc-add-free if the queue
was full.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
v2:
  convert usage in try_fill_recv() as well

 drivers/net/virtio_net.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a6e81d..a93ca07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -280,7 +280,7 @@ static void try_fill_recv_maxbufs(struct virtnet_info *vi)
 	int num, err, i;
 
 	sg_init_table(sg, 2+MAX_SKB_FRAGS);
-	for (;;) {
+	while (vi->rvq->vq_ops->can_add_buf(vi->rvq)) {
 		struct virtio_net_hdr *hdr;
 
 		skb = netdev_alloc_skb(vi->dev, MAX_PACKET_LEN + NET_IP_ALIGN);
@@ -338,7 +338,7 @@ static void try_fill_recv(struct virtnet_info *vi)
 		return;
 	}
 
-	for (;;) {
+	while (vi->rvq->vq_ops->can_add_buf(vi->rvq)) {
 		skb_frag_t *f;
 
 		skb = netdev_alloc_skb(vi->dev, GOOD_COPY_LEN + NET_IP_ALIGN);
-- 
1.6.2.5
