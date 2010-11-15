From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 00/20] x86: ticket lock rewrite and paravirtualization
Date: Mon, 15 Nov 2010 12:00:31 -0800
Message-ID: <4CE1915F.60507__33513.0062689588$1289851272$gmane$org@goop.org>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4CDDBBD3.5050903@zytor.com> <4CDDBCE4.80906@goop.org>
	<4CDDBDB5.8000800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CDDBDB5.8000800@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/12/2010 02:20 PM, H. Peter Anvin wrote:
> On 11/12/2010 02:17 PM, Jeremy Fitzhardinge wrote:
>> On 11/12/2010 02:12 PM, H. Peter Anvin wrote:
>>> On 11/03/2010 07:59 AM, Jeremy Fitzhardinge wrote:
>>>>       - with an unmodified struct spinlock, it can check to see if
>>>>         head == tail after unlock; if not, then there's someone else
>>>>         trying to lock, and we can do a kick.  Unfortunately this
>>>>         generates very high level of redundant kicks, because the
>>>>         waiting CPU might not have blocked yet (which is the common
>>>>         case)
>>>>
>>> How high is "very high" here -- most of the time (so that any mitigation
>>> on the slow patch is useless)?
>> I'll need to remeasure, but I think around 90% of the slowpath entries
>> were spurious without this.  In other words, when spinlocks do contend,
>> most of the time it isn't very serious and the other cpu doesn't spend
>> much time spinning.
>>
> 90% of the slowpath entries is one thing, my real question is the
> fraction of fastpath entries that get diverted to the slowpath.  It
> affects where mitigation needs to happen.

There are two questions: how many unlock events *must* go into the
slowpath for correctness reasons (ie, because the corresponding lock
also went slowpath and got blocked there), and how many end up going
into the slowpath due to imperfect heuristics?

The number of lock events which go slowpath is very dependent on the
workload of the kernel in question and of the machine overall.  On a
system with no CPU overcommit it should be zero (assuming that in the
native case no Linux spinlock remains contended for so long that it will
trigger the slowpath).  On a very overcommitted system, it comes down to
what the likelihood that a VCPU will get preempted while running in a
critical region: Tcrit * Phz, where Tcrit is the critical section time
in S and Phz is the preemption rate of the VCPU scheduler in Hz.  So,
for example, a lock with a 10uS critical section and a 100Hz preemption
rate will have a .1% chance of getting preempted and possibly causing
the other lockers to enter the slow path.

On the unlock side, it needs to test whether lock has any waiters in a
slowpath state.  A conservative test is whether there are any
outstanding tickets, but in my measurements 90% of CPUs which spun on a
lock ended up getting it without having to take the slowpath.  This lead
me to investigate more precise tests, which is currently a count of
slowpath-entering CPUs waiting on the lock.

Another approach I discussed with PeterZ and Mathieu is to steal the LSB
of the ticket counters (halving the max CPU count) to use as a "there is
someone in slowpath waiting on this lock".  But I haven't spent the time
to work out an algorithm to maintain that flag (or flags, since there
are bits available) in a correct and efficient way.

    J
