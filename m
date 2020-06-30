From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
Date: Tue, 30 Jun 2020 21:25:03 +0200
Message-ID: <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-19-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, alpha <linux-alpha@vger.k>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 7:39 PM Will Deacon <will@kernel.org> wrote:
> +#define __READ_ONCE(x)                                                 \
> +({                                                                     \
> +       int atomic = 1;                                                 \
> +       union { __unqual_scalar_typeof(x) __val; char __c[1]; } __u;    \
> +       typeof(&(x)) __x = &(x);                                        \
> +       switch (sizeof(x)) {                                            \
...
> +       atomic ? (typeof(x))__u.__val : (*(volatile typeof(x) *)__x);   \
> +})

This expands (x) nine times (five in __unqual_scala_typeof()), which can
lead to significant code bloat after preprocessing if something passes a
compound expression into READ_ONCE().
The compiler works it out eventually, but we've seen an actual slowdown
in compile speed from this recently, especially on clang.

I think if you move the

        typeof(&(x)) __x = &(x);

line first, all other instances can use typeof(*__x) instead of typeof(x)
and avoid this problem. Once we make gcc-4.9 the minimum version,
this could be further improved to

       __auto_type __x = &(x);

       Arnd
