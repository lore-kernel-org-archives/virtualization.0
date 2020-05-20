From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 42/75] x86/sev-es: Setup GHCB based boot #VC handler
Date: Wed, 20 May 2020 21:22:30 +0200
Message-ID: <20200520192230.GK1457@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-43-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-43-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:52PM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
> index b2cbcd40b52e..e1ed963a57ec 100644
> --- a/arch/x86/include/asm/sev-es.h
> +++ b/arch/x86/include/asm/sev-es.h
> @@ -74,5 +74,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
>  }
>  
>  extern void vc_no_ghcb(void);
> +extern bool vc_boot_ghcb(struct pt_regs *regs);

Those function names need verbs:

	handle_vc_no_ghcb
	handle_vc_boot_ghcb

> @@ -161,3 +176,104 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  
>  /* Include code shared with pre-decompression boot stage */
>  #include "sev-es-shared.c"
> +
> +/*
> + * This function runs on the first #VC exception after the kernel
> + * switched to virtual addresses.
> + */
> +static bool __init sev_es_setup_ghcb(void)

There's already another sev_es_setup_ghcb() in compressed/. All those
functions with the same name are just confusion waiting to happen. Let's
prepend the ones in compressed/ with "early_" or so, so that their names
are at least different even if they're in two different files with the
same name.

This way you know at least which function is used in which boot stages.

> +{
> +	/* First make sure the hypervisor talks a supported protocol. */
> +	if (!sev_es_negotiate_protocol())
> +		return false;

<---- newline here.

> +	/*
> +	 * Clear the boot_ghcb. The first exception comes in before the bss
> +	 * section is cleared.
> +	 */
> +	memset(&boot_ghcb_page, 0, PAGE_SIZE);
> +
> +	/* Alright - Make the boot-ghcb public */
> +	boot_ghcb = &boot_ghcb_page;
> +
> +	return true;
> +}
> +
> +static void __init vc_early_vc_forward_exception(struct es_em_ctxt *ctxt)

That second "vc" looks redundant.

> +{
> +	int trapnr = ctxt->fi.vector;
> +
> +	if (trapnr == X86_TRAP_PF)
> +		native_write_cr2(ctxt->fi.cr2);
> +
> +	ctxt->regs->orig_ax = ctxt->fi.error_code;
> +	do_early_exception(ctxt->regs, trapnr);
> +}
> +
> +static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
> +					 struct ghcb *ghcb,
> +					 unsigned long exit_code)
> +{
> +	enum es_result result;
> +
> +	switch (exit_code) {
> +	default:
> +		/*
> +		 * Unexpected #VC exception
> +		 */
> +		result = ES_UNSUPPORTED;
> +	}
> +
> +	return result;
> +}
> +
> +bool __init vc_boot_ghcb(struct pt_regs *regs)
> +{
> +	unsigned long exit_code = regs->orig_ax;
> +	struct es_em_ctxt ctxt;
> +	enum es_result result;
> +
> +	/* Do initial setup or terminate the guest */
> +	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
> +		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
> +
> +	vc_ghcb_invalidate(boot_ghcb);

Newline here...

> +	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
> +

... remove that one here.

> +	if (result == ES_OK)
> +		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
