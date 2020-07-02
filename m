From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered implementation
Date: Thu, 2 Jul 2020 13:39:10 +0200
Message-ID: <CAK8P3a3VrEkDf8t1CCsY+g7rtXkqBsiPOr97b1yRbz8NpjdfFA@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local> <20200702094833.GA16248@willie-the-truck>
 <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com> <20200702111832.GC16418@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200702111832.GC16418@willie-the-truck>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, alpha <linux-alpha@vger.k>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 2, 2020 at 1:18 PM Will Deacon <will@kernel.org> wrote:
> On Thu, Jul 02, 2020 at 12:08:41PM +0200, Arnd Bergmann wrote:
> > On Thu, Jul 2, 2020 at 11:48 AM Will Deacon <will@kernel.org> wrote:
> > > On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:

> Not sure I follow you here, but I can confirm that what you're worried
> about doesn't happen for the usual case of a pointer-to-volatile scalar.
>
> For example, ignoring dependency ordering:
>
> unsigned long foo(volatile unsigned long *p)
> {
>         return smp_load_acquire(p) + 1;
> }
>
> Ends up looking like:
>
>         unsigned long ___p1 = *(const volatile unsigned long *)p;
>         smp_mb();
>         (volatile unsigned long)___p1;
>
> My understanding is that casting a non-pointer type to volatile doesn't
> do anything, so we're good.

Right, I mixed up the correct

        (typeof(*p))___p;

with the incorrect

       *typeof(p)&___p;

which would dereference a volatile pointer and cause the
problem.

The code is all fine then.

    Arnd
