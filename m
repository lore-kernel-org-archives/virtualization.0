From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 03/62] x86/cpufeatures: Add SEV-ES CPU feature
Date: Thu, 13 Feb 2020 07:51:30 +0100
Message-ID: <20200213065130.GC31799@zn.tnic>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200211135256.24617-4-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:51:57PM +0100, Joerg Roedel wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Add CPU feature detection for Secure Encrypted Virtualization with
> Encrypted State. This feature enhances SEV by also encrypting the
> guest register state, making it in-accessible to the hypervisor.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/amd.c          | 4 +++-
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index f3327cb56edf..26e4ee209f7b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -285,6 +285,7 @@
>  #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
>  #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
>  #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
> +#define X86_FEATURE_SEV_ES		(11*32+ 6) /* AMD Secure Encrypted Virtualization - Encrypted State */

Let's put this in word 8 which is for virt flags. X86_FEATURE_SEV could
go there too but that should be a separate patch anyway, if at all.

>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index ac83a0fef628..aad2223862ef 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -580,7 +580,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>  	 *	      If BIOS has not enabled SME then don't advertise the
>  	 *	      SME feature (set in scattered.c).
>  	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
> -	 *            SEV feature (set in scattered.c).
> +	 *            SEV and SEV_ES feature (set in scattered.c).
>  	 *
>  	 *   In all cases, since support for SME and SEV requires long mode,
>  	 *   don't advertise the feature under CONFIG_X86_32.
> @@ -611,6 +611,8 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>  		setup_clear_cpu_cap(X86_FEATURE_SME);
>  clear_sev:
>  		setup_clear_cpu_cap(X86_FEATURE_SEV);
> +		setup_clear_cpu_cap(X86_FEATURE_SEV);

X86_FEATURE_SEV twice? Because once didn't stick?

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
