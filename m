From: boqun.feng@gmail.com
Subject: Re: [PATCH v3 02/19] compiler.h: Split {READ,WRITE}_ONCE definitions
 out into rwonce.h
Date: Mon, 13 Jul 2020 20:23:22 +0800
Message-ID: <20200713122322.GD72639@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-3-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-3-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-team@a
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 05:51:46PM +0100, Will Deacon wrote:
> In preparation for allowing architectures to define their own
> implementation of the READ_ONCE() macro, move the generic
> {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> file and into a new 'rwonce.h' header under 'asm-generic'.
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/asm-generic/Kbuild    |  1 +
>  include/asm-generic/barrier.h |  2 +-
>  include/asm-generic/rwonce.h  | 91 +++++++++++++++++++++++++++++++++++
>  include/linux/compiler.h      | 83 +-------------------------------
>  4 files changed, 95 insertions(+), 82 deletions(-)
>  create mode 100644 include/asm-generic/rwonce.h
> 
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 44ec80e70518..74b0612601dd 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -45,6 +45,7 @@ mandatory-y += pci.h
>  mandatory-y += percpu.h
>  mandatory-y += pgalloc.h
>  mandatory-y += preempt.h
> +mandatory-y += rwonce.h
>  mandatory-y += sections.h
>  mandatory-y += serial.h
>  mandatory-y += shmparam.h
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 2eacaf7d62f6..8116744bb82c 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -13,7 +13,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <linux/compiler.h>
> +#include <asm/rwonce.h>
>  
>  #ifndef nop
>  #define nop()	asm volatile ("nop")
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> new file mode 100644
> index 000000000000..92cc2f223cb3
> --- /dev/null
> +++ b/include/asm-generic/rwonce.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Prevent the compiler from merging or refetching reads or writes. The
> + * compiler is also forbidden from reordering successive instances of
> + * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
> + * particular ordering. One way to make the compiler aware of ordering is to
> + * put the two invocations of READ_ONCE or WRITE_ONCE in different C
> + * statements.
> + *
> + * These two macros will also work on aggregate data types like structs or
> + * unions.
> + *
> + * Their two major use cases are: (1) Mediating communication between
> + * process-level code and irq/NMI handlers, all running on the same CPU,
> + * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
> + * mutilate accesses that either do not require ordering or that interact
> + * with an explicit memory barrier or atomic instruction that provides the
> + * required ordering.
> + */
> +#ifndef __ASM_GENERIC_RWONCE_H
> +#define __ASM_GENERIC_RWONCE_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/compiler_types.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
> +#include <asm/barrier.h>
> +
> +/*
> + * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> + * atomicity or dependency ordering guarantees. Note that this may result
> + * in tears!
> + */
> +#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
> +
> +#define __READ_ONCE_SCALAR(x)						\
> +({									\
> +	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
> +	smp_read_barrier_depends();					\
> +	(typeof(x))__x;							\
> +})
> +
> +#define READ_ONCE(x)							\
> +({									\
> +	compiletime_assert_rwonce_type(x);				\

Does it make sense if we also move the definition of this compile time
assertion into rwonce.h too?

Regards,
Boqun

> +	__READ_ONCE_SCALAR(x);						\
> +})
> +

[...]
