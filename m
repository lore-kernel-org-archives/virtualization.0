From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 07/12] Xen: Make events.c portable for ia64/xen support.
Date: Fri, 28 Mar 2008 13:27:58 -0700
Message-ID: <47ED54CE.7000007__30593.6807104901$1206736252$gmane$org@goop.org>
References: <12067044183207-git-send-email-yamahata@valinux.co.jp>
	<12067044180-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12067044180-git-send-email-yamahata@valinux.co.jp>
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
Cc: eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> +/* macro to avoid header inclusion dependncy hell */
> +#define xen_irqs_disabled(regs)	(!((regs)->flags & X86_EFLAGS_IF))
>   

This seems pretty generic.  Is there no suitable existing function?  
Could irqs_disabled_flags() be pressed into service?  I guess it depends 
on how ia64 (and other architectures) can get the saved flags state from 
the interrupt context.

> +
> +/* macro to avoid header inclusion dependncy hell */
> +#define xen_do_IRQ(irq, regs)			\
> +	do {					\
> +		(regs)->orig_ax = ~(irq);	\
> +		do_IRQ(regs);			\
> +	} while (0)
>   

It's not possible to put this somewhere it could be an inline function?  
It might be better to make it an out of line function then.

    J
