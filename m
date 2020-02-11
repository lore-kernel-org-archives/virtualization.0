From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 35/62] x86/sev-es: Setup per-cpu GHCBs for the runtime handler
Date: Tue, 11 Feb 2020 14:46:11 -0800
Message-ID: <CALCETrWVYM_EQJYznNzPT0q2yYjUojCHYpHmdYoSCdqApitTrA@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-36-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-36-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Tom Lendacky <thomas.lendacky@amd.com>
>
> The runtime handler needs a GHCB per CPU. Set them up and map them
> unencrypted.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/mem_encrypt.h |  2 ++
>  arch/x86/kernel/sev-es.c           | 25 ++++++++++++++++++++++++-
>  arch/x86/kernel/traps.c            |  3 +++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 6f61bb93366a..d48e7be9bb49 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -48,6 +48,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
>  void __init mem_encrypt_init(void);
>  void __init mem_encrypt_free_decrypted_mem(void);
>
> +void __init encrypted_state_init_ghcbs(void);
>  bool sme_active(void);
>  bool sev_active(void);
>  bool sev_es_active(void);
> @@ -71,6 +72,7 @@ static inline void __init sme_early_init(void) { }
>  static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>  static inline void __init sme_enable(struct boot_params *bp) { }
>
> +static inline void encrypted_state_init_ghcbs(void) { }
>  static inline bool sme_active(void) { return false; }
>  static inline bool sev_active(void) { return false; }
>  static inline bool sev_es_active(void) { return false; }
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 0e0b28477627..9a5530857db7 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -8,8 +8,11 @@
>   */
>
>  #include <linux/sched/debug.h> /* For show_regs() */
> -#include <linux/kernel.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/mem_encrypt.h>
>  #include <linux/printk.h>
> +#include <linux/set_memory.h>
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>
>  #include <asm/trap_defs.h>
> @@ -28,6 +31,9 @@ struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  struct ghcb __initdata *boot_ghcb;
>
> +/* Runtime GHCBs */
> +static DEFINE_PER_CPU_DECRYPTED(struct ghcb, ghcb_page) __aligned(PAGE_SIZE);

Hmm.  This is a largeish amount of memory on large non-SEV-ES systems.
Maybe store a pointer instead?  It would be even better if it could be
DEFINE_PER_CPU like this but be discarded if we don't need it, but I
don't think we have the infrastructure for that.

--Andy
