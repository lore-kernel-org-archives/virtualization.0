From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v5 3/4] net: vhost: factor out busy polling logic to
	vhost_net_busy_poll()
Date: Tue,  3 Jul 2018 21:31:37 -0700
Message-ID: <1530678698-33427-4-git-send-email-xiangxia.m.yue__32109.3210405254$1530678762$gmane$org@gmail.com>
References: <1530678698-33427-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1530678698-33427-1-git-send-email-xiangxia.m.yue@gmail.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Tonghao Zhang <zhangtonghao@didichuxing.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Factor out generic busy polling logic and will be
used for in tx path in the next patch. And with the patch,
qemu can set differently the busyloop_timeout for rx queue.

Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
---
 drivers/vhost/net.c | 94 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 62bb8e8..2790959 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -429,6 +429,52 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 	return vhost_poll_start(poll, sock->file);
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
+static void vhost_net_busy_poll(struct vhost_net *net,
+				struct vhost_virtqueue *rvq,
+				struct vhost_virtqueue *tvq,
+				bool rx)
+{
+	unsigned long uninitialized_var(endtime);
+	unsigned long busyloop_timeout;
+	struct socket *sock;
+	struct vhost_virtqueue *vq = rx ? tvq : rvq;
+
+	mutex_lock_nested(&vq->mutex, rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
+
+	vhost_disable_notify(&net->dev, vq);
+	sock = rvq->private_data;
+	busyloop_timeout = rx ? rvq->busyloop_timeout : tvq->busyloop_timeout;
+
+	preempt_disable();
+	endtime = busy_clock() + busyloop_timeout;
+	while (vhost_can_busy_poll(tvq->dev, endtime) &&
+	       !(sock && sk_has_rx_data(sock->sk)) &&
+	       vhost_vq_avail_empty(tvq->dev, tvq))
+		cpu_relax();
+	preempt_enable();
+
+	if ((rx && !vhost_vq_avail_empty(&net->dev, vq)) ||
+	    (!rx && (sock && sk_has_rx_data(sock->sk)))) {
+		vhost_poll_queue(&vq->poll);
+	} else if (vhost_enable_notify(&net->dev, vq) && rx) {
+		vhost_disable_notify(&net->dev, vq);
+		vhost_poll_queue(&vq->poll);
+	}
+
+	mutex_unlock(&vq->mutex);
+}
+
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
 				    struct iovec iov[], unsigned int iov_size,
@@ -621,16 +667,6 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
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
 static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
@@ -645,39 +681,19 @@ static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 {
-	struct vhost_net_virtqueue *rvq = &net->vqs[VHOST_NET_VQ_RX];
-	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
-	struct vhost_virtqueue *vq = &nvq->vq;
-	unsigned long uninitialized_var(endtime);
-	int len = peek_head_len(rvq, sk);
+	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
+	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
 
-	if (!len && vq->busyloop_timeout) {
-		/* Flush batched heads first */
-		vhost_rx_signal_used(rvq);
-		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
-		vhost_disable_notify(&net->dev, vq);
+	int len = peek_head_len(rnvq, sk);
 
-		preempt_disable();
-		endtime = busy_clock() + vq->busyloop_timeout;
-
-		while (vhost_can_busy_poll(&net->dev, endtime) &&
-		       !sk_has_rx_data(sk) &&
-		       vhost_vq_avail_empty(&net->dev, vq))
-			cpu_relax();
-
-		preempt_enable();
-
-		if (!vhost_vq_avail_empty(&net->dev, vq))
-			vhost_poll_queue(&vq->poll);
-		else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
-			vhost_disable_notify(&net->dev, vq);
-			vhost_poll_queue(&vq->poll);
-		}
+	if (!len && rnvq->vq.busyloop_timeout) {
+		/* Flush batched heads first */
+		vhost_rx_signal_used(rnvq);
 
-		mutex_unlock(&vq->mutex);
+		/* Both tx vq and rx socket were polled here */
+		vhost_net_busy_poll(net, &rnvq->vq, &tnvq->vq, true);
 
-		len = peek_head_len(rvq, sk);
+		len = peek_head_len(rnvq, sk);
 	}
 
 	return len;
-- 
1.8.3.1
