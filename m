From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC v6 2/6] VSOCK: defer sock removal to transports
Date: Thu, 28 Jul 2016 15:36:31 +0100
Message-ID: <1469716595-13591-3-git-send-email-stefanha__43783.2111878835$1469716632$gmane$org@redhat.com>
References: <1469716595-13591-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1469716595-13591-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: marius vlad <marius.vlad0@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Ian Campbell <ian.campbell@docker.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, ggarcia@abra.uab.cat, Matt Benjamin <mbenjamin@redhat.com>, Greg Kurz <gkurz@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

The virtio transport will implement graceful shutdown and the related
SO_LINGER socket option.  This requires orphaning the sock but keeping
it in the table of connections after .release().

This patch adds the vsock_remove_sock() function and leaves it up to the
transport when to remove the sock.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/net/af_vsock.h         |  1 +
 net/vmw_vsock/af_vsock.c       | 16 ++++++++++------
 net/vmw_vsock/vmci_transport.c |  2 ++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 23f5525..3af0b22 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -180,6 +180,7 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
 
 #endif /* __AF_VSOCK_H__ */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e34d96f..17dbbe6 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -344,6 +344,16 @@ static bool vsock_in_connected_table(struct vsock_sock *vsk)
 	return ret;
 }
 
+void vsock_remove_sock(struct vsock_sock *vsk)
+{
+	if (vsock_in_bound_table(vsk))
+		vsock_remove_bound(vsk);
+
+	if (vsock_in_connected_table(vsk))
+		vsock_remove_connected(vsk);
+}
+EXPORT_SYMBOL_GPL(vsock_remove_sock);
+
 void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
 {
 	int i;
@@ -660,12 +670,6 @@ static void __vsock_release(struct sock *sk)
 		vsk = vsock_sk(sk);
 		pending = NULL;	/* Compiler warning. */
 
-		if (vsock_in_bound_table(vsk))
-			vsock_remove_bound(vsk);
-
-		if (vsock_in_connected_table(vsk))
-			vsock_remove_connected(vsk);
-
 		transport->release(vsk);
 
 		lock_sock(sk);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4120b7a..4be4fbb 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1644,6 +1644,8 @@ static void vmci_transport_destruct(struct vsock_sock *vsk)
 
 static void vmci_transport_release(struct vsock_sock *vsk)
 {
+	vsock_remove_sock(vsk);
+
 	if (!vmci_handle_is_invalid(vmci_trans(vsk)->dg_handle)) {
 		vmci_datagram_destroy_handle(vmci_trans(vsk)->dg_handle);
 		vmci_trans(vsk)->dg_handle = VMCI_INVALID_HANDLE;
-- 
2.7.4
