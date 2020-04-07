From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 12/70] x86/boot/compressed/64: Add IDT Infrastructure
Date: Mon, 6 Apr 2020 22:21:27 -0400
Message-ID: <20200407022127.GA1048595@rani.riverdale.lan>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-13-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200319091407.1481-13-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 10:13:09AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add code needed to setup an IDT in the early pre-decompression
> boot-code. The IDT is loaded first in startup_64, which is after
> EfiExitBootServices() has been called, and later reloaded when the
> kernel image has been relocated to the end of the decompression area.
> 
> This allows to setup different IDT handlers before and after the
> relocation.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 1f1f6c8139b3..d27a9ce1bcb0 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -465,6 +470,16 @@ SYM_FUNC_END_ALIAS(efi_stub_entry)
>  	.text
>  SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  
> +/*
> + * Reload GDT after relocation - The GDT at the non-relocated position
> + * might be overwritten soon by the in-place decompression, so reload
> + * GDT at the relocated address. The GDT is referenced by exception
> + * handling and needs to be set up correctly.
> + */
> +	leaq	gdt(%rip), %rax
> +	movq	%rax, gdt64+2(%rip)
> +	lgdt	gdt64(%rip)
> +
>  /*
>   * Clear BSS (stack is currently empty)
>   */

Note that this is now done in mainline as of commit c98a76eabbb6e, just
prior to jumping to .Lrelocated, so this can be dropped on the next
rebase.

Thanks.
