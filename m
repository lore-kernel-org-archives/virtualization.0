From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] virtio_pci updates
Date: Sat, 10 Nov 2007 16:12:12 -0600
Message-ID: <11947327333462-git-send-email-aliguori@us.ibm.com>
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

This patch brings the virtio_pci driver up-to-date with what I have locally.
It fixes a bug with destroying a virtqueue, switches to kmalloc so we can
support rings > PAGE_SIZE, and fixes a bug with odd sized configuration
entries.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 85ae096..eb9a8e0 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -1,3 +1,19 @@
+/*
+ * Virtio PCI driver
+ *
+ * This module allows virtio devices to be used over a virtual PCI device.
+ * This can be used with QEMU based VMMs like KVM or Xen.
+ *
+ * Copyright IBM Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori  <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/pci.h>
@@ -17,32 +33,32 @@ MODULE_VERSION("1");
 /* Our device structure */
 struct virtio_pci_device
 {
-	/* the virtio device */
 	struct virtio_device vdev;
-	/* the PCI device */
 	struct pci_dev *pci_dev;
+
 	/* the IO mapping for the PCI config space */
 	void *ioaddr;
 
+	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
 };
 
 struct virtio_pci_vq_info
 {
+	/* the actual virtqueue */
+	struct virtqueue *vq;
+
 	/* the number of entries in the queue */
 	int num;
-	/* the number of pages the device needs for the ring queue */
-	int n_pages;
+
 	/* the index of the queue */
 	int queue_index;
-	/* the struct page of the ring queue */
-	struct page *pages;
+
 	/* the virtual address of the ring queue */
 	void *queue;
-	/* a pointer to the virtqueue */
-	struct virtqueue *vq;
-	/* the node pointer */
+
+	/* the list node for the virtqueues list */
 	struct list_head node;
 };
 
@@ -127,12 +143,15 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		break;
 	}
 
-	/* for strange accesses of an odd size, we do not perform any
-	 * endianness conversion. */
-	default:
-		ioread8_rep(ioaddr, buf, len);
+	default: {
+		uint8_t *ptr = buf;
+		int i;
+
+		for (i = 0; i < len; i++)
+			ptr[i] = ioread8(ioaddr + i);
 		break;
 	}
+	}
 }
 
 /* the config->set() implementation.  it's symmetric to the config->get()
@@ -169,10 +188,15 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		iowrite32(val, ioaddr + 4);
 		break;
 	}
-	default:
-		iowrite8_rep(ioaddr, buf, len);
+	default: {
+		const uint8_t *ptr = buf;
+		int i;
+
+		for (i = 0; i < len; i++)
+			iowrite8(ptr[i], ioaddr + i);
 		break;
 	}
+	}
 }
 
 /* config->{get,set}_status() implementations */
@@ -237,8 +261,8 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
-	int err;
 	u16 num;
+	int err;
 
 	/* Select the queue we're interested in */
 	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
@@ -257,25 +281,14 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 	info->queue_index = index;
 	info->num = num;
 
-	/* determine the memory needed for the queue and provide the memory
-	 * location to the host */
-	info->n_pages = DIV_ROUND_UP(vring_size(num), PAGE_SIZE);
-	info->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				  get_order(info->n_pages));
-	if (info->pages == NULL) {
-		err = -ENOMEM;
-		goto out_info;
-	}
-
-	/* FIXME: is this sufficient for info->n_pages > 1? */
-	info->queue = kmap(info->pages);
+	info->queue = kmalloc(vring_size(num), GFP_KERNEL | __GFP_ZERO);
 	if (info->queue == NULL) {
 		err = -ENOMEM;
-		goto out_alloc_pages;
+		goto out_info;
 	}
 
 	/* activate the queue */
-	iowrite32(page_to_pfn(info->pages),
+	iowrite32(virt_to_phys(info->queue) >> PAGE_SHIFT,
 		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 		  
 	/* create the vring */
@@ -297,9 +310,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 
 out_activate_queue:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
-	kunmap(info->queue);
-out_alloc_pages:
-	__free_pages(info->pages, get_order(info->n_pages));
+	kfree(info->queue);
 out_info:
 	kfree(info);
 	return ERR_PTR(err);
@@ -319,10 +330,9 @@ static void vp_del_vq(struct virtqueue *vq)
 
 	/* Select and deactivate the queue */
 	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
-	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
+	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
-	kunmap(info->queue);
-	__free_pages(info->pages, get_order(info->n_pages));
+	kfree(info->queue);
 	kfree(info);
 }
 
@@ -348,10 +358,13 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 	if (vp_dev == NULL)
 		return -ENOMEM;
 
-	vp_dev->pci_dev = pci_dev;
+	snprintf(vp_dev->vdev.dev.bus_id, BUS_ID_SIZE, "virtio%d", dev_index);
+	vp_dev->vdev.index = dev_index;
+	dev_index++;
+
 	vp_dev->vdev.dev.parent = &virtio_pci_root;
-	vp_dev->vdev.index = dev_index++;
 	vp_dev->vdev.config = &virtio_pci_config_ops;
+	vp_dev->pci_dev = pci_dev;
 	INIT_LIST_HEAD(&vp_dev->virtqueues);
 	spin_lock_init(&vp_dev->lock);
 
@@ -379,7 +392,7 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 
 	/* register a handler for the queue with the PCI device's interrupt */
 	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
-			  pci_name(vp_dev->pci_dev), vp_dev);
+			  vp_dev->vdev.dev.bus_id, vp_dev);
 	if (err)
 		goto out_set_drvdata;
 
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index b1a1568..4b28409 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -1,3 +1,19 @@
+/*
+ * Virtio PCI driver
+ *
+ * This module allows virtio devices to be used over a virtual PCI device.
+ * This can be used with QEMU based VMMs like KVM or Xen.
+ *
+ * Copyright IBM Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori  <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
 #ifndef _LINUX_VIRTIO_PCI_H
 #define _LINUX_VIRTIO_PCI_H
