From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 20/20] vhost: 64 bit features
Date: Thu, 11 Dec 2014 14:25:22 +0100
Message-ID: <1418304322-7546-21-git-send-email-cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Make sure that all vhost interfaces use 64 bit features, as the virtio
core does, and make sure to use ULL everywhere possible to be on the
safe side.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/net/vhost_net.c        |   12 ++++++------
 hw/virtio/vhost.c         |   14 +++++++-------
 include/hw/virtio/vhost.h |    6 +++---
 include/net/vhost_net.h   |    4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 4e3a061..a6d4ef2 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -107,13 +107,13 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
     return feature_bits;
 }
 
-unsigned vhost_net_get_features(struct vhost_net *net, unsigned features)
+uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
 {
     return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
             features);
 }
 
-void vhost_net_ack_features(struct vhost_net *net, unsigned features)
+void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
     net->dev.acked_features = net->dev.backend_features;
     vhost_ack_features(&net->dev, vhost_net_get_feature_bits(net), features);
@@ -147,7 +147,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
         net->dev.backend_features = qemu_has_vnet_hdr(options->net_backend)
-            ? 0 : (1 << VHOST_NET_F_VIRTIO_NET_HDR);
+            ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
         net->backend = r;
     } else {
         net->dev.backend_features = 0;
@@ -166,7 +166,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     if (backend_kernel) {
         if (!qemu_has_vnet_hdr_len(options->net_backend,
                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
-            net->dev.features &= ~(1 << VIRTIO_NET_F_MRG_RXBUF);
+            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
         if (~net->dev.features & net->dev.backend_features) {
             fprintf(stderr, "vhost lacks feature mask %" PRIu64
@@ -423,11 +423,11 @@ void vhost_net_cleanup(struct vhost_net *net)
 {
 }
 
-unsigned vhost_net_get_features(struct vhost_net *net, unsigned features)
+uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
 {
     return features;
 }
-void vhost_net_ack_features(struct vhost_net *net, unsigned features)
+void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
 }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5a12861..9e6e9cc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -551,7 +551,7 @@ static int vhost_dev_set_features(struct vhost_dev *dev, bool enable_log)
     uint64_t features = dev->acked_features;
     int r;
     if (enable_log) {
-        features |= 0x1 << VHOST_F_LOG_ALL;
+        features |= 0x1ULL << VHOST_F_LOG_ALL;
     }
     r = dev->vhost_ops->vhost_call(dev, VHOST_SET_FEATURES, &features);
     return r < 0 ? -errno : 0;
@@ -860,7 +860,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .priority = 10
     };
     hdev->migration_blocker = NULL;
-    if (!(hdev->features & (0x1 << VHOST_F_LOG_ALL))) {
+    if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
         error_setg(&hdev->migration_blocker,
                    "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
         migrate_add_blocker(hdev->migration_blocker);
@@ -1003,12 +1003,12 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
     assert(r >= 0);
 }
 
-unsigned vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
-        unsigned features)
+uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
+                            uint64_t features)
 {
     const int *bit = feature_bits;
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        unsigned bit_mask = (1 << *bit);
+        uint64_t bit_mask = (1ULL << *bit);
         if (!(hdev->features & bit_mask)) {
             features &= ~bit_mask;
         }
@@ -1018,11 +1018,11 @@ unsigned vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
 }
 
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
-        unsigned features)
+                        uint64_t features)
 {
     const int *bit = feature_bits;
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        unsigned bit_mask = (1 << *bit);
+        uint64_t bit_mask = (1ULL << *bit);
         if (features & bit_mask) {
             hdev->acked_features |= bit_mask;
         }
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index d5593d1..71ef18f 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -72,8 +72,8 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
  */
 void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
                           bool mask);
-unsigned vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
-        unsigned features);
+uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
+                            uint64_t features);
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
-        unsigned features);
+                        uint64_t features);
 #endif
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index b1c18a3..9eb493e 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -22,8 +22,8 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs, int total_queues);
 
 void vhost_net_cleanup(VHostNetState *net);
 
-unsigned vhost_net_get_features(VHostNetState *net, unsigned features);
-void vhost_net_ack_features(VHostNetState *net, unsigned features);
+uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
+void vhost_net_ack_features(VHostNetState *net, uint64_t features);
 
 bool vhost_net_virtqueue_pending(VHostNetState *net, int n);
 void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
-- 
1.7.9.5
