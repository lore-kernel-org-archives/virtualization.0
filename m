From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Date: Mon, 6 Jul 2020 19:35:43 +0100
Message-ID: <20200706183542.GB23766@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200706160023.GB10992@arm.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, kernel-team@android.com, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 06, 2020 at 05:00:23PM +0100, Dave Martin wrote:
> On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> > On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > > Also, can you illustrate code that can only be unsafe with Clang LTO?
> > 
> > I don't have a concrete example, but it's an ongoing concern over on the LTO
> > thread [1], so I cooked this to show one way we could deal with it. The main
> > concern is that the whole-program optimisations enabled by LTO may allow the
> > compiler to enumerate possible values for a pointer at link time and replace
> > an address dependency between two loads with a control dependency instead,
> > defeating the dependency ordering within the CPU.
> 
> Why can't that happen without LTO?

It could, but I'd argue that it's considerably less likely because there
is less information available to the compiler to perform these sorts of
optimisations. It also doesn't appear to be happening in practice.

The current state of affairs is that, if/when we catch the compiler
performing harmful optimistations, we look for a way to disable them.
However, there are good reasons to enable LTO, so this is one way to
do that without having to worry about the potential impact on dependency
ordering.

Will
