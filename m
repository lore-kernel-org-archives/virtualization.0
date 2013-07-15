From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V10 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Mon, 15 Jul 2013 15:20:06 +0530
Message-ID: <51E3C5CE.7000009@linux.vnet.ibm.com>
References: <20130624124014.27508.8906.sendpatchset@codeblue.in.ibm.com>
	<20130624124342.27508.44656.sendpatchset@codeblue.in.ibm.com>
	<20130714131241.GA11772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130714131241.GA11772@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/14/2013 06:42 PM, Gleb Natapov wrote:
> On Mon, Jun 24, 2013 at 06:13:42PM +0530, Raghavendra K T wrote:
>> kvm : Paravirtual ticketlocks support for linux guests running on KVM hypervisor
>>
>> From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
>>
trimming
[...]
>> +
>> +static void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
>> +{
>> +	struct kvm_lock_waiting *w;
>> +	int cpu;
>> +	u64 start;
>> +	unsigned long flags;
>> +
>> +	w = &__get_cpu_var(lock_waiting);
>> +	cpu = smp_processor_id();
>> +	start = spin_time_start();
>> +
>> +	/*
>> +	 * Make sure an interrupt handler can't upset things in a
>> +	 * partially setup state.
>> +	 */
>> +	local_irq_save(flags);
>> +
>> +	/*
>> +	 * The ordering protocol on this is that the "lock" pointer
>> +	 * may only be set non-NULL if the "want" ticket is correct.
>> +	 * If we're updating "want", we must first clear "lock".
>> +	 */
>> +	w->lock = NULL;
>> +	smp_wmb();
>> +	w->want = want;
>> +	smp_wmb();
>> +	w->lock = lock;
>> +
>> +	add_stats(TAKEN_SLOW, 1);
>> +
>> +	/*
>> +	 * This uses set_bit, which is atomic but we should not rely on its
>> +	 * reordering gurantees. So barrier is needed after this call.
>> +	 */
>> +	cpumask_set_cpu(cpu, &waiting_cpus);
>> +
>> +	barrier();
>> +
>> +	/*
>> +	 * Mark entry to slowpath before doing the pickup test to make
>> +	 * sure we don't deadlock with an unlocker.
>> +	 */
>> +	__ticket_enter_slowpath(lock);
>> +
>> +	/*
>> +	 * check again make sure it didn't become free while
>> +	 * we weren't looking.
>> +	 */
>> +	if (ACCESS_ONCE(lock->tickets.head) == want) {
>> +		add_stats(TAKEN_SLOW_PICKUP, 1);
>> +		goto out;
>> +	}
>> +
>> +	/* Allow interrupts while blocked */
>> +	local_irq_restore(flags);
>> +
> So what happens if an interrupt comes here and an interrupt handler
> takes another spinlock that goes into the slow path? As far as I see
> lock_waiting will become overwritten and cpu will be cleared from
> waiting_cpus bitmap by nested kvm_lock_spinning(), so when halt is
> called here after returning from the interrupt handler nobody is going
> to wake this lock holder. Next random interrupt will "fix" it, but it
> may be several milliseconds away, or never. We should probably check
> if interrupt were enabled and call native_safe_halt() here.
>

Okay you mean something like below should be done.
if irq_enabled()
   native_safe_halt()
else
   halt()

It is been a complex stuff for analysis for me.

So in our discussion stack would looking like this.

spinlock()
   kvm_lock_spinning()
                   <------ interrupt here
           halt()


 From the halt if we trace

   halt()
     kvm_vcpu_block()
        kvm_arch_vcpu_runnable())
	 kvm_make_request(KVM_REQ_UNHALT)
		
This would drive us out of halt handler, and we are fine when it
happens since we would revisit kvm_lock_spinning.

But I see that

kvm_arch_vcpu_runnable() has this condition
  (kvm_arch_interrupt_allowed(vcpu) &&  kvm_cpu_has_interrupt(vcpu));

which means that if we going process the interrupt here we would set 
KVM_REQ_UNHALT. and we are fine.

But if we are in the situation kvm_arch_interrupt_allowed(vcpu) = true, 
but we already processed interrupt and kvm_cpu_has_interrupt(vcpu) is 
false, we have problem till next random interrupt.

The confusing part to me is the case kvm_cpu_has_interrupt(vcpu)=false 
and irq
already handled and overwritten the lock_waiting. can this
situation happen? or is it that we will process the interrupt only
after this point (kvm_vcpu_block). Because if that is the case we are
fine.

Please let me know.
