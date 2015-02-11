From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Wed, 11 Feb 2015 18:38:38 +0100
Message-ID: <20150211173838.GB28689@redhat.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
	<20150210132634.GA30380@redhat.com>
	<54DB384A.2050305@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54DB384A.2050305@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <ak@linux.intel.com>, xen-devel@lists.xenproject.org, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew
List-Id: virtualization@lists.linuxfoundation.org

On 02/11, Raghavendra K T wrote:
>
> On 02/10/2015 06:56 PM, Oleg Nesterov wrote:
>
>> In this case __ticket_check_and_clear_slowpath() really needs to cmpxchg
>> the whole .head_tail. Plus obviously more boring changes. This needs a
>> separate patch even _if_ this can work.
>
> Correct, but apart from this, before doing xadd in unlock,
> we would have to make sure lsb bit is cleared so that we can live with 1
> bit overflow to tail which is unused. now either or both of head,tail
> lsb bit may be set after unlock.

Sorry, can't understand... could you spell?

If TICKET_SLOWPATH_FLAG lives in .head arch_spin_unlock() could simply do

	head = xadd(&lock->tickets.head, TICKET_LOCK_INC);

	if (head & TICKET_SLOWPATH_FLAG)
		__ticket_unlock_kick(head);

so it can't overflow to .tail?

But probably I missed your concern.



And we we do this, probably it makes sense to add something like

	bool tickets_equal(__ticket_t one, __ticket_t two)
	{
		return (one ^ two) & ~TICKET_SLOWPATH_FLAG;
	}

and change kvm_lock_spinning() to use tickets_equal(tickets.head, want), plus
it can have more users in asm/spinlock.h.

Oleg.
