From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Wed, 18 Jan 2012 16:18:11 +0530
Message-ID: <4F16A36B.4050409@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
	<4F13E613.7090602@redhat.com> <4F14B9C7.9090709@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F14B9C7.9090709@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Avi Kivity <avi@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Raghavendra <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Rob Landley <rlandley@parallels.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/17/2012 05:29 AM, Jeremy Fitzhardinge wrote:
> On 01/16/2012 07:55 PM, Avi Kivity wrote:
>> On 01/16/2012 08:40 AM, Jeremy Fitzhardinge wrote:
>>>> That means we're spinning for n cycles, then notify the spinlock holder that we'd like to get kicked and go sleeping. While I'm pretty sure that it improves the situation, it doesn't solve all of the issues we have.
>>>>
>>>> Imagine we have an idle host. All vcpus can freely run and everyone can fetch the lock as fast as on real machines. We don't need to / want to go to sleep here. Locks that take too long are bugs that need to be solved on real hw just as well, so all we do is possibly incur overhead.
>>> I'm not quite sure what your concern is.  The lock is under contention, so there's nothing to do except spin; all this patch adds is a variable decrement/test to the spin loop, but that's not going to waste any more CPU than the non-counting case.  And once it falls into the blocking path, its a win because the VCPU isn't burning CPU any more.
>> The wakeup path is slower though.  The previous lock holder has to
>> hypercall, and the new lock holder has to be scheduled, and transition
>> from halted state to running (a vmentry).  So it's only a clear win if
>> we can do something with the cpu other than go into the idle loop.
>
> Not burning power is a win too.
>
> Actually what you want is something like "if you preempt a VCPU while
> its spinning in a lock, then push it into the slowpath and don't
> reschedule it without a kick".  But I think that interface would have a
> lot of fiddly corners.
>

Yes wakeup path is little slower but better than burning cpu. no?

Suppose we have  16 vcpu,
vcpu 1- lockholder (preempted).
vcpu 2-8 - in slowpath.

If scheduler schedules vcpu-1 that is most favourable for lock progress,
But if vcpu-9 - vcpu-16 OR something else scheduled, then  also it's a 
win right (we are doing some useful work), but yes lock progress is
again little slower though.

The optimization areas of interests are perhaps:
(1) suppose vcpu-1 is running and is about to release lock and next
vcpu in queue just goes to halt(). so this makes us to tune 
SPIN_THRESHOLD rightly and have a mechanism to determine if lock-holder 
is running and do continue spin. Identifying whether lock-holder is 
running would be easier task and can be next step of optimization.

(2) Much talked, identifying lockholder-preemption (vcpu) and do
yield_to().

But I am not sure how complicated is yield_to() implementation once we 
have identified the exact preempted vcpu (lock-holder).

>      J
>
>
