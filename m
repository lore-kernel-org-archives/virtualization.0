From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH] virtio: drop internal struct from UAPI
Date: Sat, 2 Feb 2019 12:04:40 +0800
Message-ID: <20190202040440.GA19948__6592.99878623045$1549163430$gmane$org@dpdk-tbie>
References: <20190201221553.7210-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190201221553.7210-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 01, 2019 at 05:16:01PM -0500, Michael S. Tsirkin wrote:
> There's no reason to expose struct vring_packed in UAPI - if we do we
> won't be able to change or drop it, and it's not part of any interface.
> 
> Let's move it to virtio_ring.c
> 
> Cc: Tiwei Bie <tiwei.bie@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c     |  7 ++++++-
>  include/uapi/linux/virtio_ring.h | 10 ----------
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 412e0c431d87..1c85b3423182 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -152,7 +152,12 @@ struct vring_virtqueue {
>  		/* Available for packed ring */
>  		struct {
>  			/* Actual memory layout for this queue. */
> -			struct vring_packed vring;
> +			struct {
> +				unsigned int num;
> +				struct vring_packed_desc *desc;
> +				struct vring_packed_desc_event *driver;
> +				struct vring_packed_desc_event *device;
> +			} vring;
>  
>  			/* Driver ring wrap counter. */
>  			bool avail_wrap_counter;
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 2414f8af26b3..4c4e24c291a5 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -213,14 +213,4 @@ struct vring_packed_desc {
>  	__le16 flags;
>  };
>  
> -struct vring_packed {
> -	unsigned int num;
> -
> -	struct vring_packed_desc *desc;
> -
> -	struct vring_packed_desc_event *driver;
> -
> -	struct vring_packed_desc_event *device;
> -};
> -
>  #endif /* _UAPI_LINUX_VIRTIO_RING_H */
> -- 
> MST

Acked-by: Tiwei Bie <tiwei.bie@intel.com>
