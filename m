From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 12/13] vsock: prevent transport modules unloading
Date: Fri, 27 Sep 2019 13:27:02 +0200
Message-ID: <20190927112703.17745-13-sgarzare__31283.0815719039$1569583776$gmane$org@redhat.com>
References: <20190927112703.17745-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-1-sgarzare@redhat.com>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds 'module' member in the 'struct vsock_transport'
in order to get/put the transport module. This prevents the
module unloading while sockets are assigned to it.

We increase the module refcnt when a socket is assigned to a
transport, and we decrease the module refcnt when the socket
is destructed.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c            |  1 +
 include/net/af_vsock.h           |  1 +
 net/vmw_vsock/af_vsock.c         | 23 +++++++++++++++++------
 net/vmw_vsock/hyperv_transport.c |  1 +
 net/vmw_vsock/virtio_transport.c |  1 +
 net/vmw_vsock/vmci_transport.c   |  1 +
 6 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 375af01a5b64..6d7a8fc9eb63 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -387,6 +387,7 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
 static struct virtio_transport vhost_transport = {
 	.transport = {
 		.features                 = VSOCK_TRANSPORT_F_H2G,
+		.module                   = THIS_MODULE,
 
 		.get_local_cid            = vhost_transport_get_local_cid,
 
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 2a081d19e20d..f10fa918bf23 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -100,6 +100,7 @@ struct vsock_transport_send_notify_data {
 
 struct vsock_transport {
 	uint64_t features;
+	struct module *module;
 
 	/* Initialize/tear-down socket. */
 	int (*init)(struct vsock_sock *, struct vsock_sock *);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c5f46b8242ce..750b62711b01 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -416,13 +416,28 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		return -ESOCKTNOSUPPORT;
 	}
 
-	if (!vsk->transport)
+	/* We increase the module refcnt to prevent the tranport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!vsk->transport || !try_module_get(vsk->transport->module)) {
+		vsk->transport = NULL;
 		return -ENODEV;
+	}
 
 	return vsk->transport->init(vsk, psk);
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
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
 static bool vsock_find_cid(unsigned int cid)
 {
 	if (transport_g2h && cid == transport_g2h->get_local_cid())
@@ -728,8 +743,7 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
-	if (vsk->transport)
-		vsk->transport->destruct(vsk);
+	vsock_deassign_transport(vsk);
 
 	/* When clearing these addresses, there's no need to set the family and
 	 * possibly register the address family with the kernel.
@@ -2161,9 +2175,6 @@ void vsock_core_unregister(const struct vsock_transport *t)
 {
 	mutex_lock(&vsock_register_mutex);
 
-	/* RFC-TODO: maybe we should check if there are open sockets
-	 * assigned to that transport and avoid the unregistration
-	 */
 	if (transport_h2g == t)
 		transport_h2g = NULL;
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 94e6fc905a77..bd4f3c222904 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -857,6 +857,7 @@ int hvs_notify_send_post_enqueue(struct vsock_sock *vsk, ssize_t written,
 
 static struct vsock_transport hvs_transport = {
 	.features                 = VSOCK_TRANSPORT_F_G2H,
+	.module                   = THIS_MODULE,
 
 	.get_local_cid            = hvs_get_local_cid,
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 0ff037ef7f8e..439fe01e6691 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -463,6 +463,7 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
 static struct virtio_transport virtio_transport = {
 	.transport = {
 		.features                 = VSOCK_TRANSPORT_F_G2H,
+		.module                   = THIS_MODULE,
 
 		.get_local_cid            = virtio_transport_get_local_cid,
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 52e63952d0d4..900392686c03 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2021,6 +2021,7 @@ static u32 vmci_transport_get_local_cid(void)
 
 static struct vsock_transport vmci_transport = {
 	.features = VSOCK_TRANSPORT_F_DGRAM | VSOCK_TRANSPORT_F_H2G,
+	.module = THIS_MODULE,
 	.init = vmci_transport_socket_init,
 	.destruct = vmci_transport_destruct,
 	.release = vmci_transport_release,
-- 
2.21.0
