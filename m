From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 3/25] [PATCH] irq_flags / halt routines
Date: Thu, 9 Aug 2007 04:29:38 -0300
Message-ID: <5d6222a80708090029o13577af4j4c99b46612b31ef7__26776.1082192466$1186644755$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546763582-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<200708081114.21260.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081114.21260.ak@suse.de>
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
> > +#ifdef CONFIG_PARAVIRT
> > +#include <asm/paravirt.h>
> > +#  ifdef CONFIG_X86_VSMP
> > +static inline int raw_irqs_disabled_flags(unsigned long flags)
> > +{
> > +     return !(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC);
> > +}
> > +#  else
> > +static inline int raw_irqs_disabled_flags(unsigned long flags)
> > +{
> > +     return !(flags & X86_EFLAGS_IF);
> > +}
> > +#  endif
>
> You should really turn the vsmp special case into a paravirt client first
> instead of complicating all this even more.
Looking at it more carefully, it turns out that those functions are
not eligible for being paravirt clients. They do no privileged
operation at all. In fact, all they do is bit manipulation.
That said, the code got a little bit cleaner by moving them down, and so I did.

But later on, you voiced concern about making CONFIG_PARAVIRT depend
on !VSMP. (and said it would be okay, because these functions would be
paravirt clients: but they won't) Given this updated picture, what's
your position about this?

Again, as they don't do anything besides bit manipulation, I don't
think they will stop VSMP from working with PARAVIRT.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
