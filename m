From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [PATCH] KVM virtio balloon driver
Date: Tue, 15 Jan 2008 17:01:02 -0200
Message-ID: <20080115190102.GA27645@dmt>
References: <20080114200357.GA18354@dmt>
	<200801151032.09495.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801151032.09495.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 15, 2008 at 10:32:08AM +1100, Rusty Russell wrote:
> On Tuesday 15 January 2008 07:03:57 Marcelo Tosatti wrote:
> > Hi Rusty,
> >
> > It was agreed that the balloon driver should be merged through the
> > virtio tree, so here it goes. It depends on the config_changed patch
> > posted earlier.
> 
> Hi Marcelo,
> 
>     Excellent!  Although the main user will be kvm, it'd be nice to have a 
> demonstration in-tree using lguest; any chance of you conjuring up an 
> appropriate patch?
> 
> If not, I can whip something up.
> 
> > +config KVM_BALLOON
> > +	tristate "KVM balloon driver (EXPERIMENTAL)"
> > +	depends on VIRTIO_PCI
> > +	---help---
> > +	 This driver provides support for ballooning memory in/out of a
> > +	 KVM paravirt guest.
> > +
> > +	 If unsure, say M.
> 
> Please don't define "balloon" in terms of "ballooning".  How about "This 
> driver supports increasing and decreasing the amount of memory within a KVM 
> guest." ?
> 
> > +	uint32_t target_nrpages;
> 
> I prefer u32 within the kernel, but no big deal.
> 
> > +static int send_balloon_buf(struct virtballoon *v, uint8_t cmd,
> > +			    struct balloon_buf *buf)
> > +{
> > +	struct scatterlist sg[VIRTIO_MAX_SG];
> > +	int err = 0;
> > +
> > +	buf->hdr.cmd = cmd;
> > +
> > +	sg_init_table(sg, VIRTIO_MAX_SG);
> > +	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
> > +	sg_set_buf(&sg[1], &buf->data, sizeof(buf->data));
> 
> Since these are adjacent, can't you just combine them into one sg element?  Or 
> does the kvm code rely on the sg as a boundary between header and data?
> 
> > +static int kvm_balloon_inflate(struct virtballoon *v, int32_t npages)
> > +{
> > +	LIST_HEAD(tmp_list);
> > +	struct page *page, *tmp;
> > +	struct balloon_buf *buf;
> > +	u32 *pfn;
> > +	int allocated = 0;
> > +	int i, r = -ENOMEM;
> > +
> > +	buf = alloc_balloon_buf(v->vdev, GFP_KERNEL);
> > +	if (!buf)
> > +		return r;
> > +
> > +	pfn = (u32 *)&buf->data;
> > +	*pfn++ = (u32)npages;
> 
> OK, this seems strange.  You always use the data portion as an array of u32s, 
> yet you declare it as char[200].  You have a perfectly good header, but you 
> put the number of pages in the first element of the data array: and you hand 
> the entire data array even though you normally only use part of it.
> 
> You can intuit the number from the sg len, I suggest you do that instead.
> 
> Looking at this driver, I just don't think this needs to be so complicated: 
> it's not a high speed device, after all.  Perhaps allocate one buffer up 
> front, and just reuse that.  One simple thread loop, less locking needed.
> 
> > +	for (i = 0; i < npages; i++) {
> > +		page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
> > +		if (!page)
> > +			goto out_free;
> > +		list_add(&page->lru, &tmp_list);
> > +		allocated++;
> > +		*pfn = page_to_pfn(page);
> > +		pfn++;
> > +	}
> 
> I think it might be simpler to defer adding to any list until after the 
> callback is done?  Helpers to add an array to the balloon array (on 
> successful inflate, or unsuccessful deflate) and to free them (unsuccessful 
> inflate, or successful deflate) would also make the code more readable.
> 
> > +	gfns_per_buf = MAX_BALLOON_PAGES_PER_OP;
> > +
> > +	/*
> > +	 * Call the balloon in PAGE_SIZE*pfns-per-buf
> > +	 * iterations
> > +	 */
> > +	iterations = DIV_ROUND_UP(abspages, gfns_per_buf);
> > +	dprintk(&v->vdev->dev, "%s: iterations=%d\n", __func__, iterations);
> > +
> > +	for (i = 0; i < iterations; i++) {
> 
> This logic seems overly complex.  How about in the main thread:
> 
> 	/* We're woken when target changes, in config_changed() */
> 	if (wait_event_interruptible(&v->wq,
> 		(diff = atomic_read(&v->target_pages) - total_pages)) == 0) {
> 
> 		/* If we submit inflate/deflate request, wait for it to finish. */
> 		if (xflate(v, diff) == 0)
> 			wait_for_completion(&v->complete);
> 	}
> 
> xflate just does as much as it can (up to "diff"), and then the interrupt 
> handler adds/removes from the linked list, frees pages, etc and fires the 
> completion.
> 
> No need for locking, since there's only one pending request at any time.

OK, thats simpler. How about this:

[PATCH] Virtio balloon driver

Add a balloon driver for KVM, host<->guest communication is performed
via virtio.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


Index: linux-2.6-nv/drivers/virtio/Kconfig
===================================================================
--- linux-2.6-nv.orig/drivers/virtio/Kconfig
+++ linux-2.6-nv/drivers/virtio/Kconfig
@@ -23,3 +23,13 @@ config VIRTIO_PCI
 
 	  If unsure, say M.
 
+config VIRTIO_BALLOON
+	tristate "Virtio balloon driver (EXPERIMENTAL)"
+	select VIRTIO
+	select VIRTIO_RING
+	---help---
+	 This driver supports increasing and decreasing the amount 
+	 of memory within a KVM guest.
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
+obj-$(CONFIG_VIRTIO_BALLOON) += kvm_balloon.o
Index: linux-2.6-nv/drivers/virtio/kvm_balloon.c
===================================================================
--- /dev/null
+++ linux-2.6-nv/drivers/virtio/kvm_balloon.c
@@ -0,0 +1,404 @@
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
+#define DEBUG
+#include <asm/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/wait.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+#include <linux/version.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_balloon.h>
+#include <linux/preempt.h>
+
+MODULE_AUTHOR ("Dor Laor");
+MODULE_DESCRIPTION ("Implements guest ballooning support");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1");
+
+static int kvm_balloon_debug;
+
+#define dprintk(dev, str...) if (kvm_balloon_debug) dev_dbg(dev, str)
+
+#define BALLOON_DATA_SIZE 200
+
+struct balloon_buf {
+	struct virtio_balloon_hdr hdr;
+	u8 data[BALLOON_DATA_SIZE];
+};
+
+#define VIRTIO_MAX_SG 2
+
+struct virtballoon {
+	struct virtio_device *vdev;
+	struct virtqueue *vq;
+	struct task_struct *balloon_thread;
+	struct balloon_buf buf;
+	wait_queue_head_t balloon_wait;
+	wait_queue_head_t rmmod_wait;
+	struct completion complete;
+	atomic_t target_nrpages;
+	int balloon_size;
+	struct list_head balloon_plist;
+	struct list_head list;
+};
+
+
+static int send_balloon_buf(struct virtballoon *v, u8 cmd,
+			    struct balloon_buf *buf, unsigned int data_len)
+{
+	struct scatterlist sg[VIRTIO_MAX_SG];
+	int err = 0;
+
+	buf->hdr.cmd = cmd;
+
+	sg_init_table(sg, VIRTIO_MAX_SG);
+	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
+	sg_set_buf(&sg[1], &buf->data, data_len);
+
+	err = v->vq->vq_ops->add_buf(v->vq, sg, 0, 2, buf);
+	if (err) {
+		dev_printk(KERN_ERR, &v->vq->vdev->dev, "%s: add_buf err\n",
+			   __func__);
+		goto out;
+	}
+
+	v->vq->vq_ops->kick(v->vq);
+out:
+	return err;
+}
+
+static int kvm_balloon_inflate(struct virtballoon *v, int32_t npages)
+{
+	struct page *page;
+	struct balloon_buf *buf = &v->buf;
+	u32 *pfn;
+	int allocated = 0;
+	int i, r = -ENOMEM;
+
+	pfn = (u32 *)&buf->data;
+	for (i = 0; i < npages; i++) {
+		page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
+		if (!page)
+			goto out_free;
+		allocated++;
+		*pfn = page_to_pfn(page);
+		pfn++;
+	}
+
+	r = send_balloon_buf(v, CMD_BALLOON_INFLATE, buf,
+			     allocated * sizeof(u32));
+	if (r)
+		goto out_free;
+
+	dprintk(&v->vdev->dev, "%s: current balloon size=%d\n", __func__,
+		v->balloon_size);
+	return r;
+
+out_free:
+	pfn = (u32 *)&buf->data;
+	for (i = 0; i < allocated; i++) 
+		__free_page(pfn_to_page(*pfn++));
+	return r;
+}
+
+static int kvm_balloon_deflate(struct virtballoon *v, int32_t npages)
+{
+	struct page *page;
+	struct balloon_buf *buf = &v->buf;
+	u32 *pfn;
+	int deallocated = 0;
+	int r = 0;
+
+	if (v->balloon_size < npages) {
+		dev_printk(KERN_INFO, &v->vdev->dev,
+			   "%s: balloon=%d with deflate rq=%d\n",
+			   __func__, v->balloon_size, npages);
+		npages = v->balloon_size;
+		if (!npages) {
+			r = -EINVAL;
+			goto out;
+		}
+	}
+
+	dprintk(&v->vdev->dev, "%s: current balloon size=%d\n", __func__,
+		v->balloon_size);
+
+	pfn = (u32 *)&buf->data;
+
+	list_for_each_entry(page, &v->balloon_plist, lru) {
+		*pfn++ = page_to_pfn(page);
+		if (++deallocated == npages)
+			break;
+	}
+
+	r = send_balloon_buf(v, CMD_BALLOON_DEFLATE, buf,
+			     deallocated * sizeof(u32));
+out:
+	return r;
+}
+
+#define MAX_BALLOON_PAGES_PER_OP (BALLOON_DATA_SIZE/sizeof(u32))
+#define MAX_BALLOON_XFLATE_OP 1000000
+
+static int kvm_balloon_xflate(struct virtballoon *v, int32_t npages)
+{
+	int r = -EINVAL;
+	int pages_in_iteration;
+	int abspages;
+	int maxpages = MAX_BALLOON_PAGES_PER_OP;
+
+	abspages = abs(npages);
+
+	if (abspages > MAX_BALLOON_XFLATE_OP) {
+		dev_printk(KERN_ERR, &v->vdev->dev,
+			   "%s: bad npages=%d\n", __func__, npages);
+		goto out;
+	}
+
+	dprintk(&v->vdev->dev, "%s: got %s, npages=%d\n", __func__,
+	       (npages > 0)? "inflate":"deflate", npages);
+
+	pages_in_iteration = min(maxpages, abspages);
+
+	if (npages > 0)
+		r = kvm_balloon_inflate(v, pages_in_iteration);
+	else
+		r = kvm_balloon_deflate(v, pages_in_iteration);
+
+out:
+	/* stop the thread in case of an error */
+	if (r)
+		atomic_set(&v->target_nrpages, totalram_pages);
+	return r;
+}
+
+static void free_page_array(struct balloon_buf *buf, unsigned int npages)
+{
+	struct page *page;
+	u32 *pfn = (u32 *)&buf->data;
+	int i;
+
+	for (i=0; i<npages; i++) { 
+		page = pfn_to_page(*pfn);
+		list_del_init(&page->lru);
+		 __free_page(page);
+		pfn++;
+	}
+}
+
+static void add_page_array(struct virtballoon *v, struct balloon_buf *buf,
+			   unsigned int npages)
+{
+	struct page *page;
+	u32 *pfn = (u32 *)&buf->data;
+	int i;
+
+	for (i=0; i<npages; i++) {
+		page = pfn_to_page(*pfn);
+		v->balloon_size++;
+		totalram_pages--;
+		list_add(&page->lru, &v->balloon_plist);
+		pfn++;
+	}
+}
+
+static void inflate_done(struct virtballoon *v, struct balloon_buf *buf,
+			 unsigned int npages)
+{
+	u8 status = buf->hdr.status;
+
+	/* inflate OK */
+	if (!status)
+		add_page_array(v, buf, npages);
+	else 
+		free_page_array(buf, npages);
+}
+
+static void deflate_done(struct virtballoon *v, struct balloon_buf *buf,
+			 unsigned int npages)
+{
+	u8 status = buf->hdr.status;
+
+	/* deflate OK, return pages to the system */
+	if (!status) {
+		free_page_array(buf, npages);
+		totalram_pages += npages;
+		v->balloon_size -= npages;
+	}
+	return;
+}
+
+static int balloon_thread(void *p)
+{
+	struct virtballoon *v = p;
+	DEFINE_WAIT(wait);
+
+	set_freezable();
+	while (!kthread_should_stop()) {
+		int diff, r;
+
+		try_to_freeze();
+
+		r = wait_event_interruptible(v->balloon_wait,
+					     (diff = totalram_pages -
+					      atomic_read(&v->target_nrpages))
+					     || kthread_should_stop());
+		if (r == 0)
+			if (kvm_balloon_xflate(v, diff) == 0)
+				wait_for_completion(&v->complete);
+
+		if (waitqueue_active(&v->rmmod_wait)) {
+			diff = totalram_pages - atomic_read(&v->target_nrpages);
+			if (!diff)
+				wake_up(&v->rmmod_wait);
+		}
+	}
+	return 0;
+}
+
+static bool balloon_tx_done(struct virtqueue *vq)
+{
+	struct balloon_buf *buf;
+	struct virtballoon *v = vq->vdev->priv;
+	unsigned int len;
+
+	buf = vq->vq_ops->get_buf(vq, &len);
+	if (buf) {
+		switch(buf->hdr.cmd) {
+		case CMD_BALLOON_DEFLATE:
+			deflate_done(v, buf, len/sizeof(u32));
+			break;
+		case CMD_BALLOON_INFLATE:
+			inflate_done(v, buf, len/sizeof(u32));
+			break;
+		default:
+			printk("%s: unknown cmd 0x%x\n", __func__,
+				buf->hdr.cmd);
+		}
+		complete(&v->complete);
+	}
+	return true;
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID},
+	{ 0 },
+};
+
+static LIST_HEAD(balloon_devices);
+
+static int balloon_probe(struct virtio_device *vdev)
+{
+	int err = -EINVAL;
+	struct virtballoon *v;
+
+	v = kzalloc(GFP_KERNEL, sizeof(struct virtballoon));
+	if (!v)
+		return -ENOMEM;
+
+	v->vq = vdev->config->find_vq(vdev, 0, balloon_tx_done);
+	if (IS_ERR(v->vq))
+		goto out_free;
+	
+	v->vdev = vdev;
+
+	init_waitqueue_head(&v->balloon_wait);
+	init_waitqueue_head(&v->rmmod_wait);
+	INIT_LIST_HEAD(&v->balloon_plist);
+	INIT_LIST_HEAD(&v->list);
+	init_completion(&v->complete);
+	atomic_set(&v->target_nrpages, totalram_pages);
+
+	vdev->priv = v;
+
+	v->balloon_thread = kthread_run(balloon_thread, v, "kvm_balloond");
+	if (IS_ERR(v->balloon_thread)) 
+		goto out_free_vq;
+
+	list_add(&v->list, &balloon_devices);
+	dev_printk(KERN_INFO, &v->vdev->dev, "registered\n");
+
+	return 0;
+
+out_free_vq:
+	vdev->config->del_vq(v->vq);
+out_free:
+	kfree(v);
+	return err;
+}
+
+static void balloon_remove(struct virtio_device *vdev)
+{
+	struct virtballoon *v = vdev->priv;
+
+	kthread_stop(v->balloon_thread);
+	vdev->config->del_vq(v->vq);
+	list_del(&v->list);
+	kfree(v);
+}
+
+static void balloon_config_changed(struct virtio_device *vdev)
+{
+	struct virtballoon *v = vdev->priv;
+	u32 target_nrpages;
+
+	__virtio_config_val(v->vdev, 0, &target_nrpages);
+	atomic_set(&v->target_nrpages, target_nrpages);
+	wake_up(&v->balloon_wait);
+	dprintk(&vdev->dev, "%s\n", __func__);
+}
+
+static struct virtio_driver virtio_balloon = {
+	.driver.name =  KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table =     id_table,
+	.probe =        balloon_probe,
+	.remove =	__devexit_p(balloon_remove),
+	.config_changed	= balloon_config_changed,
+};
+
+module_param(kvm_balloon_debug, int, 0);
+
+static int __init kvm_balloon_init(void)
+{
+	return register_virtio_driver(&virtio_balloon);
+}
+
+static void __exit kvm_balloon_exit(void)
+{
+	struct virtballoon *v;
+	
+	list_for_each_entry(v, &balloon_devices, list) { 
+		while (v->balloon_size) {
+			DEFINE_WAIT(wait);
+
+			atomic_add(v->balloon_size, &v->target_nrpages);
+			wake_up(&v->balloon_wait);
+			prepare_to_wait(&v->rmmod_wait, &wait,
+					TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ*10);
+			finish_wait(&v->rmmod_wait, &wait);
+		}
+	}
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
@@ -67,6 +67,7 @@ static struct pci_device_id virtio_pci_i
 	{ 0x1AF4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
 	{ 0x1AF4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
 	{ 0x1AF4, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
+	{ 0x1AF4, 0x1003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Balloon */
 	{ 0 },
 };
 
Index: linux-2.6-nv/include/linux/virtio_balloon.h
===================================================================
--- /dev/null
+++ linux-2.6-nv/include/linux/virtio_balloon.h
@@ -0,0 +1,20 @@
+#ifndef _LINUX_VIRTIO_BALLOON_H
+#define _LINUX_VIRTIO_BALLOON_H
+#include <linux/virtio_config.h>
+
+#define VIRTIO_ID_BALLOON 3
+
+#define CMD_BALLOON_INFLATE 0x1
+#define CMD_BALLOON_DEFLATE 0x2
+
+struct virtio_balloon_hdr {
+	__u8 cmd;
+	__u8 status;
+};
+
+struct virtio_balloon_config
+{
+	__u32 target_nrpages;
+};
+
+#endif /* _LINUX_VIRTIO_BALLOON_H */
