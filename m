From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v2] net: vhost: improve performance when enable
	busyloop
Date: Mon, 25 Jun 2018 22:17:56 -0700
Message-ID: <1529990276-61157-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: netdev@vger.kernel.org, Tonghao Zhang <zhangtonghao@didichuxing.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

This patch improves the guest receive performance from
host. On the handle_tx side, we poll the sock receive
queue at the same time. handle_rx do that in the same way.

For avoiding deadlock, change the code to lock the vq one
by one and use the VHOST_NET_VQ_XX as a subclass for
mutex_lock_nested. With the patch, qemu can set differently
the busyloop_timeout for rx or tx queue.

We set the poll-us=100us and use the iperf3 to test
its throughput. The iperf3 command is shown as below.

on the guest:
iperf3  -s -D

on the host:
iperf3  -c 192.168.1.100 -i 1 -P 10 -t 10 -M 1400

* With the patch:     23.1 Gbits/sec
* Without the patch:  12.7 Gbits/sec

Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
---
 drivers/vhost/net.c   | 106 +++++++++++++++++++++++++++-----------------------
 drivers/vhost/vhost.c |  24 ++++--------
 2 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e7cf7d2..38e9adb 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -429,22 +429,62 @@ static int vhost_net_enable_vq(struct vhost_net *n,
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
+	struct socket *sock = rvq->private_data;
+	struct vhost_virtqueue *vq = rx ? tvq : rvq;
+	unsigned long busyloop_timeout = rx ? rvq->busyloop_timeout :
+					      tvq->busyloop_timeout;
+
+	mutex_lock_nested(&vq->mutex, rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
+	vhost_disable_notify(&net->dev, vq);
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
+	} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
+		vhost_disable_notify(&net->dev, vq);
+		vhost_poll_queue(&vq->poll);
+	}
+
+	mutex_unlock(&vq->mutex);
+}
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
 				    struct iovec iov[], unsigned int iov_size,
 				    unsigned int *out_num, unsigned int *in_num)
 {
-	unsigned long uninitialized_var(endtime);
+	struct vhost_net_virtqueue *nvq_rx = &net->vqs[VHOST_NET_VQ_RX];
+
 	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				  out_num, in_num, NULL, NULL);
 
 	if (r == vq->num && vq->busyloop_timeout) {
-		preempt_disable();
-		endtime = busy_clock() + vq->busyloop_timeout;
-		while (vhost_can_busy_poll(vq->dev, endtime) &&
-		       vhost_vq_avail_empty(vq->dev, vq))
-			cpu_relax();
-		preempt_enable();
+		vhost_net_busy_poll(net, &nvq_rx->vq, vq, false);
+
 		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				      out_num, in_num, NULL, NULL);
 	}
@@ -484,7 +524,7 @@ static void handle_tx(struct vhost_net *net)
 	bool zcopy, zcopy_used;
 	int sent_pkts = 0;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
@@ -621,16 +661,6 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
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
@@ -645,39 +675,19 @@ static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 {
-	struct vhost_net_virtqueue *rvq = &net->vqs[VHOST_NET_VQ_RX];
-	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
-	struct vhost_virtqueue *vq = &nvq->vq;
-	unsigned long uninitialized_var(endtime);
-	int len = peek_head_len(rvq, sk);
-
-	if (!len && vq->busyloop_timeout) {
-		/* Flush batched heads first */
-		vhost_rx_signal_used(rvq);
-		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&vq->mutex, 1);
-		vhost_disable_notify(&net->dev, vq);
-
-		preempt_disable();
-		endtime = busy_clock() + vq->busyloop_timeout;
-
-		while (vhost_can_busy_poll(&net->dev, endtime) &&
-		       !sk_has_rx_data(sk) &&
-		       vhost_vq_avail_empty(&net->dev, vq))
-			cpu_relax();
+	struct vhost_net_virtqueue *nvq_rx = &net->vqs[VHOST_NET_VQ_RX];
+	struct vhost_net_virtqueue *nvq_tx = &net->vqs[VHOST_NET_VQ_TX];
 
-		preempt_enable();
+	int len = peek_head_len(nvq_rx, sk);
 
-		if (!vhost_vq_avail_empty(&net->dev, vq))
-			vhost_poll_queue(&vq->poll);
-		else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
-			vhost_disable_notify(&net->dev, vq);
-			vhost_poll_queue(&vq->poll);
-		}
+	if (!len && nvq_rx->vq.busyloop_timeout) {
+		/* Flush batched heads first */
+		vhost_rx_signal_used(nvq_rx);
 
-		mutex_unlock(&vq->mutex);
+		/* Both tx vq and rx socket were polled here */
+		vhost_net_busy_poll(net, &nvq_rx->vq, &nvq_tx->vq, true);
 
-		len = peek_head_len(rvq, sk);
+		len = peek_head_len(nvq_rx, sk);
 	}
 
 	return len;
@@ -789,7 +799,7 @@ static void handle_rx(struct vhost_net *net)
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
-	mutex_lock_nested(&vq->mutex, 0);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 895eaa2..1716b10 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -294,8 +294,11 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
 
-	for (i = 0; i < d->nvqs; ++i)
+	for (i = 0; i < d->nvqs; ++i) {
+		mutex_lock(&d->vqs[i]->mutex);
 		__vhost_vq_meta_reset(d->vqs[i]);
+		mutex_unlock(&d->vqs[i]->mutex);
+	}
 }
 
 static void vhost_vq_reset(struct vhost_dev *dev,
@@ -887,19 +890,6 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 #define vhost_get_used(vq, x, ptr) \
 	vhost_get_user(vq, x, ptr, VHOST_ADDR_USED)
 
-static void vhost_dev_lock_vqs(struct vhost_dev *d)
-{
-	int i = 0;
-	for (i = 0; i < d->nvqs; ++i)
-		mutex_lock_nested(&d->vqs[i]->mutex, i);
-}
-
-static void vhost_dev_unlock_vqs(struct vhost_dev *d)
-{
-	int i = 0;
-	for (i = 0; i < d->nvqs; ++i)
-		mutex_unlock(&d->vqs[i]->mutex);
-}
 
 static int vhost_new_umem_range(struct vhost_umem *umem,
 				u64 start, u64 size, u64 end,
@@ -950,7 +940,11 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 		if (msg->iova <= vq_msg->iova &&
 		    msg->iova + msg->size - 1 > vq_msg->iova &&
 		    vq_msg->type == VHOST_IOTLB_MISS) {
+
+			mutex_lock(&node->vq->mutex);
 			vhost_poll_queue(&node->vq->poll);
+			mutex_unlock(&node->vq->mutex);
+
 			list_del(&node->node);
 			kfree(node);
 		}
@@ -982,7 +976,6 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 	int ret = 0;
 
 	mutex_lock(&dev->mutex);
-	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
 		if (!dev->iotlb) {
@@ -1016,7 +1009,6 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 		break;
 	}
 
-	vhost_dev_unlock_vqs(dev);
 	mutex_unlock(&dev->mutex);
 
 	return ret;
-- 
1.8.3.1
