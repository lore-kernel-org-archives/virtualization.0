From: Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC] Implement Batched (group) ticket lock
Date: Thu, 29 May 2014 18:45:18 -0400
Message-ID: <5387B87E.2010609@hp.com>
References: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, gleb@redhat.com, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, oleg@redhat.com, davej@redhat.com, tglx@linutronix.de, fernando_b1@lab.ntt.co.jp, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/28/2014 08:16 AM, Raghavendra K T wrote:
>
> TODO:
> - we need an intelligent way to nullify the effect of batching for baremetal
>   (because extra cmpxchg is not required).

To do this, you will need to have 2 slightly different algorithms 
depending on the paravirt_ticketlocks_enabled jump label.

>
> - My kernbench/ebizzy test on baremetal (32 cpu +ht sandybridge) did not seem to
>    show the impact of extra cmpxchg. but there should be effect of extra cmpxchg.

It will depend on the micro-benchmark and the test system used. I had 
seen the a test case that extra cmpxchg did not really impact 
performance on a Westmere system but had noticeable adverse impact on an 
IvyBridge system with the same micro-benchmark.

>   Please provide your suggestion and comments.
>
> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
> index 0f62f54..87685f1 100644
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -81,23 +81,36 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>    */
>   static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>   {
> -	register struct __raw_tickets inc = { .tail = TICKET_LOCK_INC };
> +	register struct __raw_tickets inc = { .tail = TICKET_LOCK_TAIL_INC };
> +	struct __raw_tickets new;
>
>   	inc = xadd(&lock->tickets, inc);
> -	if (likely(inc.head == inc.tail))
> -		goto out;
>
>   	inc.tail&= ~TICKET_SLOWPATH_FLAG;
>   	for (;;) {
>   		unsigned count = SPIN_THRESHOLD;
>
>   		do {
> -			if (ACCESS_ONCE(lock->tickets.head) == inc.tail)
> -				goto out;
> +			if ((inc.head&  TICKET_LOCK_BATCH_MASK) == (inc.tail&
> +							TICKET_LOCK_BATCH_MASK))
> +				goto spin;
>   			cpu_relax();
> +			inc.head = ACCESS_ONCE(lock->tickets.head);
>   		} while (--count);
>   		__ticket_lock_spinning(lock, inc.tail);
>   	}
> +spin:
> +	for (;;) {
> +		inc.head = ACCESS_ONCE(lock->tickets.head);
> +		if (!(inc.head&  TICKET_LOCK_HEAD_INC)) {
> +			new.head = inc.head | TICKET_LOCK_HEAD_INC;
> +			if (cmpxchg(&lock->tickets.head, inc.head, new.head)
> +					== inc.head)
> +				goto out;
> +		}
> +		cpu_relax();
> +	}
> +

It had taken me some time to figure out the the LSB of inc.head is used 
as a bit lock for the contending tasks in the spin loop. I would suggest 
adding some comment here to make it easier to look at.

> diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
> index 4f1bea1..b04c03d 100644
> --- a/arch/x86/include/asm/spinlock_types.h
> +++ b/arch/x86/include/asm/spinlock_types.h
> @@ -3,15 +3,16 @@
>
>   #include<linux/types.h>
>
> +#define TICKET_LOCK_INC_SHIFT 1
> +#define __TICKET_LOCK_TAIL_INC (1<<TICKET_LOCK_INC_SHIFT)
> +
>   #ifdef CONFIG_PARAVIRT_SPINLOCKS
> -#define __TICKET_LOCK_INC	2
>   #define TICKET_SLOWPATH_FLAG	((__ticket_t)1)
>   #else
> -#define __TICKET_LOCK_INC	1
>   #define TICKET_SLOWPATH_FLAG	((__ticket_t)0)
>   #endif
>
> -#if (CONFIG_NR_CPUS<  (256 / __TICKET_LOCK_INC))
> +#if (CONFIG_NR_CPUS<  (256 / __TICKET_LOCK_TAIL_INC))
>   typedef u8  __ticket_t;
>   typedef u16 __ticketpair_t;
>   #else
> @@ -19,7 +20,12 @@ typedef u16 __ticket_t;
>   typedef u32 __ticketpair_t;
>   #endif
>
> -#define TICKET_LOCK_INC	((__ticket_t)__TICKET_LOCK_INC)
> +#define TICKET_LOCK_TAIL_INC ((__ticket_t)__TICKET_LOCK_TAIL_INC)
> +
> +#define TICKET_LOCK_HEAD_INC ((__ticket_t)1)
> +#define TICKET_BATCH    0x4 /* 4 waiters can contend simultaneously */
> +#define TICKET_LOCK_BATCH_MASK (~(TICKET_BATCH<<TICKET_LOCK_INC_SHIFT) + \
> +				  TICKET_LOCK_TAIL_INC - 1)

I don't think TAIL_INC has anything to do with setting the BATCH_MASK. 
It works here because TAIL_INC is 2. I think it is clearer to define it 
as either "(~(TICKET_BATCH<<TICKET_LOCK_INC_SHIFT) + 1)" or 
(~((TICKET_BATCH<<TICKET_LOCK_INC_SHIFT) - 1)).

-Longman
