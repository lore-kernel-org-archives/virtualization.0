From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 23/75] x86/boot/compressed/64: Setup GHCB Based VC
 Exception handler
Date: Mon, 11 May 2020 22:07:09 +0200
Message-ID: <20200511200709.GE25861@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-24-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-24-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:33PM +0200, Joerg Roedel wrote:
> @@ -63,3 +175,45 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  	while (true)
>  		asm volatile("hlt\n");
>  }
> +
> +static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
> +					  void *src, char *buf,
> +					  unsigned int data_size,
> +					  unsigned int count,
> +					  bool backwards)
> +{
> +	int i, b = backwards ? -1 : 1;
> +	enum es_result ret = ES_OK;
> +
> +	for (i = 0; i < count; i++) {
> +		void *s = src + (i * data_size * b);
> +		char *d = buf + (i * data_size);

From a previous review:

Where are we checking whether that count is not exceeding @buf or
similar discrepancies?

Ditto below.

> +
> +		ret = vc_read_mem(ctxt, s, d, data_size);
> +		if (ret != ES_OK)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
> +					   void *dst, char *buf,
> +					   unsigned int data_size,
> +					   unsigned int count,
> +					   bool backwards)
> +{
> +	int i, s = backwards ? -1 : 1;
> +	enum es_result ret = ES_OK;
> +
> +	for (i = 0; i < count; i++) {
> +		void *d = dst + (i * data_size * s);
> +		char *b = buf + (i * data_size);
> +
> +		ret = vc_write_mem(ctxt, d, b, data_size);
> +		if (ret != ES_OK)
> +			break;
> +	}
> +
> +	return ret;
> +}
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
