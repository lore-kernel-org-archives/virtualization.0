From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v8 3/7] net: vhost: factor out busy polling logic to
	vhost_net_busy_poll()
Date: Sun, 19 Aug 2018 05:11:22 -0700
Message-ID: <1534680686-3108-4-git-send-email-xiangxia.m.yue__13302.1393944093$1534680753$gmane$org@gmail.com>
References: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Factor out generic busy polling logic and will be
used for in tx path in the next patch. And with the patch,
qemu can set differently the busyloop_timeout for rx queue.

To avoid duplicate codes, introduce the helper functions:
* sock_has_rx_data(changed from sk_has_rx_data)
* vhost_net_busy_poll_try_queue

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 111 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 40 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 32c1b52..453c061 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -440,6 +440,75 @@ static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
 	nvq->done_idx = 0;
 }
 
+static int sock_has_rx_data(struct socket *sock)
+{
+	if (unlikely(!sock))
+		return 0;
+
+	if (sock->ops->peek_len)
+		return sock->ops->peek_len(sock);
+
+	return skb_queue_empty(&sock->sk->sk_receive_queue);
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
+static void vhost_net_busy_poll(struct vhost_net *net,
+				struct vhost_virtqueue *rvq,
+				struct vhost_virtqueue *tvq,
+				bool *busyloop_intr,
+				bool poll_rx)
+{
+	unsigned long busyloop_timeout;
+	unsigned long endtime;
+	struct socket *sock;
+	struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
+
+	mutex_lock_nested(&vq->mutex, poll_rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
+	vhost_disable_notify(&net->dev, vq);
+	sock = rvq->private_data;
+
+	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
+				     tvq->busyloop_timeout;
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
+		if ((sock_has_rx_data(sock) &&
+		     !vhost_vq_avail_empty(&net->dev, rvq)) ||
+		    !vhost_vq_avail_empty(&net->dev, tvq))
+			break;
+
+		cpu_relax();
+	}
+
+	preempt_enable();
+
+	if (poll_rx)
+		vhost_net_busy_poll_try_queue(net, tvq);
+	else if (sock_has_rx_data(sock))
+		vhost_net_busy_poll_try_queue(net, rvq);
+	else /* On tx here, sock has no rx data. */
+		vhost_enable_notify(&net->dev, rvq);
+
+	mutex_unlock(&vq->mutex);
+}
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_net_virtqueue *nvq,
 				    unsigned int *out_num, unsigned int *in_num,
@@ -753,16 +822,6 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
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
@@ -770,41 +829,13 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
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
