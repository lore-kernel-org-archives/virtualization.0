From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 2/2] virtio: refactor find_vqs
Date: Sun, 26 Jul 2009 18:47:09 +0300
Message-ID: <20090726154709.GC21829__13334.0815817521$1248623360$gmane$org@redhat.com>
References: <cover.1248623150.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1248623150.git.mst@redhat.com>
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

This refactors find_vqs, making it more readable and robust, and fixing
two regressions from 2.6.30:
- double free_irq causing BUG_ON on device removal
- probe failure when vq can't be assigned to msi-x vector
  (reported on old host kernels)

An older version of this patch was tested by Amit Shah.

Reported-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |  212 ++++++++++++++++++++++++-------------------
 1 files changed, 119 insertions(+), 93 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 4c74c72..c17b830 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -52,8 +52,10 @@ struct virtio_pci_device
 	char (*msix_names)[256];
 	/* Number of available vectors */
 	unsigned msix_vectors;
-	/* Vectors allocated */
+	/* Vectors allocated, excluding per-vq vectors if any */
 	unsigned msix_used_vectors;
+	/* Whether we have vector per vq */
+	bool per_vq_vectors;
 };
 
 /* Constants for MSI-X */
@@ -278,27 +280,24 @@ static void vp_free_vectors(struct virtio_device *vdev)
 	vp_dev->msix_entries = NULL;
 }
 
-static int vp_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			  int *options, int noptions)
-{
-	int i;
-	for (i = 0; i < noptions; ++i)
-		if (!pci_enable_msix(dev, entries, options[i]))
-			return options[i];
-	return -EBUSY;
-}
-
-static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
+static int vp_request_vectors(struct virtio_device *vdev, int nvectors,
+			      bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
 	unsigned i, v;
 	int err = -ENOMEM;
-	/* We want at most one vector per queue and one for config changes.
-	 * Fallback to separate vectors for config and a shared for queues.
-	 * Finally fall back to regular interrupts. */
-	int options[] = { max_vqs + 1, 2 };
-	int nvectors = max(options[0], options[1]);
+
+	if (!nvectors) {
+		/* Can't allocate MSI-X vectors, use regular interrupt */
+		vp_dev->msix_vectors = 0;
+		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+				  IRQF_SHARED, name, vp_dev);
+		if (err)
+			return err;
+		vp_dev->intx_enabled = 1;
+		return 0;
+	}
 
 	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
 				       GFP_KERNEL);
@@ -312,41 +311,34 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
 	for (i = 0; i < nvectors; ++i)
 		vp_dev->msix_entries[i].entry = i;
 
-	err = vp_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries,
-			     options, ARRAY_SIZE(options));
-	if (err < 0) {
-		/* Can't allocate enough MSI-X vectors, use regular interrupt */
-		vp_dev->msix_vectors = 0;
-		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
-				  IRQF_SHARED, name, vp_dev);
-		if (err)
-			goto error;
-		vp_dev->intx_enabled = 1;
-	} else {
-		vp_dev->msix_vectors = err;
-		vp_dev->msix_enabled = 1;
-
-		/* Set the vector used for configuration */
-		v = vp_dev->msix_used_vectors;
-		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-			 "%s-config", name);
-		err = request_irq(vp_dev->msix_entries[v].vector,
-				  vp_config_changed, 0, vp_dev->msix_names[v],
-				  vp_dev);
-		if (err)
-			goto error;
-		++vp_dev->msix_used_vectors;
+	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
+	if (err > 0)
+		err = -ENOSPC;
+	if (err)
+		goto error;
+	vp_dev->msix_vectors = nvectors;
+	vp_dev->msix_enabled = 1;
+
+	/* Set the vector used for configuration */
+	v = vp_dev->msix_used_vectors;
+	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
+		 "%s-config", name);
+	err = request_irq(vp_dev->msix_entries[v].vector,
+			  vp_config_changed, 0, vp_dev->msix_names[v],
+			  vp_dev);
+	if (err)
+		goto error;
+	++vp_dev->msix_used_vectors;
 
-		iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
-		/* Verify we had enough resources to assign the vector */
-		v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
-		if (v == VIRTIO_MSI_NO_VECTOR) {
-			err = -EBUSY;
-			goto error;
-		}
+	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+	/* Verify we had enough resources to assign the vector */
+	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+	if (v == VIRTIO_MSI_NO_VECTOR) {
+		err = -EBUSY;
+		goto error;
 	}
 
-	if (vp_dev->msix_vectors && vp_dev->msix_vectors != max_vqs + 1) {
+	if (!per_vq_vectors) {
 		/* Shared vector for all VQs */
 		v = vp_dev->msix_used_vectors;
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
@@ -366,13 +358,14 @@ error:
 
 static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 				    void (*callback)(struct virtqueue *vq),
-				    const char *name)
+				    const char *name,
+				    u16 vector)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
 	unsigned long flags, size;
-	u16 num, vector;
+	u16 num;
 	int err;
 
 	/* Select the queue we're interested in */
@@ -391,7 +384,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 
 	info->queue_index = index;
 	info->num = num;
-	info->vector = VIRTIO_MSI_NO_VECTOR;
+	info->vector = vector;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
@@ -415,22 +408,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	vq->priv = info;
 	info->vq = vq;
 
-	/* allocate per-vq vector if available and necessary */
-	if (callback && vp_dev->msix_used_vectors < vp_dev->msix_vectors) {
-		vector = vp_dev->msix_used_vectors;
-		snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
-			 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
-		err = request_irq(vp_dev->msix_entries[vector].vector,
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[vector], vq);
-		if (err)
-			goto out_request_irq;
-		info->vector = vector;
-		++vp_dev->msix_used_vectors;
-	} else
-		vector = VP_MSIX_VQ_VECTOR;
-
-	 if (callback && vp_dev->msix_enabled) {
+	 if (vector != VIRTIO_MSI_NO_VECTOR) {
 		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
 		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
 		if (vector == VIRTIO_MSI_NO_VECTOR) {
@@ -446,11 +424,6 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	return vq;
 
 out_assign:
-	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
-		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
-		--vp_dev->msix_used_vectors;
-	}
-out_request_irq:
 	vring_del_virtqueue(vq);
 out_activate_queue:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
@@ -472,9 +445,6 @@ static void vp_del_vq(struct virtqueue *vq)
 
 	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
-	if (info->vector != VIRTIO_MSI_NO_VECTOR)
-		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
-
 	if (vp_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
 			  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
@@ -495,36 +465,62 @@ static void vp_del_vq(struct virtqueue *vq)
 /* the config->del_vqs() implementation */
 static void vp_del_vqs(struct virtio_device *vdev)
 {
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq, *n;
+	struct virtio_pci_vq_info *info;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+		info = vq->priv;
+		if (vp_dev->per_vq_vectors)
+			free_irq(vp_dev->msix_entries[info->vector].vector, vq);
 		vp_del_vq(vq);
+	}
+	vp_dev->per_vq_vectors = false;
 
 	vp_free_vectors(vdev);
 }
 
-/* the config->find_vqs() implementation */
-static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char *names[])
+static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+			      struct virtqueue *vqs[],
+			      vq_callback_t *callbacks[],
+			      const char *names[],
+			      int nvectors,
+			      bool per_vq_vectors)
 {
-	int vectors = 0;
-	int i, err;
-
-	/* How many vectors would we like? */
-	for (i = 0; i < nvqs; ++i)
-		if (callbacks[i])
-			++vectors;
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	u16 vector;
+	int i, err, allocated_vectors;
 
-	err = vp_request_vectors(vdev, vectors);
+	err = vp_request_vectors(vdev, nvectors, per_vq_vectors);
 	if (err)
 		goto error_request;
 
+	vp_dev->per_vq_vectors = per_vq_vectors;
+	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i]);
-		if (IS_ERR(vqs[i]))
+		if (!callbacks[i] || !vp_dev->msix_enabled)
+			vector = VIRTIO_MSI_NO_VECTOR;
+		else if (vp_dev->per_vq_vectors)
+			vector = allocated_vectors++;
+		else
+			vector = VP_MSIX_VQ_VECTOR;
+		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i], vector);
+		if (IS_ERR(vqs[i])) {
+			err = PTR_ERR(vqs[i]);
 			goto error_find;
+		}
+		/* allocate per-vq irq if available and necessary */
+		if (vp_dev->per_vq_vectors && vector != VIRTIO_MSI_NO_VECTOR) {
+			snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
+				 "%s-%s", dev_name(&vp_dev->vdev.dev), names[i]);
+			err = request_irq(vp_dev->msix_entries[vector].vector,
+					  vring_interrupt, 0,
+					  vp_dev->msix_names[vector], vqs[i]);
+			if (err) {
+				vp_del_vq(vqs[i]);
+				goto error_find;
+			}
+		}
 	}
 	return 0;
 
@@ -532,7 +528,37 @@ error_find:
 	vp_del_vqs(vdev);
 
 error_request:
-	return PTR_ERR(vqs[i]);
+	return err;
+}
+
+/* the config->find_vqs() implementation */
+static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+		       struct virtqueue *vqs[],
+		       vq_callback_t *callbacks[],
+		       const char *names[])
+{
+	int vectors = 0;
+	int i, uninitialized_var(err);
+
+	/* How many vectors would we like? */
+	for (i = 0; i < nvqs; ++i)
+		if (callbacks[i])
+			++vectors;
+
+	/* We want at most one vector per queue and one for config changes. */
+	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				 vectors + 1, true);
+	if (!err)
+		return 0;
+	/* Fallback to separate vectors for config and a shared for queues. */
+	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				 2, false);
+	if (!err)
+		return 0;
+	/* Finally fall back to regular interrupts. */
+	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				 0, false);
+	return err;
 }
 
 static struct virtio_config_ops virtio_pci_config_ops = {
-- 
1.6.2.5
