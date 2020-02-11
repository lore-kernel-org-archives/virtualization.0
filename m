From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 18/62] x86/boot/compressed/64: Setup GHCB Based VC
 Exception handler
Date: Tue, 11 Feb 2020 14:25:49 -0800
Message-ID: <CALCETrVWoG7ugfE_FJgNKyyWYCmZh1162kfceJ2bs+O7Qyf-8A@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-19-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-19-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Install an exception handler for #VC exception that uses a GHCB. Also
> add the infrastructure for handling different exit-codes by decoding
> the instruction that caused the exception and error handling.
>

> diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
> index 8d13121a8cf2..02fb6f57128b 100644
> --- a/arch/x86/boot/compressed/sev-es.c
> +++ b/arch/x86/boot/compressed/sev-es.c
> @@ -8,12 +8,16 @@
>  #include <linux/kernel.h>
>
>  #include <asm/sev-es.h>
> +#include <asm/trap_defs.h>
>  #include <asm/msr-index.h>
>  #include <asm/ptrace.h>
>  #include <asm/svm.h>
>
>  #include "misc.h"
>
> +struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
> +struct ghcb *boot_ghcb;
> +
>  static inline u64 read_ghcb_msr(void)
>  {
>         unsigned long low, high;
> @@ -35,8 +39,95 @@ static inline void write_ghcb_msr(u64 val)
>                         "a"(low), "d" (high) : "memory");
>  }
>
> +static enum es_result es_fetch_insn_byte(struct es_em_ctxt *ctxt,
> +                                        unsigned int offset,
> +                                        char *buffer)
> +{
> +       char *rip = (char *)ctxt->regs->ip;
> +
> +       buffer[offset] = rip[offset];
> +
> +       return ES_OK;
> +}
> +
> +static enum es_result es_write_mem(struct es_em_ctxt *ctxt,
> +                                  void *dst, char *buf, size_t size)
> +{
> +       memcpy(dst, buf, size);
> +
> +       return ES_OK;
> +}
> +
> +static enum es_result es_read_mem(struct es_em_ctxt *ctxt,
> +                                 void *src, char *buf, size_t size)
> +{
> +       memcpy(buf, src, size);
> +
> +       return ES_OK;
> +}


What are all these abstractions for?
