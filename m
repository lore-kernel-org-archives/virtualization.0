From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] virtio_pci: clean up interrupt state in struct
	virtio_pci_device
Date: Sun,  6 Nov 2016 15:09:43 -0800
Message-ID: <1478473783-12589-8-git-send-email-hch__31668.368043802$1478473920$gmane$org@lst.de>
References: <1478473783-12589-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478473783-12589-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently there is a lot of interrupt-related state in struct
virtio_pci_device, must of which is not needed:

 - msix_enabled is stored in struct pci_device and can be used there
 - msix_enabled isn't needed as we can call pci_free_irq_vectors even
   for the INTx case and it will do the right thing, as will a call
   to pci_irq_vector for vector 0
 - used_msix_vectors is not needed because we can just subtract the number
   of per-VQ vectors from the total number and get it
 - per_vq_vectors is not needed as we can just check the msix_vec field
   in the VQ for a valid vector

This just laves us with the old msix_vectors field that has been renamed
to irq_vectors and will be maintained for the INTx case as well to make
our life easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 64 ++++++++++++++------------------------
 drivers/virtio/virtio_pci_common.h | 12 ++-----
 drivers/virtio/virtio_pci_legacy.c |  2 +-
 drivers/virtio/virtio_pci_modern.c |  2 +-
 include/uapi/linux/virtio_pci.h    |  2 +-
 5 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 3f166bc..4b2af83 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -33,10 +33,7 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
-		synchronize_irq(vp_dev->pci_dev->irq);
-
-	for (i = 0; i < vp_dev->msix_vectors; ++i)
+	for (i = 0; i < vp_dev->irq_vectors; ++i)
 		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
@@ -117,8 +114,6 @@ static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 	unsigned i, v;
 	int err = -ENOMEM;
 
-	vp_dev->msix_vectors = nvectors;
-
 	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
 				     GFP_KERNEL);
 	if (!vp_dev->msix_names)
@@ -137,10 +132,9 @@ static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 			PCI_IRQ_MSIX);
 	if (err < 0)
 		goto error;
-	vp_dev->msix_enabled = 1;
 
 	/* Set the vector used for configuration */
-	err = vp_request_msix_vector(vp_dev, vp_dev->msix_used_vectors++,
+	err = vp_request_msix_vector(vp_dev, vp_dev->irq_vectors++,
 			vp_config_changed, "config", vp_dev);
 	if (err)
 		goto error;
@@ -211,46 +205,40 @@ void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq, *n;
+	int irq_vectors = vp_dev->irq_vectors;
 	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		if (vp_dev->per_vq_vectors) {
-			int v = vp_dev->vqs[vq->index]->msix_vector;
+		int vec = vp_dev->vqs[vq->index]->msix_vector;
 
-			if (v != VIRTIO_MSI_NO_VECTOR)
-				free_irq(pci_irq_vector(vp_dev->pci_dev, v),
-					vq);
+		if (vec != VIRTIO_MSI_NO_VECTOR && vec != VP_MSIX_VQ_VECTOR) {
+			free_irq(pci_irq_vector(vp_dev->pci_dev, vec), vq);
+			irq_vectors--;
 		}
-		vp_del_vq(vq);
-	}
-	vp_dev->per_vq_vectors = false;
 
-	if (vp_dev->intx_enabled) {
-		free_irq(vp_dev->pci_dev->irq, vp_dev);
-		vp_dev->intx_enabled = 0;
+		vp_del_vq(vq);
 	}
 
-	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
+	for (i = irq_vectors - 1; i >= 0; i--)
 		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
 
-	for (i = 0; i < vp_dev->msix_vectors; i++)
-		if (vp_dev->msix_affinity_masks[i])
+	if (vp_dev->msix_affinity_masks) {
+		for (i = 0; i < vp_dev->irq_vectors; i++)
 			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
+		kfree(vp_dev->msix_affinity_masks);
+		vp_dev->msix_affinity_masks = NULL;
+	}
 
-	if (vp_dev->msix_enabled) {
-		/* Disable the vector used for configuration */
+	/* Disable the vector used for configuration */
+	if (vp_dev->pci_dev->msix_enabled)
 		vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
 
-		pci_free_irq_vectors(vp_dev->pci_dev);
-		vp_dev->msix_enabled = 0;
-	}
+	pci_free_irq_vectors(vp_dev->pci_dev);
+	vp_dev->irq_vectors = 0;
 
-	vp_dev->msix_vectors = 0;
-	vp_dev->msix_used_vectors = 0;
 	kfree(vp_dev->msix_names);
 	vp_dev->msix_names = NULL;
-	kfree(vp_dev->msix_affinity_masks);
-	vp_dev->msix_affinity_masks = NULL;
+
 	kfree(vp_dev->vqs);
 	vp_dev->vqs = NULL;
 }
@@ -260,7 +248,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		const char * const names[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i, err, nvectors = 1, allocated_vectors;
+	int i, err, nvectors = 1;
 	u16 msix_vec;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
@@ -275,15 +263,13 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 	if (err)
 		goto out_del_vqs;
 
-	vp_dev->per_vq_vectors = true;
-	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i])
 			continue;
 		if (!callbacks[i])
 			msix_vec = VIRTIO_MSI_NO_VECTOR;
 		else
-			msix_vec = allocated_vectors++;
+			msix_vec = vp_dev->irq_vectors++;
 
 		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
@@ -319,12 +305,11 @@ static int vp_find_vqs_msix_shared(struct virtio_device *vdev, unsigned nvqs,
 	err = vp_setup_msix_vectors(vdev, 2);
 	if (err)
 		goto out_del_vqs;
-	err = vp_request_msix_vector(vp_dev, vp_dev->msix_used_vectors++,
+	err = vp_request_msix_vector(vp_dev, vp_dev->irq_vectors++,
 			vp_vring_interrupt, "virtqueues", vp_dev);
 	if (err)
 		goto out_del_vqs;
 
-	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i])
 			continue;
@@ -358,9 +343,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 			dev_name(&vdev->dev), vp_dev);
 	if (err)
 		goto out_del_vqs;
+	vp_dev->irq_vectors = 1;
 
-	vp_dev->intx_enabled = 1;
-	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
@@ -423,7 +407,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 	if (!vq->callback)
 		return -EINVAL;
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		mask = vp_dev->msix_affinity_masks[info->msix_vector];
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
 		if (cpu == -1)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index b2f6662..d3e3a1b 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -82,20 +82,12 @@ struct virtio_pci_device {
 	/* array of all queues for house-keeping */
 	struct virtio_pci_vq_info **vqs;
 
-	/* MSI-X support */
-	int msix_enabled;
-	int intx_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
 	char (*msix_names)[256];
-	/* Number of available vectors */
-	unsigned msix_vectors;
-	/* Vectors allocated, excluding per-vq vectors if any */
-	unsigned msix_used_vectors;
-
-	/* Whether we have vector per vq */
-	bool per_vq_vectors;
+	/* Total number of interrupt vectors (INTx or MSI-X) */
+	unsigned irq_vectors;
 
 	struct virtqueue *(*setup_vq)(struct virtio_pci_device *vp_dev,
 				      struct virtio_pci_vq_info *info,
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 8c4e617..25f90f0 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -169,7 +169,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 
 	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
 			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
 		/* Flush the write out to device */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e76bd91..e18d0b0 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -416,7 +416,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 
 	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
 
-	if (vp_dev->msix_enabled) {
+	if (vp_dev->pci_dev->msix_enabled) {
 		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
 			     &vp_dev->common->queue_msix_vector);
 		/* Flush the write out to device */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1..15b4385 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -79,7 +79,7 @@
  * configuration space */
 #define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
 /* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
-#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
+#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->pci_dev->msix_enabled)
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
-- 
2.1.4
