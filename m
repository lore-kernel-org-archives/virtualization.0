From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 2/2] virtio: fix memory leak on device removal
Date: Thu, 23 Jul 2009 14:57:37 +0300
Message-ID: <20090723115737.GC12293__18798.4216296629$1248350373$gmane$org@redhat.com>
References: <cover.1248350116.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1248350116.git.mst@redhat.com>
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

Make vp_free_vectors do the reverse of vq_request_vectors.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a40e4f7..3aff895 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -258,7 +258,6 @@ static void vp_free_vectors(struct virtio_device *vdev)
 
 	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
 		free_irq(vp_dev->msix_entries[i].vector, vp_dev);
-	vp_dev->msix_used_vectors = 0;
 
 	if (vp_dev->msix_enabled) {
 		/* Disable the vector used for configuration */
@@ -267,9 +266,16 @@ static void vp_free_vectors(struct virtio_device *vdev)
 		/* Flush the write out to device */
 		ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
 
-		vp_dev->msix_enabled = 0;
 		pci_disable_msix(vp_dev->pci_dev);
+		vp_dev->msix_enabled = 0;
+		vp_dev->msix_vectors = 0;
 	}
+
+	vp_dev->msix_used_vectors = 0;
+	kfree(vp_dev->msix_names);
+	vp_dev->msix_names = NULL;
+	kfree(vp_dev->msix_entries);
+	vp_dev->msix_entries = NULL;
 }
 
 static int vp_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
@@ -297,11 +303,11 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
 	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
 				       GFP_KERNEL);
 	if (!vp_dev->msix_entries)
-		goto error_entries;
+		goto error;
 	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
 				     GFP_KERNEL);
 	if (!vp_dev->msix_names)
-		goto error_names;
+		goto error;
 
 	for (i = 0; i < nvectors; ++i)
 		vp_dev->msix_entries[i].entry = i;
@@ -314,7 +320,7 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
 		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
 				  IRQF_SHARED, name, vp_dev);
 		if (err)
-			goto error_irq;
+			goto error;
 		vp_dev->intx_enabled = 1;
 	} else {
 		vp_dev->msix_vectors = err;
@@ -328,7 +334,7 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
 				  vp_config_changed, 0, vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
-			goto error_irq;
+			goto error;
 		++vp_dev->msix_used_vectors;
 
 		iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
@@ -336,7 +342,7 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
 		v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
 		if (v == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
-			goto error_irq;
+			goto error;
 		}
 	}
 
@@ -349,16 +355,12 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
 				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
-			goto error_irq;
+			goto error;
 		++vp_dev->msix_used_vectors;
 	}
 	return 0;
-error_irq:
+error:
 	vp_free_vectors(vdev);
-	kfree(vp_dev->msix_names);
-error_names:
-	kfree(vp_dev->msix_entries);
-error_entries:
 	return err;
 }
 
-- 
1.6.2.5
