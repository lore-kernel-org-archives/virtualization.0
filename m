From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 2/6] vsock: add VMADDR_CID_LOCAL definition
Date: Tue, 10 Dec 2019 11:43:03 +0100
Message-ID: <20191210104307.89346-3-sgarzare@redhat.com>
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

The VMADDR_CID_RESERVED (1) was used by VMCI, but now it is not
used anymore, so we can reuse it for local communication
(loopback) adding the new well-know CID: VMADDR_CID_LOCAL.

Cc: Jorgen Hansen <jhansen@vmware.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vm_sockets.h | 8 +++++---
 net/vmw_vsock/vmci_transport.c  | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index 68d57c5e99bc..fd0ed7221645 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -99,11 +99,13 @@
 
 #define VMADDR_CID_HYPERVISOR 0
 
-/* This CID is specific to VMCI and can be considered reserved (even VMCI
- * doesn't use it anymore, it's a legacy value from an older release).
+/* Use this as the destination CID in an address when referring to the
+ * local communication (loopback).
+ * (This was VMADDR_CID_RESERVED, but even VMCI doesn't use it anymore,
+ * it was a legacy value from an older release).
  */
 
-#define VMADDR_CID_RESERVED 1
+#define VMADDR_CID_LOCAL 1
 
 /* Use this as the destination CID in an address when referring to the host
  * (any process other than the hypervisor).  VMCI relies on it being 2, but
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 644d32e43d23..4b8b1150a738 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -648,7 +648,7 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 static bool vmci_transport_stream_allow(u32 cid, u32 port)
 {
 	static const u32 non_socket_contexts[] = {
-		VMADDR_CID_RESERVED,
+		VMADDR_CID_LOCAL,
 	};
 	int i;
 
-- 
2.23.0
