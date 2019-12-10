From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 5/6] vsock: use local transport when it is loaded
Date: Tue, 10 Dec 2019 11:43:06 +0100
Message-ID: <20191210104307.89346-6-sgarzare@redhat.com>
References: <20191210104307.89346-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210104307.89346-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: netdev@vger.kernel.org, davem@davemloft.net
Cc: kvm@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have a transport that can handle the local communication,
we can use it when it is loaded.

A socket will use the local transport (loopback) when the remote
CID is:
- equal to VMADDR_CID_LOCAL
- or equal to transport_g2h->get_local_cid(), if transport_g2h
  is loaded (this allows us to keep the same behavior implemented
  by virtio and vmci transports)
- or equal to VMADDR_CID_HOST, if transport_g2h is not loaded

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1 -> v2:
- use G2H transport when local transport is not loaded and remote cid
  is VMADDR_CID_LOCAL [Stefan]
---
 net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 3da0749a0c97..9c5b2a91baad 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -388,6 +388,21 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
+static bool vsock_use_local_transport(unsigned int remote_cid)
+{
+	if (!transport_local)
+		return false;
+
+	if (remote_cid == VMADDR_CID_LOCAL)
+		return true;
+
+	if (transport_g2h) {
+		return remote_cid == transport_g2h->get_local_cid();
+	} else {
+		return remote_cid == VMADDR_CID_HOST;
+	}
+}
+
 static void vsock_deassign_transport(struct vsock_sock *vsk)
 {
 	if (!vsk->transport)
@@ -404,9 +419,9 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
  * (e.g. during the connect() or when a connection request on a listener
  * socket is received).
  * The vsk->remote_addr is used to decide which transport to use:
+ *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
+ *    g2h is not loaded, will use local transport;
  *  - remote CID <= VMADDR_CID_HOST will use guest->host transport;
- *  - remote CID == local_cid (guest->host transport) will use guest->host
- *    transport for loopback (host->guest transports don't support loopback);
  *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
  */
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
@@ -421,9 +436,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		new_transport = transport_dgram;
 		break;
 	case SOCK_STREAM:
-		if (remote_cid <= VMADDR_CID_HOST ||
-		    (transport_g2h &&
-		     remote_cid == transport_g2h->get_local_cid()))
+		if (vsock_use_local_transport(remote_cid))
+			new_transport = transport_local;
+		else if (remote_cid <= VMADDR_CID_HOST)
 			new_transport = transport_g2h;
 		else
 			new_transport = transport_h2g;
@@ -466,6 +481,9 @@ bool vsock_find_cid(unsigned int cid)
 	if (transport_h2g && cid == VMADDR_CID_HOST)
 		return true;
 
+	if (transport_local && cid == VMADDR_CID_LOCAL)
+		return true;
+
 	return false;
 }
 EXPORT_SYMBOL_GPL(vsock_find_cid);
-- 
2.23.0
