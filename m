From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 17/17] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Wed, 30 May 2012 19:14:56 +0530
Message-ID: <4FC62458.7030802@linux.vnet.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120502100947.13206.26518.sendpatchset@codeblue.in.ibm.com>
	<4FC60A71.5050804@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FC60A71.5050804@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, Andi Kleen <andi@firstfloor.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, X86 <x86@kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/30/2012 05:24 PM, Jan Kiszka wrote:
> On 2012-05-02 12:09, Raghavendra K T wrote:
>> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>>
>> KVM_HC_KICK_CPU  hypercall added to wakeup halted vcpu in paravirtual spinlock
>> enabled guest.
>>
>> KVM_FEATURE_PV_UNHALT enables guest to check whether pv spinlock can be enabled
>> in guest.
>>
>> Thanks Alex for KVM_HC_FEATURES inputs and Vatsa for rewriting KVM_HC_KICK_CPU
>
> This contains valuable documentation for features that are already
> supported. Can you break them out and post as separate patch already?
> One comment on them below.
>

That sounds like a good idea. Sure, will do that.

>>
>> Signed-off-by: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   Documentation/virtual/kvm/cpuid.txt      |    4 ++
>>   Documentation/virtual/kvm/hypercalls.txt |   60 ++++++++++++++++++++++++++++++
>>   2 files changed, 64 insertions(+), 0 deletions(-)
>> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
>> index 8820685..062dff9 100644
>> --- a/Documentation/virtual/kvm/cpuid.txt
>> +++ b/Documentation/virtual/kvm/cpuid.txt
>> @@ -39,6 +39,10 @@ KVM_FEATURE_CLOCKSOURCE2           ||     3 || kvmclock available at msrs
>>   KVM_FEATURE_ASYNC_PF               ||     4 || async pf can be enabled by
>>                                      ||       || writing to msr 0x4b564d02
>>   ------------------------------------------------------------------------------
>> +KVM_FEATURE_PV_UNHALT              ||     6 || guest checks this feature bit
>> +                                   ||       || before enabling paravirtualized
>> +                                   ||       || spinlock support.
>> +------------------------------------------------------------------------------
>>   KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>>                                      ||       || per-cpu warps are expected in
>>                                      ||       || kvmclock.
>> diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
>> new file mode 100644
>> index 0000000..bc3f14a
>> --- /dev/null
>> +++ b/Documentation/virtual/kvm/hypercalls.txt
>> @@ -0,0 +1,60 @@
>> +KVM Hypercalls Documentation
>> +===========================
>> +The template for each hypercall is:
>> +1. Hypercall name, value.
>> +2. Architecture(s)
>> +3. Status (deprecated, obsolete, active)
>> +4. Purpose
>> +
>> +1. KVM_HC_VAPIC_POLL_IRQ
>> +------------------------
>> +Value: 1
>> +Architecture: x86
>> +Purpose: None
>
> Purpose: Trigger guest exit so that the host can check for pending
> interrupts on reentry.

will add fold this and resend.

[...]
