From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 2/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Mon, 16 Jan 2012 14:13:06 +0530
Message-ID: <4F13E31A.1080502@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182553.8604.41642.sendpatchset@oc5400248562.ibm.com>
	<5861AA49-E70B-4812-BBE4-A8507B3FCF80@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5861AA49-E70B-4812-BBE4-A8507B3FCF80@suse.de>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

On 01/16/2012 08:54 AM, Alexander Graf wrote:
>
> On 14.01.2012, at 19:25, Raghavendra K T wrote:
>
>> Add a hypercall to KVM hypervisor to support pv-ticketlocks
>>
>> KVM_HC_KICK_CPU allows the calling vcpu to kick another vcpu out of halt state.
>>
>> The presence of these hypercalls is indicated to guest via
>> KVM_FEATURE_PVLOCK_KICK/KVM_CAP_PVLOCK_KICK.
>>
>> Qemu needs a corresponding patch to pass up the presence of this feature to
>> guest via cpuid. Patch to qemu will be sent separately.
>>
>> Signed-off-by: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>> Signed-off-by: Suzuki Poulose<suzuki@in.ibm.com>
>> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>> ---
>> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
>> index 734c376..7a94987 100644
>> --- a/arch/x86/include/asm/kvm_para.h
>> +++ b/arch/x86/include/asm/kvm_para.h
>> @@ -16,12 +16,14 @@
>> #define KVM_FEATURE_CLOCKSOURCE		0
>> #define KVM_FEATURE_NOP_IO_DELAY	1
>> #define KVM_FEATURE_MMU_OP		2
>> +
>> /* This indicates that the new set of kvmclock msrs
>>   * are available. The use of 0x11 and 0x12 is deprecated
>>   */
>> #define KVM_FEATURE_CLOCKSOURCE2        3
>> #define KVM_FEATURE_ASYNC_PF		4
>> #define KVM_FEATURE_STEAL_TIME		5
>> +#define KVM_FEATURE_PVLOCK_KICK		6
>>
>> /* The last 8 bits are used to indicate how to interpret the flags field
>>   * in pvclock structure. If no bits are set, all flags are ignored.
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 4c938da..c7b05fc 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2099,6 +2099,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>> 	case KVM_CAP_XSAVE:
>> 	case KVM_CAP_ASYNC_PF:
>> 	case KVM_CAP_GET_TSC_KHZ:
>> +	case KVM_CAP_PVLOCK_KICK:
>> 		r = 1;
>> 		break;
>> 	case KVM_CAP_COALESCED_MMIO:
>> @@ -2576,7 +2577,8 @@ static void do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>> 			     (1<<  KVM_FEATURE_NOP_IO_DELAY) |
>> 			     (1<<  KVM_FEATURE_CLOCKSOURCE2) |
>> 			     (1<<  KVM_FEATURE_ASYNC_PF) |
>> -			     (1<<  KVM_FEATURE_CLOCKSOURCE_STABLE_BIT);
>> +			     (1<<  KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
>> +			     (1<<  KVM_FEATURE_PVLOCK_KICK);
>>
>> 		if (sched_info_on())
>> 			entry->eax |= (1<<  KVM_FEATURE_STEAL_TIME);
>> @@ -5304,6 +5306,29 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>> 	return 1;
>> }
>>
>> +/*
>> + * kvm_pv_kick_cpu_op:  Kick a vcpu.
>> + *
>> + * @apicid - apicid of vcpu to be kicked.
>> + */
>> +static void kvm_pv_kick_cpu_op(struct kvm *kvm, int apicid)
>> +{
>> +	struct kvm_vcpu *vcpu = NULL;
>> +	int i;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		if (!kvm_apic_present(vcpu))
>> +			continue;
>> +
>> +		if (kvm_apic_match_dest(vcpu, 0, 0, apicid, 0))
>> +			break;
>> +	}
>> +	if (vcpu) {
>> +		kvm_make_request(KVM_REQ_PVLOCK_KICK, vcpu);
>> +		kvm_vcpu_kick(vcpu);
>> +	}
>> +}
>> +
>> int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>> {
>> 	unsigned long nr, a0, a1, a2, a3, ret;
>> @@ -5340,6 +5365,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>> 	case KVM_HC_MMU_OP:
>> 		r = kvm_pv_mmu_op(vcpu, a0, hc_gpa(vcpu, a1, a2),&ret);
>> 		break;
>> +	case KVM_HC_KICK_CPU:
>> +		kvm_pv_kick_cpu_op(vcpu->kvm, a0);
>> +		ret = 0;
>> +		break;
>> 	default:
>> 		ret = -KVM_ENOSYS;
>> 		break;
>> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
>> index 68e67e5..63fb6b0 100644
>> --- a/include/linux/kvm.h
>> +++ b/include/linux/kvm.h
>> @@ -558,6 +558,7 @@ struct kvm_ppc_pvinfo {
>> #define KVM_CAP_PPC_PAPR 68
>> #define KVM_CAP_S390_GMAP 71
>> #define KVM_CAP_TSC_DEADLINE_TIMER 72
>> +#define KVM_CAP_PVLOCK_KICK 73
>>
>> #ifdef KVM_CAP_IRQ_ROUTING
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index d526231..3b1ae7b 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -50,6 +50,7 @@
>> #define KVM_REQ_APF_HALT          12
>> #define KVM_REQ_STEAL_UPDATE      13
>> #define KVM_REQ_NMI               14
>> +#define KVM_REQ_PVLOCK_KICK       15
>
> Everything I see in this patch is pvlock agnostic. It's only a vcpu kick hypercall. So it's probably a good idea to also name it accordingly :).
>
>
> Alex
>
>

It was indeed KICK_VCPU in V4. But since we are currently dealing with
only pv locks it is renamed so.  But if we start using the code for
flush_tlb_others_ipi() optimization etc, it is good idea to rename
accordingly. OR even  go back to KICK_VCPU as used earlier..

  - Raghu
