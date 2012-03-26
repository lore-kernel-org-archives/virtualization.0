From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Mon, 26 Mar 2012 16:25:35 +0200
Message-ID: <4F707C5F.1000905@redhat.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/21/2012 12:20 PM, Raghavendra K T wrote:
> From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
>
> Changes since last posting: (Raghavendra K T)
> [
>  - Rebased to linux-3.3-rc6.
>  - used function+enum in place of macro (better type checking) 
>  - use cmpxchg while resetting zero status for possible race
> 	[suggested by Dave Hansen for KVM patches ]
> ]
>
> This series replaces the existing paravirtualized spinlock mechanism
> with a paravirtualized ticketlock mechanism.
>
> Ticket locks have an inherent problem in a virtualized case, because
> the vCPUs are scheduled rather than running concurrently (ignoring
> gang scheduled vCPUs).  This can result in catastrophic performance
> collapses when the vCPU scheduler doesn't schedule the correct "next"
> vCPU, and ends up scheduling a vCPU which burns its entire timeslice
> spinning.  (Note that this is not the same problem as lock-holder
> preemption, which this series also addresses; that's also a problem,
> but not catastrophic).
>
> (See Thomas Friebel's talk "Prevent Guests from Spinning Around"
> http://www.xen.org/files/xensummitboston08/LHP.pdf for more details.)
>
> Currently we deal with this by having PV spinlocks, which adds a layer
> of indirection in front of all the spinlock functions, and defining a
> completely new implementation for Xen (and for other pvops users, but
> there are none at present).
>
> PV ticketlocks keeps the existing ticketlock implemenentation
> (fastpath) as-is, but adds a couple of pvops for the slow paths:
>
> - If a CPU has been waiting for a spinlock for SPIN_THRESHOLD
>   iterations, then call out to the __ticket_lock_spinning() pvop,
>   which allows a backend to block the vCPU rather than spinning.  This
>   pvop can set the lock into "slowpath state".
>
> - When releasing a lock, if it is in "slowpath state", the call
>   __ticket_unlock_kick() to kick the next vCPU in line awake.  If the
>   lock is no longer in contention, it also clears the slowpath flag.
>
> The "slowpath state" is stored in the LSB of the within the lock tail
> ticket.  This has the effect of reducing the max number of CPUs by
> half (so, a "small ticket" can deal with 128 CPUs, and "large ticket"
> 32768).
>
> This series provides a Xen implementation, but it should be
> straightforward to add a KVM implementation as well.
>

Looks like a good baseline on which to build the KVM implementation.  We
might need some handshake to prevent interference on the host side with
the PLE code.

-- 
error compiling committee.c: too many arguments to function
