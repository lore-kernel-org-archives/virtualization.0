From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 14/22] virtio_pci: layout changes as per hpa's suggestions.
Date: Thu, 21 Mar 2013 18:59:35 +1030
Message-ID: <1363854584-25795-15-git-send-email-rusty@rustcorp.com.au>
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
Cc: "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

1) Drop the FIXME reference to BIR, just use BAR.
2) Make queue addresses explicit: desc/avail/used.
3) Add an explicit number of queues.
4) Have explicit queue_enable, which can double as a method to disable
   all activity on a queue (write 0, read until 0).

I also noticed that the 64-bit queue_address was at offset 28 (0x1C),
which is unusual, so add more padding to take the first 64-bit value
to offset 32 (0x20).

Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci.c     |   48 +++++++++++++++++++++++++++++++--------
 include/uapi/linux/virtio_pci.h |   11 +++++----
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index b86b99c..0169531 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -457,13 +457,14 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	u16 num;
 	int err;
 
+	if (index >= ioread16(&vp_dev->common->num_queues))
+		return ERR_PTR(-ENOENT);
+
 	/* Select the queue we're interested in */
 	iowrite16(index, &vp_dev->common->queue_select);
 
-	switch (ioread64(&vp_dev->common->queue_address)) {
-	case 0xFFFFFFFFFFFFFFFFULL:
-		return ERR_PTR(-ENOENT);
-	case 0:
+	/* Sanity check */
+	switch (ioread64(&vp_dev->common->queue_desc)) {
 		/* Uninitialized.  Excellent. */
 		break;
 	default:
@@ -522,9 +523,11 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	}
 
 	/* Activate the queue. */
-	iowrite64(virt_to_phys(info->queue), &vp_dev->common->queue_address);
-	iowrite16(SMP_CACHE_BYTES, &vp_dev->common->queue_align);
 	iowrite16(num, &vp_dev->common->queue_size);
+	iowrite64(virt_to_phys(vq->vring.desc), &vp_dev->common->queue_desc);
+	iowrite64(virt_to_phys(vq->vring.avail), &vp_dev->common->queue_avail);
+	iowrite64(virt_to_phys(vq->vring.used), &vp_dev->common->queue_used);
+	iowrite8(1, &vp_dev->common->queue_enable);
 
 	return vq;
 
@@ -537,6 +540,29 @@ out_info:
 	return ERR_PTR(err);
 }
 
+static void vp_vq_disable(struct virtio_pci_device *vp_dev,
+			  struct virtqueue *vq)
+{
+	unsigned long end;
+
+	/* Select the queue */
+	iowrite16(vq->index, &vp_dev->common->queue_select);
+
+	/* Disable it */
+ 	iowrite16(0, &vp_dev->common->queue_enable);
+
+	/* It's almost certainly synchronous, but just in case. */
+	end = jiffies + HZ/2;
+	while (ioread16(&vp_dev->common->queue_enable) != 0) {
+		if (time_after(jiffies, end)) {
+			dev_warn(&vp_dev->pci_dev->dev,
+				 "virtio_pci: disable ignored\n");
+			break;
+		}
+		cpu_relax();
+	}
+}
+
 static void vp_del_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
@@ -547,7 +573,10 @@ static void vp_del_vq(struct virtqueue *vq)
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vp_dev->lock, flags);
 
-	/* Select and deactivate the queue */
+	/* It should be quiescent, but disable first just in case. */
+	vp_vq_disable(vp_dev, vq);
+
+	/* Select the queue */
 	iowrite16(vq->index, &vp_dev->common->queue_select);
 
 	if (vp_dev->msix_enabled) {
@@ -560,9 +589,10 @@ static void vp_del_vq(struct virtqueue *vq)
 	vring_del_virtqueue(vq);
 
 	/* This is for our own benefit, not the device's! */
-	iowrite64(0, &vp_dev->common->queue_address);
 	iowrite16(0, &vp_dev->common->queue_size);
-	iowrite16(0, &vp_dev->common->queue_align);
+	iowrite64(0, &vp_dev->common->queue_desc);
+	iowrite64(0, &vp_dev->common->queue_avail);
+	iowrite64(0, &vp_dev->common->queue_used);
 
 	free_pages_exact(info->queue, size);
 	kfree(info);
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 0d12828..b334cd9 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -128,7 +128,6 @@ struct virtio_pci_cap {
 	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
 	u8 cap_next;	/* Generic PCI field: next ptr. */
 	u8 cfg_type;	/* One of the VIRTIO_PCI_CAP_*_CFG. */
-/* FIXME: Should we use a bir, instead of raw bar number? */
 	u8 bar;		/* Where to find it. */
 	__le32 offset;	/* Offset within bar. */
 	__le32 length;	/* Length. */
@@ -142,14 +141,18 @@ struct virtio_pci_common_cfg {
 	__le32 guest_feature_select;	/* read-write */
 	__le32 guest_feature;		/* read-only */
 	__le16 msix_config;		/* read-write */
+	__le16 num_queues;		/* read-only */
 	__u8 device_status;		/* read-write */
-	__u8 unused;
+	__u8 unused1;
+	__le16 unused2;
 
 	/* About a specific virtqueue. */
 	__le16 queue_select;	/* read-write */
-	__le16 queue_align;	/* read-write, power of 2. */
 	__le16 queue_size;	/* read-write, power of 2. */
 	__le16 queue_msix_vector;/* read-write */
-	__le64 queue_address;	/* read-write: 0xFFFFFFFFFFFFFFFF == DNE. */
+	__le16 queue_enable;	/* read-write */
+	__le64 queue_desc;	/* read-write */
+	__le64 queue_avail;	/* read-write */
+	__le64 queue_used;	/* read-write */
 };
 #endif /* _UAPI_LINUX_VIRTIO_PCI_H */
-- 
1.7.10.4
