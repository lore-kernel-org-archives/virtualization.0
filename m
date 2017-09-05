From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Tue, 5 Sep 2017 16:42:23 +0200
Message-ID: <eedcab30-b392-74db-3dc3-1de5769ebecc__49896.8720240102$1504622602$gmane$org@suse.com>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
	<c62a47cd-c46d-bfbf-77f2-ec27c86c0f7c@redhat.com>
	<42918500-4487-f0d8-e6fd-99e4d0d7f1bf@suse.com>
	<3a2eefe7-5c0b-9768-2bb8-03c947133b06@redhat.com>
	<a921465a-3c4f-9223-b4af-cd250df62f90@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a921465a-3c4f-9223-b4af-cd250df62f90@redhat.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 05/09/17 16:31, Waiman Long wrote:
> On 09/05/2017 10:24 AM, Waiman Long wrote:
>> On 09/05/2017 10:18 AM, Juergen Gross wrote:
>>> On 05/09/17 16:10, Waiman Long wrote:
>>>> On 09/05/2017 09:24 AM, Juergen Gross wrote:
>>>>> There are cases where a guest tries to switch spinlocks to bare metal
>>>>> behavior (e.g. by setting "xen_nopvspin" boot parameter). Today this
>>>>> has the downside of falling back to unfair test and set scheme for
>>>>> qspinlocks due to virt_spin_lock() detecting the virtualized
>>>>> environment.
>>>>>
>>>>> Make virt_spin_lock() a paravirt operation in order to enable users
>>>>> to select an explicit behavior like bare metal.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>>  arch/x86/include/asm/paravirt.h       |  5 ++++
>>>>>  arch/x86/include/asm/paravirt_types.h |  1 +
>>>>>  arch/x86/include/asm/qspinlock.h      | 48 ++++++++++++++++++++++++-----------
>>>>>  arch/x86/kernel/paravirt-spinlocks.c  | 14 ++++++++++
>>>>>  arch/x86/kernel/smpboot.c             |  2 ++
>>>>>  5 files changed, 55 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
>>>>> index c25dd22f7c70..d9e954fb37df 100644
>>>>> --- a/arch/x86/include/asm/paravirt.h
>>>>> +++ b/arch/x86/include/asm/paravirt.h
>>>>> @@ -725,6 +725,11 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
>>>>>  	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
>>>>>  }
>>>>>  
>>>>> +static __always_inline bool pv_virt_spin_lock(struct qspinlock *lock)
>>>>> +{
>>>>> +	return PVOP_CALLEE1(bool, pv_lock_ops.virt_spin_lock, lock);
>>>>> +}
>>>>> +
>>>>>  #endif /* SMP && PARAVIRT_SPINLOCKS */
>>>>>  
>>>>>  #ifdef CONFIG_X86_32
>>>>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
>>>>> index 19efefc0e27e..928f5e7953a7 100644
>>>>> --- a/arch/x86/include/asm/paravirt_types.h
>>>>> +++ b/arch/x86/include/asm/paravirt_types.h
>>>>> @@ -319,6 +319,7 @@ struct pv_lock_ops {
>>>>>  	void (*kick)(int cpu);
>>>>>  
>>>>>  	struct paravirt_callee_save vcpu_is_preempted;
>>>>> +	struct paravirt_callee_save virt_spin_lock;
>>>>>  } __no_randomize_layout;
>>>>>  
>>>>>  /* This contains all the paravirt structures: we get a convenient
>>>>> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
>>>>> index 48a706f641f2..fbd98896385c 100644
>>>>> --- a/arch/x86/include/asm/qspinlock.h
>>>>> +++ b/arch/x86/include/asm/qspinlock.h
>>>>> @@ -17,6 +17,25 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
>>>>>  	smp_store_release((u8 *)lock, 0);
>>>>>  }
>>>>>  
>>>>> +static inline bool native_virt_spin_lock(struct qspinlock *lock)
>>>>> +{
>>>>> +	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> +		return false;
>>>>> +
>>>>> +	/*
>>>>> +	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
>>>>> +	 * back to a Test-and-Set spinlock, because fair locks have
>>>>> +	 * horrible lock 'holder' preemption issues.
>>>>> +	 */
>>>>> +
>>>>> +	do {
>>>>> +		while (atomic_read(&lock->val) != 0)
>>>>> +			cpu_relax();
>>>>> +	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
>>>>> +
>>>>> +	return true;
>>>>> +}
>>>>> +
>>>>>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>>>>>  extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>>>>>  extern void __pv_init_lock_hash(void);
>>>>> @@ -38,33 +57,32 @@ static inline bool vcpu_is_preempted(long cpu)
>>>>>  {
>>>>>  	return pv_vcpu_is_preempted(cpu);
>>>>>  }
>>>>> +
>>>>> +void native_pv_lock_init(void) __init;
>>>>>  #else
>>>>>  static inline void queued_spin_unlock(struct qspinlock *lock)
>>>>>  {
>>>>>  	native_queued_spin_unlock(lock);
>>>>>  }
>>>>> +
>>>>> +static inline void native_pv_lock_init(void)
>>>>> +{
>>>>> +}
>>>>>  #endif
>>>>>  
>>>>>  #ifdef CONFIG_PARAVIRT
>>>>>  #define virt_spin_lock virt_spin_lock
>>>>> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>>>>>  static inline bool virt_spin_lock(struct qspinlock *lock)
>>>>>  {
>>>>> -	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> -		return false;
>>>> Have you consider just add one more jump label here to skip
>>>> virt_spin_lock when KVM or Xen want to do so?
>>> Why? Did you look at patch 4? This is the way to do it...
>> I asked this because of my performance concern as stated later in the email.
> 
> For clarification, I was actually asking if you consider just adding one
> more jump label to skip it for Xen/KVM instead of making
> virt_spin_lock() a pv-op.

Aah, okay.

Bare metal could make use of this jump label, too.

I'll have a try how it looks like.


Juergen
