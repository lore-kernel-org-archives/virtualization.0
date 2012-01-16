From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Mon, 16 Jan 2012 09:21:14 +0530
Message-ID: <20120116035114.GI9129@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
	<AD31813D-E4D5-43F3-B06A-9EB1B6FC9381@suse.de>
Reply-To: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AD31813D-E4D5-43F3-B06A-9EB1B6FC9381@suse.de>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>Dave Hansen <dav>
List-Id: virtualization@lists.linuxfoundation.org

* Alexander Graf <agraf@suse.de> [2012-01-16 04:23:24]:

> > +5. KVM_HC_KICK_CPU
> > +------------------------
> > +value: 5
> > +Architecture: x86
> > +Purpose: Hypercall used to wakeup a vcpu from HLT state
> > +
> > +Usage example : A vcpu of a paravirtualized guest that is busywaiting in guest
> > +kernel mode for an event to occur (ex: a spinlock to become available)
> > +can execute HLT instruction once it has busy-waited for more than a
> > +threshold time-interval. Execution of HLT instruction would cause
> > +the hypervisor to put the vcpu to sleep (unless yield_on_hlt=0) until occurence
> > +of an appropriate event. Another vcpu of the same guest can wakeup the sleeping
> > +vcpu by issuing KVM_HC_KICK_CPU hypercall, specifying APIC ID of the vcpu to be
> > +wokenup.
> 
> The description is way too specific. The hypercall basically gives the guest the ability to yield() its current vcpu to another chosen vcpu.

Hmm ..the hypercall does not allow a vcpu to yield. It just allows some
target vcpu to be prodded/wokenup, after which vcpu continues execution.

Note that semantics of this hypercall is different from the hypercall on which
PPC pv-spinlock (__spin_yield()) is currently dependent. This is mainly because 
of ticketlocks on x86 (which does not allow us to easily store owning cpu
details in lock word itself).

> The APIC piece is an implementation detail for x86. On PPC we could just use the PIR register contents (processor identifier).

- vatsa
