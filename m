From: Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] kvm guest balloon driver
Date: Tue, 8 Jan 2008 13:33:56 -0200
Message-ID: <20080108153356.GA21726__41528.8598429926$1199824345$gmane$org@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org


Following patch introduces a KVM guest balloon driver. Communication
to/from the host is performed via virtio.

Next patch implements the QEMU driver and handling.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-nv/drivers/virtio/Kconfig
===================================================================
--- linux-2.6-nv.orig/drivers/virtio/Kconfig
+++ linux-2.6-nv/drivers/virtio/Kconfig
@@ -23,3 +23,12 @@ config VIRTIO_PCI
 
 	  If unsure, say M.
 
+config KVM_BALLOON
+	tristate "KVM balloon driver (EXPERIMENTAL)"
+	depends on VIRTIO_PCI
+	---help---
+	 This driver provides support for ballooning memory in/out of a
+	 KVM paravirt guest.	
+
+	 If unsure, say M.
+
Index: linux-2.6-nv/drivers/virtio/Makefile
===================================================================
--- linux-2.6-nv.orig/drivers/virtio/Makefile
+++ linux-2.6-nv/drivers/virtio/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
+obj-$(CONFIG_KVM_BALLOON) += kvm_balloon.o
Index: linux-2.6-nv/drivers/virtio/kvm_balloon.c
===================================================================
--- /dev/null
+++ linux-2.6-nv/drivers/virtio/kvm_balloon.c
@@ -0,0 +1,577 @@
+/*
+ * KVM guest balloon driver
+ *
+ * Copyright (C) 2007, Qumranet, Inc., Dor Laor <dor.laor@qumranet.com>
+ * Copyright (C) 2007, Red Hat, Inc., Marcelo Tosatti <mtosatti@redhat.com>
+ * 
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include <asm/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/wait.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+#include <linux/version.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_pci.h>
+#include <linux/preempt.h>
+#include <linux/kvm_types.h>
+#include <linux/kvm_host.h>
+
+MODULE_AUTHOR ("Dor Laor");
+MODULE_DESCRIPTION ("Implements guest ballooning support");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1");
+
+#define CMD_BALLOON_INFLATE 0x1
+#define CMD_BALLOON_DEFLATE 0x2
+
+static int kvm_balloon_debug;
+
+#define DEBUG
+#ifdef DEBUG
+#define dprintk(str...) if (kvm_balloon_debug) printk(str)
+#else
+#define dprintk(str...)
+#endif
+
+static LIST_HEAD(balloon_plist);
+static LIST_HEAD(balloon_work);
+static int balloon_size = 0;
+static DEFINE_SPINLOCK(balloon_plist_lock);
+static DEFINE_SPINLOCK(balloon_queue_lock);
+
+struct virtio_balloon_hdr {
+	uint8_t cmd;
+	uint8_t status;
+};
+
+#define BALLOON_DATA_SIZE 200
+
+struct balloon_buf {
+	struct virtio_balloon_hdr hdr;
+	u8 data[BALLOON_DATA_SIZE];
+};
+
+struct balloon_work {
+	struct balloon_buf *buf;
+	struct list_head list;
+};
+
+#define VIRTIO_MAX_SG 2
+
+struct virtballoon {
+	struct virtio_device *dev;
+	struct virtqueue *vq;
+	struct task_struct *balloon_thread;
+	wait_queue_head_t balloon_wait;
+	wait_queue_head_t rmmod_wait;
+	uint32_t target_nrpages;
+	atomic_t inflight_bufs;
+};
+
+struct balloon_page {
+	struct page *bpage;
+	struct list_head bp_list;
+};
+
+struct virtballoon virtballoon;
+
+struct balloon_buf *alloc_balloon_buf(void)
+{
+	struct balloon_buf *buf;
+
+	buf = kzalloc(sizeof(struct balloon_buf), GFP_KERNEL);
+	if (!buf)
+		printk(KERN_ERR "%s: allocation failed\n", __func__);
+
+	return buf;
+}
+
+static int send_balloon_buf(uint8_t cmd, struct balloon_buf *buf)
+{
+	struct scatterlist sg[VIRTIO_MAX_SG];
+	struct virtqueue *vq = virtballoon.vq;
+	int err = 0;
+
+	buf->hdr.cmd = cmd;
+
+	sg_init_table(sg, VIRTIO_MAX_SG);
+	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
+	sg_set_buf(&sg[1], &buf->data, sizeof(buf->data));
+
+	spin_lock_irq(&balloon_queue_lock);
+	err = vq->vq_ops->add_buf(vq, sg, 0, 2, buf);
+	if (err) {
+		printk("%s: add_buf err\n", __func__);
+		goto out;
+	}
+	atomic_inc(&virtballoon.inflight_bufs);
+
+	/* TODO: kick several balloon buffers at once */
+	vq->vq_ops->kick(vq);
+out:
+	spin_unlock_irq(&balloon_queue_lock);
+	return err;
+}
+
+static int kvm_balloon_inflate(int32_t npages)
+{
+	LIST_HEAD(tmp_list);
+	struct balloon_page *node, *tmp;
+	struct balloon_buf *buf;
+	u32 *pfn;
+	int allocated = 0;
+	int i, r = -ENOMEM;
+
+	buf = alloc_balloon_buf();
+	if (!buf)
+		return r;
+
+	pfn = (u32 *)&buf->data;
+	*pfn++ = (u32)npages;
+
+	for (i = 0; i < npages; i++) {
+		node = kzalloc(sizeof(struct balloon_page), GFP_KERNEL);
+		if (!node)
+			goto out_free;
+
+		node->bpage = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
+		if (!node->bpage) {
+			kfree(node);
+			goto out_free;
+		}
+
+		list_add(&node->bp_list, &tmp_list);
+		allocated++;
+		*pfn = page_to_pfn(node->bpage);
+		pfn++;
+	}
+
+	r = send_balloon_buf(CMD_BALLOON_INFLATE, buf);
+	if (r)
+		goto out_free;
+
+	spin_lock(&balloon_plist_lock);
+	list_splice(&tmp_list, &balloon_plist);
+	balloon_size += allocated;
+	totalram_pages -= allocated;
+	dprintk("%s: current balloon size=%d\n", __FUNCTION__,
+	       balloon_size);
+	spin_unlock(&balloon_plist_lock);
+	return allocated;
+
+out_free:
+	list_for_each_entry_safe(node, tmp, &tmp_list, bp_list) {
+		__free_page(node->bpage);
+		list_del(&node->bp_list);
+		kfree(node);
+	}
+	return r;
+}
+
+static int kvm_balloon_deflate(int32_t npages)
+{
+	LIST_HEAD(tmp_list);
+	struct balloon_page *node, *tmp;
+	struct balloon_buf *buf;
+	u32 *pfn;
+	int deallocated = 0;
+	int r = 0;
+
+	buf = alloc_balloon_buf();
+	if (!buf)
+		return r;
+
+	spin_lock(&balloon_plist_lock);
+
+	if (balloon_size < npages) {
+		printk("%s: balloon=%d while deflate rq=%d\n",
+		       __FUNCTION__, balloon_size, npages);
+		npages = balloon_size;
+		if (!npages)
+			goto out;
+	}
+
+	pfn = (u32 *)&buf->data;
+	*pfn++ = (u32)-npages;
+
+	/*
+	 * Move the balloon pages to tmp list before issuing 
+	 * the virtio buffer
+	 */
+	list_for_each_entry_safe(node, tmp, &balloon_plist, bp_list) {
+		*pfn++ = page_to_pfn(node->bpage);
+		list_move(&node->bp_list, &tmp_list);
+		if (++deallocated == npages)
+			break;
+	}
+
+	r = send_balloon_buf(CMD_BALLOON_DEFLATE, buf);
+	if (r)
+		goto out;
+
+	list_for_each_entry_safe(node, tmp, &tmp_list, bp_list) {
+		list_del(&node->bp_list);
+		kfree(node);
+	}
+	balloon_size -= npages;
+	totalram_pages += npages;
+	dprintk("%s: current balloon size=%d\n", __FUNCTION__,
+	       balloon_size);
+
+	spin_unlock(&balloon_plist_lock);
+	return deallocated;
+
+out:
+	list_splice(&tmp_list, &balloon_plist);
+	spin_unlock(&balloon_plist_lock);
+	return r;
+}
+
+#define MAX_BALLOON_PAGES_PER_OP (BALLOON_DATA_SIZE/sizeof(u32)) \
+				 - sizeof(int32_t)
+#define MAX_BALLOON_XFLATE_OP 1000000
+
+static int kvm_balloon_xflate(int32_t npages)
+{
+	int r = -EINVAL, i;
+	int iterations;
+	int abspages;
+	int curr_pages = 0;
+	int gfns_per_buf;
+
+	abspages = abs(npages);
+
+	if (abspages > MAX_BALLOON_XFLATE_OP) {
+		printk("%s: bad npages=%d\n", __func__,
+			npages);
+		return -EINVAL;
+	}
+
+	dprintk("%s: got %s, npages=%d\n", __FUNCTION__,
+	       (npages > 0)? "inflate":"deflate", npages);
+
+	gfns_per_buf = MAX_BALLOON_PAGES_PER_OP;
+
+	/*
+	 * Call the balloon in PAGE_SIZE*pfns-per-buf
+	 * iterations
+	 */
+	iterations = DIV_ROUND_UP(abspages, gfns_per_buf);
+	dprintk("%s: iterations=%d\n", __FUNCTION__, iterations);
+
+	for (i = 0; i < iterations; i++) {
+		int32_t pages_in_iteration = 
+			min(abspages - curr_pages, gfns_per_buf);
+
+		if (npages > 0)
+			r = kvm_balloon_inflate(pages_in_iteration);
+		else
+			r = kvm_balloon_deflate(pages_in_iteration);
+						
+		if (r < 0)
+			return r;
+		curr_pages += r;
+		if (r != pages_in_iteration)
+			break;
+		cond_resched();
+	}
+
+	return curr_pages;
+}
+
+static void inflate_done(struct balloon_buf *buf)
+{
+	uint8_t status = buf->hdr.status;
+
+	/* error inflating, return pages to the system */
+	if (status) {
+	 	struct balloon_page *node, *tmp;
+
+		spin_lock(&balloon_plist_lock);
+		list_for_each_entry_safe(node, tmp, &balloon_plist, bp_list) {
+			u32 *pfn = (u32 *)&buf->data;
+			int npages = (int)*pfn++;
+			int i;
+
+			for (i=0;i<npages;i++) { 	
+				if (page_to_pfn(node->bpage) == *pfn) {
+					list_del(&node->bp_list);
+					kfree(node);
+					__free_page(pfn_to_page(*pfn));
+					balloon_size--;
+					totalram_pages++;
+					virtballoon.target_nrpages++;
+					break;
+	 			}
+				pfn++;
+			}
+		}
+		spin_unlock(&balloon_plist_lock);
+		virtballoon.dev->config->set(virtballoon.dev, 0, 
+					   &virtballoon.target_nrpages,
+					   sizeof(virtballoon.target_nrpages));
+	}
+}
+
+static void deflate_done(struct balloon_buf *buf)
+{
+	uint8_t status = buf->hdr.status;
+
+	/* deflate OK, return pages to the system */
+	if (!status) { 
+		u32 *pfn = (u32 *)&buf->data;
+		int npages, i;
+
+		npages = (int)*pfn++;
+		npages = abs(npages);
+
+		for (i = 0; i<npages; i++) {
+			__free_page(pfn_to_page(*pfn));
+			pfn++;
+		}
+	/* deflate error, add pages back to ballooned list */
+	} else {
+		u32 *pfn = (u32 *)&buf->data;
+		int npages, i;
+		struct balloon_page *node;
+
+		npages = (int)*pfn++;
+		npages = abs(npages);
+
+		spin_lock(&balloon_plist_lock);
+		for (i = 0; i < npages; i++) {
+			node = kzalloc(sizeof(struct balloon_page), GFP_KERNEL);
+			if (!node) {
+				spin_unlock(&balloon_plist_lock);
+				printk(KERN_ERR "%s: allocation failure\n",
+					__func__);
+				goto out;
+			}
+
+			node->bpage = pfn_to_page(*pfn++);
+			list_add(&node->bp_list, &balloon_plist);
+			balloon_size++;
+			totalram_pages--;
+			virtballoon.target_nrpages--;
+		}
+		spin_unlock(&balloon_plist_lock);
+		virtballoon.dev->config->set(virtballoon.dev, 0, 
+					   &virtballoon.target_nrpages,
+					   sizeof(virtballoon.target_nrpages));
+	}
+out:
+	return;
+}
+
+static int balloon_thread(void *p)
+{
+	struct virtballoon *v = p;
+	DEFINE_WAIT(wait);
+
+	set_freezable();
+	for (;;) {
+		prepare_to_wait(&v->balloon_wait, &wait, TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&v->balloon_wait, &wait);
+
+		try_to_freeze();
+
+		if (kthread_should_stop())
+			break;
+
+		if (v->target_nrpages != totalram_pages) {
+			int delta = totalram_pages - v->target_nrpages;
+			kvm_balloon_xflate(delta);
+		}
+
+		spin_lock_irq(&balloon_queue_lock);
+		while (!list_empty(&balloon_work)) {
+			struct balloon_work *work;
+			struct balloon_buf *buf;
+
+			work = list_entry(balloon_work.next,
+					 struct balloon_work, list);
+			list_del(&work->list);
+			spin_unlock_irq(&balloon_queue_lock);
+			buf = work->buf;
+			kfree(work);
+
+			switch(buf->hdr.cmd) {
+			case CMD_BALLOON_DEFLATE:
+				deflate_done(buf);
+				break;
+			case CMD_BALLOON_INFLATE:
+				inflate_done(buf);
+				break;
+			default:
+				printk("%s: unknown cmd 0x%x\n", __func__,
+					buf->hdr.cmd);
+			}
+			kfree(buf);
+			if (atomic_dec_and_test(&v->inflight_bufs)) {
+				if (waitqueue_active(&v->rmmod_wait)) {
+					wake_up(&v->rmmod_wait);
+					return 0;
+				}
+			}
+			cond_resched();
+			spin_lock_irq(&balloon_queue_lock);
+		}
+		spin_unlock_irq(&balloon_queue_lock);
+	}
+	return 0;
+}
+
+static bool balloon_tx_done(struct virtqueue *vq)
+{
+	struct balloon_buf *buf;
+	unsigned int len;
+
+	spin_lock(&balloon_queue_lock);
+	while ((buf = vq->vq_ops->get_buf(vq, &len)) != NULL) {
+		struct balloon_work *work;
+
+		work = kzalloc(sizeof(struct balloon_work), GFP_ATOMIC);
+		if (!work)
+			continue;
+		INIT_LIST_HEAD(&work->list);
+		work->buf = buf;
+
+		list_add(&work->list, &balloon_work);
+	}
+	spin_unlock(&balloon_queue_lock);
+	wake_up(&virtballoon.balloon_wait);
+
+	return true;
+}
+
+static irqreturn_t balloon_irq(int irq, void *opaque)
+{
+	struct virtballoon *vb = opaque;
+	uint32_t target_nrpages;
+	
+	__virtio_config_val(vb->dev, 0, &target_nrpages);
+
+	dprintk("%s: target_nrpages = %d, vb->target_nrpages = %d\n",
+		__func__, target_nrpages, vb->target_nrpages);
+
+	if (target_nrpages != vb->target_nrpages) {
+		vb->target_nrpages = target_nrpages;
+		wake_up(&vb->balloon_wait);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+#define VIRTIO_ID_BALLOON 3
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID},
+	{ 0 },
+};
+
+static int balloon_probe(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *pvdev = to_vp_device(vdev);
+	int err = -EBUSY;
+
+	if (virtballoon.dev) { 
+		printk("kvm_ballon: error, already registered\n");
+		return -EBUSY;
+	}
+
+	virtballoon.vq = vdev->config->find_vq(vdev, 0, balloon_tx_done);
+	if (IS_ERR(virtballoon.vq)) {
+		printk("%s: error finding vq\n", __func__);
+		return -EINVAL;
+	}
+
+	virtballoon.dev = vdev;
+	init_waitqueue_head(&virtballoon.balloon_wait);
+	init_waitqueue_head(&virtballoon.rmmod_wait);
+	atomic_set(&virtballoon.inflight_bufs, 0);
+
+	err = request_irq(pvdev->pci_dev->irq, balloon_irq, IRQF_SHARED,
+			  pvdev->vdev.dev.bus_id, &virtballoon);
+	if (err)
+		goto out_free_vq;
+
+	virtballoon.balloon_thread = kthread_run(balloon_thread,
+						 &virtballoon,
+						 "kvm_balloond");
+	printk("kvm_balloon: registered\n");
+
+	return 0;
+
+out_free_vq:
+	vdev->config->del_vq(virtballoon.vq);
+	virtballoon.dev = NULL;
+	return err;
+}
+
+static void balloon_remove(struct virtio_device *vdev)
+{
+	kthread_stop(virtballoon.balloon_thread);
+	vdev->config->del_vq(virtballoon.vq);
+}
+
+static struct virtio_driver virtio_balloon = {
+	.driver.name =  KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table =     id_table,
+	.probe =        balloon_probe,
+	.remove =	__devexit_p(balloon_remove),
+};
+
+module_param(kvm_balloon_debug, int, 0);
+
+static int __init kvm_balloon_init(void)
+{
+	virtballoon.dev = NULL;
+
+	return register_virtio_driver(&virtio_balloon);
+}
+
+static void __exit kvm_balloon_exit(void)
+{
+	spin_lock(&balloon_plist_lock);
+	if (balloon_size) {
+		DEFINE_WAIT(wait);
+
+		virtballoon.target_nrpages += balloon_size;
+		spin_unlock(&balloon_plist_lock);
+		virtballoon.dev->config->set(virtballoon.dev, 0, 
+					   &virtballoon.target_nrpages,
+					   sizeof(virtballoon.target_nrpages));
+		wake_up(&virtballoon.balloon_wait);
+		prepare_to_wait(&virtballoon.rmmod_wait, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&virtballoon.rmmod_wait, &wait);
+		spin_lock(&balloon_plist_lock);
+	}
+
+	if (balloon_size)
+		printk(KERN_ERR "%s: exit while balloon not empty!\n",
+			__FUNCTION__);
+
+	spin_unlock(&balloon_plist_lock);
+
+	unregister_virtio_driver(&virtio_balloon);
+}
+
+module_init(kvm_balloon_init);
+module_exit(kvm_balloon_exit);
Index: linux-2.6-nv/drivers/virtio/virtio_pci.c
===================================================================
--- linux-2.6-nv.orig/drivers/virtio/virtio_pci.c
+++ linux-2.6-nv/drivers/virtio/virtio_pci.c
@@ -30,20 +30,6 @@ MODULE_DESCRIPTION("virtio-pci");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1");
 
-/* Our device structure */
-struct virtio_pci_device
-{
-	struct virtio_device vdev;
-	struct pci_dev *pci_dev;
-
-	/* the IO mapping for the PCI config space */
-	void *ioaddr;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-};
-
 struct virtio_pci_vq_info
 {
 	/* the actual virtqueue */
@@ -67,6 +53,7 @@ static struct pci_device_id virtio_pci_i
 	{ 0x1AF4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
 	{ 0x1AF4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
 	{ 0x1AF4, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
+	{ 0x1AF4, 0x1003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Balloon */
 	{ 0 },
 };
 
@@ -89,12 +76,6 @@ static struct device virtio_pci_root = {
 /* Unique numbering for devices under the kvm root */
 static unsigned int dev_index;
 
-/* Convert a generic virtio device to our structure */
-static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
-{
-	return container_of(vdev, struct virtio_pci_device, vdev);
-}
-
 /* virtio config->feature() implementation */
 static bool vp_feature(struct virtio_device *vdev, unsigned bit)
 {
Index: linux-2.6-nv/include/linux/virtio_pci.h
===================================================================
--- linux-2.6-nv.orig/include/linux/virtio_pci.h
+++ linux-2.6-nv/include/linux/virtio_pci.h
@@ -19,6 +19,26 @@
 
 #include <linux/virtio_config.h>
 
+/* Our device structure */
+struct virtio_pci_device
+{
+	struct virtio_device vdev;
+	struct pci_dev *pci_dev;
+
+	/* the IO mapping for the PCI config space */
+	void *ioaddr;
+
+	/* a list of queues so we can dispatch IRQs */
+	spinlock_t lock;
+	struct list_head virtqueues;
+};
+
+/* Convert a generic virtio device to our structure */
+struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
+{
+	return container_of(vdev, struct virtio_pci_device, vdev);
+}
+
 /* A 32-bit r/o bitmask of the features supported by the host */
 #define VIRTIO_PCI_HOST_FEATURES	0
