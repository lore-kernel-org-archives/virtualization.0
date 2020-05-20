From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 40/75] x86/sev-es: Compile early handler code into
 kernel image
Date: Wed, 20 May 2020 11:14:15 +0200
Message-ID: <20200520091415.GC1457@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-41-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-41-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:50PM +0200, Joerg Roedel wrote:
> +static inline u64 sev_es_rd_ghcb_msr(void)
> +{
> +	return native_read_msr(MSR_AMD64_SEV_ES_GHCB);
> +}
> +
> +static inline void sev_es_wr_ghcb_msr(u64 val)
> +{
> +	u32 low, high;
> +
> +	low  = (u32)(val);
> +	high = (u32)(val >> 32);
> +
> +	native_write_msr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +}

Instead of duplicating those two, you can lift the ones in the
compressed image into sev-es.h and use them here. I don't care one bit
about the MSR tracepoints in native_*_msr().

> +static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
> +				   char *dst, char *buf, size_t size)
> +{
> +	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
> +	char __user *target = (char __user *)dst;
> +	u64 d8;
> +	u32 d4;
> +	u16 d2;
> +	u8  d1;
> +
> +	switch (size) {
> +	case 1:
> +		memcpy(&d1, buf, 1);
> +		if (put_user(d1, target))
> +			goto fault;
> +		break;
> +	case 2:
> +		memcpy(&d2, buf, 2);
> +		if (put_user(d2, target))
> +			goto fault;
> +		break;
> +	case 4:
> +		memcpy(&d4, buf, 4);
> +		if (put_user(d4, target))
> +			goto fault;
> +		break;
> +	case 8:
> +		memcpy(&d8, buf, 8);
> +		if (put_user(d8, target))
> +			goto fault;

Ok, those (and below) memcpys get nicely optimized to MOVs by the
compiler here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
