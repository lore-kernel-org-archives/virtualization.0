From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 03/18] x86/tsc/paravirt: Remove the read_tsc and
	read_tscp paravirt hooks
Date: Wed, 17 Jun 2015 11:56:19 +0200
Message-ID: <20150617095619.GD26661@pd.tnic>
References: <cover.1434501120.git.luto@kernel.org>
	<d08a2600fb298af163681e5efd8e599d889a5b97.1434501121.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d08a2600fb298af163681e5efd8e599d889a5b97.1434501121.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, virtualization@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>, John Stultz <john.stultz@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

+ paravirt list.

On Tue, Jun 16, 2015 at 05:35:51PM -0700, Andy Lutomirski wrote:
> We've had read_tsc and read_tscp paravirt hooks since the very
> beginning of paravirt, i.e., d3561b7fa0fb ("[PATCH] paravirt: header
> and stubs for paravirtualisation").  AFAICT the only paravirt guest
> implementation that ever replaced these calls was vmware, and it's
> gone.  Arguably even vmware shouldn't have hooked rdtsc -- we fully
> support systems that don't have a TSC at all, so there's no point
> for a paravirt implementation to pretend that we have a TSC but to
> replace it.
> 
> I also doubt that these hooks actually worked.  Calls to rdtscl and
> rdtscll, which respected the hooks, were used seemingly
> interchangeably with native_read_tsc, which did not.
> 
> Just remove them.  If anyone ever needs them again, they can try
> to make a case for why they need them.
> 
> Before, on a paravirt config:
>    text	   data	    bss	    dec	    hex	filename
> 13426505	1827056	14508032	29761593	1c62039	vmlinux
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
> 13426617	1827056	14508032	29761705	1c620a9	vmlinux
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/msr.h            | 16 ++++++++--------
>  arch/x86/include/asm/paravirt.h       | 34 ----------------------------------
>  arch/x86/include/asm/paravirt_types.h |  2 --
>  arch/x86/kernel/paravirt.c            |  2 --
>  arch/x86/kernel/paravirt_patch_32.c   |  2 --
>  arch/x86/xen/enlighten.c              |  3 ---
>  6 files changed, 8 insertions(+), 51 deletions(-)

Nice diffstat.

Acked-by: Borislav Petkov <bp@suse.de>

(leaving in the rest for reference)

> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 88711470af7f..d1afac7df484 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -178,12 +178,6 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
>  	return err;
>  }
>  
> -#define rdtscl(low)						\
> -	((low) = (u32)native_read_tsc())
> -
> -#define rdtscll(val)						\
> -	((val) = native_read_tsc())
> -
>  #define rdpmc(counter, low, high)			\
>  do {							\
>  	u64 _l = native_read_pmc((counter));		\
> @@ -193,6 +187,14 @@ do {							\
>  
>  #define rdpmcl(counter, val) ((val) = native_read_pmc(counter))
>  
> +#endif	/* !CONFIG_PARAVIRT */
> +
> +#define rdtscl(low)						\
> +	((low) = (u32)native_read_tsc())
> +
> +#define rdtscll(val)						\
> +	((val) = native_read_tsc())
> +
>  #define rdtscp(low, high, aux)					\
>  do {                                                            \
>  	unsigned long long _val = native_read_tscp(&(aux));     \
> @@ -202,8 +204,6 @@ do {                                                            \
>  
>  #define rdtscpll(val, aux) (val) = native_read_tscp(&(aux))
>  
> -#endif	/* !CONFIG_PARAVIRT */
> -
>  /*
>   * 64-bit version of wrmsr_safe():
>   */
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index d143bfad45d7..c2be0375bcad 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -174,19 +174,6 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
>  	return err;
>  }
>  
> -static inline u64 paravirt_read_tsc(void)
> -{
> -	return PVOP_CALL0(u64, pv_cpu_ops.read_tsc);
> -}
> -
> -#define rdtscl(low)				\
> -do {						\
> -	u64 _l = paravirt_read_tsc();		\
> -	low = (int)_l;				\
> -} while (0)
> -
> -#define rdtscll(val) (val = paravirt_read_tsc())
> -
>  static inline unsigned long long paravirt_sched_clock(void)
>  {
>  	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
> @@ -215,27 +202,6 @@ do {						\
>  
>  #define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
>  
> -static inline unsigned long long paravirt_rdtscp(unsigned int *aux)
> -{
> -	return PVOP_CALL1(u64, pv_cpu_ops.read_tscp, aux);
> -}
> -
> -#define rdtscp(low, high, aux)				\
> -do {							\
> -	int __aux;					\
> -	unsigned long __val = paravirt_rdtscp(&__aux);	\
> -	(low) = (u32)__val;				\
> -	(high) = (u32)(__val >> 32);			\
> -	(aux) = __aux;					\
> -} while (0)
> -
> -#define rdtscpll(val, aux)				\
> -do {							\
> -	unsigned long __aux; 				\
> -	val = paravirt_rdtscp(&__aux);			\
> -	(aux) = __aux;					\
> -} while (0)
> -
>  static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
>  {
>  	PVOP_VCALL2(pv_cpu_ops.alloc_ldt, ldt, entries);
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index a6b8f9fadb06..ce029e4fa7c6 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -156,9 +156,7 @@ struct pv_cpu_ops {
>  	u64 (*read_msr)(unsigned int msr, int *err);
>  	int (*write_msr)(unsigned int msr, unsigned low, unsigned high);
>  
> -	u64 (*read_tsc)(void);
>  	u64 (*read_pmc)(int counter);
> -	unsigned long long (*read_tscp)(unsigned int *aux);
>  
>  #ifdef CONFIG_X86_32
>  	/*
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 58bcfb67c01f..f68e48f5f6c2 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -351,9 +351,7 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
>  	.wbinvd = native_wbinvd,
>  	.read_msr = native_read_msr_safe,
>  	.write_msr = native_write_msr_safe,
> -	.read_tsc = native_read_tsc,
>  	.read_pmc = native_read_pmc,
> -	.read_tscp = native_read_tscp,
>  	.load_tr_desc = native_load_tr_desc,
>  	.set_ldt = native_set_ldt,
>  	.load_gdt = native_load_gdt,
> diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
> index e1b013696dde..c89f50a76e97 100644
> --- a/arch/x86/kernel/paravirt_patch_32.c
> +++ b/arch/x86/kernel/paravirt_patch_32.c
> @@ -10,7 +10,6 @@ DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
>  DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
>  DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
>  DEF_NATIVE(pv_cpu_ops, clts, "clts");
> -DEF_NATIVE(pv_cpu_ops, read_tsc, "rdtsc");
>  
>  #if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUED_SPINLOCKS)
>  DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
> @@ -52,7 +51,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
>  		PATCH_SITE(pv_mmu_ops, read_cr3);
>  		PATCH_SITE(pv_mmu_ops, write_cr3);
>  		PATCH_SITE(pv_cpu_ops, clts);
> -		PATCH_SITE(pv_cpu_ops, read_tsc);
>  #if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUED_SPINLOCKS)
>  		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
>  			if (pv_is_native_spin_unlock()) {
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 0b95c9b8283f..32136bfca43f 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -1175,11 +1175,8 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
>  	.read_msr = xen_read_msr_safe,
>  	.write_msr = xen_write_msr_safe,
>  
> -	.read_tsc = native_read_tsc,
>  	.read_pmc = native_read_pmc,
>  
> -	.read_tscp = native_read_tscp,
> -
>  	.iret = xen_iret,
>  #ifdef CONFIG_X86_64
>  	.usergs_sysret32 = xen_sysret32,
> -- 
> 2.4.2
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
