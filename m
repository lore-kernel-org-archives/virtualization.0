From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v7 3/4] net: vhost: factor out busy polling logic to
	vhost_net_busy_poll()
Date: Tue, 31 Jul 2018 20:00:53 -0700
Message-ID: <1533092454-37196-4-git-send-email-xiangxia.m.yue__34481.3433745459$1533092481$gmane$org@gmail.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Factor out generic busy polling logic and will be
used for in tx path in the next patch. And with the patch,
qemu can set differently the busyloop_timeout for rx queue.

In the handle_tx, the busypoll will vhost_net_disable/enable_vq
because we have poll the sock. This can improve performance.
[This is suggested by Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>]

And when the sock receive skb, we should queue the poll if necessary.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 131 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 40 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 32c1b52..5b45463 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -440,6 +440,95 @@ static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
 	nvq->done_idx = 0;
 }
 
+static int sk_has_rx_data(struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+
+	if (sock->ops->peek_len)
+		return sock->ops->peek_len(sock);
+
+	return skb_queue_empty(&sk->sk_receive_queue);
+}
+
+static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
+					  struct vhost_virtqueue *vq)
+{
+	if (!vhost_vq_avail_empty(&net->dev, vq)) {
+		vhost_poll_queue(&vq->poll);
+	} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
+		vhost_disable_notify(&net->dev, vq);
+		vhost_poll_queue(&vq->poll);
+	}
+}
+
+static void vhost_net_busy_poll_check(struct vhost_net *net,
+				      struct vhost_virtqueue *rvq,
+				      struct vhost_virtqueue *tvq,
+				      bool rx)
+{
+	struct socket *sock = rvq->private_data;
+
+	if (rx)
+		vhost_net_busy_poll_try_queue(net, tvq);
+	else if (sock && sk_has_rx_data(sock->sk))
+		vhost_net_busy_poll_try_queue(net, rvq);
+	else {
+		/* On tx here, sock has no rx data, so we
+		 * will wait for sock wakeup for rx, and
+		 * vhost_enable_notify() is not needed. */
+	}
+}
+
+static void vhost_net_busy_poll(struct vhost_net *net,
+				struct vhost_virtqueue *rvq,
+				struct vhost_virtqueue *tvq,
+				bool *busyloop_intr,
+				bool rx)
+{
+	unsigned long busyloop_timeout;
+	unsigned long endtime;
+	struct socket *sock;
+	struct vhost_virtqueue *vq = rx ? tvq : rvq;
+
+	mutex_lock_nested(&vq->mutex, rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
+	vhost_disable_notify(&net->dev, vq);
+	sock = rvq->private_data;
+
+	busyloop_timeout = rx ? rvq->busyloop_timeout:
+				tvq->busyloop_timeout;
+
+
+	/* Busypoll the sock, so don't need rx wakeups during it. */
+	if (!rx)
+		vhost_net_disable_vq(net, vq);
+
+	preempt_disable();
+	endtime = busy_clock() + busyloop_timeout;
+
+	while (vhost_can_busy_poll(endtime)) {
+		if (vhost_has_work(&net->dev)) {
+			*busyloop_intr = true;
+			break;
+		}
+
+		if ((sock && sk_has_rx_data(sock->sk) &&
+		     !vhost_vq_avail_empty(&net->dev, rvq)) ||
+		    !vhost_vq_avail_empty(&net->dev, tvq))
+			break;
+
+		cpu_relax();
+	}
+
+	preempt_enable();
+
+	if (!rx)
+		vhost_net_enable_vq(net, vq);
+
+	vhost_net_busy_poll_check(net, rvq, tvq, rx);
+
+	mutex_unlock(&vq->mutex);
+}
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_net_virtqueue *nvq,
 				    unsigned int *out_num, unsigned int *in_num,
@@ -753,16 +842,6 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 	return len;
 }
 
-static int sk_has_rx_data(struct sock *sk)
-{
-	struct socket *sock = sk->sk_socket;
-
-	if (sock->ops->peek_len)
-		return sock->ops->peek_len(sock);
-
-	return skb_queue_empty(&sk->sk_receive_queue);
-}
-
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 				      bool *busyloop_intr)
 {
@@ -770,41 +849,13 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
 	struct vhost_virtqueue *rvq = &rnvq->vq;
 	struct vhost_virtqueue *tvq = &tnvq->vq;
-	unsigned long uninitialized_var(endtime);
 	int len = peek_head_len(rnvq, sk);
 
-	if (!len && tvq->busyloop_timeout) {
+	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
 		vhost_net_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&tvq->mutex, VHOST_NET_VQ_TX);
-		vhost_disable_notify(&net->dev, tvq);
-
-		preempt_disable();
-		endtime = busy_clock() + tvq->busyloop_timeout;
-
-		while (vhost_can_busy_poll(endtime)) {
-			if (vhost_has_work(&net->dev)) {
-				*busyloop_intr = true;
-				break;
-			}
-			if ((sk_has_rx_data(sk) &&
-			     !vhost_vq_avail_empty(&net->dev, rvq)) ||
-			    !vhost_vq_avail_empty(&net->dev, tvq))
-				break;
-			cpu_relax();
-		}
-
-		preempt_enable();
-
-		if (!vhost_vq_avail_empty(&net->dev, tvq)) {
-			vhost_poll_queue(&tvq->poll);
-		} else if (unlikely(vhost_enable_notify(&net->dev, tvq))) {
-			vhost_disable_notify(&net->dev, tvq);
-			vhost_poll_queue(&tvq->poll);
-		}
-
-		mutex_unlock(&tvq->mutex);
+		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
 
 		len = peek_head_len(rnvq, sk);
 	}
-- 
1.8.3.1
