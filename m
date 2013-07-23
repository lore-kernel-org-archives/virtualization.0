From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Tue, 23 Jul 2013 18:07:48 +0300
Message-ID: <20130723150748.GC6029@redhat.com>
References: <20130722061631.24737.75508.sendpatchset@codeblue>
	<20130722062016.24737.54554.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130722062016.24737.54554.sendpatchset@codeblue>
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
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 22, 2013 at 11:50:16AM +0530, Raghavendra K T wrote:
> +static void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
> +{
> +	struct kvm_lock_waiting *w;
> +	int cpu;
> +	u64 start;
> +	unsigned long flags;
> +
Why don't you bailout if in nmi here like we discussed?

> +	w = &__get_cpu_var(lock_waiting);
> +	cpu = smp_processor_id();
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
> +	/*
> +	 * halt until it's our turn and kicked. Note that we do safe halt
> +	 * for irq enabled case to avoid hang when lock info is overwritten
> +	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
> +	 */
> +	if (arch_irqs_disabled_flags(flags))
> +		halt();
> +	else
> +		safe_halt();
> +
> +out:
So here now interrupts can be either disabled or enabled. Previous
version disabled interrupts here, so are we sure it is safe to have them
enabled at this point? I do not see any problem yet, will keep thinking.

> +	cpumask_clear_cpu(cpu, &waiting_cpus);
> +	w->lock = NULL;
> +	local_irq_restore(flags);
> +	spin_time_accum_blocked(start);
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(kvm_lock_spinning);
> +
> +/* Kick vcpu waiting on @lock->head to reach value @ticket */
> +static void kvm_unlock_kick(struct arch_spinlock *lock, __ticket_t ticket)
> +{
> +	int cpu;
> +
> +	add_stats(RELEASED_SLOW, 1);
> +	for_each_cpu(cpu, &waiting_cpus) {
> +		const struct kvm_lock_waiting *w = &per_cpu(lock_waiting, cpu);
> +		if (ACCESS_ONCE(w->lock) == lock &&
> +		    ACCESS_ONCE(w->want) == ticket) {
> +			add_stats(RELEASED_SLOW_KICKED, 1);
> +			kvm_kick_cpu(cpu);
What about using NMI to wake sleepers? I think it was discussed, but
forgot why it was dismissed.

> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
> + */
> +void __init kvm_spinlock_init(void)
> +{
> +	if (!kvm_para_available())
> +		return;
> +	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
> +	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
> +		return;
> +
> +	printk(KERN_INFO "KVM setup paravirtual spinlock\n");
> +
> +	static_key_slow_inc(&paravirt_ticketlocks_enabled);
> +
> +	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
> +	pv_lock_ops.unlock_kick = kvm_unlock_kick;
> +}
> +#endif	/* CONFIG_PARAVIRT_SPINLOCKS */

--
			Gleb.
