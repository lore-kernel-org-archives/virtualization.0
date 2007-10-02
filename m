From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH RFC] paravirt: cleanup lazy mode handling
Date: Tue, 02 Oct 2007 07:48:41 +0200
Message-ID: <4701DBB9.9020202@qumranet.com>
References: <470186C4.5080208@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752618AbXJBFtP@vger.kernel.org>
In-Reply-To: <470186C4.5080208@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <anthony@codemonkey.ws>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Currently, the set_lazy_mode pv_op is overloaded with 5 functions:
>  1. enter lazy cpu mode
>  2. leave lazy cpu mode
>  3. enter lazy mmu mode
>  4. leave lazy mmu mode
>  5. flush pending batched operations
>
> This complicates each paravirt backend, since it needs to deal with
> all the possible state transitions, handling flushing, etc. In
> particular, flushing is quite distinct from the other 4 functions, and
> seems to just cause complication.
>
> This patch removes the set_lazy_mode operation, and adds "enter" and
> "leave" lazy mode operations on mmu_ops and cpu_ops.  All the logic
> associated with enter and leaving lazy states is now in common code
> (basically BUG_ONs to make sure that no mode is current when entering
> a lazy mode, and make sure that the mode is current when leaving).
> Also, flush is handled in a common way, by simply leaving and
> re-entering the lazy mode.
>
> The result is that the Xen and VMI lazy mode implementations are much
> simpler; as would lguest's be.
>
>   

The code doesn't support having both lazy modes active at once.  Maybe 
that's not an issue, but aren't the two modes orthogonal?

> --- a/arch/i386/xen/multicalls.h
> +++ b/arch/i386/xen/multicalls.h
> @@ -35,7 +35,7 @@ void xen_mc_flush(void);
>  /* Issue a multicall if we're not in a lazy mode */
>  static inline void xen_mc_issue(unsigned mode)
>  {
> -	if ((xen_get_lazy_mode() & mode) == 0)
> +	if ((paravirt_get_lazy_mode() & mode) == 0)
>  		xen_mc_flush();

This snippet looks like it wants to support concurrently active lazy modes.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
