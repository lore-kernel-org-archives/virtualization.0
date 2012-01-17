From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH RFC V4 4/5] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Tue, 17 Jan 2012 09:02:11 -0200
Message-ID: <20120117110210.GA17420@amt.cnet>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 14, 2012 at 11:56:46PM +0530, Raghavendra K T wrote:
> Extends Linux guest running on KVM hypervisor to support pv-ticketlocks. 
> 
> During smp_boot_cpus  paravirtualied KVM guest detects if the hypervisor has
> required feature (KVM_FEATURE_PVLOCK_KICK) to support pv-ticketlocks. If so,
>  support for pv-ticketlocks is registered via pv_lock_ops.
> 
> Use KVM_HC_KICK_CPU hypercall to wakeup waiting/halted vcpu.
> 
> Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 7a94987..cf5327c 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -195,10 +195,20 @@ void kvm_async_pf_task_wait(u32 token);
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
> +
>  static inline u32 kvm_read_and_reset_pf_reason(void)
>  {
>  	return 0;
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index a9c2116..ec55a0b 100644
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
> @@ -627,3 +629,250 @@ static __init int activate_jump_labels(void)
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
> +static inline void add_stats(enum kvm_contention_stat var, u32 val)
> +{
> +	check_zero();
> +	spinlock_stats.contention_stats[var] += val;
> +}
> +
> +
> +static inline u64 spin_time_start(void)
> +{
> +	return sched_clock();
> +}
> +
> +static void __spin_time_accum(u64 delta, u32 *array)
> +{
> +	unsigned index = ilog2(delta);
> +
> +	check_zero();
> +
> +	if (index < HISTO_BUCKETS)
> +		array[index]++;
> +	else
> +		array[HISTO_BUCKETS]++;
> +}
> +
> +static inline void spin_time_accum_blocked(u64 start)
> +{
> +	u32 delta = sched_clock() - start;
> +
> +	__spin_time_accum(delta, spinlock_stats.histo_spin_blocked);
> +	spinlock_stats.time_blocked += delta;
> +}
> +
> +static struct dentry *d_spin_debug;
> +static struct dentry *d_kvm_debug;
> +
> +struct dentry *kvm_init_debugfs(void)
> +{
> +	d_kvm_debug = debugfs_create_dir("kvm", NULL);
> +	if (!d_kvm_debug)
> +		printk(KERN_WARNING "Could not create 'kvm' debugfs directory\n");
> +
> +	return d_kvm_debug;
> +}
> +
> +static int __init kvm_spinlock_debugfs(void)
> +{
> +	struct dentry *d_kvm = kvm_init_debugfs();
> +
> +	if (d_kvm == NULL)
> +		return -ENOMEM;
> +
> +	d_spin_debug = debugfs_create_dir("spinlocks", d_kvm);
> +
> +	debugfs_create_u8("zero_stats", 0644, d_spin_debug, &zero_stats);
> +
> +	debugfs_create_u32("taken_slow", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[TAKEN_SLOW]);
> +	debugfs_create_u32("taken_slow_pickup", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[TAKEN_SLOW_PICKUP]);
> +
> +	debugfs_create_u32("released_slow", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[RELEASED_SLOW]);
> +	debugfs_create_u32("released_slow_kicked", 0444, d_spin_debug,
> +		   &spinlock_stats.contention_stats[RELEASED_SLOW_KICKED]);
> +
> +	debugfs_create_u64("time_blocked", 0444, d_spin_debug,
> +			   &spinlock_stats.time_blocked);
> +
> +	debugfs_create_u32_array("histo_blocked", 0444, d_spin_debug,
> +		     spinlock_stats.histo_spin_blocked, HISTO_BUCKETS + 1);
> +
> +	return 0;
> +}
> +fs_initcall(kvm_spinlock_debugfs);
> +#else  /* !CONFIG_KVM_DEBUG_FS */
> +#define TIMEOUT			(1 << 10)
> +static inline void add_stats(enum kvm_contention_stat var, u32 val)
> +{
> +}
> +
> +static inline u64 spin_time_start(void)
> +{
> +	return 0;
> +}
> +
> +static inline void spin_time_accum_blocked(u64 start)
> +{
> +}
> +#endif  /* CONFIG_KVM_DEBUG_FS */
> +
> +struct kvm_lock_waiting {
> +	struct arch_spinlock *lock;
> +	__ticket_t want;
> +};
> +
> +/* cpus 'waiting' on a spinlock to become available */
> +static cpumask_t waiting_cpus;
> +
> +/* Track spinlock on which a cpu is waiting */
> +static DEFINE_PER_CPU(struct kvm_lock_waiting, lock_waiting);
> +
> +static void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
> +{
> +	struct kvm_lock_waiting *w = &__get_cpu_var(lock_waiting);
> +	int cpu = smp_processor_id();
> +	u64 start;
> +	unsigned long flags;
> +
> +	start = spin_time_start();
> +
> +	/*
> +	 * Make sure an interrupt handler can't upset things in a
> +	 * partially setup state.
> +	 */
> +	local_irq_save(flags);
> +
> +	/*
> +	 * The ordering protocol on this is that the "lock" pointer
> +	 * may only be set non-NULL if the "want" ticket is correct.
> +	 * If we're updating "want", we must first clear "lock".
> +	 */
> +	w->lock = NULL;
> +	smp_wmb();
> +	w->want = want;
> +	smp_wmb();
> +	w->lock = lock;
> +
> +	add_stats(TAKEN_SLOW, 1);
> +
> +	/*
> +	 * This uses set_bit, which is atomic but we should not rely on its
> +	 * reordering gurantees. So barrier is needed after this call.
> +	 */
> +	cpumask_set_cpu(cpu, &waiting_cpus);
> +
> +	barrier();
> +
> +	/*
> +	 * Mark entry to slowpath before doing the pickup test to make
> +	 * sure we don't deadlock with an unlocker.
> +	 */
> +	__ticket_enter_slowpath(lock);
> +
> +	/*
> +	 * check again make sure it didn't become free while
> +	 * we weren't looking.
> +	 */
> +	if (ACCESS_ONCE(lock->tickets.head) == want) {
> +		add_stats(TAKEN_SLOW_PICKUP, 1);
> +		goto out;
> +	}
> +
> +	/* Allow interrupts while blocked */
> +	local_irq_restore(flags);
> +
> +	/* halt until it's our turn and kicked. */
> +	halt();
> +
> +	local_irq_save(flags);
> +out:
> +	cpumask_clear_cpu(cpu, &waiting_cpus);
> +	w->lock = NULL;
> +	local_irq_restore(flags);
> +	spin_time_accum_blocked(start);
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(kvm_lock_spinning);
> +
> +/* Kick a cpu by its apicid*/
> +static inline void kvm_kick_cpu(int apicid)
> +{
> +	kvm_hypercall1(KVM_HC_KICK_CPU, apicid);
> +}
> +
> +/* Kick vcpu waiting on @lock->head to reach value @ticket */
> +static void kvm_unlock_kick(struct arch_spinlock *lock, __ticket_t ticket)
> +{
> +	int cpu;
> +	int apicid;
> +
> +	add_stats(RELEASED_SLOW, 1);
> +
> +	for_each_cpu(cpu, &waiting_cpus) {
> +		const struct kvm_lock_waiting *w = &per_cpu(lock_waiting, cpu);
> +		if (ACCESS_ONCE(w->lock) == lock &&
> +		    ACCESS_ONCE(w->want) == ticket) {
> +			add_stats(RELEASED_SLOW_KICKED, 1);
> +			apicid = per_cpu(x86_cpu_to_apicid, cpu);
> +			kvm_kick_cpu(apicid);
> +			break;
> +		}
> +	}

What prevents a kick from being lost here, if say, the waiter is at
local_irq_save in kvm_lock_spinning, before the lock/want assignments?

> +
> +/*
> + * Setup pv_lock_ops to exploit KVM_FEATURE_PVLOCK_KICK if present.
> + */
> +void __init kvm_spinlock_init(void)
> +{
> +	if (!kvm_para_available())
> +		return;
> +	/* Does host kernel support KVM_FEATURE_PVLOCK_KICK? */
> +	if (!kvm_para_has_feature(KVM_FEATURE_PVLOCK_KICK))
> +		return;
> +
> +	jump_label_inc(&paravirt_ticketlocks_enabled);
> +
> +	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
> +	pv_lock_ops.unlock_kick = kvm_unlock_kick;
> +}
> +#endif	/* CONFIG_PARAVIRT_SPINLOCKS */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c7b05fc..4d7a950 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5754,8 +5754,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  
>  	local_irq_disable();
>  
> -	if (vcpu->mode == EXITING_GUEST_MODE || vcpu->requests
> -	    || need_resched() || signal_pending(current)) {
> +	if (vcpu->mode == EXITING_GUEST_MODE
> +		 || (vcpu->requests & ~(1UL<<KVM_REQ_PVLOCK_KICK))
> +		 || need_resched() || signal_pending(current)) {
>  		vcpu->mode = OUTSIDE_GUEST_MODE;
>  		smp_wmb();
>  		local_irq_enable();
> @@ -6711,6 +6712,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
>  		!vcpu->arch.apf.halted)
>  		|| !list_empty_careful(&vcpu->async_pf.done)
>  		|| vcpu->arch.mp_state == KVM_MP_STATE_SIPI_RECEIVED
> +		|| kvm_check_request(KVM_REQ_PVLOCK_KICK, vcpu)

The bit should only be read here (kvm_arch_vcpu_runnable), but cleared
on vcpu entry (along with the other kvm_check_request processing).

Then the first hunk becomes unnecessary.

Please do not mix host/guest patches.
