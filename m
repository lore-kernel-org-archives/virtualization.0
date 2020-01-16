From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next 2/3] vsock/virtio_transport_common: handle netns of
 received packets
Date: Thu, 16 Jan 2020 18:24:27 +0100
Message-ID: <20200116172428.311437-3-sgarzare@redhat.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200116172428.311437-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch allows transports that use virtio_transport_common
to specify the network namespace where a received packet is to
be delivered.

virtio_transport and vhost_transport, for now, use the default
network namespace.

vsock_loopback uses the same network namespace of the transmitter.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  2 ++
 net/vmw_vsock/virtio_transport.c        |  2 ++
 net/vmw_vsock/virtio_transport_common.c | 13 ++++++++++---
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index c2d7d57e98cf..f1d39939d5e4 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -474,6 +474,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		pkt->net = vsock_default_net();
 		len = pkt->len;
 
 		/* Deliver to monitoring devices all received packets */
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 71c81e0dc8f2..d4fc93e6e03e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -43,6 +43,7 @@ struct virtio_vsock_pkt {
 	struct list_head list;
 	/* socket refcnt not held, only use for cancellation */
 	struct vsock_sock *vsk;
+	struct net *net;
 	void *buf;
 	u32 buf_len;
 	u32 len;
@@ -54,6 +55,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index dfbaf6bd8b1c..fb03a1535c21 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -527,6 +527,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			pkt->len = len - sizeof(pkt->hdr);
+			pkt->net = vsock_default_net();
+
 			virtio_transport_deliver_tap_pkt(pkt);
 			virtio_transport_recv_pkt(&virtio_transport, pkt);
 		}
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index cecdfd91ed00..6402dea62e45 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -63,6 +63,7 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
 	pkt->hdr.len		= cpu_to_le32(len);
 	pkt->reply		= info->reply;
 	pkt->vsk		= info->vsk;
+	pkt->net		= info->net;
 
 	if (info->msg && len > 0) {
 		pkt->buf = kmalloc(len, GFP_KERNEL);
@@ -273,6 +274,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.type = type,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -622,6 +624,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.type = VIRTIO_VSOCK_TYPE_STREAM,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -638,6 +641,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -665,6 +669,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -687,6 +692,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.type = VIRTIO_VSOCK_TYPE_STREAM,
 		.reply = !!pkt,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -707,6 +713,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(pkt->hdr.type),
 		.reply = true,
+		.net = pkt->net,
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -991,6 +998,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(pkt->hdr.src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1088,7 +1096,6 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct virtio_vsock_pkt *pkt)
 {
-	struct net *net = vsock_default_net();
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1116,9 +1123,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst, net);
+	sk = vsock_find_connected_socket(&src, &dst, pkt->net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst, net);
+		sk = vsock_find_bound_socket(&dst, pkt->net);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, pkt);
 			goto free_pkt;
-- 
2.24.1
