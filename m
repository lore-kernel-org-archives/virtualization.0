From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Date: Mon, 6 Jul 2020 17:08:20 +0100
Message-ID: <20200706160820.GC10992@arm.com>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200630173734.14057-19-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, kernel-team@android.com, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Nick
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
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
> 
> diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> new file mode 100644
> index 000000000000..515e360b01a1
> --- /dev/null
> +++ b/arch/arm64/include/asm/rwonce.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#ifndef __ASM_RWONCE_H
> +#define __ASM_RWONCE_H
> +
> +#ifdef CONFIG_CLANG_LTO
> +
> +#include <linux/compiler_types.h>
> +#include <asm/alternative-macros.h>
> +
> +#ifndef BUILD_VDSO
> +
> +#ifdef CONFIG_AS_HAS_LDAPR
> +#define __LOAD_RCPC(sfx, regs...)					\
> +	ALTERNATIVE(							\
> +		"ldar"	#sfx "\t" #regs,				\

^ Should this be here?  It seems that READ_ONCE() will actually read
twice... even if that doesn't actually conflict with the required
semantics of READ_ONCE(), it looks odd.

Making a direct link between LTO and the memory model also seems highly
spurious (as discussed in the other subthread) so can we have a comment
explaining the reasoning?

> +		".arch_extension rcpc\n"				\
> +		"ldapr"	#sfx "\t" #regs,				\
> +	ARM64_HAS_LDAPR)
> +#else
> +#define __LOAD_RCPC(sfx, regs...)	"ldar" #sfx "\t" #regs
> +#endif /* CONFIG_AS_HAS_LDAPR */

[...]

Cheers
---Dave
