From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V3 2/4] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Wed, 07 Dec 2011 16:52:53 +0200
Message-ID: <4EDF7DC5.5010504@redhat.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130085959.23386.69166.sendpatchset@oc5400248562.ibm.com>
	<20111207104849.GA24849@amt.cnet>
	<4EDF5413.1030107@linux.vnet.ibm.com>
	<20111207123330.GA32212@amt.cnet> <4EDF6049.2030204@redhat.com>
	<20111207133947.GA1708@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111207133947.GA1708@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Raghavendra K T <raghukt@linux.vnet.ibm.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuk
List-Id: virtualization@lists.linuxfoundation.org

On 12/07/2011 03:39 PM, Marcelo Tosatti wrote:
> > Also I think we can keep the kicked flag in vcpu->requests, no need for
> > new storage.
>
> Was going to suggest it but it violates the currently organized
> processing of entries at the beginning of vcpu_enter_guest.
>
> That is, this "kicked" flag is different enough from vcpu->requests
> processing that a separate variable seems worthwhile (even more
> different with convertion to MP_STATE at KVM_GET_MP_STATE).

IMO, it's similar to KVM_REQ_EVENT (which can also cause mpstate to
change due to apic re-evaluation).

-- 
error compiling committee.c: too many arguments to function
