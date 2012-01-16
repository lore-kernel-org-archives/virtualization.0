From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Tue, 17 Jan 2012 10:59:03 +1100
Message-ID: <4F14B9C7.9090709@goop.org>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
	<4F13E613.7090602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F13E613.7090602@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vnet.ibm.com>S
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 07:55 PM, Avi Kivity wrote:
> On 01/16/2012 08:40 AM, Jeremy Fitzhardinge wrote:
>>> That means we're spinning for n cycles, then notify the spinlock holder that we'd like to get kicked and go sleeping. While I'm pretty sure that it improves the situation, it doesn't solve all of the issues we have.
>>>
>>> Imagine we have an idle host. All vcpus can freely run and everyone can fetch the lock as fast as on real machines. We don't need to / want to go to sleep here. Locks that take too long are bugs that need to be solved on real hw just as well, so all we do is possibly incur overhead.
>> I'm not quite sure what your concern is.  The lock is under contention, so there's nothing to do except spin; all this patch adds is a variable decrement/test to the spin loop, but that's not going to waste any more CPU than the non-counting case.  And once it falls into the blocking path, its a win because the VCPU isn't burning CPU any more.
> The wakeup path is slower though.  The previous lock holder has to
> hypercall, and the new lock holder has to be scheduled, and transition
> from halted state to running (a vmentry).  So it's only a clear win if
> we can do something with the cpu other than go into the idle loop.

Not burning power is a win too.

Actually what you want is something like "if you preempt a VCPU while
its spinning in a lock, then push it into the slowpath and don't
reschedule it without a kick".  But I think that interface would have a
lot of fiddly corners.

    J
