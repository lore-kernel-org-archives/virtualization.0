From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2 3/4] virtio-net: correctly check num_buf during err path
Date: Tue, 22 May 2018 11:44:30 +0800
Message-ID: <1526960671-11782-4-git-send-email-jasowang__23193.0495858707$1526960676$gmane$org@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If we successfully linearize the packet, num_buf will be set to zero
which may confuse error handling path which assumes num_buf is at
least 1 and this can lead the code tries to pop the descriptor of next
buffer. Fixing this by checking num_buf against 1 before decreasing.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6260d65..326e247 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -875,7 +875,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	rcu_read_unlock();
 err_skb:
 	put_page(page);
-	while (--num_buf) {
+	while (num_buf-- > 1) {
 		buf = virtqueue_get_buf(rq->vq, &len);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
-- 
2.7.4
