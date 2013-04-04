From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Thu, 4 Apr 2013 11:25:59 +0300
Message-ID: <20130404082559.GA10369@redhat.com>
References: <8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
	<20130327112535.GE24243@redhat.com> <5153CC2E.3090908@zytor.com>
	<878v554lsr.fsf@rustcorp.com.au> <515B610C.9000802@zytor.com>
	<8738v85elm.fsf@rustcorp.com.au>
	<20130403112216.GB19122@redhat.com>
	<87obdu3kz0.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87obdu3kz0.fsf@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 04, 2013 at 04:18:03PM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Wed, Apr 03, 2013 at 04:40:29PM +1030, Rusty Russell wrote:
> >> Current proposal is a 16 bit 'offset' field in the queue data for each
> >> queue, ie.
> >>         addr = dev->notify_base + vq->notify_off;
> >> 
> >> You propose a per-device 'shift' field:
> >>         addr = dev->notify_base + (vq->index << dev->notify_shift);
> >> 
> >> Which allows greater offsets, but insists on a unique offset per queue.
> >> Might be a fair trade-off...
> >> 
> >> Cheers,
> >> Rusty.
> >
> > Or even
> >          addr = dev->notify_base + (vq->notify_off << dev->notify_shift);
> >
> > since notify_base is per capability, shift can be per capability too.
> > And for IO we can allow it to be 32 to mean "always use base".
> >
> > This is a bit more elegant than just saying "no offsets for IO".
> 
> Yes, I shied away from this because it makes the capabilities different
> sizes, but per capability is elegant.  Except it really needs to be a
> multiplier, not a shift, since we want a "0".  And magic numbers are
> horrible.
> Since the multiply can be done at device init time, I don't think it's a
> big issue.
> 
> The results looks something like this...
> 
> Cheers,
> Rusty.

Looks good, I'm implementing the wildcard MMIO to check that
this actually works as fast as PIO.

By the way, Gleb pointed out that on older hosts MMIO will
always be slower since we need to do a shadow page walk to
translate virtual to physical address.
Hopefully not a big concern, and after all we are still
keeping PIO around for use by BIOS ...

> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index c917e3a..f2ce171 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -46,8 +46,8 @@ struct virtio_pci_device {
>  	size_t notify_len;
>  	size_t device_len;
>  
> -	/* We use the queue_notify_moff only for MEM bars. */
> -	bool notify_use_offset;
> +	/* We use the queue_notify_off only for MEM bars. */
> +	u32 notify_offset_multiplier;
>  
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
> @@ -469,7 +469,7 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_vq_info *info;
>  	struct virtqueue *vq;
> -	u16 num;
> +	u16 num, off;
>  	int err;
>  
>  	if (index >= ioread16(&vp_dev->common->num_queues))
> @@ -502,19 +502,16 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>  
>  	info->msix_vector = msix_vec;
>  
> -	if (vp_dev->notify_use_offset) {
> -		/* get offset of notification byte for this virtqueue */
> -		u16 off = ioread16(&vp_dev->common->queue_notify_moff);
> -		if (off > vp_dev->notify_len) {
> -			dev_warn(&vp_dev->pci_dev->dev,
> -				 "bad notification offset %u for queue %u (> %u)",
> -				 off, index, vp_dev->notify_len);
> -			err = -EINVAL;
> -			goto out_info;
> -		}
> -		info->notify = vp_dev->notify_base + off;
> -	} else
> -		info->notify = vp_dev->notify_base;
> +	/* get offset of notification byte for this virtqueue */
> +	off = ioread16(&vp_dev->common->queue_notify_off);
> +	if (off * vp_dev->notify_offset_multiplier > vp_dev->notify_len) {

maybe check there's no overflow too?
if (UINT32_MAX / vp_dev->notify_offset_multiplier > off)
	return -EINVAL;

> +		dev_warn(&vp_dev->pci_dev->dev,
> +			 "bad notification offset %u for queue %u (> %u)",
> +			 off, index, vp_dev->notify_len);
> +		err = -EINVAL;
> +		goto out_info;
> +	}

I don't know if you want to limit this to "0 or power of two",
if yes you'd do
	if (vp_dev->notify_offset_multiplier & (vp_dev->notify_offset_multiplier - 1))
		return -EINVAL;

> +	info->notify = vp_dev->notify_base + off * vp_dev->notify_offset_multiplier;
>  
>  	info->queue = alloc_virtqueue_pages(&num);
>  	if (info->queue == NULL) {
> @@ -812,7 +809,7 @@ static void virtio_pci_release_dev(struct device *_d)
>  }
>  
>  static void __iomem *map_capability(struct pci_dev *dev, int off, size_t minlen,
> -				    size_t *len, bool *is_mem)
> +				    size_t *len)
>  {
>  	u8 bar;
>  	u32 offset, length;
> @@ -834,8 +831,6 @@ static void __iomem *map_capability(struct pci_dev *dev, int off, size_t minlen,
>  
>  	if (len)
>  		*len = length;
> -	if (is_mem)
> -		*is_mem = pci_resource_flags(dev, bar) & IORESOURCE_MEM;
>  
>  	/* We want uncachable mapping, even if bar is cachable. */
>  	p = pci_iomap_range(dev, bar, offset, length, PAGE_SIZE, true);
> @@ -914,19 +909,23 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	err = -EINVAL;
>  	vp_dev->common = map_capability(pci_dev, common,
>  					sizeof(struct virtio_pci_common_cfg),
> -					NULL, NULL);
> +					NULL);
>  	if (!vp_dev->common)
>  		goto out_req_regions;
> -	vp_dev->isr = map_capability(pci_dev, isr, sizeof(u8), NULL, NULL);
> +	vp_dev->isr = map_capability(pci_dev, isr, sizeof(u8), NULL);
>  	if (!vp_dev->isr)
>  		goto out_map_common;
> +
> +	/* Read notify_off_multiplier from config space. */
> +	pci_read_config_dword(pci_dev,
> +			      notify + offsetof(struct virtio_pci_notify_cap,
> +						notify_off_multiplier),
> +			      &vp_dev->notify_offset_multiplier);
>  	vp_dev->notify_base = map_capability(pci_dev, notify, sizeof(u8),
> -					     &vp_dev->notify_len,
> -					     &vp_dev->notify_use_offset);
> +					     &vp_dev->notify_len);
>  	if (!vp_dev->notify_len)
>  		goto out_map_isr;
> -	vp_dev->device = map_capability(pci_dev, device, 0,
> -					&vp_dev->device_len, NULL);
> +	vp_dev->device = map_capability(pci_dev, device, 0, &vp_dev->device_len);
>  	if (!vp_dev->device)
>  		goto out_map_notify;
>  
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 942135a..3e61d55 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -133,6 +133,11 @@ struct virtio_pci_cap {
>  	__le32 length;	/* Length. */
>  };
>  
> +struct virtio_pci_notify_cap {
> +	struct virtio_pci_cap cap;
> +	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
> +};
> +
>  /* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
>  struct virtio_pci_common_cfg {
>  	/* About the whole device. */
> @@ -146,13 +151,13 @@ struct virtio_pci_common_cfg {
>  	__u8 unused1;
>  
>  	/* About a specific virtqueue. */
> -	__le16 queue_select;	/* read-write */
> -	__le16 queue_size;	/* read-write, power of 2. */
> -	__le16 queue_msix_vector;/* read-write */
> -	__le16 queue_enable;	/* read-write */
> -	__le16 queue_notify_moff; /* read-only */
> -	__le64 queue_desc;	/* read-write */
> -	__le64 queue_avail;	/* read-write */
> -	__le64 queue_used;	/* read-write */
> +	__le16 queue_select;		/* read-write */
> +	__le16 queue_size;		/* read-write, power of 2. */
> +	__le16 queue_msix_vector;	/* read-write */
> +	__le16 queue_enable;		/* read-write */
> +	__le16 queue_notify_off;	/* read-only */
> +	__le64 queue_desc;		/* read-write */
> +	__le64 queue_avail;		/* read-write */
> +	__le64 queue_used;		/* read-write */
>  };
>  #endif /* _UAPI_LINUX_VIRTIO_PCI_H */
> 
