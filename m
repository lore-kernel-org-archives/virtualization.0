From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Change virtio_pci to use a shared memory area for config
Date: Sat, 10 Nov 2007 17:39:25 -0600
Message-ID: <11947379652062-git-send-email-aliguori@us.ibm.com>
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

This patch changes virtio_pci to use a shared memory area for virtio config
info instead of using the PCI configuration space.  This is closer semantically
to what the virtio API exposes and is it a lot easier to implement on both
ends.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index eb9a8e0..7e6e453 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -39,6 +39,12 @@ struct virtio_pci_device
 	/* the IO mapping for the PCI config space */
 	void *ioaddr;
 
+	/* the shared device configuration */
+	void *config;
+
+	/* the size of the shared device configuration */
+	u32 config_len;
+
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
@@ -111,47 +117,12 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void *ioaddr = vp_dev->ioaddr + VIRTIO_PCI_CONFIG + offset;
-
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
 
-	default: {
-		uint8_t *ptr = buf;
-		int i;
+	BUG_ON(vp_dev->config == NULL);
 
-		for (i = 0; i < len; i++)
-			ptr[i] = ioread8(ioaddr + i);
-		break;
-	}
-	}
+	BUG_ON(vp_dev->config_len < (offset + len));
+
+	memcpy(buf, vp_dev->config + offset, len);
 }
 
 /* the config->set() implementation.  it's symmetric to the config->get()
@@ -160,43 +131,10 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void *ioaddr = vp_dev->ioaddr + VIRTIO_PCI_CONFIG + offset;
-
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
 
-		for (i = 0; i < len; i++)
-			iowrite8(ptr[i], ioaddr + i);
-		break;
-	}
-	}
+	BUG_ON(vp_dev->config_len < (offset + len));
+
+	memcpy(vp_dev->config + offset, buf, len);
 }
 
 /* config->{get,set}_status() implementations */
@@ -281,7 +219,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	info->queue_index = index;
 	info->num = num;
 
-	info->queue = kmalloc(vring_size(num), GFP_KERNEL | __GFP_ZERO);
+	info->queue = kzalloc(PAGE_ALIGN(vring_size(num)), GFP_KERNEL);
 	if (info->queue == NULL) {
 		err = -ENOMEM;
 		goto out_info;
@@ -390,11 +328,25 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 	vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
 	vp_dev->vdev.id.device = pci_dev->subsystem_device;
 
+	vp_dev->config_len = ioread32(vp_dev->ioaddr + VIRTIO_PCI_CONFIG_LEN);
+	if (vp_dev->config_len) {
+		/* round up to nearest page size to ensure proper alignment */
+		vp_dev->config = kzalloc(PAGE_ALIGN(vp_dev->config_len),
+					 GFP_KERNEL);
+		if (vp_dev->config == NULL)
+			goto out_set_drvdata;
+
+		/* tell the host about our config space */
+		iowrite32(virt_to_phys(vp_dev->config) >> PAGE_SHIFT,
+			  vp_dev->ioaddr + VIRTIO_PCI_CONFIG_PFN);
+	} else
+		vp_dev->config = NULL;
+
 	/* register a handler for the queue with the PCI device's interrupt */
 	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
 			  vp_dev->vdev.dev.bus_id, vp_dev);
 	if (err)
-		goto out_set_drvdata;
+		goto out_alloc_config;
 
 	/* finally register the virtio device */
 	err = register_virtio_device(&vp_dev->vdev);
@@ -405,6 +357,8 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 
 out_req_irq:
 	free_irq(pci_dev->irq, vp_dev);
+out_alloc_config:
+	kfree(vp_dev->config);
 out_set_drvdata:
 	pci_set_drvdata(pci_dev, NULL);
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
@@ -422,6 +376,7 @@ static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 
 	free_irq(pci_dev->irq, vp_dev);
+	kfree(vp_dev->config);
 	pci_set_drvdata(pci_dev, NULL);
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
 	pci_release_regions(pci_dev);
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index 4b28409..79e6641 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -45,8 +45,12 @@
  * a read-and-acknowledge. */
 #define VIRTIO_PCI_ISR			19
 
-/* The remaining space is defined by each driver as the per-driver
- * configuration space */
-#define VIRTIO_PCI_CONFIG		20
+/* A 32-bit r/o configuration size.  This is the amount of memory required
+ * to be allocated for VIRTIO_PCI_CONFIG_PFN. */
+#define VIRTIO_PCI_CONFIG_LEN		20
+
+/* A 32-bit r/w PFN for the shared configuration information.  The PA written
+ * by the host must point to at least VIRTIO_PCI_CONFIG_LEN bytes */
+#define VIRTIO_PCI_CONFIG_PFN		24
 
 #endif
