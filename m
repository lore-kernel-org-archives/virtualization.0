From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] virtio: retry on vector assignment failure
Date: Thu, 23 Jul 2009 18:48:59 +0300
Message-ID: <20090723154859.GC13965__49780.1716709093$1248364388$gmane$org@redhat.com>
References: <cover.1248363752.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1248363752.git.mst@redhat.com>
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

virtio currently fails to find any vqs if the device supports msi-x but fails
to assign it to a queue.  Turns out, this actually happens for old host kernels
which can't allocate a gsi for the vector.  As a result guest does not use
virtio net.  Fix this by retrying with less vectors and finally disabling msi
on such failures and falling back on regular interrupts.

Reported-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

A slightly bigger patch was tested by Amit Shah and reported working,
this one has been made as small as possible for -rc inclusion.
Let's pospone bigger refactorings for 2.6.32.

 drivers/virtio/virtio_pci.c |  130 +++++++++++++++++++++++-------------------
 1 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 4bff231..25c7995 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -278,27 +278,24 @@ static void vp_free_vectors(struct virtio_device *vdev)
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
+static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs,
+			      int nvectors)
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
@@ -312,38 +309,31 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
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
 
 	if (vp_dev->msix_vectors && vp_dev->msix_vectors != max_vqs + 1) {
@@ -499,23 +489,17 @@ static void vp_del_vqs(struct virtio_device *vdev)
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
+			      int max_vqs, int nvectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 vector, per_vq_vector;
-	int vectors = 0;
 	int i, err, allocated_vectors;
 
-	/* How many vectors would we like? */
-	for (i = 0; i < nvqs; ++i)
-		if (callbacks[i])
-			++vectors;
-
-	err = vp_request_vectors(vdev, vectors);
+	err = vp_request_vectors(vdev, max_vqs, nvectors);
 	if (err)
 		goto error_request;
 
@@ -543,6 +527,34 @@ error_request:
 	return PTR_ERR(vqs[i]);
 }
 
+/* the config->find_vqs() implementation */
+static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+		       struct virtqueue *vqs[],
+		       vq_callback_t *callbacks[],
+		       const char *names[])
+{
+	/* We want at most one vector per queue and one for config changes.
+	 * Fallback to separate vectors for config and a shared for queues.
+	 * Finally fall back to regular interrupts. */
+	int options[] = { 1, 2, 0 };
+	int vectors = 0;
+	int i, uninitialized_var(err);
+
+	/* How many vectors would we like? */
+	for (i = 0; i < nvqs; ++i)
+		if (callbacks[i])
+			++vectors;
+	options[0] = vectors + 1;
+
+	for (i = 0; i < ARRAY_SIZE(options); ++i) {
+		err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+					 vectors, options[i]);
+		if (!err)
+			break;
+	}
+	return err;
+}
+
 static struct virtio_config_ops virtio_pci_config_ops = {
 	.get		= vp_get,
 	.set		= vp_set,
-- 
1.6.2.5
