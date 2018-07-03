From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH v2 net-next 4/4] vhost_net: Avoid rx vring kicks during
	busyloop
Date: Tue,  3 Jul 2018 16:31:34 +0900
Message-ID: <1530603094-2476-5-git-send-email-makita.toshiaki__5758.20127637616$1530603202$gmane$org@lab.ntt.co.jp>
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

We may run out of avail rx ring descriptor under heavy load but busypoll
did not detect it so busypoll may have exited prematurely. Avoid this by
checking rx ring full during busypoll.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/vhost/net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 791bc8b..b224036 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -658,6 +658,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
+	struct vhost_virtqueue *rvq = &rnvq->vq;
 	struct vhost_virtqueue *tvq = &tnvq->vq;
 	unsigned long uninitialized_var(endtime);
 	int len = peek_head_len(rnvq, sk);
@@ -677,7 +678,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 				*busyloop_intr = true;
 				break;
 			}
-			if (sk_has_rx_data(sk) ||
+			if ((sk_has_rx_data(sk) &&
+			     !vhost_vq_avail_empty(&net->dev, rvq)) ||
 			    !vhost_vq_avail_empty(&net->dev, tvq))
 				break;
 			cpu_relax();
@@ -827,7 +829,6 @@ static void handle_rx(struct vhost_net *net)
 
 	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
 						      &busyloop_intr))) {
-		busyloop_intr = false;
 		sock_len += sock_hlen;
 		vhost_len = sock_len + vhost_hlen;
 		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
@@ -838,7 +839,9 @@ static void handle_rx(struct vhost_net *net)
 			goto out;
 		/* OK, now we need to know about added descriptors. */
 		if (!headcount) {
-			if (unlikely(vhost_enable_notify(&net->dev, vq))) {
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
 				/* They have slipped one in as we were
 				 * doing that: check again. */
 				vhost_disable_notify(&net->dev, vq);
@@ -848,6 +851,7 @@ static void handle_rx(struct vhost_net *net)
 			 * they refilled. */
 			goto out;
 		}
+		busyloop_intr = false;
 		if (nvq->rx_ring)
 			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
 		/* On overrun, truncate and discard */
-- 
1.8.3.1
