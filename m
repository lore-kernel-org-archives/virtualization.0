From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] xen: Use wmb instead of rmb in xen_evtchn_do_upcall().
Date: Tue, 10 Jun 2008 17:41:39 +1000
Message-ID: <200806101741.39871.nickpiggin__20240.7765355476$1213108869$gmane$org@yahoo.com.au>
References: <20080610073532.GG24381%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080610073532.GG24381%yamahata@valinux.co.jp>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-ia64-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Samuel Thibault <samuel.thibault@eu.citrix.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 10 June 2008 17:35, Isaku Yamahata wrote:
> This patch is ported one from 534:77db69c38249 of linux-2.6.18-xen.hg.
> Use wmb instead of rmb to enforce ordering between
> evtchn_upcall_pending and evtchn_pending_sel stores
> in xen_evtchn_do_upcall().

There are a whole load of places in the kernel that should be using
smp_ variants of memory barriers. This seemed to me like one of them,
but I could be wrong.

Also, if you do that can you get rid of the ifdef? If it really *really*
mattered, we could introduce smp_mb before/after xchg... but if you
use smp_wmb anyway then it definitely does not matter because that is a
noop on x86.

Thanks,
Nick

>
 Cc: Samuel Thibault <samuel.thibault@eu.citrix.com>
> Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
> ---
>  drivers/xen/events.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
> index 73d78dc..332dd63 100644
> --- a/drivers/xen/events.c
> +++ b/drivers/xen/events.c
> @@ -529,7 +529,7 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
>
>  #ifndef CONFIG_X86 /* No need for a barrier -- XCHG is a barrier on x86.
> */ /* Clear master flag /before/ clearing selector flag. */
> -		rmb();
> +		wmb();
>  #endif
>  		pending_words = xchg(&vcpu_info->evtchn_pending_sel, 0);
>  		while (pending_words != 0) {
