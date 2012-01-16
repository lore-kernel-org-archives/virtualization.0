From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V4 2/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Mon, 16 Jan 2012 11:03:15 +0200
Message-ID: <4F13E7D3.1060004@redhat.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182553.8604.41642.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120114182553.8604.41642.sendpatchset@oc5400248562.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki
List-Id: virtualization@lists.linuxfoundation.org

On 01/14/2012 08:25 PM, Raghavendra K T wrote:
> Add a hypercall to KVM hypervisor to support pv-ticketlocks 
>
> KVM_HC_KICK_CPU allows the calling vcpu to kick another vcpu out of halt state.
>     
> The presence of these hypercalls is indicated to guest via
> KVM_FEATURE_PVLOCK_KICK/KVM_CAP_PVLOCK_KICK.
>
> Qemu needs a corresponding patch to pass up the presence of this feature to 
> guest via cpuid. Patch to qemu will be sent separately.

No need to discuss qemu in a kernel patch.

>  
> +/*
> + * kvm_pv_kick_cpu_op:  Kick a vcpu.
> + *
> + * @apicid - apicid of vcpu to be kicked.
> + */
> +static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
> +{
> +	struct kvm_vcpu *vcpu = NULL;
> +	int i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (!kvm_apic_present(vcpu))
> +			continue;
> +
> +		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
> +			break;
> +	}
> +	if (vcpu) {
> +		kvm_make_request(KVM_REQ_PVLOCK_KICK, vcpu);
> +		kvm_vcpu_kick(vcpu);
> +	}
> +}
> +

The code that handles KVM_REQ_PVLOCK_KICK needs to be in this patch.


-- 
error compiling committee.c: too many arguments to function
