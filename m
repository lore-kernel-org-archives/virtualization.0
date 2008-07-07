From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC 0/4] Paravirtual spinlocks
Date: Mon, 07 Jul 2008 12:07:49 -0700
Message-ID: <20080707190749.299430659__10347.8175159127$1215458499$gmane$org@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

At the most recent Xen Summit, Thomas Friebel presented a paper
("Preventing Guests from Spinning Around",
http://xen.org/files/xensummitboston08/LHP.pdf) investigating the
interactions between spinlocks and virtual machines.  Specifically, he
looked at what happens when a lock-holding VCPU gets involuntarily
preempted.

The obvious first order effect is that while the VCPU is not running,
the effective critical region time goes from being microseconds to
milliseconds, until it gets scheduled again.  This increases the
chance that there will be be contention, and the contending VCPU will
waste time spinning.

This is a measurable effect, but not terribly serious.  After all,
since Linux tends to hold locks for very short periods of time,
the likelihood of being preempted while holding a lock is low.

The real eye-opener is the secondary effects specific to ticket locks.

Clearly ticket locks suffer the same problem as all spinlocks.  But
when the lock holder releases the lock, the real fun begins.

By design, ticket locks are strictly fair, by imposing a FIFO order
lock holders.  The micro-architectural effect of this is that the
lock cache line will bounce around between the contending CPUs until
it finds the next in line, who then takes the lock and carries on.

When running in a virtual machine, a similar effect happens at the
VCPU level.  If all the contending VCPUs are not currently running on
real CPUs, then VCPU scheduler will run some random subset of them.
If it isn't a given VCPUs turn to take the lock, it will spin, burning
a VCPU timeslice.  Eventually the next-in-line will get scheduled,
take the lock, release it, and the remaining contending VCPUs will
repeat the process until the next in line is scheduled.

This means that the effective contention time of the lock is not
merely the time if takes the original lock-holder to take and release
the lock - including any preemption it may suffer - but the
spin-scheduling storm that follows to schedule the right VCPU to next
take the lock.  This could happen if the original contention was not
as a result of preemption, but just normal spinlock level contention.

One of the results Thomas presents is a kernbench run which normally
takes less than a minute going for 45 minutes, with 99+% spent in
ticket lock contention.  I've reproduced similar results.

This series has:
 - a paravirt_ops spinlock interface, which defaults to the standard
   ticket lock algorithm,
 - a second spinlock implementation based on the pre-ticket-lock
   "lock-byte" algorithm,
 - And a Xen-specific spinlock algorithm which voluntarily preempts a
   VCPU if it spins for too long. [FOR REFERENCE ONLY: will not apply
   to a current git tree.]

When running on native hardware, the overhead of enabling
CONFIG_PARAVIRT is an extra direct call/return on the lock/unlock
paths; the paravirt-ops patching machinery eliminates any indirect
calls.  With a small amount of restructuring, this overhead could be
eliminated (by making spin_lock()/unlock() inline functions,
containing calls to __raw_spin_lock/unlock).

My experiments show that using a Xen-specific lock helps guest
performance a bit (reduction in elapsed and system time in a kernbench
run), but most significantly, reduces overall physical CPU consumption
by 10%, and so increases overall system scalability.

   J
-- 
