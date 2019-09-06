From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: fix unmap of indirect descriptors
Date: Fri, 6 Sep 2019 10:02:55 -0400
Message-ID: <20190906095904-mutt-send-email-mst@kernel.org>
References: <20190906120659.4545-1-matthias.lange@kernkonzept.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190906120659.4545-1-matthias.lange@kernkonzept.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthias Lange <matthias.lange@kernkonzept.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 06, 2019 at 02:06:59PM +0200, Matthias Lange wrote:
> The function virtqueue_add_split() DMA-maps the scatterlist buffers. In
> case a mapping error occurs the already mapped buffers must be unmapped.
> This happens by jumping to the 'unmap_release' label.
> 
> In case of indirect descriptors the release is wrong and may leak kernel
> memory. Because the implementation assumes that the head descriptor is
> already mapped it starts iterating over the descriptor list starting
> from the head descriptor. However for indirect descriptors the head
> descriptor is never mapped in case of an error.
> 
> The fix is to initialize the start index with zero in case of indirect
> descriptors and use the 'desc' pointer directly for iterating over the
> descriptor chain.
> 
> This fix also changes the return code from EIO to ENOSPC in case of a
> mapping error. The reason is that drivers such as virtio_blk may retry
> their request and thus can recover from a mapping error.
> 
> Signed-off-by: Matthias Lange <matthias.lange@kernkonzept.com>

Thanks for the patch!

However please, split this to 2 patches.
I think the 1st patch at least is a stable candidate.

About the return code part - could you please add a bit more explanation
in the commit log? E.g. document when does it trigger and what is the
effect of the fix.  Thanks!

> ---
>  drivers/virtio/virtio_ring.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8be1c4f5b55..d2e001f92e6e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -566,13 +566,17 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  
>  unmap_release:
>  	err_idx = i;
> -	i = head;
> +
> +	if (indirect)
> +		i = 0;
> +	else
> +		i = head;
>  
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
>  		vring_unmap_one_split(vq, &desc[i]);
> -		i = virtio16_to_cpu(_vq->vdev, vq->split.vring.desc[i].next);
> +		i = virtio16_to_cpu(_vq->vdev, desc[i].next);
>  	}
>  
>  	if (indirect)
> @@ -1081,7 +1085,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	kfree(desc);
>  
>  	END_USE(vq);
> -	return -EIO;
> +	return -ENOSPC;
>  }
>  
>  static inline int virtqueue_add_packed(struct virtqueue *_vq,
> -- 
> 2.17.1
