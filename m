From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 13/15] vsock: prevent transport modules unloading
Date: Thu, 14 Nov 2019 10:57:48 +0100
Message-ID: <20191114095750.59106-14-sgarzare__47139.2796303675$1573725695$gmane$org@redhat.com>
References: <20191114095750.59106-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191114095750.59106-1-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, Haiyang Zhang <haiyangz@microsoft.com>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds 'module' member in the 'struct vsock_transport'
in order to get/put the transport module. This prevents the
module unloading while sockets are assigned to it.

We increase the module refcnt when a socket is assigned to a
transport, and we decrease the module refcnt when the socket
is destructed.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c            |  2 ++
 include/net/af_vsock.h           |  2 ++
 net/vmw_vsock/af_vsock.c         | 20 ++++++++++++++++----
 net/vmw_vsock/hyperv_transport.c |  2 ++
 net/vmw_vsock/virtio_transport.c |  2 ++
 net/vmw_vsock/vmci_transport.c   |  1 +
 6 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b235f4bbe8ea..fdda9ec625ad 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -386,6 +386,8 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
 
 static struct virtio_transport vhost_transport = {
 	.transport = {
+		.module                   = THIS_MODULE,
+
 		.get_local_cid            = vhost_transport_get_local_cid,
 
 		.init                     = virtio_transport_do_socket_init,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index cf5c3691251b..4206dc6d813f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -100,6 +100,8 @@ struct vsock_transport_send_notify_data {
 #define VSOCK_TRANSPORT_F_DGRAM		0x00000004
 
 struct vsock_transport {
+	struct module *module;
+
 	/* Initialize/tear-down socket. */
 	int (*init)(struct vsock_sock *, struct vsock_sock *);
 	void (*destruct)(struct vsock_sock *);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5357714b6104..5cb0ae42d916 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -380,6 +380,16 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
+static void vsock_deassign_transport(struct vsock_sock *vsk)
+{
+	if (!vsk->transport)
+		return;
+
+	vsk->transport->destruct(vsk);
+	module_put(vsk->transport->module);
+	vsk->transport = NULL;
+}
+
 /* Assign a transport to a socket and call the .init transport callback.
  *
  * Note: for stream socket this must be called when vsk->remote_addr is set
@@ -418,10 +428,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 			return 0;
 
 		vsk->transport->release(vsk);
-		vsk->transport->destruct(vsk);
+		vsock_deassign_transport(vsk);
 	}
 
-	if (!new_transport)
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module))
 		return -ENODEV;
 
 	vsk->transport = new_transport;
@@ -741,8 +754,7 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
-	if (vsk->transport)
-		vsk->transport->destruct(vsk);
+	vsock_deassign_transport(vsk);
 
 	/* When clearing these addresses, there's no need to set the family and
 	 * possibly register the address family with the kernel.
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 1c9e65d7d94d..3c7d07a99fc5 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -857,6 +857,8 @@ int hvs_notify_send_post_enqueue(struct vsock_sock *vsk, ssize_t written,
 }
 
 static struct vsock_transport hvs_transport = {
+	.module                   = THIS_MODULE,
+
 	.get_local_cid            = hvs_get_local_cid,
 
 	.init                     = hvs_sock_init,
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 83ad85050384..1458c5c8b64d 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -462,6 +462,8 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
 
 static struct virtio_transport virtio_transport = {
 	.transport = {
+		.module                   = THIS_MODULE,
+
 		.get_local_cid            = virtio_transport_get_local_cid,
 
 		.init                     = virtio_transport_do_socket_init,
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index d9c9c834ad6f..644d32e43d23 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2020,6 +2020,7 @@ static u32 vmci_transport_get_local_cid(void)
 }
 
 static struct vsock_transport vmci_transport = {
+	.module = THIS_MODULE,
 	.init = vmci_transport_socket_init,
 	.destruct = vmci_transport_destruct,
 	.release = vmci_transport_release,
-- 
2.21.0
