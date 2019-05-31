From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 2/5] vsock/virtio: fix locking for fwd_cnt and buf_alloc
Date: Fri, 31 May 2019 15:39:51 +0200
Message-ID: <20190531133954.122567-3-sgarzare__25.7532739610156$1559310103$gmane$org@redhat.com>
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

fwd_cnt is written with rx_lock, so we should read it using
the same spinlock also if we are in the TX path.

Move also buf_alloc under rx_lock and add a missing locking
when we modify it.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h            | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 7d973903f52e..53703fe03681 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -35,11 +35,11 @@ struct virtio_vsock_sock {
 
 	/* Protected by tx_lock */
 	u32 tx_cnt;
-	u32 buf_alloc;
 	u32 peer_fwd_cnt;
 	u32 peer_buf_alloc;
 
 	/* Protected by rx_lock */
+	u32 buf_alloc;
 	u32 fwd_cnt;
 	u32 rx_bytes;
 	struct list_head rx_queue;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4fd4987511a9..694d9805f989 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -211,10 +211,10 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
 
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
 {
-	spin_lock_bh(&vvs->tx_lock);
+	spin_lock_bh(&vvs->rx_lock);
 	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
 	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
-	spin_unlock_bh(&vvs->tx_lock);
+	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
 
@@ -434,7 +434,9 @@ void virtio_transport_set_buffer_size(struct vsock_sock *vsk, u64 val)
 	if (val > vvs->buf_size_max)
 		vvs->buf_size_max = val;
 	vvs->buf_size = val;
+	spin_lock_bh(&vvs->rx_lock);
 	vvs->buf_alloc = val;
+	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_set_buffer_size);
 
-- 
2.20.1
