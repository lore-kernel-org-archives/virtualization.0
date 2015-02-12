From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] x86 spinlock: Fix memory corruption on completing
	completions
Date: Thu, 12 Feb 2015 19:55:42 +0530
Message-ID: <54DCB7E6.8040802__13372.100031893$1423751106$gmane$org@linux.vnet.ibm.com>
References: <1423741647-2156-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150212140248.GA11050@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150212140248.GA11050@redhat.com>
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

On 02/12/2015 07:32 PM, Oleg Nesterov wrote:
> Damn, sorry for noise, forgot to mention...
>
> On 02/12, Raghavendra K T wrote:
>>
>> +static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock,
>> +							__ticket_t head)
>> +{
>> +	if (head & TICKET_SLOWPATH_FLAG) {
>> +		arch_spinlock_t old, new;
>> +
>> +		old.tickets.head = head;
>> +		new.tickets.head = head & ~TICKET_SLOWPATH_FLAG;
>> +		old.tickets.tail = new.tickets.head + TICKET_LOCK_INC;
>> +		new.tickets.tail = old.tickets.tail;
>> +
>> +		/* try to clear slowpath flag when there are no contenders */
>> +		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
>> +	}
>> +}
>
> ...
>
>> +clear_slowpath:
>> +	if (TICKET_SLOWPATH_FLAG)
>> +		__ticket_check_and_clear_slowpath(lock, inc.head);
>
> I think you can remove this "if (TICKET_SLOWPATH_FLAG)" check. If it is
> defined as zero, gcc should optimize out the code under "if (head & 0)".
>

right, the above if ( ) is unnecesary, though we would have same code
at the end, getting rid of that makes code more clean.
