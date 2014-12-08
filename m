From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 06/10] virtio_pci: setup vqs indirectly
Date: Mon, 8 Dec 2014 17:16:47 +0200
Message-ID: <1418051779-27748-7-git-send-email-mst@redhat.com>
References: <1418051779-27748-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418051779-27748-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

VQ setup is mostly version-specific, add another level of indirection to
split the version-independent code out.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c | 69 ++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 133978c..68023e5 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -82,6 +82,12 @@ struct virtio_pci_device {
 	/* Whether we have vector per vq */
 	bool per_vq_vectors;
 
+	struct virtqueue *(*setup_vq)(struct virtio_pci_device *vp_dev,
+				      struct virtio_pci_vq_info *info,
+				      unsigned idx,
+				      void (*callback)(struct virtqueue *vq),
+				      const char *name,
+				      u16 msix_vec);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 };
 
@@ -389,15 +395,15 @@ static int vp_request_intx(struct virtio_device *vdev)
 	return err;
 }
 
-static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
+static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
+				  struct virtio_pci_vq_info *info,
+				  unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
 				  u16 msix_vec)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
-	unsigned long flags, size;
+	unsigned long size;
 	u16 num;
 	int err;
 
@@ -409,28 +415,21 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
 		return ERR_PTR(-ENOENT);
 
-	/* allocate and fill out our structure the represents an active
-	 * queue */
-	info = kmalloc(sizeof(struct virtio_pci_vq_info), GFP_KERNEL);
-	if (!info)
-		return ERR_PTR(-ENOMEM);
-
 	info->num = num;
 	info->msix_vector = msix_vec;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
 	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
-	if (info->queue == NULL) {
-		err = -ENOMEM;
-		goto out_info;
-	}
+	if (info->queue == NULL)
+		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
 	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
 		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	/* create the vring */
-	vq = vring_new_virtqueue(index, info->num, VIRTIO_PCI_VRING_ALIGN, vdev,
+	vq = vring_new_virtqueue(index, info->num,
+				 VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				 true, info->queue, vp_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -438,7 +437,6 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	}
 
 	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
-	info->vq = vq;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
 		iowrite16(msix_vec, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
@@ -449,6 +447,35 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 		}
 	}
 
+	return vq;
+
+out_assign:
+	vring_del_virtqueue(vq);
+out_activate_queue:
+	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+	free_pages_exact(info->queue, size);
+	return ERR_PTR(err);
+}
+
+static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
+				     void (*callback)(struct virtqueue *vq),
+				     const char *name,
+				     u16 msix_vec)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_vq_info *info = kmalloc(sizeof *info, GFP_KERNEL);
+	struct virtqueue *vq;
+	unsigned long flags;
+
+	/* fill out our structure that represents an active queue */
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, msix_vec);
+	if (IS_ERR(vq))
+		goto out_info;
+
+	info->vq = vq;
 	if (callback) {
 		spin_lock_irqsave(&vp_dev->lock, flags);
 		list_add(&info->node, &vp_dev->virtqueues);
@@ -460,14 +487,9 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	vp_dev->vqs[index] = info;
 	return vq;
 
-out_assign:
-	vring_del_virtqueue(vq);
-out_activate_queue:
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
-	free_pages_exact(info->queue, size);
 out_info:
 	kfree(info);
-	return ERR_PTR(err);
+	return vq;
 }
 
 static void del_vq(struct virtio_pci_vq_info *info)
@@ -578,7 +600,7 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i], msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -748,6 +770,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
 	vp_dev->vdev.id.device = pci_dev->subsystem_device;
 
+	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
 
 	/* finally register the virtio device */
-- 
MST
