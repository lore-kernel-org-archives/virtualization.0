From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/5] x86-64: Add user_64bit_mode paravirt op
Date: Wed, 27 Jul 2011 10:24:10 -0700
Message-ID: <4E3049BA.7060907__45684.2869207778$1311787593$gmane$org@goop.org>
References: <cover.1311736366.git.luto@mit.edu>
	<4f4f2b2fdd92eff234f833125732b82a039203e2.1311736366.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4f4f2b2fdd92eff234f833125732b82a039203e2.1311736366.git.luto@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@MIT.EDU>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/26/2011 08:20 PM, Andy Lutomirski wrote:
> Three places in the kernel assume that the only long mode CPL 3
> selector is __USER_CS.  This is not true on Xen -- Xen's sysretq
> changes cs to the magic value 0xe033.
>
> Two of the places are corner cases, but as of "x86-64: Improve
> vsyscall emulation CS and RIP handling"
> (c9712944b2a12373cb6ff8059afcfb7e826a6c54), vsyscalls will segfault
> if called with Xen's extra CS selector.  This causes a panic when
> older init builds die.
>
> It seems impossible to make Xen use __USER_CS reliably without
> taking a performance hit on every system call, so this fixes the
> tests instead with a new paravirt op.  It's a little ugly because
> ptrace.h can't include paravirt.h.
>
> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/include/asm/desc.h           |    4 ++--
>  arch/x86/include/asm/paravirt_types.h |    6 ++++++
>  arch/x86/include/asm/ptrace.h         |   19 +++++++++++++++++++
>  arch/x86/kernel/paravirt.c            |    4 ++++
>  arch/x86/kernel/step.c                |    2 +-
>  arch/x86/kernel/vsyscall_64.c         |    6 +-----
>  arch/x86/mm/fault.c                   |    2 +-
>  arch/x86/xen/enlighten.c              |    1 +
>  8 files changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index 7b439d9..41935fa 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -27,8 +27,8 @@ static inline void fill_ldt(struct desc_struct *desc, const struct user_desc *in
>  
>  	desc->base2		= (info->base_addr & 0xff000000) >> 24;
>  	/*
> -	 * Don't allow setting of the lm bit. It is useless anyway
> -	 * because 64bit system calls require __USER_CS:
> +	 * Don't allow setting of the lm bit. It would confuse
> +	 * user_64bit_mode and would get overridden by sysret anyway.
>  	 */
>  	desc->l			= 0;
>  }
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 2c76521..8e8b9a4 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -41,6 +41,7 @@
>  
>  #include <asm/desc_defs.h>
>  #include <asm/kmap_types.h>
> +#include <asm/pgtable_types.h>
>  
>  struct page;
>  struct thread_struct;
> @@ -63,6 +64,11 @@ struct paravirt_callee_save {
>  struct pv_info {
>  	unsigned int kernel_rpl;
>  	int shared_kernel_pmd;
> +
> +#ifdef CONFIG_X86_64
> +	u16 extra_user_64bit_cs;  /* __USER_CS if none */
> +#endif
> +
>  	int paravirt_enabled;
>  	const char *name;
>  };
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 94e7618..3566454 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -131,6 +131,9 @@ struct pt_regs {
>  #ifdef __KERNEL__
>  
>  #include <linux/init.h>
> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt_types.h>
> +#endif
>  
>  struct cpuinfo_x86;
>  struct task_struct;
> @@ -187,6 +190,22 @@ static inline int v8086_mode(struct pt_regs *regs)
>  #endif
>  }
>  
> +#ifdef CONFIG_X86_64
> +static inline bool user_64bit_mode(struct pt_regs *regs)
> +{
> +#ifndef CONFIG_PARAVIRT
> +	/*
> +	 * On non-paravirt systems, this is the only long mode CPL 3
> +	 * selector.  We do not allow long mode selectors in the LDT.
> +	 */
> +	return regs->cs == __USER_CS;
> +#else
> +	/* Headers are too twisted for this to go in paravirt.h. */
> +	return regs->cs == __USER_CS || regs->cs == pv_info.extra_user_64bit_cs;

Is this necessary because usermode may sometimes be on __USER_CS or
sometimes on Xen's?  Could we just commit to one or the other and make
it a simple comparison?

What if __USER_CS were a variable?

    J
> +#endif
> +}
> +#endif
> +
>  /*
>   * X86_32 CPUs don't save ss and esp if the CPU is already in kernel mode
>   * when it traps.  The previous stack will be directly underneath the saved
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 613a793..d90272e 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -307,6 +307,10 @@ struct pv_info pv_info = {
>  	.paravirt_enabled = 0,
>  	.kernel_rpl = 0,
>  	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
> +
> +#ifdef CONFIG_X86_64
> +	.extra_user_64bit_cs = __USER_CS,
> +#endif
>  };
>  
>  struct pv_init_ops pv_init_ops = {
> diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
> index 7977f0c..c346d11 100644
> --- a/arch/x86/kernel/step.c
> +++ b/arch/x86/kernel/step.c
> @@ -74,7 +74,7 @@ static int is_setting_trap_flag(struct task_struct *child, struct pt_regs *regs)
>  
>  #ifdef CONFIG_X86_64
>  		case 0x40 ... 0x4f:
> -			if (regs->cs != __USER_CS)
> +			if (!user_64bit_mode(regs))
>  				/* 32-bit mode: register increment */
>  				return 0;
>  			/* 64-bit mode: REX prefix */
> diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
> index dda7dff..1725930 100644
> --- a/arch/x86/kernel/vsyscall_64.c
> +++ b/arch/x86/kernel/vsyscall_64.c
> @@ -127,11 +127,7 @@ void dotraplinkage do_emulate_vsyscall(struct pt_regs *regs, long error_code)
>  
>  	local_irq_enable();
>  
> -	/*
> -	 * Real 64-bit user mode code has cs == __USER_CS.  Anything else
> -	 * is bogus.
> -	 */
> -	if (regs->cs != __USER_CS) {
> +	if (!user_64bit_mode(regs)) {
>  		/*
>  		 * If we trapped from kernel mode, we might as well OOPS now
>  		 * instead of returning to some random address and OOPSing
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 4d09df0..decd51a 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -105,7 +105,7 @@ check_prefetch_opcode(struct pt_regs *regs, unsigned char *instr,
>  		 * but for now it's good enough to assume that long
>  		 * mode only uses well known segments or kernel.
>  		 */
> -		return (!user_mode(regs)) || (regs->cs == __USER_CS);
> +		return (!user_mode(regs) || user_64bit_mode(regs));
>  #endif
>  	case 0x60:
>  		/* 0x64 thru 0x67 are valid prefixes in all modes. */
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 974a528..a9c710a 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -950,6 +950,7 @@ static unsigned xen_patch(u8 type, u16 clobbers, void *insnbuf,
>  static const struct pv_info xen_info __initconst = {
>  	.paravirt_enabled = 1,
>  	.shared_kernel_pmd = 0,
> +	.extra_user_64bit_cs = FLAT_USER_CS64,
>  
>  	.name = "Xen",
>  };
