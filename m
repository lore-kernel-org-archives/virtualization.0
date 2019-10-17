From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 2/2] vsock/virtio: discard packets if credit is not
	respected
Date: Thu, 17 Oct 2019 14:44:03 +0200
Message-ID: <20191017124403.266242-3-sgarzare__5158.57824809558$1571316274$gmane$org@redhat.com>
References: <20191017124403.266242-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191017124403.266242-1-sgarzare@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

If the remote peer doesn't respect the credit information
(buf_alloc, fwd_cnt), sending more data than it can send,
we should drop the packets to prevent a malicious peer
from using all of our memory.

This is patch follows the VIRTIO spec: "VIRTIO_VSOCK_OP_RW data
packets MUST only be transmitted when the peer has sufficient
free buffer space for the payload"

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index db127a69f5c3..481f7f8a1655 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -204,10 +204,14 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return virtio_transport_get_ops()->send_pkt(pkt);
 }
 
-static void virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					struct virtio_vsock_pkt *pkt)
 {
+	if (vvs->rx_bytes + pkt->len > vvs->buf_alloc)
+		return false;
+
 	vvs->rx_bytes += pkt->len;
+	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
@@ -879,14 +883,18 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct virtio_vsock_pkt *pkt)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	bool free_pkt = false;
+	bool can_enqueue, free_pkt = false;
 
 	pkt->len = le32_to_cpu(pkt->hdr.len);
 	pkt->off = 0;
 
 	spin_lock_bh(&vvs->rx_lock);
 
-	virtio_transport_inc_rx_pkt(vvs, pkt);
+	can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
+	if (!can_enqueue) {
+		free_pkt = true;
+		goto out;
+	}
 
 	/* Try to copy small packets into the buffer of last packet queued,
 	 * to avoid wasting memory queueing the entire buffer with a small
-- 
2.21.0
