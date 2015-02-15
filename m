From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 15 Feb 2015 11:17:29 +0530
Message-ID: <54E032F1.5060503@linux.vnet.ibm.com>
References: <1423809941-11125-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150213153228.GA9535@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150213153228.GA9535@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/13/2015 09:02 PM, Oleg Nesterov wrote:
> On 02/13, Raghavendra K T wrote:
>>
>> @@ -164,7 +161,7 @@ static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>>   {
>>   	struct __raw_tickets tmp = READ_ONCE(lock->tickets);
>>
>> -	return tmp.tail != tmp.head;
>> +	return tmp.tail != (tmp.head & ~TICKET_SLOWPATH_FLAG);
>>   }
>
> Well, this can probably use __tickets_equal() too. But this is cosmetic.

That looks good. Added.

> It seems that arch_spin_is_contended() should be fixed with this change,
>
> 	(__ticket_t)(tmp.tail - tmp.head) > TICKET_LOCK_INC
>
> can be true because of TICKET_SLOWPATH_FLAG in .head, even if it is actually
> unlocked.


Done.
Hmm! it was because I was still under impression that slowpath bit is
in tail. You are right, situation could lead to positive max and may
report false contention.

And the "(__ticket_t)" typecast looks unnecessary, it only adds more
> confusuin, but this is cosmetic too.
>

Done.

>> @@ -772,7 +773,8 @@ __visible void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
>>   	 * check again make sure it didn't become free while
>>   	 * we weren't looking.
>>   	 */
>> -	if (ACCESS_ONCE(lock->tickets.head) == want) {
>> +	head = READ_ONCE(lock->tickets.head);
>> +	if (__tickets_equal(head, want)) {
>>   		add_stats(TAKEN_SLOW_PICKUP, 1);
>>   		goto out;
>
> This is off-topic, but with or without this change perhaps it makes sense
> to add smp_mb__after_atomic(). It is nop on x86, just to make this code
> more understandable for those (for me ;) who can never remember even the
> x86 rules.
>

Hope you meant it for add_stat. yes  smp_mb__after_atomic() would be
harmless barrier() in x86. Did not add this V5 as yoiu though  but this
made me look at slowpath_enter code and added an explicit barrier() 
there :).
