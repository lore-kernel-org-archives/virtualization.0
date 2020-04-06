From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 18/70] x86/boot/compressed/64: Add stage1 #VC handler
Date: Mon, 6 Apr 2020 14:41:24 +0200
Message-ID: <20200406124123.GE2520@zn.tnic>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-19-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200319091407.1481-19-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 10:13:15AM +0100, Joerg Roedel wrote:
> diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
> index bfb3fc5aa144..67ddafab2943 100644
> --- a/arch/x86/boot/compressed/idt_handlers_64.S
> +++ b/arch/x86/boot/compressed/idt_handlers_64.S
> @@ -75,3 +75,7 @@ SYM_FUNC_END(\name)
>  	.code64
>  
>  EXCEPTION_HANDLER	boot_pf_handler do_boot_page_fault error_code=1
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +EXCEPTION_HANDLER	boot_stage1_vc_handler vc_no_ghcb_handler error_code=1

Like the others
			boot_stage1_vc	do_boot_stage1_vc ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
