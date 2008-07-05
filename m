From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 1/4] KVM: Introduce kvm_set_irq to inject interrupts in
 guests
Date: Sat, 05 Jul 2008 14:05:20 +0300
Message-ID: <486F5570.8010500@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com> <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: kvm@vger.kernel.org, muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> This function injects an interrupt into the guest given the kvm struct,
> the (guest) irq number and the interrupt level.
>
> Signed-off-by: Amit Shah <amit.shah@qumranet.com>
> ---
>  arch/x86/kvm/irq.c |   11 +++++++++++
>  arch/x86/kvm/irq.h |    2 ++
>  2 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 76d736b..0d9e552 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -100,3 +100,14 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
>  	__kvm_migrate_apic_timer(vcpu);
>  	__kvm_migrate_pit_timer(vcpu);
>  }
> +
> +/* This should be called with the kvm->lock mutex held */
> +void kvm_set_irq(struct kvm *kvm, int irq, int level)
> +{
> +	/* Not possible to detect if the guest uses the PIC or the
> +	 * IOAPIC.  So set the bit in both. The guest will ignore
> +	 * writes to the unused one.
> +	 */
> +	kvm_ioapic_set_irq(kvm->arch.vioapic, irq, level);
> +	kvm_pic_set_irq(pic_irqchip(kvm), irq, level);
> +}
>   

pic supports only irqs 0-15.

I guess instead of adding the check here, better move it into i8259.c 
and ioapic.c.


-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.

