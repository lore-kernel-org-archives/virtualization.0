From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 07 Aug 2006 16:04:28 +1000
Message-ID: <1154930669.7642.12.camel@localhost.localdomain>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<200608070730.17813.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200608070730.17813.ak@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2006-08-07 at 07:30 +0200, Andi Kleen wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null
> > +++ b/include/asm-i386/no_paravirt.h
> =

> I can't say I like the name. After all that should be the normal
> case for a long time now ... native? normal? bareiron?

Yeah, I don't like it much either.  native.h doesn't say what the
alternative is.  native_paravirt.h is kind of contradictory.

> Also I would prefer if you split this file up a bit - the old
> processor/system/irqflags split wasn't too bad.

In the paravirt case, they all come into one ops structure, which has to
be declared in one place.

Of course, those headers can do:

#ifdef CONFIG_PARAVIRT
#include <asm/paravirt.h>
#else
...
#endif

I'll try this and see what happens.  Playing with the x86 headers can be
extremely hairy 8(

> > +
> > +/*
> > + * Set IOPL bits in EFLAGS from given mask
> > + */
> > +static inline void set_iopl_mask(unsigned mask)
> =

> This function can be completely written in C using local_save_flags()/loc=
al_restore_flags()
> Please do that. I guess it's still a good idea to keep it separated
> though because it might allow other optimizations.
> =

> e.g. i've been thinking about special casing IF changes in save/restore f=
lags =

> to optimize CPUs which have slow pushf/popf. If you already make sure
> all non IF manipulations of flags are separated that would help.
...
> > +
> > +/*
> > + * Clear and set 'TS' bit respectively
> > + */
> =

> The comment seems out of date (no set TS)
> =

> =

> > +#define clts() __asm__ __volatile__ ("clts")
> > +#define read_cr0() ({ \
> > +	unsigned int __dummy; \
> > +	__asm__ __volatile__( \
> =

> Maybe it's just me, but can't you just drop all these __s around
> asm and volatile? They are completely useless as far I know. =

> =

> Also the assembly will be easier readable if you just keep it on a single =

> line for the simple ones.

I'm just shuffling code here, and if the other approach works, I won't
even be doing that.

But I'm happy to submit a separate patch which cleans these...

Thanks!
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
