From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 10/22] virtio_pci: use _LEGACY_ defines in virtio_pci_legacy.c
Date: Thu, 21 Mar 2013 18:59:31 +1030
Message-ID: <1363854584-25795-11-git-send-email-rusty@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

include/linux/virtio_pci.h turns off the compat defines, and we use it
rather than including include/uapi/linux/virtio_pci.h directly.

This makes it obvious if we use legacy defines elsewhere.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci_legacy.c |   62 +++++++++++++++++++-----------------
 include/linux/virtio_pci.h         |    7 ++++
 include/uapi/linux/virtio_pci.h    |    6 ++--
 3 files changed, 43 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/virtio_pci.h

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 77baa7c..c75eb39 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -110,7 +110,7 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
 	/* We only support 32 feature bits. */
-	return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
+	return ioread32(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_HOST_FEATURES);
 }
 
 /* virtio config->finalize_features() implementation */
@@ -122,7 +122,8 @@ static void vp_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/* We only support 32 feature bits. */
-	iowrite32(vdev->features, vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
+	iowrite32(vdev->features,
+		  vp_dev->ioaddr + VIRTIO_PCI_LEGACY_GUEST_FEATURES);
 }
 
 /* Device config access: we use guest endian, as per spec. */
@@ -131,7 +132,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
-				VIRTIO_PCI_CONFIG(vp_dev) + offset;
+				VIRTIO_PCI_LEGACY_CONFIG(vp_dev) + offset;
 	u8 *ptr = buf;
 	int i;
 
@@ -157,7 +158,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
-				VIRTIO_PCI_CONFIG(vp_dev) + offset;
+				VIRTIO_PCI_LEGACY_CONFIG(vp_dev) + offset;
 	const u8 *ptr = buf;
 	int i;
 
@@ -181,7 +182,7 @@ VP_SETx(64)
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	return ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
@@ -189,7 +190,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
 }
 
 /* wait for pending irq handlers */
@@ -209,10 +210,10 @@ static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
-	iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
-	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -224,7 +225,7 @@ static void vp_notify(struct virtqueue *vq)
 
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
-	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
+	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_NOTIFY);
 }
 
 /* Handle a configuration change: Tell driver if it wants to know. */
@@ -271,7 +272,7 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
-	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_ISR);
 
 	/* It's definitely not us if the ISR was not high */
 	if (!isr)
@@ -304,9 +305,9 @@ static void vp_free_vectors(struct virtio_device *vdev)
 	if (vp_dev->msix_enabled) {
 		/* Disable the vector used for configuration */
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+			  vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 		/* Flush the write out to device */
-		ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+		ioread16(vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 
 		pci_disable_msix(vp_dev->pci_dev);
 		vp_dev->msix_enabled = 0;
@@ -371,9 +372,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		goto error;
 	++vp_dev->msix_used_vectors;
 
-	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 	/* Verify we had enough resources to assign the vector */
-	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 	if (v == VIRTIO_MSI_NO_VECTOR) {
 		err = -EBUSY;
 		goto error;
@@ -422,11 +423,11 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	int err;
 
 	/* Select the queue we're interested in */
-	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_SEL);
 
 	/* Check if queue is either not available or already active. */
-	num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
-	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
+	num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_NUM);
+	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN))
 		return ERR_PTR(-ENOENT);
 
 	/* allocate and fill out our structure the represents an active
@@ -438,7 +439,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	info->num = num;
 	info->msix_vector = msix_vec;
 
-	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
+	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_LEGACY_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
 	if (info->queue == NULL) {
 		err = -ENOMEM;
@@ -446,11 +447,12 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	}
 
 	/* activate the queue */
-	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
-		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	iowrite32(virt_to_phys(info->queue)>>VIRTIO_PCI_LEGACY_QUEUE_ADDR_SHIFT,
+		  vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 
 	/* create the vring */
-	vq = vring_new_virtqueue(index, info->num, VIRTIO_PCI_VRING_ALIGN, vdev,
+	vq = vring_new_virtqueue(index, info->num,
+				 VIRTIO_PCI_LEGACY_VRING_ALIGN, vdev,
 				 true, info->queue, vp_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -461,8 +463,10 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	info->vq = vq;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
-		msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		iowrite16(msix_vec,
+			  vp_dev->ioaddr + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
+		msix_vec = ioread16(vp_dev->ioaddr
+				    + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto out_assign;
@@ -482,7 +486,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 out_assign:
 	vring_del_virtqueue(vq);
 out_activate_queue:
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 	free_pages_exact(info->queue, size);
 out_info:
 	kfree(info);
@@ -499,21 +503,21 @@ static void vp_del_vq(struct virtqueue *vq)
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
-	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_SEL);
 
 	if (vp_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+			  vp_dev->ioaddr + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
 		/* Flush the write out to device */
-		ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+		ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_ISR);
 	}
 
 	vring_del_virtqueue(vq);
 
 	/* Select and deactivate the queue */
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 
-	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
+	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_LEGACY_VRING_ALIGN));
 	free_pages_exact(info->queue, size);
 	kfree(info);
 }
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
new file mode 100644
index 0000000..af5b9ab
--- /dev/null
+++ b/include/linux/virtio_pci.h
@@ -0,0 +1,7 @@
+#ifndef _LINUX_VIRTIO_PCI_H
+#define _LINUX_VIRTIO_PCI_H
+
+#define VIRTIO_PCI_NO_LEGACY
+#include <uapi/linux/virtio_pci.h>
+
+#endif /* _LINUX_VIRTIO_PCI_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 9eb6373..0d12828 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -36,8 +36,8 @@
  * SUCH DAMAGE.
  */
 
-#ifndef _LINUX_VIRTIO_PCI_H
-#define _LINUX_VIRTIO_PCI_H
+#ifndef _UAPI_LINUX_VIRTIO_PCI_H
+#define _UAPI_LINUX_VIRTIO_PCI_H
 
 #include <linux/virtio_config.h>
 
@@ -152,4 +152,4 @@ struct virtio_pci_common_cfg {
 	__le16 queue_msix_vector;/* read-write */
 	__le64 queue_address;	/* read-write: 0xFFFFFFFFFFFFFFFF == DNE. */
 };
-#endif
+#endif /* _UAPI_LINUX_VIRTIO_PCI_H */
-- 
1.7.10.4
