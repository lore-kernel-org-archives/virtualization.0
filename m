From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 54/75] x86/sev-es: Handle DR7 read/write events
Date: Mon, 25 May 2020 12:59:35 +0200
Message-ID: <20200525105935.GH25636@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-55-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-55-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:04PM +0200, Joerg Roedel wrote:
> +static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
> +					  struct es_em_ctxt *ctxt)
> +{
> +	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
> +	long val, *reg = vc_insn_get_rm(ctxt);
> +	enum es_result ret;
> +
> +	if (!reg)
> +		return ES_DECODE_FAILED;
> +
> +	val = *reg;
> +
> +	/* Upper 32 bits must be written as zeroes */
> +	if (val >> 32) {
> +		ctxt->fi.vector = X86_TRAP_GP;
> +		ctxt->fi.error_code = 0;
> +		return ES_EXCEPTION;
> +	}
> +
> +	/* Clear out other reservered bits and set bit 10 */

"reserved"

> +	val = (val & 0xffff23ffL) | BIT(10);
> +
> +	/* Early non-zero writes to DR7 are not supported */
> +	if (!data && (val & ~DR7_RESET_VALUE))
> +		return ES_UNSUPPORTED;
> +
> +	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
> +	ghcb_set_rax(ghcb, val);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
> +	if (ret != ES_OK)
> +		return ret;
> +
> +	if (data)
> +		data->dr7 = val;

Are we still returning ES_OK if !data?

> +
> +	return ES_OK;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
