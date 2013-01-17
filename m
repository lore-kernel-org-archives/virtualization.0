From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Thu, 17 Jan 2013 13:23:15 +0200
Message-ID: <20130117112314.GA15504@redhat.com>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 17, 2013 at 08:59:38PM +1030, Rusty Russell wrote:
> Getting use of virtio rings correct is tricky, and a recent patch saw
> an implementation of in-kernel rings (as separate from userspace).
> 
> This patch attempts to abstract the business of dealing with the
> virtio ring layout from the access (userspace or direct); to do this,
> we use function pointers, which gcc inlines correctly.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/Makefile             |    2 +-
>  drivers/vhost/Kconfig        |    8 +
>  drivers/vhost/Kconfig.tcm    |    1 +
>  drivers/vhost/Makefile       |    2 +
>  drivers/vhost/vringh.c       |  818 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_ring.c |   33 +-
>  include/linux/virtio_ring.h  |   57 +++
>  include/linux/vringh.h       |  115 ++++++
>  8 files changed, 1008 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/vhost/vringh.c
>  create mode 100644 include/linux/vringh.h
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 7863b9f..351a34f 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -123,7 +123,7 @@ obj-$(CONFIG_PPC_PS3)		+= ps3/
>  obj-$(CONFIG_OF)		+= of/
>  obj-$(CONFIG_SSB)		+= ssb/
>  obj-$(CONFIG_BCMA)		+= bcma/
> -obj-$(CONFIG_VHOST_NET)		+= vhost/
> +obj-$(CONFIG_VHOST_RING)	+= vhost/
>  obj-$(CONFIG_VLYNQ)		+= vlynq/
>  obj-$(CONFIG_STAGING)		+= staging/
>  obj-y				+= platform/
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 202bba6..613b074 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -1,6 +1,7 @@
>  config VHOST_NET
>  	tristate "Host kernel accelerator for virtio net (EXPERIMENTAL)"
>  	depends on NET && EVENTFD && (TUN || !TUN) && (MACVTAP || !MACVTAP) && EXPERIMENTAL
> +	select VHOST_RING
>  	---help---
>  	  This kernel module can be loaded in host kernel to accelerate
>  	  guest networking with virtio_net. Not to be confused with virtio_net
> @@ -12,3 +13,10 @@ config VHOST_NET
>  if STAGING
>  source "drivers/vhost/Kconfig.tcm"
>  endif
> +
> +config VHOST_RING
> +	tristate
> +	---help---
> +	  This option is selected by any driver which needs to access
> +	  the host side of a virtio ring.
> +
> diff --git a/drivers/vhost/Kconfig.tcm b/drivers/vhost/Kconfig.tcm
> index a9c6f76..0218f77 100644
> --- a/drivers/vhost/Kconfig.tcm
> +++ b/drivers/vhost/Kconfig.tcm
> @@ -1,6 +1,7 @@
>  config TCM_VHOST
>  	tristate "TCM_VHOST fabric module (EXPERIMENTAL)"
>  	depends on TARGET_CORE && EVENTFD && EXPERIMENTAL && m
> +	select VHOST_RING
>  	default n
>  	---help---
>  	Say M here to enable the TCM_VHOST fabric module for use with virtio-scsi guests
> diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> index a27b053..1d37f5e 100644
> --- a/drivers/vhost/Makefile
> +++ b/drivers/vhost/Makefile
> @@ -2,3 +2,5 @@ obj-$(CONFIG_VHOST_NET) += vhost_net.o
>  vhost_net-y := vhost.o net.o
>  
>  obj-$(CONFIG_TCM_VHOST) += tcm_vhost.o
> +
> +obj-$(CONFIG_VHOST_RING) += vringh.o
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> new file mode 100644
> index 0000000..b28670f
> --- /dev/null
> +++ b/drivers/vhost/vringh.c
> @@ -0,0 +1,818 @@
> +/*
> + * Helpers for the host side of a virtio ring.
> + *
> + * Since these may be in userspace, we use (inline) accessors.
> + */
> +#include <linux/vringh.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/kernel.h>
> +#include <linux/ratelimit.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +
> +static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
> +{
> +	static DEFINE_RATELIMIT_STATE(vringh_rs,
> +				      DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	if (__ratelimit(&vringh_rs)) {
> +		va_list ap;
> +		va_start(ap, fmt);
> +		printk(KERN_NOTICE "vringh:");
> +		vprintk(fmt, ap);
> +		va_end(ap);
> +	}
> +}
> +
> +/* Returns vring->num if empty, -ve on error. */
> +static inline int __vringh_get_head(const struct vringh *vrh,
> +				    int (*getu16)(u16 *val, const u16 *p),

I think int (*getu16)(const u16 *p) would be cleaner
than returning through a pointer, then
callers check that value < 0 for error.

> +				    u16 *last_avail_idx)
> +{
> +	u16 avail_idx, i, head;
> +	int err;
> +
> +	err = getu16(&avail_idx, &vrh->vring.avail->idx);
> +	if (err) {
> +		vringh_bad("Failed to access avail idx at %p",
> +			   &vrh->vring.avail->idx);
> +		return err;
> +	}
> +
> +	if (*last_avail_idx == avail_idx)
> +		return vrh->vring.num;
> +
> +	/* Only get avail ring entries after they have been exposed by guest. */
> +	virtio_rmb(vrh->weak_barriers);
> +
> +	i = *last_avail_idx & (vrh->vring.num - 1);
> +
> +	err = getu16(&head, &vrh->vring.avail->ring[i]);
> +	if (err) {
> +		vringh_bad("Failed to read head: idx %d address %p",
> +			   *last_avail_idx, &vrh->vring.avail->ring[i]);
> +		return err;
> +	}
> +
> +	if (head >= vrh->vring.num) {
> +		vringh_bad("Guest says index %u > %u is available",
> +			   head, vrh->vring.num);
> +		return -EINVAL;
> +	}
> +
> +	(*last_avail_idx)++;
> +	return head;
> +}
> +
> +/* Copy some bytes to/from the iovec.  Returns num copied. */
> +static inline ssize_t vringh_iov_xfer(struct vringh_iov *iov,
> +				      void *ptr, size_t len,
> +				      int (*xfer)(void __user *addr, void *ptr,
> +						  size_t len))
> +{
> +	int err, done = 0;
> +
> +	while (len && iov->i < iov->max) {
> +		size_t partlen;
> +
> +		partlen = min(iov->iov[iov->i].iov_len, len);
> +		err = xfer(iov->iov[iov->i].iov_base, ptr, partlen);
> +		if (err)
> +			return err;
> +		done += partlen;
> +		len -= partlen;
> +		ptr += partlen;
> +		iov->iov[iov->i].iov_base += partlen;
> +		iov->iov[iov->i].iov_len -= partlen;
> +
> +		if (iov->iov[iov->i].iov_len == 0)
> +			iov->i++;
> +	}
> +	return done;
> +}
> +
> +static inline bool check_range(u64 addr, u32 len,
> +			       struct vringh_range *range,
> +			       bool (*getrange)(u64, struct vringh_range *))
> +{
> +	if (addr < range->start || addr > range->end_incl) {
> +		if (!getrange(addr, range))
> +			goto bad;
> +	}
> +	BUG_ON(addr < range->start || addr > range->end_incl);
> +
> +	/* To end of memory? */
> +	if (unlikely(addr + len == 0)) {
> +		if (range->end_incl == -1ULL)
> +			return true;
> +		goto bad;
> +	}
> +
> +	/* Otherwise, don't wrap. */
> +	if (unlikely(addr + len < addr))
> +		goto bad;
> +	if (unlikely(addr + len - 1 > range->end_incl))
> +		goto bad;
> +	return true;
> +
> +bad:
> +	vringh_bad("Malformed descriptor address %u@0x%llx", len, addr);
> +	return false;
> +}
> +
> +/* No reason for this code to be inline. */
> +static int move_to_indirect(int *up_next, u16 *i, void *addr,
> +			    const struct vring_desc *desc,
> +			    struct vring_desc **descs, int *desc_max)
> +{
> +	/* Indirect tables can't have indirect. */
> +	if (*up_next != -1) {
> +		vringh_bad("Multilevel indirect %u->%u", *up_next, *i);
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(desc->len % sizeof(struct vring_desc))) {
> +		vringh_bad("Strange indirect len %u", desc->len);
> +		return -EINVAL;
> +	}
> +
> +	/* We will check this when we follow it! */
> +	if (desc->flags & VRING_DESC_F_NEXT)
> +		*up_next = desc->next;
> +	else
> +		*up_next = -2;
> +	*descs = addr;
> +	*desc_max = desc->len / sizeof(struct vring_desc);
> +
> +	/* Now, start at the first indirect. */
> +	*i = 0;
> +	return 0;
> +}
> +
> +static int resize_iovec(struct vringh_iov *iov, gfp_t gfp)
> +{
> +	struct iovec *new;
> +	unsigned int new_num = iov->max * 2;
> +
> +	if (new_num < 8)
> +		new_num = 8;
> +
> +	if (iov->allocated)
> +		new = krealloc(iov->iov, new_num * sizeof(struct iovec), gfp);
> +	else {
> +		new = kmalloc(new_num * sizeof(struct iovec), gfp);
> +		if (new) {
> +			memcpy(new, iov->iov, iov->i * sizeof(struct iovec));
> +			iov->allocated = true;
> +		}
> +	}
> +	if (!new)
> +		return -ENOMEM;
> +	iov->iov = new;
> +	iov->max = new_num;
> +	return 0;
> +}
> +
> +static u16 __cold return_from_indirect(const struct vringh *vrh, int *up_next,
> +				       struct vring_desc **descs, int *desc_max)
> +{
> +	u16 i = *up_next;
> +
> +	*up_next = -1;
> +	*descs = vrh->vring.desc;
> +	*desc_max = vrh->vring.num;
> +	return i;
> +}
> +
> +static inline int
> +__vringh_iov(struct vringh *vrh, u16 i,
> +	     struct vringh_iov *riov,
> +	     struct vringh_iov *wiov,
> +	     bool (*getrange)(u64 addr, struct vringh_range *r),
> +	     gfp_t gfp,
> +	     int (*getdesc)(struct vring_desc *dst, const struct vring_desc *s))
> +{
> +	int err, count = 0, up_next, desc_max;
> +	struct vring_desc desc, *descs;
> +	struct vringh_range range = { -1ULL, 0 };
> +
> +	/* We start traversing vring's descriptor table. */
> +	descs = vrh->vring.desc;
> +	desc_max = vrh->vring.num;
> +	up_next = -1;
> +
> +	riov->i = wiov->i = 0;
> +	for (;;) {
> +		void *addr;
> +		struct vringh_iov *iov;
> +
> +		err = getdesc(&desc, &descs[i]);
> +		if (unlikely(err))
> +			goto fail;
> +
> +		/* Make sure it's OK, and get offset. */
> +		if (!check_range(desc.addr, desc.len, &range, getrange)) {
> +			err = -EINVAL;
> +			goto fail;
> +		}
> +		addr = (void *)(long)desc.addr + range.offset;

Should probably be (void *)(long)(desc.addr + range.offset).
Otherwise we risk signed integer overflow.

> +
> +		if (unlikely(desc.flags & VRING_DESC_F_INDIRECT)) {
> +			err = move_to_indirect(&up_next, &i, addr, &desc,
> +					       &descs, &desc_max);
> +			if (err)
> +				goto fail;
> +			continue;
> +		}
> +
> +		if (count++ == vrh->vring.num) {
> +			vringh_bad("Descriptor loop in %p", descs);
> +			err = -ELOOP;
> +			goto fail;
> +		}
> +
> +		if (desc.flags & VRING_DESC_F_WRITE)
> +			iov = wiov;
> +		else {
> +			iov = riov;
> +			if (unlikely(wiov->i)) {
> +				vringh_bad("Readable desc %p after writable",
> +					   &descs[i]);
> +				err = -EINVAL;
> +				goto fail;
> +			}
> +		}
> +
> +		if (unlikely(iov->i == iov->max)) {
> +			err = resize_iovec(iov, gfp);
> +			if (err)
> +				goto fail;
> +		}
> +
> +		iov->iov[iov->i].iov_base = (__force __user void *)addr;
> +		iov->iov[iov->i].iov_len = desc.len;

The following comment from the previous version still applies:
	> This looks like it won't do the right thing if desc.len spans multiple
	> ranges. I don't know if this happens in practice but this is something
	> vhost supports ATM.
in otgher words, we might need to split a single desc to multiple
iov entries.

> +		iov->i++;
> +
> +		if (desc.flags & VRING_DESC_F_NEXT) {
> +			i = desc.next;
> +		} else {
> +			/* Just in case we need to finish traversing above. */
> +			if (unlikely(up_next > 0))
> +				i = return_from_indirect(vrh, &up_next,
> +							 &descs, &desc_max);
> +			else
> +				break;
> +		}
> +
> +		if (i >= desc_max) {
> +			vringh_bad("Chained index %u > %u", i, desc_max);
> +			err = -EINVAL;
> +			goto fail;
> +		}
> +	}
> +
> +	/* Reset for fresh iteration. */
> +	riov->max = riov->i;
> +	wiov->max = wiov->i;
> +	riov->i = wiov->i = 0;
> +	return 0;
> +
> +fail:
> +	if (riov->allocated)
> +		kfree(riov->iov);
> +	if (wiov->allocated)
> +		kfree(wiov->iov);
> +	return err;
> +}
> +
> +static inline int __vringh_complete(struct vringh *vrh, u16 idx, u32 len,
> +				    int (*getu16)(u16 *val, const u16 *p),
> +				    int (*putu16)(u16 *p, u16 val),
> +				    int (*putused)(struct vring_used_elem *dst,
> +						   const struct vring_used_elem
> +						   *s),
> +				    bool *notify)
> +{
> +	struct vring_used_elem used;
> +	struct vring_used *used_ring;
> +	int err;
> +	u16 used_idx, old, used_event;
> +
> +	used.id = idx;
> +	used.len = len;
> +
> +	err = getu16(&used_idx, &vring_used_event(&vrh->vring));
> +	if (err) {
> +		vringh_bad("Failed to access used event %p",
> +			   &vring_used_event(&vrh->vring));
> +		return err;
> +	}
> +
> +	used_ring = vrh->vring.used;
> +	used_idx = vrh->last_used_idx;
> +
> +	err = putused(&used_ring->ring[used_idx % vrh->vring.num],
> +		      &used);
> +	if (err) {
> +		vringh_bad("Failed to write used entry %u at %p",
> +			   used_idx % vrh->vring.num,
> +			   &used_ring->ring[used_idx % vrh->vring.num]);
> +		return err;
> +	}
> +
> +	/* Make sure buffer is written before we update index. */
> +	virtio_wmb(vrh->weak_barriers);
> +
> +	old = vrh->last_used_idx;
> +	vrh->last_used_idx++;
> +
> +	err = putu16(&vrh->vring.used->idx, vrh->last_used_idx);
> +	if (err) {
> +		vringh_bad("Failed to update used index at %p",
> +			   &vrh->vring.used->idx);
> +		return err;


One thing vhost does is roll back everything on error,
so you can for example have an invalid range
of memory and handle writes there in userspace.
I think it's worth preserving though this is
currently unused.

> +	}
> +
> +	/* If we already know we need to notify, skip re-checking */
> +	if (*notify)
> +		return 0;
> +
> +	/* Flush out used index update. This is paired with the
> +	 * barrier that the Guest executes when enabling
> +	 * interrupts. */
> +	virtio_mb(vrh->weak_barriers);
> +
> +	/* Old-style, without event indices. */
> +	if (!vrh->event_indices) {
> +		u16 flags;
> +		err = getu16(&flags, &vrh->vring.avail->flags);
> +		if (err) {
> +			vringh_bad("Failed to get flags at %p",
> +				   &vrh->vring.avail->flags);
> +			return err;
> +		}
> +		if (!(flags & VRING_AVAIL_F_NO_INTERRUPT))
> +			*notify = true;
> +		return 0;
> +	}
> +
> +	/* Modern: we know where other side is up to. */
> +	err = getu16(&used_event, &vring_used_event(&vrh->vring));
> +	if (err) {
> +		vringh_bad("Failed to get used event idx at %p",
> +			   &vring_used_event(&vrh->vring));
> +		return err;
> +	}
> +	if (vring_need_event(used_event, vrh->last_used_idx, old))
> +		*notify = true;
> +	return 0;
> +}
> +
> +static inline bool __vringh_notify_enable(struct vringh *vrh,
> +					  int (*getu16)(u16 *val, const u16 *p),
> +					  int (*putu16)(u16 *p, u16 val))
> +{
> +	u16 avail;
> +
> +	/* Already enabled? */
> +	if (vrh->listening)
> +		return false;
> +
> +	vrh->listening = true;
> +
> +	if (!vrh->event_indices) {
> +		/* Old-school; update flags. */
> +		if (putu16(&vrh->vring.used->flags, 0) != 0) {
> +			vringh_bad("Clearing used flags %p",
> +				   &vrh->vring.used->flags);
> +			return false;
> +		}
> +	} else {
> +		if (putu16(&vring_avail_event(&vrh->vring),
> +			   vrh->last_avail_idx) != 0) {
> +			vringh_bad("Updating avail event index %p",
> +				   &vring_avail_event(&vrh->vring));
> +			return false;
> +		}
> +	}
> +
> +	/* They could have slipped one in as we were doing that: make
> +	 * sure it's written, then check again. */
> +	virtio_mb(vrh->weak_barriers);
> +
> +	if (getu16(&avail, &vrh->vring.avail->idx) != 0) {

Hmm above has implicit != 0 why not here?

> +		vringh_bad("Failed to check avail idx at %p",
> +			   &vrh->vring.avail->idx);
> +		return false;
> +	}
> +
> +	/* This is so unlikely, we just leave notifications enabled. */
> +	return avail != vrh->last_avail_idx;
> +}
> +
> +static inline void __vringh_notify_disable(struct vringh *vrh,
> +					   int (*putu16)(u16 *p, u16 val))
> +{
> +	/* Already disabled? */
> +	if (!vrh->listening)
> +		return;
> +
> +	vrh->listening = false;
> +	if (!vrh->event_indices) {
> +		/* Old-school; update flags. */
> +		if (putu16(&vrh->vring.used->flags, VRING_USED_F_NO_NOTIFY)) {
> +			vringh_bad("Setting used flags %p",
> +				   &vrh->vring.used->flags);
> +		}
> +	}
> +}
> +
> +/* Userspace access helpers. */
> +static inline int getu16_user(u16 *val, const u16 *p)
> +{
> +	return get_user(*val, (__force u16 __user *)p);
> +}
> +
> +static inline int putu16_user(u16 *p, u16 val)
> +{
> +	return put_user(val, (__force u16 __user *)p);
> +}
> +
> +static inline int getdesc_user(struct vring_desc *dst,
> +			       const struct vring_desc *src)
> +{
> +	return copy_from_user(dst, (__force void *)src, sizeof(*dst)) == 0 ? 0 :
> +		-EFAULT;

confused about __force above. Shouldn't it cast to __user?
I have not tried does this patch pass the checker?

> +}
> +
> +static inline int putused_user(struct vring_used_elem *dst,
> +			       const struct vring_used_elem *s)
> +{
> +	return copy_to_user((__force void __user *)dst, s, sizeof(*dst)) == 0
> +		? 0 : -EFAULT;
> +}
> +
> +static inline int xfer_from_user(void *src, void *dst, size_t len)
> +{
> +	return copy_from_user(dst, (__force void *)src, len) == 0 ? 0 :
> +		-EFAULT;
> +}
> +
> +static inline int xfer_to_user(void *dst, void *src, size_t len)
> +{
> +	return copy_to_user((__force void *)dst, src, len) == 0 ? 0 :
> +		-EFAULT;
> +}
> +
> +/**
> + * vringh_init_user - initialize a vringh for a userspace vring.
> + * @vrh: the vringh to initialize.
> + * @features: the feature bits for this ring.
> + * @num: the number of elements.
> + * @weak_barriers: true if we only need memory barriers, not I/O.
> + * @desc: the userpace descriptor pointer.
> + * @avail: the userpace avail pointer.
> + * @used: the userpace used pointer.
> + *
> + * Returns an error if num is invalid: you should check pointers
> + * yourself!
> + */
> +int vringh_init_user(struct vringh *vrh, u32 features,
> +		     unsigned int num, bool weak_barriers,
> +		     struct vring_desc __user *desc,
> +		     struct vring_avail __user *avail,
> +		     struct vring_used __user *used)
> +{
> +	/* Sane power of 2 please! */
> +	if (!num || num > 0xffff || (num & (num - 1))) {
> +		vringh_bad("Bad ring size %zu", num);
> +		return -EINVAL;
> +	}
> +
> +	vrh->event_indices = (features & (1 << VIRTIO_RING_F_EVENT_IDX));
> +	vrh->weak_barriers = weak_barriers;
> +	vrh->listening = false;
> +	vrh->last_avail_idx = 0;
> +	vrh->last_used_idx = 0;
> +	vrh->vring.num = num;
> +	vrh->vring.desc = (__force struct vring_desc *)desc;
> +	vrh->vring.avail = (__force struct vring_avail *)avail;
> +	vrh->vring.used = (__force struct vring_used *)used;

I counted 3 separate chunks that do __force casts.
Let's try to isolate them and comment why it's safe.


> +	return 0;
> +}
> +
> +/**
> + * vringh_getdesc_user - get next available descriptor from userspace ring.
> + * @vrh: the userspace vring.
> + * @riov: where to put the readable descriptors.
> + * @wiov: where to put the writable descriptors.
> + * @getrange: function to call to check ranges.
> + * @head: head index we received, for passing to vringh_complete_user().
> + * @gfp: flags for allocating larger riov/wiov.
> + *
> + * Returns 0 if there was no descriptor, 1 if there was, or -errno.
> + *
> + * If it returns 1, riov->allocated and wiov->allocated indicate if you
> + * have to kfree riov->iov and wiov->iov respectively.
> + */
> +int vringh_getdesc_user(struct vringh *vrh,
> +			struct vringh_iov *riov,
> +			struct vringh_iov *wiov,
> +			bool (*getrange)(u64 addr, struct vringh_range *r),
> +			u16 *head,
> +			gfp_t gfp)
> +{
> +	int err;
> +
> +	err = __vringh_get_head(vrh, getu16_user, &vrh->last_avail_idx);
> +	if (err < 0)
> +		return err;
> +
> +	/* Empty... */
> +	if (err == vrh->vring.num)
> +		return 0;
> +
> +	*head = err;
> +	err = __vringh_iov(vrh, *head, riov, wiov, getrange, gfp, getdesc_user);
> +	if (err)
> +		return err;
> +
> +	return 1;
> +}
> +
> +/**
> + * vringh_iov_pull_user - copy bytes from vring_iov.
> + * @riov: the riov as passed to vringh_getdesc_user() (updated as we consume)
> + * @dst: the place to copy.
> + * @len: the maximum length to copy.
> + *
> + * Returns the bytes copied <= len or a negative errno.
> + */
> +ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len)
> +{
> +	return vringh_iov_xfer(riov, dst, len, xfer_from_user);
> +}
> +
> +/**
> + * vringh_iov_push_user - copy bytes into vring_iov.
> + * @wiov: the wiov as passed to vringh_getdesc_user() (updated as we consume)
> + * @dst: the place to copy.
> + * @len: the maximum length to copy.
> + *
> + * Returns the bytes copied <= len or a negative errno.
> + */
> +ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
> +			     const void *src, size_t len)
> +{
> +	return vringh_iov_xfer(wiov, (void *)src, len, xfer_to_user);
> +}
> +
> +/**
> + * vringh_abandon_user - we've decided not to handle the descriptor(s).
> + * @vrh: the vring.
> + * @num: the number of descriptors to put back (ie. num
> + *	 vringh_get_user() to undo).
> + *
> + * The next vringh_get_user() will return the old descriptor(s) again.
> + */
> +void vringh_abandon_user(struct vringh *vrh, unsigned int num)
> +{
> +	/* We only update vring_avail_event(vr) when we want to be notified,
> +	 * so we haven't changed that yet. */
> +	vrh->last_avail_idx -= num;
> +}
> +
> +/**
> + * vringh_complete_user - we've finished with descriptor, publish it.
> + * @vrh: the vring.
> + * @head: the head as filled in by vringh_getdesc_user.
> + * @len: the length of data we have written.
> + * @notify: set if we should notify the other side, otherwise left alone.
> + */
> +int vringh_complete_user(struct vringh *vrh, u16 head, u32 len,
> +			 bool *notify)
> +{
> +	return __vringh_complete(vrh, head, len,
> +				 getu16_user, putu16_user, putused_user,
> +				 notify);
> +}
> +
> +/**
> + * vringh_notify_enable_user - we want to know if something changes.
> + * @vrh: the vring.
> + *
> + * This always enables notifications, but returns true if there are
> + * now more buffers available in the vring.
> + */
> +bool vringh_notify_enable_user(struct vringh *vrh)
> +{
> +	return __vringh_notify_enable(vrh, getu16_user, putu16_user);
> +}
> +
> +/**
> + * vringh_notify_disable_user - don't tell us if something changes.
> + * @vrh: the vring.
> + *
> + * This is our normal running state: we disable and then only enable when
> + * we're going to sleep.
> + */
> +void vringh_notify_disable_user(struct vringh *vrh)
> +{
> +	__vringh_notify_disable(vrh, putu16_user);
> +}
> +
> +/* Kernelspace access helpers. */
> +static inline int getu16_kern(u16 *val, const u16 *p)
> +{
> +	*val = *p;
> +	return 0;
> +}
> +
> +static inline int putu16_kern(u16 *p, u16 val)
> +{
> +	*p = val;
> +	return 0;
> +}
> +
> +static inline int getdesc_kern(struct vring_desc *dst,
> +			       const struct vring_desc *src)
> +{
> +	*dst = *src;
> +	return 0;
> +}
> +
> +static inline int putused_kern(struct vring_used_elem *dst,
> +			       const struct vring_used_elem *s)
> +{
> +	*dst = *s;
> +	return 0;
> +}
> +
> +static inline int xfer_kern(void *src, void *dst, size_t len)
> +{
> +	memcpy(dst, src, len);
> +	return 0;
> +}
> +
> +static inline bool noop_getrange(u64 addr, struct vringh_range *r)
> +{
> +	r->start = 0;
> +	r->end_incl = -1ULL;
> +	r->offset = 0;
> +	return true;
> +}
> +
> +/**
> + * vringh_init_kern - initialize a vringh for a kernelspace vring.
> + * @vrh: the vringh to initialize.
> + * @features: the feature bits for this ring.
> + * @num: the number of elements.
> + * @weak_barriers: true if we only need memory barriers, not I/O.
> + * @desc: the userpace descriptor pointer.
> + * @avail: the userpace avail pointer.
> + * @used: the userpace used pointer.
> + *
> + * Returns an error if num is invalid.
> + */
> +int vringh_init_kern(struct vringh *vrh, u32 features,
> +		     unsigned int num, bool weak_barriers,
> +		     struct vring_desc *desc,
> +		     struct vring_avail *avail,
> +		     struct vring_used *used)
> +{
> +	/* Sane power of 2 please! */
> +	if (!num || num > 0xffff || (num & (num - 1))) {
> +		vringh_bad("Bad ring size %zu", num);
> +		return -EINVAL;
> +	}
> +
> +	vrh->event_indices = (features & (1 << VIRTIO_RING_F_EVENT_IDX));
> +	vrh->weak_barriers = weak_barriers;
> +	vrh->listening = false;
> +	vrh->last_avail_idx = 0;
> +	vrh->last_used_idx = 0;
> +	vrh->vring.num = num;
> +	vrh->vring.desc = desc;
> +	vrh->vring.avail = avail;
> +	vrh->vring.used = used;
> +	return 0;
> +}
> +
> +/**
> + * vringh_getdesc_kern - get next available descriptor from kernelspace ring.
> + * @vrh: the kernelspace vring.
> + * @riov: where to put the readable descriptors.
> + * @wiov: where to put the writable descriptors.
> + * @head: head index we received, for passing to vringh_complete_kern().
> + * @gfp: flags for allocating larger riov/wiov.
> + *
> + * Returns 0 if there was no descriptor, 1 if there was, or -errno.
> + *
> + * If it returns 1, riov->allocated and wiov->allocated indicate if you
> + * have to kfree riov->iov and wiov->iov respectively.
> + */
> +int vringh_getdesc_kern(struct vringh *vrh,
> +			struct vringh_iov *riov,
> +			struct vringh_iov *wiov,
> +			u16 *head,
> +			gfp_t gfp)
> +{
> +	int err;
> +
> +	err = __vringh_get_head(vrh, getu16_kern, &vrh->last_avail_idx);
> +	if (err < 0)
> +		return err;
> +
> +	/* Empty... */
> +	if (err == vrh->vring.num)
> +		return 0;
> +
> +	*head = err;
> +	err = __vringh_iov(vrh, *head, riov, wiov, noop_getrange,
> +			   gfp, getdesc_kern);
> +	if (err)
> +		return err;
> +
> +	return 1;
> +}
> +
> +/**
> + * vringh_iov_pull_kern - copy bytes from vring_iov.
> + * @riov: the riov as passed to vringh_getdesc_kern() (updated as we consume)
> + * @dst: the place to copy.
> + * @len: the maximum length to copy.
> + *
> + * Returns the bytes copied <= len or a negative errno.
> + */
> +ssize_t vringh_iov_pull_kern(struct vringh_iov *riov, void *dst, size_t len)
> +{
> +	return vringh_iov_xfer(riov, dst, len, xfer_kern);
> +}
> +
> +/**
> + * vringh_iov_push_kern - copy bytes into vring_iov.
> + * @wiov: the wiov as passed to vringh_getdesc_kern() (updated as we consume)
> + * @dst: the place to copy.
> + * @len: the maximum length to copy.
> + *
> + * Returns the bytes copied <= len or a negative errno.
> + */
> +ssize_t vringh_iov_push_kern(struct vringh_iov *wiov,
> +			     const void *src, size_t len)
> +{
> +	return vringh_iov_xfer(wiov, (void *)src, len, xfer_kern);
> +}
> +
> +/**
> + * vringh_abandon_kern - we've decided not to handle the descriptor(s).
> + * @vrh: the vring.
> + * @num: the number of descriptors to put back (ie. num
> + *	 vringh_get_kern() to undo).
> + *
> + * The next vringh_get_kern() will return the old descriptor(s) again.
> + */
> +void vringh_abandon_kern(struct vringh *vrh, unsigned int num)
> +{
> +	/* We only update vring_avail_event(vr) when we want to be notified,
> +	 * so we haven't changed that yet. */
> +	vrh->last_avail_idx -= num;
> +}
> +
> +/**
> + * vringh_complete_kern - we've finished with descriptor, publish it.
> + * @vrh: the vring.
> + * @head: the head as filled in by vringh_getdesc_kern.
> + * @len: the length of data we have written.
> + * @notify: set if we should notify the other side, otherwise left alone.
> + */
> +int vringh_complete_kern(struct vringh *vrh, u16 head, u32 len,
> +			 bool *notify)
> +{
> +	return __vringh_complete(vrh, head, len,
> +				 getu16_kern, putu16_kern, putused_kern,
> +				 notify);
> +}
> +
> +/**
> + * vringh_notify_enable_kern - we want to know if something changes.
> + * @vrh: the vring.
> + *
> + * This always enables notifications, but returns true if there are
> + * now more buffers available in the vring.
> + */
> +bool vringh_notify_enable_kern(struct vringh *vrh)
> +{
> +	return __vringh_notify_enable(vrh, getu16_kern, putu16_kern);
> +}
> +
> +/**
> + * vringh_notify_disable_kern - don't tell us if something changes.
> + * @vrh: the vring.
> + *
> + * This is our normal running state: we disable and then only enable when
> + * we're going to sleep.
> + */
> +void vringh_notify_disable_kern(struct vringh *vrh)
> +{
> +	__vringh_notify_disable(vrh, putu16_kern);
> +}
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ffd7e7d..245177c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -24,27 +24,6 @@
>  #include <linux/module.h>
>  #include <linux/hrtimer.h>
>  
> -/* virtio guest is communicating with a virtual "device" that actually runs on
> - * a host processor.  Memory barriers are used to control SMP effects. */
> -#ifdef CONFIG_SMP
> -/* Where possible, use SMP barriers which are more lightweight than mandatory
> - * barriers, because mandatory barriers control MMIO effects on accesses
> - * through relaxed memory I/O windows (which virtio-pci does not use). */
> -#define virtio_mb(vq) \
> -	do { if ((vq)->weak_barriers) smp_mb(); else mb(); } while(0)
> -#define virtio_rmb(vq) \
> -	do { if ((vq)->weak_barriers) smp_rmb(); else rmb(); } while(0)
> -#define virtio_wmb(vq) \
> -	do { if ((vq)->weak_barriers) smp_wmb(); else wmb(); } while(0)
> -#else
> -/* We must force memory ordering even if guest is UP since host could be
> - * running on another CPU, but SMP barriers are defined to barrier() in that
> - * configuration. So fall back to mandatory barriers instead. */
> -#define virtio_mb(vq) mb()
> -#define virtio_rmb(vq) rmb()
> -#define virtio_wmb(vq) wmb()
> -#endif
> -
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
>  #define BAD_RING(_vq, fmt, args...)				\
> @@ -276,7 +255,7 @@ add_head:
>  
>  	/* Descriptors and available array need to be set before we expose the
>  	 * new available array entries. */
> -	virtio_wmb(vq);
> +	virtio_wmb(vq->weak_barriers);
>  	vq->vring.avail->idx++;
>  	vq->num_added++;
>  
> @@ -312,7 +291,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  	START_USE(vq);
>  	/* We need to expose available array entries before checking avail
>  	 * event. */
> -	virtio_mb(vq);
> +	virtio_mb(vq->weak_barriers);
>  
>  	old = vq->vring.avail->idx - vq->num_added;
>  	new = vq->vring.avail->idx;
> @@ -436,7 +415,7 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  	}
>  
>  	/* Only get used array entries after they have been exposed by host. */
> -	virtio_rmb(vq);
> +	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->vring.num - 1));
>  	i = vq->vring.used->ring[last_used].id;
> @@ -460,7 +439,7 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  	 * the read in the next get_buf call. */
>  	if (!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vring_used_event(&vq->vring) = vq->last_used_idx;
> -		virtio_mb(vq);
> +		virtio_mb(vq->weak_barriers);
>  	}
>  
>  #ifdef DEBUG
> @@ -513,7 +492,7 @@ bool virtqueue_enable_cb(struct virtqueue *_vq)
>  	 * entry. Always do both to keep code simple. */
>  	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
>  	vring_used_event(&vq->vring) = vq->last_used_idx;
> -	virtio_mb(vq);
> +	virtio_mb(vq->weak_barriers);
>  	if (unlikely(more_used(vq))) {
>  		END_USE(vq);
>  		return false;
> @@ -553,7 +532,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	/* TODO: tune this threshold */
>  	bufs = (u16)(vq->vring.avail->idx - vq->last_used_idx) * 3 / 4;
>  	vring_used_event(&vq->vring) = vq->last_used_idx + bufs;
> -	virtio_mb(vq);
> +	virtio_mb(vq->weak_barriers);
>  	if (unlikely((u16)(vq->vring.used->idx - vq->last_used_idx) > bufs)) {
>  		END_USE(vq);
>  		return false;
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 63c6ea1..ca3ad41 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -4,6 +4,63 @@
>  #include <linux/irqreturn.h>
>  #include <uapi/linux/virtio_ring.h>
>  
> +/*
> + * Barriers in virtio are tricky.  Non-SMP virtio guests can't assume
> + * they're not on an SMP host system, so they need to assume real
> + * barriers.  Non-SMP virtio hosts could skip the barriers, but does
> + * anyone care?
> + *
> + * For virtio_pci on SMP, we don't need to order with respect to MMIO
> + * accesses through relaxed memory I/O windows, so smp_mb() et al are
> + * sufficient.
> + *
> + * For using virtio to talk to real devices (eg. other heterogeneous
> + * CPUs) we do need real barriers.  In theory, we could be using both
> + * kinds of virtio, so it's a runtime decision, and the branch is
> + * actually quite cheap.
> + */
> +
> +#ifdef CONFIG_SMP
> +static inline void virtio_mb(bool weak_barriers)
> +{
> +	if (weak_barriers)
> +		smp_mb();
> +	else
> +		mb();
> +}
> +
> +static inline void virtio_rmb(bool weak_barriers)
> +{
> +	if (weak_barriers)
> +		smp_rmb();
> +	else
> +		rmb();
> +}
> +
> +static inline void virtio_wmb(bool weak_barriers)
> +{
> +	if (weak_barriers)
> +		smp_wmb();
> +	else
> +		wmb();
> +}
> +#else
> +static inline void virtio_mb(bool weak_barriers)
> +{
> +	mb();
> +}
> +
> +static inline void virtio_rmb(bool weak_barriers)
> +{
> +	rmb();
> +}
> +
> +static inline void virtio_wmb(bool weak_barriers)
> +{
> +	wmb();
> +}
> +#endif
> +
>  struct virtio_device;
>  struct virtqueue;
>  
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> new file mode 100644
> index 0000000..508b5e5
> --- /dev/null
> +++ b/include/linux/vringh.h
> @@ -0,0 +1,115 @@
> +/*
> + * Linux host-side vring helpers; for when the kernel needs to access
> + * someone else's vring.
> + *
> + * Copyright IBM Corporation, 2013.
> + * Parts taken from drivers/vhost/vhost.c Copyright 2009 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Written by: Rusty Russell <rusty@rustcorp.com.au>
> + */
> +#ifndef _LINUX_VRINGH_H
> +#define _LINUX_VRINGH_H
> +#include <uapi/linux/virtio_ring.h>
> +#include <uapi/linux/uio.h>
> +#include <asm/barrier.h>
> +
> +/* virtio_ring with information needed for host access. */
> +struct vringh {
> +	/* Guest publishes used event idx (note: we always do). */
> +	bool event_indices;
> +
> +	/* Have we told the other end we want to be notified? */
> +	bool listening;
> +
> +	/* Can we get away with weak barriers? */
> +	bool weak_barriers;
> +
> +	/* Last available index we saw (ie. where we're up to). */
> +	u16 last_avail_idx;
> +
> +	/* Last index we used. */
> +	u16 last_used_idx;
> +
> +	/* The vring (note: it may contain user pointers!) */
> +	struct vring vring;
> +};
> +
> +/* The memory the vring can access, and what offset to apply. */
> +struct vringh_range {
> +	u64 start, end_incl;
> +	u64 offset;
> +};
> +
> +/* All the information about an iovec. */
> +struct vringh_iov {
> +	struct iovec *iov;
> +	unsigned i, max;
> +	bool allocated;
> +};
> +
> +/* Helpers for userspace vrings. */
> +int vringh_init_user(struct vringh *vrh, u32 features,
> +		     unsigned int num, bool weak_barriers,
> +		     struct vring_desc __user *desc,
> +		     struct vring_avail __user *avail,
> +		     struct vring_used __user *used);
> +
> +/* Convert a descriptor into iovecs. */
> +int vringh_getdesc_user(struct vringh *vrh,
> +			struct vringh_iov *riov,
> +			struct vringh_iov *wiov,
> +			bool (*getrange)(u64 addr, struct vringh_range *r),
> +			u16 *head,
> +			gfp_t gfp);
> +
> +/* Copy bytes from readable vsg, consuming it (and incrementing wiov->i). */
> +ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len);
> +
> +/* Copy bytes into writable vsg, consuming it (and incrementing wiov->i). */
> +ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
> +			     const void *src, size_t len);
> +
> +/* Mark a descriptor as used.  Sets notify if you should fire eventfd. */
> +int vringh_complete_user(struct vringh *vrh, u16 head, u32 len,
> +			 bool *notify);
> +
> +/* Pretend we've never seen descriptor (for easy error handling). */
> +void vringh_abandon_user(struct vringh *vrh, unsigned int num);
> +
> +/* Helpers for kernelspace vrings. */
> +int vringh_init_kern(struct vringh *vrh, u32 features,
> +		     unsigned int num, bool weak_barriers,
> +		     struct vring_desc *desc,
> +		     struct vring_avail *avail,
> +		     struct vring_used *used);
> +
> +int vringh_getdesc_kern(struct vringh *vrh,
> +			struct vringh_iov *riov,
> +			struct vringh_iov *wiov,
> +			u16 *head,
> +			gfp_t gfp);
> +
> +ssize_t vringh_iov_pull_kern(struct vringh_iov *riov, void *dst, size_t len);
> +ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
> +			     const void *src, size_t len);
> +void vringh_abandon_kern(struct vringh *vrh, unsigned int num);
> +int vringh_complete_kern(struct vringh *vrh, u16 head, u32 len, bool *notify);
> +
> +bool vringh_notify_enable_kern(struct vringh *vrh);
> +void vringh_notify_disable_kern(struct vringh *vrh);
> +
> +#endif /* _LINUX_VRINGH_H */
> -- 
> 1.7.10.4
