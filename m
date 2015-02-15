From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] virtio_pci_modern: switch to type-safe io accessors
Date: Sun, 15 Feb 2015 06:31:19 +0100
Message-ID: <1423977123-10115-2-git-send-email-mst@redhat.com>
References: <1423977123-10115-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1423977123-10115-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As Rusty noted, we were accessing queue_enable with an incorrect width.
Switch to type-safe accessors so we don't make this mistake again in the
future.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 83 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 4e73ef7..c0d39eb 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -57,6 +57,13 @@ static inline void vp_iowrite32(u32 value, u32 __iomem *addr)
 	iowrite16(value, addr);
 }
 
+static void vp_iowrite64_twopart(u64 val,
+				 __le32 __iomem *lo, __le32 __iomem *hi)
+{
+	vp_iowrite32((u32)val, lo);
+	vp_iowrite32(val >> 32, hi);
+}
+
 static void __iomem *map_capability(struct pci_dev *dev, int off,
 				    size_t minlen,
 				    u32 align,
@@ -131,22 +138,16 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 	return p;
 }
 
-static void iowrite64_twopart(u64 val, __le32 __iomem *lo, __le32 __iomem *hi)
-{
-	iowrite32((u32)val, lo);
-	iowrite32(val >> 32, hi);
-}
-
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u64 features;
 
-	iowrite32(0, &vp_dev->common->device_feature_select);
-	features = ioread32(&vp_dev->common->device_feature);
-	iowrite32(1, &vp_dev->common->device_feature_select);
-	features |= ((u64)ioread32(&vp_dev->common->device_feature) << 32);
+	vp_iowrite32(0, &vp_dev->common->device_feature_select);
+	features = vp_ioread32(&vp_dev->common->device_feature);
+	vp_iowrite32(1, &vp_dev->common->device_feature_select);
+	features |= ((u64)vp_ioread32(&vp_dev->common->device_feature) << 32);
 
 	return features;
 }
@@ -165,10 +166,10 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	iowrite32(0, &vp_dev->common->guest_feature_select);
-	iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
-	iowrite32(1, &vp_dev->common->guest_feature_select);
-	iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
+	vp_iowrite32(0, &vp_dev->common->guest_feature_select);
+	vp_iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
+	vp_iowrite32(1, &vp_dev->common->guest_feature_select);
+	vp_iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
 
 	return 0;
 }
@@ -247,14 +248,14 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 static u32 vp_generation(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(&vp_dev->common->config_generation);
+	return vp_ioread8(&vp_dev->common->config_generation);
 }
 
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(&vp_dev->common->device_status);
+	return vp_ioread8(&vp_dev->common->device_status);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
@@ -262,17 +263,17 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	iowrite8(status, &vp_dev->common->device_status);
+	vp_iowrite8(status, &vp_dev->common->device_status);
 }
 
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
-	iowrite8(0, &vp_dev->common->device_status);
+	vp_iowrite8(0, &vp_dev->common->device_status);
 	/* Flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any. */
-	ioread8(&vp_dev->common->device_status);
+	vp_ioread8(&vp_dev->common->device_status);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -280,10 +281,10 @@ static void vp_reset(struct virtio_device *vdev)
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
 	/* Setup the vector used for configuration events */
-	iowrite16(vector, &vp_dev->common->msix_config);
+	vp_iowrite16(vector, &vp_dev->common->msix_config);
 	/* Verify we had enough resources to assign the vector */
 	/* Will also flush the write out to device */
-	return ioread16(&vp_dev->common->msix_config);
+	return vp_ioread16(&vp_dev->common->msix_config);
 }
 
 static size_t vring_pci_size(u16 num)
@@ -323,15 +324,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	u16 num, off;
 	int err;
 
-	if (index >= ioread16(&cfg->num_queues))
+	if (index >= vp_ioread16(&cfg->num_queues))
 		return ERR_PTR(-ENOENT);
 
 	/* Select the queue we're interested in */
-	iowrite16(index, &cfg->queue_select);
+	vp_iowrite16(index, &cfg->queue_select);
 
 	/* Check if queue is either not available or already active. */
-	num = ioread16(&cfg->queue_size);
-	if (!num || ioread16(&cfg->queue_enable))
+	num = vp_ioread16(&cfg->queue_size);
+	if (!num || vp_ioread16(&cfg->queue_enable))
 		return ERR_PTR(-ENOENT);
 
 	if (num & (num - 1)) {
@@ -340,7 +341,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* get offset of notification word for this vq */
-	off = ioread16(&cfg->queue_notify_off);
+	off = vp_ioread16(&cfg->queue_notify_off);
 
 	info->num = num;
 	info->msix_vector = msix_vec;
@@ -359,13 +360,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* activate the queue */
-	iowrite16(num, &cfg->queue_size);
-	iowrite64_twopart(virt_to_phys(info->queue),
-			  &cfg->queue_desc_lo, &cfg->queue_desc_hi);
-	iowrite64_twopart(virt_to_phys(virtqueue_get_avail(vq)),
-			  &cfg->queue_avail_lo, &cfg->queue_avail_hi);
-	iowrite64_twopart(virt_to_phys(virtqueue_get_used(vq)),
-			  &cfg->queue_used_lo, &cfg->queue_used_hi);
+	vp_iowrite16(num, &cfg->queue_size);
+	vp_iowrite64_twopart(virt_to_phys(info->queue),
+			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
+	vp_iowrite64_twopart(virt_to_phys(virtqueue_get_avail(vq)),
+			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
+	vp_iowrite64_twopart(virt_to_phys(virtqueue_get_used(vq)),
+			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
 	if (vp_dev->notify_base) {
 		/* offset should not wrap */
@@ -394,8 +395,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(msix_vec, &cfg->queue_msix_vector);
-		msix_vec = ioread16(&cfg->queue_msix_vector);
+		vp_iowrite16(msix_vec, &cfg->queue_msix_vector);
+		msix_vec = vp_ioread16(&cfg->queue_msix_vector);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto err_assign_vector;
@@ -430,8 +431,8 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * this, there's no way to go back except reset.
 	 */
 	list_for_each_entry(vq, &vdev->vqs, list) {
-		iowrite16(vq->index, &vp_dev->common->queue_select);
-		iowrite16(1, &vp_dev->common->queue_enable);
+		vp_iowrite16(vq->index, &vp_dev->common->queue_select);
+		vp_iowrite16(1, &vp_dev->common->queue_enable);
 	}
 
 	return 0;
@@ -442,13 +443,13 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 
-	iowrite16(vq->index, &vp_dev->common->queue_select);
+	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
 
 	if (vp_dev->msix_enabled) {
-		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  &vp_dev->common->queue_msix_vector);
+		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
+			     &vp_dev->common->queue_msix_vector);
 		/* Flush the write out to device */
-		ioread16(&vp_dev->common->queue_msix_vector);
+		vp_ioread16(&vp_dev->common->queue_msix_vector);
 	}
 
 	if (!vp_dev->notify_base)
-- 
MST
