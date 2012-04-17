From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V5 2/6] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Tue, 17 Apr 2012 09:19:01 +0530
Message-ID: <4F8CE82D.80503__45733.9425026023$1334634567$gmane$org@linux.vnet.ibm.com>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
	<20120323080701.14568.97779.sendpatchset@codeblue>
	<20120412000629.GA32051@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412000629.GA32051@amt.cnet>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, X86 <x86@kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org


Sorry for late reply,
was on vacation for a week (without IMAP access :( )

On 04/12/2012 05:36 AM, Marcelo Tosatti wrote:
> On Fri, Mar 23, 2012 at 01:37:04PM +0530, Raghavendra K T wrote:
>> From: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
[snip]
>> @@ -1567,6 +1568,9 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>   		prepare_to_wait(&vcpu->wq,&wait, TASK_INTERRUPTIBLE);
>>
>>   		if (kvm_arch_vcpu_runnable(vcpu)) {
>> +			vcpu->pv_unhalted = 0;
>> +			/* preventing reordering should be enough here */
>> +			barrier();
>
> Is it always OK to erase the notification, even in case an unrelated
> event such as interrupt was the source of wakeup?


Erasing notification is not good, But I think in this case,

kvm_make_request(KVM_REQ_UNHALT, vcpu);

below this would take care of the rest.

>
> It would be easier to verify that notifications are not lost with atomic
>
> test_and_clear(pv_unhalted).

true, I 'll verify that (with pv_unhalt as atomic variable). my heart
says  current code is just fine, since we are about to unblock.

>
> Also x86 specific code should remain in arch/x86/kvm/
>

I agree. 'll have clear function in arch/x86/kvm and add stub to rest
of the archs

>
