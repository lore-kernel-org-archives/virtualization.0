From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
Date: Mon, 6 Jul 2020 21:23:26 +0200
Message-ID: <CANpmjNP9pb4_2S8sf+Ty2ZqtMxWSrBEosDx2wuL2OQnA9YFt9A@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck> <20200706160023.GB10992@arm.com> <20200706183542.GB23766@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200706183542.GB23766@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, Android Kernel Team <kernel-team@android.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 6 Jul 2020 at 20:35, Will Deacon <will@kernel.org> wrote:
> On Mon, Jul 06, 2020 at 05:00:23PM +0100, Dave Martin wrote:
> > On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> > > On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > > > Also, can you illustrate code that can only be unsafe with Clang LTO?
> > >
> > > I don't have a concrete example, but it's an ongoing concern over on the LTO
> > > thread [1], so I cooked this to show one way we could deal with it. The main
> > > concern is that the whole-program optimisations enabled by LTO may allow the
> > > compiler to enumerate possible values for a pointer at link time and replace
> > > an address dependency between two loads with a control dependency instead,
> > > defeating the dependency ordering within the CPU.
> >
> > Why can't that happen without LTO?
>
> It could, but I'd argue that it's considerably less likely because there
> is less information available to the compiler to perform these sorts of
> optimisations. It also doesn't appear to be happening in practice.
>
> The current state of affairs is that, if/when we catch the compiler
> performing harmful optimistations, we look for a way to disable them.
> However, there are good reasons to enable LTO, so this is one way to
> do that without having to worry about the potential impact on dependency
> ordering.

If it's of any help, I'll see if we can implement that warning in LLVM
if data dependencies somehow disappear (although I don't have any
cycles to pursue right now myself). Until then, short of manual
inspection or encountering a bug in the wild, there is no proof any of
this happens or doesn't happen.

Also, as some anecdotal evidence it's extremely unlikely, even with
LTO: looking at the passes that LLVM runs, there are a number of
passes that seem to want to eliminate basic blocks, thereby getting
rid of branches. Intuitively, it makes sense, because branches are
expensive on most architectures (for GPU targets, I think it tries
even harder to get rid of branches). If we extend our reasoning and
assumptions of LTO's aggressiveness in that direction, we might
actually end up with fewer branches. That might be beneficial for the
data dependencies we worry about (but not so much for control
dependencies we want to keep). Still, no point in speculating (no pun
intended) until we have hard data what actually happens. :-)

Thanks,
-- Marco
