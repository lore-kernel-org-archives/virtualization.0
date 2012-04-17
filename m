From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [Xen-devel] [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Tue, 17 Apr 2012 08:24:16 +0530
Message-ID: <20120417025416.GA10184@linux.vnet.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F7616F5.4070000@zytor.com>
	<alpine.LFD.2.02.1203302333560.2542@ionos>
	<20120331040745.GC14030@linux.vnet.ibm.com>
	<20120416154429.GB4654@phenom.dumpdata.com>
	<1334594195.14560.236.camel@zakaz.uk.xensource.com>
Reply-To: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <andi@firstfloor.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

* Ian Campbell <Ian.Campbell@citrix.com> [2012-04-16 17:36:35]:

> > > The current pv-spinlock patches however does not track which vcpu is
> > > spinning at what head of the ticketlock. I suppose we can consider 
> > > that optimization in future and see how much benefit it provides (over
> > > plain yield/sleep the way its done now).
> > 
> > Right. I think Jeremy played around with this some time?
> 
> 5/11 "xen/pvticketlock: Xen implementation for PV ticket locks" tracks
> which vcpus are waiting for a lock in "cpumask_t waiting_cpus" and
> tracks which lock each is waiting for in per-cpu "lock_waiting". This is
> used in xen_unlock_kick to kick the right CPU. There's a loop over only
> the waiting cpus to figure out who to kick.

Yes sorry that's right. We do track who is waiting on what lock at what
position. This can be used to pass directed yield hints to host
scheduler (in a future optimization patch). What we don't track is the
vcpu owning a lock, which would have allowed other spinning vcpus to do
a directed yield to vcpu preempted holding a lock. OTOH that may be
unnecessary if we put in support for deferring preemption of vcpu that
are holding locks.

- vatsa
