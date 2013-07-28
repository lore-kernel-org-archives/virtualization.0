From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Merge of "virtio_net: fix race in RX VQ processing" for
	linux-3.2.48
Date: Sun, 28 Jul 2013 10:11:56 +0300
Message-ID: <20130728071156.GD12087@redhat.com>
References: <u4ehb37a8w.fsf@md.dent.med.uni-muenchen.de>
	<1374936173.13555.19.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1374936173.13555.19.camel@deadeye.wl.decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>, "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 27, 2013 at 03:42:53PM +0100, Ben Hutchings wrote:
> On Fri, 2013-07-12 at 23:13 +0200, Wolfram Gloger wrote:
> > Hi,
> > 
> > Today I merged M. Tsirkin's patch v2 "virtio_net: fix race in RX VQ
> > processing":
> > 
> > http://lkml.indiana.edu/hypermail/linux/kernel/1307.1/00503.html
> > 
> > into 3.2.48 and lightly tested the result (vhost-net, virtio-disk
> > and 9pfs using virtio).
> 
> This sounds like it could be suitable for stable, but that doesn't seem
> to have been requested by the author.

It was in the cover letter:
"Please review, and consider for 3.11 and stable."

> I'm cc'ing those involved so they
> can make a decision whether this should be included in 3.2.y or other
> stable branches.
> > Merge is not completely trivial, so might save you some time, if only
> > for a comparison that you arrive at the same result.
> 
> Thanks, but these are not in quite the right patch format.  The
> filenames should always have a leading directory name which will be
> stripped (patch -p1).  The original patch header must be preserved and a
> reference to the upstream commit inserted e.g.
> 'commit 0123456789abcdef0123456789abcdef012345678 upstream.'
> 
> (Attachments copied for reference.)
> 
> Ben.
> 
> -- 
> Ben Hutchings
> Once a job is fouled up, anything done to improve it makes it worse.
> 

> --- drivers/virtio/virtio_ring.c.orig	2013-06-30 11:35:44.000000000 +0200
> +++ drivers/virtio/virtio_ring.c	2013-07-12 15:18:48.000000000 +0200
> @@ -360,9 +360,22 @@ void virtqueue_disable_cb(struct virtque
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> -bool virtqueue_enable_cb(struct virtqueue *_vq)
> +/**
> + * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks; it returns current queue state
> + * in an opaque unsigned value. This value should be later tested by
> + * virtqueue_poll, to detect a possible race between the driver checking for
> + * more work, and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 last_used_idx;
>  
>  	START_USE(vq);
>  
> @@ -372,15 +385,45 @@ bool virtqueue_enable_cb(struct virtqueu
>  	 * either clear the flags bit or point the event index at the next
>  	 * entry. Always do both to keep code simple. */
>  	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
> -	vring_used_event(&vq->vring) = vq->last_used_idx;
> +	vring_used_event(&vq->vring) = last_used_idx = vq->last_used_idx;
> +	END_USE(vq);
> +	return last_used_idx;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> +
> +/**
> + * virtqueue_poll - query pending used buffers
> + * @vq: the struct virtqueue we're talking about.
> + * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> + *
> + * Returns "true" if there are pending used buffers in the queue.
> + *
> + * This does not need to be serialized.
> + */
> +bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
>  	virtio_mb();
> -	if (unlikely(more_used(vq))) {
> -		END_USE(vq);
> -		return false;
> -	}
> +	return (u16)last_used_idx != vq->vring.used->idx;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> -	END_USE(vq);
> -	return true;
> +/**
> + * virtqueue_enable_cb - restart callbacks after disable_cb.
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks; it returns "false" if there are pending
> + * buffers in the queue, to detect a possible race between the driver
> + * checking for more work, and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +bool virtqueue_enable_cb(struct virtqueue *_vq)
> +{
> +	unsigned last_used_idx = virtqueue_enable_cb_prepare(_vq);
> +	return !virtqueue_poll(_vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
>  
> --- include/linux/virtio.h.orig	2012-01-05 00:55:44.000000000 +0100
> +++ include/linux/virtio.h	2013-07-12 14:42:26.000000000 +0200
> @@ -96,6 +96,10 @@ void virtqueue_disable_cb(struct virtque
>  
>  bool virtqueue_enable_cb(struct virtqueue *vq);
>  
> +unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> +
> +bool virtqueue_poll(struct virtqueue *vq, unsigned);
> +
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);

> --- drivers/net/virtio_net.c.orig	2012-01-05 00:55:44.000000000 +0100
> +++ drivers/net/virtio_net.c	2013-07-12 15:39:06.000000000 +0200
> @@ -508,7 +508,7 @@ static int virtnet_poll(struct napi_stru
>  {
>  	struct virtnet_info *vi = container_of(napi, struct virtnet_info, napi);
>  	void *buf;
> -	unsigned int len, received = 0;
> +	unsigned int r, len, received = 0;
>  
>  again:
>  	while (received < budget &&
> @@ -525,8 +525,9 @@ again:
>  
>  	/* Out of packets? */
>  	if (received < budget) {
> +		r = virtqueue_enable_cb_prepare(vi->rvq);
>  		napi_complete(napi);
> -		if (unlikely(!virtqueue_enable_cb(vi->rvq)) &&
> +		if (unlikely(virtqueue_poll(vi->rvq, r)) &&
>  		    napi_schedule_prep(napi)) {
>  			virtqueue_disable_cb(vi->rvq);
>  			__napi_schedule(napi);
