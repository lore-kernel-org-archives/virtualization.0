From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered
 implementation
Date: Thu, 2 Jul 2020 12:18:33 +0100
Message-ID: <20200702111832.GC16418@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local>
 <20200702094833.GA16248@willie-the-truck>
 <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, alpha <linux-alpha@vger.k>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 02, 2020 at 12:08:41PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 2, 2020 at 11:48 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:
> > > On Tue, Jun 30, 2020 at 06:37:20PM +0100, Will Deacon wrote:
> > > > -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> > > > +#define __smp_load_acquire(p)                                              \
> > > > +({                                                                 \
> > > > +   __unqual_scalar_typeof(*p) ___p1 =                              \
> > > > +           (*(volatile typeof(___p1) *)(p));                       \
> > > > +   compiletime_assert_atomic_type(*p);                             \
> > > > +   ___p1;                                                          \
> > > > +})
> > >
> > > Sorry if I'm being thick, but doesn't this need a barrier after the
> > > volatile access to provide the acquire semantic?
> > >
> > > IIUC prior to this commit alpha would have used the asm-generic
> > > __smp_load_acquire, i.e.
> > >
> > > | #ifndef __smp_load_acquire
> > > | #define __smp_load_acquire(p)                                           \
> > > | ({                                                                      \
> > > |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> > > |         compiletime_assert_atomic_type(*p);                             \
> > > |         __smp_mb();                                                     \
> > > |         (typeof(*p))___p1;                                              \
> > > | })
> > > | #endif
> 
> I also have a question that I didn't dare ask when the same
> code came up before (I guess it's also what's in the kernel today):
> 
> With the cast to 'typeof(*p)' at the end, doesn't that mean we
> lose the effect of __unqual_scalar_typeof() again, so any "volatile"
> pointer passed into __READ_ONCE_SCALAR() or
> __smp_load_acquire() still leads to a volatile load of the original
> variable, plus another volatile access to ___p1 after
> spilling it to the stack as a non-volatile variable?

Not sure I follow you here, but I can confirm that what you're worried
about doesn't happen for the usual case of a pointer-to-volatile scalar.

For example, ignoring dependency ordering:

unsigned long foo(volatile unsigned long *p)
{
	return smp_load_acquire(p) + 1;
}

Ends up looking like:

	unsigned long ___p1 = *(const volatile unsigned long *)p;
	smp_mb();
	(volatile unsigned long)___p1;

My understanding is that casting a non-pointer type to volatile doesn't
do anything, so we're good.

On the other hand, you can still cause the stack reload if you use volatile
pointers to volatile:

volatile unsigned long *bar(volatile unsigned long * volatile *ptr)
{
	return READ_ONCE(*ptr);
}

but this is pretty weird code, I think.

Will
