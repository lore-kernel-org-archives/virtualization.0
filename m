From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 9/9] vhost_net: batch update used ring for datacopy TX
Date: Fri, 20 Jul 2018 08:15:21 +0800
Message-ID: <1532045721-4958-10-git-send-email-jasowang__38498.8201818944$1532046163$gmane$org@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Like commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
this patches implements batch used ring update for datacopy TX
(zerocopy has already done some kind of batching).

Testpmd transmission from guest to host (XDP_DROP on tap) shows 25.8%
improvement (from ~3.1Mpps to ~3.9Mpps) on Broadwell i7-5600U CPU @
2.60GHz machine. Netperf TCP tests does not show obvious differences.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2fd2f0e3..367d802 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -428,16 +428,31 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 	return vhost_poll_start(poll, sock->file);
 }
 
+static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
+{
+	struct vhost_virtqueue *vq = &nvq->vq;
+	struct vhost_dev *dev = vq->dev;
+
+	if (!nvq->done_idx)
+		return;
+
+	vhost_add_used_and_signal_n(dev, vq, vq->heads, nvq->done_idx);
+	nvq->done_idx = 0;
+}
+
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
-				    struct vhost_virtqueue *vq,
+				    struct vhost_net_virtqueue *nvq,
 				    unsigned int *out_num, unsigned int *in_num,
 				    bool *busyloop_intr)
 {
+	struct vhost_virtqueue *vq = &nvq->vq;
 	unsigned long uninitialized_var(endtime);
 	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				  out_num, in_num, NULL, NULL);
 
 	if (r == vq->num && vq->busyloop_timeout) {
+		if (!vhost_sock_zcopy(vq->private_data))
+			vhost_net_signal_used(nvq);
 		preempt_disable();
 		endtime = busy_clock() + vq->busyloop_timeout;
 		while (vhost_can_busy_poll(endtime)) {
@@ -493,7 +508,8 @@ static int get_tx_bufs(struct vhost_net *net,
 	struct vhost_virtqueue *vq = &nvq->vq;
 	int ret;
 
-	ret = vhost_net_tx_get_vq_desc(net, vq, out, in, busyloop_intr);
+	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, busyloop_intr);
+
 	if (ret < 0 || ret == vq->num)
 		return ret;
 
@@ -557,6 +573,9 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		}
 
+		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
+		vq->heads[nvq->done_idx].len = 0;
+
 		total_len += len;
 		if (tx_can_batch(vq, total_len))
 			msg.msg_flags |= MSG_MORE;
@@ -573,12 +592,15 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (err != len)
 			pr_debug("Truncated TX packet: len %d != %zd\n",
 				 err, len);
-		vhost_add_used_and_signal(&net->dev, vq, head, 0);
+		if (++nvq->done_idx >= VHOST_NET_BATCH)
+			vhost_net_signal_used(nvq);
 		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
 	}
+
+	vhost_net_signal_used(nvq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
@@ -741,18 +763,6 @@ static int sk_has_rx_data(struct sock *sk)
 	return skb_queue_empty(&sk->sk_receive_queue);
 }
 
-static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
-{
-	struct vhost_virtqueue *vq = &nvq->vq;
-	struct vhost_dev *dev = vq->dev;
-
-	if (!nvq->done_idx)
-		return;
-
-	vhost_add_used_and_signal_n(dev, vq, vq->heads, nvq->done_idx);
-	nvq->done_idx = 0;
-}
-
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 				      bool *busyloop_intr)
 {
-- 
2.7.4
