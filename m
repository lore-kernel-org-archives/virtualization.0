From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Date: Wed, 1 Jul 2020 11:19:23 +0100
Message-ID: <20200701101922.GC14959@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Sami Tolvanen <samitolvanen@google.com>, alpha <linux-alpha@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, virtualization@lists.linux-foundation.org, Android Kernel Team <kernel-team@android.com>, Boqun Feng <boqun.feng@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 09:25:03PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 30, 2020 at 7:39 PM Will Deacon <will@kernel.org> wrote:
> > +#define __READ_ONCE(x)                                                 \
> > +({                                                                     \
> > +       int atomic = 1;                                                 \
> > +       union { __unqual_scalar_typeof(x) __val; char __c[1]; } __u;    \
> > +       typeof(&(x)) __x = &(x);                                        \
> > +       switch (sizeof(x)) {                                            \
> ...
> > +       atomic ? (typeof(x))__u.__val : (*(volatile typeof(x) *)__x);   \
> > +})
> 
> This expands (x) nine times (five in __unqual_scala_typeof()), which can
> lead to significant code bloat after preprocessing if something passes a
> compound expression into READ_ONCE().
> The compiler works it out eventually, but we've seen an actual slowdown
> in compile speed from this recently, especially on clang.
> 
> I think if you move the
> 
>         typeof(&(x)) __x = &(x);
> 
> line first, all other instances can use typeof(*__x) instead of typeof(x)
> and avoid this problem.

Cheers, I was only thinking about side-effects when I wrote this, but
bloating built time is very unpopular, so I'll go with your suggestion.

> Once we make gcc-4.9 the minimum version,
> this could be further improved to
> 
>        __auto_type __x = &(x);

Is anybody working on moving to 4.9? I've seen the mails from Linus
championing it, but I thought there was a RHEL in support that people
might care about?

Will
