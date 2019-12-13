From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 2/2] vsock/virtio: add WARN_ON check on
 virtio_transport_get_ops()
Date: Fri, 13 Dec 2019 19:48:01 +0100
Message-ID: <20191213184801.486675-3-sgarzare__13098.7337137171$1576262910$gmane$org@redhat.com>
References: <20191213184801.486675-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191213184801.486675-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: davem@davemloft.net
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio_transport_get_ops() and virtio_transport_send_pkt_info()
can only be used on connecting/connected sockets, since a socket
assigned to a transport is required.

This patch adds a WARN_ON() on virtio_transport_get_ops() to check
this requirement, a comment and a returned error on
virtio_transport_send_pkt_info(),

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f5991006190e..6abec3fc81d1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -34,6 +34,9 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
 {
 	const struct vsock_transport *t = vsock_core_get_transport(vsk);
 
+	if (WARN_ON(!t))
+		return NULL;
+
 	return container_of(t, struct virtio_transport, transport);
 }
 
@@ -161,15 +164,25 @@ void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
 
+/* This function can only be used on connecting/connected sockets,
+ * since a socket assigned to a transport is required.
+ *
+ * Do not use on listener sockets!
+ */
 static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 					  struct virtio_vsock_pkt_info *info)
 {
 	u32 src_cid, src_port, dst_cid, dst_port;
+	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
 	struct virtio_vsock_pkt *pkt;
 	u32 pkt_len = info->pkt_len;
 
-	src_cid = virtio_transport_get_ops(vsk)->transport.get_local_cid();
+	t_ops = virtio_transport_get_ops(vsk);
+	if (unlikely(!t_ops))
+		return -EFAULT;
+
+	src_cid = t_ops->transport.get_local_cid();
 	src_port = vsk->local_addr.svm_port;
 	if (!info->remote_cid) {
 		dst_cid	= vsk->remote_addr.svm_cid;
@@ -202,7 +215,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	virtio_transport_inc_tx_pkt(vvs, pkt);
 
-	return virtio_transport_get_ops(vsk)->send_pkt(pkt);
+	return t_ops->send_pkt(pkt);
 }
 
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-- 
2.23.0
