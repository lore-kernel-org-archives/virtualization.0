From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/25] [PATCH] irq_flags / halt routines
Date: Wed, 8 Aug 2007 11:14:19 +0200
Message-ID: <200708081114.21260.ak__35058.0432372682$1186567651$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546763582-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865467662182-git-send-email-gcosta@redhat.com>
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
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#  ifdef CONFIG_X86_VSMP
> +static inline int raw_irqs_disabled_flags(unsigned long flags)
> +{
> +	return !(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC);
> +}
> +#  else
> +static inline int raw_irqs_disabled_flags(unsigned long flags)
> +{
> +	return !(flags & X86_EFLAGS_IF);
> +}
> +#  endif

You should really turn the vsmp special case into a paravirt client first 
instead of complicating all this even more. 

> +#ifndef CONFIG_PARAVIRT
> +#define raw_safe_halt	native_raw_safe_halt
> +#define halt		native_halt
> +#endif /* ! CONFIG_PARAVIRT */

This seems inconsistent

-Andi
