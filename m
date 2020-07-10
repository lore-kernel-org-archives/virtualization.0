From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 06/19] asm/rwonce: Don't pull <asm/barrier.h> into 'asm-generic/rwonce.h'
Date: Fri, 10 Jul 2020 10:06:12 -0700
Message-ID: <CAKwvOd=HJye0iHr=9=7EMytO8ycFNJEsHHe1m64uT8s0jOQw0Q@mail.gmail.com>
References: <20200710165203.31284-1-will@kernel.org> <20200710165203.31284-7-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200710165203.31284-7-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-alpha@vger.kernel.org, virtualization@lists.linux-fou
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 9:52 AM Will Deacon <will@kernel.org> wrote:
>
> Now that 'smp_read_barrier_depends()' has gone the way of the Norwegian
> Blue, drop the inclusion of <asm/barrier.h> in 'asm-generic/rwonce.h'.
>
> This requires fixups to some architecture vdso headers which were
> previously relying on 'asm/barrier.h' coming in via 'linux/compiler.h'.
>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm/include/asm/vdso/gettimeofday.h          | 1 +
>  arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
>  arch/arm64/include/asm/vdso/gettimeofday.h        | 1 +
>  arch/riscv/include/asm/vdso/gettimeofday.h        | 1 +
>  include/asm-generic/rwonce.h                      | 2 --
>  include/linux/nospec.h                            | 2 ++
>  6 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
> index 36dc18553ed8..1b207cf07697 100644
> --- a/arch/arm/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm/include/asm/vdso/gettimeofday.h
> @@ -7,6 +7,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/barrier.h>
>  #include <asm/errno.h>
>  #include <asm/unistd.h>
>  #include <asm/vdso/cp15.h>
> diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> index b6907ae78e53..bcf7649999a4 100644
> --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> @@ -7,6 +7,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/barrier.h>
>  #include <asm/unistd.h>
>  #include <asm/errno.h>
>
> diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> index afba6ba332f8..127fa63893e2 100644
> --- a/arch/arm64/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> @@ -7,6 +7,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/barrier.h>
>  #include <asm/unistd.h>
>
>  #define VDSO_HAS_CLOCK_GETRES          1
> diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
> index c8e818688ec1..3099362d9f26 100644
> --- a/arch/riscv/include/asm/vdso/gettimeofday.h
> +++ b/arch/riscv/include/asm/vdso/gettimeofday.h
> @@ -4,6 +4,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <asm/barrier.h>
>  #include <asm/unistd.h>
>  #include <asm/csr.h>
>  #include <uapi/linux/time.h>
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index cc810f1f18ca..cd0302746fb4 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -26,8 +26,6 @@
>  #include <linux/kasan-checks.h>
>  #include <linux/kcsan-checks.h>
>
> -#include <asm/barrier.h>
> -
>  /*
>   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
>   * atomicity. Note that this may result in tears!
> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> index 0c5ef54fd416..c1e79f72cd89 100644
> --- a/include/linux/nospec.h
> +++ b/include/linux/nospec.h
> @@ -5,6 +5,8 @@
>
>  #ifndef _LINUX_NOSPEC_H
>  #define _LINUX_NOSPEC_H
> +
> +#include <linux/compiler.h>

The other hunks LGTM, but this one is a little more curious to me. Can
you walk me through this addition?

>  #include <asm/barrier.h>
>
>  struct task_struct;
> --
> 2.27.0.383.g050319c2ae-goog
>


-- 
Thanks,
~Nick Desaulniers
