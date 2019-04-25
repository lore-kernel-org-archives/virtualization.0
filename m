From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost_net: fix possible infinite loop
Date: Thu, 25 Apr 2019 03:33:19 -0400
Message-ID: <1556177599-56248-1-git-send-email-jasowang__15698.1653229863$1556177643$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ppandit@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

When the rx buffer is too small for a packet, we will discard the vq
descriptor and retry it for the next packet:

while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
					      &busyloop_intr))) {
...
	/* On overrun, truncate and discard */
	if (unlikely(headcount > UIO_MAXIOV)) {
		iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
		err = sock->ops->recvmsg(sock, &msg,
					 1, MSG_DONTWAIT | MSG_TRUNC);
		pr_debug("Discarded rx packet: len %zd\n", sock_len);
		continue;
	}
...
}

This makes it possible to trigger a infinite while..continue loop
through the co-opreation of two VMs like:

1) Malicious VM1 allocate 1 byte rx buffer and try to slow down the
   vhost process as much as possible e.g using indirect descriptors or
   other.
2) Malicious VM2 generate packets to VM1 as fast as possible

Fixing this by checking against weight at the end of RX and TX
loop. This also eliminate other similar cases when:

- userspace is consuming the packets in the meanwhile
- theoretical TOCTOU attack if guest moving avail index back and forth
  to hit the continue after vhost find guest just add new buffers

This addresses CVE-2019-3900.

Fixes: d8316f3991d20 ("vhost: fix total length when packets are too short")
Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index df51a35..fb46e6b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -778,8 +778,9 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int err;
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
+	bool next_round = false;
 
-	for (;;) {
+	do {
 		bool busyloop_intr = false;
 
 		if (nvq->done_idx == VHOST_NET_BATCH)
@@ -845,11 +846,10 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
 		vq->heads[nvq->done_idx].len = 0;
 		++nvq->done_idx;
-		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
-			vhost_poll_queue(&vq->poll);
-			break;
-		}
-	}
+	} while (!(next_round = vhost_exceeds_weight(++sent_pkts, total_len)));
+
+	if (next_round)
+		vhost_poll_queue(&vq->poll);
 
 	vhost_tx_batch(net, nvq, sock, &msg);
 }
@@ -873,8 +873,9 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy_used;
 	int sent_pkts = 0;
+	bool next_round = false;
 
-	for (;;) {
+	do {
 		bool busyloop_intr;
 
 		/* Release DMAs done buffers first */
@@ -951,11 +952,10 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
-		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
-			vhost_poll_queue(&vq->poll);
-			break;
-		}
-	}
+	} while (!(next_round = vhost_exceeds_weight(++sent_pkts, total_len)));
+
+	if (next_round)
+		vhost_poll_queue(&vq->poll);
 }
 
 /* Expects to be always run from workqueue - which acts as
@@ -1134,6 +1134,7 @@ static void handle_rx(struct vhost_net *net)
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
+	bool next_round = false;
 
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vq->private_data;
@@ -1153,8 +1154,11 @@ static void handle_rx(struct vhost_net *net)
 		vq->log : NULL;
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
 
-	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
-						      &busyloop_intr))) {
+	do {
+		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
+						      &busyloop_intr);
+		if (!sock_len)
+			break;
 		sock_len += sock_hlen;
 		vhost_len = sock_len + vhost_hlen;
 		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
@@ -1239,12 +1243,9 @@ static void handle_rx(struct vhost_net *net)
 			vhost_log_write(vq, vq_log, log, vhost_len,
 					vq->iov, in);
 		total_len += vhost_len;
-		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
-			vhost_poll_queue(&vq->poll);
-			goto out;
-		}
-	}
-	if (unlikely(busyloop_intr))
+	} while (!(next_round = vhost_exceeds_weight(++recv_pkts, total_len)));
+
+	if (unlikely(busyloop_intr || next_round))
 		vhost_poll_queue(&vq->poll);
 	else
 		vhost_net_enable_vq(net, vq);
-- 
1.8.3.1
