From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Date: Fri, 11 Oct 2019 18:25:19 -0700
Message-ID: <1570843519-8696-3-git-send-email-linuxram__14821.2468646065$1570844113$gmane$org@us.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
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
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, robin.murphy@arm.com, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
be set by both device and guest driver. However, as a hack, when DMA API
returns physical addresses, guest driver can use the DMA API; even though
device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
addresses.

Doing this works-around POWER secure guests for which only the bounce
buffer is accessible to the device, but which don't set
VIRTIO_F_IOMMU_PLATFORM due to a set of hypervisor and architectural bugs.
To guard against platform changes, breaking any of these assumptions down
the road, we check at probe time and fail if that's not the case.

cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Gibson <david@gibson.dropbear.id.au>
cc: Michael Ellerman <mpe@ellerman.id.au>
cc: Paul Mackerras <paulus@ozlabs.org>
cc: Michael Roth <mdroth@linux.vnet.ibm.com>
cc: Alexey Kardashevskiy <aik@linux.ibm.com>
cc: Jason Wang <jasowang@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 drivers/virtio/virtio.c       | 18 ++++++++++++++++++
 drivers/virtio/virtio_ring.c  |  8 ++++++++
 include/linux/virtio_config.h | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32..77a3baf 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <linux/dma-mapping.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -245,6 +246,23 @@ static int virtio_dev_probe(struct device *_d)
 	if (err)
 		goto err;
 
+	/*
+	 * If memory is encrypted, but VIRTIO_F_IOMMU_PLATFORM is not set, then
+	 * the device is broken: DMA API is required for these platforms, but
+	 * the only way using the DMA API is going to work at all is if the
+	 * device is ready for it. So we need a flag on the virtio device,
+	 * exposed by the hypervisor (or hardware for hw virtio devices) that
+	 * says: hey, I'm real, don't take a shortcut.
+	 *
+	 * There's one exception where guest can make things work, and that is
+	 * when DMA API is guaranteed to always return physical addresses.
+	 */
+	if (mem_encrypt_active() && !virtio_can_use_dma_api(dev)) {
+		dev_err(_d, "virtio: device unable to access encrypted memory\n");
+		err = -EINVAL;
+		goto err;
+	}
+
 	err = drv->probe(dev);
 	if (err)
 		goto err;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8be1c4..9c56b61 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -255,6 +255,14 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	if (xen_domain())
 		return true;
 
+	/*
+	 * Also, if guest memory is encrypted the host can't access it
+	 * directly. We need to either use an IOMMU or do bounce buffering.
+	 * Both are done via the DMA API.
+	 */
+	if (mem_encrypt_active() && virtio_can_use_dma_api(vdev))
+		return true;
+
 	return false;
 }
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc49..57bc25c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -4,6 +4,7 @@
 
 #include <linux/err.h>
 #include <linux/bug.h>
+#include <linux/dma-mapping.h>
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
 #include <uapi/linux/virtio_config.h>
@@ -174,6 +175,19 @@ static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
 	return !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
 }
 
+/**
+ * virtio_can_use_dma_api - determine whether the DMA API can be used
+ * @vdev: the device
+ *
+ * The DMA API can be used either when the device doesn't have the IOMMU quirk,
+ * or when the DMA API is guaranteed to always return physical addresses.
+ */
+static inline bool virtio_can_use_dma_api(const struct virtio_device *vdev)
+{
+	return !virtio_has_iommu_quirk(vdev) ||
+	       dma_addr_is_phys_addr(vdev->dev.parent);
+}
+
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
-- 
1.8.3.1
