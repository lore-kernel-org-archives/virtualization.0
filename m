From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
Date: Tue, 30 Jun 2020 21:47:30 +0200
Message-ID: <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-19-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualization@lists.linux-foundati
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 30 Jun 2020 at 19:39, Will Deacon <will@kernel.org> wrote:
>
> When building with LTO, there is an increased risk of the compiler
> converting an address dependency headed by a READ_ONCE() invocation
> into a control dependency and consequently allowing for harmful
> reordering by the CPU.
>
> Ensure that such transformations are harmless by overriding the generic
> READ_ONCE() definition with one that provides acquire semantics when
> building with LTO.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vdso/Makefile   |  2 +-
>  arch/arm64/kernel/vdso32/Makefile |  2 +-
>  3 files changed, 65 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/rwonce.h

This seems reasonable, given we can't realistically tell the compiler
about dependent loads. What (if any), is the performance impact? I
guess this also heavily depends on the actual silicon.

I do wonder, though, if there is some way to make the compiler do
something better for us. Clearly, implementing real
memory_order_consume hasn't worked out until today. But maybe the
compiler could promote dependent loads to acquires if it recognizes it
lost dependencies during optimizations. Just thinking out loud, it
probably still has some weird corner case that will break. ;-)

The other thing is that I'd be cautious blaming LTO, as I tried to
summarize here:
https://lore.kernel.org/kernel-hardening/20200630191931.GA884155@elver.google.com/

The main thing is that, yes, this might be something to be worried
about, but if we are worried about it, we need to be worried about it
in *all* builds (LTO or not). My guess is that's not acceptable. Would
it be better to just guard the promotion of READ_ONCE() to acquire
behind a config option like CONFIG_ACQUIRE_READ_DEPENDENCIES, and then
make LTO select that (or maybe leave it optional?). In future, for
very aggressive non-LTO compilers even, one may then also select that
if there is substantiated worry things do actually break.

Thanks,
-- Marco
