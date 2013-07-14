From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V10 16/18] kvm hypervisor : Simplify
	kvm_for_each_vcpu with kvm_irq_delivery_to_apic
Date: Sun, 14 Jul 2013 16:24:02 +0300
Message-ID: <20130714132402.GB11772@redhat.com>
References: <20130624124014.27508.8906.sendpatchset@codeblue.in.ibm.com>
	<20130624124353.27508.94224.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130624124353.27508.94224.sendpatchset@codeblue.in.ibm.com>
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
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 24, 2013 at 06:13:53PM +0530, Raghavendra K T wrote:
> Simplify kvm_for_each_vcpu with kvm_irq_delivery_to_apic
> 
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> 
> Note that we are using APIC_DM_REMRD which has reserved usage.
> In future if APIC_DM_REMRD usage is standardized, then we should
> find some other way or go back to old method.
> 
> Suggested-by: Gleb Natapov <gleb@redhat.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  arch/x86/kvm/lapic.c |    5 ++++-
>  arch/x86/kvm/x86.c   |   25 ++++++-------------------
>  2 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index e1adbb4..3f5f82e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -706,7 +706,10 @@ out:
>  		break;
>  
>  	case APIC_DM_REMRD:
> -		apic_debug("Ignoring delivery mode 3\n");
> +		result = 1;
> +		vcpu->arch.pv.pv_unhalted = 1;
> +		kvm_make_request(KVM_REQ_EVENT, vcpu);
> +		kvm_vcpu_kick(vcpu);
>  		break;
>  
>  	case APIC_DM_SMI:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 92a9932..b963c86 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5456,27 +5456,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>   */
>  static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
>  {
> -	struct kvm_vcpu *vcpu = NULL;
> -	int i;
> +	struct kvm_lapic_irq lapic_irq;
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (!kvm_apic_present(vcpu))
> -			continue;
> +	lapic_irq.shorthand = 0;
> +	lapic_irq.dest_mode = 0;
> +	lapic_irq.dest_id = apicid;
>  
> -		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
> -			break;
> -	}
> -	if (vcpu) {
> -		/*
> -		 * Setting unhalt flag here can result in spurious runnable
> -		 * state when unhalt reset does not happen in vcpu_block.
> -		 * But that is harmless since that should soon result in halt.
> -		 */
> -		vcpu->arch.pv.pv_unhalted = true;
> -		/* We need everybody see unhalt before vcpu unblocks */
> -		smp_wmb();
> -		kvm_vcpu_kick(vcpu);
> -	}
> +	lapic_irq.delivery_mode = APIC_DM_REMRD;
Need to make sure that delivery_mode cannot be set to APIC_DM_REMRD
from MSI/IOAPIC/IPI path.

> +	kvm_irq_delivery_to_apic(kvm, 0, &lapic_irq, NULL);
>  }
>  
>  int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)

--
			Gleb.
