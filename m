From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 25/62] x86/head/64: Install boot GDT
Date: Tue, 11 Feb 2020 14:29:24 -0800
Message-ID: <CALCETrWryvrGoPD5zOVxVs3pk+WFfb287NV46Zw7Gz7FtNAHag@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-26-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-26-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Handling exceptions during boot requires a working GDT. The kernel GDT
> is not yet ready for use, so install a temporary boot GDT.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/head_64.S | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 4bbc770af632..5a3cde971cb7 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -72,6 +72,20 @@ SYM_CODE_START_NOALIGN(startup_64)
>         /* Set up the stack for verify_cpu(), similar to initial_stack below */
>         leaq    (__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
>
> +       /* Setup boot GDT descriptor and load boot GDT */
> +       leaq    boot_gdt(%rip), %rax
> +       movq    %rax, boot_gdt_base(%rip)
> +       lgdt    boot_gdt_descr(%rip)
> +
> +       /* GDT loaded - switch to __KERNEL_CS so IRET works reliably */
> +       pushq   $__KERNEL_CS
> +       leaq    .Lon_kernel_cs(%rip), %rax
> +       pushq   %rax
> +       lretq
> +
> +.Lon_kernel_cs:
> +       UNWIND_HINT_EMPTY

I would suggest fixing at least SS as well.
