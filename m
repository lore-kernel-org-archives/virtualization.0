From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 2/11] x86/ticketlock: don't inline _spin_unlock
	when using paravirt spinlocks
Date: Thu, 22 Mar 2012 15:36:42 +0530
Message-ID: <4F6AF9B2.4070207__46640.9704684795$1332413065$gmane$org@linux.vnet.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<20120321102107.473.89777.sendpatchset@codeblue.in.ibm.com>
	<CA+55aFzJn_U=2-kxGX15v6zLaCV+Jgtxjop2PudizzsqSn+nLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFzJn_U=2-kxGX15v6zLaCV+Jgtxjop2PudizzsqSn+nLg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/21/2012 10:43 PM, Linus Torvalds wrote:
> On Wed, Mar 21, 2012 at 3:21 AM, Raghavendra K T
> <raghavendra.kt@linux.vnet.ibm.com>  wrote:
>> From: Jeremy Fitzhardinge<jeremy.fitzhardinge@citrix.com>
>>
>> The code size expands somewhat, and its probably better to just call
>> a function rather than inline it.
>>
>> Signed-off-by: Jeremy Fitzhardinge<jeremy.fitzhardinge@citrix.com>
>> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/x86/Kconfig     |    3 +++
>>   kernel/Kconfig.locks |    2 +-
>>   2 files changed, 4 insertions(+), 1 deletions(-)
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5bed94e..10c28ec 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -623,6 +623,9 @@ config PARAVIRT_SPINLOCKS
>>
>>           If you are unsure how to answer this question, answer N.
>>
>> +config ARCH_NOINLINE_SPIN_UNLOCK
>> +       def_bool PARAVIRT_SPINLOCKS
>> +
>>   config PARAVIRT_CLOCK
>>         bool
>>
>> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
>> index 5068e2a..584637b 100644
>> --- a/kernel/Kconfig.locks
>> +++ b/kernel/Kconfig.locks
>> @@ -125,7 +125,7 @@ config INLINE_SPIN_LOCK_IRQSAVE
>>                  ARCH_INLINE_SPIN_LOCK_IRQSAVE
>>
>>   config INLINE_SPIN_UNLOCK
>> -       def_bool !DEBUG_SPINLOCK&&  (!PREEMPT || ARCH_INLINE_SPIN_UNLOCK)
>> +       def_bool !DEBUG_SPINLOCK&&  (!PREEMPT || ARCH_INLINE_SPIN_UNLOCK)&&  !ARCH_NOINLINE_SPIN_UNLOCK
>>
>>   config INLINE_SPIN_UNLOCK_BH
>>         def_bool !DEBUG_SPINLOCK&&  ARCH_INLINE_SPIN_UNLOCK_BH
>
> Ugh. This is getting really ugly.
>

Agree that it had become longer.

> Can we just fix it by
>   - getting rid of INLINE_SPIN_UNLOCK entirely
>
>   - replacing it with UNINLINE_SPIN_UNLOCK instead with the reverse
> meaning, and no "def_bool" at all, just a simple
>
>          config UNINLINE_SPIN_UNLOCK
>                  bool
>
>   - make the various people who want to uninline the spinlocks (like
> spinlock debugging, paravirt etc) all just do
>
>          select UNINLINE_SPIN_UNLOCK

I just posted  https://lkml.org/lkml/2012/3/22/94. Please let me know
if that looks better.
And this patch should now become something like
---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5bed94e..2666b7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -613,6 +613,7 @@ config PARAVIRT
  config PARAVIRT_SPINLOCKS
	 bool "Paravirtualization layer for spinlocks"
	 depends on PARAVIRT && SMP && EXPERIMENTAL
+	 select UNINLINE_SPIN_UNLOCK
	 ---help---
	   Paravirtualized spinlocks allow a pvops backend to replace the
	   spinlock implementation with something virtualization-friendly
