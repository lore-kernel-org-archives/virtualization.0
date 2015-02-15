From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V5] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 15 Feb 2015 23:04:01 +0530
Message-ID: <54E0D889.8030206__28080.2257628695$1424022165$gmane$org@linux.vnet.ibm.com>
References: <1423979744-18320-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150215161733.GB27608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150215161733.GB27608@redhat.com>
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

On 02/15/2015 09:47 PM, Oleg Nesterov wrote:
> Well, I regret I mentioned the lack of barrier after enter_slowpath ;)
>
> On 02/15, Raghavendra K T wrote:
>>
>> @@ -46,7 +46,8 @@ static __always_inline bool static_key_false(struct static_key *key);
>>
>>   static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
>>   {
>> -	set_bit(0, (volatile unsigned long *)&lock->tickets.tail);
>> +	set_bit(0, (volatile unsigned long *)&lock->tickets.head);
>> +	barrier();
>>   }
>
> Because this barrier() looks really confusing.
>
> Firsty, it is equally unneeded on x86. At the same time, it can not help.
> We need a memory barrier() between set_bit(SLOWPATH) and READ_ONCE(head)
> to avoid the race with spin_unlock().
>
> So I think you should replace it with smp_mb__after_atomic() or remove it.
>

I resent the patch the above change.

>
> Other than that I believe this version is correct. So I won't insist, this
> is cosmetic after all.

Thanks Oleg.
