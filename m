From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/18] Allow architectures to override __READ_ONCE()
Date: Mon, 13 Jul 2020 12:34:43 +0200
Message-ID: <20200713103443.GE10769@hirez.programming.kicks-ass.net>
References: <20200710165203.31284-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-team@andro
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 05:51:44PM +0100, Will Deacon wrote:

> SeongJae Park (1):
>   Documentation/barriers/kokr: Remove references to
>     [smp_]read_barrier_depends()
> 
> Will Deacon (18):
>   tools: bpf: Use local copy of headers including uapi/linux/filter.h
>   compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
>   asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
>   alpha: Override READ_ONCE() with barriered implementation
>   asm/rwonce: Remove smp_read_barrier_depends() invocation
>   asm/rwonce: Don't pull <asm/barrier.h> into 'asm-generic/rwonce.h'
>   vhost: Remove redundant use of read_barrier_depends() barrier
>   alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
>   locking/barriers: Remove definitions for [smp_]read_barrier_depends()
>   Documentation/barriers: Remove references to
>     [smp_]read_barrier_depends()
>   tools/memory-model: Remove smp_read_barrier_depends() from informal
>     doc
>   include/linux: Remove smp_read_barrier_depends() from comments
>   checkpatch: Remove checks relating to [smp_]read_barrier_depends()
>   arm64: Reduce the number of header files pulled into vmlinux.lds.S
>   arm64: alternatives: Split up alternative.h
>   arm64: cpufeatures: Add capability for LDAPR instruction
>   arm64: alternatives: Remove READ_ONCE() usage during patch operation
>   arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
