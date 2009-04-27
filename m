From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 8/8] virtio_pci: optional MSI-X support
Date: Mon, 27 Apr 2009 15:33:24 +0300
Message-ID: <20090427123324.GA1196__25357.4116658003$1240856445$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1240832196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This implements optional MSI-X support in virtio_pci.
MSI-X is used whenever the host supports at least 2 MSI-X
vectors: 1 for configuration changes and 1 for virtqueues.
Per-virtqueue vectors are allocated if enough vectors
available.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |  147 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 132 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 151538c..20bdc8c 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -42,8 +42,33 @@ struct virtio_pci_device
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+
+	/* MSI-X support */
+	struct msix_entry *msix_entries;
+	/* Name strings for interrupts. This size should be enough,
+	 * and I'm too lazy to allocate each name separately. */
+	char (*msix_names)[256];
+	/* Number of vectors configured at startup (excludes per-virtqueue
+	 * vectors if any) */
+	unsigned msix_preset_vectors;
+	/* Number of per-virtqueue vectors if any. */
+	unsigned msix_per_vq_vectors;
+};
+
+/* Constants for MSI-X */
+/* Use first vector for configuration changes, second and the rest for
+ * virtqueues Thus, we need at least 2 vectors for MSI. */
+enum {
+	VP_MSIX_CONFIG_VECTOR = 0,
+	VP_MSIX_VQ_VECTOR = 1,
+	VP_MSIX_MIN_VECTORS = 2
 };
 
+static inline int vq_vector(int index)
+{
+	return index + VP_MSIX_VQ_VECTOR;
+}
+
 struct virtio_pci_vq_info
 {
 	/* the actual virtqueue */
@@ -221,14 +246,92 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	return vp_vring_interrupt(irq, opaque);
 }
 
-	spin_lock_irqsave(&vp_dev->lock, flags);
-	list_for_each_entry(info, &vp_dev->virtqueues, node) {
-		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
-			ret = IRQ_HANDLED;
+/* the config->free_vqs() implementation */
+static void vp_free_vqs(struct virtio_device *vdev) {
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i;
+
+	for (i = 0; i < vp_dev->msix_preset_vectors; ++i)
+		free_irq(vp_dev->msix_entries[i].vector, vp_dev);
+
+	if (!vp_dev->msix_preset_vectors)
+		free_irq(vp_dev->pci_dev->irq, vp_dev);
+}
+
+/* the config->request_vqs() implementation */
+static int vp_request_vqs(struct virtio_device *vdev, unsigned max_vqs) {
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	const char *name = dev_name(&vp_dev->vdev.dev);
+	unsigned i, vectors;
+	int err = -ENOMEM;
+
+	/* We need at most one vector per queue and one for config changes */
+	vectors = vq_vector(max_vqs);
+	vp_dev->msix_entries = kmalloc(vectors * sizeof *vp_dev->msix_entries,
+				       GFP_KERNEL);
+	if (!vp_dev->msix_entries)
+		goto error_entries;
+	vp_dev->msix_names = kmalloc(vectors * sizeof *vp_dev->msix_names,
+				     GFP_KERNEL);
+	if (!vp_dev->msix_names)
+		goto error_names;
+
+	snprintf(vp_dev->msix_names[VP_MSIX_CONFIG_VECTOR],
+		 sizeof *vp_dev->msix_names, "%s-config", name);
+	for (i = 0; i < max_vqs; ++i)
+		snprintf(vp_dev->msix_names[vq_vector(i)],
+			 sizeof *vp_dev->msix_names, "%s-vq-%d", name, i);
+
+	vp_dev->msix_preset_vectors = 1;
+	vp_dev->msix_per_vq_vectors = max_vqs;
+	for (;;) {
+		err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries,
+				      vectors);
+		/* Error out if not enough vectors */
+		if (err > 0 && err < VP_MSIX_MIN_VECTORS)
+			err = -EBUSY;
+		if (err <= 0)
+			break;
+		/* Not enough vectors for all queues. Retry, disabling
+		 * per-queue interrupts */
+		vectors = VP_MSIX_MIN_VECTORS;
+		vp_dev->msix_preset_vectors = VP_MSIX_MIN_VECTORS;
+		vp_dev->msix_per_vq_vectors = 0;
+		snprintf(vp_dev->msix_names[VP_MSIX_VQ_VECTOR],
+			 sizeof *vp_dev->msix_names, "%s-vq", name);
 	}
-	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
-	return ret;
+	if (err) {
+		/* Can't allocate enough MSI-X vectors, use regular interrupt */
+		vp_dev->msix_preset_vectors = 0;
+		vp_dev->msix_per_vq_vectors = 0;
+		/* Register a handler for the queue with the PCI device's
+		 * interrupt */
+		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+				  IRQF_SHARED, name, vp_dev);
+		if (err)
+			goto error_irq;
+	}
+	for (i = 0; i < vp_dev->msix_preset_vectors; ++i) {
+		err = request_irq(vp_dev->msix_entries[i].vector,
+				  i == VP_MSIX_CONFIG_VECTOR ?
+				  vp_config_changed : vp_vring_interrupt,
+				  0, vp_dev->msix_names[i], vp_dev);
+		if (err) {
+			/* Set msix_preset_vectors so that only vectors we
+			 * already allocated will be freed by vp_free_vqs. */
+			vp_dev->msix_preset_vectors = i;
+			goto error_irq;
+		}
+	}
+	return 0;
+error_irq:
+	vp_free_vqs(vdev);
+	kfree(vp_dev->msix_names);
+error_names:
+	kfree(vp_dev->msix_entries);
+error_entries:
+	return err;
 }
 
 /* the config->find_vq() implementation */
@@ -242,6 +345,10 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	u16 num;
 	int err;
 
+	/* If using IRQ vector per vq, make sure we have enough vectors */
+	if (vp_dev->msix_per_vq_vectors && vp_dev->msix_per_vq_vectors <= index)
+		return ERR_PTR(-ENOENT);
+
 	/* Select the queue we're interested in */
 	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
@@ -285,8 +392,19 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	list_add(&info->node, &vp_dev->virtqueues);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
+	/* allocate per-vq irq if neccessary */
+	if (vp_dev->msix_per_vq_vectors) {
+		err = request_irq(vp_dev->msix_entries[vq_vector(index)].vector,
+				  vring_interrupt, 0,
+				  vp_dev->msix_names[vq_vector(index)], vq);
+		if (err)
+			goto out_request_irq;
+	}
+
 	return vq;
 
+out_request_irq:
+	vring_del_virtqueue(vq);
 out_activate_queue:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 	free_pages_exact(info->queue, size);
@@ -302,6 +420,11 @@ static void vp_del_vq(struct virtqueue *vq)
 	struct virtio_pci_vq_info *info = vq->priv;
 	unsigned long flags, size;
 
+	if (vp_dev->msix_per_vq_vectors) {
+		int vector = vq_vector(info->queue_index);
+		free_irq(vp_dev->msix_entries[vector].vector, vq);
+	}
+
 	spin_lock_irqsave(&vp_dev->lock, flags);
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
@@ -323,6 +446,8 @@ static struct virtio_config_ops virtio_pci_config_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
+	.request_vqs	= vp_request_vqs,
+	.free_vqs	= vp_free_vqs,
 	.find_vq	= vp_find_vq,
 	.del_vq		= vp_del_vq,
 	.get_features	= vp_get_features,
@@ -394,21 +519,13 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
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
-- 
1.6.0.6
