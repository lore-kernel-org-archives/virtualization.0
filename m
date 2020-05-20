From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 38/75] x86/sev-es: Add SEV-ES Feature Detection
Date: Wed, 20 May 2020 10:39:16 +0200
Message-ID: <20200520083916.GB1457@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-39-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-39-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:48PM +0200, Joerg Roedel wrote:
> +bool sev_es_active(void)
> +{
> +	return !!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
> +}
> +EXPORT_SYMBOL_GPL(sev_es_active);

I don't see this being used in modules anywhere in the patchset. Or am I
missing something?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
