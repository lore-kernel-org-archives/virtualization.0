From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: Shadow available ring flags & index
Date: Wed, 11 Nov 2015 14:34:33 +0200
Message-ID: <20151111142647-mutt-send-email-mst__28408.420031383$1447245299$gmane$org@redhat.com>
References: <1447201267-30024-1-git-send-email-venkateshs@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1447201267-30024-1-git-send-email-venkateshs@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Venkatesh Srinivas <venkateshs@google.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, vsrinivas@ops101.org, luto@kernel.org, dmatlack@google.com, pbonzini@redhat.com, huawei.xie@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 10, 2015 at 04:21:07PM -0800, Venkatesh Srinivas wrote:
> Improves cacheline transfer flow of available ring header.
> 
> Virtqueues are implemented as a pair of rings, one producer->consumer
> avail ring and one consumer->producer used ring; preceding the
> avail ring in memory are two contiguous u16 fields -- avail->flags
> and avail->idx. A producer posts work by writing to avail->idx and
> a consumer reads avail->idx.
> 
> The flags and idx fields only need to be written by a producer CPU
> and only read by a consumer CPU; when the producer and consumer are
> running on different CPUs and the virtio_ring code is structured to
> only have source writes/sink reads, we can continuously transfer the
> avail header cacheline between 'M' states between cores. This flow
> optimizes core -> core bandwidth on certain CPUs.
> 
> (see: "Software Optimization Guide for AMD Family 15h Processors",
> Section 11.6; similar language appears in the 10h guide and should
> apply to CPUs w/ exclusive caches, using LLC as a transfer cache)
> 
> Unfortunately the existing virtio_ring code issued reads to the
> avail->idx and read-modify-writes to avail->flags on the producer.
> 
> This change shadows the flags and index fields in producer memory;
> the vring code now reads from the shadows and only ever writes to
> avail->flags and avail->idx, allowing the cacheline to transfer
> core -> core optimally.

Sounds logical, I'll apply this after a  bit of testing
of my own, thanks!

> In a concurrent version of vring_bench, the time required for
> 10,000,000 buffer checkout/returns was reduced by ~2% (average
> across many runs) on an AMD Piledriver (15h) CPU:
> 
> (w/o shadowing):
>  Performance counter stats for './vring_bench':
>      5,451,082,016      L1-dcache-loads
>      ...
>        2.221477739 seconds time elapsed
> 
> (w/ shadowing):
>  Performance counter stats for './vring_bench':
>      5,405,701,361      L1-dcache-loads
>      ...
>        2.168405376 seconds time elapsed

Could you supply the full command line you used
to test this?

> The further away (in a NUMA sense) virtio producers and consumers are
> from each other, the more we expect to benefit. Physical implementations
> of virtio devices and implementations of virtio where the consumer polls
> vring avail indexes (vhost) should also benefit.
> 
> Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>

Here's a similar patch for the ring itself:
https://lkml.org/lkml/2015/9/10/111

Does it help you as well?


> ---
>  drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 096b857..6262015 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -80,6 +80,12 @@ struct vring_virtqueue {
>  	/* Last used index we've seen. */
>  	u16 last_used_idx;
>  
> +	/* Last written value to avail->flags */
> +	u16 avail_flags_shadow;
> +
> +	/* Last written value to avail->idx in guest byte order */
> +	u16 avail_idx_shadow;
> +
>  	/* How to notify other side. FIXME: commonalize hcalls! */
>  	bool (*notify)(struct virtqueue *vq);
>  
> @@ -235,13 +241,14 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
> -	avail = virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) & (vq->vring.num - 1);
> +	avail = vq->avail_idx_shadow & (vq->vring.num - 1);
>  	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>  
>  	/* Descriptors and available array need to be set before we expose the
>  	 * new available array entries. */
>  	virtio_wmb(vq->weak_barriers);
> -	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) + 1);
> +	vq->avail_idx_shadow++;
> +	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
>  	vq->num_added++;
>  
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -354,8 +361,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  	 * event. */
>  	virtio_mb(vq->weak_barriers);
>  
> -	old = virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) - vq->num_added;
> -	new = virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx);
> +	old = vq->avail_idx_shadow - vq->num_added;
> +	new = vq->avail_idx_shadow;
>  	vq->num_added = 0;
>  
>  #ifdef DEBUG
> @@ -510,7 +517,7 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->vring.avail->flags & cpu_to_virtio16(_vq->vdev, VRING_AVAIL_F_NO_INTERRUPT))) {
> +	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx);
>  		virtio_mb(vq->weak_barriers);
>  	}
> @@ -537,7 +544,11 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	vq->vring.avail->flags |= cpu_to_virtio16(_vq->vdev, VRING_AVAIL_F_NO_INTERRUPT);
> +	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> +		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +		vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> +	}
> +
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> @@ -565,7 +576,10 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
>  	 * either clear the flags bit or point the event index at the next
>  	 * entry. Always do both to keep code simple. */
> -	vq->vring.avail->flags &= cpu_to_virtio16(_vq->vdev, ~VRING_AVAIL_F_NO_INTERRUPT);
> +	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> +		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> +		vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> +	}
>  	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
>  	END_USE(vq);
>  	return last_used_idx;
> @@ -633,9 +647,12 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
>  	 * either clear the flags bit or point the event index at the next
>  	 * entry. Always do both to keep code simple. */
> -	vq->vring.avail->flags &= cpu_to_virtio16(_vq->vdev, ~VRING_AVAIL_F_NO_INTERRUPT);
> +	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> +		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> +		vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> +	}
>  	/* TODO: tune this threshold */
> -	bufs = (u16)(virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) - vq->last_used_idx) * 3 / 4;
> +	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
>  	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs);
>  	virtio_mb(vq->weak_barriers);
>  	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
> @@ -670,7 +687,8 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  		/* detach_buf clears data, so grab it now. */
>  		buf = vq->data[i];
>  		detach_buf(vq, i);
> -		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) - 1);
> +		vq->avail_idx_shadow--;
> +		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
>  		END_USE(vq);
>  		return buf;
>  	}
> @@ -735,6 +753,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> +	vq->avail_flags_shadow = 0;
> +	vq->avail_idx_shadow = 0;
>  	vq->num_added = 0;
>  	list_add_tail(&vq->vq.list, &vdev->vqs);
>  #ifdef DEBUG
> @@ -746,8 +766,10 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>  
>  	/* No callback?  Tell other side not to bother us. */
> -	if (!callback)
> -		vq->vring.avail->flags |= cpu_to_virtio16(vdev, VRING_AVAIL_F_NO_INTERRUPT);
> +	if (!callback) {
> +		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +		vq->vring.avail->flags = cpu_to_virtio16(vdev, vq->avail_flags_shadow);
> +	}
>  
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
> -- 
> 2.6.0.rc2.230.g3dd15c0
