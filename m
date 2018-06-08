From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR support
Date: Fri,  8 Jun 2018 11:50:42 +0800
Message-ID: <1528429842-22835-1-git-send-email-jasowang__12111.7569077343$1528429749$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
a userpsace want to enable VRITIO_F_ANY_LAYOUT,
VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
break networking. Fixing this by safely removing
VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
no userspace can use this. Further cleanups could be done for
-net-next for safety.

In the future, we need a vhost dedicated feature set/get ioctl()
instead of reusing virtio ones.

Fixes: 4e9fa50c6ccbe ("vhost: move features to core")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 986058a..83eef52 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,7 +69,6 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
-			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
 			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
 };
@@ -1255,15 +1254,11 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 			       (1ULL << VIRTIO_F_VERSION_1))) ?
 			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 			sizeof(struct virtio_net_hdr);
-	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
-		/* vhost provides vnet_hdr */
-		vhost_hlen = hdr_len;
-		sock_hlen = 0;
-	} else {
-		/* socket provides vnet_hdr */
-		vhost_hlen = 0;
-		sock_hlen = hdr_len;
-	}
+
+        /* socket provides vnet_hdr */
+	vhost_hlen = 0;
+	sock_hlen = hdr_len;
+
 	mutex_lock(&n->dev.mutex);
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&n->dev))
-- 
2.7.4
