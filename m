From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 10/11] virtio_pci: share virtqueue setup/teardown between modern
	and legacy driver.
Date: Thu, 08 Dec 2011 21:12:09 +1030
Message-ID: <87vcprfipq.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pqfzgy6p.fsf@rustcorp.com.au>
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

There's a great deal of work in setting up and disabling interrupts,
particularly with MSI-X, which is generic.  So we move most of the
work out to helpers which take the location of the msix_config
register, and setup_vq and del_vq functions.
---
 drivers/virtio/virtio_pci-common.c |  249 +++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci-common.h |   19 ++
 drivers/virtio/virtio_pci.c        |  224 +--------------------------------
 drivers/virtio/virtio_pci_legacy.c |  229 ++--------------------------------
 4 files changed, 291 insertions(+), 430 deletions(-)

diff --git a/drivers/virtio/virtio_pci-common.c b/drivers/virtio/virtio_pci-common.c
--- a/drivers/virtio/virtio_pci-common.c
+++ b/drivers/virtio/virtio_pci-common.c
@@ -11,6 +11,7 @@
 #define VIRTIO_PCI_NO_LEGACY
 #include "virtio_pci-common.h"
 #include <linux/virtio_ring.h>
+#include <linux/interrupt.h>
 
 /* the notify function used when creating a virt queue */
 void virtio_pci_notify(struct virtqueue *vq)
@@ -79,3 +80,251 @@ irqreturn_t virtio_pci_interrupt(int irq
 
 	return virtio_pci_vring_interrupt(irq, opaque);
 }
+
+static void vp_free_vectors(struct virtio_device *vdev,
+			    __le16 __iomem *msix_config)
+{
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
+
+	if (vp_dev->msix_enabled) {
+		/* Disable the vector used for configuration */
+		iowrite16(VIRTIO_MSI_NO_VECTOR, msix_config);
+		/* Flush the write out to device */
+		ioread16(msix_config);
+
+		pci_disable_msix(vp_dev->pci_dev);
+		vp_dev->msix_enabled = 0;
+		vp_dev->msix_vectors = 0;
+	}
+
+	vp_dev->msix_used_vectors = 0;
+	kfree(vp_dev->msix_names);
+	vp_dev->msix_names = NULL;
+	kfree(vp_dev->msix_entries);
+	vp_dev->msix_entries = NULL;
+}
+
+static int vp_request_msix_vectors(struct virtio_device *vdev,
+				   __le16 __iomem *msix_config,
+				   int nvectors, bool per_vq_vectors)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	const char *name = dev_name(&vp_dev->vdev.dev);
+	unsigned i, v;
+	int err = -ENOMEM;
+
+	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
+				       GFP_KERNEL);
+	if (!vp_dev->msix_entries)
+		goto error;
+	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
+				     GFP_KERNEL);
+	if (!vp_dev->msix_names)
+		goto error;
+
+	for (i = 0; i < nvectors; ++i)
+		vp_dev->msix_entries[i].entry = i;
+
+	/* pci_enable_msix returns positive if we can't get this many. */
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
+			  virtio_pci_config_changed, 0, vp_dev->msix_names[v],
+			  vp_dev);
+	if (err)
+		goto error;
+	++vp_dev->msix_used_vectors;
+
+	iowrite16(v, msix_config);
+	/* Verify we had enough resources to assign the vector */
+	v = ioread16(msix_config);
+	if (v == VIRTIO_MSI_NO_VECTOR) {
+		err = -EBUSY;
+		goto error;
+	}
+
+	if (!per_vq_vectors) {
+		/* Shared vector for all VQs */
+		v = vp_dev->msix_used_vectors;
+		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
+			 "%s-virtqueues", name);
+		err = request_irq(vp_dev->msix_entries[v].vector,
+				  virtio_pci_vring_interrupt, 0,
+				  vp_dev->msix_names[v], vp_dev);
+		if (err)
+			goto error;
+		++vp_dev->msix_used_vectors;
+	}
+	return 0;
+error:
+	vp_free_vectors(vdev, msix_config);
+	return err;
+}
+
+static int vp_request_intx(struct virtio_device *vdev)
+{
+	int err;
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
+			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
+	if (!err)
+		vp_dev->intx_enabled = 1;
+	return err;
+}
+
+static int vp_try_to_find_vqs(struct virtio_device *vdev,
+			      __le16 __iomem *msix_config,
+			      struct virtqueue *(setup_vq)(struct virtio_device*,
+							   unsigned,
+							   void (*)(struct
+								    virtqueue *),
+							   const char *,
+							   u16 msix_vec),
+			      void (*del_vq)(struct virtqueue *vq),
+			      unsigned nvqs,
+			      struct virtqueue *vqs[],
+			      vq_callback_t *callbacks[],
+			      const char *names[],
+			      bool use_msix,
+			      bool per_vq_vectors)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	u16 msix_vec;
+	int i, err, nvectors, allocated_vectors;
+
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
+		err = vp_request_msix_vectors(vdev, msix_config,
+					      nvectors, per_vq_vectors);
+		if (err)
+			goto error_request;
+	}
+
+	vp_dev->per_vq_vectors = per_vq_vectors;
+	allocated_vectors = vp_dev->msix_used_vectors;
+	for (i = 0; i < nvqs; ++i) {
+		if (!callbacks[i] || !vp_dev->msix_enabled)
+			msix_vec = VIRTIO_MSI_NO_VECTOR;
+		else if (vp_dev->per_vq_vectors)
+			msix_vec = allocated_vectors++;
+		else
+			msix_vec = VP_MSIX_VQ_VECTOR;
+		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
+		if (IS_ERR(vqs[i])) {
+			err = PTR_ERR(vqs[i]);
+			goto error_find;
+		}
+
+		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+			continue;
+
+		/* allocate per-vq irq if available and necessary */
+		snprintf(vp_dev->msix_names[msix_vec],
+			 sizeof *vp_dev->msix_names,
+			 "%s-%s",
+			 dev_name(&vp_dev->vdev.dev), names[i]);
+		err = request_irq(vp_dev->msix_entries[msix_vec].vector,
+				  vring_interrupt, 0,
+				  vp_dev->msix_names[msix_vec],
+				  vqs[i]);
+		if (err) {
+			del_vq(vqs[i]);
+			goto error_find;
+		}
+	}
+	return 0;
+
+error_find:
+	virtio_pci_del_vqs(vdev, msix_config, del_vq);
+
+error_request:
+	return err;
+}
+
+/* the config->find_vqs() implementation */
+int virtio_pci_find_vqs(struct virtio_device *vdev,
+			__le16 __iomem *msix_config,
+			struct virtqueue *(setup_vq)(struct virtio_device *,
+						     unsigned,
+						     void (*)(struct virtqueue*),
+						     const char *,
+						     u16 msix_vec),
+			void (*del_vq)(struct virtqueue *vq),
+			unsigned nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char *names[])
+{
+	int err;
+
+	/* Try MSI-X with one vector per queue. */
+	err = vp_try_to_find_vqs(vdev, msix_config, setup_vq, del_vq,
+				 nvqs, vqs, callbacks, names, true, true);
+	if (!err)
+		return 0;
+	/* Fallback: MSI-X with one vector for config, one shared for queues. */
+	err = vp_try_to_find_vqs(vdev, msix_config, setup_vq, del_vq,
+				 nvqs, vqs, callbacks, names, true, false);
+	if (!err)
+		return 0;
+	/* Finally fall back to regular interrupts. */
+	return vp_try_to_find_vqs(vdev, msix_config, setup_vq, del_vq,
+				  nvqs, vqs, callbacks, names, false, false);
+}
+
+/* the core of a config->del_vqs() implementation */
+void virtio_pci_del_vqs(struct virtio_device *vdev,
+			__le16 __iomem *msix_config,
+			void (*del_vq)(struct virtqueue *vq))
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtqueue *vq, *n;
+	struct virtio_pci_vq_info *info;
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+		info = vq->priv;
+		if (vp_dev->per_vq_vectors &&
+			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
+			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
+				 vq);
+		del_vq(vq);
+	}
+	vp_dev->per_vq_vectors = false;
+
+	vp_free_vectors(vdev, msix_config);
+}
diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
--- a/drivers/virtio/virtio_pci-common.h
+++ b/drivers/virtio/virtio_pci-common.h
@@ -87,6 +87,25 @@ irqreturn_t virtio_pci_vring_interrupt(i
 irqreturn_t virtio_pci_interrupt(int irq, void *opaque);
 
 /* Core of a config->find_vqs() implementation */
+int virtio_pci_find_vqs(struct virtio_device *vdev,
+			__le16 __iomem *msix_config,
+			struct virtqueue *(setup_vq)(struct virtio_device *,
+						     unsigned,
+						     void (*)(struct virtqueue*),
+						     const char *,
+						     u16 msix_vec),
+			void (*del_vq)(struct virtqueue *vq),
+			unsigned nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char *names[]);
+
+/* the core of a config->del_vqs() implementation */
+void virtio_pci_del_vqs(struct virtio_device *vdev,
+			__le16 __iomem *msix_config,
+			void (*del_vq)(struct virtqueue *vq));
+
+/* Core of a config->find_vqs() implementation */
 int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev,
 			__le16 __iomem *msix_config,
 			struct virtqueue *(setup_vq)(struct virtio_pci_device *,
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -145,115 +145,6 @@ static void vp_reset(struct virtio_devic
 	vp_synchronize_vectors(vdev);
 }
 
-static void vp_free_vectors(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
-
-	if (vp_dev->intx_enabled) {
-		free_irq(vp_dev->pci_dev->irq, vp_dev);
-		vp_dev->intx_enabled = 0;
-	}
-
-	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
-		free_irq(vp_dev->msix_entries[i].vector, vp_dev);
-
-	if (vp_dev->msix_enabled) {
-		/* Disable the vector used for configuration */
-		iowrite16(VIRTIO_MSI_NO_VECTOR, &vp_dev->common->msix_config);
-		/* Flush the write out to device */
-		ioread16(&vp_dev->common->msix_config);
-
-		pci_disable_msix(vp_dev->pci_dev);
-		vp_dev->msix_enabled = 0;
-		vp_dev->msix_vectors = 0;
-	}
-
-	vp_dev->msix_used_vectors = 0;
-	kfree(vp_dev->msix_names);
-	vp_dev->msix_names = NULL;
-	kfree(vp_dev->msix_entries);
-	vp_dev->msix_entries = NULL;
-}
-
-static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-				   bool per_vq_vectors)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	const char *name = dev_name(&vp_dev->vdev.dev);
-	unsigned i, v;
-	int err = -ENOMEM;
-
-	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
-				       GFP_KERNEL);
-	if (!vp_dev->msix_entries)
-		goto error;
-	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
-				     GFP_KERNEL);
-	if (!vp_dev->msix_names)
-		goto error;
-
-	for (i = 0; i < nvectors; ++i)
-		vp_dev->msix_entries[i].entry = i;
-
-	/* pci_enable_msix returns positive if we can't get this many. */
-	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
-	if (err > 0)
-		err = -ENOSPC;
-	if (err)
-		goto error;
-	vp_dev->msix_vectors = nvectors;
-	vp_dev->msix_enabled = 1;
-
-	/* Set the vector used for configuration */
-	v = vp_dev->msix_used_vectors;
-	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-		 "%s-config", name);
-	err = request_irq(vp_dev->msix_entries[v].vector,
-			  virtio_pci_config_changed, 0, vp_dev->msix_names[v],
-			  vp_dev);
-	if (err)
-		goto error;
-	++vp_dev->msix_used_vectors;
-
-	iowrite16(v, &vp_dev->common->msix_config);
-	/* Verify we had enough resources to assign the vector */
-	v = ioread16(&vp_dev->common->msix_config);
-	if (v == VIRTIO_MSI_NO_VECTOR) {
-		err = -EBUSY;
-		goto error;
-	}
-
-	if (!per_vq_vectors) {
-		/* Shared vector for all VQs */
-		v = vp_dev->msix_used_vectors;
-		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-			 "%s-virtqueues", name);
-		err = request_irq(vp_dev->msix_entries[v].vector,
-				  virtio_pci_vring_interrupt, 0,
-				  vp_dev->msix_names[v], vp_dev);
-		if (err)
-			goto error;
-		++vp_dev->msix_used_vectors;
-	}
-	return 0;
-error:
-	vp_free_vectors(vdev);
-	return err;
-}
-
-static int vp_request_intx(struct virtio_device *vdev)
-{
-	int err;
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
-			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
-	if (!err)
-		vp_dev->intx_enabled = 1;
-	return err;
-}
-
 static void *alloc_virtqueue_pages(u16 *num)
 {
 	void *pages;
@@ -403,116 +294,19 @@ static void vp_del_vq(struct virtqueue *
 static void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtqueue *vq, *n;
-	struct virtio_pci_vq_info *info;
-
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		info = vq->priv;
-		if (vp_dev->per_vq_vectors &&
-			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
-			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
-				 vq);
-		vp_del_vq(vq);
-	}
-	vp_dev->per_vq_vectors = false;
-
-	vp_free_vectors(vdev);
+	virtio_pci_del_vqs(vdev, &vp_dev->common->msix_config, vp_del_vq);
 }
 
-static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char *names[],
-			      bool use_msix,
-			      bool per_vq_vectors)
+static int vp_find_vqs(struct virtio_device *vdev,
+			unsigned nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char *names[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors;
-
-	if (!use_msix) {
-		/* Old style: one normal interrupt for change and all vqs. */
-		err = vp_request_intx(vdev);
-		if (err)
-			goto error_request;
-	} else {
-		if (per_vq_vectors) {
-			/* Best option: one for change interrupt, one per vq. */
-			nvectors = 1;
-			for (i = 0; i < nvqs; ++i)
-				if (callbacks[i])
-					++nvectors;
-		} else {
-			/* Second best: one for change, shared for all vqs. */
-			nvectors = 2;
-		}
-
-		err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
-		if (err)
-			goto error_request;
-	}
-
-	vp_dev->per_vq_vectors = per_vq_vectors;
-	allocated_vectors = vp_dev->msix_used_vectors;
-	for (i = 0; i < nvqs; ++i) {
-		if (!callbacks[i] || !vp_dev->msix_enabled)
-			msix_vec = VIRTIO_MSI_NO_VECTOR;
-		else if (vp_dev->per_vq_vectors)
-			msix_vec = allocated_vectors++;
-		else
-			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
-		if (IS_ERR(vqs[i])) {
-			err = PTR_ERR(vqs[i]);
-			goto error_find;
-		}
-
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
-			continue;
-
-		/* allocate per-vq irq if available and necessary */
-		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(vp_dev->msix_entries[msix_vec].vector,
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
-		if (err) {
-			vp_del_vq(vqs[i]);
-			goto error_find;
-		}
-	}
-	return 0;
-
-error_find:
-	vp_del_vqs(vdev);
-
-error_request:
-	return err;
-}
-
-/* the config->find_vqs() implementation */
-static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char *names[])
-{
-	int err;
-
-	/* Try MSI-X with one vector per queue. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, true, true);
-	if (!err)
-		return 0;
-	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				 true, false);
-	if (!err)
-		return 0;
-	/* Finally fall back to regular interrupts. */
-	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				  false, false);
+	return virtio_pci_find_vqs(vdev, &vp_dev->common->msix_config,
+				   setup_vq, vp_del_vq,
+				   nvqs, vqs, callbacks, names);
 }
 
 static struct virtio_config_ops virtio_pci_config_ops = {
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -134,120 +134,11 @@ static void vp_reset(struct virtio_devic
 	vp_synchronize_vectors(vdev);
 }
 
-static void vp_free_vectors(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
-
-	if (vp_dev->intx_enabled) {
-		free_irq(vp_dev->pci_dev->irq, vp_dev);
-		vp_dev->intx_enabled = 0;
-	}
-
-	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
-		free_irq(vp_dev->msix_entries[i].vector, vp_dev);
-
-	if (vp_dev->msix_enabled) {
-		/* Disable the vector used for configuration */
-		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
-		/* Flush the write out to device */
-		ioread16(vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
-
-		pci_disable_msix(vp_dev->pci_dev);
-		vp_dev->msix_enabled = 0;
-		vp_dev->msix_vectors = 0;
-	}
-
-	vp_dev->msix_used_vectors = 0;
-	kfree(vp_dev->msix_names);
-	vp_dev->msix_names = NULL;
-	kfree(vp_dev->msix_entries);
-	vp_dev->msix_entries = NULL;
-}
-
-static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-				   bool per_vq_vectors)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	const char *name = dev_name(&vp_dev->vdev.dev);
-	unsigned i, v;
-	int err = -ENOMEM;
-
-	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
-				       GFP_KERNEL);
-	if (!vp_dev->msix_entries)
-		goto error;
-	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
-				     GFP_KERNEL);
-	if (!vp_dev->msix_names)
-		goto error;
-
-	for (i = 0; i < nvectors; ++i)
-		vp_dev->msix_entries[i].entry = i;
-
-	/* pci_enable_msix returns positive if we can't get this many. */
-	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
-	if (err > 0)
-		err = -ENOSPC;
-	if (err)
-		goto error;
-	vp_dev->msix_vectors = nvectors;
-	vp_dev->msix_enabled = 1;
-
-	/* Set the vector used for configuration */
-	v = vp_dev->msix_used_vectors;
-	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-		 "%s-config", name);
-	err = request_irq(vp_dev->msix_entries[v].vector,
-			  virtio_pci_config_changed, 0, vp_dev->msix_names[v],
-			  vp_dev);
-	if (err)
-		goto error;
-	++vp_dev->msix_used_vectors;
-
-	iowrite16(v, vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
-	/* Verify we had enough resources to assign the vector */
-	v = ioread16(vp_dev->legacy + VIRTIO_MSI_CONFIG_VECTOR);
-	if (v == VIRTIO_MSI_NO_VECTOR) {
-		err = -EBUSY;
-		goto error;
-	}
-
-	if (!per_vq_vectors) {
-		/* Shared vector for all VQs */
-		v = vp_dev->msix_used_vectors;
-		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-			 "%s-virtqueues", name);
-		err = request_irq(vp_dev->msix_entries[v].vector,
-				  virtio_pci_vring_interrupt, 0,
-				  vp_dev->msix_names[v], vp_dev);
-		if (err)
-			goto error;
-		++vp_dev->msix_used_vectors;
-	}
-	return 0;
-error:
-	vp_free_vectors(vdev);
-	return err;
-}
-
-static int vp_request_intx(struct virtio_device *vdev)
-{
-	int err;
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
-			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
-	if (!err)
-		vp_dev->intx_enabled = 1;
-	return err;
-}
-
-static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
-				  void (*callback)(struct virtqueue *vq),
-				  const char *name,
-				  u16 msix_vec)
+static struct virtqueue *setup_legacy_vq(struct virtio_device *vdev,
+					 unsigned index,
+					 void (*callback)(struct virtqueue *vq),
+					 const char *name,
+					 u16 msix_vec)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -326,7 +217,7 @@ out_info:
 	return ERR_PTR(err);
 }
 
-static void vp_del_vq(struct virtqueue *vq)
+static void del_legacy_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_vq_info *info = vq->priv;
@@ -359,94 +250,10 @@ static void vp_del_vq(struct virtqueue *
 static void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtqueue *vq, *n;
-	struct virtio_pci_vq_info *info;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		info = vq->priv;
-		if (vp_dev->per_vq_vectors &&
-			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
-			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
-				 vq);
-		vp_del_vq(vq);
-	}
-	vp_dev->per_vq_vectors = false;
-
-	vp_free_vectors(vdev);
-}
-
-static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char *names[],
-			      bool use_msix,
-			      bool per_vq_vectors)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors;
-
-	if (!use_msix) {
-		/* Old style: one normal interrupt for change and all vqs. */
-		err = vp_request_intx(vdev);
-		if (err)
-			goto error_request;
-	} else {
-		if (per_vq_vectors) {
-			/* Best option: one for change interrupt, one per vq. */
-			nvectors = 1;
-			for (i = 0; i < nvqs; ++i)
-				if (callbacks[i])
-					++nvectors;
-		} else {
-			/* Second best: one for change, shared for all vqs. */
-			nvectors = 2;
-		}
-
-		err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
-		if (err)
-			goto error_request;
-	}
-
-	vp_dev->per_vq_vectors = per_vq_vectors;
-	allocated_vectors = vp_dev->msix_used_vectors;
-	for (i = 0; i < nvqs; ++i) {
-		if (!callbacks[i] || !vp_dev->msix_enabled)
-			msix_vec = VIRTIO_MSI_NO_VECTOR;
-		else if (vp_dev->per_vq_vectors)
-			msix_vec = allocated_vectors++;
-		else
-			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
-		if (IS_ERR(vqs[i])) {
-			err = PTR_ERR(vqs[i]);
-			goto error_find;
-		}
-
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
-			continue;
-
-		/* allocate per-vq irq if available and necessary */
-		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(vp_dev->msix_entries[msix_vec].vector,
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
-		if (err) {
-			vp_del_vq(vqs[i]);
-			goto error_find;
-		}
-	}
-	return 0;
-
-error_find:
-	vp_del_vqs(vdev);
-
-error_request:
-	return err;
+	return virtio_pci_del_vqs(vdev, vp_dev->legacy +
+				  VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
+				  del_legacy_vq);
 }
 
 /* the config->find_vqs() implementation */
@@ -455,20 +262,12 @@ static int vp_find_vqs(struct virtio_dev
 		       vq_callback_t *callbacks[],
 		       const char *names[])
 {
-	int err;
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	/* Try MSI-X with one vector per queue. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, true, true);
-	if (!err)
-		return 0;
-	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				 true, false);
-	if (!err)
-		return 0;
-	/* Finally fall back to regular interrupts. */
-	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
-				  false, false);
+	return virtio_pci_find_vqs(vdev, vp_dev->legacy +
+				   VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
+				   setup_legacy_vq, del_legacy_vq,
+				   nvqs, vqs, callbacks, names);
 }
 
 static struct virtio_config_ops virtio_pci_config_ops = {
