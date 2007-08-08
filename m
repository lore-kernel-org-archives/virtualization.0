From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/25] [PATCH] irq_flags / halt routines
Date: Wed, 8 Aug 2007 16:14:52 +0200
Message-ID: <200708081614.52391.ak__1723.82811219922$1186582793$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081114.21260.ak@suse.de>
	<5d6222a80708080710n296f6da8i1dc08d914baeb27a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708080710n296f6da8i1dc08d914baeb27a@mail.gmail.com>
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
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 08 August 2007 16:10:28 Glauber de Oliveira Costa wrote:
> On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> >
> > > +#ifdef CONFIG_PARAVIRT
> > > +#include <asm/paravirt.h>
> > > +#  ifdef CONFIG_X86_VSMP
> > > +static inline int raw_irqs_disabled_flags(unsigned long flags)
> > > +{
> > > +     return !(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC);
> > > +}
> > > +#  else
> > > +static inline int raw_irqs_disabled_flags(unsigned long flags)
> > > +{
> > > +     return !(flags & X86_EFLAGS_IF);
> > > +}
> > > +#  endif
> >
> > You should really turn the vsmp special case into a paravirt client first
> > instead of complicating all this even more.
> 
> By "client" you mean a user of the paravirt interface?

Yes

> 
> > > +#ifndef CONFIG_PARAVIRT
> > > +#define raw_safe_halt        native_raw_safe_halt
> > > +#define halt         native_halt
> > > +#endif /* ! CONFIG_PARAVIRT */
> >
> > This seems inconsistent
> Sorry andi. Can't see why. Could you elaborate?

Hmm, must have misread it. It's ok

-Andi
