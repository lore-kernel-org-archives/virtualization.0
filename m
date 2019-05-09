From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2] vhost: don't use kmap() to log dirty pages
Date: Thu, 9 May 2019 09:18:22 -0400
Message-ID: <20190509090433-mutt-send-email-mst__1326.73194618604$1557407926$gmane$org@kernel.org>
References: <1557406680-4087-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1557406680-4087-1-git-send-email-jasowang@redhat.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 09, 2019 at 08:58:00AM -0400, Jason Wang wrote:
> Vhost log dirty pages directly to a userspace bitmap through GUP and
> kmap_atomic() since kernel doesn't have a set_bit_to_user()
> helper. This will cause issues for the arch that has virtually tagged
> caches. The way to fix is to keep using userspace virtual
> address. Fortunately, futex has arch_futex_atomic_op_inuser() which
> could be used for setting a bit to user.
> 
> Note:
> - There're archs (few non popular ones) that don't implement futex
>   helper, we can't log dirty pages. We can fix them e.g for non
>   virtually tagged archs implement a kmap fallback on top or simply
>   disable LOG_ALL features of vhost.
> - The helper also requires userspace pointer is located at 4-byte
>   boundary, need to check during dirty log setting

Why check? Round it down.

> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - switch to use arch_futex_atomic_op_inuser()
> ---
>  drivers/vhost/vhost.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 351af88..4e5a004 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -31,6 +31,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/interval_tree_generic.h>
>  #include <linux/nospec.h>
> +#include <asm/futex.h>
>  
>  #include "vhost.h"
>  
> @@ -1652,6 +1653,10 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  			r = -EFAULT;
>  			break;
>  		}
> +		if (p & 0x3) {
> +			r = -EINVAL;
> +			break;
> +		}
>  		for (i = 0; i < d->nvqs; ++i) {
>  			struct vhost_virtqueue *vq;
>  			void __user *base = (void __user *)(unsigned long)p;

That's an ABI change and might break some userspace. I don't think
it's necessary: you are changing individual bits anyway.

> @@ -1692,31 +1697,27 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
>  
> -/* TODO: This is really inefficient.  We need something like get_user()
> - * (instruction directly accesses the data, with an exception table entry
> - * returning -EFAULT). See Documentation/x86/exception-tables.txt.
> - */
> -static int set_bit_to_user(int nr, void __user *addr)
> +static int set_bit_to_user(int nr, u32 __user *addr)
>  {
>  	unsigned long log = (unsigned long)addr;
>  	struct page *page;
> -	void *base;
> -	int bit = nr + (log % PAGE_SIZE) * 8;
> +	u32 old;
>  	int r;
>  
>  	r = get_user_pages_fast(log, 1, 1, &page);

OK so the trick is that page is pinned so you don't expect
arch_futex_atomic_op_inuser below to fail.  get_user_pages_fast
guarantees page is not going away but does it guarantee PTE won't be
invaidated or write protected?

>  	if (r < 0)
>  		return r;
>  	BUG_ON(r != 1);
> -	base = kmap_atomic(page);
> -	set_bit(bit, base);
> -	kunmap_atomic(base);
> +
> +	r = arch_futex_atomic_op_inuser(FUTEX_OP_ADD, 1 << nr, &old, addr);
> +	/* TODO: fallback to kmap() when -ENOSYS? */
> +

Add a comment why this won't fail? Maybe warn on EFAULT?

Also down the road a variant that does not need tricks like this is
still nice to have.


>  	set_page_dirty_lock(page);
>  	put_page(page);
> -	return 0;
> +	return r;
>  }
>  
> -static int log_write(void __user *log_base,
> +static int log_write(u32 __user *log_base,
>  		     u64 write_address, u64 write_length)
>  {
>  	u64 write_page = write_address / VHOST_PAGE_SIZE;
> @@ -1726,12 +1727,10 @@ static int log_write(void __user *log_base,
>  		return 0;
>  	write_length += write_address % VHOST_PAGE_SIZE;
>  	for (;;) {
> -		u64 base = (u64)(unsigned long)log_base;
> -		u64 log = base + write_page / 8;
> -		int bit = write_page % 8;
> -		if ((u64)(unsigned long)log != log)
> -			return -EFAULT;
> -		r = set_bit_to_user(bit, (void __user *)(unsigned long)log);
> +		u32 __user *log = log_base + write_page / 32;
> +		int bit = write_page % 32;
> +
> +		r = set_bit_to_user(bit, log);
>  		if (r < 0)
>  			return r;
>  		if (write_length <= VHOST_PAGE_SIZE)
> -- 
> 1.8.3.1
