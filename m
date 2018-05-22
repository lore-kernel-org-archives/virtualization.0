From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2 4/4] virtio-net: fix leaking page for gso packet during
	mergeable XDP
Date: Tue, 22 May 2018 11:44:31 +0800
Message-ID: <1526960671-11782-5-git-send-email-jasowang__44251.1177192957$1526960737$gmane$org@redhat.com>
References: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We need to drop refcnt to xdp_page if we see a gso packet. Otherwise
it will be leaked. Fixing this by moving the check of gso packet above
the linearizing logic. While at it, remove useless comment as well.

Cc: John Fastabend <john.fastabend@gmail.com>
Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 326e247..032e1ac 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -707,6 +707,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		void *data;
 		u32 act;
 
+		/* Transient failure which in theory could occur if
+		 * in-flight packets from before XDP was enabled reach
+		 * the receive path after XDP is loaded.
+		 */
+		if (unlikely(hdr->hdr.gso_type))
+			goto err_xdp;
+
 		/* This happens when rx buffer size is underestimated
 		 * or headroom is not enough because of the buffer
 		 * was refilled before XDP is set. This should only
@@ -727,14 +734,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			xdp_page = page;
 		}
 
-		/* Transient failure which in theory could occur if
-		 * in-flight packets from before XDP was enabled reach
-		 * the receive path after XDP is loaded. In practice I
-		 * was not able to create this condition.
-		 */
-		if (unlikely(hdr->hdr.gso_type))
-			goto err_xdp;
-
 		/* Allow consuming headroom but reserve enough space to push
 		 * the descriptor on if we get an XDP_TX return code.
 		 */
-- 
2.7.4
