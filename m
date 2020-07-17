From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/75] x86/insn: Make inat-tables.c suitable for
 pre-decompression code
Date: Fri, 17 Jul 2020 22:58:26 +0900
Message-ID: <20200717225826.3b16e168de2a1573150e7952@kernel.org>
References: <20200714120917.11253-1-joro@8bytes.org>
        <20200714120917.11253-7-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200714120917.11253-7-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Jul 2020 14:08:08 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> The inat-tables.c file has some arrays in it that contain pointers to
> other arrays. These pointers need to be relocated when the kernel
> image is moved to a different location.
> 
> The pre-decompression boot-code has no support for applying ELF
> relocations, so initialize these arrays at runtime in the
> pre-decompression code to make sure all pointers are correctly
> initialized.

OK, This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/tools/gen-insn-attr-x86.awk       | 50 +++++++++++++++++++++-
>  tools/arch/x86/tools/gen-insn-attr-x86.awk | 50 +++++++++++++++++++++-
>  2 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
> index a42015b305f4..af38469afd14 100644
> --- a/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -362,6 +362,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
>  END {
>  	if (awkchecked != "")
>  		exit 1
> +
> +	print "#ifndef __BOOT_COMPRESSED\n"
> +
>  	# print escape opcode map's array
>  	print "/* Escape opcode map array */"
>  	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
> @@ -388,6 +391,51 @@ END {
>  		for (j = 0; j < max_lprefix; j++)
>  			if (atable[i,j])
>  				print "	["i"]["j"] = "atable[i,j]","
> -	print "};"
> +	print "};\n"
> +
> +	print "#else /* !__BOOT_COMPRESSED */\n"
> +
> +	print "/* Escape opcode map array */"
> +	print "static const insn_attr_t *inat_escape_tables[INAT_ESC_MAX + 1]" \
> +	      "[INAT_LSTPFX_MAX + 1];"
> +	print ""
> +
> +	print "/* Group opcode map array */"
> +	print "static const insn_attr_t *inat_group_tables[INAT_GRP_MAX + 1]"\
> +	      "[INAT_LSTPFX_MAX + 1];"
> +	print ""
> +
> +	print "/* AVX opcode map array */"
> +	print "static const insn_attr_t *inat_avx_tables[X86_VEX_M_MAX + 1]"\
> +	      "[INAT_LSTPFX_MAX + 1];"
> +	print ""
> +
> +	print "static void inat_init_tables(void)"
> +	print "{"
> +
> +	# print escape opcode map's array
> +	print "\t/* Print Escape opcode map array */"
> +	for (i = 0; i < geid; i++)
> +		for (j = 0; j < max_lprefix; j++)
> +			if (etable[i,j])
> +				print "\tinat_escape_tables["i"]["j"] = "etable[i,j]";"
> +	print ""
> +
> +	# print group opcode map's array
> +	print "\t/* Print Group opcode map array */"
> +	for (i = 0; i < ggid; i++)
> +		for (j = 0; j < max_lprefix; j++)
> +			if (gtable[i,j])
> +				print "\tinat_group_tables["i"]["j"] = "gtable[i,j]";"
> +	print ""
> +	# print AVX opcode map's array
> +	print "\t/* Print AVX opcode map array */"
> +	for (i = 0; i < gaid; i++)
> +		for (j = 0; j < max_lprefix; j++)
> +			if (atable[i,j])
> +				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
> +
> +	print "}"
> +	print "#endif"
>  }
>  
> diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> index a42015b305f4..af38469afd14 100644
> --- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -362,6 +362,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
>  END {
>  	if (awkchecked != "")
>  		exit 1
> +
> +	print "#ifndef __BOOT_COMPRESSED\n"
> +
>  	# print escape opcode map's array
>  	print "/* Escape opcode map array */"
>  	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
> @@ -388,6 +391,51 @@ END {
>  		for (j = 0; j < max_lprefix; j++)
>  			if (atable[i,j])
>  				print "	["i"]["j"] = "atable[i,j]","
> -	print "};"
> +	print "};\n"
> +
> +	print "#else /* !__BOOT_COMPRESSED */\n"
> +
> +	print "/* Escape opcode map array */"
> +	print "static const insn_attr_t *inat_escape_tables[INAT_ESC_MAX + 1]" \
> +	      "[INAT_LSTPFX_MAX + 1];"
> +	print ""
> +
> +	print "/* Group opcode map array */"
> +	print "static const insn_attr_t *inat_group_tables[INAT_GRP_MAX + 1]"\
> +	      "[INAT_LSTPFX_MAX + 1];"
> +	print ""
> +
> +	print "/* AVX opcode map array */"
> +	print "static const insn_attr_t *inat_avx_tables[X86_VEX_M_MAX + 1]"\
> +	      "[INAT_LSTPFX_MAX + 1];"
> +	print ""
> +
> +	print "static void inat_init_tables(void)"
> +	print "{"
> +
> +	# print escape opcode map's array
> +	print "\t/* Print Escape opcode map array */"
> +	for (i = 0; i < geid; i++)
> +		for (j = 0; j < max_lprefix; j++)
> +			if (etable[i,j])
> +				print "\tinat_escape_tables["i"]["j"] = "etable[i,j]";"
> +	print ""
> +
> +	# print group opcode map's array
> +	print "\t/* Print Group opcode map array */"
> +	for (i = 0; i < ggid; i++)
> +		for (j = 0; j < max_lprefix; j++)
> +			if (gtable[i,j])
> +				print "\tinat_group_tables["i"]["j"] = "gtable[i,j]";"
> +	print ""
> +	# print AVX opcode map's array
> +	print "\t/* Print AVX opcode map array */"
> +	for (i = 0; i < gaid; i++)
> +		for (j = 0; j < max_lprefix; j++)
> +			if (atable[i,j])
> +				print "\tinat_avx_tables["i"]["j"] = "atable[i,j]";"
> +
> +	print "}"
> +	print "#endif"
>  }
>  
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
