From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/6] virtio_pci: minor MSI-X cleanups
Date: Mon, 21 Sep 2009 16:28:11 +0930
Message-ID: <200909211628.12106.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


1) Rename vp_request_vectors to vp_request_msix_vectors, and take
   non-MSI-X case out to caller.
2) Comment weird pci_enable_msix API
3) Rename vp_find_vq to setup_vq.
4) Fix spaces to tabs
5) Make nvectors calc internal to vp_try_to_find_vqs()
6) Rename vector to msix_vector for more clarity.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |   89 ++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -84,7 +84,7 @@ struct virtio_pci_vq_info
 	struct list_head node;
 
 	/* MSI-X vector (or none) */
-	unsigned vector;
+	unsigned msix_vector;
 };
 
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
@@ -280,25 +280,14 @@ static void vp_free_vectors(struct virti
 	vp_dev->msix_entries = NULL;
 }
 
-static int vp_request_vectors(struct virtio_device *vdev, int nvectors,
-			      bool per_vq_vectors)
+static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
+				   bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
 	unsigned i, v;
 	int err = -ENOMEM;
 
-	if (!nvectors) {
-		/* Can't allocate MSI-X vectors, use regular interrupt */
-		vp_dev->msix_vectors = 0;
-		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
-				  IRQF_SHARED, name, vp_dev);
-		if (err)
-			return err;
-		vp_dev->intx_enabled = 1;
-		return 0;
-	}
-
 	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
 				       GFP_KERNEL);
 	if (!vp_dev->msix_entries)
@@ -311,6 +300,7 @@ static int vp_request_vectors(struct vir
 	for (i = 0; i < nvectors; ++i)
 		vp_dev->msix_entries[i].entry = i;
 
+	/* pci_enable_msix returns positive if we can't get this many. */
 	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
 	if (err > 0)
 		err = -ENOSPC;
@@ -356,10 +346,22 @@ error:
 	return err;
 }
 
-static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
-				    void (*callback)(struct virtqueue *vq),
-				    const char *name,
-				    u16 vector)
+static int vp_request_intx(struct virtio_device *vdev)
+{
+	int err;
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
+	if (!err)
+		vp_dev->intx_enabled = 1;
+	return err;
+}
+
+static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
+				  void (*callback)(struct virtqueue *vq),
+				  const char *name,
+				  u16 msix_vec)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -384,7 +386,7 @@ static struct virtqueue *vp_find_vq(stru
 
 	info->queue_index = index;
 	info->num = num;
-	info->vector = vector;
+	info->msix_vector = msix_vec;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
@@ -408,10 +410,10 @@ static struct virtqueue *vp_find_vq(stru
 	vq->priv = info;
 	info->vq = vq;
 
-	 if (vector != VIRTIO_MSI_NO_VECTOR) {
-		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
-		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
-		if (vector == VIRTIO_MSI_NO_VECTOR) {
+	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
+		iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto out_assign;
 		}
@@ -472,7 +474,8 @@ static void vp_del_vqs(struct virtio_dev
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
 		info = vq->priv;
 		if (vp_dev->per_vq_vectors)
-			free_irq(vp_dev->msix_entries[info->vector].vector, vq);
+			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
+				 vq);
 		vp_del_vq(vq);
 	}
 	vp_dev->per_vq_vectors = false;
@@ -484,38 +487,58 @@ static int vp_try_to_find_vqs(struct vir
 			      struct virtqueue *vqs[],
 			      vq_callback_t *callbacks[],
 			      const char *names[],
-			      int nvectors,
+			      bool use_msix,
 			      bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	u16 vector;
-	int i, err, allocated_vectors;
+	u16 msix_vec;
+	int i, err, nvectors, allocated_vectors;
 
-	err = vp_request_vectors(vdev, nvectors, per_vq_vectors);
-	if (err)
-		goto error_request;
+	if (!use_msix) {
+		/* Old style: one normal interrupt for change and all vqs. */
+		err = vp_request_intx(vdev);
+		if (err)
+			goto error_request;
+	} else {
+		if (per_vq_vectors) {
+			/* Best option: one for change interrupt, one per vq. */
+			nvectors = 1;
+			for (i = 0; i < nvqs; ++i)
+				if (callbacks[i])
+					++nvectors;
+		} else {
+			/* Second best: one for change, shared for all vqs. */
+			nvectors = 2;
+		}
+
+		err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
+		if (err)
+			goto error_request;
+	}
 
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		if (!callbacks[i] || !vp_dev->msix_enabled)
-			vector = VIRTIO_MSI_NO_VECTOR;
+			msix_vec = VIRTIO_MSI_NO_VECTOR;
 		else if (vp_dev->per_vq_vectors)
-			vector = allocated_vectors++;
+			msix_vec = allocated_vectors++;
 		else
-			vector = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i], vector);
+			msix_vec = VP_MSIX_VQ_VECTOR;
+		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
 		/* allocate per-vq irq if available and necessary */
-		if (vp_dev->per_vq_vectors && vector != VIRTIO_MSI_NO_VECTOR) {
-			snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
-				 "%s-%s", dev_name(&vp_dev->vdev.dev), names[i]);
-			err = request_irq(vp_dev->msix_entries[vector].vector,
-					  vring_interrupt, 0,
-					  vp_dev->msix_names[vector], vqs[i]);
+		if (vp_dev->per_vq_vectors) {
+			snprintf(vp_dev->msix_names[msix_vec],
+				 sizeof *vp_dev->msix_names,
+				 "%s-%s",
+				 dev_name(&vp_dev->vdev.dev), names[i]);
+			err = request_irq(msix_vec, vring_interrupt, 0,
+					  vp_dev->msix_names[msix_vec],
+					  vqs[i]);
 			if (err) {
 				vp_del_vq(vqs[i]);
 				goto error_find;
@@ -537,28 +560,20 @@ static int vp_find_vqs(struct virtio_dev
 		       vq_callback_t *callbacks[],
 		       const char *names[])
 {
-	int vectors = 0;
-	int i, uninitialized_var(err);
+	int err;
 
-	/* How many vectors would we like? */
-	for (i = 0; i < nvqs; ++i)
-		if (callbacks[i])
-			++vectors;
-
-	/* We want at most one vector per queue and one for config changes. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				 vectors + 1, true);
+	/* Try MSI-X with one vector per queue. */
+	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, true, true);
 	if (!err)
 		return 0;
-	/* Fallback to separate vectors for config and a shared for queues. */
+	/* Fallback: MSI-X with one vector for config, one shared for queues. */
 	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				 2, false);
+				 true, false);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				 0, false);
-	return err;
+	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				  false, false);
 }
 
 static struct virtio_config_ops virtio_pci_config_ops = {
