From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Tue, 17 Jan 2012 11:30:04 +1100
Message-ID: <4F14C10C.3010303@goop.org>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
	<0B6BF918-45C7-45C6-AAA4-FB73EFAB9FDB@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0B6BF918-45C7-45C6-AAA4-FB73EFAB9FDB@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 09:24 PM, Alexander Graf wrote:
> This is true in case you're spinning. If on overcommit spinlocks would
> instead of spin just yield(), we wouldn't have any vcpu running that's
> just waiting for a late ticket.

Yes, but the reality is that most spinlocks are held for a short period
of time and there's a low likelihood of being preempted while within a
spinlock critical section.  Therefore if someone else tries to get the
spinlock and there's contention, it's always worth spinning for a little
while because the lock will likely become free soon.

At least that's the case if the lock has low contention (shallow queue
depth and not in slow state).  Again, maybe it makes sense to never spin
for deep queues or already slowstate locks.

> We still have an issue finding the point in time when a vcpu could run again, which is what this whole series is about. My point above was that instead of doing a count loop, we could just do the normal spin dance and set the threshold to when we enable the magic to have another spin lock notify us in the CPU. That way we
>
>   * don't change the uncontended case

I don't follow you.  What do you mean by "the normal spin dance"?  What
do you mean by "have another spinlock notify us in the CPU"?  Don't
change which uncontended case?  Do you mean in the locking path?  Or the
unlock path?  Or both?

>   * can set the threshold on the host, which knows how contended the system is

Hm, I'm not convinced that knowing how contended the system is is all
that useful overall.  What's important is how contended a particular
lock is, and what state the current holder is in.  If it's not currently
running, then knowing the overall system contention would give you some
idea about how long you need to wait for it to be rescheduled, but
that's getting pretty indirect.

I think the "slowpath if preempted while spinning" idea I mentioned in
the other mail is probably worth following up, since that give specific
actionable information to the guest from the hypervisor.  But lots of
caveats.

[[
A possible mechanism:

  * register ranges of [er]ips with the hypervisor
  * each range is paired with a "resched handler block"
  * if vcpu is preempted within such a range, make sure it is
    rescheduled in the resched handler block

This is obviously akin to the exception mechanism, but it is partially
implemented by the hypervisor.  It allows the spinlock code to be
unchanged from native, but make use of a resched rather than an explicit
counter to determine when to slowpath the lock.  And it's a nice general
mechanism that could be potentially useful elsewhere.

Unfortunately, it doesn't change the unlock path at all; it still needs
to explicitly test if a VCPU needs to be kicked on unlock.
]]


> And since we control what spin locks look like, we can for example always keep the pointer to it in a specific register so that we can handle pv_lock_ops.lock_spinning() inside there and fetch all the information we need from our pt_regs.

You've left a pile of parts of an idea lying around, but I'm not sure
what shape you intend it to be.

>>> Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal? Last time I checked, enabling all the PV ops did incur significant slowdown which is why I went though the work to split the individual pv ops features up to only enable a few for KVM guests.
>> The whole point of the pv-ticketlock work is to keep the pvops hooks out of the locking fast path, so that the calls are only made on the slow path - that is, when spinning too long on a contended lock, and when releasing a lock that's in a "slow" state.  In the fast path case of no contention, there are no pvops, and the executed code path is almost identical to native.
> You're still changing a tight loop that does nothing (CPU detects it and saves power) into something that performs calculations.

It still has a "pause" instruction in that loop, so that CPU mechanism
will still come into play.  "pause" doesn't directly "save power"; it's
more about making sure that memory dependence cycles are broken and that
two competing threads will make similar progress.  Besides I'm not sure
adding a dec+test to a loop that's already got a memory read and compare
in it is adding much in the way of "calculations".

    J
