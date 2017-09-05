From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Tue, 5 Sep 2017 15:55:06 +0200
Message-ID: <20170905135506.55drjahteljbatak@hirez.programming.kicks-ass.net>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170905132444.7163-4-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, longman@redhat.com, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 05, 2017 at 03:24:43PM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 48a706f641f2..fbd98896385c 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -17,6 +17,25 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
>  	smp_store_release((u8 *)lock, 0);
>  }
>  


Should this not have:

#ifdef CONFIG_PARAVIRT

?

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

#endif

> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __pv_init_lock_hash(void);


>  #ifdef CONFIG_PARAVIRT
>  #define virt_spin_lock virt_spin_lock
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>  static inline bool virt_spin_lock(struct qspinlock *lock)
>  {
> +	return pv_virt_spin_lock(lock);
> +}
> +#else
> +static inline bool virt_spin_lock(struct qspinlock *lock)
> +{
> +	return native_virt_spin_lock(lock);
>  }
> +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
>  #endif /* CONFIG_PARAVIRT */

Because I think the above only ever uses native_virt_spin_lock() when
PARAVIRT.

> @@ -1381,6 +1382,7 @@ void __init native_smp_prepare_boot_cpu(void)
>  	/* already set me in cpu_online_mask in boot_cpu_init() */
>  	cpumask_set_cpu(me, cpu_callout_mask);
>  	cpu_set_state_online(me);
> +	native_pv_lock_init();
>  }

Aah, this is where that goes.. OK that works too.
