From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 52/75] x86/sev-es: Handle MMIO String Instructions
Date: Mon, 25 May 2020 11:47:54 +0200
Message-ID: <20200525094747.GE25636@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-53-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-53-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:02PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add handling for emulation the MOVS instruction on MMIO regions, as done
> by the memcpy_toio() and memcpy_fromio() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev-es.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index e3662723ed76..84958a82f8e0 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -552,6 +552,74 @@ static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
>  	return ret;
>  }
>  
> +/*
> + * The MOVS instruction has two memory operands, which raises the
> + * problem that it is not known whether the access to the source or the
> + * destination caused the #VC exception (and hence whether an MMIO read
> + * or write operation needs to be emulated).
> + *
> + * Instead of playing games with walking page-tables and trying to guess
> + * whether the source or destination is an MMIO range, this code splits

s/this code splits/split/

> + * the move into two operations, a read and a write with only one
> + * memory operand. This will cause a nested #VC exception on the MMIO
> + * address which can then be handled.
> + *
> + * This implementation has the benefit that it also supports MOVS where
> + * source _and_ destination are MMIO regions.
> + *
> + * It will slow MOVS on MMIO down a lot, but in SEV-ES guests it is a
> + * rare operation. If it turns out to be a performance problem the split
> + * operations can be moved to memcpy_fromio() and memcpy_toio().
> + */
> +static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
> +					  unsigned int bytes)
> +{
> +	unsigned long ds_base, es_base;
> +	unsigned char *src, *dst;
> +	unsigned char buffer[8];
> +	enum es_result ret;
> +	bool rep;
> +	int off;
> +
> +	ds_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_DS);
> +	es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
> +
> +	if (ds_base == -1L || es_base == -1L) {
> +		ctxt->fi.vector = X86_TRAP_GP;
> +		ctxt->fi.error_code = 0;
> +		return ES_EXCEPTION;
> +	}
> +
> +	src = ds_base + (unsigned char *)ctxt->regs->si;
> +	dst = es_base + (unsigned char *)ctxt->regs->di;
> +
> +	ret = vc_read_mem(ctxt, src, buffer, bytes);
> +	if (ret != ES_OK)
> +		return ret;
> +
> +	ret = vc_write_mem(ctxt, dst, buffer, bytes);
> +	if (ret != ES_OK)
> +		return ret;
> +
> +	if (ctxt->regs->flags & X86_EFLAGS_DF)
> +		off = -bytes;
> +	else
> +		off =  bytes;
> +
> +	ctxt->regs->si += off;
> +	ctxt->regs->di += off;
> +
> +	rep = insn_has_rep_prefix(&ctxt->insn);
> +

^ Superfluous newline.

> +	if (rep)
> +		ctxt->regs->cx -= 1;
> +
> +	if (!rep || ctxt->regs->cx == 0)
> +		return ES_OK;
> +	else
> +		return ES_RETRY;
> +}
> +
>  static enum es_result vc_handle_mmio(struct ghcb *ghcb,
>  				     struct es_em_ctxt *ctxt)
>  {
> @@ -606,6 +674,16 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
>  		memcpy(reg_data, ghcb->shared_buffer, bytes);
>  		break;
>  
> +		/* MOVS instruction */
> +	case 0xa4:
> +		bytes = 1;
> +		/* Fallthrough */

WARNING: Prefer 'fallthrough;' over fallthrough comment
#120: FILE: arch/x86/kernel/sev-es.c:680:
+               /* Fallthrough */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
