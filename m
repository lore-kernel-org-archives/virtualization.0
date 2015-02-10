From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Mon, 9 Feb 2015 16:53:51 -0800
Message-ID: <CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150209120227.GT21418@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 9, 2015 at 4:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 09, 2015 at 03:04:22PM +0530, Raghavendra K T wrote:
>> So we have 3 choices,
>> 1. xadd
>> 2. continue with current approach.
>> 3. a read before unlock and also after that.
>
> For the truly paranoid we have probe_kernel_address(), suppose the lock
> was in module space and the module just got unloaded under us.

That's much too expensive.

The xadd shouldn't be noticeably more expensive than the current
"add_smp()". Yes, "lock xadd" used to be several cycles slower than
just "lock add" on some early cores, but I think these days it's down
to a single-cycle difference, which is not really different from doing
a separate load after the add.

The real problem with xadd used to be that we always had to do magic
special-casing for i386, but that's one of the reasons we dropped
support for original 80386.

So I think Raghavendra's last version (which hopefully fixes the
lockup problem that Sasha reported) together with changing that

        add_smp(&lock->tickets.head, TICKET_LOCK_INC);
        if (READ_ONCE(lock->tickets.tail) & TICKET_SLOWPATH_FLAG) ..

into something like

        val = xadd((&lock->ticket.head_tail, TICKET_LOCK_INC << TICKET_SHIFT);
        if (unlikely(val & TICKET_SLOWPATH_FLAG)) ...

would be the right thing to do. Somebody should just check that I got
that shift right, and that the tail is in the high bytes (head really
needs to be high to work, if it's in the low byte(s) the xadd would
overflow from head into tail which would be wrong).

                     Linus
