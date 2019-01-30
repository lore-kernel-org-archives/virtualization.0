From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH] mic: vop: Fix broken virtqueues
Date: Wed, 30 Jan 2019 08:29:57 -0800
Message-ID: <1548865797.29684.47.camel__10319.5298508339$1548873340$gmane$org@intel.com>
References: <20190129102207.9577-1-vincent.whitchurch@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190129102207.9577-1-vincent.whitchurch@axis.com>
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
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, Sudeep Dutt <sudeep.dutt@intel.com>, virtualization@lists.linux-foundation.org, ashutosh.dixit@intel.com, luto@kernel.org, linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2019-01-29 at 11:22 +0100, Vincent Whitchurch wrote:
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

Thank you for fixing this up Vincent.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/misc/mic/vop/vop_main.c | 60 +++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index d2b9782eee87..fef45bf6d519 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -284,6 +284,26 @@ static void vop_del_vqs(struct virtio_device *dev)
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
> @@ -303,7 +323,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  	struct _mic_vring_info __iomem *info;
>  	void *used;
>  	int vr_size, _vr_size, err, magic;
> -	struct vring *vr;
>  	u8 type = ioread8(&vdev->desc->type);
>  
>  	if (index >= ioread8(&vdev->desc->num_vq))
> @@ -322,17 +341,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
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
> @@ -341,7 +350,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		goto unmap;
>  	}
>  
> -	/* Allocate and reassign used ring now */
>  	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
>  					     sizeof(struct vring_used_elem) *
>  					     le16_to_cpu(config.num));
> @@ -351,8 +359,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
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
> @@ -360,26 +377,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
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
