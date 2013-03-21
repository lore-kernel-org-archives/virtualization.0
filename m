From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 18/22] virtio_pci: share structure between legacy and modern.
Date: Thu, 21 Mar 2013 18:59:39 +1030
Message-ID: <1363854584-25795-19-git-send-email-rusty@rustcorp.com.au>
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

They're almost identical: we add a "legacy" ioregion (what was
"ioaddr" in the legacy driver), and move it out to virtio_pci-common.h.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci-common.h |   76 +++++++++++++++++++++
 drivers/virtio/virtio_pci.c        |   68 +------------------
 drivers/virtio/virtio_pci_legacy.c |  128 +++++++++++-------------------------
 3 files changed, 116 insertions(+), 156 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci-common.h

diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
new file mode 100644
index 0000000..8ff8c92
--- /dev/null
+++ b/drivers/virtio/virtio_pci-common.h
@@ -0,0 +1,76 @@
+#include <linux/pci.h>
+#include <linux/virtio_pci.h>
+
+/* Our device structure: shared by virtio_pci and virtio_pci_legacy. */
+struct virtio_pci_device {
+	struct virtio_device vdev;
+	struct pci_dev *pci_dev;
+
+	/* The IO mapping for the PCI config space (non-legacy mode) */
+	struct virtio_pci_common_cfg __iomem *common;
+	/* Device-specific data (non-legacy mode)  */
+	void __iomem *device;
+	/* Base of vq notifications (non-legacy mode). */
+	void __iomem *notify_base;
+
+	/* In legacy mode, these two point to within ->legacy. */
+	/* Where to read and clear interrupt */
+	u8 __iomem *isr;
+
+	/* So we can sanity-check accesses. */
+	size_t notify_len;
+	size_t device_len;
+
+	/* a list of queues so we can dispatch IRQs */
+	spinlock_t lock;
+	struct list_head virtqueues;
+
+	/* MSI-X support */
+	int msix_enabled;
+	int intx_enabled;
+	struct msix_entry *msix_entries;
+	cpumask_var_t *msix_affinity_masks;
+	/* Name strings for interrupts. This size should be enough,
+	 * and I'm too lazy to allocate each name separately. */
+	char (*msix_names)[256];
+	/* Number of available vectors */
+	unsigned msix_vectors;
+	/* Vectors allocated, excluding per-vq vectors if any */
+	unsigned msix_used_vectors;
+
+	/* Status saved during hibernate/restore */
+	u8 saved_status;
+
+	/* Whether we have vector per vq */
+	bool per_vq_vectors;
+
+#ifdef CONFIG_VIRTIO_PCI_LEGACY
+	/* Instead of common and device, legacy uses this: */
+	void __iomem *legacy;
+#endif
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
+struct virtio_pci_vq_info {
+	/* the actual virtqueue */
+	struct virtqueue *vq;
+
+	/* the pages used for the queue. */
+	void *queue;
+
+	/* the list node for the virtqueues list */
+	struct list_head node;
+
+	/* Notify area for this vq. */
+	u16 __iomem *notify;
+
+	/* MSI-X vector (or none) */
+	unsigned msix_vector;
+};
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index d492361..340ab2e 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -22,79 +22,13 @@
 #include <linux/virtio_pci.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
+#include "virtio_pci-common.h"
 
 MODULE_AUTHOR("Rusty Russell <rusty@rustcorp.com.au>");
 MODULE_DESCRIPTION("virtio-pci");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("2");
 
-/* Our device structure */
-struct virtio_pci_device {
-	struct virtio_device vdev;
-	struct pci_dev *pci_dev;
-
-	/* The IO mapping for the PCI config space */
-	struct virtio_pci_common_cfg __iomem *common;
-	/* Where to read and clear interrupt */
-	u8 __iomem *isr;
-	/* Write the vq index here to notify device of activity. */
-	void __iomem *notify_base;
-	/* Device-specific data. */
-	void __iomem *device;
-
-	/* So we can sanity-check accesses. */
-	size_t notify_len;
-	size_t device_len;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-
-	/* MSI-X support */
-	int msix_enabled;
-	int intx_enabled;
-	struct msix_entry *msix_entries;
-	cpumask_var_t *msix_affinity_masks;
-	/* Name strings for interrupts. This size should be enough,
-	 * and I'm too lazy to allocate each name separately. */
-	char (*msix_names)[256];
-	/* Number of available vectors */
-	unsigned msix_vectors;
-	/* Vectors allocated, excluding per-vq vectors if any */
-	unsigned msix_used_vectors;
-
-	/* Status saved during hibernate/restore */
-	u8 saved_status;
-
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
-struct virtio_pci_vq_info {
-	/* the actual virtqueue */
-	struct virtqueue *vq;
-
-	/* the pages used for the queue. */
-	void *queue;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
-
-	/* Notify area for this vq. */
-	u16 __iomem *notify;
-
-	/* MSI-X vector (or none) */
-	unsigned msix_vector;
-};
-
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
 static DEFINE_PCI_DEVICE_TABLE(virtio_pci_id_table) = {
 	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 429f593..4c51965 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -25,6 +25,7 @@
 #include <linux/virtio_pci.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
+#include "virtio_pci-common.h"
 
 static bool force_nonlegacy;
 module_param(force_nonlegacy, bool, 0644);
@@ -35,65 +36,6 @@ MODULE_DESCRIPTION("virtio-pci-legacy");
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
-	cpumask_var_t *msix_affinity_masks;
-	/* Name strings for interrupts. This size should be enough,
-	 * and I'm too lazy to allocate each name separately. */
-	char (*msix_names)[256];
-	/* Number of available vectors */
-	unsigned msix_vectors;
-	/* Vectors allocated, excluding per-vq vectors if any */
-	unsigned msix_used_vectors;
-
-	/* Status saved during hibernate/restore */
-	u8 saved_status;
-
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
-	/* the virtual address of the ring queue */
-	void *queue;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
-
-	/* Notify area for this vq. */
-	u16 __iomem *notify;
-
-	/* MSI-X vector (or none) */
-	unsigned msix_vector;
-};
-
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
 static DEFINE_PCI_DEVICE_TABLE(virtio_pci_id_table) = {
 	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
@@ -114,7 +56,7 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
 	/* We only support 32 feature bits. */
-	return ioread32(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_HOST_FEATURES);
+	return ioread32(vp_dev->legacy + VIRTIO_PCI_LEGACY_HOST_FEATURES);
 }
 
 /* virtio config->finalize_features() implementation */
@@ -127,7 +69,7 @@ static void vp_finalize_features(struct virtio_device *vdev)
 
 	/* We only support 32 feature bits. */
 	iowrite32(vdev->features,
-		  vp_dev->ioaddr + VIRTIO_PCI_LEGACY_GUEST_FEATURES);
+		  vp_dev->legacy + VIRTIO_PCI_LEGACY_GUEST_FEATURES);
 }
 
 /* Device config access: we use guest endian, as per spec. */
@@ -135,13 +77,13 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->ioaddr +
+	void __iomem *legacy = vp_dev->legacy +
 				VIRTIO_PCI_LEGACY_CONFIG(vp_dev) + offset;
 	u8 *ptr = buf;
 	int i;
 
 	for (i = 0; i < len; i++)
-		ptr[i] = ioread8(ioaddr + i);
+		ptr[i] = ioread8(legacy + i);
 }
 
 #define VP_GETx(bits)							\
@@ -161,7 +103,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->ioaddr +
+	void __iomem *ioaddr = vp_dev->legacy +
 				VIRTIO_PCI_LEGACY_CONFIG(vp_dev) + offset;
 	const u8 *ptr = buf;
 	int i;
@@ -186,7 +128,7 @@ VP_SETx(64)
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
+	return ioread8(vp_dev->legacy + VIRTIO_PCI_LEGACY_STATUS);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
@@ -194,7 +136,7 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
+	iowrite8(status, vp_dev->legacy + VIRTIO_PCI_LEGACY_STATUS);
 }
 
 /* wait for pending irq handlers */
@@ -214,10 +156,10 @@ static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
-	iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
+	iowrite8(0, vp_dev->legacy + VIRTIO_PCI_LEGACY_STATUS);
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
-	ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_STATUS);
+	ioread8(vp_dev->legacy + VIRTIO_PCI_LEGACY_STATUS);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -276,7 +218,7 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
-	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_ISR);
+	isr = ioread8(vp_dev->legacy + VIRTIO_PCI_LEGACY_ISR);
 
 	/* It's definitely not us if the ISR was not high */
 	if (!isr)
@@ -309,9 +251,9 @@ static void vp_free_vectors(struct virtio_device *vdev)
 	if (vp_dev->msix_enabled) {
 		/* Disable the vector used for configuration */
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
+			  vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 		/* Flush the write out to device */
-		ioread16(vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
+		ioread16(vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 
 		pci_disable_msix(vp_dev->pci_dev);
 		vp_dev->msix_enabled = 0;
@@ -376,9 +318,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		goto error;
 	++vp_dev->msix_used_vectors;
 
-	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
+	iowrite16(v, vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 	/* Verify we had enough resources to assign the vector */
-	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
+	v = ioread16(vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
 	if (v == VIRTIO_MSI_NO_VECTOR) {
 		err = -EBUSY;
 		goto error;
@@ -427,11 +369,11 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	int err;
 
 	/* Select the queue we're interested in */
-	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_SEL);
+	iowrite16(index, vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_SEL);
 
 	/* Check if queue is either not available or already active. */
-	num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_NUM);
-	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN))
+	num = ioread16(vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_NUM);
+	if (!num || ioread32(vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_PFN))
 		return ERR_PTR(-ENOENT);
 
 	/* allocate and fill out our structure the represents an active
@@ -451,7 +393,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 
 	/* activate the queue */
 	iowrite32(virt_to_phys(info->queue)>>VIRTIO_PCI_LEGACY_QUEUE_ADDR_SHIFT,
-		  vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
+		  vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 
 	/* create the vring */
 	vq = vring_new_virtqueue(index, num,
@@ -464,12 +406,12 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 
 	vq->priv = info;
 	info->vq = vq;
-	info->notify = vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_NOTIFY;
+	info->notify = vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_NOTIFY;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
 		iowrite16(msix_vec,
-			  vp_dev->ioaddr + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
-		msix_vec = ioread16(vp_dev->ioaddr
+			  vp_dev->legacy + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
+		msix_vec = ioread16(vp_dev->legacy
 				    + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
@@ -490,7 +432,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 out_assign:
 	vring_del_virtqueue(vq);
 out_activate_queue:
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
+	iowrite32(0, vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 	free_pages_exact(info->queue, size);
 out_info:
 	kfree(info);
@@ -507,19 +449,19 @@ static void vp_del_vq(struct virtqueue *vq)
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
-	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_SEL);
+	iowrite16(vq->index, vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_SEL);
 
 	if (vp_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->ioaddr + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
+			  vp_dev->legacy + VIRTIO_MSI_LEGACY_QUEUE_VECTOR);
 		/* Flush the write out to device */
-		ioread8(vp_dev->ioaddr + VIRTIO_PCI_LEGACY_ISR);
+		ioread8(vp_dev->legacy + VIRTIO_PCI_LEGACY_ISR);
 	}
 
 	vring_del_virtqueue(vq);
 
 	/* Select and deactivate the queue */
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
+	iowrite32(0, vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 
 	size = PAGE_ALIGN(vring_size(vq->vring.num,
 				     VIRTIO_PCI_LEGACY_VRING_ALIGN));
@@ -767,12 +709,20 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (err)
 		goto out_enable_device;
 
-	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
-	if (vp_dev->ioaddr == NULL) {
+	vp_dev->legacy = pci_iomap(pci_dev, 0, 0);
+	if (vp_dev->legacy == NULL) {
 		err = -ENOMEM;
 		goto out_req_regions;
 	}
 
+	/* Not used for legacy virtio PCI */
+	vp_dev->common = NULL;
+	vp_dev->device = NULL;
+	vp_dev->notify_base = NULL;
+	vp_dev->notify_len = sizeof(u16);
+	/* Device config len actually depends on MSI-X: may overestimate */
+	vp_dev->device_len = pci_resource_len(pci_dev, 0) - 20;
+
 	pci_set_drvdata(pci_dev, vp_dev);
 	pci_set_master(pci_dev);
 
@@ -792,7 +742,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 
 out_set_drvdata:
 	pci_set_drvdata(pci_dev, NULL);
-	pci_iounmap(pci_dev, vp_dev->ioaddr);
+	pci_iounmap(pci_dev, vp_dev->legacy);
 out_req_regions:
 	pci_release_regions(pci_dev);
 out_enable_device:
@@ -810,7 +760,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 
 	vp_del_vqs(&vp_dev->vdev);
 	pci_set_drvdata(pci_dev, NULL);
-	pci_iounmap(pci_dev, vp_dev->ioaddr);
+	pci_iounmap(pci_dev, vp_dev->legacy);
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
 	kfree(vp_dev);
-- 
1.7.10.4
