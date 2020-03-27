From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 08/70] x86/insn: Add insn_get_modrm_reg_off()
Date: Fri, 27 Mar 2020 12:57:51 +0900
Message-ID: <20200327125751.1b6cdf8e298fd0d2ce5f3d1f@kernel.org>
References: <20200319091407.1481-1-joro@8bytes.org>
        <20200319091407.1481-9-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-9-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 19 Mar 2020 10:13:05 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> Add a function to the instruction decoder which returns the pt_regs
> offset of the register specified in the reg field of the modrm byte.
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/insn-eval.h |  1 +
>  arch/x86/lib/insn-eval.c         | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index b4ff3e3316d1..1e343010129e 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h
> @@ -17,6 +17,7 @@
>  
>  void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
>  int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
> +int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
>  unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
>  int insn_get_code_seg_params(struct pt_regs *regs);
>  int insn_fetch_from_user(struct pt_regs *regs,
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 1949f5258f9e..f18260a19960 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -20,6 +20,7 @@
>  
>  enum reg_type {
>  	REG_TYPE_RM = 0,
> +	REG_TYPE_REG,
>  	REG_TYPE_INDEX,
>  	REG_TYPE_BASE,
>  };
> @@ -441,6 +442,13 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
>  			regno += 8;
>  		break;
>  
> +	case REG_TYPE_REG:
> +		regno = X86_MODRM_REG(insn->modrm.value);
> +
> +		if (X86_REX_R(insn->rex_prefix.value))
> +			regno += 8;
> +		break;
> +
>  	case REG_TYPE_INDEX:
>  		regno = X86_SIB_INDEX(insn->sib.value);
>  		if (X86_REX_X(insn->rex_prefix.value))
> @@ -809,6 +817,21 @@ int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs)
>  	return get_reg_offset(insn, regs, REG_TYPE_RM);
>  }
>  
> +/**
> + * insn_get_modrm_reg_off() - Obtain register in reg part of the ModRM byte
> + * @insn:	Instruction containing the ModRM byte
> + * @regs:	Register values as seen when entering kernel mode
> + *
> + * Returns:
> + *
> + * The register indicated by the reg part of the ModRM byte. The
> + * register is obtained as an offset from the base of pt_regs.
> + */
> +int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
> +{
> +	return get_reg_offset(insn, regs, REG_TYPE_REG);
> +}
> +
>  /**
>   * get_seg_base_limit() - obtain base address and limit of a segment
>   * @insn:	Instruction. Must be valid.
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
