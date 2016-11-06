From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/7] virtio_pci: split the shared and per-VQ MSI-X setup
	routines
Date: Sun,  6 Nov 2016 15:09:42 -0800
Message-ID: <1478473783-12589-7-git-send-email-hch__2744.02383151955$1478473888$gmane$org@lst.de>
References: <1478473783-12589-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478473783-12589-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

While this is a tiny bit more code in terms of LOC it clearly separates
the purposes of both routines and makes them a lot easier to read, and
more importantly to modify for PCI-level affinity assignment which will
only go into the per-VQ version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 103 +++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7c44891..3f166bc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -111,8 +111,7 @@ static int vp_request_msix_vector(struct virtio_pci_device *vp_dev, int vec,
 			vp_dev->msix_names[vec], dev_id);
 }
 
-static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-				   bool per_vq_vectors)
+static int vp_setup_msix_vectors(struct virtio_device *vdev, int nvectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	unsigned i, v;
@@ -153,13 +152,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		goto error;
 	}
 
-	if (!per_vq_vectors) {
-		/* Shared vector for all VQs */
-		err = vp_request_msix_vector(vp_dev, vp_dev->msix_used_vectors++,
-				vp_vring_interrupt, "virtqueues", vp_dev);
-		if (err)
-			goto error;
-	}
 	return 0;
 error:
 	return err;
@@ -263,67 +255,90 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
-static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			      struct virtqueue *vqs[],
-			      vq_callback_t *callbacks[],
-			      const char * const names[],
-			      bool per_vq_vectors)
+static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i, err, nvectors = 1, allocated_vectors;
 	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors;
 
-	vp_dev->vqs = kmalloc(nvqs * sizeof *vp_dev->vqs, GFP_KERNEL);
+	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
-	if (per_vq_vectors) {
-		/* Best option: one for change interrupt, one per vq. */
-		nvectors = 1;
-		for (i = 0; i < nvqs; ++i)
-			if (callbacks[i])
-				++nvectors;
-	} else {
-		/* Second best: one for change, shared for all vqs. */
-		nvectors = 2;
+	for (i = 0; i < nvqs; ++i) {
+		if (callbacks[i])
+			nvectors++;
 	}
-
-	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
+	err = vp_setup_msix_vectors(vdev, nvectors);
 	if (err)
-		goto error_find;
+		goto out_del_vqs;
 
-	vp_dev->per_vq_vectors = per_vq_vectors;
+	vp_dev->per_vq_vectors = true;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
-			vqs[i] = NULL;
+		if (!names[i])
 			continue;
-		} else if (!callbacks[i] || !vp_dev->msix_enabled)
+		if (!callbacks[i])
 			msix_vec = VIRTIO_MSI_NO_VECTOR;
-		else if (vp_dev->per_vq_vectors)
-			msix_vec = allocated_vectors++;
 		else
-			msix_vec = VP_MSIX_VQ_VECTOR;
+			msix_vec = allocated_vectors++;
+
 		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
-			goto error_find;
+			goto out_del_vqs;
 		}
-
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+		if (msix_vec == VIRTIO_MSI_NO_VECTOR)
 			continue;
-
-		/* allocate per-vq irq if available and necessary */
 		err = vp_request_msix_vector(vp_dev, msix_vec, vring_interrupt,
 				names[i], vqs[i]);
 		if (err) {
 			vp_del_vq(vqs[i]);
-			goto error_find;
+			goto out_del_vqs;
 		}
 	}
+
 	return 0;
+out_del_vqs:
+	vp_del_vqs(vdev);
+	return err;
+}
+
+static int vp_find_vqs_msix_shared(struct virtio_device *vdev, unsigned nvqs,
+		struct virtqueue *vqs[], vq_callback_t *callbacks[],
+		const char * const names[])
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i, err;
+
+	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
+	if (!vp_dev->vqs)
+		return -ENOMEM;
+	err = vp_setup_msix_vectors(vdev, 2);
+	if (err)
+		goto out_del_vqs;
+	err = vp_request_msix_vector(vp_dev, vp_dev->msix_used_vectors++,
+			vp_vring_interrupt, "virtqueues", vp_dev);
+	if (err)
+		goto out_del_vqs;
 
-error_find:
+	vp_dev->per_vq_vectors = false;
+	for (i = 0; i < nvqs; ++i) {
+		if (!names[i])
+			continue;
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
+				callbacks[i] ? VP_MSIX_VQ_VECTOR :
+					VIRTIO_MSI_NO_VECTOR);
+		if (IS_ERR(vqs[i])) {
+			err = PTR_ERR(vqs[i]);
+			goto out_del_vqs;
+		}
+	}
+
+	return 0;
+out_del_vqs:
 	vp_del_vqs(vdev);
 	return err;
 }
@@ -374,11 +389,11 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, true);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, false);
+	err = vp_find_vqs_msix_shared(vdev, nvqs, vqs, callbacks, names);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-- 
2.1.4
