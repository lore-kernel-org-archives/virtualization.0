From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 3/5] vsock/virtio: fix locking in
	virtio_transport_inc_tx_pkt()
Date: Wed, 17 Jul 2019 13:30:28 +0200
Message-ID: <20190717113030.163499-4-sgarzare__33374.2095435568$1563363084$gmane$org@redhat.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-1-sgarzare@redhat.com>
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

fwd_cnt and last_fwd_cnt are protected by rx_lock, so we should use
the same spinlock also if we are in the TX path.

Move also buf_alloc under the same lock.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h            | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 49fc9d20bc43..4c7781f4b29b 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -35,7 +35,6 @@ struct virtio_vsock_sock {
 
 	/* Protected by tx_lock */
 	u32 tx_cnt;
-	u32 buf_alloc;
 	u32 peer_fwd_cnt;
 	u32 peer_buf_alloc;
 
@@ -43,6 +42,7 @@ struct virtio_vsock_sock {
 	u32 fwd_cnt;
 	u32 last_fwd_cnt;
 	u32 rx_bytes;
+	u32 buf_alloc;
 	struct list_head rx_queue;
 };
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a85559d4d974..34a2b42313b7 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -210,11 +210,11 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
 
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
 {
-	spin_lock_bh(&vvs->tx_lock);
+	spin_lock_bh(&vvs->rx_lock);
 	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
 	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
-	spin_unlock_bh(&vvs->tx_lock);
+	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
 
-- 
2.20.1
