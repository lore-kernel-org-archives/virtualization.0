From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Wed, 8 Aug 2007 11:49:22 -0300
Message-ID: <5d6222a80708080749t35c5c0ceo8b3b8f0cce50c666__14501.9434429289$1186585030$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546847263-git-send-email-gcosta@redhat.com>
	<11865468513077-git-send-email-gcosta@redhat.com>
	<200708081200.13669.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081200.13669.ak@suse.de>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/8/07, Andi Kleen <ak@suse.de> wrote:
>
> Is this really synced with the latest version of the i386 code?
Roasted already commented on this. I will check out and change it here.

>
> > +#ifdef CONFIG_PARAVIRT
> > +#include <asm/paravirt.h>
> > +#endif
>
>
> > +#include <linux/errno.h>
> > +#include <linux/module.h>
> > +#include <linux/efi.h>
> > +#include <linux/bcd.h>
> > +#include <linux/start_kernel.h>
> > +
> > +#include <asm/bug.h>
> > +#include <asm/paravirt.h>
> > +#include <asm/desc.h>
> > +#include <asm/setup.h>
> > +#include <asm/irq.h>
> > +#include <asm/delay.h>
> > +#include <asm/fixmap.h>
> > +#include <asm/apic.h>
> > +#include <asm/tlbflush.h>
> > +#include <asm/msr.h>
> > +#include <asm/page.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/proto.h>
> > +#include <asm/e820.h>
> > +#include <asm/time.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/smp.h>
> > +#include <asm/irqflags.h>
>
>
> Are the includes really all needed?
delay.h is not needed anymore. Most of them, could be maybe moved to
paravirt.c , which is the one that really needs all the native_
things. Yeah, it will be better code this way, will change.

>
> > +     if (opfunc == NULL)
> > +             /* If there's no function, patch it with a ud2a (BUG) */
> > +             ret = paravirt_patch_insns(site, len, start_ud2a, end_ud2a);
>
> This will actually give corrupted BUGs because you don't supply
> the full inline BUG header. Perhaps another trap would be better.

You mean this:
> > +#include <asm/bug.h>
?

>
> > +EXPORT_SYMBOL(paravirt_ops);
>
> Definitely _GPL at least.
Sure.

>
> Should be native_paravirt_ops I guess

makes sense.

> > +
> > + * This generates an indirect call based on the operation type number.
>
> The macros here don't
>

> > +static inline unsigned long read_msr(unsigned int msr)
> > +{
> > +     int __err;
>
> No need for __ in inlines
Right. Thanks.


> > +/* The paravirtualized I/O functions */
> > +static inline void slow_down_io(void) {
>
> I doubt this needs to be inline and it's large
In a second look, i386 have such a function in io.h because they need
slow_down_io in a bunch of I/O instructions. It seems that we do not.
Could we just get rid of it, then?

> > +     __asm__ __volatile__(paravirt_alt(PARAVIRT_CALL)
>
> No __*__ in new code please

Yup, will fix.

> > +                          : "=a"(f)
> > +                          : paravirt_type(save_fl),
> > +                            paravirt_clobber(CLBR_RAX)
> > +                          : "memory", "cc");
> > +     return f;
> > +}
> > +
> > +static inline void raw_local_irq_restore(unsigned long f)
> > +{
> > +     __asm__ __volatile__(paravirt_alt(PARAVIRT_CALL)
> > +                          :
> > +                          : "D" (f),
>
> Have you investigated if a different input register generates better/smaller
> code? I would assume rdi to be usually used already for the caller's
> arguments so it will produce spilling
>
> Similar for the rax return in the other functions.
I don't think we can do different. These functions can be patched, and
if it happens, they will put their return value in rax. So we'd better
expect it there.
Same goes for rdi, as they will expect the value to be there as an input.

I don't think it will spill in the normal case, as rdi is already the
parameter. So the compiler will just leave it there, untouched.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
