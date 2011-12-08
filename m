From: Raghavendra K T <raghukt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V3 2/4] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Thu, 08 Dec 2011 23:05:04 +0530
Message-ID: <4EE0F548.8050006@linux.vnet.ibm.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130085959.23386.69166.sendpatchset@oc5400248562.ibm.com>
	<4ED760F1.6080804@redhat.com> <4ED7DA85.5080504@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED7DA85.5080504@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghukt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

On 12/02/2011 01:20 AM, Raghavendra K T wrote:
>>>
>>> +/*
>>> + * kvm_pv_kick_cpu_op: Kick a vcpu.
>>> + *
>>> + * @cpu - vcpu to be kicked.
>>> + */
>>> +static void kvm_pv_kick_cpu_op(struct kvm *kvm, int cpu)
>>> +{
>>> + struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, cpu);
>>
>> There is no guarantee that guest cpu numbers match host vcpu numbers.
>> Use APIC IDs, and kvm_apic_match_dest().
>
> Okay. I have to dig more on this.
>
Sorry for late reply on this, was experimenting with the changes needed.

Wanted to confirm if it is according to your expectation.

  Host side change should look like this to get vcpu,

	int i;
	struct kvm_vcpu *vcpu = NULL;

	kvm_for_each_vcpu(i, vcpu, kvm) {
		if (!kvm_apic_present(vcpu))
		continue;

		if (kvm_apic_match_dest(vcpu, 0, 0, cpu, 0)) {
		break;
		}
	}


In guest side, convert the cpu to apicid using,

apicid = apic->cpu_present_to_apicid(cpu);
OR
apicid =  per_cpu(x86_cpu_to_apicid, cpu);

But I have a question, as you know, we are storing the waiting cpus in
cpumask, to track the cpu to be kicked.

You want to change the logic to store the apicid directly instead of
cpu during contention or is it OK to convert before kick hypercall?.

Probably it would be more good if I can get to know the scenario,
where guest cpu numbers does not match host vcpu numbers. It may answer 
the whole question and help me in testing/validating the code.

Thanks
- Raghu
