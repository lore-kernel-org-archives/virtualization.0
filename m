From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC V4 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Mon, 16 Jan 2012 04:23:24 +0100
Message-ID: <AD31813D-E4D5-43F3-B06A-9EB1B6FC9381@suse.de>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120114182710.8604.22277.sendpatchset@oc5400248562.ibm.com>
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


On 14.01.2012, at 19:27, Raghavendra K T wrote:

> Add Documentation on CPUID, KVM_CAP_PVLOCK_KICK, and Hypercalls supported.
> 
> KVM_HC_KICK_CPU  hypercall added to wakeup halted vcpu in
> paravirtual spinlock enabled guest.
> 
> KVM_FEATURE_PVLOCK_KICK enables guest to check whether pv spinlock can
> be enabled in guest. support in host is queried via
> ioctl(KVM_CHECK_EXTENSION, KVM_CAP_PVLOCK_KICK)
> 
> A minimal Documentation and template is added for hypercalls.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> ---
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index e2a4b52..1583bc7 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1109,6 +1109,13 @@ support.  Instead it is reported via
> if that returns true and you use KVM_CREATE_IRQCHIP, or if you emulate the
> feature in userspace, then you can enable the feature for KVM_SET_CPUID2.
> 
> +Paravirtualized ticket spinlocks can be enabled in guest by checking whether
> +support exists in host via,
> +
> +  ioctl(KVM_CHECK_EXTENSION, KVM_CAP_PVLOCK_KICK)
> +
> +if this call return true, guest can use the feature.
> +
> 4.47 KVM_PPC_GET_PVINFO
> 
> Capability: KVM_CAP_PPC_GET_PVINFO
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index 8820685..c7fc0da 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -39,6 +39,10 @@ KVM_FEATURE_CLOCKSOURCE2           ||     3 || kvmclock available at msrs
> KVM_FEATURE_ASYNC_PF               ||     4 || async pf can be enabled by
>                                    ||       || writing to msr 0x4b564d02
> ------------------------------------------------------------------------------
> +KVM_FEATURE_PVLOCK_KICK            ||     6 || guest checks this feature bit
> +                                   ||       || before enabling paravirtualized
> +                                   ||       || spinlock support.
> +------------------------------------------------------------------------------
> KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                    ||       || per-cpu warps are expected in
>                                    ||       || kvmclock.
> diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
> new file mode 100644
> index 0000000..7872da5
> --- /dev/null
> +++ b/Documentation/virtual/kvm/hypercalls.txt
> @@ -0,0 +1,54 @@
> +KVM Hypercalls Documentation
> +===========================
> +Template for documentation is
> +The documenenation for hypercalls should inlcude
> +1. Hypercall name, value.
> +2. Architecture(s)
> +3. Purpose
> +
> +
> +1. KVM_HC_VAPIC_POLL_IRQ
> +------------------------
> +value: 1
> +Architecture: x86
> +Purpose:
> +
> +2. KVM_HC_MMU_OP
> +------------------------
> +value: 2
> +Architecture: x86
> +Purpose: Support MMU operations such as writing to PTE,
> +flushing TLB, release PT.

This one is deprecated, no? Should probably be mentioned here.

> +
> +3. KVM_HC_FEATURES
> +------------------------
> +value: 3
> +Architecture: PPC
> +Purpose:

Expose hypercall availability to the guest. On x86 you use cpuid to enumerate which hypercalls are available. The natural fit on ppc would be device tree based lookup (which is also what EPAPR dictates), but we also have a second enumeration mechanism that's KVM specific - which is this hypercall.

> +
> +4. KVM_HC_PPC_MAP_MAGIC_PAGE
> +------------------------
> +value: 4
> +Architecture: PPC
> +Purpose: To enable communication between the hypervisor and guest there is a
> +new

It's not new anymore :)

> shared page that contains parts of supervisor visible register state.
> +The guest can map this shared page using this hypercall.

... to access its supervisor register through memory.

> +
> +5. KVM_HC_KICK_CPU
> +------------------------
> +value: 5
> +Architecture: x86
> +Purpose: Hypercall used to wakeup a vcpu from HLT state
> +
> +Usage example : A vcpu of a paravirtualized guest that is busywaiting in guest
> +kernel mode for an event to occur (ex: a spinlock to become available)
> +can execute HLT instruction once it has busy-waited for more than a
> +threshold time-interval. Execution of HLT instruction would cause
> +the hypervisor to put the vcpu to sleep (unless yield_on_hlt=0) until occurence
> +of an appropriate event. Another vcpu of the same guest can wakeup the sleeping
> +vcpu by issuing KVM_HC_KICK_CPU hypercall, specifying APIC ID of the vcpu to be
> +wokenup.

The description is way too specific. The hypercall basically gives the guest the ability to yield() its current vcpu to another chosen vcpu. The APIC piece is an implementation detail for x86. On PPC we could just use the PIR register contents (processor identifier).

Maybe I didn't fully understand what this really is about though :)


Alex
