From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC v6 1/6] VSOCK: transport-specific vsock_transport functions
Date: Thu, 28 Jul 2016 15:36:30 +0100
Message-ID: <1469716595-13591-2-git-send-email-stefanha__49221.9988875606$1469716626$gmane$org@redhat.com>
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
index b96ac91..e34d96f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1995,6 +1995,15 @@ void vsock_core_exit(void)
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
2.7.4
