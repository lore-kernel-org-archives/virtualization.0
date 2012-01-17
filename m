From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Tue, 17 Jan 2012 19:58:18 +0530
Message-ID: <20120117142818.GE30398@linux.vnet.ibm.com>
References: <20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
	<4F13E739.7040300@redhat.com>
	<20120116094020.GA6019@linux.vnet.ibm.com>
	<4F13F883.5090002@redhat.com>
	<20120116141117.GB6019@linux.vnet.ibm.com>
	<20120117091413.GM2167@redhat.com>
	<20120117122650.GC30757@linux.vnet.ibm.com>
	<20120117125126.GQ2167@redhat.com>
	<20120117131103.GD30398@linux.vnet.ibm.com>
	<20120117132051.GR2167@redhat.com>
Reply-To: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120117132051.GR2167@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>Dave Hansen <dave>
List-Id: virtualization@lists.linuxfoundation.org

* Gleb Natapov <gleb@redhat.com> [2012-01-17 15:20:51]:

> > Having the hypercall makes the intent of vcpu (to sleep on a kick) clear to 
> > hypervisor vs assuming that because of a trapped HLT instruction (which
> > will anyway won't work when yield_on_hlt=0).
> > 
> The purpose of yield_on_hlt=0 is to allow VCPU to occupy CPU for the
> entire time slice no mater what. I do not think disabling yield on HLT
> is even make sense in CPU oversubscribe scenario.

Yes, so is there any real use for yield_on_hlt=0? I believe Anthony
initially added it as a way to implement CPU bandwidth capping for VMs,
which would ensure that busy VMs don't eat into cycles meant for a idle
VM. Now that we have proper support in scheduler for CPU bandwidth capping, is 
there any real world use for yield_on_hlt=0? If not, deprecate it?

> Now if you'll call
> KVM_HC_WAIT_FOR_KICK instead of HLT you will effectively ignore
> yield_on_hlt=0 setting.

I guess that depends on what we do in KVM_HC_WAIT_FOR_KICK. If we do
yield_to() rather than sleep, it should minimize how much cycles vcpu gives away
to a competing VM (which seems to be the biggest purpose why one may
want to set yield_on_hlt=0).

> This is like having PV HLT that does not obey
> VMX exit control setting.

- vatsa
