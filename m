From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 31/75] x86/head/64: Install boot GDT
Date: Mon, 18 May 2020 10:23:13 +0200
Message-ID: <20200518082313.GA25034@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-32-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-32-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:41PM +0200, Joerg Roedel wrote:
> @@ -480,6 +500,22 @@ SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
>  SYM_DATA(phys_base, .quad 0x0)
>  EXPORT_SYMBOL(phys_base)
>
> +/* Boot GDT used when kernel addresses are not mapped yet */
> +SYM_DATA_LOCAL(boot_gdt_descr,		.word boot_gdt_end - boot_gdt)
> +SYM_DATA_LOCAL(boot_gdt_base,		.quad 0)
> +SYM_DATA_START(boot_gdt)
> +	.quad	0
> +	.quad   0x00cf9a000000ffff	/* __KERNEL32_CS */
> +	.quad   0x00af9a000000ffff	/* __KERNEL_CS */
> +	.quad   0x00cf92000000ffff	/* __KERNEL_DS */
> +	.quad	0			/* __USER32_CS - unused */
> +	.quad	0			/* __USER_DS   - unused */
> +	.quad	0			/* __USER_CS   - unused */
> +	.quad	0			/* unused */
> +	.quad   0x0080890000000000	/* TSS descriptor */
> +	.quad   0x0000000000000000	/* TSS continued */

Any chance you could use macros ala GDT_ENTRY_INIT() for those instead
of the naked values?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
