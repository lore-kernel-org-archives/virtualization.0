From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Thu, 21 Mar 2013 12:13:00 +0200
Message-ID: <20130321101300.GA30493@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 06:59:37PM +1030, Rusty Russell wrote:
> (MST, is this what you were thinking?)

Almost.

Three points:

1. this is still an offset in BAR so for KVM we are still forced to use
an IO BAR.  I would like an option for hypervisor to simply say "Do IO
to this fixed address for this VQ". Then virtio can avoid using IO BARs
completely.

2.  for a real virtio device, offset is only 16 bit, using a 32 bit
offset in a memory BAR giving each VQ a separate 4K page would allow
priveledge separation where e.g. RXVQ/TXVQ are passed through to
hardware but CVQ is handled by the hypervisor.

3. last thing - (1) applies to ISR reads as well.

So I had in mind a structure like:

	struct vq_notify {
		u32 offset;
		u16 data;
		u16 flags;
	}

enum vq_notify_flags {
	VQ_NOTIFY_BAR0,
	VQ_NOTIFY_BAR1,
	VQ_NOTIFY_BAR2,
	VQ_NOTIFY_BAR3,
	VQ_NOTIFY_BAR4,
	VQ_NOTIFY_BAR5,
	VQ_NOTIFY_FIXED_IOPORT,
}

And then to notify a vq we write a given data at given offset
or into a given port for VQ_NOTIFY_FIXED_IOPORT.

Only point 1 is really important for me though, I can be
flexible on the rest of it.


> This uses the previously-unused field for "queue_notify".  This contains
> the offset from the notification area given by the VIRTIO_PCI_CAP_NOTIFY_CFG
> header.
> 
> (A device can still make them all overlap if it wants, since the queue
> index is written: it can still distinguish different notifications).
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/virtio/virtio_pci.c     |   61 +++++++++++++++++++++++++++------------
>  include/uapi/linux/virtio_pci.h |    2 +-
>  2 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index f252afe..d492361 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -37,11 +37,15 @@ struct virtio_pci_device {
>  	struct virtio_pci_common_cfg __iomem *common;
>  	/* Where to read and clear interrupt */
>  	u8 __iomem *isr;
> -	/* Write the virtqueue index here to notify device of activity. */
> -	__le16 __iomem *notify;
> +	/* Write the vq index here to notify device of activity. */
> +	void __iomem *notify_base;
>  	/* Device-specific data. */
>  	void __iomem *device;
>  
> +	/* So we can sanity-check accesses. */
> +	size_t notify_len;
> +	size_t device_len;
> +
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> @@ -84,6 +88,9 @@ struct virtio_pci_vq_info {
>  	/* the list node for the virtqueues list */
>  	struct list_head node;
>  
> +	/* Notify area for this vq. */
> +	u16 __iomem *notify;
> +
>  	/* MSI-X vector (or none) */
>  	unsigned msix_vector;
>  };
> @@ -240,11 +247,11 @@ static void vp_reset(struct virtio_device *vdev)
>  /* the notify function used when creating a virt queue */
>  static void vp_notify(struct virtqueue *vq)
>  {
> -	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_vq_info *info = vq->priv;
>  
> -	/* we write the queue's selector into the notification register to
> -	 * signal the other end */
> -	iowrite16(vq->index, vp_dev->notify);
> +	/* we write the queue selector into the notification register
> +	 * to signal the other end */
> +	iowrite16(vq->index, info->notify);
>  }
>  
>  /* Handle a configuration change: Tell driver if it wants to know. */
> @@ -460,7 +467,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>  	struct virtio_pci_vq_info *info;
>  	struct virtqueue *vq;
>  	u16 num;
> -	int err;
> +	int err, off;
>  
>  	if (index >= ioread16(&vp_dev->common->num_queues))
>  		return ERR_PTR(-ENOENT);
> @@ -492,6 +499,17 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>  
>  	info->msix_vector = msix_vec;
>  
> +	/* get offset of notification byte for this virtqueue */
> +	off = ioread16(&vp_dev->common->queue_notify);
> +	if (off > vp_dev->notify_len) {
> +		dev_warn(&vp_dev->pci_dev->dev,
> +			 "bad notification offset %u for queue %u (> %u)",
> +			 off, index, vp_dev->notify_len);
> +		err = -EINVAL;
> +		goto out_info;
> +	}
> +	info->notify = vp_dev->notify_base + off;
> +
>  	info->queue = alloc_virtqueue_pages(&num);
>  	if (info->queue == NULL) {
>  		err = -ENOMEM;
> @@ -787,7 +805,8 @@ static void virtio_pci_release_dev(struct device *_d)
>  	 */
>  }
>  
> -static void __iomem *map_capability(struct pci_dev *dev, int off, size_t expect)
> +static void __iomem *map_capability(struct pci_dev *dev, int off, size_t minlen,
> +				    size_t *len)
>  {
>  	u8 bar;
>  	u32 offset, length;
> @@ -800,13 +819,16 @@ static void __iomem *map_capability(struct pci_dev *dev, int off, size_t expect)
>  	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>  			     &length);
>  
> -	if (length < expect) {
> +	if (length < minlen) {
>  		dev_err(&dev->dev,
> -			"virtio_pci: small capability len %u (%u expected)\n",
> -			length, expect);
> +			"virtio_pci: small capability len %u (%zu expected)\n",
> +			length, minlen);
>  		return NULL;
>  	}
>  
> +	if (len)
> +		*len = length;
> +
>  	/* We want uncachable mapping, even if bar is cachable. */
>  	p = pci_iomap_range(dev, bar, offset, length, PAGE_SIZE, true);
>  	if (!p)
> @@ -883,16 +905,19 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  
>  	err = -EINVAL;
>  	vp_dev->common = map_capability(pci_dev, common,
> -					sizeof(struct virtio_pci_common_cfg));
> +					sizeof(struct virtio_pci_common_cfg),
> +					NULL);
>  	if (!vp_dev->common)
>  		goto out_req_regions;
> -	vp_dev->isr = map_capability(pci_dev, isr, sizeof(u8));
> +	vp_dev->isr = map_capability(pci_dev, isr, sizeof(u8), NULL);
>  	if (!vp_dev->isr)
>  		goto out_map_common;
> -	vp_dev->notify = map_capability(pci_dev, notify, sizeof(u16));
> -	if (!vp_dev->notify)
> +	vp_dev->notify_base = map_capability(pci_dev, notify, sizeof(u8),
> +					     &vp_dev->notify_len);
> +	if (!vp_dev->notify_len)
>  		goto out_map_isr;
> -	vp_dev->device = map_capability(pci_dev, device, 0);
> +	vp_dev->device = map_capability(pci_dev, device, 0,
> +					&vp_dev->device_len);
>  	if (!vp_dev->device)
>  		goto out_map_notify;
>  
> @@ -917,7 +942,7 @@ out_set_drvdata:
>  	pci_set_drvdata(pci_dev, NULL);
>  	pci_iounmap(pci_dev, vp_dev->device);
>  out_map_notify:
> -	pci_iounmap(pci_dev, vp_dev->notify);
> +	pci_iounmap(pci_dev, vp_dev->notify_base);
>  out_map_isr:
>  	pci_iounmap(pci_dev, vp_dev->isr);
>  out_map_common:
> @@ -940,7 +965,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	vp_del_vqs(&vp_dev->vdev);
>  	pci_set_drvdata(pci_dev, NULL);
>  	pci_iounmap(pci_dev, vp_dev->device);
> -	pci_iounmap(pci_dev, vp_dev->notify);
> +	pci_iounmap(pci_dev, vp_dev->notify_base);
>  	pci_iounmap(pci_dev, vp_dev->isr);
>  	pci_iounmap(pci_dev, vp_dev->common);
>  	pci_release_regions(pci_dev);
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index b334cd9..23b90cb 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -144,13 +144,13 @@ struct virtio_pci_common_cfg {
>  	__le16 num_queues;		/* read-only */
>  	__u8 device_status;		/* read-write */
>  	__u8 unused1;
> -	__le16 unused2;
>  
>  	/* About a specific virtqueue. */
>  	__le16 queue_select;	/* read-write */
>  	__le16 queue_size;	/* read-write, power of 2. */
>  	__le16 queue_msix_vector;/* read-write */
>  	__le16 queue_enable;	/* read-write */
> +	__le16 queue_notify;	/* read-only */
>  	__le64 queue_desc;	/* read-write */
>  	__le64 queue_avail;	/* read-write */
>  	__le64 queue_used;	/* read-write */
> -- 
> 1.7.10.4
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
