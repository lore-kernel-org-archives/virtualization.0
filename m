From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Sun, 01 Apr 2012 16:53:19 +0300
Message-ID: <4F785DCF.7020809@redhat.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F707C5F.1000905@redhat.com>	<4F716E31.3000803@linux.vnet.ibm.com>
	<CAMy5W3foop40+R1RLv_JPhnO5ZmV90uMmNERYY-e3QCeaJfqLw@mail.gmail.com>
	<4F73568D.7000703@linux.vnet.ibm.com> <4F743247.5080407@redhat.com>
	<4F74A405.2040609@linux.vnet.ibm.com>
	<4F7585EE.7060203@linux.vnet.ibm.com> <4F7855A1.80107@redhat.com>
	<4F785CC9.7070204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F785CC9.7070204@linux.vnet.ibm.com>
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
Cc: KVM <kvm@vger.kernel.org>, Alan Meadows <alan.meadows@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/01/2012 04:48 PM, Raghavendra K T wrote:
>>> I have patch something like below in mind to try:
>>>
>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> index d3b98b1..5127668 100644
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -1608,15 +1608,18 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>>>        * else and called schedule in __vcpu_run.  Hopefully that
>>>        * VCPU is holding the lock that we need and will release it.
>>>        * We approximate round-robin by starting at the last boosted
>>> VCPU.
>>> +     * Priority is given to vcpu that are unhalted.
>>>        */
>>> -    for (pass = 0; pass<  2&&  !yielded; pass++) {
>>> +    for (pass = 0; pass<  3&&  !yielded; pass++) {
>>>           kvm_for_each_vcpu(i, vcpu, kvm) {
>>>               struct task_struct *task = NULL;
>>>               struct pid *pid;
>>> -            if (!pass&&  i<  last_boosted_vcpu) {
>>> +            if (!pass&&  !vcpu->pv_unhalted)
>>> +                continue;
>>> +            else if (pass == 1&&  i<  last_boosted_vcpu) {
>>>                   i = last_boosted_vcpu;
>>>                   continue;
>>> -            } else if (pass&&  i>  last_boosted_vcpu)
>>> +            } else if (pass == 2&&  i>  last_boosted_vcpu)
>>>                   break;
>>>               if (vcpu == me)
>>>                   continue;
>>>
>>
>> Actually I think this is unneeded.  The loops tries to find vcpus that
>> are runnable but not running (vcpu_active(vcpu->wq)), and halted vcpus
>> don't match this condition.
>>
>
>
> I almost agree. But at corner of my thought,
>
> Suppose there are 8 vcpus runnable out of which 4 of them are kicked
> but not running, making yield_to those 4 vcpus would result in better
> lock progress. no?

That's what the code does.

>   I still have little problem getting PLE setup, here (instead
> rebasing patches).
> Once I get PLE to get that running, and numbers prove no improvement,
> I will drop this idea.
>

I'm interested in how PLE does vs. your patches, both with PLE enabled
and disabled.

-- 
error compiling committee.c: too many arguments to function
