From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] fixup! virtio: convert to use DMA api
Date: Mon, 18 Apr 2016 14:47:24 +0300
Message-ID: <1460979793-6621-1-git-send-email-mst__32001.4879609973$1460980072$gmane$org@redhat.com>
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
To: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: Wei Liu <wei.liu2@citrix.com>, Andy Lutomirski <luto@kernel.org>, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, peterx@redhat.com, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

This adds a flag to enable/disable bypassing the IOMMU by
virtio devices.

This is on top of patch
http://article.gmane.org/gmane.comp.emulators.qemu/403467
virtio: convert to use DMA api

Tested with patchset
http://article.gmane.org/gmane.linux.kernel.virtualization/27545
virtio-pci: iommu support

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
 include/hw/virtio/virtio-access.h              | 3 ++-
 include/hw/virtio/virtio.h                     | 6 +++++-
 include/standard-headers/linux/virtio_config.h | 8 ++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 967cc75..bb6f34e 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -23,7 +23,8 @@ static inline AddressSpace *virtio_get_dma_as(VirtIODevice *vdev)
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
-    if (k->get_dma_as) {
+    if ((vdev->host_features & (0x1ULL << VIRTIO_F_IOMMU_PLATFORM)) &&
+        k->get_dma_as) {
         return k->get_dma_as(qbus->parent);
     }
     return &address_space_memory;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b12faa9..34d3041 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -228,7 +228,11 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
                       VIRTIO_F_NOTIFY_ON_EMPTY, true), \
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
-                      VIRTIO_F_ANY_LAYOUT, true)
+                      VIRTIO_F_ANY_LAYOUT, true), \
+    DEFINE_PROP_BIT64("iommu_passthrough", _state, _field, \
+                      VIRTIO_F_IOMMU_PASSTHROUGH, false), \
+    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
+                      VIRTIO_F_IOMMU_PLATFORM, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index bcc445b..5564dab 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -61,4 +61,12 @@
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
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
MST
