From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 1/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Thu, 28 Jun 2012 23:47:27 +0530
Message-ID: <4FEC9FB7.3000608@linux.vnet.ibm.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423095947.30893.84029.sendpatchset@codeblue.in.ibm.com>
	<20120424095923.GS15413@redhat.com>
	<4F9A78CF.7070005@linux.vnet.ibm.com>
	<20120427155318.GI6833@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120427155318.GI6833@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>, Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/27/2012 09:23 PM, Gleb Natapov wrote:
> On Fri, Apr 27, 2012 at 04:15:35PM +0530, Raghavendra K T wrote:
>> On 04/24/2012 03:29 PM, Gleb Natapov wrote:
>>> On Mon, Apr 23, 2012 at 03:29:47PM +0530, Raghavendra K T wrote:
>>>> From: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>>>>
>>>> KVM_HC_KICK_CPU allows the calling vcpu to kick another vcpu out of halt state.
>>>>
>>>> The presence of these hypercalls is indicated to guest via
>>>> KVM_FEATURE_PV_UNHALT/KVM_CAP_PV_UNHALT.
>>>>
>>>> Signed-off-by: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>>>> Signed-off-by: Suzuki Poulose<suzuki@in.ibm.com>
>>>> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>>>> ---
>> [...]
>>>> +/*
>>>> + * kvm_pv_kick_cpu_op:  Kick a vcpu.
>>>> + *
>>>> + * @apicid - apicid of vcpu to be kicked.
>>>> + */
>>>> +static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
>>>> +{
>>>> +	struct kvm_vcpu *vcpu = NULL;
>>>> +	int i;
>>>> +
>>>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>>>> +		if (!kvm_apic_present(vcpu))
>>>> +			continue;
>>>> +
>>>> +		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
>>>> +			break;
>>>> +	}
>>>> +	if (vcpu) {
>>>> +		/*
>>>> +		 * Setting unhalt flag here can result in spurious runnable
>>>> +		 * state when unhalt reset does not happen in vcpu_block.
>>>> +		 * But that is harmless since that should soon result in halt.
>>>> +		 */
>>>> +		vcpu->arch.pv.pv_unhalted = 1;
>>>> +		/* We need everybody see unhalt before vcpu unblocks */
>>>> +		smp_mb();
>>>> +		kvm_vcpu_kick(vcpu);
>>>> +	}
>>>> +}
>>> This is too similar to kvm_irq_delivery_to_apic(). Why not reuse it. We
>>> can use one of reserved delivery modes as PV delivery mode. We will
>>> disallow guest to trigger it through apic interface, so this will not be
>>> part of ABI and can be changed at will.
[...]
>> kvm/x86.c
>> =========
>> kvm_pv_kick_cpu_op()
>> {
>>
>>   struct kvm_lapic_irq lapic_irq;
>>
>>   lapic_irq.shorthand = 0;
>>   lapic_irq.dest_mode = 0;
>>   lapic_irq.dest_id = apicid;
>>
>>   lapic_irq.delivery_mode = PV_DELIVERY_MODE;
>>   kvm_irq_delivery_to_apic(kvm, 0,&lapic_irq );
>>
>> }
>>
>> kvm/lapic.c
>> ==========
>> _apic_accept_irq()
>> {
>> ...
>> case APIC_DM_REMRD:
>>                  result = 1;
>>                  vcpu->pv_unhalted = 1
>>                  smp_mb();
>>                  kvm_make_request(KVM_REQ_EVENT, vcpu);
>>                  kvm_vcpu_kick(vcpu);
>>                  break;
>>
>> ...
>> }
>>
>> here using PV_DELIVERY_MODE = APIC_DM_REMRD, which was unused.
>>
> Yes, this is what I mean except that PV_DELIVERY_MODE should be
> number defined as reserved by Intel spec.
>

Hi Gleb, Avi,

This had been TODO in my V8 patches.
I 'll fold this into V9 (while rebasing to
3.5-rc).
Please let me know if it is OK.
