From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 18/70] x86/boot/compressed/64: Add stage1 #VC handler
Date: Fri, 20 Mar 2020 14:16:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.2003201413010.205664@chino.kir.corp.google.com>
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-19-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-19-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 19 Mar 2020, Joerg Roedel wrote:

> diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
> new file mode 100644
> index 000000000000..f524b40aef07
> --- /dev/null
> +++ b/arch/x86/include/asm/sev-es.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD Encrypted Register State Support
> + *
> + * Author: Joerg Roedel <jroedel@suse.de>
> + */
> +
> +#ifndef __ASM_ENCRYPTED_STATE_H
> +#define __ASM_ENCRYPTED_STATE_H
> +
> +#include <linux/types.h>
> +
> +#define GHCB_SEV_CPUID_REQ	0x004UL
> +#define		GHCB_CPUID_REQ_EAX	0
> +#define		GHCB_CPUID_REQ_EBX	1
> +#define		GHCB_CPUID_REQ_ECX	2
> +#define		GHCB_CPUID_REQ_EDX	3
> +#define		GHCB_CPUID_REQ(fn, reg) (GHCB_SEV_CPUID_REQ | \
> +					(((unsigned long)reg & 3) << 30) | \
> +					(((unsigned long)fn) << 32))
> +
> +#define GHCB_SEV_CPUID_RESP	0x005UL
> +#define GHCB_SEV_TERMINATE	0x100UL
> +
> +#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
> +#define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }

Since preemption and irqs should be disabled before updating the GHCB and 
its MSR and until the contents have been accessed following VMGEXIT, 
should there be checks in place to ensure that's always the case?

> +
> +static inline u64 lower_bits(u64 val, unsigned int bits)
> +{
> +	u64 mask = (1ULL << bits) - 1;
> +
> +	return (val & mask);
> +}
> +
> +static inline u64 copy_lower_bits(u64 out, u64 in, unsigned int bits)
> +{
> +	u64 mask = (1ULL << bits) - 1;
> +
> +	out &= ~mask;
> +	out |= lower_bits(in, bits);
> +
> +	return out;
> +}
> +
> +#endif
> diff --git a/arch/x86/include/asm/trap_defs.h b/arch/x86/include/asm/trap_defs.h
> index 488f82ac36da..af45d65f0458 100644
> --- a/arch/x86/include/asm/trap_defs.h
> +++ b/arch/x86/include/asm/trap_defs.h
> @@ -24,6 +24,7 @@ enum {
>  	X86_TRAP_AC,		/* 17, Alignment Check */
>  	X86_TRAP_MC,		/* 18, Machine Check */
>  	X86_TRAP_XF,		/* 19, SIMD Floating-Point Exception */
> +	X86_TRAP_VC = 29,	/* 29, VMM Communication Exception */
>  	X86_TRAP_IRET = 32,	/* 32, IRET Exception */
>  };
>  
> diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
> new file mode 100644
> index 000000000000..e963b48d3e86
> --- /dev/null
> +++ b/arch/x86/kernel/sev-es-shared.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Encrypted Register State Support
> + *
> + * Author: Joerg Roedel <jroedel@suse.de>
> + *
> + * This file is not compiled stand-alone. It contains code shared
> + * between the pre-decompression boot code and the running Linux kernel
> + * and is included directly into both code-bases.
> + */
> +
> +/*
> + * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
> + * page yet, so it only supports the MSR based communication with the
> + * hypervisor and only the CPUID exit-code.
> + */
> +void __init vc_no_ghcb_handler(struct pt_regs *regs, unsigned long exit_code)
> +{
> +	unsigned int fn = lower_bits(regs->ax, 32);
> +	unsigned long val;
> +
> +	/* Only CPUID is supported via MSR protocol */
> +	if (exit_code != SVM_EXIT_CPUID)
> +		goto fail;
> +
> +	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
> +	VMGEXIT();
> +	val = sev_es_rd_ghcb_msr();
> +	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
> +		goto fail;
> +	regs->ax = val >> 32;
> +
> +	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
> +	VMGEXIT();
> +	val = sev_es_rd_ghcb_msr();
> +	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
> +		goto fail;
> +	regs->bx = val >> 32;
> +
> +	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
> +	VMGEXIT();
> +	val = sev_es_rd_ghcb_msr();
> +	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
> +		goto fail;
> +	regs->cx = val >> 32;
> +
> +	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
> +	VMGEXIT();
> +	val = sev_es_rd_ghcb_msr();
> +	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
> +		goto fail;
> +	regs->dx = val >> 32;
> +
> +	regs->ip += 2;
> +
> +	return;
> +
> +fail:
> +	sev_es_wr_ghcb_msr(GHCB_SEV_TERMINATE);
> +	VMGEXIT();
> +
> +	/* Shouldn't get here - if we do halt the machine */
> +	while (true)
> +		asm volatile("hlt\n");
> +}
> -- 
> 2.17.1
> 
> 
