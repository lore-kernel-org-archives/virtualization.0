From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 1/5] Paravirt_ops full patching.patch
Date: Thu, 19 Apr 2007 18:58:30 -0700
Message-ID: <46281E46.7040007@goop.org>
References: <20070420015224.56315BFC@zach-dev2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420015224.56315BFC@zach-dev2.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Add 5-argument handling for paravirt ops patching of PAE functions.
>
> Signed-off-by: Zachary Amsden <zach@vmware.com>
>
> diff -r dbe11208916f include/asm-i386/paravirt.h
> --- a/include/asm-i386/paravirt.h	Thu Apr 19 11:40:55 2007 -0700
> +++ b/include/asm-i386/paravirt.h	Thu Apr 19 12:04:16 2007 -0700
> @@ -308,10 +308,9 @@ unsigned paravirt_patch_insns(void *site
>   * return value handling from within these macros.  This is fairly
>   * cumbersome.
>   *
> - * There are 5 sets of PVOP_* macros for dealing with 0-4 arguments.
> - * It could be extended to more arguments, but there would be little
> - * to be gained from that.  For each number of arguments, there are
> - * the two VCALL and CALL variants for void and non-void functions.
> + * There are 5 sets of PVOP_* macros for dealing with 0-5 arguments.
> + * For each number of arguments, there are the two VCALL and CALL
> + * variants for void and non-void functions.
>   *
>   * When there is a return value, the invoker of the macro must specify
>   * the return type.  The macro then uses sizeof() on that type to
> @@ -405,6 +404,21 @@ unsigned paravirt_patch_insns(void *site
>  		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
>  		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)))
>  
> +#define PVOP_CALL5(rettype, op, arg1, arg2, arg3, arg4, arg5)		\
> +	__PVOP_CALL(rettype, op,					\
> +		    "push %[_arg5]; push %[_arg4];",			\
> +		    "lea 8(%%esp),%%esp;",				\
> +		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
> +		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)),	\
> +		    [_arg5] "mr" ((u32)(arg5)))
>   

Won't work if arg4 is a stack-relative addressing mode.  That was the
main reason I avoided 5-arg patching.  I guess using "r" as the arg4
constraint would work, but register pressure is getting pretty tight.

    J
