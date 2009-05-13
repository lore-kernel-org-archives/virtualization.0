From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv5 3/3] virtio_pci: optional MSI-X support
Date: Wed, 13 May 2009 22:11:38 +0300
Message-ID: <20090513191138.GA4046__30795.401792466$1242242276$gmane$org@redhat.com>
References: <cover.1242241196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1242241196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redha
List-Id: virtualization@lists.linuxfoundation.org

This implements optional MSI-X support in virtio_pci.
MSI-X is used whenever the host supports at least 2 MSI-X
vectors: 1 for configuration changes and 1 for virtqueues.
Per-virtqueue vectors are allocated if enough vectors
available.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |  227 +++++++++++++++++++++++++++++++++++++++----
 include/linux/virtio_pci.h  |   10 ++-
 2 files changed, 217 insertions(+), 20 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 951e673..65627a4 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -42,6 +42,26 @@ struct virtio_pci_device
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
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
+	/* Vectors allocated */
+	unsigned msix_used_vectors;
+};
+
+/* Constants for MSI-X */
+/* Use first vector for configuration changes, second and the rest for
+ * virtqueues Thus, we need at least 2 vectors for MSI. */
+enum {
+	VP_MSIX_CONFIG_VECTOR = 0,
+	VP_MSIX_VQ_VECTOR = 1,
 };
 
 struct virtio_pci_vq_info
@@ -60,6 +80,9 @@ struct virtio_pci_vq_info
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
+
+	/* MSI-X vector (or none) */
+	unsigned vector;
 };
 
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
@@ -109,7 +132,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->ioaddr + VIRTIO_PCI_CONFIG + offset;
+	void __iomem *ioaddr = vp_dev->ioaddr +
+                               VIRTIO_PCI_CONFIG(vp_dev) + offset;
 	u8 *ptr = buf;
 	int i;
 
@@ -123,7 +147,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->ioaddr + VIRTIO_PCI_CONFIG + offset;
+	void __iomem *ioaddr = vp_dev->ioaddr +
+		               VIRTIO_PCI_CONFIG(vp_dev) + offset;
 	const u8 *ptr = buf;
 	int i;
 
@@ -221,7 +246,121 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	return vp_vring_interrupt(irq, opaque);
 }
 
-/* the config->find_vq() implementation */
+static void vp_free_vectors(struct virtio_device *vdev) {
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i;
+
+	if (vp_dev->intx_enabled) {
+		free_irq(vp_dev->pci_dev->irq, vp_dev);
+		vp_dev->intx_enabled = 0;
+	}
+
+	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
+		free_irq(vp_dev->msix_entries[i].vector, vp_dev);
+	vp_dev->msix_used_vectors = 0;
+
+	if (vp_dev->msix_enabled) {
+		/* Disable the vector used for configuration */
+		iowrite16(VIRTIO_MSI_NO_VECTOR,
+			  vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+		/* Flush the write out to device */
+		ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+
+		vp_dev->msix_enabled = 0;
+		pci_disable_msix(vp_dev->pci_dev);
+	}
+}
+
+static int vp_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
+			  int *options, int noptions)
+{
+	int i;
+	for (i = 0; i < noptions; ++i)
+		if (!pci_enable_msix(dev, entries, options[i]))
+			return options[i];
+	return -EBUSY;
+}
+
+static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	const char *name = dev_name(&vp_dev->vdev.dev);
+	unsigned i, v;
+	int err = -ENOMEM;
+	/* We want at most one vector per queue and one for config changes.
+	 * Fallback to separate vectors for config and a shared for queues.
+	 * Finally fall back to regular interrupts. */
+	int options[] = { max_vqs + 1, 2 };
+	int nvectors = max(options[0], options[1]);
+
+	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
+				       GFP_KERNEL);
+	if (!vp_dev->msix_entries)
+		goto error_entries;
+	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
+				     GFP_KERNEL);
+	if (!vp_dev->msix_names)
+		goto error_names;
+
+	for (i = 0; i < nvectors; ++i)
+		vp_dev->msix_entries[i].entry = i;
+
+	err = vp_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries,
+			     options, ARRAY_SIZE(options));
+	if (err < 0) {
+		/* Can't allocate enough MSI-X vectors, use regular interrupt */
+		vp_dev->msix_vectors = 0;
+		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+				  IRQF_SHARED, name, vp_dev);
+		if (err)
+			goto error_irq;
+		vp_dev->intx_enabled = 1;
+	} else {
+		vp_dev->msix_vectors = err;
+		vp_dev->msix_enabled = 1;
+
+		/* Set the vector used for configuration */
+		v = vp_dev->msix_used_vectors;
+		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
+			 "%s-config", name);
+		err = request_irq(vp_dev->msix_entries[v].vector,
+				  vp_config_changed, 0, vp_dev->msix_names[v],
+				  vp_dev);
+		if (err)
+			goto error_irq;
+		++vp_dev->msix_used_vectors;
+
+		iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+		/* Verify we had enough resources to assign the vector */
+		v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+		if (v == VIRTIO_MSI_NO_VECTOR) {
+			err = -EBUSY;
+			goto error_irq;
+		}
+	}
+
+	if (vp_dev->msix_vectors && vp_dev->msix_vectors != max_vqs + 1) {
+		/* Shared vector for all VQs */
+		v = vp_dev->msix_used_vectors;
+		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
+			 "%s-virtqueues", name);
+		err = request_irq(vp_dev->msix_entries[v].vector,
+				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
+				  vp_dev);
+		if (err)
+			goto error_irq;
+		++vp_dev->msix_used_vectors;
+	}
+	return 0;
+error_irq:
+	vp_free_vectors(vdev);
+	kfree(vp_dev->msix_names);
+error_names:
+	kfree(vp_dev->msix_entries);
+error_entries:
+	return err;
+}
+
 static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 				    void (*callback)(struct virtqueue *vq),
 				    const char *name)
@@ -230,7 +369,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
 	unsigned long flags, size;
-	u16 num;
+	u16 num, vector;
 	int err;
 
 	/* Select the queue we're interested in */
@@ -249,6 +388,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 
 	info->queue_index = index;
 	info->num = num;
+	info->vector = VIRTIO_MSI_NO_VECTOR;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
@@ -272,12 +412,43 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	vq->priv = info;
 	info->vq = vq;
 
+	/* allocate per-vq vector if available and necessary */
+	if (callback && vp_dev->msix_used_vectors < vp_dev->msix_vectors) {
+		vector = vp_dev->msix_used_vectors;
+		snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
+			 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
+		err = request_irq(vp_dev->msix_entries[vector].vector,
+				  vring_interrupt, 0,
+				  vp_dev->msix_names[vector], vq);
+		if (err)
+			goto out_request_irq;
+		info->vector = vector;
+		++vp_dev->msix_used_vectors;
+	} else
+		vector = VP_MSIX_VQ_VECTOR;
+
+	 if (callback && vp_dev->msix_enabled) {
+		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		if (vector == VIRTIO_MSI_NO_VECTOR) {
+			err = -EBUSY;
+			goto out_assign;
+		}
+	}
+
 	spin_lock_irqsave(&vp_dev->lock, flags);
 	list_add(&info->node, &vp_dev->virtqueues);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
 	return vq;
 
+out_assign:
+	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
+		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
+		--vp_dev->msix_used_vectors;
+	}
+out_request_irq:
+	vring_del_virtqueue(vq);
 out_activate_queue:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 	free_pages_exact(info->queue, size);
@@ -286,17 +457,27 @@ out_info:
 	return ERR_PTR(err);
 }
 
-/* the config->del_vq() implementation */
 static void vp_del_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_vq_info *info = vq->priv;
 	unsigned long size;
 
+	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+
+	if (info->vector != VIRTIO_MSI_NO_VECTOR)
+		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
+
+	if (vp_dev->msix_enabled) {
+		iowrite16(VIRTIO_MSI_NO_VECTOR,
+			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		/* Flush the write out to device */
+		ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+	}
+
 	vring_del_virtqueue(vq);
 
 	/* Select and deactivate the queue */
-	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
@@ -304,30 +485,46 @@ static void vp_del_vq(struct virtqueue *vq)
 	kfree(info);
 }
 
+/* the config->del_vqs() implementation */
 static void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtqueue *vq, *n;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		vp_del_vq(vq);
+
+	vp_free_vectors(vdev);
 }
 
+/* the config->find_vqs() implementation */
 static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
 		       const char *names[])
 {
-	int i;
+	int vectors = 0;
+	int i, err;
+
+	/* How many vectors would we like? */
+	for (i = 0; i < nvqs; ++i)
+		if (callbacks[i])
+			++vectors;
+
+	err = vp_request_vectors(vdev, vectors);
+	if (err)
+		goto error_request;
 
 	for (i = 0; i < nvqs; ++i) {
 		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i]);
 		if (IS_ERR(vqs[i]))
-			goto error;
+			goto error_find;
 	}
 	return 0;
 
-error:
+error_find:
 	vp_del_vqs(vdev);
+
+error_request:
 	return PTR_ERR(vqs[i]);
 }
 
@@ -349,7 +546,7 @@ static void virtio_pci_release_dev(struct device *_d)
 	struct virtio_pci_device *vp_dev = to_vp_device(dev);
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
 
-	free_irq(pci_dev->irq, vp_dev);
+	vp_del_vqs(dev);
 	pci_set_drvdata(pci_dev, NULL);
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
 	pci_release_regions(pci_dev);
@@ -408,21 +605,13 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 	vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
 	vp_dev->vdev.id.device = pci_dev->subsystem_device;
 
-	/* register a handler for the queue with the PCI device's interrupt */
-	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
-			  dev_name(&vp_dev->vdev.dev), vp_dev);
-	if (err)
-		goto out_set_drvdata;
-
 	/* finally register the virtio device */
 	err = register_virtio_device(&vp_dev->vdev);
 	if (err)
-		goto out_req_irq;
+		goto out_set_drvdata;
 
 	return 0;
 
-out_req_irq:
-	free_irq(pci_dev->irq, vp_dev);
 out_set_drvdata:
 	pci_set_drvdata(pci_dev, NULL);
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index cd0fd5d..9a3d7c4 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -47,9 +47,17 @@
 /* The bit of the ISR which indicates a device configuration change. */
 #define VIRTIO_PCI_ISR_CONFIG		0x2
 
+/* MSI-X registers: only enabled if MSI-X is enabled. */
+/* A 16-bit vector for configuration changes. */
+#define VIRTIO_MSI_CONFIG_VECTOR        20
+/* A 16-bit vector for selected queue notifications. */
+#define VIRTIO_MSI_QUEUE_VECTOR         22
+/* Vector value used to disable MSI for queue */
+#define VIRTIO_MSI_NO_VECTOR            0xffff
+
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
-#define VIRTIO_PCI_CONFIG		20
+#define VIRTIO_PCI_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
-- 
1.6.3.rc3.1.g830204
