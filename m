From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] virtio_pci: abstract all MMIO accesses.
Date: Wed, 11 Feb 2015 16:55:16 +1030
Message-ID: <1423635917-31282-2-git-send-email-rusty__6868.27475806258$1423636588$gmane$org@rustcorp.com.au>
References: <1423635917-31282-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1423635917-31282-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lkml <linux-kernel@vger.kernel.org>, lguest@lists.ozlabs.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is in preparation for testing the virtio pci config mmio backdoor.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci_common.c |  47 ++++++++++++-
 drivers/virtio/virtio_pci_common.h |  41 +++++++++++
 drivers/virtio/virtio_pci_modern.c | 140 ++++++++++++++++++++++++-------------
 3 files changed, 177 insertions(+), 51 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index e894eb278d83..4e6132dd0ca3 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -27,6 +27,49 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
+u8 vp_read_isr(const struct virtio_pci_device *dev)
+{
+	return ioread8(dev->isr);
+}
+
+void vp_write_notify(const struct virtqueue *vq, u16 vqindex)
+{
+	iowrite16(vqindex, (void __iomem *)vq->priv);
+}
+
+u32 __vp_read_common32(const struct virtio_pci_device *dev, size_t offset)
+{
+	return ioread32((void __iomem *)dev->common + offset);
+}
+
+u16 __vp_read_common16(const struct virtio_pci_device *dev, size_t offset)
+{
+	return ioread16((void __iomem *)dev->common + offset);
+}
+
+u8 __vp_read_common8(const struct virtio_pci_device *dev, size_t offset)
+{
+	return ioread8((void __iomem *)dev->common + offset);
+}
+
+void __vp_write_common32(const struct virtio_pci_device *dev,
+			 size_t offset, u32 val)
+{
+	iowrite32(val, (void __iomem *)dev->common + offset);
+}
+
+void __vp_write_common16(const struct virtio_pci_device *dev,
+			 size_t offset, u16 val)
+{
+	iowrite16(val, (void __iomem *)dev->common + offset);
+}
+
+void __vp_write_common8(const struct virtio_pci_device *dev,
+			size_t offset, u8 val)
+{
+	iowrite8(val, (void __iomem *)dev->common + offset);
+}
+
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev)
 {
@@ -45,7 +88,7 @@ bool vp_notify(struct virtqueue *vq)
 {
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
-	iowrite16(vq->index, (void __iomem *)vq->priv);
+	vp_write_notify(vq, vq->index);
 	return true;
 }
 
@@ -89,7 +132,7 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
-	isr = ioread8(vp_dev->isr);
+	isr = vp_read_isr(vp_dev);
 
 	/* It's definitely not us if the ISR was not high */
 	if (!isr)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 28ee4e56badf..15a20c968ae7 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -113,6 +113,47 @@ struct virtio_pci_device {
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
 };
 
+/* Accessor functions. */
+u8 vp_read_isr(const struct virtio_pci_device *dev);
+void vp_write_notify(const struct virtqueue *vq, u16 vqindex);
+u32 __vp_read_common32(const struct virtio_pci_device *dev, size_t offset);
+u16 __vp_read_common16(const struct virtio_pci_device *dev, size_t offset);
+u8 __vp_read_common8(const struct virtio_pci_device *dev, size_t offset);
+void __vp_write_common32(const struct virtio_pci_device *dev,
+			 size_t offset, u32 val);
+void __vp_write_common16(const struct virtio_pci_device *dev,
+			 size_t offset, u16 val);
+void __vp_write_common8(const struct virtio_pci_device *dev,
+			size_t offset, u8 val);
+
+#define vp_read_common32(dev, fieldname)				\
+	__vp_read_common32((dev),					\
+		   offsetof(struct virtio_pci_common_cfg, fieldname) + \
+		   BUILD_BUG_ON_ZERO(sizeof((dev)->common->fieldname) != 4))
+#define vp_read_common16(dev, fieldname)				\
+	__vp_read_common16((dev),					\
+		offsetof(struct virtio_pci_common_cfg, fieldname) +	\
+		BUILD_BUG_ON_ZERO(sizeof((dev)->common->fieldname) != 2))
+#define vp_read_common8(dev, fieldname)				\
+	__vp_read_common8((dev),					\
+		offsetof(struct virtio_pci_common_cfg, fieldname) +	\
+		BUILD_BUG_ON_ZERO(sizeof((dev)->common->fieldname) != 1))
+#define vp_write_common32(dev, fieldname, val)				\
+	__vp_write_common32((dev),					\
+		   offsetof(struct virtio_pci_common_cfg, fieldname) + \
+		   BUILD_BUG_ON_ZERO(sizeof((dev)->common->fieldname) != 4), \
+		   (val))
+#define vp_write_common16(dev, fieldname, val)				\
+	__vp_write_common16((dev),					\
+		   offsetof(struct virtio_pci_common_cfg, fieldname) + \
+		   BUILD_BUG_ON_ZERO(sizeof((dev)->common->fieldname) != 2), \
+		   (val))
+#define vp_write_common8(dev, fieldname, val)				\
+	__vp_write_common8((dev),					\
+		   offsetof(struct virtio_pci_common_cfg, fieldname) + \
+		   BUILD_BUG_ON_ZERO(sizeof((dev)->common->fieldname) != 1), \
+		   (val))
+
 /* Constants for MSI-X */
 /* Use first vector for configuration changes, second and the rest for
  * virtqueues Thus, we need at least 2 vectors for MSI. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 2aa38e59db2e..daa990ef3df0 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -94,22 +94,29 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 	return p;
 }
 
-static void iowrite64_twopart(u64 val, __le32 __iomem *lo, __le32 __iomem *hi)
+static void __vp_write_common64(const struct virtio_pci_device *dev,
+				size_t off_lo, size_t off_hi, u64 val)
 {
-	iowrite32((u32)val, lo);
-	iowrite32(val >> 32, hi);
+	__vp_write_common32(dev, off_lo, val);
+	__vp_write_common32(dev, off_hi, val >> 32);
 }
 
+#define vp_write_common64(dev, name_lo, name_hi, val)			\
+	__vp_write_common64((dev),					\
+			    offsetof(struct virtio_pci_common_cfg, name_lo), \
+			    offsetof(struct virtio_pci_common_cfg, name_hi), \
+			    (val))
+
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u64 features;
 
-	iowrite32(0, &vp_dev->common->device_feature_select);
-	features = ioread32(&vp_dev->common->device_feature);
-	iowrite32(1, &vp_dev->common->device_feature_select);
-	features |= ((u64)ioread32(&vp_dev->common->device_feature) << 32);
+	vp_write_common32(vp_dev, device_feature_select, 0);
+	features = vp_read_common32(vp_dev, device_feature);
+	vp_write_common32(vp_dev, device_feature_select, 1);
+	features |= ((u64)vp_read_common32(vp_dev, device_feature) << 32);
 
 	return features;
 }
@@ -128,13 +135,49 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	iowrite32(0, &vp_dev->common->guest_feature_select);
-	iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
-	iowrite32(1, &vp_dev->common->guest_feature_select);
-	iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
+	vp_write_common32(vp_dev, guest_feature_select, 0);
+	vp_write_common32(vp_dev, guest_feature, (u32)vdev->features);
+	vp_write_common32(vp_dev, guest_feature_select, 1);
+	vp_write_common32(vp_dev, guest_feature, vdev->features >> 32);
 
 	return 0;
 }
+			   
+static u32 vp_read_device32(const struct virtio_pci_device *dev,
+			    size_t offset)
+{
+	return ioread32((void __iomem *)dev->device + offset);
+}
+
+static u16 vp_read_device16(const struct virtio_pci_device *dev,
+			    size_t offset)
+{
+	return ioread16((void __iomem *)dev->device + offset);
+}
+
+static u8 vp_read_device8(const struct virtio_pci_device *dev,
+			  size_t offset)
+{
+	return ioread8((void __iomem *)dev->device + offset);
+}
+
+static void vp_write_device32(const struct virtio_pci_device *dev,
+			      size_t offset, u32 val)
+{
+	iowrite32(val, (void __iomem *)dev->device + offset);
+}
+
+static void vp_write_device16(const struct virtio_pci_device *dev,
+			      size_t offset, u16 val)
+{
+	iowrite16(val, (void __iomem *)dev->device + offset);
+}
+
+static void vp_write_device8(const struct virtio_pci_device *dev,
+			      size_t offset, u8 val)
+{
+	iowrite8(val, (void __iomem *)dev->device + offset);
+}
 
 /* virtio config->get() implementation */
 static void vp_get(struct virtio_device *vdev, unsigned offset,
@@ -149,21 +192,21 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 
 	switch (len) {
 	case 1:
-		b = ioread8(vp_dev->device + offset);
+		b = vp_read_device8(vp_dev, offset);
 		memcpy(buf, &b, sizeof b);
 		break;
 	case 2:
-		w = cpu_to_le16(ioread16(vp_dev->device + offset));
+		w = cpu_to_le16(vp_read_device16(vp_dev, offset));
 		memcpy(buf, &w, sizeof w);
 		break;
 	case 4:
-		l = cpu_to_le32(ioread32(vp_dev->device + offset));
+		l = cpu_to_le32(vp_read_device32(vp_dev, offset));
 		memcpy(buf, &l, sizeof l);
 		break;
 	case 8:
-		l = cpu_to_le32(ioread32(vp_dev->device + offset));
+		l = cpu_to_le32(vp_read_device32(vp_dev, offset));
 		memcpy(buf, &l, sizeof l);
-		l = cpu_to_le32(ioread32(vp_dev->device + offset + sizeof l));
+		l = cpu_to_le32(vp_read_device32(vp_dev, offset + sizeof l));
 		memcpy(buf + sizeof l, &l, sizeof l);
 		break;
 	default:
@@ -186,21 +229,21 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	switch (len) {
 	case 1:
 		memcpy(&b, buf, sizeof b);
-		iowrite8(b, vp_dev->device + offset);
+		vp_write_device8(vp_dev, offset, b);
 		break;
 	case 2:
 		memcpy(&w, buf, sizeof w);
-		iowrite16(le16_to_cpu(w), vp_dev->device + offset);
+		vp_write_device16(vp_dev, offset, le16_to_cpu(w));
 		break;
 	case 4:
 		memcpy(&l, buf, sizeof l);
-		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
+		vp_write_device32(vp_dev, offset, le32_to_cpu(l));
 		break;
 	case 8:
 		memcpy(&l, buf, sizeof l);
-		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
+		vp_write_device32(vp_dev, offset, le32_to_cpu(l));
 		memcpy(&l, buf + sizeof l, sizeof l);
-		iowrite32(le32_to_cpu(l), vp_dev->device + offset + sizeof l);
+		vp_write_device32(vp_dev, offset + sizeof l, le32_to_cpu(l));
 		break;
 	default:
 		BUG();
@@ -210,14 +253,14 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 static u32 vp_generation(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(&vp_dev->common->config_generation);
+	return vp_read_common8(vp_dev, config_generation);
 }
 
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(&vp_dev->common->device_status);
+	return vp_read_common8(vp_dev, device_status);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
@@ -225,17 +268,17 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	iowrite8(status, &vp_dev->common->device_status);
+	vp_write_common8(vp_dev, device_status, status);
 }
 
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
-	iowrite8(0, &vp_dev->common->device_status);
+	vp_write_common8(vp_dev, device_status, 0);
 	/* Flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any. */
-	ioread8(&vp_dev->common->device_status);
+	vp_read_common8(vp_dev, device_status);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -243,10 +286,10 @@ static void vp_reset(struct virtio_device *vdev)
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
 	/* Setup the vector used for configuration events */
-	iowrite16(vector, &vp_dev->common->msix_config);
+	vp_write_common16(vp_dev, msix_config, vector);
 	/* Verify we had enough resources to assign the vector */
 	/* Will also flush the write out to device */
-	return ioread16(&vp_dev->common->msix_config);
+	return vp_read_common16(vp_dev, msix_config);
 }
 
 static size_t vring_pci_size(u16 num)
@@ -281,20 +324,19 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  const char *name,
 				  u16 msix_vec)
 {
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 	struct virtqueue *vq;
 	u16 num, off;
 	int err;
 
-	if (index >= ioread16(&cfg->num_queues))
+	if (index >= vp_read_common16(vp_dev, num_queues))
 		return ERR_PTR(-ENOENT);
 
 	/* Select the queue we're interested in */
-	iowrite16(index, &cfg->queue_select);
+	vp_write_common16(vp_dev, queue_select, index);
 
 	/* Check if queue is either not available or already active. */
-	num = ioread16(&cfg->queue_size);
-	if (!num || ioread16(&cfg->queue_enable))
+	num = vp_read_common16(vp_dev, queue_size);
+	if (!num || vp_read_common16(vp_dev, queue_enable))
 		return ERR_PTR(-ENOENT);
 
 	if (num & (num - 1)) {
@@ -303,7 +345,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* get offset of notification word for this vq */
-	off = ioread16(&cfg->queue_notify_off);
+	off = vp_read_common16(vp_dev, queue_notify_off);
 
 	info->num = num;
 	info->msix_vector = msix_vec;
@@ -322,13 +364,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* activate the queue */
-	iowrite16(num, &cfg->queue_size);
-	iowrite64_twopart(virt_to_phys(info->queue),
-			  &cfg->queue_desc_lo, &cfg->queue_desc_hi);
-	iowrite64_twopart(virt_to_phys(virtqueue_get_avail(vq)),
-			  &cfg->queue_avail_lo, &cfg->queue_avail_hi);
-	iowrite64_twopart(virt_to_phys(virtqueue_get_used(vq)),
-			  &cfg->queue_used_lo, &cfg->queue_used_hi);
+	vp_write_common16(vp_dev, queue_size, num);
+	vp_write_common64(vp_dev, queue_desc_lo, queue_desc_hi,
+			  virt_to_phys(info->queue));
+	vp_write_common64(vp_dev, queue_avail_lo, queue_avail_hi,
+			  virt_to_phys(virtqueue_get_avail(vq)));
+	vp_write_common64(vp_dev, queue_used_lo, queue_used_hi,
+			  virt_to_phys(virtqueue_get_used(vq)));
 
 	if (vp_dev->notify_base) {
 		/* offset should not wrap */
@@ -357,8 +399,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(msix_vec, &cfg->queue_msix_vector);
-		msix_vec = ioread16(&cfg->queue_msix_vector);
+		vp_write_common16(vp_dev, queue_msix_vector, msix_vec);
+		msix_vec = vp_read_common16(vp_dev, queue_msix_vector);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto err_assign_vector;
@@ -393,8 +435,8 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * this, there's no way to go back except reset.
 	 */
 	list_for_each_entry(vq, &vdev->vqs, list) {
-		iowrite16(vq->index, &vp_dev->common->queue_select);
-		iowrite16(1, &vp_dev->common->queue_enable);
+		vp_write_common16(vp_dev, queue_select, vq->index);
+		vp_write_common16(vp_dev, queue_enable, 1);
 	}
 
 	return 0;
@@ -405,13 +447,13 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 
-	iowrite16(vq->index, &vp_dev->common->queue_select);
+	vp_write_common16(vp_dev, queue_select, vq->index);
 
 	if (vp_dev->msix_enabled) {
-		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  &vp_dev->common->queue_msix_vector);
+		vp_write_common16(vp_dev, queue_msix_vector,
+				  VIRTIO_MSI_NO_VECTOR);
 		/* Flush the write out to device */
-		ioread16(&vp_dev->common->queue_msix_vector);
+		vp_read_common16(vp_dev, queue_msix_vector);
 	}
 
 	if (!vp_dev->notify_base)
-- 
2.1.0
