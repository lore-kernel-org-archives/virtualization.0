From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net-next 3/4] vhost_net: Avoid rx queue wake-ups during
	busypoll
Date: Tue,  3 Jul 2018 16:31:33 +0900
Message-ID: <1530603094-2476-4-git-send-email-makita.toshiaki__46290.6638895676$1530603141$gmane$org@lab.ntt.co.jp>
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

We may run handle_rx() while rx work is queued. For example a packet can
push the rx work during the window before handle_rx calls
vhost_net_disable_vq().
In that case busypoll immediately exits due to vhost_has_work()
condition and enables vq again. This can lead to another unnecessary rx
wake-ups, so poll rx work instead of enabling the vq.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/vhost/net.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 811c0e5..791bc8b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -653,7 +653,8 @@ static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
 	nvq->done_idx = 0;
 }
 
-static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
+static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
+				      bool *busyloop_intr)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -671,11 +672,16 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 		preempt_disable();
 		endtime = busy_clock() + tvq->busyloop_timeout;
 
-		while (vhost_can_busy_poll(endtime) &&
-		       !vhost_has_work(&net->dev) &&
-		       !sk_has_rx_data(sk) &&
-		       vhost_vq_avail_empty(&net->dev, tvq))
+		while (vhost_can_busy_poll(endtime)) {
+			if (vhost_has_work(&net->dev)) {
+				*busyloop_intr = true;
+				break;
+			}
+			if (sk_has_rx_data(sk) ||
+			    !vhost_vq_avail_empty(&net->dev, tvq))
+				break;
 			cpu_relax();
+		}
 
 		preempt_enable();
 
@@ -795,6 +801,7 @@ static void handle_rx(struct vhost_net *net)
 	s16 headcount;
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
+	bool busyloop_intr = false;
 	struct socket *sock;
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
@@ -818,7 +825,9 @@ static void handle_rx(struct vhost_net *net)
 		vq->log : NULL;
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
 
-	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk))) {
+	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
+						      &busyloop_intr))) {
+		busyloop_intr = false;
 		sock_len += sock_hlen;
 		vhost_len = sock_len + vhost_hlen;
 		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
@@ -905,7 +914,10 @@ static void handle_rx(struct vhost_net *net)
 			goto out;
 		}
 	}
-	vhost_net_enable_vq(net, vq);
+	if (unlikely(busyloop_intr))
+		vhost_poll_queue(&vq->poll);
+	else
+		vhost_net_enable_vq(net, vq);
 out:
 	vhost_rx_signal_used(nvq);
 	mutex_unlock(&vq->mutex);
-- 
1.8.3.1
