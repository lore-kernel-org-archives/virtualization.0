From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 64/75] x86/sev-es: Cache CPUID results for improved
 performance
Date: Tue, 19 May 2020 22:16:37 -0700
Message-ID: <20200520051637.GA16599@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-65-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-65-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:14PM +0200, Joerg Roedel wrote:
> From: Mike Stunes <mstunes@vmware.com>
> 
> To avoid a future VMEXIT for a subsequent CPUID function, cache the
> results returned by CPUID into an xarray.
> 
>  [tl: coding standard changes, register zero extension]
> 
> Signed-off-by: Mike Stunes <mstunes@vmware.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: - Wrapped cache handling into vc_handle_cpuid_cached()
>                    - Used lower_32_bits() where applicable
> 		   - Moved cache_index out of struct es_em_ctxt ]
> Co-developed-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---

...

> +struct sev_es_cpuid_cache_entry {
> +	unsigned long eax;
> +	unsigned long ebx;
> +	unsigned long ecx;
> +	unsigned long edx;

Why are these unsigned longs?  CPUID returns 32-bit values, this wastes 16
bytes per entry.

> +};
> +
> +static struct xarray sev_es_cpuid_cache;
> +static bool __ro_after_init sev_es_cpuid_cache_initialized;
> +
>  /* For early boot hypervisor communication in SEV-ES enabled guests */
>  static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>  
> @@ -463,6 +474,9 @@ void __init sev_es_init_vc_handling(void)
>  		sev_es_setup_vc_stack(cpu);
>  	}
>  
> +	xa_init_flags(&sev_es_cpuid_cache, XA_FLAGS_LOCK_IRQ);
> +	sev_es_cpuid_cache_initialized = true;
> +
>  	init_vc_stack_names();
>  }
>  
> @@ -744,6 +758,91 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
>  	return ret;
>  }
>  
> +static unsigned long sev_es_get_cpuid_cache_index(struct es_em_ctxt *ctxt)
> +{
> +	unsigned long hi, lo;
> +
> +	/* Don't attempt to cache until the xarray is initialized */
> +	if (!sev_es_cpuid_cache_initialized)
> +		return ULONG_MAX;
> +
> +	lo = lower_32_bits(ctxt->regs->ax);
> +
> +	/*
> +	 * CPUID 0x0000000d requires both RCX and XCR0, so it can't be
> +	 * cached.
> +	 */
> +	if (lo == 0x0000000d)
> +		return ULONG_MAX;
> +
> +	/*
> +	 * Some callers of CPUID don't always set RCX to zero for CPUID
> +	 * functions that don't require RCX, which can result in excessive
> +	 * cached values, so RCX needs to be manually zeroed for use as part
> +	 * of the cache index. Future CPUID values may need RCX, but since
> +	 * they can't be known, they must not be cached.
> +	 */
> +	if (lo > 0x80000020)
> +		return ULONG_MAX;
> +
> +	switch (lo) {
> +	case 0x00000007:

OSPKE may or may not be cached correctly depending on when
sev_es_cpuid_cache_initialized is set.

> +	case 0x0000000b:
> +	case 0x0000000f:
> +	case 0x00000010:
> +	case 0x8000001d:
> +	case 0x80000020:
> +		hi = ctxt->regs->cx << 32;
> +		break;
> +	default:
> +		hi = 0;
> +	}
> +
> +	return hi | lo;

This needs to be way more restrictive on what is cached.  Unless I've
overlooked something, this lets userspace trigger arbitrary, unaccounted
kernel memory allocations.  E.g.

	for (i = 0; i <= 0x80000020; i++) {
		for (j = 0; j <= 0xffffffff; j++) {
			cpuid(i, j);
			if (i != 7 || i != 0xb || i != 0xf || i != 0x10 ||
			    i != 0x8000001d || i != 0x80000020)
				break;
		}
	}

The whole cache on-demand approach seems like overkill.  The number of CPUID
leaves that are invoked after boot with any regularity can probably be counted
on one hand.   IIRC glibc invokes CPUID to gather TLB/cache info, XCR0-based
features, and one or two other leafs.  A statically sized global array that's
arbitrarily index a la x86_capability would be just as simple and more
performant.  It would also allow fancier things like emulating CPUID 0xD in
the guest if you want to go down that road.
