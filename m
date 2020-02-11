From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 30/62] x86/head/64: Move early exception dispatch to C code
Date: Tue, 11 Feb 2020 14:44:45 -0800
Message-ID: <CALCETrVLhTkZ2MMUD+WMWXnhmSvwVhinUtMJey2M6sx_iUREcg@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-31-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-31-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Move the assembly coded dispatch between page-faults and all other
> exceptions to C code to make it easier to maintain and extend.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/head64.c  | 20 ++++++++++++++++++++
>  arch/x86/kernel/head_64.S | 11 +----------
>  2 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 7cdfb7113811..d83c62ebaa85 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -36,6 +36,8 @@
>  #include <asm/microcode.h>
>  #include <asm/kasan.h>
>  #include <asm/fixmap.h>
> +#include <asm/extable.h>
> +#include <asm/trap_defs.h>
>
>  /*
>   * Manage page tables very early on.
> @@ -377,6 +379,24 @@ int __init early_make_pgtable(unsigned long address)
>         return __early_make_pgtable(address, pmd);
>  }
>
> +void __init early_exception(struct pt_regs *regs, int trapnr)
> +{
> +       unsigned long cr2;
> +       int r;

How about int (or bool) handled;  Or just if (!early_make_pgtable)
return;  This would also be nicer if you inverted the return value so
that true means "I handled it".

--Andy
