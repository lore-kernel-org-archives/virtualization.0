From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/18] compiler.h: Split {READ,WRITE}_ONCE definitions out
 into rwonce.h
Date: Tue, 30 Jun 2020 21:11:32 +0200
Message-ID: <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-3-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-3-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, alpha <linux-alpha@vger.k>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 7:37 PM Will Deacon <will@kernel.org> wrote:
>
> In preparation for allowing architectures to define their own
> implementation of the READ_ONCE() macro, move the generic
> {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> file and into a new 'rwonce.h' header under 'asm-generic'.
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/asm-generic/Kbuild   |  1 +
>  include/asm-generic/rwonce.h | 91 ++++++++++++++++++++++++++++++++++++
>  include/linux/compiler.h     | 83 +-------------------------------

Very nice, this has the added benefit of allowing us to stop including
asm/barrier.h once linux/compiler.h gets changed to not include
asm/rwonce.h.

The asm/barrier.h header has a circular dependency, pulling in
linux/compiler.h itself.

       Arnd
