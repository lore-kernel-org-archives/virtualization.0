From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: fix packed ring event may missing
Date: Sun, 27 Oct 2019 05:51:31 -0400
Message-ID: <20191027051015-mutt-send-email-mst@kernel.org>
References: <20191021171004.18729-1-yong.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191021171004.18729-1-yong.liu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marvin Liu <yong.liu@intel.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 22, 2019 at 01:10:04AM +0800, Marvin Liu wrote:
> When callback is delayed, virtio expect that vhost will kick when
> rolling over event offset. Recheck should be taken as used index may
> exceed event offset between status check and driver event update.
> 
> However, it is possible that flags was not modified if descriptors are
> chained or in_order feature was negotiated. So flags at event offset
> may not be valid for descriptor's status checking. Fix it by using last
> used index as replacement. Tx queue will be stopped if there's not
> enough freed buffers after recheck.
> 
> Signed-off-by: Marvin Liu <yong.liu@intel.com>

OK I rewrote the commit log slightly:
	When VIRTIO_F_RING_EVENT_IDX is negotiated, virtio devices can
use virtqueue_enable_cb_delayed_packed to reduce the number of device
interrupts.  At the moment, this is the case for virtio-net when
the napi_tx module parameter is set to false.

In this case, the virtio driver selects an event offset in the ring and expects
that the device will send a notification when rolling over the event
offset in the ring.  However, if this roll-over happens before the event
suppression structure update, the notification won't be sent. To address
this race condition the driver needs to check wether the
device rolled over this offset after updating the event suppression structure.

With VIRTIO_F_RING_PACKED, the virtio driver did this by reading the the
flags field at the specified offset in the descriptor.

	Unfortunately, checking at the event offset isn't reliable: if
descriptors are chained (e.g. when INDIRECT is off) not all descriptors
are overwritten by the device, so it's possible that the device skipped
the specific descriptor driver is checking when writing out used
descriptors. If this happens, the driver won't detect the race condition and will
incorrectly expect the device to send a notification.

For virtio-net, the result will be TX queue stall, and transmission
getting blocked forever.

	With the packed ring, it isn't easy to find a location which is
guaranteed to change upon the roll-over, except the next device
descriptor, as described in the spec:

	Writes of device and driver descriptors can generally be
	reordered, but each side (driver and device) are only required to
	poll (or test) a single location in memory: the next device descriptor after
	the one they processed previously, in circular order.

while this might be sub-optimal, let's do exactly this for now.

And applied this.

Thanks a lot for working on this, and sorry again for not understanding
the patch originally and thinking it was not tested!

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index bdc08244a648..a8041e451e9e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1499,9 +1499,6 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  		 * counter first before updating event flags.
>  		 */
>  		virtio_wmb(vq->weak_barriers);
> -	} else {
> -		used_idx = vq->last_used_idx;
> -		wrap_counter = vq->packed.used_wrap_counter;
>  	}
>  
>  	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
> @@ -1518,7 +1515,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	 */
>  	virtio_mb(vq->weak_barriers);
>  
> -	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> +	if (is_used_desc_packed(vq,
> +				vq->last_used_idx,
> +				vq->packed.used_wrap_counter)) {
>  		END_USE(vq);
>  		return false;
>  	}
> -- 
> 2.17.1
