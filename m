From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFCv2 04/12] virtio-ring: Refactor out the functions accessing
	user memory
Date: Thu, 6 Dec 2012 11:52:37 +0200
Message-ID: <20121206095237.GE10837@redhat.com>
References: <871ug75vp1.fsf@rustcorp.com.au>
	<1354718230-4486-1-git-send-email-sjur@brendeland.net>
	<1354718230-4486-5-git-send-email-sjur@brendeland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1354718230-4486-5-git-send-email-sjur@brendeland.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur@brendeland.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, virtualization@lists.linux-foundation.org, Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 05, 2012 at 03:37:02PM +0100, Sjur Br=E6ndeland wrote:
> Isolate the access to user-memory in separate inline
> functions. This open up for reuse from host-side virtioqueue
> implementation accessing virtio-ring in kernel space.
> =

> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> ---
>  drivers/virtio/virtio_ring_host.c |   81 ++++++++++++++++++++++++++-----=
------
>  1 files changed, 57 insertions(+), 24 deletions(-)
> =

> diff --git a/drivers/virtio/virtio_ring_host.c b/drivers/virtio/virtio_ri=
ng_host.c
> index 192b838..0750099 100644
> --- a/drivers/virtio/virtio_ring_host.c
> +++ b/drivers/virtio/virtio_ring_host.c
> @@ -18,44 +18,45 @@
>  #include <linux/virtio_ring.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> +#include <linux/kconfig.h>
>  =

>  MODULE_LICENSE("GPL");
>  =

> -struct vring_used_elem *vring_add_used_user(struct vring_host *vh,
> -				     unsigned int head, int len)
> +
> +static inline struct vring_used_elem *_vring_add_used(struct vring_host =
*vh,
> +						      u32 head, u32 len,
> +						      bool (*cpy)(void *dst,
> +								  void *src,
> +								  size_t s),
> +						      void (*wbarrier)(void))
>  {
>  	struct vring_used_elem  *used;
> +	u16 last_used;
>  =

>  	/* The virtqueue contains a ring of used buffers.  Get a pointer to the
>  	 * next entry in that used ring. */
> -	used =3D &vh->vr.used->ring[vh->last_used_idx % vh->vr.num];
> -	if (__put_user(head, &used->id)) {
> -		pr_debug("Failed to write used id");
> +	used =3D &vh->vr.used->ring[vh->last_used_idx & (vh->vr.num - 1)];
> +	if (!cpy(&used->id, &head, sizeof(used->id)) ||
> +	    !cpy(&used->len, &len, sizeof(used->len)))
>  		return NULL;
> -	}
> -	if (__put_user(len, &used->len)) {
> -		pr_debug("Failed to write used len");
> +	wbarrier();
> +	last_used =3D vh->last_used_idx + 1;
> +	if (!cpy(&vh->vr.used->idx, &last_used, sizeof(vh->vr.used->idx)))
>  		return NULL;

I think this is broken: we need a 16 bit access, this is
doing a memcpy which is byte by byte.

> -	}
> -	/* Make sure buffer is written before we update index. */
> -	smp_wmb();
> -	if (__put_user(vh->last_used_idx + 1, &vh->vr.used->idx)) {
> -		pr_debug("Failed to increment used idx");
> -		return NULL;
> -	}
> -	vh->last_used_idx++;
> +	vh->last_used_idx =3D last_used;
>  	return used;
>  }
> -EXPORT_SYMBOL(vring_add_used_user);
>  =

> -int vring_avail_desc_user(struct vring_host *vh)
> +static inline int _vring_avail_desc(struct vring_host *vh,
> +				    bool (*get)(u16 *dst, u16 *src),
> +				    void (*read_barrier)(void))
>  {
> -	int head;
> +	u16 head;
>  	u16 last_avail_idx;
>  =

>  	/* Check it isn't doing very strange things with descriptor numbers. */
>  	last_avail_idx =3D vh->last_avail_idx;
> -	if (unlikely(__get_user(vh->avail_idx, &vh->vr.avail->idx))) {
> +	if (unlikely(!get(&vh->avail_idx, &vh->vr.avail->idx))) {
>  		pr_debug("Failed to access avail idx at %p\n",
>  		       &vh->vr.avail->idx);
>  		return -EFAULT;
> @@ -69,13 +70,12 @@ int vring_avail_desc_user(struct vring_host *vh)
>  		return vh->vr.num;
>  =

>  	/* Only get avail ring entries after they have been exposed by guest. */
> -	smp_rmb();
> +	read_barrier();
>  =

>  	/* Grab the next descriptor number they're advertising, and increment
>  	 * the index we've seen. */
> -	if (unlikely(__get_user(head,
> -				&vh->vr.avail->ring[last_avail_idx %
> -							vh->vr.num]))) {
> +	if (unlikely(!get(&head, &vh->vr.avail->ring[last_avail_idx &
> +						     (vh->vr.num - 1)]))) {
>  		pr_debug("Failed to read head: idx %d address %p\n",
>  			 last_avail_idx,
>  		       &vh->vr.avail->ring[last_avail_idx %
> @@ -92,6 +92,39 @@ int vring_avail_desc_user(struct vring_host *vh)
>  =

>  	return head;
>  }
> +
> +static inline void smp_write_barrier(void)
> +{
> +	smp_wmb();
> +}
> +
> +static inline void smp_read_barrier(void)
> +{
> +	smp_rmb();
> +}
> +
> +static inline bool userspace_cpy_to(void  *dst, void *src, size_t s)
> +{
> +	return __copy_to_user(dst, src, s) =3D=3D 0;
> +}
> +
> +static inline bool userspace_get(u16 *dst, u16 *src)
> +{
> +	return __get_user(*dst, src);
> +}
> +
> +struct vring_used_elem *vring_add_used_user(struct vring_host *vh,
> +					    unsigned int head, int len)
> +{
> +	return _vring_add_used(vh, head, len, userspace_cpy_to,
> +			       smp_write_barrier);
> +}
> +EXPORT_SYMBOL(vring_add_used_user);
> +
> +int vring_avail_desc_user(struct vring_host *vh)
> +{
> +	return _vring_avail_desc(vh, userspace_get, smp_read_barrier);
> +}
>  EXPORT_SYMBOL(vring_avail_desc_user);
>  =

>  /* Each buffer in the virtqueues is actually a chain of descriptors.  Th=
is
> -- =

> 1.7.5.4
