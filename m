From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 08/13] x86/paravirt: Clean up paravirt_types.h
Date: Wed, 22 Nov 2017 21:46:10 +0100
Message-ID: <20171122204610.mtpjea2wbeuey5mp__276.647069449787$1511383605$gmane$org@pd.tnic>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<38b16ecbfa88b41239e8a87ce1d8330fea7a2b3a.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <38b16ecbfa88b41239e8a87ce1d8330fea7a2b3a.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 04, 2017 at 10:58:29AM -0500, Josh Poimboeuf wrote:
> Make paravirt_types.h more understandable:
> 
> - Use more consistent and logical naming
> - Simplify interfaces
> - Put related macros together
> - Improve whitespace
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/paravirt_types.h | 104 ++++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 01f9e10983c1..5656aea79412 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h

...

> @@ -388,13 +361,46 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
>  
>  int paravirt_disable_iospace(void);
>  
> +
>  /*
> - * This generates an indirect call based on the operation type number.
> - * The type number, computed in PARAVIRT_PATCH, is derived from the
> - * offset into the paravirt_patch_template structure, and can therefore be
> - * freely converted back into a structure offset.
> + * Generate some code, and mark it as patchable by apply_paravirt().
>   */
> -#define PARAVIRT_CALL	"call *%c[paravirt_opptr];"
> +#define _PV_SITE(insn_string, type, clobber)				\
> +	"771:\n\t" insn_string "\n" "772:\n"				\

You can merge the last two strings into one.

Also, s/insn_string/insns/ so that it is the same as in paravirt-asm.h
PV_SITE definition. Ditto for s/clobber/clobbers/ I.e., in general,
have the same parameter names in the respective macros so that they can
be parsed visually quickly and reader can say, aha, I see, that's that
param from the asm version of the macro.

> +	".pushsection .parainstructions,\"a\"\n"			\
> +	_ASM_ALIGN "\n"							\
> +	_ASM_PTR " 771b\n"						\
> +	"  .byte " type "\n"						\
> +	"  .byte 772b-771b\n"						\
> +	"  .short " clobber "\n"					\
> +	".popsection\n"
> +
> +#define PARAVIRT_PATCH(x)						\

Btw, that macro's name doesn't tell me anything: it should be
PV_INSN_TYPE or so.

> +	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
> +
> +#define PV_STRINGIFY(constraint)	"%c[" __stringify(constraint) "]"
> +
> +#define PV_CALL_CONSTRAINT		pv_op_ptr
> +#define PV_TYPE_CONSTRAINT		pv_typenum
> +#define PV_CLBR_CONSTRAINT		pv_clobber
> +
> +#define PV_CALL_CONSTRAINT_STR		PV_STRINGIFY(PV_CALL_CONSTRAINT)
> +#define PV_TYPE_CONSTRAINT_STR		PV_STRINGIFY(PV_TYPE_CONSTRAINT)
> +#define PV_CLBR_CONSTRAINT_STR		PV_STRINGIFY(PV_CLBR_CONSTRAINT)
> +
> +#define PV_CALL_STR			"call *" PV_CALL_CONSTRAINT_STR ";"
> +
> +#define PV_INPUT_CONSTRAINTS(op, clobber)				\
> +	[PV_TYPE_CONSTRAINT] "i" (PARAVIRT_PATCH(op)),			\
> +	[PV_CALL_CONSTRAINT] "i" (&(op)),				\
> +	[PV_CLBR_CONSTRAINT] "i" (clobber)
> +
> +#define PV_SITE(insn_string)						\
> +	_PV_SITE(insn_string, PV_TYPE_CONSTRAINT_STR, PV_CLBR_CONSTRAINT_STR)
> +
> +#define PV_ALT_SITE(oldinstr, newinstr)					\
> +	_PV_ALT_SITE(oldinstr, newinstr, PV_TYPE_CONSTRAINT_STR,	\
> +		     PV_CLBR_CONSTRAINT_STR)
>  
>  /*
>   * These macros are intended to wrap calls through one of the paravirt
> @@ -525,25 +531,24 @@ int paravirt_disable_iospace(void);
>  
>  #define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr,		\
>  		      pre, post, ...)					\
> -	({								\
> -		rettype __ret;						\
> -		PVOP_CALL_ARGS;						\
> -		PVOP_TEST_NULL(op);					\
> +({									\
> +	rettype __ret;							\
> +	PVOP_CALL_ARGS;							\
> +	PVOP_TEST_NULL(op);						\
>  		asm volatile(pre					\
> -			     paravirt_alt(PARAVIRT_CALL)		\
> +			     PV_SITE(PV_CALL_STR)			\
>  			     post					\
>  			     : call_clbr, ASM_CALL_CONSTRAINT		\
> -			     : paravirt_type(op),			\
> -			       paravirt_clobber(clbr),			\
> +			     : PV_INPUT_CONSTRAINTS(op, clbr),		\
>  			       ##__VA_ARGS__				\
>  			     : "memory", "cc" extra_clbr);		\
> -		if (IS_ENABLED(CONFIG_X86_32) &&			\
> -		    sizeof(rettype) > sizeof(unsigned long))		\
> -			__ret = (rettype)((((u64)__edx) << 32) | __eax);\
> -		else							\
> -			__ret = (rettype)(__eax & PVOP_RETMASK(rettype));\
> -		__ret;							\
> -	})

<---- newline here.

> +	if (IS_ENABLED(CONFIG_X86_32) &&				\
> +	    sizeof(rettype) > sizeof(unsigned long))			\
> +		__ret = (rettype)((((u64)__edx) << 32) | __eax);	\
> +	else								\
> +		__ret = (rettype)(__eax & PVOP_RETMASK(rettype));	\
> +	__ret;								\
> +})
-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
