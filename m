From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V3 4/4] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Mon, 5 Dec 2011 22:27:41 -0500
Message-ID: <20111206032741.GF6647@phenom.dumpdata.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130090038.23386.4505.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111130090038.23386.4505.sendpatchset@oc5400248562.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Xen <xen-devel@lists.xensource.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 30, 2011 at 02:30:38PM +0530, Raghavendra K T wrote:
> This patch extends Linux guests running on KVM hypervisor to support
> pv-ticketlocks. 
> During smp_boot_cpus  paravirtualied KVM guest detects if the hypervisor has
> required feature (KVM_FEATURE_KICK_VCPU) to support pv-ticketlocks. If so,
>  support for pv-ticketlocks is registered via pv_lock_ops.
> 
> Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 8b1d65d..7e419ad 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -195,10 +195,21 @@ void kvm_async_pf_task_wait(u32 token);
>  void kvm_async_pf_task_wake(u32 token);
>  u32 kvm_read_and_reset_pf_reason(void);
>  extern void kvm_disable_steal_time(void);
> -#else
> -#define kvm_guest_init() do { } while (0)
> +
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +void __init kvm_spinlock_init(void);
> +#else /* CONFIG_PARAVIRT_SPINLOCKS */
> +static void kvm_spinlock_init(void)
> +{
> +}
> +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
> +
> +#else /* CONFIG_KVM_GUEST */
> +#define kvm_guest_init() do {} while (0)
>  #define kvm_async_pf_task_wait(T) do {} while(0)
>  #define kvm_async_pf_task_wake(T) do {} while(0)
> +#define kvm_spinlock_init() do {} while (0)
> +
>  static inline u32 kvm_read_and_reset_pf_reason(void)
>  {
>  	return 0;
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index a9c2116..dffeea3 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -33,6 +33,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/kprobes.h>
> +#include <linux/debugfs.h>
>  #include <asm/timer.h>
>  #include <asm/cpu.h>
>  #include <asm/traps.h>
> @@ -545,6 +546,7 @@ static void __init kvm_smp_prepare_boot_cpu(void)
>  #endif
>  	kvm_guest_cpu_init();
>  	native_smp_prepare_boot_cpu();
> +	kvm_spinlock_init();
>  }
>  
>  static void __cpuinit kvm_guest_cpu_online(void *dummy)
> @@ -627,3 +629,248 @@ static __init int activate_jump_labels(void)
>  	return 0;
>  }
>  arch_initcall(activate_jump_labels);
> +
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +
> +enum kvm_contention_stat {
> +	TAKEN_SLOW,
> +	TAKEN_SLOW_PICKUP,
> +	RELEASED_SLOW,
> +	RELEASED_SLOW_KICKED,
> +	NR_CONTENTION_STATS
> +};
> +
> +#ifdef CONFIG_KVM_DEBUG_FS
> +
> +static struct kvm_spinlock_stats
> +{
> +	u32 contention_stats[NR_CONTENTION_STATS];
> +
> +#define HISTO_BUCKETS	30
> +	u32 histo_spin_blocked[HISTO_BUCKETS+1];
> +
> +	u64 time_blocked;
> +} spinlock_stats;
> +
> +static u8 zero_stats;
> +
> +static inline void check_zero(void)
> +{
> +	u8 ret;
> +	u8 old = ACCESS_ONCE(zero_stats);
> +	if (unlikely(old)) {
> +		ret = cmpxchg(&zero_stats, old, 0);
> +		/* This ensures only one fellow resets the stat */
> +		if (ret == old)
> +			memset(&spinlock_stats, 0, sizeof(spinlock_stats));
> +	}
> +}
> +
> +static inline void add_stats(enum kvm_contention_stat var, int val)

You probably want 'int val' to be 'u32 val' as that is the type
in contention_stats.
