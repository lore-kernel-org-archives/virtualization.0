From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/7] virtio_pci: add a helper to request MSI-X interrupts
Date: Sun,  6 Nov 2016 15:09:41 -0800
Message-ID: <1478473783-12589-6-git-send-email-hch__24467.7807008431$1478473877$gmane$org@lst.de>
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

Factor out some duplicated code to format that MSI-X vector name and
request the interrupt for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 644bd80..7c44891 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -102,11 +102,19 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	return vp_vring_interrupt(irq, opaque);
 }
 
+static int vp_request_msix_vector(struct virtio_pci_device *vp_dev, int vec,
+		irq_handler_t handler, const char *name, void *dev_id)
+{
+	snprintf(vp_dev->msix_names[vec], sizeof(vp_dev->msix_names[vec]),
+			"%s-%s", dev_name(&vp_dev->vdev.dev), name);
+	return request_irq(pci_irq_vector(vp_dev->pci_dev, vec), handler, 0,
+			vp_dev->msix_names[vec], dev_id);
+}
+
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 				   bool per_vq_vectors)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	const char *name = dev_name(&vp_dev->vdev.dev);
 	unsigned i, v;
 	int err = -ENOMEM;
 
@@ -133,15 +141,10 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	vp_dev->msix_enabled = 1;
 
 	/* Set the vector used for configuration */
-	v = vp_dev->msix_used_vectors;
-	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-		 "%s-config", name);
-	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-			  vp_config_changed, 0, vp_dev->msix_names[v],
-			  vp_dev);
+	err = vp_request_msix_vector(vp_dev, vp_dev->msix_used_vectors++,
+			vp_config_changed, "config", vp_dev);
 	if (err)
 		goto error;
-	++vp_dev->msix_used_vectors;
 
 	v = vp_dev->config_vector(vp_dev, v);
 	/* Verify we had enough resources to assign the vector */
@@ -152,15 +155,10 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 
 	if (!per_vq_vectors) {
 		/* Shared vector for all VQs */
-		v = vp_dev->msix_used_vectors;
-		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
-			 "%s-virtqueues", name);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
-				  vp_dev);
+		err = vp_request_msix_vector(vp_dev, vp_dev->msix_used_vectors++,
+				vp_vring_interrupt, "virtqueues", vp_dev);
 		if (err)
 			goto error;
-		++vp_dev->msix_used_vectors;
 	}
 	return 0;
 error:
@@ -316,14 +314,8 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			continue;
 
 		/* allocate per-vq irq if available and necessary */
-		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
+		err = vp_request_msix_vector(vp_dev, msix_vec, vring_interrupt,
+				names[i], vqs[i]);
 		if (err) {
 			vp_del_vq(vqs[i]);
 			goto error_find;
-- 
2.1.4
