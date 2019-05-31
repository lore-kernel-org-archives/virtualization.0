From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 1/5] vsock/virtio: limit the memory used per-socket
Date: Fri, 31 May 2019 15:39:50 +0200
Message-ID: <20190531133954.122567-2-sgarzare__18297.8360260435$1559310111$gmane$org@redhat.com>
References: <20190531133954.122567-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190531133954.122567-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Since virtio-vsock was introduced, the buffers filled by the host
and pushed to the guest using the vring, are directly queued in
a per-socket list. These buffers are preallocated by the guest
with a fixed size (4 KB).

The maximum amount of memory used by each socket should be
controlled by the credit mechanism.
The default credit available per-socket is 256 KB, but if we use
only 1 byte per packet, the guest can queue up to 262144 of 4 KB
buffers, using up to 1 GB of memory per-socket. In addition, the
guest will continue to fill the vring with new 4 KB free buffers
to avoid starvation of other sockets.

This patch mitigates this issue copying the payload of small
packets (< 128 bytes) into the buffer of last packet queued, in
order to avoid wasting memory.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c                   |  2 +
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 60 +++++++++++++++++++++----
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bb5fc0e9fbc2..7964e2daee09 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -320,6 +320,8 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
+	pkt->buf_len = pkt->len;
+
 	nbytes = copy_from_iter(pkt->buf, pkt->len, &iov_iter);
 	if (nbytes != pkt->len) {
 		vq_err(vq, "Expected %u byte payload, got %zu bytes\n",
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index e223e2632edd..7d973903f52e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -52,6 +52,7 @@ struct virtio_vsock_pkt {
 	/* socket refcnt not held, only use for cancellation */
 	struct vsock_sock *vsk;
 	void *buf;
+	u32 buf_len;
 	u32 len;
 	u32 off;
 	bool reply;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 96ab344f17bb..beabb8025907 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -280,6 +280,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 			break;
 		}
 
+		pkt->buf_len = buf_len;
 		pkt->len = buf_len;
 
 		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f3f3d06cb6d8..4fd4987511a9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -27,6 +27,9 @@
 /* How long to wait for graceful shutdown of a connection */
 #define VSOCK_CLOSE_TIMEOUT (8 * HZ)
 
+/* Threshold for detecting small packets to copy */
+#define GOOD_COPY_LEN  128
+
 static const struct virtio_transport *virtio_transport_get_ops(void)
 {
 	const struct vsock_transport *t = vsock_core_get_transport();
@@ -65,6 +68,9 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
 		pkt->buf = kmalloc(len, GFP_KERNEL);
 		if (!pkt->buf)
 			goto out_pkt;
+
+		pkt->buf_len = len;
+
 		err = memcpy_from_msg(pkt->buf, info->msg, len);
 		if (err)
 			goto out;
@@ -842,24 +848,60 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
+static void
+virtio_transport_recv_enqueue(struct vsock_sock *vsk,
+			      struct virtio_vsock_pkt *pkt)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	bool free_pkt = false;
+
+	pkt->len = le32_to_cpu(pkt->hdr.len);
+	pkt->off = 0;
+
+	spin_lock_bh(&vvs->rx_lock);
+
+	virtio_transport_inc_rx_pkt(vvs, pkt);
+
+	/* Try to copy small packets into the buffer of last packet queued,
+	 * to avoid wasting memory queueing the entire buffer with a small
+	 * payload.
+	 */
+	if (pkt->len <= GOOD_COPY_LEN && !list_empty(&vvs->rx_queue)) {
+		struct virtio_vsock_pkt *last_pkt;
+
+		last_pkt = list_last_entry(&vvs->rx_queue,
+					   struct virtio_vsock_pkt, list);
+
+		/* If there is space in the last packet queued, we copy the
+		 * new packet in its buffer.
+		 */
+		if (pkt->len <= last_pkt->buf_len - last_pkt->len) {
+			memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
+			       pkt->len);
+			last_pkt->len += pkt->len;
+			free_pkt = true;
+			goto out;
+		}
+	}
+
+	list_add_tail(&pkt->list, &vvs->rx_queue);
+
+out:
+	spin_unlock_bh(&vvs->rx_lock);
+	if (free_pkt)
+		virtio_transport_free_pkt(pkt);
+}
+
 static int
 virtio_transport_recv_connected(struct sock *sk,
 				struct virtio_vsock_pkt *pkt)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
-	struct virtio_vsock_sock *vvs = vsk->trans;
 	int err = 0;
 
 	switch (le16_to_cpu(pkt->hdr.op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		pkt->len = le32_to_cpu(pkt->hdr.len);
-		pkt->off = 0;
-
-		spin_lock_bh(&vvs->rx_lock);
-		virtio_transport_inc_rx_pkt(vvs, pkt);
-		list_add_tail(&pkt->list, &vvs->rx_queue);
-		spin_unlock_bh(&vvs->rx_lock);
-
+		virtio_transport_recv_enqueue(vsk, pkt);
 		sk->sk_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
-- 
2.20.1
