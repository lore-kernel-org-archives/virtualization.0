From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 1/3] virtio: add features for IOMMU control
Date: Mon, 18 Apr 2016 12:58:14 +0300
Message-ID: <1460973374-32719-2-git-send-email-mst@redhat.com>
References: <1460973374-32719-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1460973374-32719-1-git-send-email-mst@redhat.com>
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
Cc: Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

The interaction between virtio and DMA API is messy.

On most systems with virtio, physical addresses match bus addresses,
and it doesn't particularly matter whether we use the DMA API.

On some systems, including Xen and any system with a physical device
that speaks virtio behind a physical IOMMU, we must use the DMA API
for virtio DMA to work at all.

Add a feature bit to detect that: VIRTIO_F_IOMMU_PLATFORM.

On other systems, including SPARC and PPC64, virtio-pci devices are
enumerated as though they are behind an IOMMU, but the virtio host
ignores the IOMMU, so we must either pretend that the IOMMU isn't
there or somehow map everything as the identity.

Add a feature bit for that as well: VIRTIO_F_IOMMU_PASSTHROUGH: without
VIRTIO_F_IOMMU_PLATFORM, it means that virtio will bypass the IOMMU.
With VIRTIO_F_IOMMU_PLATFORM, it suggests that guest maps everything as
the identity (this last bit isn't trivial to implement so ignore this
hint for now).

If not there, we preserve historic behavior and bypass the DMA
API unless within Xen guest.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_config.h | 10 +++++++++-
 drivers/virtio/virtio_ring.c       | 18 +++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 4cb65bb..952775c 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		33
+#define VIRTIO_TRANSPORT_F_END		35
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -63,4 +63,12 @@
 /* v1.0 compliant. */
 #define VIRTIO_F_VERSION_1		32
 
+/* Request IOMMU passthrough (if available)
+ * Without VIRTIO_F_IOMMU_PLATFORM: bypass the IOMMU even if enabled.
+ * With VIRTIO_F_IOMMU_PLATFORM: suggest disabling IOMMU.
+ */
+#define VIRTIO_F_IOMMU_PASSTHROUGH	33
+
+/* Do not bypass the IOMMU (if configured) */
+#define VIRTIO_F_IOMMU_PLATFORM		34
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c802d4..0436bd2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -117,7 +117,10 @@ struct vring_virtqueue {
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
 /*
- * The interaction between virtio and a possible IOMMU is a mess.
+ * Modern virtio devices might set feature bits to specify whether
+ * they use or unconditionally bypass the platform IOMMU.
+ *
+ * If not there, the interaction between virtio and DMA API is messy.
  *
  * On most systems with virtio, physical addresses match bus addresses,
  * and it doesn't particularly matter whether we use the DMA API.
@@ -137,6 +140,13 @@ struct vring_virtqueue {
 
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
+		return true;
+
+	if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PASSTHROUGH))
+		return false;
+
+	/* Otherwise, we are left to guess. */
 	/*
 	 * In theory, it's possible to have a buggy QEMU-supposed
 	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
@@ -1099,6 +1109,12 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_VERSION_1:
 			break;
+		case VIRTIO_F_IOMMU_PASSTHROUGH:
+			break;
+		case VIRTIO_F_IOMMU_PLATFORM:
+			/* Ignore passthrough hint for now, obey kernel config. */
+			__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PASSTHROUGH);
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
MST
