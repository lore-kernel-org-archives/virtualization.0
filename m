From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH v2] virtio-mmio: Update the device to OASIS spec version
Date: Wed, 29 Apr 2015 17:30:37 +0100
Message-ID: <1430325037.3283.44.camel@arm.com>
References: <1421777531-15180-1-git-send-email-pawel.moll@arm.com>
	<553FF648.2020003@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <553FF648.2020003@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2015-04-28 at 22:06 +0100, Christopher Covington wrote:
> Hi,
> 
> On 01/20/2015 01:12 PM, Pawel Moll wrote:
> 
> > @@ -356,13 +346,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
> >  		info->num /= 2;
> >  	}
> >  
> > -	/* Activate the queue */
> > -	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> > -	writel(VIRTIO_MMIO_VRING_ALIGN,
> > -			vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> > -	writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> > -			vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> > -
> >  	/* Create the vring */
> >  	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN, vdev,
> >  				 true, info->queue, vm_notify, callback, name);
> > @@ -371,6 +354,33 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
> >  		goto error_new_virtqueue;
> >  	}
> >  
> > +	/* Activate the queue */
> > +	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> > +	if (vm_dev->version == 1) {
> > +		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> > +		writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> > +				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> > +	} else {
> > +		u64 addr;
> > +
> > +		addr = virt_to_phys(info->queue);
> > +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
> > +		writel((u32)(addr >> 32),
> > +				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
> > +
> > +		addr = virt_to_phys(virtqueue_get_avail(vq));
> > +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
> > +		writel((u32)(addr >> 32),
> > +				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
> > +
> > +		addr = virt_to_phys(virtqueue_get_used(vq));
> > +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
> > +		writel((u32)(addr >> 32),
> > +				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
> > +
> > +		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
> > +	}
> > +
> >  	vq->priv = info;
> >  	info->vq = vq;
> 
> This patch moved the call to vring_new_virtqueue() in the legacy code flow
> before the VIRTIO_MMIO_QUEUE_NUM, VIRTIO_MMIO_QUEUE_ALIGN, and
> VIRTIO_MMIO_QUEUE_PFN writes. 

Just to make sure: we're talking the legacy case only here, correct?

> Was this intentional? 

Yes, it simply made the code cleaner. I remember stopping for a moment
doing this change and thinking what bad can it make. Haven't figured out
anything, but it seems I was wrong ;-)

> Could the old behavior be reinstated?

I see no big problem with this, but only for the "if (vm_dev->version ==
1)" case.

> We have an implementation that relies on knowing ahead of time what address
> range will be used, and is blind to memory accesses that occur before
> VIRTIO_MMIO_QUEUE_PFN is written to (or VIRTIO_MMIO_QUEUE_READY when we
> upgrade). Is such an implementation supported by the specification? We can't
> find any explicit mention that the driver is forbidden from writing to the
> memory region before VIRTIO_MMIO_QUEUE_READY is set to 1 (or
> VIRTIO_MMIO_QUEUE_PFN is set for legacy devices).

Hm. At the first glance I wouldn't expect the spec to impose such ban.
After all the driver is responsible for providing the ring memory, spec
doesn't care (or does it?) how is it coming into existence - it's the
guest's memory after all. Am I missing something obvious?

Pawel
