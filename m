From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 4/5] kvm : pv-ticketlocks support for linux guests
	running on KVM hypervisor
Date: Wed, 25 Jan 2012 00:31:45 +0530
Message-ID: <4F1F0019.2010601@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<20120114182645.8604.68884.sendpatchset@oc5400248562.ibm.com>
	<20120117110210.GA17420@amt.cnet>
	<4F15C48F.1000000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F15C48F.1000000@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>, Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/18/2012 12:27 AM, Raghavendra K T wrote:
> On 01/17/2012 04:32 PM, Marcelo Tosatti wrote:
>> On Sat, Jan 14, 2012 at 11:56:46PM +0530, Raghavendra K T wrote:
[...]
>>> + || (vcpu->requests& ~(1UL<<KVM_REQ_PVLOCK_KICK))
>>> + || need_resched() || signal_pending(current)) {
>>> vcpu->mode = OUTSIDE_GUEST_MODE;
>>> smp_wmb();
>>> local_irq_enable();
>>> @@ -6711,6 +6712,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
>>> !vcpu->arch.apf.halted)
>>> || !list_empty_careful(&vcpu->async_pf.done)
>>> || vcpu->arch.mp_state == KVM_MP_STATE_SIPI_RECEIVED
>>> + || kvm_check_request(KVM_REQ_PVLOCK_KICK, vcpu)
>>
>> The bit should only be read here (kvm_arch_vcpu_runnable), but cleared
>> on vcpu entry (along with the other kvm_check_request processing).
>>
[...]
>
> I had tried alternative approach earlier, I think that is closer
> to your expectation.
>
> where
> - flag is read in kvm_arch_vcpu_runnable
> - flag cleared in vcpu entry along with others.
>
> But it needs per vcpu flag to remember that pv_unhalted while clearing
> the flag in vcpu enter [ patch below ]. Could not find third alternative
> though.
[...]
> do you think having pv_unhalt flag in below patch cause problem to
> live migration still? (vcpu->request bit is retained as is) OR do we
> have to have KVM_GET_MP_STATE changes also with below patch you
> mentioned earlier.
>

Avi, Marcello, Please let me know, any comments you have on how should
it look like in next version?
Should I get rid of KVM_REQ_PVLOCK_KICK bit in vcpu->request and have
only pv_unahlt flag as below and also add MSR as suggested?

> ---8<---
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c38efd7..1bf8fa8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5684,6 +5717,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> r = 1;
> goto out;
> }
> + if (kvm_check_request(KVM_REQ_PVKICK, vcpu)) {
> + vcpu->pv_unhalted = 1;
> + r = 1;
> + goto out;
> + }
> if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
> record_steal_time(vcpu);
> if (kvm_check_request(KVM_REQ_NMI, vcpu))
> @@ -6683,6 +6720,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
> !vcpu->arch.apf.halted)
> || !list_empty_careful(&vcpu->async_pf.done)
> || vcpu->arch.mp_state == KVM_MP_STATE_SIPI_RECEIVED
> + || (kvm_test_request(KVM_REQ_PVKICK, vcpu) || vcpu->pv_unhalted)
> || atomic_read(&vcpu->arch.nmi_queued) ||
> (kvm_arch_interrupt_allowed(vcpu) &&
> kvm_cpu_has_interrupt(vcpu));
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d526231..a48e0f2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -154,6 +155,8 @@ struct kvm_vcpu {
> #endif
>
> struct kvm_vcpu_arch arch;
> +
> + int pv_unhalted;
> };
>
> static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
> @@ -770,5 +773,12 @@ static inline bool kvm_check_request(int req,
> struct kvm_vcpu *vcpu)
> }
> }
>
> +static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
> +{
> + if (test_bit(req, &vcpu->requests))
> + return true;
> + else
> + return false;
> +}
> #endif
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d9cfb78..55c44a2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -226,6 +226,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm
> *kvm, unsigned id)
> vcpu->kvm = kvm;
> vcpu->vcpu_id = id;
> vcpu->pid = NULL;
> + vcpu->pv_unhalted = 0;
> init_waitqueue_head(&vcpu->wq);
> kvm_async_pf_vcpu_init(vcpu);
>
> @@ -1509,11 +1510,12 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
> void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> {
> DEFINE_WAIT(wait);
> for (;;) {
> prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
>
> if (kvm_arch_vcpu_runnable(vcpu)) {
> + vcpu->pv_unhalted = 0;
> kvm_make_request(KVM_REQ_UNHALT, vcpu);
> break;
> }
>
