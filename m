From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 1/2] virtio: fix double free_irq on device removal
Date: Thu, 23 Jul 2009 14:57:31 +0300
Message-ID: <20090723115731.GB12293__18016.1682110795$1248350370$gmane$org@redhat.com>
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

msix_user_vectors counted both per-vq and shared/config vectors.
This causes BUG_ON when device is removed, as
free_vectors tries to free per-vq vectors.

Count per-vq vectors separately so they are only freed by del_vq.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 193c8f0..a40e4f7 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -52,7 +52,7 @@ struct virtio_pci_device
 	char (*msix_names)[256];
 	/* Number of available vectors */
 	unsigned msix_vectors;
-	/* Vectors allocated */
+	/* Vectors allocated, excluding per-vq vectors if any */
 	unsigned msix_used_vectors;
 };
 
@@ -364,13 +364,15 @@ error_entries:
 
 static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 				    void (*callback)(struct virtqueue *vq),
-				    const char *name)
+				    const char *name,
+				    u16 vector,
+				    u16 per_vq_vector)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
 	unsigned long flags, size;
-	u16 num, vector;
+	u16 num;
 	int err;
 
 	/* Select the queue we're interested in */
@@ -389,7 +391,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 
 	info->queue_index = index;
 	info->num = num;
-	info->vector = VIRTIO_MSI_NO_VECTOR;
+	info->vector = per_vq_vector;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
@@ -414,8 +416,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	info->vq = vq;
 
 	/* allocate per-vq vector if available and necessary */
-	if (callback && vp_dev->msix_used_vectors < vp_dev->msix_vectors) {
-		vector = vp_dev->msix_used_vectors;
+	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
 		snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
 			 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
 		err = request_irq(vp_dev->msix_entries[vector].vector,
@@ -423,10 +424,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 				  vp_dev->msix_names[vector], vq);
 		if (err)
 			goto out_request_irq;
-		info->vector = vector;
-		++vp_dev->msix_used_vectors;
-	} else
-		vector = VP_MSIX_VQ_VECTOR;
+	}
 
 	 if (callback && vp_dev->msix_enabled) {
 		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
@@ -444,10 +442,8 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	return vq;
 
 out_assign:
-	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
+	if (info->vector != VIRTIO_MSI_NO_VECTOR)
 		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
-		--vp_dev->msix_used_vectors;
-	}
 out_request_irq:
 	vring_del_virtqueue(vq);
 out_activate_queue:
@@ -503,8 +499,10 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       vq_callback_t *callbacks[],
 		       const char *names[])
 {
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	u16 vector, per_vq_vector;
 	int vectors = 0;
-	int i, err;
+	int i, err, allocated_vectors;
 
 	/* How many vectors would we like? */
 	for (i = 0; i < nvqs; ++i)
@@ -515,8 +513,18 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	if (err)
 		goto error_request;
 
+	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
-		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i]);
+		if (!callbacks[i])
+			vector = per_vq_vector = VIRTIO_MSI_NO_VECTOR;
+		else if (vp_dev->msix_used_vectors < vp_dev->msix_vectors)
+			per_vq_vector = vector = allocated_vectors++;
+		else {
+			vector = VP_MSIX_VQ_VECTOR;
+			per_vq_vector = VIRTIO_MSI_NO_VECTOR;
+		}
+		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i],
+				    vector, per_vq_vector);
 		if (IS_ERR(vqs[i]))
 			goto error_find;
 	}
-- 
1.6.2.5
