From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V4] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 15 Feb 2015 17:07:00 +0100
Message-ID: <20150215160700.GA27608@redhat.com>
References: <1423809941-11125-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150213153228.GA9535@redhat.com>
	<54E032F1.5060503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54E032F1.5060503@linux.vnet.ibm.com>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/15, Raghavendra K T wrote:
>
> On 02/13/2015 09:02 PM, Oleg Nesterov wrote:
>
>>> @@ -772,7 +773,8 @@ __visible void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
>>>   	 * check again make sure it didn't become free while
>>>   	 * we weren't looking.
>>>   	 */
>>> -	if (ACCESS_ONCE(lock->tickets.head) == want) {
>>> +	head = READ_ONCE(lock->tickets.head);
>>> +	if (__tickets_equal(head, want)) {
>>>   		add_stats(TAKEN_SLOW_PICKUP, 1);
>>>   		goto out;
>>
>> This is off-topic, but with or without this change perhaps it makes sense
>> to add smp_mb__after_atomic(). It is nop on x86, just to make this code
>> more understandable for those (for me ;) who can never remember even the
>> x86 rules.
>
> Hope you meant it for add_stat.

No, no. We need a barrier between set_bit(SLOWPATH) and tickets_equal().

Yes, on x86 set_bit() can't be reordered so smp_mb_*_atomic() is nop, but
it can make the code more understandable.

> yes  smp_mb__after_atomic() would be
> harmless barrier() in x86. Did not add this V5 as yoiu though  but this
> made me look at slowpath_enter code and added an explicit barrier()
> there :).

Well. it looks even more confusing than a lack of barrier ;)

Oleg.
