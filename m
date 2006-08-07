From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 07:30:17 +0200
Message-ID: <200608070730.17813.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751062AbWHGFap@vger.kernel.org>
In-Reply-To: <1154925835.21647.29.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> ===================================================================
> --- /dev/null
> +++ b/include/asm-i386/no_paravirt.h

I can't say I like the name. After all that should be the normal
case for a long time now ... native? normal? bareiron?

Also I would prefer if you split this file up a bit - the old
processor/system/irqflags split wasn't too bad.



> +
> +/*
> + * Set IOPL bits in EFLAGS from given mask
> + */
> +static inline void set_iopl_mask(unsigned mask)

This function can be completely written in C using local_save_flags()/local_restore_flags()
Please do that. I guess it's still a good idea to keep it separated
though because it might allow other optimizations.

e.g. i've been thinking about special casing IF changes in save/restore flags 
to optimize CPUs which have slow pushf/popf. If you already make sure
all non IF manipulations of flags are separated that would help.



> +/* Stop speculative execution */
> +static inline void sync_core(void)
> +{
> +	unsigned int eax = 1, ebx, ecx, edx;
> +	__cpuid(&eax, &ebx, &ecx, &edx);
> +}

Actually I don't think this one should be para virtualized at all.
I don't see any reason at all why a hypervisor should trap it and it
is very time critical. I would recommend you move it back into the 
normal files without hooks.

> +
> +/*
> + * Clear and set 'TS' bit respectively
> + */

The comment seems out of date (no set TS)


> +#define clts() __asm__ __volatile__ ("clts")
> +#define read_cr0() ({ \
> +	unsigned int __dummy; \
> +	__asm__ __volatile__( \

Maybe it's just me, but can't you just drop all these __s around
asm and volatile? They are completely useless as far I know. 

Also the assembly will be easier readable if you just keep it on a single 
line for the simple ones.

-Andi
