From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 11/13] vsock: add 'transport_hg' to handle g2h\h2g
	transports
Date: Fri, 27 Sep 2019 13:27:01 +0200
Message-ID: <20190927112703.17745-12-sgarzare__39507.9075171211$1569583763$gmane$org@redhat.com>
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

VMCI transport provides both g2h and h2g behaviors in a single
transport.
We are able to set (or not) the g2h behavior, detecting if we
are in a VMware guest (or not), but the h2g feature is always set.
This prevents to load other h2g transports while we are in a
VMware guest.

This patch adds a new 'transport_hg' to handle this case, reducing
the priority of transports that provide both g2h and h2g
behaviors. A transport that has g2h and h2g features, can be
bypassed by a transport that has only the h2g feature.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c52203fe52c4..c5f46b8242ce 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -134,6 +134,8 @@ static struct proto vsock_proto = {
 static const struct vsock_transport *transport_h2g;
 /* Transport used for guest->host communication */
 static const struct vsock_transport *transport_g2h;
+/* Transport used for both host->guest and guest->host communication */
+static const struct vsock_transport *transport_hg;
 /* Transport used for DGRAM communication */
 static const struct vsock_transport *transport_dgram;
 static DEFINE_MUTEX(vsock_register_mutex);
@@ -402,10 +404,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->transport = transport_dgram;
 		break;
 	case SOCK_STREAM:
-		if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
+		if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST) {
 			vsk->transport = transport_h2g;
-		else
+			if (!vsk->transport)
+				vsk->transport = transport_hg;
+		} else {
 			vsk->transport = transport_g2h;
+		}
 		break;
 	default:
 		return -ESOCKTNOSUPPORT;
@@ -423,7 +428,7 @@ static bool vsock_find_cid(unsigned int cid)
 	if (transport_g2h && cid == transport_g2h->get_local_cid())
 		return true;
 
-	if (transport_h2g && cid == VMADDR_CID_HOST)
+	if ((transport_h2g || transport_hg) && cid == VMADDR_CID_HOST)
 		return true;
 
 	return false;
@@ -1997,6 +2002,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			cid = transport_g2h->get_local_cid();
 		else if (transport_h2g)
 			cid = transport_h2g->get_local_cid();
+		else if (transport_hg)
+			cid = transport_hg->get_local_cid();
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;
@@ -2093,13 +2100,14 @@ EXPORT_SYMBOL_GPL(vsock_core_get_transport);
 
 int vsock_core_register(const struct vsock_transport *t)
 {
-	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram;
+	const struct vsock_transport *t_h2g, *t_hg, *t_g2h, *t_dgram;
 	int err = mutex_lock_interruptible(&vsock_register_mutex);
 
 	if (err)
 		return err;
 
 	t_h2g = transport_h2g;
+	t_hg = transport_hg;
 	t_g2h = transport_g2h;
 	t_dgram = transport_dgram;
 
@@ -2107,7 +2115,14 @@ int vsock_core_register(const struct vsock_transport *t)
 	 * same transport. We are able to set the G2H feature only if we are
 	 * in a VMware guest, but we are not able to do the same for the host.
 	 */
-	if (t->features & VSOCK_TRANSPORT_F_H2G) {
+	if ((t->features & VSOCK_TRANSPORT_F_H2G) &&
+	    (t->features & VSOCK_TRANSPORT_F_G2H)) {
+		if (t_hg) {
+			err = -EBUSY;
+			goto err_busy;
+		}
+		t_hg = t;
+	} else if (t->features & VSOCK_TRANSPORT_F_H2G) {
 		if (t_h2g) {
 			err = -EBUSY;
 			goto err_busy;
@@ -2132,6 +2147,7 @@ int vsock_core_register(const struct vsock_transport *t)
 	}
 
 	transport_h2g = t_h2g;
+	transport_hg = t_hg;
 	transport_g2h = t_g2h;
 	transport_dgram = t_dgram;
 
@@ -2151,6 +2167,9 @@ void vsock_core_unregister(const struct vsock_transport *t)
 	if (transport_h2g == t)
 		transport_h2g = NULL;
 
+	if (transport_hg == t)
+		transport_hg = NULL;
+
 	if (transport_g2h == t)
 		transport_g2h = NULL;
 
-- 
2.21.0
