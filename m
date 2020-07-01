From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/18] compiler.h: Split {READ,WRITE}_ONCE definitions
 out into rwonce.h
Date: Wed, 1 Jul 2020 11:16:04 +0100
Message-ID: <20200701101603.GB14959@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-3-will@kernel.org>
 <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, alpha <linux-alpha@vger.k>
List-Id: virtualization@lists.linuxfoundation.org

Hi Arnd,

On Tue, Jun 30, 2020 at 09:11:32PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 30, 2020 at 7:37 PM Will Deacon <will@kernel.org> wrote:
> >
> > In preparation for allowing architectures to define their own
> > implementation of the READ_ONCE() macro, move the generic
> > {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> > file and into a new 'rwonce.h' header under 'asm-generic'.
> >
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  include/asm-generic/Kbuild   |  1 +
> >  include/asm-generic/rwonce.h | 91 ++++++++++++++++++++++++++++++++++++
> >  include/linux/compiler.h     | 83 +-------------------------------
> 
> Very nice, this has the added benefit of allowing us to stop including
> asm/barrier.h once linux/compiler.h gets changed to not include
> asm/rwonce.h.

Yeah, with this series linux/compiler.h _does_ include asm/rwonce.h because
otherwise there are many callers to fix up, but that could be addressed
subsequently, I suppose.

> The asm/barrier.h header has a circular dependency, pulling in
> linux/compiler.h itself.

Hmm. Once smp_read_barrier_depends() disappears, I could actually remove
the include of <asm/barrier.h> from asm-generic/rwonce.h. It would have to
remain for arch/alpha/, however, since we need the barrier definitions to
implement READ_ONCE(). I can probably also replace the include of
<linux/compiler.h> in asm-generic/barrier.h with <asm/rwonce.h> too (so it's
still circular, but at least a lot simpler).

I'll have a play...

Will
