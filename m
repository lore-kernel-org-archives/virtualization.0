From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Change virtio_pci to use a shared memory area for config
Date: Mon, 12 Nov 2007 21:30:26 -0600
Message-ID: <11949246261412-git-send-email-aliguori@us.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch changes virtio_pci to treat the PCI config space as opaque memory.
This is closer semantically to what the virtio API exposes and is it a lot
easier to implement on the guest side.  It also doesn't preclude a more
PCI-like treatment of the ABI.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index eb9a8e0..36e86eb 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -112,46 +112,11 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void *ioaddr = vp_dev->ioaddr + VIRTIO_PCI_CONFIG + offset;
+	u8 *ptr = buf;
+	int i;
 
-	/* We translate appropriately sized get requests into more natural
-	 * IO operations.  These functions also take care of endianness
-	 * conversion. */
-	switch (len) {
-	case 1: {
-		u8 val;
-		val = ioread8(ioaddr);
-		memcpy(buf, &val, sizeof(val));
-		break;
-	}
-	case 2: {
-		u16 val;
-		val = ioread16(ioaddr);
-		memcpy(buf, &val, sizeof(val));
-		break;
-	}
-	case 4: {
-		u32 val;
-		val = ioread32(ioaddr);
-		memcpy(buf, &val, sizeof(val));
-		break;
-	}
-	case 8: {
-		u64 val;
-		val = (u64)ioread32(ioaddr) << 32;
-		val |= ioread32(ioaddr + 4);
-		memcpy(buf, &val, sizeof(val));
-		break;
-	}
-
-	default: {
-		uint8_t *ptr = buf;
-		int i;
-
-		for (i = 0; i < len; i++)
-			ptr[i] = ioread8(ioaddr + i);
-		break;
-	}
-	}
+	for (i = 0; i < len; i++)
+		ptr[i] = ioread8(ioaddr + i);
 }
 
 /* the config->set() implementation.  it's symmetric to the config->get()
@@ -161,42 +126,11 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void *ioaddr = vp_dev->ioaddr + VIRTIO_PCI_CONFIG + offset;
+	const u8 *ptr = buf;
+	int i;
 
-	switch (len) {
-	case 1: {
-		u8 val;
-		memcpy(&val, buf, sizeof(val));
-		iowrite8(val, ioaddr);
-		break;
-	}
-	case 2: {
-		u16 val;
-		memcpy(&val, buf, sizeof(val));
-		iowrite16(val, ioaddr);
-		break;
-	}
-	case 4: {
-		u32 val;
-		memcpy(&val, buf, sizeof(val));
-		iowrite32(val, ioaddr);
-		break;
-	}
-	case 8: {
-		u64 val;
-		memcpy(&val, buf, sizeof(val));
-		iowrite32(val >> 32, ioaddr);
-		iowrite32(val, ioaddr + 4);
-		break;
-	}
-	default: {
-		const uint8_t *ptr = buf;
-		int i;
-
-		for (i = 0; i < len; i++)
-			iowrite8(ptr[i], ioaddr + i);
-		break;
-	}
-	}
+	for (i = 0; i < len; i++)
+		iowrite8(ptr[i], ioaddr + i);
 }
 
 /* config->{get,set}_status() implementations */
@@ -281,7 +215,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	info->queue_index = index;
 	info->num = num;
 
-	info->queue = kmalloc(vring_size(num), GFP_KERNEL | __GFP_ZERO);
+	info->queue = kzalloc(PAGE_ALIGN(vring_size(num)), GFP_KERNEL);
 	if (info->queue == NULL) {
 		err = -ENOMEM;
 		goto out_info;
