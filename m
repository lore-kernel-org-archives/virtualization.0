From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next 06/14] vsock: add 'struct vsock_sock *' param to
	vsock_core_get_transport()
Date: Wed, 23 Oct 2019 11:55:46 +0200
Message-ID: <20191023095554.11340-7-sgarzare__11030.7736018271$1571824685$gmane$org@redhat.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-1-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Since now the 'struct vsock_sock' object contains a pointer to
the transport, this patch adds a parameter to the
vsock_core_get_transport() to return the right transport
assigned to the socket.

This patch modifies also the virtio_transport_get_ops(), that
uses the vsock_core_get_transport(), adding the
'struct vsock_sock *' parameter.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
RFC -> v1:
- Removed comment about protecting transport_single (Stefan)
---
 include/net/af_vsock.h                  | 2 +-
 net/vmw_vsock/af_vsock.c                | 7 ++-----
 net/vmw_vsock/virtio_transport_common.c | 9 +++++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index a5e1e134261d..2ca67d048de4 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -166,7 +166,7 @@ static inline int vsock_core_init(const struct vsock_transport *t)
 void vsock_core_exit(void);
 
 /* The transport may downcast this to access transport-specific functions */
-const struct vsock_transport *vsock_core_get_transport(void);
+const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk);
 
 /**** UTILS ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c3a14f853eb0..eaea159006c8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2001,12 +2001,9 @@ void vsock_core_exit(void)
 }
 EXPORT_SYMBOL_GPL(vsock_core_exit);
 
-const struct vsock_transport *vsock_core_get_transport(void)
+const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
 {
-	/* vsock_register_mutex not taken since only the transport uses this
-	 * function and only while registered.
-	 */
-	return transport_single;
+	return vsk->transport;
 }
 EXPORT_SYMBOL_GPL(vsock_core_get_transport);
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9763394f7a61..37a1c7e7c7fe 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -29,9 +29,10 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
-static const struct virtio_transport *virtio_transport_get_ops(void)
+static const struct virtio_transport *
+virtio_transport_get_ops(struct vsock_sock *vsk)
 {
-	const struct vsock_transport *t = vsock_core_get_transport();
+	const struct vsock_transport *t = vsock_core_get_transport(vsk);
 
 	return container_of(t, struct virtio_transport, transport);
 }
@@ -168,7 +169,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	struct virtio_vsock_pkt *pkt;
 	u32 pkt_len = info->pkt_len;
 
-	src_cid = virtio_transport_get_ops()->transport.get_local_cid();
+	src_cid = virtio_transport_get_ops(vsk)->transport.get_local_cid();
 	src_port = vsk->local_addr.svm_port;
 	if (!info->remote_cid) {
 		dst_cid	= vsk->remote_addr.svm_cid;
@@ -201,7 +202,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	virtio_transport_inc_tx_pkt(vvs, pkt);
 
-	return virtio_transport_get_ops()->send_pkt(pkt);
+	return virtio_transport_get_ops(vsk)->send_pkt(pkt);
 }
 
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-- 
2.21.0
