From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Tue, 17 Jan 2012 15:20:51 +0200
Message-ID: <20120117132051.GR2167@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
	<4F13E739.7040300@redhat.com>
	<20120116094020.GA6019@linux.vnet.ibm.com>
	<4F13F883.5090002@redhat.com>
	<20120116141117.GB6019@linux.vnet.ibm.com>
	<20120117091413.GM2167@redhat.com>
	<20120117122650.GC30757@linux.vnet.ibm.com>
	<20120117125126.GQ2167@redhat.com>
	<20120117131103.GD30398@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120117131103.GD30398@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>Dave Hansen <dave>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 17, 2012 at 06:41:03PM +0530, Srivatsa Vaddagiri wrote:
> * Gleb Natapov <gleb@redhat.com> [2012-01-17 14:51:26]:
> 
> > On Tue, Jan 17, 2012 at 05:56:50PM +0530, Srivatsa Vaddagiri wrote:
> > > * Gleb Natapov <gleb@redhat.com> [2012-01-17 11:14:13]:
> > > 
> > > > > The problem case I was thinking of was when guest VCPU would have issued
> > > > > HLT with interrupts disabled. I guess one option is to inject an NMI,
> > > > > and have the guest kernel NMI handler recognize this and make
> > > > > adjustments such that the vcpu avoids going back to HLT instruction.
> > > > > 
> > > > Just kick vcpu out of a guest mode and adjust rip to point after HLT on
> > > > next re-entry. Don't forget to call vmx_clear_hlt().
> > > 
> > > Looks bit hackish to me compared to having another hypercall to yield!
> > > 
> > Do not see anything hackish about it. But what you described above (the
> > part I replied to) is not another hypercall, but yet another NMI source
> > and special handling in a guest.
> 
> True, which I didn't exactly like and hence was suggesting we use
> another hypercall to let spinning vcpu sleep.
> 
Ah, sorry. Missed that.

> > So what hypercall do you mean?
> 
> The hypercall is described below:
> 
> > > > > Having another hypercall to do yield/sleep (rather than effecting that
> > > > > via HLT) seems like an alternate clean solution here ..
> 
> and was implemented in an earlier version of this patch (v2) as
> KVM_HC_WAIT_FOR_KICK hypercall:
> 
> https://lkml.org/lkml/2011/10/23/211
> 
> Having the hypercall makes the intent of vcpu (to sleep on a kick) clear to 
> hypervisor vs assuming that because of a trapped HLT instruction (which
> will anyway won't work when yield_on_hlt=0).
> 
The purpose of yield_on_hlt=0 is to allow VCPU to occupy CPU for the
entire time slice no mater what. I do not think disabling yield on HLT
is even make sense in CPU oversubscribe scenario. Now if you'll call
KVM_HC_WAIT_FOR_KICK instead of HLT you will effectively ignore
yield_on_hlt=0 setting. This is like having PV HLT that does not obey
VMX exit control setting.

--
			Gleb.
