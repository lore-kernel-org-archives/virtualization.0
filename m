From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC] vhost: don't use kmap() to log dirty pages
Date: Tue, 7 May 2019 08:47:53 -0700
Message-ID: <20190507154753.GA8809__48637.9355703079$1557244087$gmane$org@infradead.org>
References: <1557195809-12373-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1557195809-12373-1-git-send-email-jasowang@redhat.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org, mst@redhat.com, Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@HansenPartnership.com>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 06, 2019 at 10:23:29PM -0400, Jason Wang wrote:
> Note: there're archs (few non popular ones) that don't implement
> futex helper, we can't log dirty pages. We can fix them on top or
> simply disable LOG_ALL features of vhost.

That means vhost now has to depend on HAVE_FUTEX_CMPXCHG to make
sure we have a working implementation.


>  #include <linux/sched/signal.h>
>  #include <linux/interval_tree_generic.h>
>  #include <linux/nospec.h>
> +#include <asm/futex.h>

Also please include the futex maintainers to make sure they are fine
with this first usage of <asm/futex.h> outside of kernel/futex.c.


> +static int set_bit_to_user(int nr, u32 __user *addr)
>  {
>  	unsigned long log = (unsigned long)addr;
>  	struct page *page;
> +	u32 old_log;
>  	int r;
>  
>  	r = get_user_pages_fast(log, 1, 1, &page);
>  	if (r < 0)
>  		return r;
>  	BUG_ON(r != 1);
> +
> +	r = futex_atomic_cmpxchg_inatomic(&old_log, addr, 0, 0);
> +	if (r < 0)
> +		return r;
> +
> +	old_log |= 1 << nr;
> +	r = put_user(old_log, addr);
> +	if (r < 0)
> +		return r;

And this just looks odd to me.  Why do we need the futex call to
replace a 0 value with 0?  Why does it still duplicate the
put_user?  This doesn't look like actually working code to me.

Also don't we need a pagefault_disable() around
futex_atomic_cmpxchg_inatomic?
