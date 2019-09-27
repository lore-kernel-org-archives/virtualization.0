From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 08/13] vsock: move vsock_insert_unbound() in the
	vsock_create()
Date: Fri, 27 Sep 2019 13:26:58 +0200
Message-ID: <20190927112703.17745-9-sgarzare__38779.1853559733$1569583735$gmane$org@redhat.com>
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

vsock_insert_unbound() was called only when 'sock' parameter of
__vsock_create() was not null. This only happened when
__vsock_create() was called by vsock_create().

In order to simplify the multi-transports support, this patch
moves vsock_insert_unbound() at the end of vsock_create().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index dee69d7ee148..95e6db21e7e1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -634,9 +634,6 @@ struct sock *__vsock_create(struct net *net,
 		return NULL;
 	}
 
-	if (sock)
-		vsock_insert_unbound(vsk);
-
 	return sk;
 }
 EXPORT_SYMBOL_GPL(__vsock_create);
@@ -1875,6 +1872,8 @@ static const struct proto_ops vsock_stream_ops = {
 static int vsock_create(struct net *net, struct socket *sock,
 			int protocol, int kern)
 {
+	struct sock *sk;
+
 	if (!sock)
 		return -EINVAL;
 
@@ -1894,7 +1893,13 @@ static int vsock_create(struct net *net, struct socket *sock,
 
 	sock->state = SS_UNCONNECTED;
 
-	return __vsock_create(net, sock, NULL, GFP_KERNEL, 0, kern) ? 0 : -ENOMEM;
+	sk = __vsock_create(net, sock, NULL, GFP_KERNEL, 0, kern);
+	if (!sk)
+		return -ENOMEM;
+
+	vsock_insert_unbound(vsock_sk(sk));
+
+	return 0;
 }
 
 static const struct net_proto_family vsock_family_ops = {
-- 
2.21.0
