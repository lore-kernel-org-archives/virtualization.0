From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 7/7] tools/virtio: Make --reset reset ring idx
Date: Thu, 2 Apr 2020 09:27:37 -0400
Message-ID: <20200402092529-mutt-send-email-mst@kernel.org>
References: <20200401183118.8334-1-eperezma@redhat.com>
 <20200401183118.8334-8-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401183118.8334-8-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 01, 2020 at 08:31:18PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

I'm still a bit puzzled by this one - could you
explain what the rationale here is?

> ---
>  drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
>  tools/virtio/linux/virtio.h  |  2 ++
>  tools/virtio/virtio_test.c   | 28 +++++++++++++++++++++++++++-
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58b96baa8d48..f9153a381f72 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1810,6 +1810,35 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>  
> +#ifndef __KERNEL__
> +
> +/**
> + * virtqueue_reset_free_head - Reset to 0 the members of split ring.
> + * @vq: Virtqueue to reset.
> + *
> + * At this moment, is only meant for debug the ring index change, do not use
> + * in production.
> + */
> +void virtqueue_reset_free_head(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	// vq->last_used_idx = 0;
> +	vq->num_added = 0;
> +
> +	vq->split.queue_size_in_bytes = 0;
> +	vq->split.avail_flags_shadow = 0;
> +	vq->split.avail_idx_shadow = 0;
> +
> +	memset(vq->split.desc_state, 0, vq->split.vring.num *
> +			sizeof(struct vring_desc_state_split));
> +
> +	vq->free_head = 0;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_reset_free_head);
> +
> +#endif
> +
>  /**
>   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue
> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
> index b751350d4ce8..5d33eab6b814 100644
> --- a/tools/virtio/linux/virtio.h
> +++ b/tools/virtio/linux/virtio.h
> @@ -65,4 +65,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      const char *name);
>  void vring_del_virtqueue(struct virtqueue *vq);
>  
> +void virtqueue_reset_free_head(struct virtqueue *vq);
> +
>  #endif
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 93d81cd64ba0..bf21ece30594 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -49,6 +49,7 @@ struct vdev_info {
>  
>  static const struct vhost_vring_file no_backend = { .fd = -1 },
>  				     backend = { .fd = 1 };
> +static const struct vhost_vring_state null_state = {};
>  
>  bool vq_notify(struct virtqueue *vq)
>  {
> @@ -218,10 +219,33 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  			}
>  
>  			if (reset) {
> +				struct vhost_vring_state s = { .index = 0 };
> +				int i;
> +				vq->vring.avail->idx = 0;
> +				vq->vq->num_free = vq->vring.num;
> +
> +				// Put everything in free lists.
> +				for (i = 0; i < vq->vring.num-1; i++)
> +					vq->vring.desc[i].next =
> +						cpu_to_virtio16(&dev->vdev,
> +								i + 1);
> +				vq->vring.desc[vq->vring.num-1].next = 0;


Poking at vq descriptors like this seems fragile.
I think this calls for a better API that handles everything
internally.


> +				virtqueue_reset_free_head(vq->vq);
> +
> +				r = ioctl(dev->control, VHOST_GET_VRING_BASE,
> +					  &s);
> +				assert(!r);
> +
> +				s.num = 0;
> +				r = ioctl(dev->control, VHOST_SET_VRING_BASE,
> +					  &null_state);
> +				assert(!r);
> +
>  				r = ioctl(dev->control, VHOST_TEST_SET_BACKEND,
>  					  &backend);
>  				assert(!r);
>  
> +				started = completed;
>                                  while (completed > next_reset)
>  					next_reset += completed;
>  			}
> @@ -243,7 +267,9 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	test = 0;
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
> -	fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
> +	fprintf(stderr,
> +		"spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
> +		spurious, started, completed);
>  }
>  
>  const char optstring[] = "h";
> -- 
> 2.18.1
