From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered
 implementation
Date: Thu, 2 Jul 2020 10:48:33 +0100
Message-ID: <20200702094833.GA16248@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200702093239.GA15391@C02TD0UTHF1T.local>
Sender: linux-alpha-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualization@lists.linux-foundation.orgkern
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:
> On Tue, Jun 30, 2020 at 06:37:20PM +0100, Will Deacon wrote:
> > -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> > +#define __smp_load_acquire(p)						\
> > +({									\
> > +	__unqual_scalar_typeof(*p) ___p1 =				\
> > +		(*(volatile typeof(___p1) *)(p));			\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	___p1;								\
> > +})
> 
> Sorry if I'm being thick, but doesn't this need a barrier after the
> volatile access to provide the acquire semantic?
> 
> IIUC prior to this commit alpha would have used the asm-generic
> __smp_load_acquire, i.e.
> 
> | #ifndef __smp_load_acquire
> | #define __smp_load_acquire(p)                                           \
> | ({                                                                      \
> |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> |         compiletime_assert_atomic_type(*p);                             \
> |         __smp_mb();                                                     \
> |         (typeof(*p))___p1;                                              \
> | })
> | #endif
> 
> ... where the __smp_mb() would be alpha's mb() from earlier in the patch
> context, i.e.
> 
> | #define mb() __asm__ __volatile__("mb": : :"memory")
> 
> ... so don't we need similar before returning ___p1 above in
> __smp_load_acquire() (and also matching the old read_barrier_depends())?
> 
> [...]
> 
> > +#include <asm/barrier.h>
> > +
> > +/*
> > + * Alpha is apparently daft enough to reorder address-dependent loads
> > + * on some CPU implementations. Knock some common sense into it with
> > + * a memory barrier in READ_ONCE().
> > + */
> > +#define __READ_ONCE(x)	__smp_load_acquire(&(x))
> 
> As above, I don't see a memory barrier implied here, so this doesn't
> look quite right.

You're right, and Peter spotted the same thing off-list. I've reworked
locally so that the mb() ends up in __READ_ONCE() and __smp_load_acquire()
calles __READ_ONCE() instead of the other way round (which made more
sense before the rework in the merge window).

Will
