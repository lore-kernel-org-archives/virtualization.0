From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 4/6] virtio_ring: virtqueue_add_outbuf /
	virtqueue_add_inbuf.
Date: Wed, 6 Mar 2013 16:37:30 +0800
Message-ID: <20130306083730.GB5281@hj.localdomain>
References: <87k3plaz3d.fsf@rustcorp.com.au> <877gllaypf.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <877gllaypf.fsf@rustcorp.com.au>
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
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2013 at 04:23:24PM +1100, Rusty Russell wrote:
> These are specialized versions of virtqueue_add_buf(), which cover
> over 80% of cases and are far clearer.
> 
> In particular, the scatterlists passed to these functions don't have
> to be clean (ie. we ignore end markers).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> 

So, what is the plan for the following ideas discussed in the other
thread?

   '''
   > Looking at code, it seems that most users really have a single sg, in
   > low memory. So how about simply passing void * instead of sg? Whoever
   > has multiple sgs can use the rich interface.
   
   Good point, let's do that:
   1) Make virtqueue_add_outbuf()/inbuf() take a void * and len.
   2) Transfer users across to use that.
   3) Make everyone else use clean scatterlists with virtqueue_add_sgs[].
   4) Remove virtqueue_add_bufs().

   '''
 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a78ad45..5217baf 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -366,6 +366,50 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
>  EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
>  
>  /**
> + * virtqueue_add_outbuf - expose output buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sgs: array of scatterlists (need not be terminated!)
> + * @num: the number of scatterlists readable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
> + */
> +int virtqueue_add_outbuf(struct virtqueue *vq,
> +			 struct scatterlist sg[], unsigned int num,
> +			 void *data,
> +			 gfp_t gfp)
> +{
> +	return virtqueue_add(vq, &sg, sg_next_arr, num, 0, 1, 0, data, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
> +
> +/**
> + * virtqueue_add_inbuf - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sgs: array of scatterlists (need not be terminated!)
> + * @num: the number of scatterlists writable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
> + */
> +int virtqueue_add_inbuf(struct virtqueue *vq,
> +			struct scatterlist sg[], unsigned int num,
> +			void *data,
> +			gfp_t gfp)
> +{
> +	return virtqueue_add(vq, &sg, sg_next_arr, 0, num, 0, 1, data, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
> +
> +/**
>   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
>   * @vq: the struct virtqueue
>   *
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 6eff15b..b442500 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -40,6 +40,16 @@ int virtqueue_add_buf(struct virtqueue *vq,
>  		      void *data,
>  		      gfp_t gfp);
>  
> +int virtqueue_add_outbuf(struct virtqueue *vq,
> +			 struct scatterlist sg[], unsigned int num,
> +			 void *data,
> +			 gfp_t gfp);
> +
> +int virtqueue_add_inbuf(struct virtqueue *vq,
> +			struct scatterlist sg[], unsigned int num,
> +			void *data,
> +			gfp_t gfp);
> +
>  int virtqueue_add_sgs(struct virtqueue *vq,
>  		      struct scatterlist *sgs[],
>  		      unsigned int out_sgs,
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
Asias
