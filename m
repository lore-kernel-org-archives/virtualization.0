From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add event idx support in
	packed ring
Date: Fri, 7 Sep 2018 10:10:14 -0400
Message-ID: <20180907100341-mutt-send-email-mst__24463.5052666583$1536329764$gmane$org@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
	<20180711022711.7090-5-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-5-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 11, 2018 at 10:27:10AM +0800, Tiwei Bie wrote:
> This commit introduces the EVENT_IDX support in packed ring.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

Besides the usual comment about hard-coded constants like <<15:
does this actually do any good for performance? We don't
have to if we do not want to.

> ---
>  drivers/virtio/virtio_ring.c | 73 ++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f317b485ba54..f79a1e17f7d1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1050,7 +1050,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 flags;
> +	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
>  	bool needs_kick;
>  	u32 snapshot;
>  
> @@ -1059,9 +1059,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  	 * suppressions. */
>  	virtio_mb(vq->weak_barriers);
>  
> +	old = vq->next_avail_idx - vq->num_added;
> +	new = vq->next_avail_idx;
> +	vq->num_added = 0;
> +
>  	snapshot = READ_ONCE(*(u32 *)vq->vring_packed.device);
> +	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
>  	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;


some kind of struct union would be helpful to make this readable.

>  
> +	wrap_counter = off_wrap >> 15;
> +	event_idx = off_wrap & ~(1 << 15);
> +	if (wrap_counter != vq->avail_wrap_counter)
> +		event_idx -= vq->vring_packed.num;
> +
>  #ifdef DEBUG
>  	if (vq->last_add_time_valid) {
>  		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
> @@ -1070,7 +1080,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  	vq->last_add_time_valid = false;
>  #endif
>  
> -	needs_kick = (flags != VRING_EVENT_F_DISABLE);
> +	if (flags == VRING_EVENT_F_DESC)
> +		needs_kick = vring_need_event(event_idx, new, old);
> +	else
> +		needs_kick = (flags != VRING_EVENT_F_DISABLE);
>  	END_USE(vq);
>  	return needs_kick;
>  }
> @@ -1185,6 +1198,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	ret = vq->desc_state_packed[id].data;
>  	detach_buf_packed(vq, id, ctx);
>  
> +	/* If we expect an interrupt for the next entry, tell host
> +	 * by writing event index and flush out the write before
> +	 * the read in the next get_buf call. */
> +	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
> +		virtio_store_mb(vq->weak_barriers,
> +				&vq->vring_packed.driver->off_wrap,
> +				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
> +					((u16)vq->used_wrap_counter << 15)));
> +
>  #ifdef DEBUG
>  	vq->last_add_time_valid = false;
>  #endif
> @@ -1213,8 +1235,18 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  	/* We optimistically turn back on interrupts, then check if there was
>  	 * more to do. */
>  
> +	if (vq->event) {
> +		vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> +				vq->last_used_idx |
> +				((u16)vq->used_wrap_counter << 15));
> +		/* We need to update event offset and event wrap
> +		 * counter first before updating event flags. */
> +		virtio_wmb(vq->weak_barriers);
> +	}
> +
>  	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> +						     VRING_EVENT_F_ENABLE;
>  		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>  							vq->event_flags_shadow);
>  	}
> @@ -1238,22 +1270,47 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned off_wrap)
>  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 bufs, used_idx, wrap_counter;
>  
>  	START_USE(vq);
>  
>  	/* We optimistically turn back on interrupts, then check if there was
>  	 * more to do. */
>  
> +	if (vq->event) {
> +		/* TODO: tune this threshold */
> +		bufs = (vq->vring_packed.num - _vq->num_free) * 3 / 4;
> +		wrap_counter = vq->used_wrap_counter;
> +
> +		used_idx = vq->last_used_idx + bufs;
> +		if (used_idx >= vq->vring_packed.num) {
> +			used_idx -= vq->vring_packed.num;
> +			wrap_counter ^= 1;
> +		}
> +
> +		vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> +				used_idx | (wrap_counter << 15));
> +
> +		/* We need to update event offset and event wrap
> +		 * counter first before updating event flags. */
> +		virtio_wmb(vq->weak_barriers);
> +	} else {
> +		used_idx = vq->last_used_idx;
> +		wrap_counter = vq->used_wrap_counter;
> +	}
> +
>  	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> +						     VRING_EVENT_F_ENABLE;
>  		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>  							vq->event_flags_shadow);
> -		/* We need to enable interrupts first before re-checking
> -		 * for more used buffers. */
> -		virtio_mb(vq->weak_barriers);
>  	}
>  
> -	if (more_used_packed(vq)) {
> +	/* We need to update event suppression structure first
> +	 * before re-checking for more used buffers. */
> +	virtio_mb(vq->weak_barriers);
> +

mb is expensive. We should not do it if we changed nothing.

> +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
>  		END_USE(vq);
>  		return false;
>  	}
> -- 
> 2.18.0
