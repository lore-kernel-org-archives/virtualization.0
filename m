From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 69/75] x86/realmode: Setup AP jump table
Date: Fri, 29 May 2020 11:02:22 +0200
Message-ID: <20200529090222.GA9011@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-70-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-70-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:19PM +0200, Joerg Roedel wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Setup the AP jump table to point to the SEV-ES trampoline code so that
> the APs can boot.

Tom, in his laconic way, doesn't want to explain to us why is this even
needed...

:)

/me reads the code

/me reads the GHCB spec

aha, it gets it from the HV. And it can be set by the guest too...

So how about expanding that commit message as to why this is done, why
needed, etc?

Thx.

> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 262f83cad355..1c5cbfd102d5 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -9,6 +9,7 @@
>  #include <asm/realmode.h>
>  #include <asm/tlbflush.h>
>  #include <asm/crash.h>
> +#include <asm/sev-es.h>
>  
>  struct real_mode_header *real_mode_header;
>  u32 *trampoline_cr4_features;
> @@ -107,6 +108,11 @@ static void __init setup_real_mode(void)
>  	if (sme_active())
>  		trampoline_header->flags |= TH_FLAGS_SME_ACTIVE;
>  
> +	if (sev_es_active()) {
> +		if (sev_es_setup_ap_jump_table(real_mode_header))
> +			panic("Failed to update SEV-ES AP Jump Table");
> +	}
> +

So this function gets slowly sprinkled with

	if (sev-something)
		bla

Please wrap at least those last two into a

	sev_setup_real_mode()

or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
