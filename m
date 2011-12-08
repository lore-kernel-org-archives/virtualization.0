From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 9/11] virtio_pci: share interrupt/notify handlers between legacy
	and modern.
Date: Thu, 08 Dec 2011 21:11:21 +1030
Message-ID: <87wra7fir2.fsf@rustcorp.com.au>
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

If we make the legacy driver set up the ->notify and ->isr pointers in
the struct virtio_pci_device structure, we can use them in common code
(the positions have changed, but the semantics haven't).
---
 drivers/virtio/Makefile            |    4 -
 drivers/virtio/virtio_pci-common.c |   81 ++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci-common.h |   34 +++++++++++++
 drivers/virtio/virtio_pci.c        |   87 ++---------------------------------
 drivers/virtio/virtio_pci_legacy.c |   91 ++++---------------------------------
 5 files changed, 135 insertions(+), 162 deletions(-)

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
-obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
-obj-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
+obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o virtio_pci-common.o
+obj-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o virtio_pci-common.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
diff --git a/drivers/virtio/virtio_pci-common.c b/drivers/virtio/virtio_pci-common.c
new file mode 100644
--- /dev/null
+++ b/drivers/virtio/virtio_pci-common.c
@@ -0,0 +1,81 @@
+/*
+ * Virtio PCI driver - common code for legacy and non-legacy.
+ *
+ * Copyright 2011, Rusty Russell IBM Corporation, but based on the
+ * older virtio_pci_legacy.c, which was Copyright IBM Corp. 2007.  But
+ * most of the interrupt setup code was written by Michael S. Tsirkin.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#define VIRTIO_PCI_NO_LEGACY
+#include "virtio_pci-common.h"
+#include <linux/virtio_ring.h>
+
+/* the notify function used when creating a virt queue */
+void virtio_pci_notify(struct virtqueue *vq)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_vq_info *info = vq->priv;
+
+	/* we write the queue's selector into the notification register to
+	 * signal the other end */
+	iowrite16(info->queue_index, vp_dev->notify);
+}
+
+/* Handle a configuration change: Tell driver if it wants to know. */
+irqreturn_t virtio_pci_config_changed(int irq, void *opaque)
+{
+	struct virtio_pci_device *vp_dev = opaque;
+	struct virtio_driver *drv;
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
+	if (drv->config_changed)
+		drv->config_changed(&vp_dev->vdev);
+	return IRQ_HANDLED;
+}
+
+/* Notify all virtqueues on an interrupt. */
+irqreturn_t virtio_pci_vring_interrupt(int irq, void *opaque)
+{
+	struct virtio_pci_device *vp_dev = opaque;
+	struct virtio_pci_vq_info *info;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vp_dev->lock, flags);
+	list_for_each_entry(info, &vp_dev->virtqueues, node) {
+		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
+			ret = IRQ_HANDLED;
+	}
+	spin_unlock_irqrestore(&vp_dev->lock, flags);
+
+	return ret;
+}
+
+/* A small wrapper to also acknowledge the interrupt when it's handled.
+ * I really need an EIO hook for the vring so I can ack the interrupt once we
+ * know that we'll be handling the IRQ but before we invoke the callback since
+ * the callback may notify the host which results in the host attempting to
+ * raise an interrupt that we would then mask once we acknowledged the
+ * interrupt. */
+irqreturn_t virtio_pci_interrupt(int irq, void *opaque)
+{
+	struct virtio_pci_device *vp_dev = opaque;
+	u8 isr;
+
+	/* reading the ISR has the effect of also clearing it so it's very
+	 * important to save off the value. */
+	isr = ioread8(vp_dev->isr);
+
+	/* It's definitely not us if the ISR was not high */
+	if (!isr)
+		return IRQ_NONE;
+
+	/* Configuration change?  Tell driver if it wants to know. */
+	if (isr & VIRTIO_PCI_ISR_CONFIG)
+		virtio_pci_config_changed(irq, opaque);
+
+	return virtio_pci_vring_interrupt(irq, opaque);
+}
diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
--- a/drivers/virtio/virtio_pci-common.h
+++ b/drivers/virtio/virtio_pci-common.h
@@ -42,6 +42,12 @@ struct virtio_pci_device
 	bool per_vq_vectors;
 };
 
+/* Convert a generic virtio device to our structure */
+static inline struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
+{
+	return container_of(vdev, struct virtio_pci_device, vdev);
+}
+
 /* Constants for MSI-X */
 /* Use first vector for configuration changes, second and the rest for
  * virtqueues Thus, we need at least 2 vectors for MSI. */
@@ -70,3 +76,31 @@ struct virtio_pci_vq_info
 	/* MSI-X vector (or none) */
 	unsigned msix_vector;
 };
+
+/* the notify function used when creating a virt queue */
+void virtio_pci_notify(struct virtqueue *vq);
+/* Handle a configuration change: Tell driver if it wants to know. */
+irqreturn_t virtio_pci_config_changed(int irq, void *opaque);
+/* Notify all virtqueues on an interrupt. */
+irqreturn_t virtio_pci_vring_interrupt(int irq, void *opaque);
+/* Acknowledge, check for config or vq interrupt. */
+irqreturn_t virtio_pci_interrupt(int irq, void *opaque);
+
+/* Core of a config->find_vqs() implementation */
+int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev,
+			__le16 __iomem *msix_config,
+			struct virtqueue *(setup_vq)(struct virtio_pci_device *,
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
+void virtio_pci_del_vqs(struct virtio_pci_device *vp_dev,
+			__le16 __iomem *msix_config,
+			void (*del_vq)(struct virtqueue *vq));
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -40,12 +40,6 @@ static struct pci_device_id virtio_pci_i
 
 MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
 
-/* Convert a generic virtio device to our structure */
-static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
-{
-	return container_of(vdev, struct virtio_pci_device, vdev);
-}
-
 /* There is no iowrite64.  We use two 32-bit ops. */
 static void iowrite64(u64 val, const __le64 *addr)
 {
@@ -151,74 +145,6 @@ static void vp_reset(struct virtio_devic
 	vp_synchronize_vectors(vdev);
 }
 
-/* the notify function used when creating a virt queue */
-static void vp_notify(struct virtqueue *vq)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_vq_info *info = vq->priv;
-
-	/* we write the queue's selector into the notification register to
-	 * signal the other end */
-	iowrite16(info->queue_index, vp_dev->notify);
-}
-
-/* Handle a configuration change: Tell driver if it wants to know. */
-static irqreturn_t vp_config_changed(int irq, void *opaque)
-{
-	struct virtio_pci_device *vp_dev = opaque;
-	struct virtio_driver *drv;
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	if (drv->config_changed)
-		drv->config_changed(&vp_dev->vdev);
-	return IRQ_HANDLED;
-}
-
-/* Notify all virtqueues on an interrupt. */
-static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
-{
-	struct virtio_pci_device *vp_dev = opaque;
-	struct virtio_pci_vq_info *info;
-	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vp_dev->lock, flags);
-	list_for_each_entry(info, &vp_dev->virtqueues, node) {
-		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
-			ret = IRQ_HANDLED;
-	}
-	spin_unlock_irqrestore(&vp_dev->lock, flags);
-
-	return ret;
-}
-
-/* A small wrapper to also acknowledge the interrupt when it's handled.
- * I really need an EIO hook for the vring so I can ack the interrupt once we
- * know that we'll be handling the IRQ but before we invoke the callback since
- * the callback may notify the host which results in the host attempting to
- * raise an interrupt that we would then mask once we acknowledged the
- * interrupt. */
-static irqreturn_t vp_interrupt(int irq, void *opaque)
-{
-	struct virtio_pci_device *vp_dev = opaque;
-	u8 isr;
-
-	/* reading the ISR has the effect of also clearing it so it's very
-	 * important to save off the value. */
-	isr = ioread8(vp_dev->isr);
-
-	/* It's definitely not us if the ISR was not high */
-	if (!isr)
-		return IRQ_NONE;
-
-	/* Configuration change?  Tell driver if it wants to know. */
-	if (isr & VIRTIO_PCI_ISR_CONFIG)
-		vp_config_changed(irq, opaque);
-
-	return vp_vring_interrupt(irq, opaque);
-}
-
 static void vp_free_vectors(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -284,7 +210,7 @@ static int vp_request_msix_vectors(struc
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
 	err = request_irq(vp_dev->msix_entries[v].vector,
-			  vp_config_changed, 0, vp_dev->msix_names[v],
+			  virtio_pci_config_changed, 0, vp_dev->msix_names[v],
 			  vp_dev);
 	if (err)
 		goto error;
@@ -304,8 +230,8 @@ static int vp_request_msix_vectors(struc
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
 		err = request_irq(vp_dev->msix_entries[v].vector,
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
-				  vp_dev);
+				  virtio_pci_vring_interrupt, 0,
+				  vp_dev->msix_names[v], vp_dev);
 		if (err)
 			goto error;
 		++vp_dev->msix_used_vectors;
@@ -321,7 +247,7 @@ static int vp_request_intx(struct virtio
 	int err;
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
 			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
 	if (!err)
 		vp_dev->intx_enabled = 1;
@@ -396,7 +322,8 @@ static struct virtqueue *setup_vq(struct
 
 	/* create the vring */
 	vq = vring_new_virtqueue(info->num, VIRTIO_PCI_ALIGN,
-				 vdev, info->queue, vp_notify, callback, name);
+				 vdev, info->queue, virtio_pci_notify,
+				 callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto out_alloc_pages;
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -44,12 +44,6 @@ static struct pci_device_id virtio_pci_i
 
 MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
 
-/* Convert a generic virtio device to our structure */
-static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
-{
-	return container_of(vdev, struct virtio_pci_device, vdev);
-}
-
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
 {
@@ -140,74 +134,6 @@ static void vp_reset(struct virtio_devic
 	vp_synchronize_vectors(vdev);
 }
 
-/* the notify function used when creating a virt queue */
-static void vp_notify(struct virtqueue *vq)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_vq_info *info = vq->priv;
-
-	/* we write the queue's selector into the notification register to
-	 * signal the other end */
-	iowrite16(info->queue_index, vp_dev->legacy + VIRTIO_PCI_QUEUE_NOTIFY);
-}
-
-/* Handle a configuration change: Tell driver if it wants to know. */
-static irqreturn_t vp_config_changed(int irq, void *opaque)
-{
-	struct virtio_pci_device *vp_dev = opaque;
-	struct virtio_driver *drv;
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	if (drv && drv->config_changed)
-		drv->config_changed(&vp_dev->vdev);
-	return IRQ_HANDLED;
-}
-
-/* Notify all virtqueues on an interrupt. */
-static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
-{
-	struct virtio_pci_device *vp_dev = opaque;
-	struct virtio_pci_vq_info *info;
-	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vp_dev->lock, flags);
-	list_for_each_entry(info, &vp_dev->virtqueues, node) {
-		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
-			ret = IRQ_HANDLED;
-	}
-	spin_unlock_irqrestore(&vp_dev->lock, flags);
-
-	return ret;
-}
-
-/* A small wrapper to also acknowledge the interrupt when it's handled.
- * I really need an EIO hook for the vring so I can ack the interrupt once we
- * know that we'll be handling the IRQ but before we invoke the callback since
- * the callback may notify the host which results in the host attempting to
- * raise an interrupt that we would then mask once we acknowledged the
- * interrupt. */
-static irqreturn_t vp_interrupt(int irq, void *opaque)
-{
-	struct virtio_pci_device *vp_dev = opaque;
-	u8 isr;
-
-	/* reading the ISR has the effect of also clearing it so it's very
-	 * important to save off the value. */
-	isr = ioread8(vp_dev->legacy + VIRTIO_PCI_ISR);
-
-	/* It's definitely not us if the ISR was not high */
-	if (!isr)
-		return IRQ_NONE;
-
-	/* Configuration change?  Tell driver if it wants to know. */
-	if (isr & VIRTIO_PCI_ISR_CONFIG)
-		vp_config_changed(irq, opaque);
-
-	return vp_vring_interrupt(irq, opaque);
-}
-
 static void vp_free_vectors(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -274,7 +200,7 @@ static int vp_request_msix_vectors(struc
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
 	err = request_irq(vp_dev->msix_entries[v].vector,
-			  vp_config_changed, 0, vp_dev->msix_names[v],
+			  virtio_pci_config_changed, 0, vp_dev->msix_names[v],
 			  vp_dev);
 	if (err)
 		goto error;
@@ -294,8 +220,8 @@ static int vp_request_msix_vectors(struc
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
 		err = request_irq(vp_dev->msix_entries[v].vector,
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
-				  vp_dev);
+				  virtio_pci_vring_interrupt, 0,
+				  vp_dev->msix_names[v], vp_dev);
 		if (err)
 			goto error;
 		++vp_dev->msix_used_vectors;
@@ -311,7 +237,7 @@ static int vp_request_intx(struct virtio
 	int err;
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
+	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
 			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
 	if (!err)
 		vp_dev->intx_enabled = 1;
@@ -361,7 +287,8 @@ static struct virtqueue *setup_vq(struct
 
 	/* create the vring */
 	vq = vring_new_virtqueue(info->num, VIRTIO_PCI_VRING_ALIGN,
-				 vdev, info->queue, vp_notify, callback, name);
+				 vdev, info->queue, virtio_pci_notify,
+				 callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto out_activate_queue;
@@ -624,6 +551,10 @@ static int __devinit virtio_pci_probe(st
 	if (vp_dev->legacy == NULL)
 		goto out_req_regions;
 
+	/* Setting this lets us share interrupt handlers with virtio_pci */
+	vp_dev->isr = vp_dev->legacy + VIRTIO_PCI_LEGACY_ISR;
+	vp_dev->notify = vp_dev->legacy + VIRTIO_PCI_LEGACY_QUEUE_NOTIFY;
+
 	pci_set_drvdata(pci_dev, vp_dev);
 	pci_set_master(pci_dev);
