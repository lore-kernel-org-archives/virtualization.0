From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Wed, 11 Feb 2015 18:24:34 +0100
Message-ID: <20150211172434.GA28689@redhat.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
	<20150210132634.GA30380@redhat.com> <54DAADEE.6070506@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54DAADEE.6070506@goop.org>
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

On 02/10, Jeremy Fitzhardinge wrote:
>
> On 02/10/2015 05:26 AM, Oleg Nesterov wrote:
> > On 02/10, Raghavendra K T wrote:
> >> Unfortunately xadd could result in head overflow as tail is high.
> >>
> >> The other option was repeated cmpxchg which is bad I believe.
> >> Any suggestions?
> > Stupid question... what if we simply move SLOWPATH from .tail to .head?
> > In this case arch_spin_unlock() could do xadd(tickets.head) and check
> > the result
>
> Well, right now, "tail" is manipulated by locked instructions by CPUs
> who are contending for the ticketlock, but head can be manipulated
> unlocked by the CPU which currently owns the ticketlock. If SLOWPATH
> moved into head, then non-owner CPUs would be touching head, requiring
> everyone to use locked instructions on it.
>
> That's the theory, but I don't see much (any?) code which depends on that.
>
> Ideally we could find a way so that pv ticketlocks could use a plain
> unlocked add for the unlock like the non-pv case, but I just don't see a
> way to do it.

I agree, and I have to admit I am not sure I fully understand why unlock
uses the locked add. Except we need a barrier to avoid the race with the
enter_slowpath() users, of course. Perhaps this is the only reason?

Anyway, I suggested this to avoid the overflow if we use xadd(), and I
guess we need the locked insn anyway if we want to eliminate the unsafe
read-after-unlock...

> > BTW. If we move "clear slowpath" into "lock" path, then probably trylock
> > should be changed too? Something like below, we just need to clear SLOWPATH
> > before cmpxchg.
>
> How important / widely used is trylock these days?

I am not saying this is that important. Just this looks more consistent imo
and we can do this for free.

Oleg.
