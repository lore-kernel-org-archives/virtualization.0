From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 07/13] x86/paravirt: Simplify ____PVOP_CALL()
Date: Wed, 22 Nov 2017 17:35:46 +0100
Message-ID: <20171122163546.ikjzkyzg3n5fyi6z__8218.08693367547$1511368578$gmane$org@pd.tnic>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<e09e6cb4f4717fc6d81ddb5fc38cd45504348ce1.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e09e6cb4f4717fc6d81ddb5fc38cd45504348ce1.1507128293.git.jpoimboe@redhat.com>
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

On Wed, Oct 04, 2017 at 10:58:28AM -0500, Josh Poimboeuf wrote:
> Remove the inline asm duplication in ____PVOP_CALL().
> 
> Also add 'IS_ENABLED(CONFIG_X86_32)' to the return variable logic,
> making the code clearer and rendering the comment unnecessary.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/paravirt_types.h | 36 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index ab7aabe6b668..01f9e10983c1 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -529,29 +529,19 @@ int paravirt_disable_iospace(void);
>  		rettype __ret;						\
>  		PVOP_CALL_ARGS;						\
>  		PVOP_TEST_NULL(op);					\

Newline here...

> -		/* This is 32-bit specific, but is okay in 64-bit */	\
> -		/* since this condition will never hold */		\
> -		if (sizeof(rettype) > sizeof(unsigned long)) {		\
> -			asm volatile(pre				\
> -				     paravirt_alt(PARAVIRT_CALL)	\
> -				     post				\
> -				     : call_clbr, ASM_CALL_CONSTRAINT	\
> -				     : paravirt_type(op),		\
> -				       paravirt_clobber(clbr),		\
> -				       ##__VA_ARGS__			\
> -				     : "memory", "cc" extra_clbr);	\
> -			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
> -		} else {						\
> -			asm volatile(pre				\
> -				     paravirt_alt(PARAVIRT_CALL)	\
> -				     post				\
> -				     : call_clbr, ASM_CALL_CONSTRAINT	\
> -				     : paravirt_type(op),		\
> -				       paravirt_clobber(clbr),		\
> -				       ##__VA_ARGS__			\
> -				     : "memory", "cc" extra_clbr);	\
> -			__ret = (rettype)(__eax & PVOP_RETMASK(rettype));	\
> -		}							\
> +		asm volatile(pre					\
> +			     paravirt_alt(PARAVIRT_CALL)		\
> +			     post					\
> +			     : call_clbr, ASM_CALL_CONSTRAINT		\
> +			     : paravirt_type(op),			\
> +			       paravirt_clobber(clbr),			\
> +			       ##__VA_ARGS__				\
> +			     : "memory", "cc" extra_clbr);		\

... and here goes a long way towards readability. :)

> +		if (IS_ENABLED(CONFIG_X86_32) &&			\
> +		    sizeof(rettype) > sizeof(unsigned long))		\
> +			__ret = (rettype)((((u64)__edx) << 32) | __eax);\
> +		else							\
> +			__ret = (rettype)(__eax & PVOP_RETMASK(rettype));\
>  		__ret;							\
>  	})

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
