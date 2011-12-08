From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 11/11] virtio_pci: simplify common helpers.
Date: Thu, 08 Dec 2011 21:14:02 +1030
Message-ID: <87ty5bfiml.fsf@rustcorp.com.au>
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

Our helpers can take a virtio_pci_device, rather than converting from
a virtio_device all the time.  They couldn't do this when they were
called from the common virtio code, but now we wrap them anyway, it
simplifies things.
---
 drivers/virtio/virtio_pci-common.c |   54 ++++++++++++++++---------------------
 drivers/virtio/virtio_pci-common.h |    6 ++--
 drivers/virtio/virtio_pci.c        |   10 +++---
 drivers/virtio/virtio_pci_legacy.c |    9 ++----
 4 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/virtio/virtio_pci-common.c b/drivers/virtio/virtio_pci-common.c
--- a/drivers/virtio/virtio_pci-common.c
+++ b/drivers/virtio/virtio_pci-common.c
@@ -81,10 +81,9 @@ irqreturn_t virtio_pci_interrupt(int irq
 	return virtio_pci_vring_interrupt(irq, opaque);
 }
 
-static void vp_free_vectors(struct virtio_device *vdev,
+static void vp_free_vectors(struct virtio_pci_device *vp_dev,
 			    __le16 __iomem *msix_config)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
 	if (vp_dev->intx_enabled) {
@@ -113,11 +112,10 @@ static void vp_free_vectors(struct virti
 	vp_dev->msix_entries = NULL;
 }
 
-static int vp_request_msix_vectors(struct virtio_device *vdev,
+static int vp_request_msix_vectors(struct virtio_pci_device *vp_dev,
 				   __le16 __iomem *msix_config,
 				   int nvectors, bool per_vq_vectors)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
 	unsigned i, v;
 	int err = -ENOMEM;
@@ -176,30 +174,28 @@ static int vp_request_msix_vectors(struc
 	}
 	return 0;
 error:
-	vp_free_vectors(vdev, msix_config);
+	vp_free_vectors(vp_dev, msix_config);
 	return err;
 }
 
-static int vp_request_intx(struct virtio_device *vdev)
+static int vp_request_intx(struct virtio_pci_device *vp_dev)
 {
 	int err;
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
 	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
-			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
+			  IRQF_SHARED, dev_name(&vp_dev->vdev.dev), vp_dev);
 	if (!err)
 		vp_dev->intx_enabled = 1;
 	return err;
 }
 
-static int vp_try_to_find_vqs(struct virtio_device *vdev,
+static int vp_try_to_find_vqs(struct virtio_pci_device *vp_dev,
 			      __le16 __iomem *msix_config,
-			      struct virtqueue *(setup_vq)(struct virtio_device*,
-							   unsigned,
-							   void (*)(struct
-								    virtqueue *),
-							   const char *,
-							   u16 msix_vec),
+			      struct virtqueue *(setup_vq)
+			      (struct virtio_pci_device *,
+			       unsigned,
+			       void (*)(struct virtqueue *),
+			       const char *,
+			       u16 msix_vec),
 			      void (*del_vq)(struct virtqueue *vq),
 			      unsigned nvqs,
 			      struct virtqueue *vqs[],
@@ -208,13 +204,12 @@ static int vp_try_to_find_vqs(struct vir
 			      bool use_msix,
 			      bool per_vq_vectors)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors;
 
 	if (!use_msix) {
 		/* Old style: one normal interrupt for change and all vqs. */
-		err = vp_request_intx(vdev);
+		err = vp_request_intx(vp_dev);
 		if (err)
 			goto error_request;
 	} else {
@@ -229,7 +224,7 @@ static int vp_try_to_find_vqs(struct vir
 			nvectors = 2;
 		}
 
-		err = vp_request_msix_vectors(vdev, msix_config,
+		err = vp_request_msix_vectors(vp_dev, msix_config,
 					      nvectors, per_vq_vectors);
 		if (err)
 			goto error_request;
@@ -244,7 +239,7 @@ static int vp_try_to_find_vqs(struct vir
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
+		vqs[i] = setup_vq(vp_dev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -270,16 +265,16 @@ static int vp_try_to_find_vqs(struct vir
 	return 0;
 
 error_find:
-	virtio_pci_del_vqs(vdev, msix_config, del_vq);
+	virtio_pci_del_vqs(vp_dev, msix_config, del_vq);
 
 error_request:
 	return err;
 }
 
 /* the config->find_vqs() implementation */
-int virtio_pci_find_vqs(struct virtio_device *vdev,
+int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev,
 			__le16 __iomem *msix_config,
-			struct virtqueue *(setup_vq)(struct virtio_device *,
+			struct virtqueue *(setup_vq)(struct virtio_pci_device *,
 						     unsigned,
 						     void (*)(struct virtqueue*),
 						     const char *,
@@ -293,30 +288,29 @@ int virtio_pci_find_vqs(struct virtio_de
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_try_to_find_vqs(vdev, msix_config, setup_vq, del_vq,
+	err = vp_try_to_find_vqs(vp_dev, msix_config, setup_vq, del_vq,
 				 nvqs, vqs, callbacks, names, true, true);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_try_to_find_vqs(vdev, msix_config, setup_vq, del_vq,
+	err = vp_try_to_find_vqs(vp_dev, msix_config, setup_vq, del_vq,
 				 nvqs, vqs, callbacks, names, true, false);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-	return vp_try_to_find_vqs(vdev, msix_config, setup_vq, del_vq,
+	return vp_try_to_find_vqs(vp_dev, msix_config, setup_vq, del_vq,
 				  nvqs, vqs, callbacks, names, false, false);
 }
 
 /* the core of a config->del_vqs() implementation */
-void virtio_pci_del_vqs(struct virtio_device *vdev,
+void virtio_pci_del_vqs(struct virtio_pci_device *vp_dev,
 			__le16 __iomem *msix_config,
 			void (*del_vq)(struct virtqueue *vq))
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq, *n;
 	struct virtio_pci_vq_info *info;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+	list_for_each_entry_safe(vq, n, &vp_dev->vdev.vqs, list) {
 		info = vq->priv;
 		if (vp_dev->per_vq_vectors &&
 			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
@@ -326,5 +320,5 @@ void virtio_pci_del_vqs(struct virtio_de
 	}
 	vp_dev->per_vq_vectors = false;
 
-	vp_free_vectors(vdev, msix_config);
+	vp_free_vectors(vp_dev, msix_config);
 }
diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
--- a/drivers/virtio/virtio_pci-common.h
+++ b/drivers/virtio/virtio_pci-common.h
@@ -87,9 +87,9 @@ irqreturn_t virtio_pci_vring_interrupt(i
 irqreturn_t virtio_pci_interrupt(int irq, void *opaque);
 
 /* Core of a config->find_vqs() implementation */
-int virtio_pci_find_vqs(struct virtio_device *vdev,
+int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev,
 			__le16 __iomem *msix_config,
-			struct virtqueue *(setup_vq)(struct virtio_device *,
+			struct virtqueue *(setup_vq)(struct virtio_pci_device *,
 						     unsigned,
 						     void (*)(struct virtqueue*),
 						     const char *,
@@ -101,7 +101,7 @@ int virtio_pci_find_vqs(struct virtio_de
 			const char *names[]);
 
 /* the core of a config->del_vqs() implementation */
-void virtio_pci_del_vqs(struct virtio_device *vdev,
+void virtio_pci_del_vqs(struct virtio_pci_device *vp_dev,
 			__le16 __iomem *msix_config,
 			void (*del_vq)(struct virtqueue *vq));
 
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -163,12 +163,12 @@ static void *alloc_virtqueue_pages(u16 *
 	return NULL;
 }
 
-static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
+static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
+				  unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
 				  u16 msix_vec)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
 	u16 num;
@@ -213,7 +213,7 @@ static struct virtqueue *setup_vq(struct
 
 	/* create the vring */
 	vq = vring_new_virtqueue(info->num, VIRTIO_PCI_ALIGN,
-				 vdev, info->queue, virtio_pci_notify,
+				 &vp_dev->vdev, info->queue, virtio_pci_notify,
 				 callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -294,7 +294,7 @@ static void vp_del_vq(struct virtqueue *
 static void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	virtio_pci_del_vqs(vdev, &vp_dev->common->msix_config, vp_del_vq);
+	virtio_pci_del_vqs(vp_dev, &vp_dev->common->msix_config, vp_del_vq);
 }
 
 static int vp_find_vqs(struct virtio_device *vdev,
@@ -304,7 +304,7 @@ static int vp_find_vqs(struct virtio_dev
 			const char *names[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return virtio_pci_find_vqs(vdev, &vp_dev->common->msix_config,
+	return virtio_pci_find_vqs(vp_dev, &vp_dev->common->msix_config,
 				   setup_vq, vp_del_vq,
 				   nvqs, vqs, callbacks, names);
 }
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -134,13 +134,12 @@ static void vp_reset(struct virtio_devic
 	vp_synchronize_vectors(vdev);
 }
 
-static struct virtqueue *setup_legacy_vq(struct virtio_device *vdev,
+static struct virtqueue *setup_legacy_vq(struct virtio_pci_device *vp_dev,
 					 unsigned index,
 					 void (*callback)(struct virtqueue *vq),
 					 const char *name,
 					 u16 msix_vec)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
 	unsigned long flags, size;
@@ -178,7 +177,7 @@ static struct virtqueue *setup_legacy_vq
 
 	/* create the vring */
 	vq = vring_new_virtqueue(info->num, VIRTIO_PCI_VRING_ALIGN,
-				 vdev, info->queue, virtio_pci_notify,
+				 &vp_dev->vdev, info->queue, virtio_pci_notify,
 				 callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -251,7 +250,7 @@ static void vp_del_vqs(struct virtio_dev
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return virtio_pci_del_vqs(vdev, vp_dev->legacy +
+	return virtio_pci_del_vqs(vp_dev, vp_dev->legacy +
 				  VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
 				  del_legacy_vq);
 }
@@ -264,7 +263,7 @@ static int vp_find_vqs(struct virtio_dev
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return virtio_pci_find_vqs(vdev, vp_dev->legacy +
+	return virtio_pci_find_vqs(vp_dev, vp_dev->legacy +
 				   VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
 				   setup_legacy_vq, del_legacy_vq,
 				   nvqs, vqs, callbacks, names);
