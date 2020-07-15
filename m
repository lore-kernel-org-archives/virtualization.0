From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Date: Tue, 14 Jul 2020 18:40:30 -0700
Message-ID: <202007141837.2B93BBD78@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-71-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 14, 2020 at 02:09:12PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The APs are not ready to handle exceptions when verify_cpu() is called
> in secondary_startup_64.

Eek, no. MSR_IA32_MISC_ENABLE_XD_DISABLE needs to be cleared very early
during CPU startup; this can't just be skipped.

Also, is UNWIND_HINT_EMPTY needed for the new target?

-Kees

> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/realmode.h | 1 +
>  arch/x86/kernel/head_64.S       | 1 +
>  arch/x86/realmode/init.c        | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index 6590394af309..5c97807c38a4 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -69,6 +69,7 @@ extern unsigned char startup_32_smp[];
>  extern unsigned char boot_gdt[];
>  #else
>  extern unsigned char secondary_startup_64[];
> +extern unsigned char secondary_startup_64_no_verify[];
>  #endif
>  
>  static inline size_t real_mode_size_needed(void)
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 5b577d6bce7a..8b43ed0592e8 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -165,6 +165,7 @@ SYM_CODE_START(secondary_startup_64)
>  	/* Sanitize CPU configuration */
>  	call verify_cpu
>  
> +SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	/*
>  	 * Retrieve the modifier (SME encryption mask if SME is active) to be
>  	 * added to the initial pgdir entry that will be programmed into CR3.
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 61a52b925d15..df701f87ddef 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -46,6 +46,12 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
>  		th->flags |= TH_FLAGS_SME_ACTIVE;
>  
>  	if (sev_es_active()) {
> +		/*
> +		 * Skip the call to verify_cpu() in secondary_startup_64 as it
> +		 * will cause #VC exceptions when the AP can't handle them yet.
> +		 */
> +		th->start = (u64) secondary_startup_64_no_verify;
> +
>  		if (sev_es_setup_ap_jump_table(real_mode_header))
>  			panic("Failed to update SEV-ES AP Jump Table");
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
