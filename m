From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Wed, 23 Oct 2019 11:55:51 +0200
Message-ID: <20191023095554.11340-12-sgarzare__39473.246997089$1571824743$gmane$org@redhat.com>
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

This patch adds the support of multiple transports in the
VSOCK core.

With the multi-transports support, we can use vsock with nested VMs
(using also different hypervisors) loading both guest->host and
host->guest transports at the same time.

Major changes:
- vsock core module can be loaded regardless of the transports
- vsock_core_init() and vsock_core_exit() are renamed to
  vsock_core_register() and vsock_core_unregister()
- vsock_core_register() has a feature parameter (H2G, G2H, DGRAM)
  to identify which directions the transport can handle and if it's
  support DGRAM (only vmci)
- each stream socket is assigned to a transport when the remote CID
  is set (during the connect() or when we receive a connection request
  on a listener socket).
  The remote CID is used to decide which transport to use:
  - remote CID > VMADDR_CID_HOST will use host->guest transport
  - remote CID <= VMADDR_CID_HOST will use guest->host transport
- listener sockets are not bound to any transports since no transport
  operations are done on it. In this way we can create a listener
  socket, also if the transports are not loaded or with VMADDR_CID_ANY
  to listen on all transports.
- DGRAM sockets are handled as before, since only the vmci_transport
  provides this feature.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
RFC -> v1:
- documented VSOCK_TRANSPORT_F_* flags
- fixed vsock_assign_transport() when the socket is already assigned
  (e.g connection failed)
- moved features outside of struct vsock_transport, and used as
  parameter of vsock_core_register()
---
 drivers/vhost/vsock.c                   |   5 +-
 include/net/af_vsock.h                  |  17 +-
 net/vmw_vsock/af_vsock.c                | 237 ++++++++++++++++++------
 net/vmw_vsock/hyperv_transport.c        |  26 ++-
 net/vmw_vsock/virtio_transport.c        |   7 +-
 net/vmw_vsock/virtio_transport_common.c |  28 ++-
 net/vmw_vsock/vmci_transport.c          |  31 +++-
 7 files changed, 270 insertions(+), 81 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6d7e4f022748..b235f4bbe8ea 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -831,7 +831,8 @@ static int __init vhost_vsock_init(void)
 {
 	int ret;
 
-	ret = vsock_core_init(&vhost_transport.transport);
+	ret = vsock_core_register(&vhost_transport.transport,
+				  VSOCK_TRANSPORT_F_H2G);
 	if (ret < 0)
 		return ret;
 	return misc_register(&vhost_vsock_misc);
@@ -840,7 +841,7 @@ static int __init vhost_vsock_init(void)
 static void __exit vhost_vsock_exit(void)
 {
 	misc_deregister(&vhost_vsock_misc);
-	vsock_core_exit();
+	vsock_core_unregister(&vhost_transport.transport);
 };
 
 module_init(vhost_vsock_init);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index fa1570dc9f5c..27a3463e4892 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -91,6 +91,14 @@ struct vsock_transport_send_notify_data {
 	u64 data2; /* Transport-defined. */
 };
 
+/* Transport features flags */
+/* Transport provides host->guest communication */
+#define VSOCK_TRANSPORT_F_H2G		0x00000001
+/* Transport provides guest->host communication */
+#define VSOCK_TRANSPORT_F_G2H		0x00000002
+/* Transport provides DGRAM communication */
+#define VSOCK_TRANSPORT_F_DGRAM		0x00000004
+
 struct vsock_transport {
 	/* Initialize/tear-down socket. */
 	int (*init)(struct vsock_sock *, struct vsock_sock *);
@@ -154,12 +162,8 @@ struct vsock_transport {
 
 /**** CORE ****/
 
-int __vsock_core_init(const struct vsock_transport *t, struct module *owner);
-static inline int vsock_core_init(const struct vsock_transport *t)
-{
-	return __vsock_core_init(t, THIS_MODULE);
-}
-void vsock_core_exit(void);
+int vsock_core_register(const struct vsock_transport *t, int features);
+void vsock_core_unregister(const struct vsock_transport *t);
 
 /* The transport may downcast this to access transport-specific functions */
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk);
@@ -190,6 +194,7 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
+int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 
 /**** TAP ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d89381166028..dddd85d9a147 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -130,7 +130,12 @@ static struct proto vsock_proto = {
 #define VSOCK_DEFAULT_BUFFER_MAX_SIZE (1024 * 256)
 #define VSOCK_DEFAULT_BUFFER_MIN_SIZE 128
 
-static const struct vsock_transport *transport_single;
+/* Transport used for host->guest communication */
+static const struct vsock_transport *transport_h2g;
+/* Transport used for guest->host communication */
+static const struct vsock_transport *transport_g2h;
+/* Transport used for DGRAM communication */
+static const struct vsock_transport *transport_dgram;
 static DEFINE_MUTEX(vsock_register_mutex);
 
 /**** UTILS ****/
@@ -182,7 +187,7 @@ static int vsock_auto_bind(struct vsock_sock *vsk)
 	return __vsock_bind(sk, &local_addr);
 }
 
-static int __init vsock_init_tables(void)
+static void vsock_init_tables(void)
 {
 	int i;
 
@@ -191,7 +196,6 @@ static int __init vsock_init_tables(void)
 
 	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
 		INIT_LIST_HEAD(&vsock_connected_table[i]);
-	return 0;
 }
 
 static void __vsock_insert_bound(struct list_head *list,
@@ -376,6 +380,62 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
+/* Assign a transport to a socket and call the .init transport callback.
+ *
+ * Note: for stream socket this must be called when vsk->remote_addr is set
+ * (e.g. during the connect() or when a connection request on a listener
+ * socket is received).
+ * The vsk->remote_addr is used to decide which transport to use:
+ *  - remote CID > VMADDR_CID_HOST will use host->guest transport
+ *  - remote CID <= VMADDR_CID_HOST will use guest->host transport
+ */
+int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
+{
+	const struct vsock_transport *new_transport;
+	struct sock *sk = sk_vsock(vsk);
+
+	switch (sk->sk_type) {
+	case SOCK_DGRAM:
+		new_transport = transport_dgram;
+		break;
+	case SOCK_STREAM:
+		if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
+			new_transport = transport_h2g;
+		else
+			new_transport = transport_g2h;
+		break;
+	default:
+		return -ESOCKTNOSUPPORT;
+	}
+
+	if (vsk->transport) {
+		if (vsk->transport == new_transport)
+			return 0;
+
+		vsk->transport->release(vsk);
+		vsk->transport->destruct(vsk);
+	}
+
+	if (!new_transport)
+		return -ENODEV;
+
+	vsk->transport = new_transport;
+
+	return vsk->transport->init(vsk, psk);
+}
+EXPORT_SYMBOL_GPL(vsock_assign_transport);
+
+static bool vsock_find_cid(unsigned int cid)
+{
+	if (transport_g2h && cid == transport_g2h->get_local_cid())
+		return true;
+
+	if (transport_h2g && cid == VMADDR_CID_HOST)
+		return true;
+
+	return false;
+}
+
 static struct sock *vsock_dequeue_accept(struct sock *listener)
 {
 	struct vsock_sock *vlistener;
@@ -414,6 +474,9 @@ static int vsock_send_shutdown(struct sock *sk, int mode)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
+	if (!vsk->transport)
+		return -ENODEV;
+
 	return vsk->transport->shutdown(vsk, mode);
 }
 
@@ -530,7 +593,6 @@ static int __vsock_bind_dgram(struct vsock_sock *vsk,
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
-	u32 cid;
 	int retval;
 
 	/* First ensure this socket isn't already bound. */
@@ -540,10 +602,9 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	/* Now bind to the provided address or select appropriate values if
 	 * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
 	 * like AF_INET prevents binding to a non-local IP address (in most
-	 * cases), we only allow binding to the local CID.
+	 * cases), we only allow binding to a local CID.
 	 */
-	cid = vsk->transport->get_local_cid();
-	if (addr->svm_cid != cid && addr->svm_cid != VMADDR_CID_ANY)
+	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
 		return -EADDRNOTAVAIL;
 
 	switch (sk->sk_socket->type) {
@@ -592,7 +653,6 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
-	vsk->transport = transport_single;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
@@ -629,11 +689,6 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_max_size = VSOCK_DEFAULT_BUFFER_MAX_SIZE;
 	}
 
-	if (vsk->transport->init(vsk, psk) < 0) {
-		sk_free(sk);
-		return NULL;
-	}
-
 	return sk;
 }
 
@@ -650,7 +705,10 @@ static void __vsock_release(struct sock *sk, int level)
 		/* The release call is supposed to use lock_sock_nested()
 		 * rather than lock_sock(), if a sock lock should be acquired.
 		 */
-		vsk->transport->release(vsk);
+		if (vsk->transport)
+			vsk->transport->release(vsk);
+		else if (sk->sk_type == SOCK_STREAM)
+			vsock_remove_sock(vsk);
 
 		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
 		 * version to avoid the warning "possible recursive locking
@@ -679,7 +737,8 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
-	vsk->transport->destruct(vsk);
+	if (vsk->transport)
+		vsk->transport->destruct(vsk);
 
 	/* When clearing these addresses, there's no need to set the family and
 	 * possibly register the address family with the kernel.
@@ -896,7 +955,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 			mask |= EPOLLIN | EPOLLRDNORM;
 
 		/* If there is something in the queue then we can read. */
-		if (transport->stream_is_active(vsk) &&
+		if (transport && transport->stream_is_active(vsk) &&
 		    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
 			bool data_ready_now = false;
 			int ret = transport->notify_poll_in(
@@ -1146,7 +1205,6 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 	err = 0;
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
-	transport = vsk->transport;
 
 	lock_sock(sk);
 
@@ -1174,19 +1232,26 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 			goto out;
 		}
 
+		/* Set the remote address that we are connecting to. */
+		memcpy(&vsk->remote_addr, remote_addr,
+		       sizeof(vsk->remote_addr));
+
+		err = vsock_assign_transport(vsk, NULL);
+		if (err)
+			goto out;
+
+		transport = vsk->transport;
+
 		/* The hypervisor and well-known contexts do not have socket
 		 * endpoints.
 		 */
-		if (!transport->stream_allow(remote_addr->svm_cid,
+		if (!transport ||
+		    !transport->stream_allow(remote_addr->svm_cid,
 					     remote_addr->svm_port)) {
 			err = -ENETUNREACH;
 			goto out;
 		}
 
-		/* Set the remote address that we are connecting to. */
-		memcpy(&vsk->remote_addr, remote_addr,
-		       sizeof(vsk->remote_addr));
-
 		err = vsock_auto_bind(vsk);
 		if (err)
 			goto out;
@@ -1586,7 +1651,7 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 	}
 
-	if (sk->sk_state != TCP_ESTABLISHED ||
+	if (!transport || sk->sk_state != TCP_ESTABLISHED ||
 	    !vsock_addr_bound(&vsk->local_addr)) {
 		err = -ENOTCONN;
 		goto out;
@@ -1712,7 +1777,7 @@ vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	lock_sock(sk);
 
-	if (sk->sk_state != TCP_ESTABLISHED) {
+	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
 		/* Recvmsg is supposed to return 0 if a peer performs an
 		 * orderly shutdown. Differentiate between that case and when a
 		 * peer has not connected or a local shutdown occured with the
@@ -1886,7 +1951,9 @@ static const struct proto_ops vsock_stream_ops = {
 static int vsock_create(struct net *net, struct socket *sock,
 			int protocol, int kern)
 {
+	struct vsock_sock *vsk;
 	struct sock *sk;
+	int ret;
 
 	if (!sock)
 		return -EINVAL;
@@ -1911,7 +1978,17 @@ static int vsock_create(struct net *net, struct socket *sock,
 	if (!sk)
 		return -ENOMEM;
 
-	vsock_insert_unbound(vsock_sk(sk));
+	vsk = vsock_sk(sk);
+
+	if (sock->type == SOCK_DGRAM) {
+		ret = vsock_assign_transport(vsk, NULL);
+		if (ret < 0) {
+			sock_put(sk);
+			return ret;
+		}
+	}
+
+	vsock_insert_unbound(vsk);
 
 	return 0;
 }
@@ -1926,11 +2003,20 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
+	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
-		if (put_user(transport_single->get_local_cid(), p) != 0)
+		/* To be compatible with the VMCI behavior, we prioritize the
+		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
+		 */
+		if (transport_g2h)
+			cid = transport_g2h->get_local_cid();
+		else if (transport_h2g)
+			cid = transport_h2g->get_local_cid();
+
+		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
 		break;
 
@@ -1970,24 +2056,13 @@ static struct miscdevice vsock_device = {
 	.fops		= &vsock_device_ops,
 };
 
-int __vsock_core_init(const struct vsock_transport *t, struct module *owner)
+static int __init vsock_init(void)
 {
-	int err = mutex_lock_interruptible(&vsock_register_mutex);
+	int err = 0;
 
-	if (err)
-		return err;
-
-	if (transport_single) {
-		err = -EBUSY;
-		goto err_busy;
-	}
-
-	/* Transport must be the owner of the protocol so that it can't
-	 * unload while there are open sockets.
-	 */
-	vsock_proto.owner = owner;
-	transport_single = t;
+	vsock_init_tables();
 
+	vsock_proto.owner = THIS_MODULE;
 	vsock_device.minor = MISC_DYNAMIC_MINOR;
 	err = misc_register(&vsock_device);
 	if (err) {
@@ -2008,7 +2083,6 @@ int __vsock_core_init(const struct vsock_transport *t, struct module *owner)
 		goto err_unregister_proto;
 	}
 
-	mutex_unlock(&vsock_register_mutex);
 	return 0;
 
 err_unregister_proto:
@@ -2016,28 +2090,15 @@ int __vsock_core_init(const struct vsock_transport *t, struct module *owner)
 err_deregister_misc:
 	misc_deregister(&vsock_device);
 err_reset_transport:
-	transport_single = NULL;
-err_busy:
-	mutex_unlock(&vsock_register_mutex);
 	return err;
 }
-EXPORT_SYMBOL_GPL(__vsock_core_init);
 
-void vsock_core_exit(void)
+static void __exit vsock_exit(void)
 {
-	mutex_lock(&vsock_register_mutex);
-
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-
-	/* We do not want the assignment below re-ordered. */
-	mb();
-	transport_single = NULL;
-
-	mutex_unlock(&vsock_register_mutex);
 }
-EXPORT_SYMBOL_GPL(vsock_core_exit);
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
 {
@@ -2045,12 +2106,70 @@ const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_core_get_transport);
 
-static void __exit vsock_exit(void)
+int vsock_core_register(const struct vsock_transport *t, int features)
+{
+	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram;
+	int err = mutex_lock_interruptible(&vsock_register_mutex);
+
+	if (err)
+		return err;
+
+	t_h2g = transport_h2g;
+	t_g2h = transport_g2h;
+	t_dgram = transport_dgram;
+
+	if (features & VSOCK_TRANSPORT_F_H2G) {
+		if (t_h2g) {
+			err = -EBUSY;
+			goto err_busy;
+		}
+		t_h2g = t;
+	}
+
+	if (features & VSOCK_TRANSPORT_F_G2H) {
+		if (t_g2h) {
+			err = -EBUSY;
+			goto err_busy;
+		}
+		t_g2h = t;
+	}
+
+	if (features & VSOCK_TRANSPORT_F_DGRAM) {
+		if (t_dgram) {
+			err = -EBUSY;
+			goto err_busy;
+		}
+		t_dgram = t;
+	}
+
+	transport_h2g = t_h2g;
+	transport_g2h = t_g2h;
+	transport_dgram = t_dgram;
+
+err_busy:
+	mutex_unlock(&vsock_register_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(vsock_core_register);
+
+void vsock_core_unregister(const struct vsock_transport *t)
 {
-	/* Do nothing.  This function makes this module removable. */
+	mutex_lock(&vsock_register_mutex);
+
+	if (transport_h2g == t)
+		transport_h2g = NULL;
+
+	if (transport_g2h == t)
+		transport_g2h = NULL;
+
+	if (transport_dgram == t)
+		transport_dgram = NULL;
+
+	mutex_unlock(&vsock_register_mutex);
 }
+EXPORT_SYMBOL_GPL(vsock_core_unregister);
 
-module_init(vsock_init_tables);
+module_init(vsock_init);
 module_exit(vsock_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index fc7e61765a4a..0ea66d87af39 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -165,6 +165,8 @@ static const guid_t srv_id_template =
 	GUID_INIT(0x00000000, 0xfacb, 0x11e6, 0xbd, 0x58,
 		  0x64, 0x00, 0x6a, 0x79, 0x86, 0xd3);
 
+static bool hvs_check_transport(struct vsock_sock *vsk);
+
 static bool is_valid_srv_id(const guid_t *id)
 {
 	return !memcmp(&id->b[4], &srv_id_template.b[4], sizeof(guid_t) - 4);
@@ -367,6 +369,18 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 
 		new->sk_state = TCP_SYN_SENT;
 		vnew = vsock_sk(new);
+
+		hvs_addr_init(&vnew->local_addr, if_type);
+		hvs_remote_addr_init(&vnew->remote_addr, &vnew->local_addr);
+
+		ret = vsock_assign_transport(vnew, vsock_sk(sk));
+		/* Transport assigned (looking at remote_addr) must be the
+		 * same where we received the request.
+		 */
+		if (ret || !hvs_check_transport(vnew)) {
+			sock_put(new);
+			goto out;
+		}
 		hvs_new = vnew->trans;
 		hvs_new->chan = chan;
 	} else {
@@ -430,9 +444,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		new->sk_state = TCP_ESTABLISHED;
 		sk->sk_ack_backlog++;
 
-		hvs_addr_init(&vnew->local_addr, if_type);
-		hvs_remote_addr_init(&vnew->remote_addr, &vnew->local_addr);
-
 		hvs_new->vm_srv_id = *if_type;
 		hvs_new->host_srv_id = *if_instance;
 
@@ -880,6 +891,11 @@ static struct vsock_transport hvs_transport = {
 
 };
 
+static bool hvs_check_transport(struct vsock_sock *vsk)
+{
+	return vsk->transport == &hvs_transport;
+}
+
 static int hvs_probe(struct hv_device *hdev,
 		     const struct hv_vmbus_device_id *dev_id)
 {
@@ -928,7 +944,7 @@ static int __init hvs_init(void)
 	if (ret != 0)
 		return ret;
 
-	ret = vsock_core_init(&hvs_transport);
+	ret = vsock_core_register(&hvs_transport, VSOCK_TRANSPORT_F_G2H);
 	if (ret) {
 		vmbus_driver_unregister(&hvs_drv);
 		return ret;
@@ -939,7 +955,7 @@ static int __init hvs_init(void)
 
 static void __exit hvs_exit(void)
 {
-	vsock_core_exit();
+	vsock_core_unregister(&hvs_transport);
 	vmbus_driver_unregister(&hvs_drv);
 }
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index fb1fc7760e8c..83ad85050384 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -770,7 +770,8 @@ static int __init virtio_vsock_init(void)
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
 
-	ret = vsock_core_init(&virtio_transport.transport);
+	ret = vsock_core_register(&virtio_transport.transport,
+				  VSOCK_TRANSPORT_F_G2H);
 	if (ret)
 		goto out_wq;
 
@@ -781,7 +782,7 @@ static int __init virtio_vsock_init(void)
 	return 0;
 
 out_vci:
-	vsock_core_exit();
+	vsock_core_unregister(&virtio_transport.transport);
 out_wq:
 	destroy_workqueue(virtio_vsock_workqueue);
 	return ret;
@@ -790,7 +791,7 @@ static int __init virtio_vsock_init(void)
 static void __exit virtio_vsock_exit(void)
 {
 	unregister_virtio_driver(&virtio_vsock_driver);
-	vsock_core_exit();
+	vsock_core_unregister(&virtio_transport.transport);
 	destroy_workqueue(virtio_vsock_workqueue);
 }
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f7d0ecbd8f97..b39917eb120e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -453,7 +453,7 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
 
 	vsk->trans = vvs;
 	vvs->vsk = vsk;
-	if (psk) {
+	if (psk && psk->trans) {
 		struct virtio_vsock_sock *ptrans = psk->trans;
 
 		vvs->peer_buf_alloc = ptrans->peer_buf_alloc;
@@ -986,11 +986,13 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 
 /* Handle server socket */
 static int
-virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt)
+virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
+			     struct virtio_transport *t)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 	struct vsock_sock *vchild;
 	struct sock *child;
+	int ret;
 
 	if (le16_to_cpu(pkt->hdr.op) != VIRTIO_VSOCK_OP_REQUEST) {
 		virtio_transport_reset(vsk, pkt);
@@ -1020,6 +1022,17 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt)
 	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(pkt->hdr.src_cid),
 			le32_to_cpu(pkt->hdr.src_port));
 
+	ret = vsock_assign_transport(vchild, vsk);
+	/* Transport assigned (looking at remote_addr) must be the same
+	 * where we received the request.
+	 */
+	if (ret || vchild->transport != &t->transport) {
+		release_sock(child);
+		virtio_transport_reset(vsk, pkt);
+		sock_put(child);
+		return ret;
+	}
+
 	vsock_insert_connected(vchild);
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, pkt);
@@ -1037,6 +1050,14 @@ static bool virtio_transport_space_update(struct sock *sk,
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	bool space_available;
 
+	/* Listener sockets are not associated with any transport, so we are
+	 * not able to take the state to see if there is space available in the
+	 * remote peer, but since they are only used to receive requests, we
+	 * can assume that there is always space available in the other peer.
+	 */
+	if (!vvs)
+		return true;
+
 	/* buf_alloc and fwd_cnt is always included in the hdr */
 	spin_lock_bh(&vvs->tx_lock);
 	vvs->peer_buf_alloc = le32_to_cpu(pkt->hdr.buf_alloc);
@@ -1102,7 +1123,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, pkt);
+		virtio_transport_recv_listen(sk, pkt, t);
 		virtio_transport_free_pkt(pkt);
 		break;
 	case TCP_SYN_SENT:
@@ -1120,6 +1141,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		virtio_transport_free_pkt(pkt);
 		break;
 	}
+
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 5955238ffc13..2eb3f16d53e7 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -57,6 +57,7 @@ static bool vmci_transport_old_proto_override(bool *old_pkt_proto);
 static u16 vmci_transport_new_proto_supported_versions(void);
 static bool vmci_transport_proto_to_notify_struct(struct sock *sk, u16 *proto,
 						  bool old_pkt_proto);
+static bool vmci_check_transport(struct vsock_sock *vsk);
 
 struct vmci_transport_recv_pkt_info {
 	struct work_struct work;
@@ -1017,6 +1018,15 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	vsock_addr_init(&vpending->remote_addr, pkt->dg.src.context,
 			pkt->src_port);
 
+	err = vsock_assign_transport(vpending, vsock_sk(sk));
+	/* Transport assigned (looking at remote_addr) must be the same
+	 * where we received the request.
+	 */
+	if (err || !vmci_check_transport(vpending)) {
+		sock_put(pending);
+		return err;
+	}
+
 	/* If the proposed size fits within our min/max, accept it. Otherwise
 	 * propose our own size.
 	 */
@@ -2008,7 +2018,7 @@ static u32 vmci_transport_get_local_cid(void)
 	return vmci_get_context_id();
 }
 
-static const struct vsock_transport vmci_transport = {
+static struct vsock_transport vmci_transport = {
 	.init = vmci_transport_socket_init,
 	.destruct = vmci_transport_destruct,
 	.release = vmci_transport_release,
@@ -2038,10 +2048,25 @@ static const struct vsock_transport vmci_transport = {
 	.get_local_cid = vmci_transport_get_local_cid,
 };
 
+static bool vmci_check_transport(struct vsock_sock *vsk)
+{
+	return vsk->transport == &vmci_transport;
+}
+
 static int __init vmci_transport_init(void)
 {
+	int features = VSOCK_TRANSPORT_F_DGRAM | VSOCK_TRANSPORT_F_H2G;
+	int cid;
 	int err;
 
+	cid = vmci_get_context_id();
+
+	if (cid == VMCI_INVALID_ID)
+		return -EINVAL;
+
+	if (cid != VMCI_HOST_CONTEXT_ID)
+		features |= VSOCK_TRANSPORT_F_G2H;
+
 	/* Create the datagram handle that we will use to send and receive all
 	 * VSocket control messages for this context.
 	 */
@@ -2065,7 +2090,7 @@ static int __init vmci_transport_init(void)
 		goto err_destroy_stream_handle;
 	}
 
-	err = vsock_core_init(&vmci_transport);
+	err = vsock_core_register(&vmci_transport, features);
 	if (err < 0)
 		goto err_unsubscribe;
 
@@ -2096,7 +2121,7 @@ static void __exit vmci_transport_exit(void)
 		vmci_transport_qp_resumed_sub_id = VMCI_INVALID_ID;
 	}
 
-	vsock_core_exit();
+	vsock_core_unregister(&vmci_transport);
 }
 module_exit(vmci_transport_exit);
 
-- 
2.21.0
