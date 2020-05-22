From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 45/75] x86/dumpstack/64: Handle #VC exception stacks
Date: Fri, 22 May 2020 15:06:41 +0200
Message-ID: <20200522130641.GE28750@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-46-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-46-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:55PM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> index 14db05086bbf..2f3534ef4b5f 100644
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -21,6 +21,10 @@ enum stack_type {
>  	STACK_TYPE_ENTRY,
>  	STACK_TYPE_EXCEPTION,
>  	STACK_TYPE_EXCEPTION_LAST = STACK_TYPE_EXCEPTION + N_EXCEPTION_STACKS-1,
> +#ifdef CONFIG_X86_64

CONFIG_AMD_MEM_ENCRYPT

> +	STACK_TYPE_VC,
> +	STACK_TYPE_VC_LAST = STACK_TYPE_VC + N_VC_STACKS - 1,
> +#endif
>  };
>  
>  struct stack_info {
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index 87b97897a881..2468963c1424 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -18,6 +18,7 @@
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> +#include <asm/sev-es.h>
>  
>  static const char * const exception_stack_names[] = {
>  		[ ESTACK_DF	]	= "#DF",
> @@ -47,6 +48,9 @@ const char *stack_type_name(enum stack_type type)
>  	if (type >= STACK_TYPE_EXCEPTION && type <= STACK_TYPE_EXCEPTION_LAST)
>  		return exception_stack_names[type - STACK_TYPE_EXCEPTION];
>  
> +	if (type >= STACK_TYPE_VC && type <= STACK_TYPE_VC_LAST)

That test can be inside vc_stack_name() so that it gets optimized away
for !CONFIG_AMD_MEM_ENCRYPT and there's no need for ifdeffery.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
