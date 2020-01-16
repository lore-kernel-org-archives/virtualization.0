From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next 1/3] vsock: add network namespace support
Date: Thu, 16 Jan 2020 18:24:26 +0100
Message-ID: <20200116172428.311437-2-sgarzare@redhat.com>
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

This patch adds a check of the "net" assigned to a socket during
the vsock_find_bound_socket() and vsock_find_connected_socket()
to support network namespace, allowing to share the same address
(cid, port) across different network namespaces.

This patch adds 'netns' module param to enable this new feature
(disabled by default), because it changes vsock's behavior with
network namespaces and could break existing applications.

G2H transports will use the default network namepsace (init_net).
H2G transports can use different network namespace for different
VMs.

This patch uses default network namepsace (init_net) in all
transports.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
RFC -> v1
 * added 'netns' module param
 * added 'vsock_net_eq()' to check the "net" assigned to a socket
   only when 'netns' support is enabled
---
 include/net/af_vsock.h                  |  7 +++--
 net/vmw_vsock/af_vsock.c                | 41 +++++++++++++++++++------
 net/vmw_vsock/hyperv_transport.c        |  5 +--
 net/vmw_vsock/virtio_transport_common.c |  5 +--
 net/vmw_vsock/vmci_transport.c          |  5 +--
 5 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index b1c717286993..015913601fad 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -193,13 +193,16 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_insert_connected(struct vsock_sock *vsk);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst);
+					 struct sockaddr_vm *dst,
+					 struct net *net);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
+bool vsock_net_eq(const struct net *net1, const struct net *net2);
+struct net *vsock_default_net(void);
 
 /**** TAP ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9c5b2a91baad..457ccd677756 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -140,6 +140,10 @@ static const struct vsock_transport *transport_dgram;
 static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
 
+static bool netns;
+module_param(netns, bool, 0644);
+MODULE_PARM_DESC(netns, "Enable network namespace support");
+
 /**** UTILS ****/
 
 /* Each bound VSocket is stored in the bind hash table and each connected
@@ -226,15 +230,18 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr,
+					      struct net *net)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
-		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
+		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
+		    vsock_net_eq(net, sock_net(sk_vsock(vsk))))
 			return sk_vsock(vsk);
 
 		if (addr->svm_port == vsk->local_addr.svm_port &&
+		    vsock_net_eq(net, sock_net(sk_vsock(vsk))) &&
 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
 		     addr->svm_cid == VMADDR_CID_ANY))
 			return sk_vsock(vsk);
@@ -244,13 +251,15 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 }
 
 static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
-						  struct sockaddr_vm *dst)
+						  struct sockaddr_vm *dst,
+						  struct net *net)
 {
 	struct vsock_sock *vsk;
 
 	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
 			    connected_table) {
 		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
+		    vsock_net_eq(net, sock_net(sk_vsock(vsk))) &&
 		    dst->svm_port == vsk->local_addr.svm_port) {
 			return sk_vsock(vsk);
 		}
@@ -295,12 +304,12 @@ void vsock_remove_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
 
-struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_bound_socket(addr);
+	sk = __vsock_find_bound_socket(addr, net);
 	if (sk)
 		sock_hold(sk);
 
@@ -311,12 +320,13 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
 EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
 
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
-					 struct sockaddr_vm *dst)
+					 struct sockaddr_vm *dst,
+					 struct net *net)
 {
 	struct sock *sk;
 
 	spin_lock_bh(&vsock_table_lock);
-	sk = __vsock_find_connected_socket(src, dst);
+	sk = __vsock_find_connected_socket(src, dst, net);
 	if (sk)
 		sock_hold(sk);
 
@@ -488,6 +498,18 @@ bool vsock_find_cid(unsigned int cid)
 }
 EXPORT_SYMBOL_GPL(vsock_find_cid);
 
+bool vsock_net_eq(const struct net *net1, const struct net *net2)
+{
+	return !netns || net_eq(net1, net2);
+}
+EXPORT_SYMBOL_GPL(vsock_net_eq);
+
+struct net *vsock_default_net(void)
+{
+	return &init_net;
+}
+EXPORT_SYMBOL_GPL(vsock_default_net);
+
 static struct sock *vsock_dequeue_accept(struct sock *listener)
 {
 	struct vsock_sock *vlistener;
@@ -586,6 +608,7 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
 {
 	static u32 port;
 	struct sockaddr_vm new_addr;
+	struct net *net = sock_net(sk_vsock(vsk));
 
 	if (!port)
 		port = LAST_RESERVED_PORT + 1 +
@@ -603,7 +626,7 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!__vsock_find_bound_socket(&new_addr, net)) {
 				found = true;
 				break;
 			}
@@ -620,7 +643,7 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (__vsock_find_bound_socket(&new_addr, net))
 			return -EADDRINUSE;
 	}
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index b3bdae74c243..237c53316d70 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -201,7 +201,8 @@ static void hvs_remote_addr_init(struct sockaddr_vm *remote,
 
 		remote->svm_port = host_ephemeral_port++;
 
-		sk = vsock_find_connected_socket(remote, local);
+		sk = vsock_find_connected_socket(remote, local,
+						 vsock_default_net());
 		if (!sk) {
 			/* Found an available ephemeral port */
 			return;
@@ -350,7 +351,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		return;
 
 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
-	sk = vsock_find_bound_socket(&addr);
+	sk = vsock_find_bound_socket(&addr, vsock_default_net());
 	if (!sk)
 		return;
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index d9f0c9c5425a..cecdfd91ed00 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1088,6 +1088,7 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct virtio_vsock_pkt *pkt)
 {
+	struct net *net = vsock_default_net();
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1115,9 +1116,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, net);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, pkt);
 			goto free_pkt;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4b8b1150a738..3ad15d51b30b 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -669,6 +669,7 @@ static bool vmci_transport_stream_allow(u32 cid, u32 port)
 
 static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 {
+	struct net *net = vsock_default_net();
 	struct sock *sk;
 	struct sockaddr_vm dst;
 	struct sockaddr_vm src;
@@ -702,9 +703,9 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
 	vsock_addr_init(&dst, pkt->dg.dst.context, pkt->dst_port);
 
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, net);
 		if (!sk) {
 			/* We could not find a socket for this specified
 			 * address.  If this packet is a RST, we just drop it.
-- 
2.24.1
