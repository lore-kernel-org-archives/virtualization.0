From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Tue, 10 Feb 2015 14:18:05 +0100
Message-ID: <CAK1hOcNZ+hfjt=CmtZumPoFQRdQbf9SSEF0cOWv9-9ku0K7bcg__12071.8496189967$1423574328$gmane$org@mail.gmail.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54D9CFC7.5020007@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <ak@linux.intel.com>, xen-devel@lists.xenproject.org, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 10, 2015 at 10:30 AM, Raghavendra K T
<raghavendra.kt@linux.vnet.ibm.com> wrote:
> On 02/10/2015 06:23 AM, Linus Torvalds wrote:
>>          add_smp(&lock->tickets.head, TICKET_LOCK_INC);
>>          if (READ_ONCE(lock->tickets.tail) & TICKET_SLOWPATH_FLAG) ..
>>
>> into something like
>>
>>          val = xadd((&lock->ticket.head_tail, TICKET_LOCK_INC <<
>> TICKET_SHIFT);
>>          if (unlikely(val & TICKET_SLOWPATH_FLAG)) ...
>>
>> would be the right thing to do. Somebody should just check that I got
>> that shift right, and that the tail is in the high bytes (head really
>> needs to be high to work, if it's in the low byte(s) the xadd would
>> overflow from head into tail which would be wrong).
>
> Unfortunately xadd could result in head overflow as tail is high.

xadd can overflow, but is this really a problem?

# define HEAD_MASK (TICKET_SLOWPATH_FLAG-1)

...
unlock_again:

val = xadd((&lock->ticket.head_tail, TICKET_LOCK_INC);
if (unlikely(!(val & HEAD_MASK))) {
    /* overflow. we inadvertently incremented the tail word.
     * tail's lsb is TICKET_SLOWPATH_FLAG.
     * Increment inverted this bit, fix it up.
     * (inc _may_ have messed up tail counter too,
     * will deal with it after kick.)
    */
    val ^= TICKET_SLOWPATH_FLAG;
}

if (unlikely(val & TICKET_SLOWPATH_FLAG)) {
    ...kick the waiting task...

   val -= TICKET_SLOWPATH_FLAG;
   if (unlikely(!(val & HEAD_MASK))) {
        /* overflow. we inadvertently incremented tail word, *and*
         * TICKET_SLOWPATH_FLAG was set, increment overflowed
         * that bit too and incremented tail counter.
         * This means we (inadvertently) taking the lock again!
         * Oh well. Take it, and unlock it again...
         */
        while (1) {
            if (READ_ONCE(lock->tickets.head) != TICKET_TAIL(val))
                cpu_relax();
        }
        goto unlock_again;
}


Granted, this looks ugly.
