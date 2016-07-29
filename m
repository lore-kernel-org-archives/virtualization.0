From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5] virtio: new feature to detect IOMMU device quirk
Date: Fri, 29 Jul 2016 06:08:58 +0300
Message-ID: <1469761579-26763-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The interaction between virtio and IOMMUs is messy.

On most systems with virtio, physical addresses match bus addresses,
and it doesn't particularly matter which one we use to program
the device.

On some systems, including Xen and any system with a physical device
that speaks virtio behind a physical IOMMU, we must program the IOMMU
for virtio DMA to work at all.

On other systems, including SPARC and PPC64, virtio-pci devices are
enumerated as though they are behind an IOMMU, but the virtio host
ignores the IOMMU, so we must either pretend that the IOMMU isn't
there or somehow map everything as the identity.

Add a feature bit to detect that quirk: VIRTIO_F_IOMMU_PLATFORM.

Any device with this feature bit set to 0 needs a quirk and has to be
passed physical addresses (as opposed to bus addresses) even though
the device is behind an IOMMU.

Note: it has to be a per-device quirk because for example, there could
be a mix of passed-through and virtual virtio devices. As another
example, some devices could be implemented by an out of process
hypervisor backend (in case of qemu vhost, or vhost-user) and so support
for an IOMMU needs to be coded up separately.

It would be cleanest to handle this in IOMMU core code, but that needs
per-device DMA ops. While we are waiting for that to be implemented, use
a work-around in virtio core.

Note: a "noiommu" feature is a quirk - add a wrapper to make
that clear.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v4:
        Clarify that iommu quirk is the feature, even though we use
	register value 0 to detect this (for compatibility).

Changes from v3:
        In response to Christoph's comments, add TODO so we remember to
        move this into DMA core.  Definitely something we want to do but doesn't
        seem practical for this release cycle.


 include/linux/virtio_config.h      | 13 +++++++++++++
 include/uapi/linux/virtio_config.h | 10 +++++++++-
 drivers/virtio/virtio_ring.c       | 15 ++++++++++++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6e6cb0c..26c155b 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -149,6 +149,19 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return __virtio_test_bit(vdev, fbit);
 }
 
+/**
+ * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
+ * @vdev: the device
+ */
+static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
+{
+	/*
+	 * Note the reverse polarity of the quirk feature (compared to most
+	 * other features), this is for compatibility with legacy systems.
+	 */
+	return !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+}
+
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 4cb65bb..308e209 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		33
+#define VIRTIO_TRANSPORT_F_END		34
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -63,4 +63,12 @@
 /* v1.0 compliant. */
 #define VIRTIO_F_VERSION_1		32
 
+/*
+ * If clear - device has the IOMMU bypass quirk feature.
+ * If set - use platform tools to detect the IOMMU.
+ *
+ * Note the reverse polarity (compared to most other features),
+ * this is for compatibility with legacy systems.
+ */
+#define VIRTIO_F_IOMMU_PLATFORM		33
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ca6bfdd..114a0c8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -117,7 +117,10 @@ struct vring_virtqueue {
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
 /*
- * The interaction between virtio and a possible IOMMU is a mess.
+ * Modern virtio devices have feature bits to specify whether they need a
+ * quirk and bypass the IOMMU. If not there, just use the DMA API.
+ *
+ * If there, the interaction between virtio and DMA API is messy.
  *
  * On most systems with virtio, physical addresses match bus addresses,
  * and it doesn't particularly matter whether we use the DMA API.
@@ -133,10 +136,18 @@ struct vring_virtqueue {
  *
  * For the time being, we preserve historic behavior and bypass the DMA
  * API.
+ *
+ * TODO: install a per-device DMA ops structure that does the right thing
+ * taking into account all the above quirks, and use the DMA API
+ * unconditionally on data path.
  */
 
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	if (!virtio_has_iommu_quirk(vdev))
+		return true;
+
+	/* Otherwise, we are left to guess. */
 	/*
 	 * In theory, it's possible to have a buggy QEMU-supposed
 	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
@@ -1099,6 +1110,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_VERSION_1:
 			break;
+		case VIRTIO_F_IOMMU_PLATFORM:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
MST
