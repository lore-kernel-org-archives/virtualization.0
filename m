From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 08/11] qspinlock: Revert to test-and-set on hypervisors
Date: Mon, 16 Jun 2014 17:57:14 -0400
Message-ID: <539F683A.2070103__2029.01241505078$1402955856$gmane$org@hp.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.940699466@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140615130153.940699466@chello.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/15/2014 08:47 AM, Peter Zijlstra wrote:
> When we detect a hypervisor (!paravirt, see later patches), revert to
> a simple test-and-set lock to avoid the horrors of queue preemption.
>
> Signed-off-by: Peter Zijlstra<peterz@infradead.org>
> ---
>   arch/x86/include/asm/qspinlock.h |   14 ++++++++++++++
>   include/asm-generic/qspinlock.h  |    7 +++++++
>   kernel/locking/qspinlock.c       |    3 +++
>   3 files changed, 24 insertions(+)
>
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -1,6 +1,7 @@
>   #ifndef _ASM_X86_QSPINLOCK_H
>   #define _ASM_X86_QSPINLOCK_H
>
> +#include<asm/cpufeature.h>
>   #include<asm-generic/qspinlock_types.h>
>
>   #if !defined(CONFIG_X86_OOSTORE)&&  !defined(CONFIG_X86_PPRO_FENCE)
> @@ -20,6 +21,19 @@ static inline void queue_spin_unlock(str
>
>   #endif /* !CONFIG_X86_OOSTORE&&  !CONFIG_X86_PPRO_FENCE */
>
> +#define virt_queue_spin_lock virt_queue_spin_lock
> +
> +static inline bool virt_queue_spin_lock(struct qspinlock *lock)
> +{
> +	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return false;
> +
> +	while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0)
> +		cpu_relax();
> +
> +	return true;
> +}
> +
>   #include<asm-generic/qspinlock.h>
>
>   #endif /* _ASM_X86_QSPINLOCK_H */
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -98,6 +98,13 @@ static __always_inline void queue_spin_u
>   }
>   #endif
>
> +#ifndef virt_queue_spin_lock
> +static __always_inline bool virt_queue_spin_lock(struct qspinlock *lock)
> +{
> +	return false;
> +}
> +#endif
> +
>   /*
>    * Initializier
>    */
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -247,6 +247,9 @@ void queue_spin_lock_slowpath(struct qsp
>
>   	BUILD_BUG_ON(CONFIG_NR_CPUS>= (1U<<  _Q_TAIL_CPU_BITS));
>
> +	if (virt_queue_spin_lock(lock))
> +		return;
> +
>   	/*
>   	 * wait for in-progress pending->locked hand-overs
>   	 *

I just wonder if it is better to allow the kernel distributors to decide 
if unfair lock should be the default for virtual guest. Anyway, I have 
no objection to that myself.

-Longman
