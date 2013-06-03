From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V9 18/19] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Mon, 3 Jun 2013 12:04:16 -0400
Message-ID: <20130603160416.GH4224@phenom.dumpdata.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130601192624.5966.97025.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130601192624.5966.97025.sendpatchset@codeblue>
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
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 02, 2013 at 12:56:24AM +0530, Raghavendra K T wrote:
> Documentation/kvm : Add documentation on Hypercalls and features used for PV spinlock
> 
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> 
> KVM_HC_KICK_CPU  hypercall added to wakeup halted vcpu in paravirtual spinlock
> enabled guest.
> 
> KVM_FEATURE_PV_UNHALT enables guest to check whether pv spinlock can be enabled
> in guest.
> 
> Thanks Vatsa for rewriting KVM_HC_KICK_CPU
> 
> Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  Documentation/virtual/kvm/cpuid.txt      |    4 ++++
>  Documentation/virtual/kvm/hypercalls.txt |   13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index 83afe65..654f43c 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -43,6 +43,10 @@ KVM_FEATURE_CLOCKSOURCE2           ||     3 || kvmclock available at msrs
>  KVM_FEATURE_ASYNC_PF               ||     4 || async pf can be enabled by
>                                     ||       || writing to msr 0x4b564d02
>  ------------------------------------------------------------------------------
> +KVM_FEATURE_PV_UNHALT              ||     6 || guest checks this feature bit
> +                                   ||       || before enabling paravirtualized
> +                                   ||       || spinlock support.
> +------------------------------------------------------------------------------
>  KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                     ||       || per-cpu warps are expected in
>                                     ||       || kvmclock.
> diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
> index ea113b5..2a4da11 100644
> --- a/Documentation/virtual/kvm/hypercalls.txt
> +++ b/Documentation/virtual/kvm/hypercalls.txt
> @@ -64,3 +64,16 @@ Purpose: To enable communication between the hypervisor and guest there is a
>  shared page that contains parts of supervisor visible register state.
>  The guest can map this shared page to access its supervisor register through
>  memory using this hypercall.
> +
> +5. KVM_HC_KICK_CPU
> +------------------------
> +Architecture: x86
> +Status: active
> +Purpose: Hypercall used to wakeup a vcpu from HLT state
> +Usage example : A vcpu of a paravirtualized guest that is busywaiting in guest
> +kernel mode for an event to occur (ex: a spinlock to become available) can
> +execute HLT instruction once it has busy-waited for more than a threshold
> +time-interval. Execution of HLT instruction would cause the hypervisor to put
> +the vcpu to sleep until occurence of an appropriate event. Another vcpu of the
> +same guest can wakeup the sleeping vcpu by issuing KVM_HC_KICK_CPU hypercall,
> +specifying APIC ID of the vcpu to be wokenup.

woken up.
> 
