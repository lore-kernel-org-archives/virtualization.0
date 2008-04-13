From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 2/2] KVM: Handle interrupts for PCI passthrough
	devices
Date: Sun, 13 Apr 2008 11:36:27 +0300
Message-ID: <4801C60B.3050401__39520.2165040702$1208075893$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>	<1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-3-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1207817334-31775-3-git-send-email-amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, virtualization@lists.linux-foundation.org, gcosta@redhat.com, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> Passthrough devices are host machine PCI devices which have
> been handed off to the guest. Handle interrupts from these
> devices and route them to the appropriate guest irq lines.
> The userspace provides us with the necessary information
> via the ioctls.
>
> The guest IRQ numbers can change dynamically, so we have an
> additional ioctl that keeps track of those changes in userspace
> and notifies us whenever that happens.
>
> It is expected the kernel driver for the passthrough device
> is removed before passing it on to the guest.
>
>  
> +/*
> + * Used to find a registered host PCI device (a "passthrough" device)
> + * during interrupts or EOI
> + */
> +static struct kvm_pci_pt_dev_list *
> +find_pci_pt_dev(struct list_head *head,
> +		struct kvm_pci_pt_info *pv_pci_info, int irq, int source)
> +{
> +	struct list_head *ptr;
> +	struct kvm_pci_pt_dev_list *match;
> +
> +	list_for_each(ptr, head) {
> +		match = list_entry(ptr, struct kvm_pci_pt_dev_list, list);
> +
> +		switch (source) {
> +		case KVM_PT_SOURCE_IRQ:
> +			/*
> +			 * Used to find a registered host device
> +			 * during interrupt context on host
> +			 */
> +			if (match->pt_dev.host.irq == irq)
> +				return match;
> +			break;
> +		case KVM_PT_SOURCE_IRQ_ACK:
> +			/*
> +			 * Used to find a registered host device when
> +			 * the guest acks an interrupt
> +			 */
> +			if (match->pt_dev.guest.irq == irq)
> +				return match;
> +			break;
> +		}
> +	}
> +	return NULL;
> +}
>   

This would be better as two separate functions.  Also, locking?

> +
> +static DECLARE_BITMAP(pt_irq_pending, NR_IRQS);
> +static DECLARE_BITMAP(pt_irq_handled, NR_IRQS);
> +
> +/* FIXME: Implement the OR logic needed to make shared interrupts on
> + * this line behave properly
> + */
> +static irqreturn_t
> +kvm_pci_pt_dev_intr(int irq, void *dev_id)
>   

Please don't split declarations unnecessarily.

> +{
> +	struct kvm_pci_pt_dev_list *match;
> +	struct kvm *kvm = (struct kvm *) dev_id;
> +
> +	if (!test_bit(irq, pt_irq_handled))
> +		return IRQ_NONE;
> +
> +	if (test_bit(irq, pt_irq_pending))
> +		return IRQ_HANDLED;
>   

Will the interrupt not fire immediately after this returns?

> +
> +	match = find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL,
> +				irq, KVM_PT_SOURCE_IRQ);
> +	if (!match)
> +		return IRQ_NONE;
> +
> +	/* Not possible to detect if the guest uses the PIC or the
> +	 * IOAPIC.  So set the bit in both. The guest will ignore
> +	 * writes to the unused one.
> +	 */
> +	kvm_ioapic_set_irq(kvm->arch.vioapic, match->pt_dev.guest.irq, 1);
> +	kvm_pic_set_irq(pic_irqchip(kvm), match->pt_dev.guest.irq, 1);
>   

A function that calls both the apic and the pic is better, as it will be 
easier to port.

> +	set_bit(irq, pt_irq_pending);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Ack the irq line for a passthrough device */
> +void
> +kvm_pci_pt_ack_irq(struct kvm *kvm, int vector)
> +{
> +	int irq;
> +	struct kvm_pci_pt_dev_list *match;
> +
> +	irq = get_eoi_gsi(kvm->arch.vioapic, vector);
> +	match = find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL,
> +				irq, KVM_PT_SOURCE_IRQ_ACK);
> +	if (!match)
> +		return;
> +	if (test_bit(match->pt_dev.host.irq, pt_irq_pending)) {
> +		kvm_ioapic_set_irq(kvm->arch.vioapic, irq, 0);
> +		kvm_pic_set_irq(pic_irqchip(kvm), irq, 0);
>   

This is dangerous with smp guests, if we aren't careful with the 
ordering the interrupt may fire again and be forwarded to the other 
vcpu.  We need to call this before we redeliver interrupts.

> +		clear_bit(match->pt_dev.host.irq, pt_irq_pending);
> +	}
> +}
> +
> +static int
> +kvm_vm_ioctl_pci_pt_dev(struct kvm *kvm,
> +			struct kvm_pci_passthrough_dev *pci_pt_dev)
> +{
> +	int r = 0;
> +	struct kvm_pci_pt_dev_list *match;
> +
> +	if (irqchip_in_kernel(kvm)) {
> +		/* Has this been added already? */
> +		if (find_pci_pt_dev(&kvm->arch.pci_pt_dev_head,
> +				    NULL, pci_pt_dev->host.irq,
> +				    KVM_PT_SOURCE_IRQ))
> +			goto out;
> +
> +		match = kzalloc(sizeof(struct kvm_pci_pt_dev_list), GFP_KERNEL);
> +		if (match == NULL) {
> +			printk(KERN_INFO "%s: Couldn't allocate memory\n",
> +			       __FUNCTION__);
> +			r = -ENOMEM;
> +			goto out;
> +		}
> +
> +		match->pt_dev.guest.irq   = pci_pt_dev->guest.irq;
> +		match->pt_dev.host.irq    = pci_pt_dev->host.irq;
> +
> +		if (request_irq(pci_pt_dev->host.irq, kvm_pci_pt_dev_intr,
> +				IRQF_SHARED, "kvm_pv_device", (void *)kvm)) {
> +			printk(KERN_INFO "%s: couldn't allocate irq for pv "
> +			       "device\n", __FUNCTION__);
> +			r = -EIO;
> +			goto out_free;
> +		}
> +		set_bit(pci_pt_dev->host.irq, pt_irq_handled);
> +		list_add(&match->list, &kvm->arch.pci_pt_dev_head);
> +	}
> + out:
> +	return r;
> + out_free:
> +	kfree(match);
> +	goto out;
> +}
>   

Locking?

> @@ -1671,6 +1836,30 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		r = 0;
>  		break;
>  	}
> +	case KVM_ASSIGN_PCI_PT_DEV: {
> +		struct kvm_pci_passthrough_dev pci_pt_dev;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&pci_pt_dev, argp, sizeof pci_pt_dev))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_pci_pt_dev(kvm, &pci_pt_dev);
> +		if (r)
> +			goto out;
> +		break;
> +	}
> +	case KVM_UPDATE_PCI_PT_IRQ: {
> +		struct kvm_pci_passthrough_dev pci_pt_dev;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&pci_pt_dev, argp, sizeof pci_pt_dev))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_pci_pt_irq(kvm, &pci_pt_dev);
> +		if (r)
> +			goto out;
> +		break;
> +	}
>   

Could these not be merged?

> diff --git a/include/asm-x86/kvm_host.h b/include/asm-x86/kvm_host.h
> index 781fc87..c4eb804 100644
> --- a/include/asm-x86/kvm_host.h
> +++ b/include/asm-x86/kvm_host.h
> @@ -296,6 +296,18 @@ struct kvm_mem_alias {
>  	gfn_t target_gfn;
>  };
>  
> +/* Some definitions for passthrough'ed devices */
>   

"passthrough'ed" and especially "pt" are awkward.  How about "assigned"?

> +#define KVM_PT_SOURCE_IRQ	1
> +#define KVM_PT_SOURCE_IRQ_ACK	2
> +
> +/* This list is to store the guest bus:device:function and host
> + * bus:device:function mapping for passthrough'ed devices.
> + */
>   

?


-- 
error compiling committee.c: too many arguments to function
