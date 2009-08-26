From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio_net: Check for room in the vq before adding buffer
Date: Wed, 26 Aug 2009 14:58:28 +0530
Message-ID: <1251278908-18601-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Saves us one cycle of alloc-add-free if the queue was full.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---

Rusty: Tested this. 256 buffers are allocated with the patch,
257 without (and one is later freed).

 drivers/net/virtio_net.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e94f817..bb54a1f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -280,7 +280,7 @@ static bool try_fill_recv_maxbufs(struct virtnet_info *vi, gfp_t gfp)
 	bool oom = false;
 
 	sg_init_table(sg, 2+MAX_SKB_FRAGS);
-	for (;;) {
+	do {
 		struct skb_vnet_hdr *hdr;
 
 		skb = netdev_alloc_skb(vi->dev, MAX_PACKET_LEN + NET_IP_ALIGN);
@@ -323,7 +323,7 @@ static bool try_fill_recv_maxbufs(struct virtnet_info *vi, gfp_t gfp)
 			break;
 		}
 		vi->num++;
-	}
+	} while (err > 0);
 	if (unlikely(vi->num > vi->max))
 		vi->max = vi->num;
 	vi->rvq->vq_ops->kick(vi->rvq);
@@ -341,7 +341,7 @@ static bool try_fill_recv(struct virtnet_info *vi, gfp_t gfp)
 	if (!vi->mergeable_rx_bufs)
 		return try_fill_recv_maxbufs(vi, gfp);
 
-	for (;;) {
+	do {
 		skb_frag_t *f;
 
 		skb = netdev_alloc_skb(vi->dev, GOOD_COPY_LEN + NET_IP_ALIGN);
@@ -375,7 +375,7 @@ static bool try_fill_recv(struct virtnet_info *vi, gfp_t gfp)
 			break;
 		}
 		vi->num++;
-	}
+	} while (err > 0);
 	if (unlikely(vi->num > vi->max))
 		vi->max = vi->num;
 	vi->rvq->vq_ops->kick(vi->rvq);
-- 
1.6.2.5
