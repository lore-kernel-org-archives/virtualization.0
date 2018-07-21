From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v6 3/4] net: vhost: factor out busy polling logic to
	vhost_net_busy_poll()
Date: Sat, 21 Jul 2018 11:04:01 -0700
Message-ID: <1532196242-2998-4-git-send-email-xiangxia.m.yue__35458.2192180262$1532196379$gmane$org@gmail.com>
References: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
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

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c | 114 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 74 insertions(+), 40 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 321264c..2dc937e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -428,6 +428,78 @@ static int vhost_net_enable_vq(struct vhost_net *n,
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
+static void vhost_net_busy_poll_vq_check(struct vhost_net *net,
+					 struct vhost_virtqueue *rvq,
+					 struct vhost_virtqueue *tvq,
+					 bool rx)
+{
+	struct socket *sock = rvq->private_data;
+
+	if (rx) {
+		if (!vhost_vq_avail_empty(&net->dev, tvq)) {
+			vhost_poll_queue(&tvq->poll);
+		} else if (unlikely(vhost_enable_notify(&net->dev, tvq))) {
+			vhost_disable_notify(&net->dev, tvq);
+			vhost_poll_queue(&tvq->poll);
+		}
+	} else if ((sock && sk_has_rx_data(sock->sk)) &&
+		    !vhost_vq_avail_empty(&net->dev, rvq)) {
+		vhost_poll_queue(&rvq->poll);
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
+	vhost_net_busy_poll_vq_check(net, rvq, tvq, rx);
+
+	mutex_unlock(&vq->mutex);
+}
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
 				    struct iovec iov[], unsigned int iov_size,
@@ -631,16 +703,6 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
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
@@ -660,41 +722,13 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
 	struct vhost_virtqueue *rvq = &rnvq->vq;
 	struct vhost_virtqueue *tvq = &tnvq->vq;
-	unsigned long uninitialized_var(endtime);
 	int len = peek_head_len(rnvq, sk);
 
-	if (!len && tvq->busyloop_timeout) {
+	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
 		vhost_rx_signal_used(rnvq);
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
