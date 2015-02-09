From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Mon, 09 Feb 2015 15:04:22 +0530
Message-ID: <54D87F1E.9060307__49692.1508842663$1423474969$gmane$org@linux.vnet.ibm.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54D7D19B.1000103@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, oleg@redhat.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/09/2015 02:44 AM, Jeremy Fitzhardinge wrote:
> On 02/06/2015 06:49 AM, Raghavendra K T wrote:
[...]
>
>> Linus suggested that we should not do any writes to lock after unlock(),
>> and we can move slowpath clearing to fastpath lock.
>
> Yep, that seems like a sound approach.

Current approach seem to be working now. (though we could not avoid read).
Related question: Do you think we could avoid SLOWPATH_FLAG itself by
checking head and tail difference. or is it costly because it may
result in unnecessary unlock_kicks?

>> However it brings additional case to be handled, viz., slowpath still
>> could be set when somebody does arch_trylock. Handle that too by ignoring
>> slowpath flag during lock availability check.
>>
>> Reported-by: Sasha Levin <sasha.levin@oracle.com>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/x86/include/asm/spinlock.h | 70 ++++++++++++++++++++---------------------
>>   1 file changed, 34 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
>> index 625660f..0829f86 100644
>> --- a/arch/x86/include/asm/spinlock.h
>> +++ b/arch/x86/include/asm/spinlock.h
>> @@ -49,6 +49,23 @@ static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
>>   	set_bit(0, (volatile unsigned long *)&lock->tickets.tail);
>>   }
>>
>> +static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock)
>> +{
>> +	arch_spinlock_t old, new;
>> +	__ticket_t diff;
>> +
>> +	old.tickets = READ_ONCE(lock->tickets);
>
> Couldn't the caller pass in the lock state that it read rather than
> re-reading it?
>

Yes we could. do you mean we could pass additional read value apart from 
lock, (because lock will be anyway needed for cmpxchg).

>>
>> +static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock)
>> +{
>> +}
>> +
>>   #endif /* CONFIG_PARAVIRT_SPINLOCKS */
>>
>>   static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>> @@ -84,7 +105,7 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>>   	register struct __raw_tickets inc = { .tail = TICKET_LOCK_INC };
>>
>>   	inc = xadd(&lock->tickets, inc);
>> -	if (likely(inc.head == inc.tail))
>> +	if (likely(inc.head == (inc.tail & ~TICKET_SLOWPATH_FLAG)))
>

good point, we can get rid of this as well.

> The intent of this conditional was to be the quickest possible path when
> taking a fastpath lock, with the code below being used for all slowpath
> locks (free or taken). So I don't think masking out SLOWPATH_FLAG is
> necessary here.
>
>>   		goto out;
>>
>>   	inc.tail &= ~TICKET_SLOWPATH_FLAG;
>> @@ -98,7 +119,10 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>>   		} while (--count);
>>   		__ticket_lock_spinning(lock, inc.tail);
>>   	}
>> -out:	barrier();	/* make sure nothing creeps before the lock is taken */
>> +out:
>> +	__ticket_check_and_clear_slowpath(lock);
>> +
>> +	barrier();	/* make sure nothing creeps before the lock is taken */
>
> Which means that if "goto out" path is only ever used for fastpath
> locks, you can limit calling __ticket_check_and_clear_slowpath() to the
> slowpath case.
>

Yes, I ll move that call up.

>>   }
>>
>>   static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
>> @@ -115,47 +139,21 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
>>   	return cmpxchg(&lock->head_tail, old.head_tail, new.head_tail) == old.head_tail;
>>   }
>>
>> -static inline void __ticket_unlock_slowpath(arch_spinlock_t *lock,
>> -					    arch_spinlock_t old)
>> -{
>> -	arch_spinlock_t new;
>> -
>> -	BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
>> -
>> -	/* Perform the unlock on the "before" copy */
>> -	old.tickets.head += TICKET_LOCK_INC;
>
> NB (see below)

Thanks for pointing, this solved the hang issue. I
missed this exact addition.

>
>> -
>> -	/* Clear the slowpath flag */
>> -	new.head_tail = old.head_tail & ~(TICKET_SLOWPATH_FLAG << TICKET_SHIFT);
>> -
>> -	/*
>> -	 * If the lock is uncontended, clear the flag - use cmpxchg in
>> -	 * case it changes behind our back though.
>> -	 */
>> -	if (new.tickets.head != new.tickets.tail ||
>> -	    cmpxchg(&lock->head_tail, old.head_tail,
>> -					new.head_tail) != old.head_tail) {
>> -		/*
>> -		 * Lock still has someone queued for it, so wake up an
>> -		 * appropriate waiter.
>> -		 */
>> -		__ticket_unlock_kick(lock, old.tickets.head);
>> -	}
>> -}
>> -
>>   static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>>   {
>>   	if (TICKET_SLOWPATH_FLAG &&
>> -	    static_key_false(&paravirt_ticketlocks_enabled)) {
>> -		arch_spinlock_t prev;
>> +		static_key_false(&paravirt_ticketlocks_enabled)) {
>> +		__ticket_t prev_head;
>>
>> -		prev = *lock;
>> +		prev_head = lock->tickets.head;
>>   		add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>>
>>   		/* add_smp() is a full mb() */
>>
>> -		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
>> -			__ticket_unlock_slowpath(lock, prev);
>> +		if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG)) {
>
> So we're OK with still having a ("speculative"?) read-after-unlock here?
> I guess the only way to avoid it is to make the add_smp an xadd, but
> that's pretty expensive even compared to a locked add (at least last
> time I checked, which was at least a couple of microarchitectures ago).
> An unlocked add followed by lfence should also do the trick, but that
> was also much worse in practice.

So we have 3 choices,
1. xadd
2. continue with current approach.
3. a read before unlock and also after that.

>
>> +			BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
>> +			__ticket_unlock_kick(lock, prev_head);
>
> Should be "prev_head + TICKET_LOCK_INC" to match the previous code,
> otherwise it won't find the CPU waiting for the new head.

Yes it is :)
