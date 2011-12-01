From: Raghavendra K T <raghukt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 2/4] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Fri, 02 Dec 2011 01:20:29 +0530
Message-ID: <4ED7DA85.5080504__15474.6969267309$1322811753$gmane$org@linux.vnet.ibm.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130085959.23386.69166.sendpatchset@oc5400248562.ibm.com>
	<4ED760F1.6080804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED760F1.6080804@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki
List-Id: virtualization@lists.linuxfoundation.org

[ CCing Jeremy's new email ID ]
Hi Avi,
Thanks for review and inputs.

On 12/01/2011 04:41 PM, Avi Kivity wrote:
> On 11/30/2011 10:59 AM, Raghavendra K T wrote:
>
> The hypercall needs to be documented in
> Documentation/virtual/kvm/hypercalls.txt.
>

Yes, Sure 'll document.  hypercalls.txt is a new file right?. also I 
have to document APIs in Documentation/virtual/kvm/api.txt.

> Have you tested it on AMD machines?  There are some differences in the
> hypercall infrastructure there.

Yes. 'll test on AMD machine and update on that.

>
>>   /* This indicates that the new set of kvmclock msrs
>>    * are available. The use of 0x11 and 0x12 is deprecated
>>    */
>>   #define KVM_FEATURE_CLOCKSOURCE2        3
>>   #define KVM_FEATURE_ASYNC_PF		4
>>   #define KVM_FEATURE_STEAL_TIME		5
>> +#define KVM_FEATURE_KICK_VCPU		6
>
> Documentation/virtual/kvm/cpuid.txt.

Yes. 'll do that.

>
>>
>>   /* The last 8 bits are used to indicate how to interpret the flags field
>>    * in pvclock structure. If no bits are set, all flags are ignored.
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index c38efd7..6e1c8b4 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2103,6 +2103,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>>   	case KVM_CAP_XSAVE:
>>   	case KVM_CAP_ASYNC_PF:
>>   	case KVM_CAP_GET_TSC_KHZ:
>> +	case KVM_CAP_KICK_VCPU:
>
> This is redundant with the feature bit?  In general, KVM_CAP is for the
> host API, while KVM_FEATURE is for the guest API.
>

No its not. I have to check the flow again. I understood that this 
completes the guest querying, that checks for KVM_FEATURE availability.
Did I miss something? I need a little deep dive though.

>>
>> +/*
>> + * kvm_pv_kick_cpu_op:  Kick a vcpu.
>> + *
>> + * @cpu - vcpu to be kicked.
>> + */
>> +static void kvm_pv_kick_cpu_op(struct kvm *kvm, int cpu)
>> +{
>> +	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, cpu);
>
> There is no guarantee that guest cpu numbers match host vcpu numbers.
> Use APIC IDs, and kvm_apic_match_dest().

Okay. I have to dig more on this.

>
>> +	struct kvm_mp_state mp_state;
>> +
>> +	mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
>> +	if (vcpu) {
>> +		vcpu->kicked = 1;
>> +		/* Ensure kicked is always set before wakeup */
>> +		barrier();
>> +	}
>> +	kvm_arch_vcpu_ioctl_set_mpstate(vcpu,&mp_state);
>
> This must only be called from the vcpu thread.

Hmm. Okay. 'll check this.

>
>> +	kvm_vcpu_kick(vcpu);
>> +}
>> +
>>
>>   	struct kvm_vcpu_arch arch;
>> +
>> +	/*
>> +	 * blocked vcpu wakes up by checking this flag set by unlocker.
>> +	 */
>> +	int kicked;
>>
>
> Write only variable.

Yes 'll remove comments.

>
> An alternative approach is to use an MSR protocol like x2apic ICR.
>

'll explore on this too.
