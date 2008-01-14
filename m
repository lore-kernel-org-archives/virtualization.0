From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] KVM virtio balloon driver
Date: Mon, 14 Jan 2008 15:29:45 -0600
Message-ID: <478BD449.4060407@codemonkey.ws>
References: <20080114200357.GA18354@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080114200357.GA18354@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Marcelo Tosatti wrote:
> Hi Rusty,
> 
> It was agreed that the balloon driver should be merged through the
> virtio tree, so here it goes. It depends on the config_changed patch
> posted earlier.
> 
> 
> -----
> 
> Following patch adds the KVM balloon driver.
> 
> Changes from last version:
> - Get rid of global variables/structure
> - Use page->lru to link ballooned pages
> - Use dev_dbg/dev_printk
> - Proper kthread_should_stop handling
> - Move shared definitions to separate header
> - Use ->config_changed method for notification
> 
> This depends on Rusty's config_changed patch.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> 
> Index: linux-2.6-nv/drivers/virtio/Kconfig
> ===================================================================
> --- linux-2.6-nv.orig/drivers/virtio/Kconfig
> +++ linux-2.6-nv/drivers/virtio/Kconfig
> @@ -23,3 +23,12 @@ config VIRTIO_PCI
>  
>  	  If unsure, say M.
>  
> +config KVM_BALLOON
> +	tristate "KVM balloon driver (EXPERIMENTAL)"
> +	depends on VIRTIO_PCI
> +	---help---
> +	 This driver provides support for ballooning memory in/out of a
> +	 KVM paravirt guest.	
> +
> +	 If unsure, say M.
> +


Please rename from KVM_BALLOON to VIRTIO_BALLOON.  Also, it doesn't 
depend on VIRTIO_PCI.  It should select VIRTIO and VIRTIO_RING.



> Index: linux-2.6-nv/drivers/virtio/Makefile
> ===================================================================
> --- linux-2.6-nv.orig/drivers/virtio/Makefile
> +++ linux-2.6-nv/drivers/virtio/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_VIRTIO) += virtio.o
>  obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> +obj-$(CONFIG_KVM_BALLOON) += kvm_balloon.o
> Index: linux-2.6-nv/drivers/virtio/kvm_balloon.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6-nv/drivers/virtio/kvm_balloon.c
> @@ -0,0 +1,537 @@
> +/*
> + * KVM guest balloon driver
> + *
> + * Copyright (C) 2007, Qumranet, Inc., Dor Laor <dor.laor@qumranet.com>
> + * Copyright (C) 2007, Red Hat, Inc., Marcelo Tosatti <mtosatti@redhat.com>
> + * 
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#define DEBUG
> +#include <asm/uaccess.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/percpu.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/mm.h>
> +#include <linux/swap.h>
> +#include <linux/wait.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +#include <linux/version.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_balloon.h>
> +#include <linux/preempt.h>
> +#include <linux/kvm_types.h>
> +#include <linux/kvm_host.h>

Please don't include kvm_types or kvm_host.

> +
> +MODULE_AUTHOR ("Dor Laor");
> +MODULE_DESCRIPTION ("Implements guest ballooning support");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1");
> +
> +static int kvm_balloon_debug;
> +
> +#define dprintk(dev, str...) if (kvm_balloon_debug) dev_dbg(dev, str)

This can go away.

Regards,

Anthony Liguori


> +#define BALLOON_DATA_SIZE 200
> +
> +struct balloon_buf {
> +	struct virtio_balloon_hdr hdr;
> +	u8 data[BALLOON_DATA_SIZE];
> +};
> +
> +struct balloon_work {
> +	struct balloon_buf *buf;
> +	struct list_head list;
> +};
> +
> +#define VIRTIO_MAX_SG 2
> +
> +struct virtballoon {
> +	struct virtio_device *vdev;
> +	struct virtqueue *vq;
> +	struct task_struct *balloon_thread;
> +	wait_queue_head_t balloon_wait;
> +	wait_queue_head_t rmmod_wait;
> +	uint32_t target_nrpages;
> +	atomic_t inflight_bufs;
> +	int balloon_size;
> +	struct list_head balloon_plist;
> +	struct list_head balloon_work;
> +	spinlock_t plist_lock;
> +	spinlock_t queue_lock;
> +	struct list_head list;
> +};
> +
> +struct balloon_buf *alloc_balloon_buf(struct virtio_device *vdev, gfp_t flags)
> +{
> +	struct balloon_buf *buf;
> +
> +	buf = kzalloc(sizeof(struct balloon_buf), flags);
> +	if (!buf)
> +		dev_printk(KERN_ERR, &vdev->dev, "%s: alloc fail\n", __func__);
> +
> +	return buf;
> +}
> +
> +static int send_balloon_buf(struct virtballoon *v, uint8_t cmd,
> +			    struct balloon_buf *buf)
> +{
> +	struct scatterlist sg[VIRTIO_MAX_SG];
> +	int err = 0;
> +
> +	buf->hdr.cmd = cmd;
> +
> +	sg_init_table(sg, VIRTIO_MAX_SG);
> +	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
> +	sg_set_buf(&sg[1], &buf->data, sizeof(buf->data));
> +
> +	spin_lock_irq(&v->queue_lock);
> +	err = v->vq->vq_ops->add_buf(v->vq, sg, 0, 2, buf);
> +	if (err) {
> +		dev_printk(KERN_ERR, &v->vq->vdev->dev, "%s: add_buf err\n",
> +			   __func__);
> +		goto out;
> +	}
> +
> +	/* TODO: kick several balloon buffers at once */
> +	v->vq->vq_ops->kick(v->vq);
> +out:
> +	spin_unlock_irq(&v->queue_lock);
> +	atomic_inc(&v->inflight_bufs);
> +	return err;
> +}
> +
> +static int kvm_balloon_inflate(struct virtballoon *v, int32_t npages)
> +{
> +	LIST_HEAD(tmp_list);
> +	struct page *page, *tmp;
> +	struct balloon_buf *buf;
> +	u32 *pfn;
> +	int allocated = 0;
> +	int i, r = -ENOMEM;
> +
> +	buf = alloc_balloon_buf(v->vdev, GFP_KERNEL);
> +	if (!buf)
> +		return r;
> +
> +	pfn = (u32 *)&buf->data;
> +	*pfn++ = (u32)npages;
> +
> +	for (i = 0; i < npages; i++) {
> +		page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
> +		if (!page)
> +			goto out_free;
> +		list_add(&page->lru, &tmp_list);
> +		allocated++;
> +		*pfn = page_to_pfn(page);
> +		pfn++;
> +	}
> +
> +	r = send_balloon_buf(v, CMD_BALLOON_INFLATE, buf);
> +	if (r)
> +		goto out_free;
> +
> +	spin_lock(&v->plist_lock);
> +	list_splice(&tmp_list, &v->balloon_plist);
> +	v->balloon_size += allocated;
> +	totalram_pages -= allocated;
> +	dprintk(&v->vdev->dev, "%s: current balloon size=%d\n", __func__,
> +		v->balloon_size);
> +	spin_unlock(&v->plist_lock);
> +	return allocated;
> +
> +out_free:
> +	list_for_each_entry_safe(page, tmp, &tmp_list, lru) {
> +		list_del(&page->lru);
> +		__free_page(page);
> +	}
> +	return r;
> +}
> +
> +static int kvm_balloon_deflate(struct virtballoon *v, int32_t npages)
> +{
> +	LIST_HEAD(tmp_list);
> +	struct page *page, *tmp;
> +	struct balloon_buf *buf;
> +	u32 *pfn;
> +	int deallocated = 0;
> +	int r = 0;
> +
> +	buf = alloc_balloon_buf(v->vdev, GFP_KERNEL);
> +	if (!buf)
> +		return r;
> +
> +	spin_lock(&v->plist_lock);
> +
> +	if (v->balloon_size < npages) {
> +		dev_printk(KERN_INFO, &v->vdev->dev,
> +			   "%s: balloon=%d with deflate rq=%d\n",
> +			   __func__, v->balloon_size, npages);
> +		npages = v->balloon_size;
> +		if (!npages)
> +			goto out;
> +	}
> +
> +	pfn = (u32 *)&buf->data;
> +	*pfn++ = (u32)-npages;
> +
> +	/*
> +	 * Move the balloon pages to tmp list before issuing 
> +	 * the virtio buffer
> +	 */
> +	list_for_each_entry_safe(page, tmp, &v->balloon_plist, lru) {
> +		*pfn++ = page_to_pfn(page);
> +		list_move(&page->lru, &tmp_list);
> +		if (++deallocated == npages)
> +			break;
> +	}
> +
> +	r = send_balloon_buf(v, CMD_BALLOON_DEFLATE, buf);
> +	if (r)
> +		goto out;
> +
> +	list_for_each_entry_safe(page, tmp, &tmp_list, lru)
> +		list_del_init(&page->lru);
> +
> +	v->balloon_size -= npages;
> +	totalram_pages += npages;
> +	dprintk(&v->vdev->dev, "%s: current balloon size=%d\n", __func__,
> +	       v->balloon_size);
> +
> +	spin_unlock(&v->plist_lock);
> +	return deallocated;
> +
> +out:
> +	list_splice(&tmp_list, &v->balloon_plist);
> +	spin_unlock(&v->plist_lock);
> +	return r;
> +}
> +
> +#define MAX_BALLOON_PAGES_PER_OP (BALLOON_DATA_SIZE/sizeof(u32)) \
> +				 - sizeof(int32_t)
> +#define MAX_BALLOON_XFLATE_OP 1000000
> +
> +static int kvm_balloon_xflate(struct virtballoon *v, int32_t npages)
> +{
> +	int r = -EINVAL, i;
> +	int iterations;
> +	int abspages;
> +	int curr_pages = 0;
> +	int gfns_per_buf;
> +
> +	abspages = abs(npages);
> +
> +	if (abspages > MAX_BALLOON_XFLATE_OP) {
> +		dev_printk(KERN_ERR, &v->vdev->dev,
> +			   "%s: bad npages=%d\n", __func__, npages);
> +		return -EINVAL;
> +	}
> +
> +	dprintk(&v->vdev->dev, "%s: got %s, npages=%d\n", __func__,
> +	       (npages > 0)? "inflate":"deflate", npages);
> +
> +	gfns_per_buf = MAX_BALLOON_PAGES_PER_OP;
> +
> +	/*
> +	 * Call the balloon in PAGE_SIZE*pfns-per-buf
> +	 * iterations
> +	 */
> +	iterations = DIV_ROUND_UP(abspages, gfns_per_buf);
> +	dprintk(&v->vdev->dev, "%s: iterations=%d\n", __func__, iterations);
> +
> +	for (i = 0; i < iterations; i++) {
> +		int32_t pages_in_iteration = 
> +			min(abspages - curr_pages, gfns_per_buf);
> +
> +		if (npages > 0)
> +			r = kvm_balloon_inflate(v, pages_in_iteration);
> +		else
> +			r = kvm_balloon_deflate(v, pages_in_iteration);
> +						
> +		if (r < 0)
> +			return r;
> +		curr_pages += r;
> +		if (r != pages_in_iteration)
> +			break;
> +		cond_resched();
> +	}
> +
> +	return curr_pages;
> +}
> +
> +static void inflate_done(struct virtballoon *v, struct balloon_buf *buf)
> +{
> +	uint8_t status = buf->hdr.status;
> +
> +	/* error inflating, return pages to the system */
> +	if (status) {
> +	 	struct page *page;
> +		u32 *pfn = (u32 *)&buf->data;
> +		int npages = (int)*pfn++;
> +		int i;
> +
> +		spin_lock(&v->plist_lock);
> +		for (i=0;i<npages;i++) { 	
> +			page = pfn_to_page(*pfn);
> +			list_del_init(&page->lru);
> +			__free_page(page);
> +			v->balloon_size--;
> +			totalram_pages++;
> +			v->target_nrpages++;
> +			pfn++;
> +		}
> +		spin_unlock(&v->plist_lock);
> +	}
> +}
> +
> +static void deflate_done(struct virtballoon *v, struct balloon_buf *buf)
> +{
> +	uint8_t status = buf->hdr.status;
> +
> +	/* deflate OK, return pages to the system */
> +	if (!status) { 
> +		u32 *pfn = (u32 *)&buf->data;
> +		int npages, i;
> +
> +		npages = (int)*pfn++;
> +		npages = abs(npages);
> +
> +		for (i = 0; i<npages; i++) {
> +			__free_page(pfn_to_page(*pfn));
> +			pfn++;
> +		}
> +	/* deflate error, add pages back to ballooned list */
> +	} else {
> +		u32 *pfn = (u32 *)&buf->data;
> +		int npages, i;
> +		struct page *page;
> +
> +		npages = (int)*pfn++;
> +		npages = abs(npages);
> +
> +		spin_lock(&v->plist_lock);
> +		for (i = 0; i < npages; i++) {
> +			page = pfn_to_page(*pfn++);
> +			list_add(&page->lru, &v->balloon_plist);
> +			v->balloon_size++;
> +			totalram_pages--;
> +			v->target_nrpages--;
> +		}
> +		spin_unlock(&v->plist_lock);
> +	}
> +	return;
> +}
> +
> +static int balloon_thread(void *p)
> +{
> +	struct virtballoon *v = p;
> +	DEFINE_WAIT(wait);
> +	int rmmod = 0;
> +
> +	set_freezable();
> +	while (!kthread_should_stop()) {
> +		int delta;
> +
> +		prepare_to_wait(&v->balloon_wait, &wait, TASK_INTERRUPTIBLE);
> +		schedule();
> +		finish_wait(&v->balloon_wait, &wait);
> +
> +		try_to_freeze();
> +
> +		/* wait for kthread_stop() if rmmod has been called */
> +		if (rmmod)
> +			continue;
> +
> +		spin_lock_irq(&v->plist_lock);
> +		delta = totalram_pages - v->target_nrpages;
> +		spin_unlock_irq(&v->plist_lock);
> +
> +		if (delta)
> +			kvm_balloon_xflate(v, delta);
> +
> +		spin_lock_irq(&v->queue_lock);
> +		while (!list_empty(&v->balloon_work)) {
> +			struct balloon_work *work;
> +			struct balloon_buf *buf;
> +
> +			work = list_entry(v->balloon_work.next,
> +					 struct balloon_work, list);
> +			list_del(&work->list);
> +			spin_unlock_irq(&v->queue_lock);
> +			buf = work->buf;
> +			kfree(work);
> +
> +			switch(buf->hdr.cmd) {
> +			case CMD_BALLOON_DEFLATE:
> +				deflate_done(v, buf);
> +				break;
> +			case CMD_BALLOON_INFLATE:
> +				inflate_done(v, buf);
> +				break;
> +			default:
> +				printk("%s: unknown cmd 0x%x\n", __func__,
> +					buf->hdr.cmd);
> +			}
> +			kfree(buf);
> +			if (atomic_dec_and_test(&v->inflight_bufs)) {
> +				if (waitqueue_active(&v->rmmod_wait)) {
> +					wake_up(&v->rmmod_wait);
> +					rmmod = 1;
> +				}
> +			}
> +			cond_resched();
> +			spin_lock_irq(&v->queue_lock);
> +		}
> +		spin_unlock_irq(&v->queue_lock);
> +	}
> +	return 0;
> +}
> +
> +static bool balloon_tx_done(struct virtqueue *vq)
> +{
> +	struct balloon_buf *buf;
> +	struct virtballoon *v = vq->vdev->priv;
> +	unsigned int len;
> +
> +	spin_lock(&v->queue_lock);
> +	while ((buf = vq->vq_ops->get_buf(vq, &len)) != NULL) {
> +		struct balloon_work *work;
> +
> +		work = kzalloc(sizeof(struct balloon_work), GFP_ATOMIC);
> +		if (!work)
> +			continue;
> +		INIT_LIST_HEAD(&work->list);
> +		work->buf = buf;
> +
> +		list_add(&work->list, &v->balloon_work);
> +	}
> +	spin_unlock(&v->queue_lock);
> +	wake_up(&v->balloon_wait);
> +
> +	return true;
> +}
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID},
> +	{ 0 },
> +};
> +
> +static LIST_HEAD(balloon_devices);
> +
> +static int balloon_probe(struct virtio_device *vdev)
> +{
> +	int err = -EINVAL;
> +	struct virtballoon *v;
> +
> +	v = kzalloc(GFP_KERNEL, sizeof(struct virtballoon));
> +	if (!v)
> +		return -ENOMEM;
> +
> +	v->vq = vdev->config->find_vq(vdev, 0, balloon_tx_done);
> +	if (IS_ERR(v->vq))
> +		goto out_free;
> +	
> +	v->vdev = vdev;
> +
> +	init_waitqueue_head(&v->balloon_wait);
> +	init_waitqueue_head(&v->rmmod_wait);
> +	spin_lock_init(&v->plist_lock);
> +	spin_lock_init(&v->queue_lock);
> +	INIT_LIST_HEAD(&v->balloon_plist);
> +	INIT_LIST_HEAD(&v->balloon_work);
> +	INIT_LIST_HEAD(&v->list);
> +	atomic_set(&v->inflight_bufs, 0);
> +
> +	vdev->priv = v;
> +
> +	v->balloon_thread = kthread_run(balloon_thread, v, "kvm_balloond");
> +	if (IS_ERR(v->balloon_thread)) 
> +		goto out_free_vq;
> +
> +	list_add(&v->list, &balloon_devices);
> +
> +	dev_printk(KERN_INFO, &v->vdev->dev, "registered\n");
> +
> +	return 0;
> +
> +out_free_vq:
> +	vdev->config->del_vq(v->vq);
> +out_free:
> +	kfree(v);
> +	return err;
> +}
> +
> +static void balloon_remove(struct virtio_device *vdev)
> +{
> +	struct virtballoon *v = vdev->priv;
> +
> +	kthread_stop(v->balloon_thread);
> +	vdev->config->del_vq(v->vq);
> +	list_del(&v->list);
> +	kfree(v);
> +}
> +
> +static void balloon_config_changed(struct virtio_device *vdev)
> +{
> +	struct virtballoon *v = vdev->priv;
> +
> +	spin_lock(&v->plist_lock);
> +	__virtio_config_val(v->vdev, 0, &v->target_nrpages);
> +	spin_unlock(&v->plist_lock);
> +	wake_up(&v->balloon_wait);
> +	dprintk(&vdev->dev, "%s\n", __func__);
> +}
> +
> +static struct virtio_driver virtio_balloon = {
> +	.driver.name =  KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table =     id_table,
> +	.probe =        balloon_probe,
> +	.remove =	__devexit_p(balloon_remove),
> +	.config_changed	= balloon_config_changed,
> +};
> +
> +module_param(kvm_balloon_debug, int, 0);
> +
> +static int __init kvm_balloon_init(void)
> +{
> +	return register_virtio_driver(&virtio_balloon);
> +}
> +
> +static void __exit kvm_balloon_exit(void)
> +{
> +	struct virtballoon *v;
> +	
> +	list_for_each_entry(v, &balloon_devices, list) { 
> +		spin_lock(&v->plist_lock);
> +		if (v->balloon_size) {
> +			DEFINE_WAIT(wait);
> +
> +			v->target_nrpages += v->balloon_size;
> +			spin_unlock(&v->plist_lock);
> +			wake_up(&v->balloon_wait);
> +			prepare_to_wait(&v->rmmod_wait, &wait,
> +					TASK_INTERRUPTIBLE);
> +			schedule();
> +			finish_wait(&v->rmmod_wait, &wait);
> +			spin_lock(&v->plist_lock);
> +		}
> +
> +		if (v->balloon_size)
> +			dev_printk(KERN_ERR, &v->vdev->dev,
> +				   "%s: exit while balloon not empty!\n",
> +				    __func__);
> +
> +		spin_unlock(&v->plist_lock);
> +	}
> +
> +	unregister_virtio_driver(&virtio_balloon);
> +}
> +
> +module_init(kvm_balloon_init);
> +module_exit(kvm_balloon_exit);
> Index: linux-2.6-nv/drivers/virtio/virtio_pci.c
> ===================================================================
> --- linux-2.6-nv.orig/drivers/virtio/virtio_pci.c
> +++ linux-2.6-nv/drivers/virtio/virtio_pci.c
> @@ -67,6 +67,7 @@ static struct pci_device_id virtio_pci_i
>  	{ 0x1AF4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
>  	{ 0x1AF4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
>  	{ 0x1AF4, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
> +	{ 0x1AF4, 0x1003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Balloon */
>  	{ 0 },
>  };
>  
> Index: linux-2.6-nv/include/linux/virtio_balloon.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6-nv/include/linux/virtio_balloon.h
> @@ -0,0 +1,20 @@
> +#ifndef _LINUX_VIRTIO_BALLOON_H
> +#define _LINUX_VIRTIO_BALLOON_H
> +#include <linux/virtio_config.h>
> +
> +#define VIRTIO_ID_BALLOON 3
> +
> +#define CMD_BALLOON_INFLATE 0x1
> +#define CMD_BALLOON_DEFLATE 0x2
> +
> +struct virtio_balloon_hdr {
> +	uint8_t cmd;
> +	uint8_t status;
> +};
> +
> +struct virtio_balloon_config
> +{
> +	uint32_t target_nrpages;
> +};
> +
> +#endif /* _LINUX_VIRTIO_BALLOON_H */
