From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [RFC] Implement Batched (group) ticket lock
Date: Fri, 30 May 2014 14:23:05 +0530
Message-ID: <538846F1.3030303@linux.vnet.ibm.com>
References: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<5387B87E.2010609@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5387B87E.2010609@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, gleb@redhat.com, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, oleg@redhat.com, davej@redhat.com, tglx@linutronix.de, fernando_b1@lab.ntt.co.jp, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/30/2014 04:15 AM, Waiman Long wrote:
> On 05/28/2014 08:16 AM, Raghavendra K T wrote:
>> - we need an intelligent way to nullify the effect of batching for
>> baremetal
>>   (because extra cmpxchg is not required).
>
> To do this, you will need to have 2 slightly different algorithms
> depending on the paravirt_ticketlocks_enabled jump label.

Thanks for the hint Waiman.

[...]
>> +spin:
>> +    for (;;) {
>> +        inc.head = ACCESS_ONCE(lock->tickets.head);
>> +        if (!(inc.head&  TICKET_LOCK_HEAD_INC)) {
>> +            new.head = inc.head | TICKET_LOCK_HEAD_INC;
>> +            if (cmpxchg(&lock->tickets.head, inc.head, new.head)
>> +                    == inc.head)
>> +                goto out;
>> +        }
>> +        cpu_relax();
>> +    }
>> +
>
> It had taken me some time to figure out the the LSB of inc.head is used
> as a bit lock for the contending tasks in the spin loop. I would suggest
> adding some comment here to make it easier to look at.

Agree. 'll add a comment.

[...]
>> +#define TICKET_BATCH    0x4 /* 4 waiters can contend simultaneously */
>> +#define TICKET_LOCK_BATCH_MASK
>> (~(TICKET_BATCH<<TICKET_LOCK_INC_SHIFT) + \
>> +                  TICKET_LOCK_TAIL_INC - 1)
>
> I don't think TAIL_INC has anything to do with setting the BATCH_MASK.
> It works here because TAIL_INC is 2. I think it is clearer to define it
> as either "(~(TICKET_BATCH<<TICKET_LOCK_INC_SHIFT) + 1)" or
> (~((TICKET_BATCH<<TICKET_LOCK_INC_SHIFT) - 1)).

You are right.
Thanks for pointing out. Your expression is simple and clearer. 'll use
one of them.
