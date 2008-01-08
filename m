From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Tue, 08 Jan 2008 09:42:13 -0600
Message-ID: <478399D5.9030707__47616.5562904955$1199807161$gmane$org@codemonkey.ws>
References: <20080108153356.GA21726@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080108153356.GA21726@dmt>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Marcelo Tosatti wrote:
> Following patch introduces a KVM guest balloon driver. Communication
> to/from the host is performed via virtio.
>
> Next patch implements the QEMU driver and handling.
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
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
> @@ -0,0 +1,577 @@
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
> +#include <asm/uaccess.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/percpu.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/mm.h>
> +#include <linux/swap.h>
> +#include <linux/wait.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +#include <linux/version.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_pci.h>
> +#include <linux/preempt.h>
> +#include <linux/kvm_types.h>
> +#include <linux/kvm_host.h>
> +
> +MODULE_AUTHOR ("Dor Laor");
> +MODULE_DESCRIPTION ("Implements guest ballooning support");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1");
> +
> +#define CMD_BALLOON_INFLATE 0x1
> +#define CMD_BALLOON_DEFLATE 0x2
>   

Anything that's part of the ABI needs to be in a header file.  This is 
how the rest of the virtio devices work.

> +static int kvm_balloon_debug;
> +
> +#define DEBUG
> +#ifdef DEBUG
> +#define dprintk(str...) if (kvm_balloon_debug) printk(str)
> +#else
> +#define dprintk(str...)
> +#endif
>   

I think pr_debug is the more appropriate thing to use.

> +static LIST_HEAD(balloon_plist);
> +static LIST_HEAD(balloon_work);
> +static int balloon_size = 0;
> +static DEFINE_SPINLOCK(balloon_plist_lock);
> +static DEFINE_SPINLOCK(balloon_queue_lock);
>   

So far, all the drivers hang their state off of the virtio_device 
instead of using statics.  While it's probably arguable that you will 
never have multiple balloon drivers, I think it's a good idea to at 
least be consistent and not use all of these globals.

> +struct virtio_balloon_hdr {
> +	uint8_t cmd;
> +	uint8_t status;
> +};
> +
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
> +	struct virtio_device *dev;
> +	struct virtqueue *vq;
> +	struct task_struct *balloon_thread;
> +	wait_queue_head_t balloon_wait;
> +	wait_queue_head_t rmmod_wait;
> +	uint32_t target_nrpages;
> +	atomic_t inflight_bufs;
> +};
> +
> +struct balloon_page {
> +	struct page *bpage;
> +	struct list_head bp_list;
> +};
> +
> +struct virtballoon virtballoon;
> +
> +struct balloon_buf *alloc_balloon_buf(void)
> +{
> +	struct balloon_buf *buf;
> +
> +	buf = kzalloc(sizeof(struct balloon_buf), GFP_KERNEL);
> +	if (!buf)
> +		printk(KERN_ERR "%s: allocation failed\n", __func__);
> +
> +	return buf;
> +}
> +
> +static int send_balloon_buf(uint8_t cmd, struct balloon_buf *buf)
> +{
> +	struct scatterlist sg[VIRTIO_MAX_SG];
> +	struct virtqueue *vq = virtballoon.vq;
> +	int err = 0;
> +
> +	buf->hdr.cmd = cmd;
> +
> +	sg_init_table(sg, VIRTIO_MAX_SG);
> +	sg_set_buf(&sg[0], &buf->hdr, sizeof(buf->hdr));
> +	sg_set_buf(&sg[1], &buf->data, sizeof(buf->data));
> +
> +	spin_lock_irq(&balloon_queue_lock);
> +	err = vq->vq_ops->add_buf(vq, sg, 0, 2, buf);
> +	if (err) {
> +		printk("%s: add_buf err\n", __func__);
> +		goto out;
> +	}
> +	atomic_inc(&virtballoon.inflight_bufs);
> +
> +	/* TODO: kick several balloon buffers at once */
> +	vq->vq_ops->kick(vq);
> +out:
> +	spin_unlock_irq(&balloon_queue_lock);
> +	return err;
> +}
> +
> +static int kvm_balloon_inflate(int32_t npages)
> +{
> +	LIST_HEAD(tmp_list);
> +	struct balloon_page *node, *tmp;
> +	struct balloon_buf *buf;
> +	u32 *pfn;
> +	int allocated = 0;
> +	int i, r = -ENOMEM;
> +
> +	buf = alloc_balloon_buf();
> +	if (!buf)
> +		return r;
> +
> +	pfn = (u32 *)&buf->data;
> +	*pfn++ = (u32)npages;
> +
> +	for (i = 0; i < npages; i++) {
> +		node = kzalloc(sizeof(struct balloon_page), GFP_KERNEL);
> +		if (!node)
> +			goto out_free;
>   

Instead of allocating a node for each page, you could use page->private 
to create a linked list.  You're potentially burning a lot of memory 
when ballooning down by a large amount otherwise.

> +		node->bpage = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
> +		if (!node->bpage) {
> +			kfree(node);
> +			goto out_free;
> +		}
> +
> +		list_add(&node->bp_list, &tmp_list);
> +		allocated++;
> +		*pfn = page_to_pfn(node->bpage);
> +		pfn++;
> +	}
> +
> +	r = send_balloon_buf(CMD_BALLOON_INFLATE, buf);
> +	if (r)
> +		goto out_free;
> +
> +	spin_lock(&balloon_plist_lock);
> +	list_splice(&tmp_list, &balloon_plist);
> +	balloon_size += allocated;
> +	totalram_pages -= allocated;
> +	dprintk("%s: current balloon size=%d\n", __FUNCTION__,
> +	       balloon_size);
> +	spin_unlock(&balloon_plist_lock);
> +	return allocated;
> +
> +out_free:
> +	list_for_each_entry_safe(node, tmp, &tmp_list, bp_list) {
> +		__free_page(node->bpage);
> +		list_del(&node->bp_list);
> +		kfree(node);
> +	}
> +	return r;
> +}
>   
<snip>
> +
> +static int balloon_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *pvdev = to_vp_device(vdev);
> +	int err = -EBUSY;
> +
> +	if (virtballoon.dev) { 
> +		printk("kvm_ballon: error, already registered\n");
> +		return -EBUSY;
> +	}
> +
> +	virtballoon.vq = vdev->config->find_vq(vdev, 0, balloon_tx_done);
> +	if (IS_ERR(virtballoon.vq)) {
> +		printk("%s: error finding vq\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	virtballoon.dev = vdev;
> +	init_waitqueue_head(&virtballoon.balloon_wait);
> +	init_waitqueue_head(&virtballoon.rmmod_wait);
> +	atomic_set(&virtballoon.inflight_bufs, 0);
> +
> +	err = request_irq(pvdev->pci_dev->irq, balloon_irq, IRQF_SHARED,
> +			  pvdev->vdev.dev.bus_id, &virtballoon);
> +	if (err)
> +		goto out_free_vq;
>   

Why is it taking over the irq?  This is very, very wrong.  A virtio 
device cannot be dependent on being used on top of the virtio-pci backend.

> +
> +	virtballoon.balloon_thread = kthread_run(balloon_thread,
> +						 &virtballoon,
> +						 "kvm_balloond");
> +	printk("kvm_balloon: registered\n");
> +
> +	return 0;
> +
> +out_free_vq:
> +	vdev->config->del_vq(virtballoon.vq);
> +	virtballoon.dev = NULL;
> +	return err;
> +}
> +
> +static void balloon_remove(struct virtio_device *vdev)
> +{
> +	kthread_stop(virtballoon.balloon_thread);
> +	vdev->config->del_vq(virtballoon.vq);
> +}
> +
> +static struct virtio_driver virtio_balloon = {
> +	.driver.name =  KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table =     id_table,
> +	.probe =        balloon_probe,
> +	.remove =	__devexit_p(balloon_remove),
> +};
> +
> +module_param(kvm_balloon_debug, int, 0);
> +
> +static int __init kvm_balloon_init(void)
> +{
> +	virtballoon.dev = NULL;
> +
> +	return register_virtio_driver(&virtio_balloon);
> +}
> +
> +static void __exit kvm_balloon_exit(void)
> +{
> +	spin_lock(&balloon_plist_lock);
> +	if (balloon_size) {
> +		DEFINE_WAIT(wait);
> +
> +		virtballoon.target_nrpages += balloon_size;
> +		spin_unlock(&balloon_plist_lock);
> +		virtballoon.dev->config->set(virtballoon.dev, 0, 
> +					   &virtballoon.target_nrpages,
> +					   sizeof(virtballoon.target_nrpages));
> +		wake_up(&virtballoon.balloon_wait);
> +		prepare_to_wait(&virtballoon.rmmod_wait, &wait,
> +				TASK_UNINTERRUPTIBLE);
> +		schedule();
> +		finish_wait(&virtballoon.rmmod_wait, &wait);
> +		spin_lock(&balloon_plist_lock);
> +	}
> +
> +	if (balloon_size)
> +		printk(KERN_ERR "%s: exit while balloon not empty!\n",
> +			__FUNCTION__);
> +
> +	spin_unlock(&balloon_plist_lock);
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
> @@ -30,20 +30,6 @@ MODULE_DESCRIPTION("virtio-pci");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION("1");
>  
> -/* Our device structure */
> -struct virtio_pci_device
> -{
> -	struct virtio_device vdev;
> -	struct pci_dev *pci_dev;
> -
> -	/* the IO mapping for the PCI config space */
> -	void *ioaddr;
> -
> -	/* a list of queues so we can dispatch IRQs */
> -	spinlock_t lock;
> -	struct list_head virtqueues;
> -};
> -
>  struct virtio_pci_vq_info
>  {
>  	/* the actual virtqueue */
> @@ -67,6 +53,7 @@ static struct pci_device_id virtio_pci_i
>  	{ 0x1AF4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
>  	{ 0x1AF4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
>  	{ 0x1AF4, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
> +	{ 0x1AF4, 0x1003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Balloon */
>  	{ 0 },
>  };
>  
> @@ -89,12 +76,6 @@ static struct device virtio_pci_root = {
>  /* Unique numbering for devices under the kvm root */
>  static unsigned int dev_index;
>  
> -/* Convert a generic virtio device to our structure */
> -static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> -{
> -	return container_of(vdev, struct virtio_pci_device, vdev);
> -}
> -
>  /* virtio config->feature() implementation */
>  static bool vp_feature(struct virtio_device *vdev, unsigned bit)
>  {
> Index: linux-2.6-nv/include/linux/virtio_pci.h
> ===================================================================
> --- linux-2.6-nv.orig/include/linux/virtio_pci.h
> +++ linux-2.6-nv/include/linux/virtio_pci.h
> @@ -19,6 +19,26 @@
>  
>  #include <linux/virtio_config.h>
>  
> +/* Our device structure */
> +struct virtio_pci_device
> +{
> +	struct virtio_device vdev;
> +	struct pci_dev *pci_dev;
> +
> +	/* the IO mapping for the PCI config space */
> +	void *ioaddr;
> +
> +	/* a list of queues so we can dispatch IRQs */
> +	spinlock_t lock;
> +	struct list_head virtqueues;
> +};
> +
> +/* Convert a generic virtio device to our structure */
> +struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> +{
> +	return container_of(vdev, struct virtio_pci_device, vdev);
> +}
> +
>   

This should be a big indicator that something is wrong.  You should not 
have to change the encapsulation of the virtio-pci backend.

Regards,

Anthony Liguori

>  /* A 32-bit r/o bitmask of the features supported by the host */
>  #define VIRTIO_PCI_HOST_FEATURES	0
>  
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>   
