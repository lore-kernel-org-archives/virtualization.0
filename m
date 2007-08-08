From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
 entry.S
Date: Wed, 8 Aug 2007 07:52:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708080740490.5921__28917.2003082514$1186574130$gmane$org@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081138.23018.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


Hi Andi,

Thanks for all the comments, it's greatly appreciated.

On Wed, 8 Aug 2007, Andi Kleen wrote:

>
> > +#define SYSRETQ						\
> > +			movq	%gs:pda_oldrsp,%rsp;	\
> > +			swapgs;				\
> > +			sysretq;
>
> When the macro does more than sysret it should have a different
> name

Noted. Do you have a better idea? Something like SETSTACK_SWAPGS_SYSRETQ?

>
>
> >   */
> >  	.globl int_ret_from_sys_call
> >  int_ret_from_sys_call:
> > -	cli
> > +	DISABLE_INTERRUPTS(CLBR_ANY)
>
> ANY? There are certainly some registers alive at this point like rax

Glauber will need to address this, this is his code ;-)

>
> >  retint_restore_args:
> > -	cli
> > +	DISABLE_INTERRUPTS(CLBR_ANY)
>
> Similar.
>
>
> >  	/*
> >  	 * The iretq could re-enable interrupts:
> >  	 */
> > @@ -566,10 +587,14 @@ retint_restore_args:
> >  restore_args:
> >  	RESTORE_ARGS 0,8,0
> >  iret_label:
> > -	iretq
> > +#ifdef CONFIG_PARAVIRT
> > +	INTERRUPT_RETURN
> > +ENTRY(native_iret)
>
> ENTRY adds alignment. Why do you need that export anyways?

The paravirt ops struct points to it.

>
> > +#endif
> > +1:	iretq
> >
> >  	.section __ex_table,"a"
> > -	.quad iret_label,bad_iret
> > +	.quad 1b, bad_iret
>
> iret_label seems more expressive to me than 1

The reason for this change is because of the added:
#ifdef CONFIG_PARAVIRT
	INTERRUPT_RETURN
ENTRY(native_iret)
#endif

If we are paravirt ops, we need the iretq in the exception table, not the
paravit ops function call.  Since that function call may simply call the
native_iretq, and if we take a fault at the iretq, it wont be in the
exception table.

>
> > +	ENABLE_INTERRUPTS(CLBR_NONE)
>
> In many of the CLBR_NONEs there are actually some registers free;
> but it might be safer to keep it this way. But if some client can get
> significantly better code with one or two free registers it might
> be worthwhile to investigate.

Glauber, that comment is for you.

>
> > -	swapgs
> > +	SWAPGS_NOSTACK
>
> There's still stack here

OK, bad name then. How about SWAPGS_UNTRUSTED_STACK?

From earlier in the file where SWAPGS_NOSTACK is declared we have:


/* Currently paravirt can't handle swapgs nicely when we
 * don't have a stack.  So we either find a way around these
 * or just fault and emulate if a guest tries to call swapgs
 * directly.
 *
 * Either way, this is a good way to document that we don't
 * have a reliable stack.
 */
#define SWAPGS_NOSTACK		swapgs

>
> >  paranoid_restore\trace:
> >  	RESTORE_ALL 8
> > -	iretq
> > +	INTERRUPT_RETURN
>
> I suspect Xen will need much more changes anyways because of its
> ring 3 guest. Are these changes sufficient for lguest?

Probably not, but this part of the code I don't fully understand. But just
doing this doesn't break lguest.  But perhaps it only did not break it yet
;-)


Thanks,

-- Steve
