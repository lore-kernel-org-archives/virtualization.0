From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC 1/5] drm/virtio: add virtio_gpu_alloc_fence()
Date: Tue, 13 Dec 2016 07:47:25 +0100
Message-ID: <1481611645.27088.56.camel__25709.5312969343$1481620488$gmane$org@redhat.com>
References: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gustavo Padovan <gustavo@padovan.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open
	list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, robdclark@gmail.com, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> +struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
> +{
> +	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
> +	struct virtio_gpu_fence *fence;
> +	unsigned long irq_flags;
> +
> +	fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
> +	if (!fence)
> +		return NULL;
> +

> +	spin_lock_irqsave(&drv->lock, irq_flags);
> +	fence->drv = drv;
> +	fence->seq = ++drv->sync_seq;
> +	dma_fence_init(&fence->f, &virtio_fence_ops, &drv->lock,
> +		       drv->context, fence->seq);
> +	spin_unlock_irqrestore(&drv->lock, irq_flags);

seq assignment ...

> +
> +	return fence;
> +}
> +
>  int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>  			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
> -			  struct virtio_gpu_fence **fence)
> +			  struct virtio_gpu_fence *fence)
>  {
>  	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
>  	unsigned long irq_flags;
>  
> -	*fence = kmalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
> -	if ((*fence) == NULL)
> -		return -ENOMEM;
> -
>  	spin_lock_irqsave(&drv->lock, irq_flags);
> -	(*fence)->drv = drv;
> -	(*fence)->seq = ++drv->sync_seq;
> -	dma_fence_init(&(*fence)->f, &virtio_fence_ops, &drv->lock,
> -		       drv->context, (*fence)->seq);

... must stay here.  Otherwise requests can be submitted to the virt
queue with fence sequence numbers out of order.

cheers,
  Gerd
