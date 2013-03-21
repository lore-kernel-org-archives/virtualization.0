From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 17/22] virtio_pci_legacy: cleanup struct virtio_pci_vq_info
Date: Thu, 21 Mar 2013 18:59:38 +1030
Message-ID: <1363854584-25795-18-git-send-email-rusty@rustcorp.com.au>
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

By removing the redundant num field and including a pointer to where we
should notify, it exactly matches the virtio_pci one now.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci_legacy.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index c7aadcb..429f593 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -81,15 +81,15 @@ struct virtio_pci_vq_info
 	/* the actual virtqueue */
 	struct virtqueue *vq;
 
-	/* the number of entries in the queue */
-	int num;
-
 	/* the virtual address of the ring queue */
 	void *queue;
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
 
+	/* Notify area for this vq. */
+	u16 __iomem *notify;
+
 	/* MSI-X vector (or none) */
 	unsigned msix_vector;
 };
@@ -225,11 +225,11 @@ static void vp_reset(struct virtio_device *vdev)
 /* the notify function used when creating a virt queue */
 static void vp_notify(struct virtqueue *vq)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_vq_info *info = vq->priv;
 
-	/* we write the queue's selector into the notification register to
-	 * signal the other end */
-	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_NOTIFY);
+	/* we write the queue selector into the notification register
+	 * to signal the other end */
+	iowrite16(vq->index, info->notify);
 }
 
 /* Handle a configuration change: Tell driver if it wants to know. */
@@ -440,7 +440,6 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	info->num = num;
 	info->msix_vector = msix_vec;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_LEGACY_VRING_ALIGN));
@@ -455,7 +454,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 		  vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 
 	/* create the vring */
-	vq = vring_new_virtqueue(index, info->num,
+	vq = vring_new_virtqueue(index, num,
 				 VIRTIO_PCI_LEGACY_VRING_ALIGN, vdev,
 				 true, info->queue, vp_notify, callback, name);
 	if (!vq) {
@@ -465,6 +464,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 
 	vq->priv = info;
 	info->vq = vq;
+	info->notify = vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_NOTIFY;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
 		iowrite16(msix_vec,
@@ -521,7 +521,8 @@ static void vp_del_vq(struct virtqueue *vq)
 	/* Select and deactivate the queue */
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_LEGACY_QUEUE_PFN);
 
-	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_LEGACY_VRING_ALIGN));
+	size = PAGE_ALIGN(vring_size(vq->vring.num,
+				     VIRTIO_PCI_LEGACY_VRING_ALIGN));
 	free_pages_exact(info->queue, size);
 	kfree(info);
 }
-- 
1.7.10.4
