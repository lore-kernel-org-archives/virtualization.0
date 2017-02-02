From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/2] virtio: Make ARM SMMU workaround more specific
Date: Thu,  2 Feb 2017 16:36:20 +0000
Message-ID: <89fb6454e6e4b4e7ac7df2e00b96271c0045f8b9.1486053223.git.robin.murphy__16137.1990842328$1486053401$gmane$org@arm.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Whilst always using the DMA API is OK on ARM systems in most cases,
there can be a problem if a hypervisor fails to tell its guest that a
virtio device is cache-coherent. In that case, the guest will end up
making non-cacheable mappings for DMA buffers (i.e. the vring), which,
if the host is using a cacheable view of the same buffer on the other
end, is not a recipe for success.

It turns out that current kvmtool, and probably QEMU as well, runs into
this exact problem, and a guest using a virtio console can be seen to
hang pretty quickly after writing a few characters as host data in cache
and guest data directly in RAM go out of sync.

In order to fix this, narrow the scope of the original workaround from
all legacy devices to just those behind IOMMUs, which was really the
only thing we were trying to deal with in the first place.

Fixes: c7070619f340 ("vring: Force use of DMA API for ARM-based systems with legacy devices")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/virtio/virtio_ring.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7e38ed79c3fc..03e824c77d61 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -20,6 +20,7 @@
 #include <linux/virtio_ring.h>
 #include <linux/virtio_config.h>
 #include <linux/device.h>
+#include <linux/iommu.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/hrtimer.h>
@@ -117,6 +118,27 @@ struct vring_virtqueue {
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
 /*
+ * ARM Fast Models are hopefully unique in implementing "hardware" legacy
+ * virtio block devices, which can be placed behind a "real" IOMMU, but are
+ * unaware of VIRTIO_F_IOMMU_PLATFORM. Fortunately, we can detect whether
+ * an IOMMU is present and in use by checking whether an IOMMU driver has
+ * assigned the DMA master device a group.
+ */
+static bool vring_arm_legacy_dma_quirk(struct virtio_device *vdev)
+{
+	struct iommu_group *group;
+
+	if (!(IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64)) ||
+	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		return false;
+
+	group = iommu_group_get(vdev->dev.parent);
+	iommu_group_put(group);
+
+	return group != NULL;
+}
+
+/*
  * Modern virtio devices have feature bits to specify whether they need a
  * quirk and bypass the IOMMU. If not there, just use the DMA API.
  *
@@ -159,12 +181,8 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	if (xen_domain())
 		return true;
 
-	/*
-	 * On ARM-based machines, the DMA ops will do the right thing,
-	 * so always use them with legacy devices.
-	 */
-	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
-		return !virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
+	if (vring_arm_legacy_dma_quirk(vdev))
+		return true;
 
 	return false;
 }
-- 
2.11.0.dirty
