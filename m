From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vhost: vdpa: remove per device feature whitelist
Date: Mon, 20 Jul 2020 16:50:43 +0800
Message-ID: <20200720085043.16485-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eli@mellanox.com, lulu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We used to have a per device feature whitelist to filter out the
unsupported virtio features. But this seems unnecessary since:

- the main idea behind feature whitelist is to block control vq
  feature until we finalize the control virtqueue API. But the current
  vhost-vDPA uAPI is sufficient to support control virtqueue. For
  device that has hardware control virtqueue, the vDPA device driver
  can just setup the hardware virtqueue and let userspace to use
  hardware virtqueue directly. For device that doesn't have a control
  virtqueue, the vDPA device driver need to use e.g vringh to emulate
  a software control virtqueue.
- we don't do it in virtio-vDPA driver

So remove this limitation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 77a0c9fb6cc3..f7f6ddd681ce 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -26,35 +26,6 @@
 
 #include "vhost.h"
 
-enum {
-	VHOST_VDPA_FEATURES =
-		(1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
-		(1ULL << VIRTIO_F_ANY_LAYOUT) |
-		(1ULL << VIRTIO_F_VERSION_1) |
-		(1ULL << VIRTIO_F_IOMMU_PLATFORM) |
-		(1ULL << VIRTIO_F_RING_PACKED) |
-		(1ULL << VIRTIO_F_ORDER_PLATFORM) |
-		(1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-		(1ULL << VIRTIO_RING_F_EVENT_IDX),
-
-	VHOST_VDPA_NET_FEATURES = VHOST_VDPA_FEATURES |
-		(1ULL << VIRTIO_NET_F_CSUM) |
-		(1ULL << VIRTIO_NET_F_GUEST_CSUM) |
-		(1ULL << VIRTIO_NET_F_MTU) |
-		(1ULL << VIRTIO_NET_F_MAC) |
-		(1ULL << VIRTIO_NET_F_GUEST_TSO4) |
-		(1ULL << VIRTIO_NET_F_GUEST_TSO6) |
-		(1ULL << VIRTIO_NET_F_GUEST_ECN) |
-		(1ULL << VIRTIO_NET_F_GUEST_UFO) |
-		(1ULL << VIRTIO_NET_F_HOST_TSO4) |
-		(1ULL << VIRTIO_NET_F_HOST_TSO6) |
-		(1ULL << VIRTIO_NET_F_HOST_ECN) |
-		(1ULL << VIRTIO_NET_F_HOST_UFO) |
-		(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-		(1ULL << VIRTIO_NET_F_STATUS) |
-		(1ULL << VIRTIO_NET_F_SPEED_DUPLEX),
-};
-
 /* Currently, only network backend w/o multiqueue is supported. */
 #define VHOST_VDPA_VQ_MAX	2
 
@@ -79,10 +50,6 @@ static DEFINE_IDA(vhost_vdpa_ida);
 
 static dev_t vhost_vdpa_major;
 
-static const u64 vhost_vdpa_features[] = {
-	[VIRTIO_ID_NET] = VHOST_VDPA_NET_FEATURES,
-};
-
 static void handle_vq_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -255,7 +222,6 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 	u64 features;
 
 	features = ops->get_features(vdpa);
-	features &= vhost_vdpa_features[v->virtio_id];
 
 	if (copy_to_user(featurep, &features, sizeof(features)))
 		return -EFAULT;
@@ -279,9 +245,6 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (copy_from_user(&features, featurep, sizeof(features)))
 		return -EFAULT;
 
-	if (features & ~vhost_vdpa_features[v->virtio_id])
-		return -EINVAL;
-
 	if (ops->set_features(vdpa, features))
 		return -EINVAL;
 
-- 
2.20.1
