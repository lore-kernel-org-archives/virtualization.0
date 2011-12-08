From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 8/11] virtio_pci: share structure between legacy and modern.
Date: Thu, 08 Dec 2011 21:10:24 +1030
Message-ID: <87y5unfisn.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
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
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

They're almost identical: we add a "legacy" ioregion (what was
"ioaddr" in the legacy driver), and move it out to virtio_pci-common.h.
---
 drivers/virtio/virtio_pci-common.h |   72 ++++++++++++++++++++++
 drivers/virtio/virtio_pci.c        |   64 -------------------
 drivers/virtio/virtio_pci_legacy.c |  120 +++++++++----------------------------
 3 files changed, 105 insertions(+), 151 deletions(-)

diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
new file mode 100644
--- /dev/null
+++ b/drivers/virtio/virtio_pci-common.h
@@ -0,0 +1,72 @@
+#include <linux/pci.h>
+#include <linux/virtio_pci.h>
+
+/* Our device structure: shared by virtio_pci and virtio_pci_legacy. */
+struct virtio_pci_device
+{
+	struct virtio_device vdev;
+	struct pci_dev *pci_dev;
+
+	/* The IO mapping for the PCI config space (non-legacy mode) */
+	struct virtio_pci_common_cfg __iomem *common;
+	/* Device-specific data (non-legacy mode). */
+	void __iomem *device;
+
+	/* In legacy mode, these two point to within ->legacy. */
+	/* Where to read and clear interrupt */ 
+	u8 __iomem *isr;
+	/* Write the virtqueue index here to notify device of activity. */
+	__le16 __iomem *notify;
+
+#ifdef CONFIG_VIRTIO_PCI_LEGACY
+	/* Instead of common, notify and device, legacy uses this: */
+	void __iomem *legacy;
+#endif
+
+	/* a list of queues so we can dispatch IRQs */
+	spinlock_t lock;
+	struct list_head virtqueues;
+
+	/* MSI-X support */
+	int msix_enabled;
+	int intx_enabled;
+	struct msix_entry *msix_entries;
+	/* Name strings for interrupts. This size should be enough,
+	 * and I'm too lazy to allocate each name separately. */
+	char (*msix_names)[256];
+	/* Number of available vectors */
+	unsigned msix_vectors;
+	/* Vectors allocated, excluding per-vq vectors if any */
+	unsigned msix_used_vectors;
+	/* Whether we have vector per vq */
+	bool per_vq_vectors;
+};
+
+/* Constants for MSI-X */
+/* Use first vector for configuration changes, second and the rest for
+ * virtqueues Thus, we need at least 2 vectors for MSI. */
+enum {
+	VP_MSIX_CONFIG_VECTOR = 0,
+	VP_MSIX_VQ_VECTOR = 1,
+};
+
+struct virtio_pci_vq_info
+{
+	/* the actual virtqueue */
+	struct virtqueue *vq;
+
+	/* the number of entries in the queue */
+	int num;
+
+	/* the index of the queue */
+	int queue_index;
+
+	/* the virtual address of the ring queue */
+	void *queue;
+
+	/* the list node for the virtqueues list */
+	struct list_head node;
+
+	/* MSI-X vector (or none) */
+	unsigned msix_vector;
+};
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -22,6 +22,7 @@
 #include <linux/virtio_pci.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
+#include "virtio_pci-common.h"
 
 MODULE_AUTHOR("Rusty Russell <rusty@rustcorp.com.au>");
 MODULE_DESCRIPTION("virtio-pci");
@@ -31,69 +32,6 @@ MODULE_VERSION("2");
 /* Use cacheline size as a good guess at a nice alignment. */
 #define VIRTIO_PCI_ALIGN	SMP_CACHE_BYTES
 
-/* Our device structure */
-struct virtio_pci_device
-{
-	struct virtio_device vdev;
-	struct pci_dev *pci_dev;
-
-	/* The IO mapping for the PCI config space */
-	struct virtio_pci_common_cfg __iomem *common;
-	/* Where to read and clear interrupt */ 
-	u8 __iomem *isr;
-	/* Write the virtqueue index here to notify device of activity. */
-	__le16 __iomem *notify;
-	/* Device-specific data. */
-	void __iomem *device;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-
-	/* MSI-X support */
-	int msix_enabled;
-	int intx_enabled;
-	struct msix_entry *msix_entries;
-	/* Name strings for interrupts. This size should be enough,
-	 * and I'm too lazy to allocate each name separately. */
-	char (*msix_names)[256];
-	/* Number of available vectors */
-	unsigned msix_vectors;
-	/* Vectors allocated, excluding per-vq vectors if any */
-	unsigned msix_used_vectors;
-	/* Whether we have vector per vq */
-	bool per_vq_vectors;
-};
-
-/* Constants for MSI-X */
-/* Use first vector for configuration changes, second and the rest for
- * virtqueues Thus, we need at least 2 vectors for MSI. */
-enum {
-	VP_MSIX_CONFIG_VECTOR = 0,
-	VP_MSIX_VQ_VECTOR = 1,
-};
-
-struct virtio_pci_vq_info
-{
-	/* the actual virtqueue */
-	struct virtqueue *vq;
-
-	/* the number of entries in the queue */
-	int num;
-
-	/* the index of the queue */
-	int queue_index;
-
-	/* the virtual address of the ring queue */
-	void *queue;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
-
-	/* MSI-X vector (or none) */
-	unsigned msix_vector;
-};
-
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
 static struct pci_device_id virtio_pci_id_table[] = {
 	{ 0x1af4, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -25,6 +25,7 @@
 #include <linux/virtio_pci.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
+#include "virtio_pci-common.h"
 
 static bool force_nonlegacy;
 module_param(force_nonlegacy, bool, 0644);
@@ -35,63 +36,6 @@ MODULE_DESCRIPTION("virtio-pci-legacy");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1");
 
-/* Our device structure */
-struct virtio_pci_device
-{
-	struct virtio_device vdev;
-	struct pci_dev *pci_dev;
-
-	/* the IO mapping for the PCI config space */
-	void __iomem *ioaddr;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-
-	/* MSI-X support */
-	int msix_enabled;
-	int intx_enabled;
-	struct msix_entry *msix_entries;
-	/* Name strings for interrupts. This size should be enough,
-	 * and I'm too lazy to allocate each name separately. */
-	char (*msix_names)[256];
-	/* Number of available vectors */
-	unsigned msix_vectors;
-	/* Vectors allocated, excluding per-vq vectors if any */
-	unsigned msix_used_vectors;
-	/* Whether we have vector per vq */
-	bool per_vq_vectors;
-};
-
-/* Constants for MSI-X */
-/* Use first vector for configuration changes, second and the rest for
- * virtqueues Thus, we need at least 2 vectors for MSI. */
-enum {
-	VP_MSIX_CONFIG_VECTOR = 0,
-	VP_MSIX_VQ_VECTOR = 1,
-};
-
-struct virtio_pci_vq_info
-{
-	/* the actual virtqueue */
-	struct virtqueue *vq;
-
-	/* the number of entries in the queue */
-	int num;
-
-	/* the index of the queue */
-	int queue_index;
-
-	/* the virtual address of the ring queue */
-	void *queue;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
-
-	/* MSI-X vector (or none) */
-	unsigned msix_vector;
-};
-
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
 static struct pci_device_id virtio_pci_id_table[] = {
 	{ 0x1af4, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -112,7 +56,7 @@ static u64 vp_get_features(struct virtio
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
 	/* We only support 32 feature bits. */
-	return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
+	return ioread32(vp_dev->legacy + VIRTIO_PCI_HOST_FEATURES);
 }
 
 /* virtio config->finalize_features() implementation */
@@ -124,7 +68,7 @@ static void vp_finalize_features(struct 
 	vring_transport_features(vdev);
 
 	/* We only support 32 feature bits. */
-	iowrite32(vdev->features, vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
+	iowrite32(vdev->features, vp_dev->legacy+VIRTIO_PCI_GUEST_FEATURES);
 }
 
 /* virtio config->get() implementation */
@@ -132,13 +76,13 @@ static void vp_get(struct virtio_device 
 		   void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->ioaddr +
+	void __iomem *legacy = vp_dev->legacy +
 				VIRTIO_PCI_CONFIG(vp_dev) + offset;
 	u8 *ptr = buf;
 	int i;
 
 	for (i = 0; i < len; i++)
-		ptr[i] = ioread8(ioaddr + i);
+		ptr[i] = ioread8(legacy + i);
 }
 
 /* the config->set() implementation.  it's symmetric to the config->get()
@@ -147,20 +91,20 @@ static void vp_set(struct virtio_device 
 		   const void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->ioaddr +
+	void __iomem *legacy = vp_dev->legacy +
 				VIRTIO_PCI_CONFIG(vp_dev) + offset;
 	const u8 *ptr = buf;
 	int i;
 
 	for (i = 0; i < len; i++)
-		iowrite8(ptr[i], ioaddr + i);
+		iowrite8(ptr[i], legacy + i);
 }
 
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	return ioread8(vp_dev->legacy + VIRTIO_PCI_STATUS);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
@@ -168,7 +112,7 @@ static void vp_set_status(struct virtio_
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	iowrite8(status, vp_dev->legacy + VIRTIO_PCI_STATUS);
 }
 
 /* wait for pending irq handlers */
@@ -188,10 +132,10 @@ static void vp_reset(struct virtio_devic
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
-	iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	iowrite8(0, vp_dev->legacy + VIRTIO_PCI_STATUS);
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
-	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+	ioread8(vp_dev->legacy + VIRTIO_PCI_STATUS);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -204,7 +148,7 @@ static void vp_notify(struct virtqueue *
 
 	/* we write the queue's selector into the notification register to
 	 * signal the other end */
-	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
+	iowrite16(info->queue_index, vp_dev->legacy + VIRTIO_PCI_QUEUE_NOTIFY);
 }
 
 /* Handle a configuration change: Tell driver if it wants to know. */
@@ -251,7 +195,7 @@ static irqreturn_t vp_interrupt(int irq,
 
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
-	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+	isr = ioread8(vp_dev->legacy + VIRTIO_PCI_ISR);
 
 	/* It's definitely not us if the ISR was not high */
 	if (!isr)
@@ -280,9 +224,9 @@ static void vp_free_vectors(struct virti
 	if (vp_dev->msix_enabled) {
 		/* Disable the vector used for configuration */
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+			  vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
 		/* Flush the write out to device */
-		ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+		ioread16(vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
 
 		pci_disable_msix(vp_dev->pci_dev);
 		vp_dev->msix_enabled = 0;
@@ -336,9 +280,9 @@ static int vp_request_msix_vectors(struc
 		goto error;
 	++vp_dev->msix_used_vectors;
 
-	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+	iowrite16(v, vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
 	/* Verify we had enough resources to assign the vector */
-	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+	v = ioread16(vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
 	if (v == VIRTIO_MSI_NO_VECTOR) {
 		err = -EBUSY;
 		goto error;
@@ -387,11 +331,11 @@ static struct virtqueue *setup_vq(struct
 	int err;
 
 	/* Select the queue we're interested in */
-	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+	iowrite16(index, vp_dev->legacy + VIRTIO_PCI_QUEUE_SEL);
 
 	/* Check if queue is either not available or already active. */
-	num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
-	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
+	num = ioread16(vp_dev->legacy + VIRTIO_PCI_QUEUE_NUM);
+	if (!num || ioread32(vp_dev->legacy + VIRTIO_PCI_QUEUE_PFN))
 		return ERR_PTR(-ENOENT);
 
 	/* allocate and fill out our structure the represents an active
@@ -413,7 +357,7 @@ static struct virtqueue *setup_vq(struct
 
 	/* activate the queue */
 	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
-		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+		  vp_dev->legacy + VIRTIO_PCI_QUEUE_PFN);
 
 	/* create the vring */
 	vq = vring_new_virtqueue(info->num, VIRTIO_PCI_VRING_ALIGN,
@@ -427,8 +371,8 @@ static struct virtqueue *setup_vq(struct
 	info->vq = vq;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
-		msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		iowrite16(msix_vec, vp_dev->legacy + VIRTIO_MSI_QUEUE_VECTOR);
+		msix_vec = ioread16(vp_dev->legacy + VIRTIO_MSI_QUEUE_VECTOR);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto out_assign;
@@ -448,7 +392,7 @@ static struct virtqueue *setup_vq(struct
 out_assign:
 	vring_del_virtqueue(vq);
 out_activate_queue:
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	iowrite32(0, vp_dev->legacy + VIRTIO_PCI_QUEUE_PFN);
 	free_pages_exact(info->queue, size);
 out_info:
 	kfree(info);
@@ -465,19 +409,19 @@ static void vp_del_vq(struct virtqueue *
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
-	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+	iowrite16(info->queue_index, vp_dev->legacy + VIRTIO_PCI_QUEUE_SEL);
 
 	if (vp_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+			  vp_dev->legacy + VIRTIO_MSI_QUEUE_VECTOR);
 		/* Flush the write out to device */
-		ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+		ioread8(vp_dev->legacy + VIRTIO_PCI_ISR);
 	}
 
 	vring_del_virtqueue(vq);
 
 	/* Select and deactivate the queue */
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	iowrite32(0, vp_dev->legacy + VIRTIO_PCI_QUEUE_PFN);
 
 	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
 	free_pages_exact(info->queue, size);
@@ -676,8 +620,8 @@ static int __devinit virtio_pci_probe(st
 	if (err)
 		goto out_enable_device;
 
-	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
-	if (vp_dev->ioaddr == NULL)
+	vp_dev->legacy = pci_iomap(pci_dev, 0, 0);
+	if (vp_dev->legacy == NULL)
 		goto out_req_regions;
 
 	pci_set_drvdata(pci_dev, vp_dev);
@@ -699,7 +643,7 @@ static int __devinit virtio_pci_probe(st
 
 out_set_drvdata:
 	pci_set_drvdata(pci_dev, NULL);
-	pci_iounmap(pci_dev, vp_dev->ioaddr);
+	pci_iounmap(pci_dev, vp_dev->legacy);
 out_req_regions:
 	pci_release_regions(pci_dev);
 out_enable_device:
@@ -717,7 +661,7 @@ static void __devexit virtio_pci_remove(
 
 	vp_del_vqs(&vp_dev->vdev);
 	pci_set_drvdata(pci_dev, NULL);
-	pci_iounmap(pci_dev, vp_dev->ioaddr);
+	pci_iounmap(pci_dev, vp_dev->legacy);
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
 	kfree(vp_dev);
