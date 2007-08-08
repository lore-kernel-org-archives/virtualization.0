From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
	entry.S
Date: Wed, 8 Aug 2007 10:58:06 -0300
Message-ID: <5d6222a80708080658j780667c4o52e924f8690f2a85__48975.0921763063$1186581701$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081138.23018.ak@suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Thank you for the attention, andi

let's go:

On 8/8/07, Andi Kleen <ak@suse.de> wrote:
>
> > +#define SYSRETQ                                              \
> > +                     movq    %gs:pda_oldrsp,%rsp;    \
> > +                     swapgs;                         \
> > +                     sysretq;
>
> When the macro does more than sysret it should have a different
> name
That's fair. Again, suggestions are welcome. Maybe SYSCALL_RETURN ?

> >   */
> >       .globl int_ret_from_sys_call
> >  int_ret_from_sys_call:
> > -     cli
> > +     DISABLE_INTERRUPTS(CLBR_ANY)
>
> ANY? There are certainly some registers alive at this point like rax
yes, this one is wrong. Thanks for the catch

> >  retint_restore_args:
> > -     cli
> > +     DISABLE_INTERRUPTS(CLBR_ANY)
>
> Similar.
I don't think so. They are live here, but restore_args follows, so we
can safely clobber anything here. Right?

>
> >       /*
> >        * The iretq could re-enable interrupts:
> >        */
> > @@ -566,10 +587,14 @@ retint_restore_args:
> >  restore_args:
> >       RESTORE_ARGS 0,8,0
> >  iret_label:
> > -     iretq
> > +#ifdef CONFIG_PARAVIRT
> > +     INTERRUPT_RETURN
> > +ENTRY(native_iret)
>
> ENTRY adds alignment. Why do you need that export anyways?
Just went on the flow. Will change.

> > +#endif
> > +1:   iretq
> >
> >       .section __ex_table,"a"
> > -     .quad iret_label,bad_iret
> > +     .quad 1b, bad_iret
>
> iret_label seems more expressive to me than 1

fair.

> > +     ENABLE_INTERRUPTS(CLBR_NONE)
>
> In many of the CLBR_NONEs there are actually some registers free;
> but it might be safer to keep it this way. But if some client can get
> significantly better code with one or two free registers it might
> be worthwhile to investigate.
That's exactly what I had in mind. I'd highly prefer to keep it this
way until it is merged, and we are sure all the rest is stable

> > -     swapgs
> > +     SWAPGS_NOSTACK
>
> There's still stack here

Yes, but it is not safe to use. I think Roasted addressed it later on.

> >  paranoid_restore\trace:
> >       RESTORE_ALL 8
> > -     iretq
> > +     INTERRUPT_RETURN
>
> I suspect Xen will need much more changes anyways because of its
> ring 3 guest. Are these changes sufficient for lguest?

Yes, they are sufficient for lguest.
Does any xen folks have any comment?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
