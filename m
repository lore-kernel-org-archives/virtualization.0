From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Date: Thu, 3 May 2018 20:57:20 +0300
Message-ID: <20180503203108-mutt-send-email-mst__9739.51522396437$1525370141$gmane$org@kernel.org>
References: <20180503025955.28816-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180503025955.28816-1-tiwei.bie@intel.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, zhihong.wang@intel.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
> This patch introduces the support for VIRTIO_F_IO_BARRIER.
> When this feature is negotiated, driver will use the barriers
> suitable for hardware devices.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

Thanks!

> ---
>  drivers/virtio/virtio_ring.c       | 5 +++++
>  include/uapi/linux/virtio_config.h | 8 +++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 21d464a29cf8..edb565643bf4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -996,6 +996,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>  
> +	if (virtio_has_feature(vdev, VIRTIO_F_IO_BARRIER))
> +		vq->weak_barriers = false;
> +
>  	/* No callback?  Tell other side not to bother us. */
>  	if (!callback) {
>  		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;

One issue worth looking at is that at least on Intel strong barriers are
actually typically overkill.  We should probably switch weak_barriers ==
false case over to dma barriers.

> @@ -1164,6 +1167,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_IOMMU_PLATFORM:
>  			break;
> +		case VIRTIO_F_IO_BARRIER:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 308e2096291f..6ca8d24bf468 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h

Any virtio UAPI changes must be CC'd to one of the virtio TC mailing lists
(subscriber-only, sorry about that).

> @@ -49,7 +49,7 @@
>   * transport being used (eg. virtio_ring), the rest are per-device feature
>   * bits. */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		34
> +#define VIRTIO_TRANSPORT_F_END		38
>  
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -71,4 +71,10 @@
>   * this is for compatibility with legacy systems.
>   */
>  #define VIRTIO_F_IOMMU_PLATFORM		33
> +
> +/*
> + * If clear - driver may use barriers suitable for CPU cores.
> + * If set - driver must use barriers suitable for hardware devices.
> + */
> +#define VIRTIO_F_IO_BARRIER		37
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */

Why 37? I'd use 34 I think.

> -- 
> 2.11.0
