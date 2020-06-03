From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 75/75] x86/efi: Add GHCB mappings when SEV-ES is active
Date: Wed, 3 Jun 2020 15:52:44 +0200
Message-ID: <20200603135244.GD19711@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-76-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-76-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:25PM +0200, Joerg Roedel wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Calling down to EFI runtime services can result in the firmware performing
> VMGEXIT calls. The firmware is likely to use the GHCB of the OS (e.g., for
> setting EFI variables), so each GHCB in the system needs to be identity
> mapped in the EFI page tables, as unencrypted, to avoid page faults.

...

> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index eef6e2196ef4..3b62714723b5 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -422,6 +422,31 @@ int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
>  	return 0;
>  }
>  

Trusting the firmware is never a good decision but we've established on
IRC that *this* firmware is in OVMF and is going to be part of the guest
measurement so if there's trouble we can always fix it, as opposed to
the actual firmware in the chip.

Please add some blurb above this function about it so that it is clear
what kind of EFI firmware it is about here.

> +int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
> +{
> +	struct sev_es_runtime_data *data;
> +	unsigned long address, pflags;
> +	int cpu;
> +	u64 pfn;
> +
> +	if (!sev_es_active())
> +		return 0;
> +
> +	pflags = _PAGE_NX | _PAGE_RW;
> +
> +	for_each_possible_cpu(cpu) {
> +		data = per_cpu(runtime_data, cpu);
> +
> +		address = __pa(&data->ghcb_page);
> +		pfn = address >> PAGE_SHIFT;
> +
> +		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
> +			return 1;
> +	}
> +
> +	return 0;
> +}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
