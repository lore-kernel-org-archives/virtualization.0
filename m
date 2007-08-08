From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 3/25] [PATCH] irq_flags / halt routines
Date: Wed, 8 Aug 2007 11:23:37 -0300
Message-ID: <5d6222a80708080723h6efbf857yd707e85ccb713b6__41018.030109308$1186583207$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081114.21260.ak@suse.de>
	<5d6222a80708080710n296f6da8i1dc08d914baeb27a@mail.gmail.com>
	<200708081614.52391.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081614.52391.ak@suse.de>
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
> On Wednesday 08 August 2007 16:10:28 Glauber de Oliveira Costa wrote:
> > On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> > >
> > > > +#ifdef CONFIG_PARAVIRT
> > > > +#include <asm/paravirt.h>
> > > > +#  ifdef CONFIG_X86_VSMP
> > > > +static inline int raw_irqs_disabled_flags(unsigned long flags)
> > > > +{
> > > > +     return !(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC);
> > > > +}
> > > > +#  else
> > > > +static inline int raw_irqs_disabled_flags(unsigned long flags)
> > > > +{
> > > > +     return !(flags & X86_EFLAGS_IF);
> > > > +}
> > > > +#  endif
> > >
> > > You should really turn the vsmp special case into a paravirt client first
> > > instead of complicating all this even more.
> >
> > By "client" you mean a user of the paravirt interface?
>
> Yes

Ohhh, I see. You're talking about just the first piece of code inside
the #ifdef CONFIG_PARAVIRT. In this case yes, I agree with you. It can
be done.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
