From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 06/12] i386: Minimum cpu detection cleanups.
Date: Mon, 30 Apr 2007 09:13:46 -0700
Message-ID: <463615BA.4020703@zytor.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>	<m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>	<m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mz0p4zfc.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1mz0p4zfc.fsf_-_@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> 
> diff --git a/arch/i386/kernel/verify_cpu.S b/arch/i386/kernel/verify_cpu.S
> index ba9e03e..e51a869 100644
> --- a/arch/i386/kernel/verify_cpu.S
> +++ b/arch/i386/kernel/verify_cpu.S
> @@ -4,10 +4,6 @@
>  #include <asm/cpufeature.h>
>  
>  verify_cpu:
> -#if REQUIRED_MASK1 == 0
> -	xorl %eax,%eax
> -	ret
> -#endif
>  	pushfl				# Save caller passed flags
>  	pushl	$0			# Kill any dangerous flags
>  	popfl
> @@ -21,7 +17,7 @@ verify_cpu:
>  	testl	$(1<<18),%eax
                 ^^^^^^^
>  	jz	bad

While you're in there can you change references to the flags to use the
<asm/cpuflags.h> constants?

	-hpa
