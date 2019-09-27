From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 13/13] vsock: fix bind() behaviour taking care of CID
Date: Fri, 27 Sep 2019 13:27:03 +0200
Message-ID: <20190927112703.17745-14-sgarzare__21298.6568965547$1569583785$gmane$org@redhat.com>
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

When we are looking for a socket bound to a specific address,
we also have to take into account the CID.

This patch is useful with multi-transports support because it
allows the binding of the same port with different CID, and
it prevents a connection to a wrong socket bound to the same
port, but with different CID.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 750b62711b01..bffa6fa7b8e5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -230,10 +230,16 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 {
 	struct vsock_sock *vsk;
 
-	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table)
-		if (addr->svm_port == vsk->local_addr.svm_port)
+	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
+		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
 			return sk_vsock(vsk);
 
+		if (addr->svm_port == vsk->local_addr.svm_port &&
+		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
+		     addr->svm_cid == VMADDR_CID_ANY))
+			return sk_vsock(vsk);
+	}
+
 	return NULL;
 }
 
-- 
2.21.0
