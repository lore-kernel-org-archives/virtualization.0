From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC] virtio 1.0 vring endian-ness
Date: Wed, 22 Oct 2014 10:24:17 +0200
Message-ID: <20141022102417.24cb2525.cornelia.huck@de.ibm.com>
References: <20141021220940.GA17704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141021220940.GA17704@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 22 Oct 2014 01:09:40 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This adds wrappers to switch between native endian-ness
> (virtio 0.9) and virtio endian-ness (virtio 1.0).
> Add new typedefs as well, so that we can check
> statically that we didn't miss any accesses.
> All callers simply pass in false (0.9) so no
> functional change for now.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> Sending this early so I can get feedback on this style.

Hm...

http://marc.info/?l=linux-virtualization&m=141270444612625&w=2

(and other in that series. Forgot to cc: you on those patches...)

> Rusty, what's your opinion? Reasonable?
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 67e06fe..32211aa 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -62,6 +62,26 @@ static inline void virtio_wmb(bool weak_barriers)
>  }
>  #endif
> 
> +#define DEFINE_VIRTIO_XX_TO_CPU(bits) \
> +static inline u##bits virtio##bits##_to_cpu(bool little_endian, __virtio##bits val) \
> +{ \
> +	if (little_endian) \
> +		return le##bits##_to_cpu((__force __le##bits)val); \
> +	else \
> +		return (__force u##bits)val; \
> +} \
> +static inline __virtio##bits cpu_to_virtio##bits(bool little_endian, u##bits val) \
> +{ \
> +	if (little_endian) \
> +		return (__force __virtio##bits)cpu_to_le##bits(val); \
> +	else \
> +		return val; \
> +}
> +
> +DEFINE_VIRTIO_XX_TO_CPU(16)
> +DEFINE_VIRTIO_XX_TO_CPU(32)
> +DEFINE_VIRTIO_XX_TO_CPU(64)
> +

I'm usually not very fond of creating functions via macros like that as
it makes it hard to grep for them.

>  struct virtio_device;
>  struct virtqueue;
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index a99f9b7..744cee1 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -33,6 +33,10 @@
>   * Copyright Rusty Russell IBM Corporation 2007. */
>  #include <linux/types.h>
> 
> +typedef __u16 __bitwise __virtio16;
> +typedef __u32 __bitwise __virtio32;
> +typedef __u64 __bitwise __virtio64;
> +
>  /* This marks a buffer as continuing via the next field. */
>  #define VRING_DESC_F_NEXT	1
>  /* This marks a buffer as write-only (otherwise read-only). */
> @@ -61,32 +65,32 @@
>  /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
>  struct vring_desc {
>  	/* Address (guest-physical). */
> -	__u64 addr;
> +	__virtio64 addr;
>  	/* Length. */
> -	__u32 len;
> +	__virtio32 len;
>  	/* The flags as indicated above. */
> -	__u16 flags;
> +	__virtio16 flags;
>  	/* We chain unused descriptors via this, too */
> -	__u16 next;
> +	__virtio16 next;
>  };
> 
>  struct vring_avail {
> -	__u16 flags;
> -	__u16 idx;
> -	__u16 ring[];
> +	__virtio16 flags;
> +	__virtio16 idx;
> +	__virtio16 ring[];
>  };

This looks weird. At least to me, that would scream "virtio endian",
which is only true for legacy devices.

I understand that you want it to be statically checkable, but I think
it decreases readability.

> 
>  /* u32 is used here for ids for padding reasons. */
>  struct vring_used_elem {
>  	/* Index of start of used descriptor chain. */
> -	__u32 id;
> +	__virtio32 id;
>  	/* Total length of the descriptor chain which was used (written to) */
> -	__u32 len;
> +	__virtio32 len;
>  };
> 
>  struct vring_used {
> -	__u16 flags;
> -	__u16 idx;
> +	__virtio16 flags;
> +	__virtio16 idx;
>  	struct vring_used_elem ring[];
>  };
> 

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 61a1fe1..a2f2f22 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -98,6 +98,8 @@ struct vring_virtqueue
>  };
> 
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
> +/* Will become vq->little_endian once we support virtio 1.0 */
> +#define vq_le(vq) (false)

All virtqueues inherit this property from their device, right? Do you
want to propagate this to the virtqueues if the guest negotiated
virtio-1 for the device?

> 
>  static struct vring_desc *alloc_indirect(unsigned int total_sg, gfp_t gfp)
>  {

> @@ -235,13 +237,13 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> 
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
> -	avail = (vq->vring.avail->idx & (vq->vring.num-1));
> -	vq->vring.avail->ring[avail] = head;
> +	avail = virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) & (vq->vring.num - 1);
> +	vq->vring.avail->ring[avail] = cpu_to_virtio16(vq_le(_vq), head);
> 
>  	/* Descriptors and available array need to be set before we expose the
>  	 * new available array entries. */
>  	virtio_wmb(vq->weak_barriers);
> -	vq->vring.avail->idx++;
> +	vq->vring.avail->idx = cpu_to_virtio16(vq_le(_vq), virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) + 1);

I think this line looks awful :(

I also notice that you need to call the converter functions with a
boolean, figuring out whether the queue is le or not in every caller. I
think passing in the device/virtqueue is a nicer interface.

>  	vq->num_added++;
> 
>  	/* This is very unlikely, but theoretically possible.  Kick
