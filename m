From: Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VSOCK: Don't call vsock_stream_has_data in atomic context
Date: Tue, 21 Nov 2017 02:46:24 -0800
Message-ID: <1511261184-45913-1-git-send-email-jhansen@vmware.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <y>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, davem@davemloft.net, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

When using the host personality, VMCI will grab a mutex for any
queue pair access. In the detach callback for the vmci vsock
transport, we call vsock_stream_has_data while holding a spinlock,
and vsock_stream_has_data will access a queue pair.

To avoid this, we can simply omit calling vsock_stream_has_data
for host side queue pairs, since the QPs are empty per default
when the guest has detached.

This bug affects users of VMware Workstation using kernel version
4.4 and later.

Testing: Ran vsock tests between guest and host, and verified that
with this change, the host isn't calling vsock_stream_has_data
during detach. Ran mixedTest between guest and host using both
guest and host as server.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 net/vmw_vsock/vmci_transport.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 10ae782..90bc1a7 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -798,9 +798,13 @@ static void vmci_transport_handle_detach(struct sock *sk)
 
 		/* We should not be sending anymore since the peer won't be
 		 * there to receive, but we can still receive if there is data
-		 * left in our consume queue.
+		 * left in our consume queue. If the local endpoint is a host,
+		 * we can't call vsock_stream_has_data, since that may block,
+		 * but a host endpoint can't read data once the VM has
+		 * detached, so there is no available data in that case.
 		 */
-		if (vsock_stream_has_data(vsk) <= 0) {
+		if (vsk->local_addr.svm_cid == VMADDR_CID_HOST ||
+		    vsock_stream_has_data(vsk) <= 0) {
 			if (sk->sk_state == SS_CONNECTING) {
 				/* The peer may detach from a queue pair while
 				 * we are still in the connecting state, i.e.,
@@ -2145,7 +2149,7 @@ static void __exit vmci_transport_exit(void)
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMCI transport for Virtual Sockets");
-MODULE_VERSION("1.0.4.0-k");
+MODULE_VERSION("1.0.5.0-k");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("vmware_vsock");
 MODULE_ALIAS_NETPROTO(PF_VSOCK);
-- 
1.7.0
