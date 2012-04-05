From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Thu, 05 Apr 2012 12:15:56 +0300
Message-ID: <4F7D62CC.9010108@redhat.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F7616F5.4070000@zytor.com>
	<alpine.LFD.2.02.1203302333560.2542@ionos>
	<4F7858C0.90405@redhat.com>
	<alpine.LFD.2.02.1204021117560.2542@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1204021117560.2542@ionos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/02/2012 12:26 PM, Thomas Gleixner wrote:
> > One thing about it is that it can give many false positives.  Consider a
> > fine-grained spinlock that is being accessed by many threads.  That is,
> > the lock is taken and released with high frequency, but there is no
> > contention, because each vcpu is accessing a different instance.  So the
> > host scheduler will needlessly delay preemption of vcpus that happen to
> > be holding a lock, even though this gains nothing.
>
> You're talking about per cpu locks, right? I can see the point there,
> but per cpu stuff might be worth annotating to avoid this.

Or any lock which is simply uncontended.  Say a single process is
running, the rest of the system is idle.  It will take and release many
locks; but it can be preempted at any point by the hypervisor with no
performance loss.

The overhead is arming a timer twice and an extra exit per deferred
context switch.  Perhaps not much given that you don't see tons of
context switches on virt workloads, at least without threaded interrupts
(or maybe interrupt threads should override this mechanism, by being
realtime threads).

> > A second issue may happen with a lock that is taken and released with
> > high frequency, with a high hold percentage.  The host scheduler may
> > always sample the guest in a held state, leading it to conclude that
> > it's exceeding its timeout when in fact the lock is held for a short
> > time only.
>
> Well, no. You can avoid that.
>
> host		VCPU
> 		spin_lock()
> 		 modify_global_state()
>    	exit
> check_global_state()
> mark_global_state()
> reschedule vcpu
>
> 		spin_unlock()
> 		 check_global_state()
> 		  trigger_exit()
>
> So when an exit occures in the locked section, then the host can mark
> the global state to tell the guest to issue a trap on unlock.

Right.

How does this nest?  Do we trigger the exit on the outermost unlock?

-- 
error compiling committee.c: too many arguments to function
