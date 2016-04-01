From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC v5 1/5] VSOCK: transport-specific vsock_transport functions
Date: Fri,  1 Apr 2016 15:23:03 +0100
Message-ID: <1459520587-12337-2-git-send-email-stefanha__28498.999894555$1459520610$gmane$org@redhat.com>
References: <1459520587-12337-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459520587-12337-1-git-send-email-stefanha@redhat.com>
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
Cc: marius vlad <marius.vlad0@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Ian Campbell <ian.campbell@docker.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Matt Benjamin <mbenjamin@redhat.com>, Greg Kurz <gkurz@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

struct vsock_transport contains function pointers called by AF_VSOCK
core code.  The transport may want its own transport-specific function
pointers and they can be added after struct vsock_transport.

Allow the transport to fetch vsock_transport.  It can downcast it to
access transport-specific function pointers.

The virtio transport will use this.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/net/af_vsock.h   | 3 +++
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e9eb2d6..23f5525 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -165,6 +165,9 @@ static inline int vsock_core_init(const struct vsock_transport *t)
 }
 void vsock_core_exit(void);
 
+/* The transport may downcast this to access transport-specific functions */
+const struct vsock_transport *vsock_core_get_transport(void);
+
 /**** UTILS ****/
 
 void vsock_release_pending(struct sock *pending);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index bbe65dc..1e5f5ed 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1987,6 +1987,15 @@ void vsock_core_exit(void)
 }
 EXPORT_SYMBOL_GPL(vsock_core_exit);
 
+const struct vsock_transport *vsock_core_get_transport(void)
+{
+	/* vsock_register_mutex not taken since only the transport uses this
+	 * function and only while registered.
+	 */
+	return transport;
+}
+EXPORT_SYMBOL_GPL(vsock_core_get_transport);
+
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Socket Family");
 MODULE_VERSION("1.0.1.0-k");
-- 
2.5.5
