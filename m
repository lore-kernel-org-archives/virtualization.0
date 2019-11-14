From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 14/15] vsock: fix bind() behaviour taking care of
	CID
Date: Thu, 14 Nov 2019 10:57:49 +0100
Message-ID: <20191114095750.59106-15-sgarzare__32661.9872286514$1573725703$gmane$org@redhat.com>
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

When we are looking for a socket bound to a specific address,
we also have to take into account the CID.

This patch is useful with multi-transports support because it
allows the binding of the same port with different CID, and
it prevents a connection to a wrong socket bound to the same
port, but with different CID.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cb0ae42d916..cc8659838bf2 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -228,10 +228,16 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
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
