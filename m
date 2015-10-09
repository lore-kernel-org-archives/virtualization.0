From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] kvm/x86: Hyper-V synthetic interrupt controller
Date: Fri, 9 Oct 2015 16:42:33 +0200
Message-ID: <5617D259.8070101@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-2-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444397988-20167-2-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Christian, the question for you is towards the end...

On 09/10/2015 15:39, Denis V. Lunev wrote:
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 62cf8c9..15c3c02 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -23,13 +23,265 @@
>  
>  #include "x86.h"
>  #include "lapic.h"
> +#include "ioapic.h"
>  #include "hyperv.h"
>  
>  #include <linux/kvm_host.h>
> +#include <asm/apicdef.h>
>  #include <trace/events/kvm.h>
>  
>  #include "trace.h"
>  
> +static inline u64 synic_read_sint(struct kvm_vcpu_hv_synic *synic, int sint)
> +{
> +	return atomic64_read(&synic->sint[sint]);
> +}
> +
> +static inline int synic_get_sint_vector(u64 sint_value)
> +{
> +	if (sint_value & HV_SYNIC_SINT_MASKED)
> +		return -1;
> +	return sint_value & HV_SYNIC_SINT_VECTOR_MASK;
> +}
> +
> +static bool synic_has_active_vector(struct kvm_vcpu_hv_synic *synic,
> +				    int vector, int sint_to_skip, int sint_mask)
> +{
> +	u64 sint_value;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
> +		if (i == sint_to_skip)
> +			continue;
> +		sint_value = synic_read_sint(synic, i);
> +		if ((synic_get_sint_vector(sint_value) == vector) &&
> +		    ((sint_mask == 0) || (sint_value & sint_mask)))

Coding style, no parentheses around && or ||:

		if (synic_get_sint_vector(sint_value) == vector &&
		    (sint_mask == 0 || sint_value & sint_mask)


> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint, u64 data)
> +{
> +	int vector;
> +
> +	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
> +	if (vector < 16)
> +		return 1;
> +	/*
> +	 * Guest may configure multiple SINTs to use the same vector, so
> +	 * we maintain a bitmap of vectors handled by synic, and a
> +	 * bitmap of vectors with auto-eoi behavoir.  The bitmaps are

Typo (behavior).

> +	 * updated here, and atomically queried on fast paths.
> +	 */
> +
> +	if (!(data & HV_SYNIC_SINT_MASKED)) {
> +		__set_bit(vector, synic->vec_bitmap);
> +		if (data & HV_SYNIC_SINT_AUTO_EOI)
> +			__set_bit(vector, synic->auto_eoi_bitmap);
> +	} else {
> +		if (!synic_has_active_vector(synic, vector, sint, 0))
> +			__clear_bit(vector, synic->vec_bitmap);
> +		if (!synic_has_active_vector(synic, vector, sint,
> +					     HV_SYNIC_SINT_AUTO_EOI))
> +			__clear_bit(vector, synic->auto_eoi_bitmap);

I think you could do the clears after the atomic64_set?  Then you do not
need anymore the third argument to synic_has_active_vector.  Actually I
think it's simpler if you just make two functions,
synic_is_vector_connected and synic_is_vector_auto_eoi.  There is some
code duplication, but the functions are trivial.

> @@ -123,6 +125,15 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>  	return kvm_irq_delivery_to_apic(kvm, NULL, &irq, NULL);
>  }
>  
> +int kvm_hv_set_sint(struct kvm_kernel_irq_routing_entry *e,
> +		    struct kvm *kvm, int irq_source_id, int level,
> +		    bool line_status)
> +{
> +	if (!level)
> +		return -1;
> +
> +	return kvm_hv_synic_set_irq(kvm, e->hv_sint.vcpu, e->hv_sint.sint);
> +}
>  
>  static int kvm_set_msi_inatomic(struct kvm_kernel_irq_routing_entry *e,
>  			 struct kvm *kvm)
> @@ -289,6 +300,11 @@ int kvm_set_routing_entry(struct kvm_kernel_irq_routing_entry *e,
>  		e->msi.address_hi = ue->u.msi.address_hi;
>  		e->msi.data = ue->u.msi.data;
>  		break;
> +	case KVM_IRQ_ROUTING_HV_SINT:
> +		e->set = kvm_hv_set_sint;
> +		e->hv_sint.vcpu = ue->u.hv_sint.vcpu;
> +		e->hv_sint.sint = ue->u.hv_sint.sint;
> +		break;
>  	default:
>  		goto out;
>  	}
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 944b38a..63edbec 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -41,6 +41,7 @@
>  #include "trace.h"
>  #include "x86.h"
>  #include "cpuid.h"
> +#include "hyperv.h"
>  
>  #ifndef CONFIG_X86_64
>  #define mod_64(x, y) ((x) - (y) * div64_u64(x, y))
> @@ -128,11 +129,6 @@ static inline int apic_enabled(struct kvm_lapic *apic)
>  	(LVT_MASK | APIC_MODE_MASK | APIC_INPUT_POLARITY | \
>  	 APIC_LVT_REMOTE_IRR | APIC_LVT_LEVEL_TRIGGER)
>  
> -static inline int kvm_apic_id(struct kvm_lapic *apic)
> -{
> -	return (kvm_apic_get_reg(apic, APIC_ID) >> 24) & 0xff;
> -}
> -
>  /* The logical map is definitely wrong if we have multiple
>   * modes at the same time.  (Physical map is always right.)
>   */
> @@ -972,6 +968,9 @@ static int apic_set_eoi(struct kvm_lapic *apic)
>  	apic_clear_isr(vector, apic);
>  	apic_update_ppr(apic);
>  
> +	if (test_bit(vector, vcpu_to_synic(apic->vcpu)->vec_bitmap))
> +		kvm_hv_synic_send_eoi(apic->vcpu, vector);
> +
>  	kvm_ioapic_send_eoi(apic, vector);
>  	kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
>  	return vector;

You need to add SYNIC vectors to the EOI exit bitmap, so that APICv
(Xeon E5 or higher, Ivy Bridge or newer) is handled correctly.  You also
need to check the auto EOI exit bitmap in __apic_accept_irq, and avoid
going through kvm_x86_ops->deliver_posted_interrupt for auto EOI
vectors.  Something like

	if (kvm_x86_ops->deliver_posted_interrupt &&
	    !test_bit(...))

in place of the existing "if (kvm_x86_ops->deliver_posted_interrupt)".

I really don't like this auto-EOI extension, but I guess that's the
spec. :( If it wasn't for it, you could do everything very easily in
userspace using Google's proposed MSR exit.

> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 3d70e36..3782636 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -63,9 +63,6 @@ enum hv_cpuid_function {
>  /* Define version of the synthetic interrupt controller. */
>  #define HV_SYNIC_VERSION		(1)
>  
> -/* Define the expected SynIC version. */
> -#define HV_SYNIC_VERSION_1		(0x1)
> -
>  /* Define synthetic interrupt controller message constants. */
>  #define HV_MESSAGE_SIZE			(256)
>  #define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
> @@ -105,8 +102,6 @@ enum hv_message_type {
>  	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005
>  };
>  
> -/* Define the number of synthetic interrupt sources. */
> -#define HV_SYNIC_SINT_COUNT		(16)
>  #define HV_SYNIC_STIMER_COUNT		(4)
>  
>  /* Define invalid partition identifier. */

Please make these changes to drivers/hv and the uapi/ headers a separate
patch.  I think the right header to move the constants to is not
include/uapi/linux/hyperv.h, but rather arch/x86/include/uapi/asm/hyperv.h.

> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index b637965..0d7b705 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -192,11 +192,19 @@ irqfd_wakeup(wait_queue_t *wait, unsigned mode, int sync, void *key)
>  			irq = irqfd->irq_entry;
>  		} while (read_seqcount_retry(&irqfd->irq_entry_sc, seq));
>  		/* An event has been signaled, inject an interrupt */
> -		if (irq.type == KVM_IRQ_ROUTING_MSI)
> +		switch (irq.type) {
> +		case KVM_IRQ_ROUTING_MSI:
>  			kvm_set_msi(&irq, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1,
>  					false);
> -		else
> +			break;
> +		case KVM_IRQ_ROUTING_HV_SINT:
> +			kvm_hv_set_sint(&irq, kvm, KVM_USERSPACE_IRQ_SOURCE_ID,
> +					1, false);
> +			break;
> +		default:
>  			schedule_work(&irqfd->inject);
> +			break;
> +		}

Please make a new function kvm_arch_set_irq.  The new function can
return true if the interrupt has been injected, and -EWOULDBLOCK if the
caller should call schedule_work().  The default implementation can be a
weak function in virt/kvm/eventfd.c.

> @@ -248,8 +256,9 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
>  
>  	e = entries;
>  	for (i = 0; i < n_entries; ++i, ++e) {
> -		/* Only fast-path MSI. */
> -		if (e->type == KVM_IRQ_ROUTING_MSI)
> +		/* Fast-path MSI and Hyper-V sint */
> +		if (e->type == KVM_IRQ_ROUTING_MSI ||
> +		    e->type == KVM_IRQ_ROUTING_HV_SINT)
>  			irqfd->irq_entry = *e;
>  	}

I think this "for" is unnecessary altogether.  Instead, we should do:

	if (n_entries == 1)
		irqfd->irq_entry = *e;
	else
		irqfd->irq_entry.type = 0;

Because any other value for irq_entry.type will just trigger
schedule_work(&irqfd->inject).  Please make it a separate patch, however.

> @@ -471,6 +480,24 @@ void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin)
>  	srcu_read_unlock(&kvm->irq_srcu, idx);
>  }
>  
> +void kvm_notify_acked_hv_sint(struct kvm_vcpu *vcpu, u32 sint)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_irq_ack_notifier *kian;
> +	int gsi, idx;
> +
> +	vcpu_debug(vcpu, "synic acked sint %d\n", sint);
> +
> +	idx = srcu_read_lock(&kvm->irq_srcu);
> +	gsi = kvm_hv_get_sint_gsi(vcpu, sint);
> +	if (gsi != -1)
> +		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
> +					 link)
> +			if (kian->gsi == gsi)
> +				kian->irq_acked(kian);
> +	srcu_read_unlock(&kvm->irq_srcu, idx);
> +}

Please move the hlist_for_each_entry_rcu to a new function
kvm_notify_acked_gsi.  kvm_notify_acked_irq can use the new function as
well.  Then this function can be moved to arch/x86/kvm/hyperv.c.

> +
>  void kvm_register_irq_ack_notifier(struct kvm *kvm,
>  				   struct kvm_irq_ack_notifier *kian)
>  {
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 716a1c4..1cf3d92 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -144,11 +144,13 @@ static int setup_routing_entry(struct kvm_irq_routing_table *rt,
>  
>  	/*
>  	 * Do not allow GSI to be mapped to the same irqchip more than once.
> -	 * Allow only one to one mapping between GSI and MSI.
> +	 * Allow only one to one mapping between GSI and MSI/Hyper-V SINT.
>  	 */
>  	hlist_for_each_entry(ei, &rt->map[ue->gsi], link)
>  		if (ei->type == KVM_IRQ_ROUTING_MSI ||
>  		    ue->type == KVM_IRQ_ROUTING_MSI ||
> +		    ei->type == KVM_IRQ_ROUTING_HV_SINT ||
> +		    ue->type == KVM_IRQ_ROUTING_HV_SINT ||
>  		    ue->u.irqchip.irqchip == ei->irqchip.irqchip)
>  			return r;

Christian, what's the desired behavior for s390 adapter interrupts here?
 Should this actually become

	if (ei->type != KVM_IRQ_ROUTING_IRQCHIP ||
	    ue->type != KVM_IRQ_ROUTING_IRQCHIP ||
	    ue->u.irqchip.irqchip == ei->irqchip.irqchip)

?  This would make sense, in that you shouldn't access "struct
kvm_irq_routing_irqchip" unless the type is set to
KVM_IRQ_ROUTING_IRQCHIP.  Again, separate patch please.

>  int kvm_set_irq_routing(struct kvm *kvm,
>  			const struct kvm_irq_routing_entry *ue,
>  			unsigned nr,
> @@ -219,6 +240,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  	old = kvm->irq_routing;
>  	rcu_assign_pointer(kvm->irq_routing, new);
>  	kvm_irq_routing_update(kvm);
> +	kvm_irq_update_hv_sint_gsi(kvm);

Please call this function kvm_arch_irq_routing_update, and (in a
separate patch) rename the existing kvm_arch_irq_routing_update to
kvm_arch_post_irq_routing_update.

Paolo
