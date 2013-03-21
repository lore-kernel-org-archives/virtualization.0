From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 20/22] virtio_pci: share virtqueue setup/teardown between
	modern and legacy driver.
Date: Thu, 21 Mar 2013 18:59:41 +1030
Message-ID: <1363854584-25795-21-git-send-email-rusty@rustcorp.com.au>
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

There's a great deal of work in setting up and disabling interrupts,
particularly with MSI-X, which is generic.  So we move most of the
work out to helpers which take the location of the msix_config
register, and setup_vq and del_vq functions.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci-common.c |  349 ++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci-common.h |   32 ++--
 drivers/virtio/virtio_pci.c        |  330 +---------------------------------
 drivers/virtio/virtio_pci_legacy.c |  340 ++---------------------------------
 4 files changed, 396 insertions(+), 655 deletions(-)

diff --git a/drivers/virtio/virtio_pci-common.c b/drivers/virtio/virtio_pci-common.c
index f6588c2..837d34b 100644
--- a/drivers/virtio/virtio_pci-common.c
+++ b/drivers/virtio/virtio_pci-common.c
@@ -11,6 +11,7 @@
 #define VIRTIO_PCI_NO_LEGACY
 #include "virtio_pci-common.h"
 #include <linux/virtio_ring.h>
+#include <linux/interrupt.h>
 
 /* the notify function used when creating a virt queue */
 void virtio_pci_notify(struct virtqueue *vq)
@@ -78,3 +79,351 @@ irqreturn_t virtio_pci_interrupt(int irq, void *opaque)
 
 	return virtio_pci_vring_interrupt(irq, opaque);
 }
+
+/* wait for pending irq handlers */
+void virtio_pci_synchronize_vectors(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i;
+
+	if (vp_dev->intx_enabled)
+		synchronize_irq(vp_dev->pci_dev->irq);
+
+	for (i = 0; i < vp_dev->msix_vectors; ++i)
+		synchronize_irq(vp_dev->msix_entries[i].vector);
+}
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
+	for (i = 0; i < vp_dev->msix_vectors; i++)
+		if (vp_dev->msix_affinity_masks[i])
+			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
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
+	kfree(vp_dev->msix_affinity_masks);
+	vp_dev->msix_affinity_masks = NULL;
+}
+
+static int vp_request_msix_vectors(struct virtio_device *vdev,
+				   int nvectors,
+				   __le16 __iomem *msix_config,
+				   bool per_vq_vectors)
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
+	vp_dev->msix_affinity_masks
+		= kzalloc(nvectors * sizeof *vp_dev->msix_affinity_masks,
+			  GFP_KERNEL);
+	if (!vp_dev->msix_affinity_masks)
+		goto error;
+	for (i = 0; i < nvectors; ++i)
+		if (!alloc_cpumask_var(&vp_dev->msix_affinity_masks[i],
+					GFP_KERNEL))
+			goto error;
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
+			      unsigned nvqs,
+			      struct virtqueue *vqs[],
+			      vq_callback_t *callbacks[],
+			      const char *names[],
+			      bool use_msix,
+			      bool per_vq_vectors,
+			      __le16 __iomem *msix_config,
+			      virtio_pci_setup_vq_fn *setup_vq,
+			      void (*del_vq)(struct virtqueue *vq))
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
+		err = vp_request_msix_vectors(vdev, nvectors, 
+					      msix_config, per_vq_vectors);
+		if (err)
+			goto error_request;
+	}
+
+	vp_dev->per_vq_vectors = per_vq_vectors;
+	allocated_vectors = vp_dev->msix_used_vectors;
+	for (i = 0; i < nvqs; ++i) {
+		if (!names[i]) {
+			vqs[i] = NULL;
+			continue;
+		} else if (!callbacks[i] || !vp_dev->msix_enabled)
+			msix_vec = VIRTIO_MSI_NO_VECTOR;
+		else if (vp_dev->per_vq_vectors)
+			msix_vec = allocated_vectors++;
+		else
+			msix_vec = VP_MSIX_VQ_VECTOR;
+		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i],
+				  msix_vec);
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
+int virtio_pci_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char *names[],
+			__le16 __iomem *msix_config,
+			virtio_pci_setup_vq_fn *setup_vq,
+			void (*del_vq)(struct virtqueue *vq))
+{
+	int err;
+
+	/* Try MSI-X with one vector per queue. */
+	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				 true, true, msix_config, setup_vq, del_vq);
+	if (!err)
+		return 0;
+	/* Fallback: MSI-X with one vector for config, one shared for queues. */
+	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				 true, false, msix_config, setup_vq, del_vq);
+	if (!err)
+		return 0;
+	/* Finally fall back to regular interrupts. */
+	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				  false, false, msix_config, setup_vq, del_vq);
+}
+
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
+
+/* Setup the affinity for a virtqueue:
+ * - force the affinity for per vq vector
+ * - OR over all affinities for shared MSI
+ * - ignore the affinity request if we're using INTX
+ */
+int virtio_pci_set_vq_affinity(struct virtqueue *vq, int cpu)
+{
+	struct virtio_device *vdev = vq->vdev;
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_vq_info *info = vq->priv;
+	struct cpumask *mask;
+	unsigned int irq;
+
+	if (!vq->callback)
+		return -EINVAL;
+
+	if (vp_dev->msix_enabled) {
+		mask = vp_dev->msix_affinity_masks[info->msix_vector];
+		irq = vp_dev->msix_entries[info->msix_vector].vector;
+		if (cpu == -1)
+			irq_set_affinity_hint(irq, NULL);
+		else {
+			cpumask_set_cpu(cpu, mask);
+			irq_set_affinity_hint(irq, mask);
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+int virtio_pci_freeze(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_driver *drv;
+	int ret;
+
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
+	ret = 0;
+	vp_dev->saved_status = vp_dev->vdev.config->get_status(&vp_dev->vdev);
+	if (drv && drv->freeze)
+		ret = drv->freeze(&vp_dev->vdev);
+
+	if (!ret)
+		pci_disable_device(pci_dev);
+	return ret;
+}
+
+int virtio_pci_restore(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_driver *drv;
+	int ret;
+
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci_dev);
+	vp_dev->vdev.config->finalize_features(&vp_dev->vdev);
+
+	if (drv && drv->restore)
+		ret = drv->restore(&vp_dev->vdev);
+
+	/* Finally, tell the device we're all set */
+	if (!ret)
+		vp_dev->vdev.config->set_status(&vp_dev->vdev,
+						vp_dev->saved_status);
+
+	return ret;
+}
+#endif
diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
index 7dbc244..2c4d890 100644
--- a/drivers/virtio/virtio_pci-common.h
+++ b/drivers/virtio/virtio_pci-common.h
@@ -90,21 +90,33 @@ irqreturn_t virtio_pci_vring_interrupt(int irq, void *opaque);
 /* Acknowledge, check for config or vq interrupt. */
 irqreturn_t virtio_pci_interrupt(int irq, void *opaque);
 
+typedef struct virtqueue *virtio_pci_setup_vq_fn(struct virtio_device *,
+						 unsigned index,
+						 void (*callback)
+							(struct virtqueue *),
+						 const char *name,
+						 u16 msix_vec);
+
 /* Core of a config->find_vqs() implementation */
-int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev,
-			__le16 __iomem *msix_config,
-			struct virtqueue *(setup_vq)(struct virtio_pci_device *,
-						     unsigned,
-						     void (*)(struct virtqueue*),
-						     const char *,
-						     u16 msix_vec),
-			void (*del_vq)(struct virtqueue *vq),
+int virtio_pci_find_vqs(struct virtio_device *vdev,
 			unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
-			const char *names[]);
+			const char *names[],
+			__le16 __iomem *msix_config,
+			virtio_pci_setup_vq_fn *setup_vq,
+			void (*del_vq)(struct virtqueue *vq));
 
 /* the core of a config->del_vqs() implementation */
-void virtio_pci_del_vqs(struct virtio_pci_device *vp_dev,
+void virtio_pci_del_vqs(struct virtio_device *vdev,
 			__le16 __iomem *msix_config,
 			void (*del_vq)(struct virtqueue *vq));
+
+void virtio_pci_synchronize_vectors(struct virtio_device *vdev);
+
+int virtio_pci_set_vq_affinity(struct virtqueue *vq, int cpu);
+
+#ifdef CONFIG_PM
+int virtio_pci_freeze(struct device *dev);
+int virtio_pci_restore(struct device *dev);
+#endif
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index f720421..937fae7 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -147,19 +147,6 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	iowrite8(status, &vp_dev->common->device_status);
 }
 
-/* wait for pending irq handlers */
-static void vp_synchronize_vectors(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
-
-	if (vp_dev->intx_enabled)
-		synchronize_irq(vp_dev->pci_dev->irq);
-
-	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		synchronize_irq(vp_dev->msix_entries[i].vector);
-}
-
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -169,131 +156,7 @@ static void vp_reset(struct virtio_device *vdev)
 	 * including MSi-X interrupts, if any. */
 	ioread8(&vp_dev->common->device_status);
 	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
-}
-
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
-	for (i = 0; i < vp_dev->msix_vectors; i++)
-		if (vp_dev->msix_affinity_masks[i])
-			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
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
-	kfree(vp_dev->msix_affinity_masks);
-	vp_dev->msix_affinity_masks = NULL;
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
-	vp_dev->msix_affinity_masks
-		= kzalloc(nvectors * sizeof *vp_dev->msix_affinity_masks,
-			  GFP_KERNEL);
-	if (!vp_dev->msix_affinity_masks)
-		goto error;
-	for (i = 0; i < nvectors; ++i)
-		if (!alloc_cpumask_var(&vp_dev->msix_affinity_masks[i],
-					GFP_KERNEL))
-			goto error;
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
+	virtio_pci_synchronize_vectors(vdev);
 }
 
 static size_t vring_pci_size(u16 num)
@@ -448,7 +311,7 @@ static void vp_vq_disable(struct virtio_pci_device *vp_dev,
 	}
 }
 
-static void vp_del_vq(struct virtqueue *vq)
+static void del_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_vq_info *info = vq->priv;
@@ -487,97 +350,7 @@ static void vp_del_vq(struct virtqueue *vq)
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
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		} else if (!callbacks[i] || !vp_dev->msix_enabled)
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
+	virtio_pci_del_vqs(vdev, &vp_dev->common->msix_config, del_vq);
 }
 
 /* the config->find_vqs() implementation */
@@ -586,56 +359,18 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       vq_callback_t *callbacks[],
 		       const char *names[])
 {
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
-}
-
-static const char *vp_bus_name(struct virtio_device *vdev)
-{
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return pci_name(vp_dev->pci_dev);
+	return virtio_pci_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				   &vp_dev->common->msix_config,
+				   setup_vq, del_vq);
 }
 
-/* Setup the affinity for a virtqueue:
- * - force the affinity for per vq vector
- * - OR over all affinities for shared MSI
- * - ignore the affinity request if we're using INTX
- */
-static int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
+static const char *vp_bus_name(struct virtio_device *vdev)
 {
-	struct virtio_device *vdev = vq->vdev;
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_vq_info *info = vq->priv;
-	struct cpumask *mask;
-	unsigned int irq;
 
-	if (!vq->callback)
-		return -EINVAL;
-
-	if (vp_dev->msix_enabled) {
-		mask = vp_dev->msix_affinity_masks[info->msix_vector];
-		irq = vp_dev->msix_entries[info->msix_vector].vector;
-		if (cpu == -1)
-			irq_set_affinity_hint(irq, NULL);
-		else {
-			cpumask_set_cpu(cpu, mask);
-			irq_set_affinity_hint(irq, mask);
-		}
-	}
-	return 0;
+	return pci_name(vp_dev->pci_dev);
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -655,7 +390,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
-	.set_vq_affinity = vp_set_vq_affinity,
+	.set_vq_affinity = virtio_pci_set_vq_affinity,
 };
 
 static void virtio_pci_release_dev(struct device *_d)
@@ -836,53 +571,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PM
-static int virtio_pci_freeze(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	ret = 0;
-	vp_dev->saved_status = vp_get_status(&vp_dev->vdev);
-	if (drv && drv->freeze)
-		ret = drv->freeze(&vp_dev->vdev);
-
-	if (!ret)
-		pci_disable_device(pci_dev);
-	return ret;
-}
-
-static int virtio_pci_restore(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	ret = pci_enable_device(pci_dev);
-	if (ret)
-		return ret;
-
-	pci_set_master(pci_dev);
-	vp_finalize_features(&vp_dev->vdev);
-
-	if (drv && drv->restore)
-		ret = drv->restore(&vp_dev->vdev);
-
-	/* Finally, tell the device we're all set */
-	if (!ret)
-		vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
-
-	return ret;
-}
-
 static const struct dev_pm_ops virtio_pci_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
 };
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 0c604c7..5ab05c3 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -133,19 +133,6 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 	iowrite8(status, vp_dev->legacy + VIRTIO_PCI_LEGACY_STATUS);
 }
 
-/* wait for pending irq handlers */
-static void vp_synchronize_vectors(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i;
-
-	if (vp_dev->intx_enabled)
-		synchronize_irq(vp_dev->pci_dev->irq);
-
-	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		synchronize_irq(vp_dev->msix_entries[i].vector);
-}
-
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -155,138 +142,14 @@ static void vp_reset(struct virtio_device *vdev)
 	 * including MSi-X interrupts, if any. */
 	ioread8(vp_dev->legacy + VIRTIO_PCI_LEGACY_STATUS);
 	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
-}
-
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
-	for (i = 0; i < vp_dev->msix_vectors; i++)
-		if (vp_dev->msix_affinity_masks[i])
-			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
-
-	if (vp_dev->msix_enabled) {
-		/* Disable the vector used for configuration */
-		iowrite16(VIRTIO_MSI_NO_VECTOR,
-			  vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
-		/* Flush the write out to device */
-		ioread16(vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
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
-	kfree(vp_dev->msix_affinity_masks);
-	vp_dev->msix_affinity_masks = NULL;
+	virtio_pci_synchronize_vectors(vdev);
 }
 
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
-	vp_dev->msix_affinity_masks
-		= kzalloc(nvectors * sizeof *vp_dev->msix_affinity_masks,
-			  GFP_KERNEL);
-	if (!vp_dev->msix_affinity_masks)
-		goto error;
-	for (i = 0; i < nvectors; ++i)
-		if (!alloc_cpumask_var(&vp_dev->msix_affinity_masks[i],
-					GFP_KERNEL))
-			goto error;
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
-	iowrite16(v, vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
-	/* Verify we had enough resources to assign the vector */
-	v = ioread16(vp_dev->legacy + VIRTIO_MSI_LEGACY_CONFIG_VECTOR);
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
@@ -367,7 +230,7 @@ out_info:
 	return ERR_PTR(err);
 }
 
-static void vp_del_vq(struct virtqueue *vq)
+static void del_legacy_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_vq_info *info = vq->priv;
@@ -401,97 +264,10 @@ static void vp_del_vq(struct virtqueue *vq)
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
-		if (!names[i]) {
-			vqs[i] = NULL;
-			continue;
-		} else if (!callbacks[i] || !vp_dev->msix_enabled)
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
 
-error_find:
-	vp_del_vqs(vdev);
-
-error_request:
-	return err;
+	virtio_pci_del_vqs(vdev, vp_dev->legacy +
+			   VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
+			   del_legacy_vq);
 }
 
 /* the config->find_vqs() implementation */
@@ -500,20 +276,12 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
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
+	return virtio_pci_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				   vp_dev->legacy +
+				   VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
+				   setup_legacy_vq, del_legacy_vq);
 }
 
 static const char *vp_bus_name(struct virtio_device *vdev)
@@ -523,35 +291,6 @@ static const char *vp_bus_name(struct virtio_device *vdev)
 	return pci_name(vp_dev->pci_dev);
 }
 
-/* Setup the affinity for a virtqueue:
- * - force the affinity for per vq vector
- * - OR over all affinities for shared MSI
- * - ignore the affinity request if we're using INTX
- */
-static int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
-{
-	struct virtio_device *vdev = vq->vdev;
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_vq_info *info = vq->priv;
-	struct cpumask *mask;
-	unsigned int irq;
-
-	if (!vq->callback)
-		return -EINVAL;
-
-	if (vp_dev->msix_enabled) {
-		mask = vp_dev->msix_affinity_masks[info->msix_vector];
-		irq = vp_dev->msix_entries[info->msix_vector].vector;
-		if (cpu == -1)
-			irq_set_affinity_hint(irq, NULL);
-		else {
-			cpumask_set_cpu(cpu, mask);
-			irq_set_affinity_hint(irq, mask);
-		}
-	}
-	return 0;
-}
-
 static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get8		= vp_get8,
 	.set8		= vp_set8,
@@ -569,7 +308,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
-	.set_vq_affinity = vp_set_vq_affinity,
+	.set_vq_affinity = virtio_pci_set_vq_affinity,
 };
 
 static void virtio_pci_release_dev(struct device *_d)
@@ -698,53 +437,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PM
-static int virtio_pci_freeze(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	ret = 0;
-	vp_dev->saved_status = vp_get_status(&vp_dev->vdev);
-	if (drv && drv->freeze)
-		ret = drv->freeze(&vp_dev->vdev);
-
-	if (!ret)
-		pci_disable_device(pci_dev);
-	return ret;
-}
-
-static int virtio_pci_restore(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	ret = pci_enable_device(pci_dev);
-	if (ret)
-		return ret;
-
-	pci_set_master(pci_dev);
-	vp_finalize_features(&vp_dev->vdev);
-
-	if (drv && drv->restore)
-		ret = drv->restore(&vp_dev->vdev);
-
-	/* Finally, tell the device we're all set */
-	if (!ret)
-		vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
-
-	return ret;
-}
-
 static const struct dev_pm_ops virtio_pci_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
 };
-- 
1.7.10.4
