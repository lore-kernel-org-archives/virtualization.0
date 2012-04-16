From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Mon, 16 Apr 2012 09:42:18 -0700
Message-ID: <4F8C4BEA.8040601__40457.0622057237$1334594974$gmane$org@goop.org>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F7616F5.4070000@zytor.com>	<alpine.LFD.2.02.1203302333560.2542@ionos>
	<20120331040745.GC14030@linux.vnet.ibm.com>
	<20120416154429.GB4654@phenom.dumpdata.com>
	<1334594195.14560.236.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1334594195.14560.236.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <andi@firstfloor.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/16/2012 09:36 AM, Ian Campbell wrote:
> On Mon, 2012-04-16 at 16:44 +0100, Konrad Rzeszutek Wilk wrote:
>> On Sat, Mar 31, 2012 at 09:37:45AM +0530, Srivatsa Vaddagiri wrote:
>>> * Thomas Gleixner <tglx@linutronix.de> [2012-03-31 00:07:58]:
>>>
>>>> I know that Peter is going to go berserk on me, but if we are running
>>>> a paravirt guest then it's simple to provide a mechanism which allows
>>>> the host (aka hypervisor) to check that in the guest just by looking
>>>> at some global state.
>>>>
>>>> So if a guest exits due to an external event it's easy to inspect the
>>>> state of that guest and avoid to schedule away when it was interrupted
>>>> in a spinlock held section. That guest/host shared state needs to be
>>>> modified to indicate the guest to invoke an exit when the last nested
>>>> lock has been released.
>>> I had attempted something like that long back:
>>>
>>> http://lkml.org/lkml/2010/6/3/4
>>>
>>> The issue is with ticketlocks though. VCPUs could go into a spin w/o
>>> a lock being held by anybody. Say VCPUs 1-99 try to grab a lock in
>>> that order (on a host with one cpu). VCPU1 wins (after VCPU0 releases it)
>>> and releases the lock. VCPU1 is next eligible to take the lock. If 
>>> that is not scheduled early enough by host, then remaining vcpus would keep 
>>> spinning (even though lock is technically not held by anybody) w/o making 
>>> forward progress.
>>>
>>> In that situation, what we really need is for the guest to hint to host
>>> scheduler to schedule VCPU1 early (via yield_to or something similar). 
>>>
>>> The current pv-spinlock patches however does not track which vcpu is
>>> spinning at what head of the ticketlock. I suppose we can consider 
>>> that optimization in future and see how much benefit it provides (over
>>> plain yield/sleep the way its done now).
>> Right. I think Jeremy played around with this some time?
> 5/11 "xen/pvticketlock: Xen implementation for PV ticket locks" tracks
> which vcpus are waiting for a lock in "cpumask_t waiting_cpus" and
> tracks which lock each is waiting for in per-cpu "lock_waiting". This is
> used in xen_unlock_kick to kick the right CPU. There's a loop over only
> the waiting cpus to figure out who to kick.

Yes, and AFAIK the KVM pv-ticketlock patches do the same thing.  If a
(V)CPU is asleep, then sending it a kick is pretty much equivalent to a
yield to (not precisely, but it should get scheduled soon enough, and it
won't be competing with a pile of VCPUs with no useful work to do).

    J
