From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Thu, 12 Feb 2015 15:18:19 +0100
Message-ID: <20150212141819.GA11633@redhat.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
	<20150210132634.GA30380@redhat.com> <54DAADEE.6070506@goop.org>
	<20150211172434.GA28689@redhat.com> <54DBE27C.8050105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54DBE27C.8050105@goop.org>
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
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Ryabinin <a.ryabinin@samsung.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <ak@linux.intel.com>, xen-devel@lists.xenproject.org, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On 02/11, Jeremy Fitzhardinge wrote:
>
> On 02/11/2015 09:24 AM, Oleg Nesterov wrote:
> > I agree, and I have to admit I am not sure I fully understand why
> > unlock uses the locked add. Except we need a barrier to avoid the race
> > with the enter_slowpath() users, of course. Perhaps this is the only
> > reason?
>
> Right now it needs to be a locked operation to prevent read-reordering.
> x86 memory ordering rules state that all writes are seen in a globally
> consistent order, and are globally ordered wrt reads *on the same
> addresses*, but reads to different addresses can be reordered wrt to writes.
>
> So, if the unlocking add were not a locked operation:
>
>         __add(&lock->tickets.head, TICKET_LOCK_INC);		/* not locked */
>
>         if (unlikely(lock->tickets.tail & TICKET_SLOWPATH_FLAG))
>             __ticket_unlock_slowpath(lock, prev);
>
> Then the read of lock->tickets.tail can be reordered before the unlock,
> which introduces a race:

Yes, yes, thanks, but this is what I meant. We need a barrier. Even if
"Every store is a release" as Linus mentioned.

> This *might* be OK, but I think it's on dubious ground:
>
>         __add(&lock->tickets.head, TICKET_LOCK_INC);		/* not locked */
>
> 	/* read overlaps write, and so is ordered */
>         if (unlikely(lock->head_tail & (TICKET_SLOWPATH_FLAG << TICKET_SHIFT))
>             __ticket_unlock_slowpath(lock, prev);
>
> because I think Intel and AMD differed in interpretation about how
> overlapping but different-sized reads & writes are ordered (or it simply
> isn't architecturally defined).

can't comment, I simply so not know how the hardware works.

> If the slowpath flag is moved to head, then it would always have to be
> locked anyway, because it needs to be atomic against other CPU's RMW
> operations setting the flag.

Yes, this is true.

But again, if we want to avoid the read-after-unlock, we need to update
this lock and read SLOWPATH atomically, it seems that we can't avoid the
locked insn.

Oleg.
