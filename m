From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 3/6] vsock: add local transport support in the
 vsock core
Date: Tue, 10 Dec 2019 11:43:04 +0100
Message-ID: <20191210104307.89346-4-sgarzare__31592.9542922944$1575974621$gmane$org@redhat.com>
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

This patch allows to register a transport able to handle
local communication (loopback).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h   |  2 ++
 net/vmw_vsock/af_vsock.c | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 4206dc6d813f..b1c717286993 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -98,6 +98,8 @@ struct vsock_transport_send_notify_data {
 #define VSOCK_TRANSPORT_F_G2H		0x00000002
 /* Transport provides DGRAM communication */
 #define VSOCK_TRANSPORT_F_DGRAM		0x00000004
+/* Transport provides local (loopback) communication */
+#define VSOCK_TRANSPORT_F_LOCAL		0x00000008
 
 struct vsock_transport {
 	struct module *module;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 74db4cd637a7..3da0749a0c97 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -136,6 +136,8 @@ static const struct vsock_transport *transport_h2g;
 static const struct vsock_transport *transport_g2h;
 /* Transport used for DGRAM communication */
 static const struct vsock_transport *transport_dgram;
+/* Transport used for local communication */
+static const struct vsock_transport *transport_local;
 static DEFINE_MUTEX(vsock_register_mutex);
 
 /**** UTILS ****/
@@ -2137,7 +2139,7 @@ EXPORT_SYMBOL_GPL(vsock_core_get_transport);
 
 int vsock_core_register(const struct vsock_transport *t, int features)
 {
-	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram;
+	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
 	int err = mutex_lock_interruptible(&vsock_register_mutex);
 
 	if (err)
@@ -2146,6 +2148,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 	t_h2g = transport_h2g;
 	t_g2h = transport_g2h;
 	t_dgram = transport_dgram;
+	t_local = transport_local;
 
 	if (features & VSOCK_TRANSPORT_F_H2G) {
 		if (t_h2g) {
@@ -2171,9 +2174,18 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 		t_dgram = t;
 	}
 
+	if (features & VSOCK_TRANSPORT_F_LOCAL) {
+		if (t_local) {
+			err = -EBUSY;
+			goto err_busy;
+		}
+		t_local = t;
+	}
+
 	transport_h2g = t_h2g;
 	transport_g2h = t_g2h;
 	transport_dgram = t_dgram;
+	transport_local = t_local;
 
 err_busy:
 	mutex_unlock(&vsock_register_mutex);
@@ -2194,6 +2206,9 @@ void vsock_core_unregister(const struct vsock_transport *t)
 	if (transport_dgram == t)
 		transport_dgram = NULL;
 
+	if (transport_local == t)
+		transport_local = NULL;
+
 	mutex_unlock(&vsock_register_mutex);
 }
 EXPORT_SYMBOL_GPL(vsock_core_unregister);
-- 
2.23.0
