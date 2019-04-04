From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Date: Thu,  4 Apr 2019 12:58:35 +0200
Message-ID: <20190404105838.101559-2-sgarzare__41989.9273825408$1555717821$gmane$org@redhat.com>
References: <20190404105838.101559-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
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

In order to reduce the number of credit update messages,
we send them only when the space available seen by the
transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index e223e2632edd..6d7a22cc20bf 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -37,6 +37,7 @@ struct virtio_vsock_sock {
 	u32 tx_cnt;
 	u32 buf_alloc;
 	u32 peer_fwd_cnt;
+	u32 last_fwd_cnt;
 	u32 peer_buf_alloc;
 
 	/* Protected by rx_lock */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 602715fc9a75..f32301d823f5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -206,6 +206,7 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
 {
 	spin_lock_bh(&vvs->tx_lock);
+	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
 	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
 	spin_unlock_bh(&vvs->tx_lock);
@@ -256,6 +257,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	struct virtio_vsock_pkt *pkt;
 	size_t bytes, total = 0;
+	s64 free_space;
 	int err = -EFAULT;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 	spin_unlock_bh(&vvs->rx_lock);
 
-	/* Send a credit pkt to peer */
-	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
-					    NULL);
+	/* We send a credit update only when the space available seen
+	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
+	 */
+	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
+	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
+		virtio_transport_send_credit_update(vsk,
+						    VIRTIO_VSOCK_TYPE_STREAM,
+						    NULL);
+	}
 
 	return total;
 
-- 
2.20.1
