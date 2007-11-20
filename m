From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 3/3] virtio PCI device
Date: Tue, 20 Nov 2007 17:01:11 +0200
Message-ID: <4742F6B7.20503@qumranet.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com> <11944900163817-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759094AbXKTPAf@vger.kernel.org>
In-Reply-To: <11944900163817-git-send-email-aliguori@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rusycorp.com.au>, virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> This is a PCI device that implements a transport for virtio.  It allows virtio
> devices to be used by QEMU based VMMs like KVM or Xen.
>
> +
> +/* the notify function used when creating a virt queue */
> +static void vp_notify(struct virtqueue *vq)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_vq_info *info = vq->priv;
> +
> +	/* we write the queue's selector into the notification register to
> +	 * signal the other end */
> +	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY);
> +}
>   

This means we can't kick multiple queues with one exit.

I'd also like to see a hypercall-capable version of this (but that can 
wait).

> +
> +/* A small wrapper to also acknowledge the interrupt when it's handled.
> + * I really need an EIO hook for the vring so I can ack the interrupt once we
> + * know that we'll be handling the IRQ but before we invoke the callback since
> + * the callback may notify the host which results in the host attempting to
> + * raise an interrupt that we would then mask once we acknowledged the
> + * interrupt. */
> +static irqreturn_t vp_interrupt(int irq, void *opaque)
> +{
> +	struct virtio_pci_device *vp_dev = opaque;
> +	struct virtio_pci_vq_info *info;
> +	irqreturn_t ret = IRQ_NONE;
> +	u8 isr;
> +
> +	/* reading the ISR has the effect of also clearing it so it's very
> +	 * important to save off the value. */
> +	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
>   

Can this be implemented via shared memory? We're exiting now on every 
interrupt.


> +	return ret;
> +}
> +
> +/* the config->find_vq() implementation */
> +static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
> +				    bool (*callback)(struct virtqueue *vq))
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_vq_info *info;
> +	struct virtqueue *vq;
> +	int err;
> +	u16 num;
> +
> +	/* Select the queue we're interested in */
> +	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
>   

I would really like to see this implemented as pci config space, with no 
tricks like multiplexing several virtqueues on one register. Something 
like the PCI BARs where you have all the register numbers allocated 
statically to queues.

> +
> +	/* Check if queue is either not available or already active. */
> +	num = ioread16(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NUM);
> +	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
> +		return ERR_PTR(-ENOENT);
> +
> +	/* allocate and fill out our structure the represents an active
> +	 * queue */
> +	info = kmalloc(sizeof(struct virtio_pci_vq_info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->queue_index = index;
> +	info->num = num;
> +
> +	/* determine the memory needed for the queue and provide the memory
> +	 * location to the host */
> +	info->n_pages = DIV_ROUND_UP(vring_size(num), PAGE_SIZE);
> +	info->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				  get_order(info->n_pages));
> +	if (info->pages == NULL) {
> +		err = -ENOMEM;
> +		goto out_info;
> +	}
> +
> +	/* FIXME: is this sufficient for info->n_pages > 1? */
> +	info->queue = kmap(info->pages);
> +	if (info->queue == NULL) {
> +		err = -ENOMEM;
> +		goto out_alloc_pages;
> +	}
> +
> +	/* activate the queue */
> +	iowrite32(page_to_pfn(info->pages),
> +		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> +		  
> +	/* create the vring */
> +	vq = vring_new_virtqueue(info->num, vdev, info->queue,
> +				 vp_notify, callback);
> +	if (!vq) {
> +		err = -ENOMEM;
> +		goto out_activate_queue;
> +	}
> +
> +	vq->priv = info;
> +	info->vq = vq;
> +
> +	spin_lock(&vp_dev->lock);
> +	list_add(&info->node, &vp_dev->virtqueues);
> +	spin_unlock(&vp_dev->lock);
> +
>   

Is this run only on init? If so the lock isn't needed.


-- 
error compiling committee.c: too many arguments to function
