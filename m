From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Mon, 16 Jan 2012 10:55:47 +0200
Message-ID: <4F13E613.7090602@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
Mime-Version: 1.0
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
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vnet.ibm.com>S
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 08:40 AM, Jeremy Fitzhardinge wrote:
> > 
> > That means we're spinning for n cycles, then notify the spinlock holder that we'd like to get kicked and go sleeping. While I'm pretty sure that it improves the situation, it doesn't solve all of the issues we have.
> > 
> > Imagine we have an idle host. All vcpus can freely run and everyone can fetch the lock as fast as on real machines. We don't need to / want to go to sleep here. Locks that take too long are bugs that need to be solved on real hw just as well, so all we do is possibly incur overhead.
>
> I'm not quite sure what your concern is.  The lock is under contention, so there's nothing to do except spin; all this patch adds is a variable decrement/test to the spin loop, but that's not going to waste any more CPU than the non-counting case.  And once it falls into the blocking path, its a win because the VCPU isn't burning CPU any more.

The wakeup path is slower though.  The previous lock holder has to
hypercall, and the new lock holder has to be scheduled, and transition
from halted state to running (a vmentry).  So it's only a clear win if
we can do something with the cpu other than go into the idle loop.

> > 
> > Imagine we have a contended host. Every vcpu gets at most 10% of a real CPU's runtime. So chances are 1:10 that you're currently running while you need to be. In such a setup, it's probably a good idea to be very pessimistic. Try to fetch the lock for 100 cycles and then immediately make room for all the other VMs that have real work going on!
>
> Are you saying the threshold should be dynamic depending on how loaded the system is?  How can a guest know what the overall system contention is?  How should a guest use that to work out a good spin time?
>
> One possibility is to use the ticket lock queue depth to work out how contended the lock is, and therefore how long it might be worth waiting for.  I was thinking of something along the lines of "threshold = (THRESHOLD >> queue_depth)".  But that's pure hand wave, and someone would actually need to experiment before coming up with something reasonable.
>
> But all of this is good to consider for future work, rather than being essential for the first version.

Agree.

> > So what I'm trying to get to is that if we had a hypervisor settable spin threshold, we could adjust it according to the host's load, getting VMs to behave differently on different (guest invisible) circumstances.
> > 
> > Speaking of which - don't we have spin lock counters in the CPUs now? I thought we could set intercepts that notify us when the guest issues too many repz nops or whatever the typical spinlock identifier was. Can't we reuse that and just interrupt the guest if we see this with a special KVM interrupt that kicks off the internal spin lock waiting code? That way we don't slow down all those bare metal boxes.
>
> Yes, that mechanism exists, but it doesn't solve a very interesting problem.
>
> The most important thing to solve is making sure that when *releasing* a ticketlock, the correct next VCPU gets scheduled promptly.  If you don't, you're just relying on the VCPU scheduler getting around to scheduling the correct VCPU, but if it doesn't it just ends up burning a timeslice of PCPU time while the wrong VCPU spins.

kvm does a directed yield to an unscheduled vcpu, selected in a round
robin fashion.  So if your overload factor is N (N runnable vcpus for
every physical cpu), and your spin counter waits for S cycles before
exiting, you will burn N*S cycles (actually more since there is overhead
involved, but lets fold it into S).

> Limiting the spin time with a timeout or the rep/nop interrupt somewhat mitigates this, but it still means you end up spending a lot of time slices spinning the wrong VCPU until it finally schedules the correct one.  And the more contended the machine is, the worse the problem gets.

Right.

>
> > Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal? Last time I checked, enabling all the PV ops did incur significant slowdown which is why I went though the work to split the individual pv ops features up to only enable a few for KVM guests.
>
> The whole point of the pv-ticketlock work is to keep the pvops hooks out of the locking fast path, so that the calls are only made on the slow path - that is, when spinning too long on a contended lock, and when releasing a lock that's in a "slow" state.  In the fast path case of no contention, there are no pvops, and the executed code path is almost identical to native.
>
> But as I mentioned above, I'd like to see some benchmarks to prove that's the case.
>

-- 
error compiling committee.c: too many arguments to function
