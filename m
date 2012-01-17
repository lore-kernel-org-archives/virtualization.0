From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Tue, 17 Jan 2012 14:51:26 +0200
Message-ID: <20120117125126.GQ2167@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
	<4F13E739.7040300@redhat.com>
	<20120116094020.GA6019@linux.vnet.ibm.com>
	<4F13F883.5090002@redhat.com>
	<20120116141117.GB6019@linux.vnet.ibm.com>
	<20120117091413.GM2167@redhat.com>
	<20120117122650.GC30757@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120117122650.GC30757@linux.vnet.ibm.com>
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

On Tue, Jan 17, 2012 at 05:56:50PM +0530, Srivatsa Vaddagiri wrote:
> * Gleb Natapov <gleb@redhat.com> [2012-01-17 11:14:13]:
> 
> > > The problem case I was thinking of was when guest VCPU would have issued
> > > HLT with interrupts disabled. I guess one option is to inject an NMI,
> > > and have the guest kernel NMI handler recognize this and make
> > > adjustments such that the vcpu avoids going back to HLT instruction.
> > > 
> > Just kick vcpu out of a guest mode and adjust rip to point after HLT on
> > next re-entry. Don't forget to call vmx_clear_hlt().
> 
> Looks bit hackish to me compared to having another hypercall to yield!
> 
Do not see anything hackish about it. But what you described above (the
part I replied to) is not another hypercall, but yet another NMI source
and special handling in a guest. So what hypercall do you mean?

> > > Having another hypercall to do yield/sleep (rather than effecting that
> > > via HLT) seems like an alternate clean solution here ..
> 
> - vatsa

--
			Gleb.
