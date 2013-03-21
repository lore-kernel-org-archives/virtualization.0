From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 21/22] virtio_pci: simplify common helpers.
Date: Thu, 21 Mar 2013 18:59:42 +1030
Message-ID: <1363854584-25795-22-git-send-email-rusty@rustcorp.com.au>
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

Our helpers can take a virtio_pci_device, rather than converting from
a virtio_device all the time.  They couldn't do this when they were
called from the common virtio code, but now we wrap them anyway, it
simplifies things.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci-common.c |   40 +++++++++++++++---------------------
 drivers/virtio/virtio_pci-common.h |    6 +++---
 drivers/virtio/virtio_pci.c        |   10 ++++-----
 drivers/virtio/virtio_pci_legacy.c |    9 ++++----
 4 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/virtio/virtio_pci-common.c b/drivers/virtio/virtio_pci-common.c
index 837d34b..d4e33ad 100644
--- a/drivers/virtio/virtio_pci-common.c
+++ b/drivers/virtio/virtio_pci-common.c
@@ -93,10 +93,9 @@ void virtio_pci_synchronize_vectors(struct virtio_device *vdev)
 		synchronize_irq(vp_dev->msix_entries[i].vector);
 }
 
-static void vp_free_vectors(struct virtio_device *vdev,
+static void vp_free_vectors(struct virtio_pci_device *vp_dev,
 			    __le16 __iomem *msix_config)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
 	if (vp_dev->intx_enabled) {
@@ -131,12 +130,11 @@ static void vp_free_vectors(struct virtio_device *vdev,
 	vp_dev->msix_affinity_masks = NULL;
 }
 
-static int vp_request_msix_vectors(struct virtio_device *vdev,
+static int vp_request_msix_vectors(struct virtio_pci_device *vp_dev,
 				   int nvectors,
 				   __le16 __iomem *msix_config,
 				   bool per_vq_vectors)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
 	unsigned i, v;
 	int err = -ENOMEM;
@@ -204,23 +202,22 @@ static int vp_request_msix_vectors(struct virtio_device *vdev,
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
 
 	err = request_irq(vp_dev->pci_dev->irq, virtio_pci_interrupt,
-			  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
+			  IRQF_SHARED, dev_name(&vp_dev->vdev.dev), vp_dev);
 	if (!err)
 		vp_dev->intx_enabled = 1;
 	return err;
 }
 
-static int vp_try_to_find_vqs(struct virtio_device *vdev,
+static int vp_try_to_find_vqs(struct virtio_pci_device *vp_dev,
 			      unsigned nvqs,
 			      struct virtqueue *vqs[],
 			      vq_callback_t *callbacks[],
@@ -231,13 +228,12 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev,
 			      virtio_pci_setup_vq_fn *setup_vq,
 			      void (*del_vq)(struct virtqueue *vq))
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
@@ -252,7 +248,7 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev,
 			nvectors = 2;
 		}
 
-		err = vp_request_msix_vectors(vdev, nvectors, 
+		err = vp_request_msix_vectors(vp_dev, nvectors, 
 					      msix_config, per_vq_vectors);
 		if (err)
 			goto error_request;
@@ -270,8 +266,7 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i],
-				  msix_vec);
+		vqs[i] = setup_vq(vp_dev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -297,13 +292,13 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev,
 	return 0;
 
 error_find:
-	virtio_pci_del_vqs(vdev, msix_config, del_vq);
+	virtio_pci_del_vqs(vp_dev, msix_config, del_vq);
 
 error_request:
 	return err;
 }
 
-int virtio_pci_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev, unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
 			const char *names[],
@@ -314,29 +309,28 @@ int virtio_pci_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+	err = vp_try_to_find_vqs(vp_dev, nvqs, vqs, callbacks, names,
 				 true, true, msix_config, setup_vq, del_vq);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+	err = vp_try_to_find_vqs(vp_dev, nvqs, vqs, callbacks, names,
 				 true, false, msix_config, setup_vq, del_vq);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+	return vp_try_to_find_vqs(vp_dev, nvqs, vqs, callbacks, names,
 				  false, false, msix_config, setup_vq, del_vq);
 }
 
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
@@ -346,7 +340,7 @@ void virtio_pci_del_vqs(struct virtio_device *vdev,
 	}
 	vp_dev->per_vq_vectors = false;
 
-	vp_free_vectors(vdev, msix_config);
+	vp_free_vectors(vp_dev, msix_config);
 }
 
 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
index 2c4d890..146c3be 100644
--- a/drivers/virtio/virtio_pci-common.h
+++ b/drivers/virtio/virtio_pci-common.h
@@ -90,7 +90,7 @@ irqreturn_t virtio_pci_vring_interrupt(int irq, void *opaque);
 /* Acknowledge, check for config or vq interrupt. */
 irqreturn_t virtio_pci_interrupt(int irq, void *opaque);
 
-typedef struct virtqueue *virtio_pci_setup_vq_fn(struct virtio_device *,
+typedef struct virtqueue *virtio_pci_setup_vq_fn(struct virtio_pci_device *,
 						 unsigned index,
 						 void (*callback)
 							(struct virtqueue *),
@@ -98,7 +98,7 @@ typedef struct virtqueue *virtio_pci_setup_vq_fn(struct virtio_device *,
 						 u16 msix_vec);
 
 /* Core of a config->find_vqs() implementation */
-int virtio_pci_find_vqs(struct virtio_device *vdev,
+int virtio_pci_find_vqs(struct virtio_pci_device *vp_dev,
 			unsigned nvqs,
 			struct virtqueue *vqs[],
 			vq_callback_t *callbacks[],
@@ -108,7 +108,7 @@ int virtio_pci_find_vqs(struct virtio_device *vdev,
 			void (*del_vq)(struct virtqueue *vq));
 
 /* the core of a config->del_vqs() implementation */
-void virtio_pci_del_vqs(struct virtio_device *vdev,
+void virtio_pci_del_vqs(struct virtio_pci_device *vp_dev,
 			__le16 __iomem *msix_config,
 			void (*del_vq)(struct virtqueue *vq));
 
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 937fae7..97d9b54 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -182,12 +182,12 @@ static void *alloc_virtqueue_pages(u16 *num)
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
@@ -241,7 +241,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	}
 
 	/* create the vring */
-	vq = vring_new_virtqueue(index, num, SMP_CACHE_BYTES, vdev,
+	vq = vring_new_virtqueue(index, num, SMP_CACHE_BYTES, &vp_dev->vdev,
 				 true, info->queue, virtio_pci_notify,
 				 callback, name);
 	if (!vq) {
@@ -350,7 +350,7 @@ static void del_vq(struct virtqueue *vq)
 static void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	virtio_pci_del_vqs(vdev, &vp_dev->common->msix_config, del_vq);
+	virtio_pci_del_vqs(vp_dev, &vp_dev->common->msix_config, del_vq);
 }
 
 /* the config->find_vqs() implementation */
@@ -361,7 +361,7 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return virtio_pci_find_vqs(vdev, nvqs, vqs, callbacks, names,
+	return virtio_pci_find_vqs(vp_dev, nvqs, vqs, callbacks, names,
 				   &vp_dev->common->msix_config,
 				   setup_vq, del_vq);
 }
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 5ab05c3..f78a858 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -145,13 +145,12 @@ static void vp_reset(struct virtio_device *vdev)
 	virtio_pci_synchronize_vectors(vdev);
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
@@ -187,7 +186,7 @@ static struct virtqueue *setup_legacy_vq(struct virtio_device *vdev,
 
 	/* create the vring */
 	vq = vring_new_virtqueue(index, num,
-				 VIRTIO_PCI_LEGACY_VRING_ALIGN, vdev,
+				 VIRTIO_PCI_LEGACY_VRING_ALIGN, &vp_dev->vdev,
 				 true, info->queue, virtio_pci_notify,
 				 callback, name);
 	if (!vq) {
@@ -265,7 +264,7 @@ static void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	virtio_pci_del_vqs(vdev, vp_dev->legacy +
+	virtio_pci_del_vqs(vp_dev, vp_dev->legacy +
 			   VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
 			   del_legacy_vq);
 }
@@ -278,7 +277,7 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	return virtio_pci_find_vqs(vdev, nvqs, vqs, callbacks, names,
+	return virtio_pci_find_vqs(vp_dev, nvqs, vqs, callbacks, names,
 				   vp_dev->legacy +
 				   VIRTIO_MSI_LEGACY_CONFIG_VECTOR,
 				   setup_legacy_vq, del_legacy_vq);
-- 
1.7.10.4
