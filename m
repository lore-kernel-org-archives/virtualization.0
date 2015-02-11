From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Tue, 10 Feb 2015 17:18:38 -0800
Message-ID: <54DAADEE.6070506@goop.org>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
	<20150210132634.GA30380@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150210132634.GA30380@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <ak@linux.intel.com>, xen-devel@lists.xenproject.org, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>Lin
List-Id: virtualization@lists.linuxfoundation.org


On 02/10/2015 05:26 AM, Oleg Nesterov wrote:
> On 02/10, Raghavendra K T wrote:
>> On 02/10/2015 06:23 AM, Linus Torvalds wrote:
>>
>>>          add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>>>          if (READ_ONCE(lock->tickets.tail) & TICKET_SLOWPATH_FLAG) ..
>>>
>>> into something like
>>>
>>>          val = xadd((&lock->ticket.head_tail, TICKET_LOCK_INC << TICKET_SHIFT);
>>>          if (unlikely(val & TICKET_SLOWPATH_FLAG)) ...
>>>
>>> would be the right thing to do. Somebody should just check that I got
>>> that shift right, and that the tail is in the high bytes (head really
>>> needs to be high to work, if it's in the low byte(s) the xadd would
>>> overflow from head into tail which would be wrong).
>> Unfortunately xadd could result in head overflow as tail is high.
>>
>> The other option was repeated cmpxchg which is bad I believe.
>> Any suggestions?
> Stupid question... what if we simply move SLOWPATH from .tail to .head?
> In this case arch_spin_unlock() could do xadd(tickets.head) and check
> the result

Well, right now, "tail" is manipulated by locked instructions by CPUs
who are contending for the ticketlock, but head can be manipulated
unlocked by the CPU which currently owns the ticketlock. If SLOWPATH
moved into head, then non-owner CPUs would be touching head, requiring
everyone to use locked instructions on it.

That's the theory, but I don't see much (any?) code which depends on that.

Ideally we could find a way so that pv ticketlocks could use a plain
unlocked add for the unlock like the non-pv case, but I just don't see a
way to do it.

> In this case __ticket_check_and_clear_slowpath() really needs to cmpxchg
> the whole .head_tail. Plus obviously more boring changes. This needs a
> separate patch even _if_ this can work.

Definitely.

> BTW. If we move "clear slowpath" into "lock" path, then probably trylock
> should be changed too? Something like below, we just need to clear SLOWPATH
> before cmpxchg.

How important / widely used is trylock these days?

    J

>
> Oleg.
>
> --- x/arch/x86/include/asm/spinlock.h
> +++ x/arch/x86/include/asm/spinlock.h
> @@ -109,7 +109,8 @@ static __always_inline int arch_spin_try
>  	if (old.tickets.head != (old.tickets.tail & ~TICKET_SLOWPATH_FLAG))
>  		return 0;
>  
> -	new.head_tail = old.head_tail + (TICKET_LOCK_INC << TICKET_SHIFT);
> +	new.tickets.head = old.tickets.head;
> +	new.tickets.tail = (old.tickets.tail & ~TICKET_SLOWPATH_FLAG) + TICKET_LOCK_INC;
>  
>  	/* cmpxchg is a full barrier, so nothing can move before it */
>  	return cmpxchg(&lock->head_tail, old.head_tail, new.head_tail) == old.head_tail;
>
