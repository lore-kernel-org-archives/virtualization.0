From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] mic: vop: Fix broken virtqueues
Date: Wed, 30 Jan 2019 20:40:23 +0100
Message-ID: <20190130194023.GB21181@kroah.com>
References: <20190130162809.14620-1-vincent.whitchurch@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190130162809.14620-1-vincent.whitchurch@axis.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, sudeep.dutt@intel.com, virtualization@lists.linux-foundation.org, ashutosh.dixit@intel.com, luto@kernel.org, Vincent Whitchurch <rabinv@axis.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 30, 2019 at 05:28:09PM +0100, Vincent Whitchurch wrote:
> VOP is broken in mainline since commit 1ce9e6055fa0a9043 ("virtio_ring:
> introduce packed ring support"); attempting to use the virtqueues leads
> to various kernel crashes.  I'm testing it with my not-yet-merged
> loopback patches, but even the in-tree MIC hardware cannot work.
> 
> The problem is not in the referenced commit per se, but is due to the
> following hack in vop_find_vq() which depends on the layout of private
> structures in other source files, which that commit happened to change:
> 
>   /*
>    * To reassign the used ring here we are directly accessing
>    * struct vring_virtqueue which is a private data structure
>    * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
>    * vring_new_virtqueue() would ensure that
>    *  (&vq->vring == (struct vring *) (&vq->vq + 1));
>    */
>   vr = (struct vring *)(vq + 1);
>   vr->used = used;
> 
> Fix vop by using __vring_new_virtqueue() to create the needed vring
> layout from the start, instead of attempting to patch in the used ring
> later.  __vring_new_virtqueue() was added way back in commit
> 2a2d1382fe9dcc ("virtio: Add improved queue allocation API") in order to
> address mic's usecase, according to the commit message.
> 
> The removal patch also has the hack and we need to save the used ring
> pointer separately to remove it.
> 
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v2: fix removal path also
> 
>  drivers/misc/mic/vop/vop_main.c | 69 +++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index b60b5ec4a28a..c4517703dc1d 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -48,7 +48,8 @@
>   * @dc: Virtio device control
>   * @vpdev: VOP device which is the parent for this virtio device
>   * @vr: Buffer for accessing the VRING
> - * @used: Buffer for used
> + * @used_virt: Virtual address of used ring
> + * @used: DMA address of used ring
>   * @used_size: Size of the used buffer
>   * @reset_done: Track whether VOP reset is complete
>   * @virtio_cookie: Cookie returned upon requesting a interrupt
> @@ -62,6 +63,7 @@ struct _vop_vdev {
>  	struct mic_device_ctrl __iomem *dc;
>  	struct vop_device *vpdev;
>  	void __iomem *vr[VOP_MAX_VRINGS];
> +	void *used_virt[VOP_MAX_VRINGS];
>  	dma_addr_t used[VOP_MAX_VRINGS];
>  	int used_size[VOP_MAX_VRINGS];
>  	struct completion reset_done;
> @@ -261,12 +263,12 @@ static bool vop_notify(struct virtqueue *vq)
>  static void vop_del_vq(struct virtqueue *vq, int n)
>  {
>  	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
> -	struct vring *vr = (struct vring *)(vq + 1);
>  	struct vop_device *vpdev = vdev->vpdev;
>  
>  	dma_unmap_single(&vpdev->dev, vdev->used[n],
>  			 vdev->used_size[n], DMA_BIDIRECTIONAL);
> -	free_pages((unsigned long)vr->used, get_order(vdev->used_size[n]));
> +	free_pages((unsigned long)vdev->used_virt[n],
> +		   get_order(vdev->used_size[n]));
>  	vring_del_virtqueue(vq);
>  	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
>  	vdev->vr[n] = NULL;
> @@ -284,6 +286,26 @@ static void vop_del_vqs(struct virtio_device *dev)
>  		vop_del_vq(vq, idx++);
>  }
>  
> +static struct virtqueue *vop_new_virtqueue(unsigned int index,
> +				      unsigned int num,
> +				      struct virtio_device *vdev,
> +				      bool context,
> +				      void *pages,
> +				      bool (*notify)(struct virtqueue *vq),
> +				      void (*callback)(struct virtqueue *vq),
> +				      const char *name,
> +				      void *used)
> +{
> +	bool weak_barriers = false;
> +	struct vring vring;
> +
> +	vring_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
> +	vring.used = used;
> +
> +	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> +				     notify, callback, name);
> +}
> +
>  /*
>   * This routine will assign vring's allocated in host/io memory. Code in
>   * virtio_ring.c however continues to access this io memory as if it were local
> @@ -303,7 +325,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  	struct _mic_vring_info __iomem *info;
>  	void *used;
>  	int vr_size, _vr_size, err, magic;
> -	struct vring *vr;
>  	u8 type = ioread8(&vdev->desc->type);
>  
>  	if (index >= ioread8(&vdev->desc->num_vq))
> @@ -322,17 +343,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		return ERR_PTR(-ENOMEM);
>  	vdev->vr[index] = va;
>  	memset_io(va, 0x0, _vr_size);
> -	vq = vring_new_virtqueue(
> -				index,
> -				le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN,
> -				dev,
> -				false,
> -				ctx,
> -				(void __force *)va, vop_notify, callback, name);
> -	if (!vq) {
> -		err = -ENOMEM;
> -		goto unmap;
> -	}
> +
>  	info = va + _vr_size;
>  	magic = ioread32(&info->magic);
>  
> @@ -341,18 +352,27 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		goto unmap;
>  	}
>  
> -	/* Allocate and reassign used ring now */
>  	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
>  					     sizeof(struct vring_used_elem) *
>  					     le16_to_cpu(config.num));
>  	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  					get_order(vdev->used_size[index]));
> +	vdev->used_virt[index] = used;
>  	if (!used) {
>  		err = -ENOMEM;
>  		dev_err(_vop_dev(vdev), "%s %d err %d\n",
>  			__func__, __LINE__, err);
> -		goto del_vq;
> +		goto unmap;
> +	}
> +
> +	vq = vop_new_virtqueue(index, le16_to_cpu(config.num), dev, ctx,
> +			       (void __force *)va, vop_notify, callback,
> +			       name, used);
> +	if (!vq) {
> +		err = -ENOMEM;
> +		goto free_used;
>  	}
> +
>  	vdev->used[index] = dma_map_single(&vpdev->dev, used,
>  					    vdev->used_size[index],
>  					    DMA_BIDIRECTIONAL);
> @@ -360,26 +380,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		err = -ENOMEM;
>  		dev_err(_vop_dev(vdev), "%s %d err %d\n",
>  			__func__, __LINE__, err);
> -		goto free_used;
> +		goto del_vq;
>  	}
>  	writeq(vdev->used[index], &vqconfig->used_address);
> -	/*
> -	 * To reassign the used ring here we are directly accessing
> -	 * struct vring_virtqueue which is a private data structure
> -	 * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
> -	 * vring_new_virtqueue() would ensure that
> -	 *  (&vq->vring == (struct vring *) (&vq->vq + 1));
> -	 */
> -	vr = (struct vring *)(vq + 1);
> -	vr->used = used;
>  
>  	vq->priv = vdev;
>  	return vq;
> +del_vq:
> +	vring_del_virtqueue(vq);
>  free_used:
>  	free_pages((unsigned long)used,
>  		   get_order(vdev->used_size[index]));
> -del_vq:
> -	vring_del_virtqueue(vq);
>  unmap:
>  	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
>  	return ERR_PTR(err);
> -- 
> 2.20.0

This patch is already in my tree, can you just send a "fixup" patch
instead of me  having to revert the old one and then adding this one
again?

thanks,

greg k-h
