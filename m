From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next 13/14] vsock: prevent transport modules unloading
Date: Wed, 23 Oct 2019 11:55:53 +0200
Message-ID: <20191023095554.11340-14-sgarzare__38868.0002697342$1571824760$gmane$org@redhat.com>
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

This patch adds 'module' member in the 'struct vsock_transport'
in order to get/put the transport module. This prevents the
module unloading while sockets are assigned to it.

We increase the module refcnt when a socket is assigned to a
transport, and we decrease the module refcnt when the socket
is destructed.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
RFC -> v1:
- fixed typo 's/tranport/transport/' in a comment (Stefan)
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
index 27a3463e4892..269e2f034789 100644
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
index dddd85d9a147..1f2e707cae66 100644
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
@@ -413,10 +423,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
@@ -737,8 +750,7 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
-	if (vsk->transport)
-		vsk->transport->destruct(vsk);
+	vsock_deassign_transport(vsk);
 
 	/* When clearing these addresses, there's no need to set the family and
 	 * possibly register the address family with the kernel.
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 0ea66d87af39..d0a349d85414 100644
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
index 04437f822d82..0cbf023fae11 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -2019,6 +2019,7 @@ static u32 vmci_transport_get_local_cid(void)
 }
 
 static struct vsock_transport vmci_transport = {
+	.module = THIS_MODULE,
 	.init = vmci_transport_socket_init,
 	.destruct = vmci_transport_destruct,
 	.release = vmci_transport_release,
-- 
2.21.0
