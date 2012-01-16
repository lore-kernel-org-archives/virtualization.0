From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Mon, 16 Jan 2012 11:26:54 +0100
Message-ID: <A65A7F2B-4C08-4437-87D2-FB978F541DE9@suse.de>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
	<AD31813D-E4D5-43F3-B06A-9EB1B6FC9381@suse.de>
	<4F13E36B.9020408@linux.vnet.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F13E36B.9020408@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux>
List-Id: virtualization@lists.linuxfoundation.org


On 16.01.2012, at 09:44, Raghavendra K T wrote:

> On 01/16/2012 08:53 AM, Alexander Graf wrote:
>> 
>> On 14.01.2012, at 19:27, Raghavendra K T wrote:
>> 
>>> Add Documentation on CPUID, KVM_CAP_PVLOCK_KICK, and Hypercalls supported.
>>> 
>>> KVM_HC_KICK_CPU  hypercall added to wakeup halted vcpu in
>>> paravirtual spinlock enabled guest.
>>> 
>>> KVM_FEATURE_PVLOCK_KICK enables guest to check whether pv spinlock can
>>> be enabled in guest. support in host is queried via
>>> ioctl(KVM_CHECK_EXTENSION, KVM_CAP_PVLOCK_KICK)
>>> 
>>> A minimal Documentation and template is added for hypercalls.
>>> 
>>> Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>>> Signed-off-by: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>>> ---
> [...]
>>> diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
>>> new file mode 100644
>>> index 0000000..7872da5
>>> --- /dev/null
>>> +++ b/Documentation/virtual/kvm/hypercalls.txt
>>> @@ -0,0 +1,54 @@
>>> +KVM Hypercalls Documentation
>>> +===========================
> 
>>> +2. KVM_HC_MMU_OP
>>> +------------------------
>>> +value: 2
>>> +Architecture: x86
>>> +Purpose: Support MMU operations such as writing to PTE,
>>> +flushing TLB, release PT.
>> 
>> This one is deprecated, no? Should probably be mentioned here.
> 
> Ok, then may be adding state = deprecated/obsolete/in use (active) may
> be good idea.
> 
>> 
>>> +
>>> +3. KVM_HC_FEATURES
>>> +------------------------
>>> +value: 3
>>> +Architecture: PPC
>>> +Purpose:
>> 
>> Expose hypercall availability to the guest. On x86 you use cpuid to enumerate which hypercalls are available. The natural fit on ppc would be device tree based lookup (which is also what EPAPR dictates), but we also have a second enumeration mechanism that's KVM specific - which is this hypercall.
>> 
> 
> Thanks, will add this. I hope you are OK if I add Signed-off-by: you.

I don't think you need a signed-off-by from me for this very simple documentation addition :). You should probably also reword it. I didn't quite write it as a paragraph that should go into the file.


Alex
