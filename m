From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Wed, 07 Dec 2011 16:02:45 +0200
Message-ID: <1323266565.4009.10.camel@lappy>
References: <4ED4F30F.8000603@redhat.com> <1322669511.3985.8.camel@lappy>
	<87wrahrp0u.fsf@rustcorp.com.au> <20111201075847.GA5479@redhat.com>
	<1322726977.3259.3.camel@lappy> <20111201102640.GB8822@redhat.com>
	<87zkfbre9x.fsf@rustcorp.com.au> <1322913028.3782.4.camel@lappy>
	<4EDB5EF0.2010909@redhat.com> <1323000831.4205.4.camel@lappy>
	<20111204162221.GB22501@redhat.com> <1323020088.3256.3.camel@lappy>
	<4EDBAFC5.2010405@redhat.com> <1323020374.3256.5.camel@lappy>
	<1323023039.3256.7.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323023039.3256.7.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2011-12-04 at 20:23 +0200, Sasha Levin wrote:

[snip]

Rusty, Michael, does the below looks a reasonable optimization for you?
should I send it as a patch?

> Something like the following patch:
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c7a2c20..3166ca0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -82,6 +82,7 @@ struct vring_virtqueue
>  
>  	/* Host supports indirect buffers */
>  	bool indirect;
> +	struct kmem_cache *indirect_cache;
>  
>  	/* Host publishes avail event idx */
>  	bool event;
> @@ -110,6 +111,9 @@ struct vring_virtqueue
>  
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>  
> +static unsigned int ind_alloc_thresh = 0;
> +module_param(ind_alloc_thresh, uint, S_IRUGO);
> +
>  /* Set up an indirect table of descriptors and add it to the queue. */
>  static int vring_add_indirect(struct vring_virtqueue *vq,
>  			      struct scatterlist sg[],
> @@ -121,7 +125,10 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
>  	unsigned head;
>  	int i;
>  
> -	desc = kmalloc((out + in) * sizeof(struct vring_desc), gfp);
> +	if ((out + in) <= ind_alloc_thresh)
> +		desc = kmem_cache_alloc(vq->indirect_cache, gfp);
> +	else
> +		desc = kmalloc((out + in) * sizeof(struct vring_desc), gfp);
>  	if (!desc)
>  		return -ENOMEM;
>  
> @@ -479,6 +486,9 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
>  	vq->num_added = 0;
> +	if (ind_alloc_thresh)
> +		vq->indirect_cache = KMEM_CACHE(vring_desc[ind_alloc_thresh], 0);
>  	list_add_tail(&vq->vq.list, &vdev->vqs);
>  #ifdef DEBUG
>  	vq->in_use = false;
> 

-- 

Sasha.
