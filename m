From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Date: Wed, 1 Jul 2020 11:24:28 +0100
Message-ID: <20200701102427.GD14959@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Jason Wang <jasowang@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>, Josh Triplett <josh@joshtriplett.org>, LKML <linux-kernel@vger.kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Sami Tolvanen <samitolvanen@google.com>, linux-alpha@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, virtualization@lists.linux-foundation.org, Android Kernel Team <kernel-team@android.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 09:47:30PM +0200, Marco Elver wrote:
> On Tue, 30 Jun 2020 at 19:39, Will Deacon <will@kernel.org> wrote:
> >
> > When building with LTO, there is an increased risk of the compiler
> > converting an address dependency headed by a READ_ONCE() invocation
> > into a control dependency and consequently allowing for harmful
> > reordering by the CPU.
> >
> > Ensure that such transformations are harmless by overriding the generic
> > READ_ONCE() definition with one that provides acquire semantics when
> > building with LTO.
> >
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/vdso/Makefile   |  2 +-
> >  arch/arm64/kernel/vdso32/Makefile |  2 +-
> >  3 files changed, 65 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/rwonce.h
> 
> This seems reasonable, given we can't realistically tell the compiler
> about dependent loads. What (if any), is the performance impact? I
> guess this also heavily depends on the actual silicon.

Right, it depends both on the CPU micro-architecture and also the workload.
When we ran some basic tests, the overhead wasn't greater than the benefit
seen by enabling LTO, so it seems like a reasonable trade-off (given that
LTO is a dependency for CFI, so it's not just about performance).

Will
