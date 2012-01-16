From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Mon, 16 Jan 2012 11:24:39 +0100
Message-ID: <0B6BF918-45C7-45C6-AAA4-FB73EFAB9FDB@suse.de>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
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
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


On 16.01.2012, at 07:40, Jeremy Fitzhardinge wrote:

> On Jan 16, 2012, at 2:57 PM, Alexander Graf wrote:
> 
>> 
>> On 14.01.2012, at 19:25, Raghavendra K T wrote:
>> 
>>> The 5-patch series to follow this email extends KVM-hypervisor and Linux guest 
>>> running on KVM-hypervisor to support pv-ticket spinlocks, based on Xen's implementation.
>>> 
>>> One hypercall is introduced in KVM hypervisor,that allows a vcpu to kick
>>> another vcpu out of halt state.
>>> The blocking of vcpu is done using halt() in (lock_spinning) slowpath.
>> 
>> Is the code for this even upstream? Prerequisite series seem to have been posted by Jeremy, but they didn't appear to have made it in yet.
> 
> No, not yet.  The patches are unchanged since I last posted them, and as far as I know there are no objections to them, but I'd like to get some performance numbers just to make sure they don't cause any surprising regressions, especially in the non-virtual case.

Yup, that's a very good idea :)

> 
>> 
>> Either way, thinking about this I stumbled over the following passage of his patch:
>> 
>>> +               unsigned count = SPIN_THRESHOLD;
>>> +
>>> +               do {
>>> +                       if (inc.head == inc.tail)
>>> +                               goto out;
>>> +                       cpu_relax();
>>> +                       inc.head = ACCESS_ONCE(lock->tickets.head);
>>> +               } while (--count);
>>> +               __ticket_lock_spinning(lock, inc.tail);
>> 
>> 
>> That means we're spinning for n cycles, then notify the spinlock holder that we'd like to get kicked and go sleeping. While I'm pretty sure that it improves the situation, it doesn't solve all of the issues we have.
>> 
>> Imagine we have an idle host. All vcpus can freely run and everyone can fetch the lock as fast as on real machines. We don't need to / want to go to sleep here. Locks that take too long are bugs that need to be solved on real hw just as well, so all we do is possibly incur overhead.
> 
> I'm not quite sure what your concern is.  The lock is under contention, so there's nothing to do except spin; all this patch adds is a variable decrement/test to the spin loop, but that's not going to waste any more CPU than the non-counting case.  And once it falls into the blocking path, its a win because the VCPU isn't burning CPU any more.
> 
>> 
>> Imagine we have a contended host. Every vcpu gets at most 10% of a real CPU's runtime. So chances are 1:10 that you're currently running while you need to be. In such a setup, it's probably a good idea to be very pessimistic. Try to fetch the lock for 100 cycles and then immediately make room for all the other VMs that have real work going on!
> 
> Are you saying the threshold should be dynamic depending on how loaded the system is?  How can a guest know what the overall system contention is?  How should a guest use that to work out a good spin time?

I'm saying what I'm saying in the next paragraph :). The guest doesn't know, but the host does. So if we had shared memory between guest and host, the host could put its threshold limit in there, which on an idle system could be -1 and on a contended system could be 1.

> One possibility is to use the ticket lock queue depth to work out how contended the lock is, and therefore how long it might be worth waiting for.  I was thinking of something along the lines of "threshold = (THRESHOLD >> queue_depth)".  But that's pure hand wave, and someone would actually need to experiment before coming up with something reasonable.
> 
> But all of this is good to consider for future work, rather than being essential for the first version.

Well, yes, of course! It's by no means an objection to what's there today. I'm just trying to think of ways to make it even better :)

> 
>> So what I'm trying to get to is that if we had a hypervisor settable spin threshold, we could adjust it according to the host's load, getting VMs to behave differently on different (guest invisible) circumstances.
>> 
>> Speaking of which - don't we have spin lock counters in the CPUs now? I thought we could set intercepts that notify us when the guest issues too many repz nops or whatever the typical spinlock identifier was. Can't we reuse that and just interrupt the guest if we see this with a special KVM interrupt that kicks off the internal spin lock waiting code? That way we don't slow down all those bare metal boxes.
> 
> Yes, that mechanism exists, but it doesn't solve a very interesting problem.
> 
> The most important thing to solve is making sure that when *releasing* a ticketlock, the correct next VCPU gets scheduled promptly.  If you don't, you're just relying on the VCPU scheduler getting around to scheduling the correct VCPU, but if it doesn't it just ends up burning a timeslice of PCPU time while the wrong VCPU spins.
> 
> Limiting the spin time with a timeout or the rep/nop interrupt somewhat mitigates this, but it still means you end up spending a lot of time slices spinning the wrong VCPU until it finally schedules the correct one.  And the more contended the machine is, the worse the problem gets.

This is true in case you're spinning. If on overcommit spinlocks would instead of spin just yield(), we wouldn't have any vcpu running that's just waiting for a late ticket.

We still have an issue finding the point in time when a vcpu could run again, which is what this whole series is about. My point above was that instead of doing a count loop, we could just do the normal spin dance and set the threshold to when we enable the magic to have another spin lock notify us in the CPU. That way we

  * don't change the uncontended case
  * can set the threshold on the host, which knows how contended the system is

And since we control what spin locks look like, we can for example always keep the pointer to it in a specific register so that we can handle pv_lock_ops.lock_spinning() inside there and fetch all the information we need from our pt_regs.

> 
>> Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal? Last time I checked, enabling all the PV ops did incur significant slowdown which is why I went though the work to split the individual pv ops features up to only enable a few for KVM guests.
> 
> The whole point of the pv-ticketlock work is to keep the pvops hooks out of the locking fast path, so that the calls are only made on the slow path - that is, when spinning too long on a contended lock, and when releasing a lock that's in a "slow" state.  In the fast path case of no contention, there are no pvops, and the executed code path is almost identical to native.

You're still changing a tight loop that does nothing (CPU detects it and saves power) into something that performs calculations.

> But as I mentioned above, I'd like to see some benchmarks to prove that's the case.

Yes, that would be very good to have :)


Alex
