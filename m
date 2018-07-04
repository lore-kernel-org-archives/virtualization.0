From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH net-next 6/8] virtio: introduce packed ring defines
Date: Wed, 4 Jul 2018 12:48:23 +0800
Message-ID: <20180704044823.GA22808@debian>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
	<1530596284-4101-7-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1530596284-4101-7-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 03, 2018 at 01:38:02PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/uapi/linux/virtio_config.h |  2 ++
>  include/uapi/linux/virtio_ring.h   | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 449132c..947f6a3 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -75,6 +75,8 @@
>   */
>  #define VIRTIO_F_IOMMU_PLATFORM		33
>  
> +#define VIRTIO_F_RING_PACKED		34

It's better to add some comments for this macro.

> +
>  /*
>   * Does the device support Single Root I/O Virtualization?
>   */
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 6d5d5fa..71c7a46 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -43,6 +43,8 @@
>  #define VRING_DESC_F_WRITE	2
>  /* This means the buffer contains a list of buffer descriptors. */
>  #define VRING_DESC_F_INDIRECT	4
> +#define VRING_DESC_F_AVAIL      7

It's better to use tab between VRING_DESC_F_AVAIL and 7.

> +#define VRING_DESC_F_USED	15

Maybe it's better to define VRING_DESC_F_AVAIL and
VRING_DESC_F_USED as (1 << 7) and (1 << 15) or something
similar to make them consistent with VRING_DESC_F_NEXT
(1 << 0), VRING_DESC_F_WRITE (1 << 1) and
VRING_DESC_F_INDIRECT (1 << 2).

I plan to define below macros in virtio_ring.c:

#define _VRING_DESC_F_AVAIL(b)  ((__u16)(b) << 7)
#define _VRING_DESC_F_USED(b)   ((__u16)(b) << 15)

>  
>  /* The Host uses this in used->flags to advise the Guest: don't kick me when
>   * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> @@ -62,6 +64,36 @@
>   * at the end of the used ring. Guest should ignore the used->flags field. */
>  #define VIRTIO_RING_F_EVENT_IDX		29
>  
> +struct vring_desc_packed {

We may have other related types named as:

struct vring_packed;
struct vring_packed_desc_event;

So maybe it's better to name this type as:

struct vring_packed_desc;

> +	/* Buffer Address. */
> +	__virtio64 addr;
> +	/* Buffer Length. */
> +	__virtio32 len;
> +	/* Buffer ID. */
> +	__virtio16 id;
> +	/* The flags depending on descriptor type. */
> +	__virtio16 flags;
> +};
> +
> +/* Enable events */
> +#define RING_EVENT_FLAGS_ENABLE 0x0
> +/* Disable events */
> +#define RING_EVENT_FLAGS_DISABLE 0x1
> +/*
> + * Enable events for a specific descriptor
> + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> + * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
> + */
> +#define RING_EVENT_FLAGS_DESC 0x2

For above three macros, maybe it's better to name
them as:

VRING_EVENT_FLAGS_ENABLE
VRING_EVENT_FLAGS_DISABLE
VRING_EVENT_FLAGS_DESC

or

VRING_EVENT_F_ENABLE
VRING_EVENT_F_DISABLE
VRING_EVENT_F_DESC

VRING_EVENT_F_* will be more consistent with
VIRTIO_F_*, VRING_DESC_F_*, etc

> +/* The value 0x3 is reserved */
> +
> +struct vring_packed_desc_event {
> +	/* Descriptor Ring Change Event Offset and Wrap Counter */
> +	__virtio16 off_wrap;
> +	/* Descriptor Ring Change Event Flags */
> +	__virtio16 flags;
> +};
> +
>  /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
>  struct vring_desc {
>  	/* Address (guest-physical). */
> -- 
> 2.7.4
> 
