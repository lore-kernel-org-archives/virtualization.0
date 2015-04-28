From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v2] virtio-mmio: Update the device to OASIS spec version
Date: Tue, 28 Apr 2015 17:06:16 -0400
Message-ID: <553FF648.2020003@codeaurora.org>
References: <1421777531-15180-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1421777531-15180-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 01/20/2015 01:12 PM, Pawel Moll wrote:

> @@ -356,13 +346,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  		info->num /= 2;
>  	}
>  
> -	/* Activate the queue */
> -	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> -	writel(VIRTIO_MMIO_VRING_ALIGN,
> -			vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> -	writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> -			vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> -
>  	/* Create the vring */
>  	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN, vdev,
>  				 true, info->queue, vm_notify, callback, name);
> @@ -371,6 +354,33 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  		goto error_new_virtqueue;
>  	}
>  
> +	/* Activate the queue */
> +	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> +	if (vm_dev->version == 1) {
> +		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> +		writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	} else {
> +		u64 addr;
> +
> +		addr = virt_to_phys(info->queue);
> +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
> +		writel((u32)(addr >> 32),
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
> +
> +		addr = virt_to_phys(virtqueue_get_avail(vq));
> +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
> +		writel((u32)(addr >> 32),
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
> +
> +		addr = virt_to_phys(virtqueue_get_used(vq));
> +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
> +		writel((u32)(addr >> 32),
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
> +
> +		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
> +	}
> +
>  	vq->priv = info;
>  	info->vq = vq;

This patch moved the call to vring_new_virtqueue() in the legacy code flow
before the VIRTIO_MMIO_QUEUE_NUM, VIRTIO_MMIO_QUEUE_ALIGN, and
VIRTIO_MMIO_QUEUE_PFN writes. Was this intentional? Could the old behavior be
reinstated?

We have an implementation that relies on knowing ahead of time what address
range will be used, and is blind to memory accesses that occur before
VIRTIO_MMIO_QUEUE_PFN is written to (or VIRTIO_MMIO_QUEUE_READY when we
upgrade). Is such an implementation supported by the specification? We can't
find any explicit mention that the driver is forbidden from writing to the
memory region before VIRTIO_MMIO_QUEUE_READY is set to 1 (or
VIRTIO_MMIO_QUEUE_PFN is set for legacy devices).

Thanks,
Chris

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
