From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 25/75] x86/sev-es: Add support for handling IOIO
 exceptions
Date: Tue, 19 May 2020 23:20:55 -0700
Message-ID: <20200520062055.GA17090@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-26-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-26-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:35PM +0200, Joerg Roedel wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Add support for decoding and handling #VC exceptions for IOIO events.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: Adapted code to #VC handling framework ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/sev-es.c |  32 +++++
>  arch/x86/kernel/sev-es-shared.c   | 202 ++++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
> index 1241697dd156..17765e471e28 100644
> --- a/arch/x86/boot/compressed/sev-es.c
> +++ b/arch/x86/boot/compressed/sev-es.c
> @@ -23,6 +23,35 @@

...

> +static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
> +{
> +	struct pt_regs *regs = ctxt->regs;
> +	u64 exit_info_1, exit_info_2;
> +	enum es_result ret;
> +
> +	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
> +	if (ret != ES_OK)
> +		return ret;
> +
> +	if (exit_info_1 & IOIO_TYPE_STR) {
> +		int df = (regs->flags & X86_EFLAGS_DF) ? -1 : 1;
> +		unsigned int io_bytes, exit_bytes;
> +		unsigned int ghcb_count, op_count;
> +		unsigned long es_base;
> +		u64 sw_scratch;
> +
> +		/*
> +		 * For the string variants with rep prefix the amount of in/out
> +		 * operations per #VC exception is limited so that the kernel
> +		 * has a chance to take interrupts an re-schedule while the
> +		 * instruction is emulated.

Doesn't this also suppress single-step #DBs?

> +		 */
> +		io_bytes   = (exit_info_1 >> 4) & 0x7;
> +		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
> +
> +		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
> +		exit_info_2 = min(op_count, ghcb_count);
> +		exit_bytes  = exit_info_2 * io_bytes;
> +
> +		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
> +
> +		if (!(exit_info_1 & IOIO_TYPE_IN)) {
> +			ret = vc_insn_string_read(ctxt,
> +					       (void *)(es_base + regs->si),

SEV(-ES) is 64-bit only, why bother with the es_base charade?

> +					       ghcb->shared_buffer, io_bytes,
> +					       exit_info_2, df);

df handling is busted, it's aways non-zero.  Same goes for the SI/DI
adjustments below.

> +			if (ret)
> +				return ret;
> +		}
> +
> +		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
> +		ghcb_set_sw_scratch(ghcb, sw_scratch);
> +		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
> +				   exit_info_1, exit_info_2);
> +		if (ret != ES_OK)
> +			return ret;

Batching the memory accesses and I/O accesses separately is technically
wrong, e.g. a #DB on a memory access will result in bogus data being shown
in the debugger.  In practice it seems unlikely to matter, but I'm curious
as to why string I/O is supported in the first place.  I didn't think there
was that much string I/O in the kernel?

> +
> +		/* Everything went well, write back results */
> +		if (exit_info_1 & IOIO_TYPE_IN) {
> +			ret = vc_insn_string_write(ctxt,
> +						(void *)(es_base + regs->di),
> +						ghcb->shared_buffer, io_bytes,
> +						exit_info_2, df);
> +			if (ret)
> +				return ret;
> +
> +			if (df)
> +				regs->di -= exit_bytes;
> +			else
> +				regs->di += exit_bytes;
> +		} else {
> +			if (df)
> +				regs->si -= exit_bytes;
> +			else
> +				regs->si += exit_bytes;
> +		}
> +
> +		if (exit_info_1 & IOIO_REP)
> +			regs->cx -= exit_info_2;
> +
> +		ret = regs->cx ? ES_RETRY : ES_OK;
> +
> +	} else {
> +		int bits = (exit_info_1 & 0x70) >> 1;
> +		u64 rax = 0;
> +
> +		if (!(exit_info_1 & IOIO_TYPE_IN))
> +			rax = lower_bits(regs->ax, bits);
> +
> +		ghcb_set_rax(ghcb, rax);
> +
> +		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
> +		if (ret != ES_OK)
> +			return ret;
> +
> +		if (exit_info_1 & IOIO_TYPE_IN) {
> +			if (!ghcb_is_valid_rax(ghcb))
> +				return ES_VMM_ERROR;
> +			regs->ax = lower_bits(ghcb->save.rax, bits);
> +		}
> +	}
> +
> +	return ret;
> +}
> -- 
> 2.17.1
> 
