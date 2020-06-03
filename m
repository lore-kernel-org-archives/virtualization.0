From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 73/75] x86/sev-es: Support CPU offline/online
Date: Wed, 3 Jun 2020 11:54:26 +0200
Message-ID: <20200603095426.GA19711@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-74-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-74-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:23PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add a play_dead handler when running under SEV-ES. This is needed
> because the hypervisor can't deliver an SIPI request to restart the AP.
> Instead the kernel has to issue a VMGEXIT to halt the VCPU. When the
> hypervisor would deliver and SIPI is wakes up the VCPU instead.

That last sentence needs fixing.

Also, that explanation belongs as comment over sev_es_ap_hlt_loop()
because commit messages are not that easy to find.

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/uapi/asm/svm.h |  1 +
>  arch/x86/kernel/sev-es.c        | 58 +++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index a19ce9681ec2..20a05839dd9a 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -84,6 +84,7 @@
>  /* SEV-ES software-defined VMGEXIT events */
>  #define SVM_VMGEXIT_MMIO_READ			0x80000001
>  #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
> +#define SVM_VMGEXIT_AP_HLT_LOOP			0x80000004
>  #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
>  #define		SVM_VMGEXIT_SET_AP_JUMP_TABLE			0
>  #define		SVM_VMGEXIT_GET_AP_JUMP_TABLE			1
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 28725c38e6fb..00a5d0483730 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -32,6 +32,8 @@
>  #include <asm/processor.h>
>  #include <asm/traps.h>
>  #include <asm/svm.h>
> +#include <asm/smp.h>
> +#include <asm/cpu.h>
>  
>  #define DR7_RESET_VALUE        0x400
>  
> @@ -448,6 +450,60 @@ static bool __init sev_es_setup_ghcb(void)
>  	return true;
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void sev_es_ap_hlt_loop(void)
> +{
> +	struct ghcb_state state;
> +	struct ghcb *ghcb;
> +
> +	ghcb = sev_es_get_ghcb(&state);
> +
> +	while (true) {
> +		vc_ghcb_invalidate(ghcb);
> +		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_HLT_LOOP);
> +		ghcb_set_sw_exit_info_1(ghcb, 0);
> +		ghcb_set_sw_exit_info_2(ghcb, 0);
> +
> +		sev_es_wr_ghcb_msr(__pa(ghcb));
> +		VMGEXIT();
> +
> +		/* Wakup Signal? */

		  "Wakeup"

> +		if (ghcb_is_valid_sw_exit_info_2(ghcb) &&
> +		    ghcb->save.sw_exit_info_2 != 0)

No need for the "!= 0".

> +			break;
> +	}
> +
> +	sev_es_put_ghcb(&state);
> +}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
