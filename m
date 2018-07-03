From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net-next 1/4] vhost_net: Rename local variables in
	vhost_net_rx_peek_head_len
Date: Tue,  3 Jul 2018 16:31:31 +0900
Message-ID: <1530603094-2476-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1530603094-2476-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1530603094-2476-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

So we can easily see which variable is for which, tx or rx.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/vhost/net.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 29756d8..3939c50 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -647,39 +647,39 @@ static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 {
-	struct vhost_net_virtqueue *rvq = &net->vqs[VHOST_NET_VQ_RX];
-	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
-	struct vhost_virtqueue *vq = &nvq->vq;
+	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
+	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
+	struct vhost_virtqueue *tvq = &tnvq->vq;
 	unsigned long uninitialized_var(endtime);
-	int len = peek_head_len(rvq, sk);
+	int len = peek_head_len(rnvq, sk);
 
-	if (!len && vq->busyloop_timeout) {
+	if (!len && tvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_rx_signal_used(rvq);
+		vhost_rx_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&vq->mutex, 1);
-		vhost_disable_notify(&net->dev, vq);
+		mutex_lock_nested(&tvq->mutex, 1);
+		vhost_disable_notify(&net->dev, tvq);
 
 		preempt_disable();
-		endtime = busy_clock() + vq->busyloop_timeout;
+		endtime = busy_clock() + tvq->busyloop_timeout;
 
 		while (vhost_can_busy_poll(&net->dev, endtime) &&
 		       !sk_has_rx_data(sk) &&
-		       vhost_vq_avail_empty(&net->dev, vq))
+		       vhost_vq_avail_empty(&net->dev, tvq))
 			cpu_relax();
 
 		preempt_enable();
 
-		if (!vhost_vq_avail_empty(&net->dev, vq))
-			vhost_poll_queue(&vq->poll);
-		else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
-			vhost_disable_notify(&net->dev, vq);
-			vhost_poll_queue(&vq->poll);
+		if (!vhost_vq_avail_empty(&net->dev, tvq)) {
+			vhost_poll_queue(&tvq->poll);
+		} else if (unlikely(vhost_enable_notify(&net->dev, tvq))) {
+			vhost_disable_notify(&net->dev, tvq);
+			vhost_poll_queue(&tvq->poll);
 		}
 
-		mutex_unlock(&vq->mutex);
+		mutex_unlock(&tvq->mutex);
 
-		len = peek_head_len(rvq, sk);
+		len = peek_head_len(rnvq, sk);
 	}
 
 	return len;
-- 
1.8.3.1
