From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 09/13] hv_sock: set VMADDR_CID_HOST in the
	hvs_remote_addr_init()
Date: Fri, 27 Sep 2019 13:26:59 +0200
Message-ID: <20190927112703.17745-10-sgarzare__47876.4881541551$1569583743$gmane$org@redhat.com>
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

Remote peer is always the host, so we set VMADDR_CID_HOST as
remote CID instead of VMADDR_CID_ANY.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/hyperv_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 4f47af2054dd..306310794522 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -186,7 +186,8 @@ static void hvs_remote_addr_init(struct sockaddr_vm *remote,
 	static u32 host_ephemeral_port = MIN_HOST_EPHEMERAL_PORT;
 	struct sock *sk;
 
-	vsock_addr_init(remote, VMADDR_CID_ANY, VMADDR_PORT_ANY);
+	/* Remote peer is always the host */
+	vsock_addr_init(remote, VMADDR_CID_HOST, VMADDR_PORT_ANY);
 
 	while (1) {
 		/* Wrap around ? */
-- 
2.21.0
