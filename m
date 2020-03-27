From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 09/70] x86/insn: Add insn_rep_prefix() helper
Date: Fri, 27 Mar 2020 12:56:33 +0900
Message-ID: <20200327125633.ff660b1f4b14ca941fd1c799@kernel.org>
References: <20200319091407.1481-1-joro@8bytes.org>
        <20200319091407.1481-10-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-10-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 19 Mar 2020 10:13:06 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> Add a function to check whether an instruction has a REP prefix.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/insn-eval.h |  1 +
>  arch/x86/lib/insn-eval.c         | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index 1e343010129e..41dee0faae97 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h
> @@ -15,6 +15,7 @@
>  #define INSN_CODE_SEG_OPND_SZ(params) (params & 0xf)
>  #define INSN_CODE_SEG_PARAMS(oper_sz, addr_sz) (oper_sz | (addr_sz << 4))
>  
> +bool insn_rep_prefix(struct insn *insn);

Can you make it "insn_has_rep_prefix()"?

Thank you,

>  void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
>  int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
>  int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index f18260a19960..5d98dff5a2d7 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -53,6 +53,30 @@ static bool is_string_insn(struct insn *insn)
>  	}
>  }
>  
> +/**
> + * insn_rep_prefix() - Determine if instruction has a REP prefix
> + * @insn:	Instruction containing the prefix to inspect
> + *
> + * Returns:
> + *
> + * true if the instruction has a REP prefix, false if not.
> + */
> +bool insn_rep_prefix(struct insn *insn)
> +{
> +	int i;
> +
> +	insn_get_prefixes(insn);
> +
> +	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +		insn_byte_t p = insn->prefixes.bytes[i];
> +
> +		if (p == 0xf2 || p == 0xf3)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * get_seg_reg_override_idx() - obtain segment register override index
>   * @insn:	Valid instruction with segment override prefixes
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
