From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 4/4] KVM/vmx: enable lbr for the guest
Date: Tue, 26 Sep 2017 16:56:43 +0800
Message-ID: <59CA164B.1080707@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
	<20170925145720.GM4311@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170925145720.GM4311@tassilo.jf.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@linux.intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/25/2017 10:57 PM, Andi Kleen wrote:
>> +static void auto_switch_lbr_msrs(struct vcpu_vmx *vmx)
>> +{
>> +	int i;
>> +	struct perf_lbr_stack lbr_stack;
>> +
>> +	perf_get_lbr_stack(&lbr_stack);
>> +
>> +	add_atomic_switch_msr(vmx, MSR_LBR_SELECT, 0, 0);
>> +	add_atomic_switch_msr(vmx, lbr_stack.lbr_tos, 0, 0);
>> +
>> +	for (i = 0; i < lbr_stack.lbr_nr; i++) {
>> +		add_atomic_switch_msr(vmx, lbr_stack.lbr_from + i, 0, 0);
>> +		add_atomic_switch_msr(vmx, lbr_stack.lbr_to + i, 0, 0);
>> +		if (lbr_stack.lbr_info)
>> +			add_atomic_switch_msr(vmx, lbr_stack.lbr_info + i, 0,
>> +					      0);
>> +	}
> That will be really expensive and add a lot of overhead to every entry/exit.
> perf can already context switch the LBRs on task context switch. With that
> you can just switch LBR_SELECT, which is *much* cheaper because there
> are far less context switches than exit/entries.
>
> It implies that when KVM is running it needs to prevent perf from enabling
> LBRs in the context of KVM, but that should be straight forward.

I kind of have a different thought here:

1) vCPU context switching and guest side task switching are not identical.
That is, when the vCPU is scheduled out, the guest task on the vCPU may not
run out its time slice yet, so the task will continue to run when the 
vCPU is
scheduled in by the host (lbr wasn't save by the guest task when the vCPU is
scheduled out in this case).

It is possible to have the vCPU which runs the guest task (in use of 
lbr) scheduled
out, followed by a new host task being scheduled in on the pCPU to run.
It is not guaranteed that the new host task does not use the LBR feature 
on the
pCPU.

2) Sometimes, people may want this usage: "perf record -b 
./qemu-system-x86_64 ...",
which will need lbr to be used in KVM as well.


I think one possible optimization we could do would be to add the LBR 
MSRs to auto
switching when the guest requests to enable the feature, and remove them 
when
being disabled. This will need to trap guest access to MSR_DEBUGCTL.


Best,
Wei
