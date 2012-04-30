From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V6 1/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Mon, 30 Apr 2012 11:22:34 +0300
Message-ID: <4F9E4BCA.5030604@redhat.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423095947.30893.84029.sendpatchset@codeblue.in.ibm.com>
	<20120424095923.GS15413@redhat.com> <4F9D3F8B.9010805@redhat.com>
	<20120429132030.GB15413@redhat.com> <4F9D417D.1050105@redhat.com>
	<20120429135227.GC15413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120429135227.GC15413@redhat.com>
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
Cc: X86 <x86@kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/29/2012 04:52 PM, Gleb Natapov wrote:
> On Sun, Apr 29, 2012 at 04:26:21PM +0300, Avi Kivity wrote:
> > On 04/29/2012 04:20 PM, Gleb Natapov wrote:
> > > > > This is too similar to kvm_irq_delivery_to_apic(). Why not reuse it. We
> > > > > can use one of reserved delivery modes as PV delivery mode. We will
> > > > > disallow guest to trigger it through apic interface, so this will not be
> > > > > part of ABI and can be changed at will.
> > > > >
> > > > 
> > > > I'm not thrilled about this.  Those delivery modes will eventually
> > > > become unreserved.  We can have a kvm_lookup_apic_id() that is shared
> > > > among implementations.
> > > > 
> > > This is only internal implementation. If they become unreserved we will
> > > use something else.
> > >
> > 
> > Yeah, I'm thinking of that time.  Why do something temporary and fragile?
> > 
> Why is it fragile? Just by unreserving the value Intel will not break
> KVM. Only when KVM will implement apic feature that unreserves the value
> we will have to change internal implementation and use another value,
> but this will be done by the same patch that does unreserving. The
> unreserving may even never happen. 

Some remains of that may leak somewhere.  Why not add an extra
parameter?  Or do something like

kvm_for_each_apic_dest(vcpu, apic_destination) {
      ...
}

That can be reused in both the apic code and pv kick.

> Meanwhile kvm_irq_delivery_to_apic()
> will likely be optimized to use hash for unicast delivery and unhalt
> hypercall will benefit from it immediately.

Overloading delivery mode is not the only way to achieve sharing.

-- 
error compiling committee.c: too many arguments to function
