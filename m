From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
	entry.S
Date: Wed, 8 Aug 2007 11:38:21 +0200
Message-ID: <200708081138.23018.ak__1415.90750213272$1186567574$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865468243612-git-send-email-gcosta@redhat.com>
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


> +#define SYSRETQ						\
> +			movq	%gs:pda_oldrsp,%rsp;	\
> +			swapgs;				\
> +			sysretq;

When the macro does more than sysret it should have a different
name


>   */
>  	.globl int_ret_from_sys_call
>  int_ret_from_sys_call:
> -	cli
> +	DISABLE_INTERRUPTS(CLBR_ANY)

ANY? There are certainly some registers alive at this point like rax

>  retint_restore_args:
> -	cli
> +	DISABLE_INTERRUPTS(CLBR_ANY)

Similar.


>  	/*
>  	 * The iretq could re-enable interrupts:
>  	 */
> @@ -566,10 +587,14 @@ retint_restore_args:
>  restore_args:
>  	RESTORE_ARGS 0,8,0
>  iret_label:
> -	iretq
> +#ifdef CONFIG_PARAVIRT
> +	INTERRUPT_RETURN
> +ENTRY(native_iret)

ENTRY adds alignment. Why do you need that export anyways? 

> +#endif
> +1:	iretq
>
>  	.section __ex_table,"a"
> -	.quad iret_label,bad_iret
> +	.quad 1b, bad_iret

iret_label seems more expressive to me than 1

> +	ENABLE_INTERRUPTS(CLBR_NONE)

In many of the CLBR_NONEs there are actually some registers free;
but it might be safer to keep it this way. But if some client can get 
significantly better code with one or two free registers it might 
be worthwhile to investigate.

> -	swapgs
> +	SWAPGS_NOSTACK

There's still stack here

>  paranoid_restore\trace:
>  	RESTORE_ALL 8
> -	iretq
> +	INTERRUPT_RETURN

I suspect Xen will need much more changes anyways because of its
ring 3 guest. Are these changes sufficient for lguest?

-Andi
