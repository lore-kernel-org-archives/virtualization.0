From: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Mon, 12 Oct 2015 16:46:17 +0300
Message-ID: <561BB9A9.2070102@openvz.org>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
	<561BB8D2.60402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <561BB8D2.60402@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Blake <eblake@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/12/2015 04:42 PM, Eric Blake wrote:
> On 10/09/2015 07:39 AM, Denis V. Lunev wrote:
>> From: Andrey Smetanin <asmetanin@virtuozzo.com>
>>
>> A new vcpu exit is introduced to notify the userspace of the
>> changes in Hyper-V synic configuraion triggered by guest writing to the
> s/configuraion/configuration/
> Is 'synic' intended?  Is it short for something (if so, spelling it out
> may help)?
>
>
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -3331,6 +3331,12 @@ the userspace IOAPIC should process the EOI and retrigger the interrupt if
>>   it is still asserted.  Vector is the LAPIC interrupt vector for which the
>>   EOI was received.
>>   
>> +		/* KVM_EXIT_HYPERV */
>> +                struct kvm_hyperv_exit hyperv;
>> +Indicates that the VCPU's exits into userspace to process some tasks
> s/VCPU's/VCPU/
>
>> +related with Hyper-V emulation. Currently used to synchronize modified
>> +Hyper-V synic state with userspace.
> Again, is 'synic' intended?  Hmm, I see it throughout the patch, so it
> looks intentional, but I keep trying to read it as a typo for 'sync'.
>
this is not a typo :)

this is an abbreviation for synthetic interrupt controller,
pls compare with this

./arch/x86/include/uapi/asm/hyperv.h: * Basic SynIC MSRs 
(HV_X64_MSR_SCONTROL through HV_X64_MSR_EOM

Though there is some sense in the question itself. I think
that it would be better to keep naming it SynIC as
in the original kernel code.

Den
