From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 51/75] x86/sev-es: Handle MMIO events
Date: Mon, 25 May 2020 10:02:26 +0200
Message-ID: <20200525080226.GB25636@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-52-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-52-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:01PM +0200, Joerg Roedel wrote:
> +static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> +				 unsigned int bytes, bool read)
> +{
> +	u64 exit_code, exit_info_1, exit_info_2;
> +	unsigned long ghcb_pa = __pa(ghcb);
> +	void __user *ref;
> +
> +	ref = insn_get_addr_ref(&ctxt->insn, ctxt->regs);
> +	if (ref == (void __user *)-1L)
> +		return ES_UNSUPPORTED;
> +
> +	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
> +
> +	exit_info_1 = vc_slow_virt_to_phys(ghcb, (unsigned long)ref);
> +	exit_info_2 = bytes;    /* Can never be greater than 8 */

No trailing comments pls - put them over the line.

> +	ghcb->save.sw_scratch = ghcb_pa + offsetof(struct ghcb, shared_buffer);
> +
> +	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
> +}
> +
> +static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
> +						 struct es_em_ctxt *ctxt)
> +{
> +	struct insn *insn = &ctxt->insn;
> +	unsigned int bytes = 0;
> +	enum es_result ret;
> +	int sign_byte;
> +	long *reg_data;
> +
> +	switch (insn->opcode.bytes[1]) {
> +		/* MMIO Read w/ zero-extension */
> +	case 0xb6:
> +		bytes = 1;
> +		/* Fallthrough */

I'm guessing we're supposed to annotate it this way now:

WARNING: Prefer 'fallthrough;' over fallthrough comment
#139: FILE: arch/x86/kernel/sev-es.c:504:
+               /* Fallthrough */


> +	case 0xb7:
> +		if (!bytes)
> +			bytes = 2;
> +
> +		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
> +		if (ret)
> +			break;
> +
> +		/* Zero extend based on operand size */
> +		reg_data = vc_insn_get_reg(ctxt);

That function can return NULL - you need to test reg_data. Ditto for all
its invocations.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
