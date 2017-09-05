From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Tue, 5 Sep 2017 10:10:37 -0400
Message-ID: <c62a47cd-c46d-bfbf-77f2-ec27c86c0f7c__8628.1870528639$1504620703$gmane$org@redhat.com>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170905132444.7163-4-jgross@suse.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/05/2017 09:24 AM, Juergen Gross wrote:
> There are cases where a guest tries to switch spinlocks to bare metal
> behavior (e.g. by setting "xen_nopvspin" boot parameter). Today this
> has the downside of falling back to unfair test and set scheme for
> qspinlocks due to virt_spin_lock() detecting the virtualized
> environment.
>
> Make virt_spin_lock() a paravirt operation in order to enable users
> to select an explicit behavior like bare metal.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt.h       |  5 ++++
>  arch/x86/include/asm/paravirt_types.h |  1 +
>  arch/x86/include/asm/qspinlock.h      | 48 ++++++++++++++++++++++++-----------
>  arch/x86/kernel/paravirt-spinlocks.c  | 14 ++++++++++
>  arch/x86/kernel/smpboot.c             |  2 ++
>  5 files changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index c25dd22f7c70..d9e954fb37df 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -725,6 +725,11 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
>  	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
>  }
>  
> +static __always_inline bool pv_virt_spin_lock(struct qspinlock *lock)
> +{
> +	return PVOP_CALLEE1(bool, pv_lock_ops.virt_spin_lock, lock);
> +}
> +
>  #endif /* SMP && PARAVIRT_SPINLOCKS */
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 19efefc0e27e..928f5e7953a7 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -319,6 +319,7 @@ struct pv_lock_ops {
>  	void (*kick)(int cpu);
>  
>  	struct paravirt_callee_save vcpu_is_preempted;
> +	struct paravirt_callee_save virt_spin_lock;
>  } __no_randomize_layout;
>  
>  /* This contains all the paravirt structures: we get a convenient
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 48a706f641f2..fbd98896385c 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -17,6 +17,25 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
>  	smp_store_release((u8 *)lock, 0);
>  }
>  
> +static inline bool native_virt_spin_lock(struct qspinlock *lock)
> +{
> +	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return false;
> +
> +	/*
> +	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
> +	 * back to a Test-and-Set spinlock, because fair locks have
> +	 * horrible lock 'holder' preemption issues.
> +	 */
> +
> +	do {
> +		while (atomic_read(&lock->val) != 0)
> +			cpu_relax();
> +	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __pv_init_lock_hash(void);
> @@ -38,33 +57,32 @@ static inline bool vcpu_is_preempted(long cpu)
>  {
>  	return pv_vcpu_is_preempted(cpu);
>  }
> +
> +void native_pv_lock_init(void) __init;
>  #else
>  static inline void queued_spin_unlock(struct qspinlock *lock)
>  {
>  	native_queued_spin_unlock(lock);
>  }
> +
> +static inline void native_pv_lock_init(void)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_PARAVIRT
>  #define virt_spin_lock virt_spin_lock
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>  static inline bool virt_spin_lock(struct qspinlock *lock)
>  {
> -	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
> -		return false;

Have you consider just add one more jump label here to skip
virt_spin_lock when KVM or Xen want to do so?

> -
> -	/*
> -	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
> -	 * back to a Test-and-Set spinlock, because fair locks have
> -	 * horrible lock 'holder' preemption issues.
> -	 */
> -
> -	do {
> -		while (atomic_read(&lock->val) != 0)
> -			cpu_relax();
> -	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
> -
> -	return true;
> +	return pv_virt_spin_lock(lock);
> +}
> +#else
> +static inline bool virt_spin_lock(struct qspinlock *lock)
> +{
> +	return native_virt_spin_lock(lock);
>  }
> +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
>  #endif /* CONFIG_PARAVIRT */
>  
>  #include <asm-generic/qspinlock.h>
> diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
> index 26e4bd92f309..1be187ef8a38 100644
> --- a/arch/x86/kernel/paravirt-spinlocks.c
> +++ b/arch/x86/kernel/paravirt-spinlocks.c
> @@ -20,6 +20,12 @@ bool pv_is_native_spin_unlock(void)
>  		__raw_callee_save___native_queued_spin_unlock;
>  }
>  
> +__visible bool __native_virt_spin_lock(struct qspinlock *lock)
> +{
> +	return native_virt_spin_lock(lock);
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(__native_virt_spin_lock);

I have some concern about the overhead of register saving/restoring have
on spin lock performance in case the kernel is under a non-KVM/Xen
hypervisor.

Cheers,
Longman
