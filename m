From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 51/75] x86/sev-es: Handle MMIO events
Date: Tue, 19 May 2020 23:32:02 -0700
Message-ID: <20200520063202.GB17090@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-52-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-52-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:01PM +0200, Joerg Roedel wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Add handler for VC exceptions caused by MMIO intercepts. These
> intercepts come along as nested page faults on pages with reserved
> bits set.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: Adapt to VC handling framework ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---

...

> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index f4ce3b475464..e3662723ed76 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -294,6 +294,25 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  	return ES_EXCEPTION;
>  }
>  
> +static phys_addr_t vc_slow_virt_to_phys(struct ghcb *ghcb, unsigned long vaddr)
> +{
> +	unsigned long va = (unsigned long)vaddr;
> +	unsigned int level;
> +	phys_addr_t pa;
> +	pgd_t *pgd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset(current->active_mm, va);
> +	pte = lookup_address_in_pgd(pgd, va, &level);
> +	if (!pte)
> +		return 0;

'0' is a valid physical address.  It happens to be reserved in the kernel
thanks to L1TF, but using '0' as an error code is ugly.  Not to mention
none of the callers actually check the result.

> +
> +	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
> +	pa |= va & ~page_level_mask(level);
> +
> +	return pa;
> +}
