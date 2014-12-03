From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 1/2] virtio_pci: free up vq->priv
Date: Wed, 3 Dec 2014 18:14:27 +0200
Message-ID: <1417623248-15666-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

We don't need to go from vq to vq info on
data path, so using direct vq->priv pointer for that
seems like a waste.

Let's build an array of vq infos, then we can use vq->index
for that lookup.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 40b4d47..91b479b 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -47,6 +58,9 @@ struct virtio_pci_device {
 	spinlock_t lock;
 	struct list_head virtqueues;
 
+	/* array of all queues for house-keeping */
+	struct virtio_pci_vq_info **vqs;
+
 	/* MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
@@ -429,7 +432,6 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 		goto out_activate_queue;
 	}
 
-	vq->priv = info;
 	info->vq = vq;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
@@ -449,6 +451,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 		INIT_LIST_HEAD(&info->node);
 	}
 
+	vp_dev->vqs[index] = info;
 	return vq;
 
 out_assign:
@@ -464,7 +467,7 @@ out_info:
 static void vp_del_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_vq_info *info = vq->priv;
+	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
 	unsigned int num = vring_get_num(vq);
 	void *queue = vring_get_pages(vq);
 	unsigned long flags, size;
@@ -501,7 +504,7 @@ static void vp_del_vqs(struct virtio_device *vdev)
 	struct virtio_pci_vq_info *info;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		info = vq->priv;
+		info = vp_dev->vqs[vq->index];
 		if (vp_dev->per_vq_vectors &&
 			info->msix_vector != VIRTIO_MSI_NO_VECTOR)
 			free_irq(vp_dev->msix_entries[info->msix_vector].vector,
@@ -511,6 +514,7 @@ static void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->per_vq_vectors = false;
 
 	vp_free_vectors(vdev);
+	kfree(vp_dev->vqs);
 }
 
 static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
@@ -524,6 +528,10 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors;
 
+	vp_dev->vqs = kmalloc(nvqs * sizeof *vp_dev->vqs, GFP_KERNEL);
+	if (!vdev->vqs)
+		return -ENOMEM;
+
 	if (!use_msix) {
 		/* Old style: one normal interrupt for change and all vqs. */
 		err = vp_request_intx(vdev);
@@ -628,7 +636,7 @@ static int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 {
 	struct virtio_device *vdev = vq->vdev;
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_vq_info *info = vq->priv;
+	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
 	struct cpumask *mask;
 	unsigned int irq;
 
-- 
MST
