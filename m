From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V6 1/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Sun, 29 Apr 2012 16:18:03 +0300
Message-ID: <4F9D3F8B.9010805@redhat.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423095947.30893.84029.sendpatchset@codeblue.in.ibm.com>
	<20120424095923.GS15413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120424095923.GS15413@redhat.com>
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

On 04/24/2012 12:59 PM, Gleb Natapov wrote:
> >  
> > +/*
> > + * kvm_pv_kick_cpu_op:  Kick a vcpu.
> > + *
> > + * @apicid - apicid of vcpu to be kicked.
> > + */
> > +static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
> > +{
> > +	struct kvm_vcpu *vcpu = NULL;
> > +	int i;
> > +
> > +	kvm_for_each_vcpu(i, vcpu, kvm) {
> > +		if (!kvm_apic_present(vcpu))
> > +			continue;
> > +
> > +		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
> > +			break;
> > +	}
> > +	if (vcpu) {
> > +		/*
> > +		 * Setting unhalt flag here can result in spurious runnable
> > +		 * state when unhalt reset does not happen in vcpu_block.
> > +		 * But that is harmless since that should soon result in halt.
> > +		 */
> > +		vcpu->arch.pv.pv_unhalted = 1;
> > +		/* We need everybody see unhalt before vcpu unblocks */
> > +		smp_mb();
> > +		kvm_vcpu_kick(vcpu);
> > +	}
> > +}
> This is too similar to kvm_irq_delivery_to_apic(). Why not reuse it. We
> can use one of reserved delivery modes as PV delivery mode. We will
> disallow guest to trigger it through apic interface, so this will not be
> part of ABI and can be changed at will.
>

I'm not thrilled about this.  Those delivery modes will eventually
become unreserved.  We can have a kvm_lookup_apic_id() that is shared
among implementations.

-- 
error compiling committee.c: too many arguments to function
