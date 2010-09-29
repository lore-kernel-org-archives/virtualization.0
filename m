From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH] virtio: (Partially) enable suspend/resume support
Date: Wed, 29 Sep 2010 17:42:24 +0530
Message-ID: <da50daa251eb982c43fa474de8d4f1303f1ad57f.1285762305.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Let host know of our state (partial yet) so that the host PCI device is
up to where we were when we were suspended.

This is still an RFC as this doesn't completely work: an unused device
at the time of suspend will work fine after resume, but a device that
has seen some activity doesn't behave well after resume.  Especially,
host->guest communication doesn't go through.  This could be due to
interrupts/MSI not being wired properly.  I haven't looked at this part
of the problem yet.

We also need a per-driver resume callback which can update the devices
with driver-specific data.  Eg, for virtio_console, the guest port
open/close status will have to be known to the device.

QEMU also starts using the queues as soon as the VIRTIO_PCI_QUEUE_PFN
command is sent, so it has to be taught to only start using queues when
the device is ready and the queues are set up.

However, I just wanted to send this out to get reactions / comments.

Not-yet-Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_pci.c  |   34 ++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c |    8 ++++++++
 include/linux/virtio.h       |    2 ++
 include/linux/virtio_pci.h   |    4 +++-
 4 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index ef8d9d5..a3c7f59 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -698,8 +698,42 @@ static int virtio_pci_suspend(struct pci_dev *pci_dev, pm_message_t state)
 
 static int virtio_pci_resume(struct pci_dev *pci_dev)
 {
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_pci_vq_info *info;
+	unsigned long flags;
+
 	pci_restore_state(pci_dev);
 	pci_set_power_state(pci_dev, PCI_D0);
+
+	iowrite32(vp_dev->vdev.features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
+	if (vp_dev->msix_used_vectors)
+		iowrite16(vp_dev->msix_used_vectors,
+			  vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
+
+	spin_lock_irqsave(&vp_dev->lock, flags);
+	list_for_each_entry(info, &vp_dev->virtqueues, node) {
+		/* Select the queue we're interested in */
+		iowrite16(info->queue_index,
+			  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+
+		/* Update the last idx we sent data in */
+		iowrite16(virtqueue_get_avail_idx(info->vq),
+			  vp_dev->ioaddr + VIRTIO_PCI_AVAIL_IDX);
+
+		if (info->msix_vector != VIRTIO_MSI_NO_VECTOR) {
+			iowrite16(info->msix_vector,
+				  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
+		}
+
+		/* activate the queue */
+		iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+			  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
+
+	}
+	spin_unlock_irqrestore(&vp_dev->lock, flags);
+
+	vp_set_status(&vp_dev->vdev, VIRTIO_CONFIG_S_DRIVER_OK);
+
 	return 0;
 }
 #endif
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1475ed6..3eb91d1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -237,6 +237,14 @@ add_head:
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
 
+u16 virtqueue_get_avail_idx(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->vring.avail->idx;
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_avail_idx);
+
 void virtqueue_kick(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index aff5b4f..cdb04ec 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -88,6 +88,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
+u16 virtqueue_get_avail_idx(struct virtqueue *vq);
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index 9a3d7c4..aa3e584 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -55,9 +55,11 @@
 /* Vector value used to disable MSI for queue */
 #define VIRTIO_MSI_NO_VECTOR            0xffff
 
+#define VIRTIO_PCI_AVAIL_IDX		24
+
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
-#define VIRTIO_PCI_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
+#define VIRTIO_PCI_CONFIG(dev)		26
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
-- 
1.7.2.3
