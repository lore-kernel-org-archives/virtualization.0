From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack
 handling
Date: Mon, 07 Jul 2008 13:08:54 +0300
Message-ID: <4871EB36.5030003@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com> <1214571305-20701-2-git-send-email-amit.shah@qumranet.com> <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: kvm@vger.kernel.org, muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> This will be useful for acking irqs of assigned devices
>
>   

And also for improving time drift tracking.

Please make this more generic by having a list of callbacks.  There 
could also be just one list, rather than one for the ioapic and one for 
the pic as implemented now.

It may also make sense to filter the irq number before calling the 
callback rather than relying on the callback to ignore uninteresting irqs.

> Signed-off-by: Amit Shah <amit.shah@qumranet.com>
> ---
>  virt/kvm/ioapic.c |    3 +++
>  virt/kvm/ioapic.h |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/virt/kvm/ioapic.c b/virt/kvm/ioapic.c
> index 9d02136..6d99a35 100644
> --- a/virt/kvm/ioapic.c
> +++ b/virt/kvm/ioapic.c
> @@ -295,6 +295,9 @@ static void __kvm_ioapic_update_eoi(struct kvm_ioapic *ioapic, int gsi)
>  	ent->fields.remote_irr = 0;
>  	if (!ent->fields.mask && (ioapic->irr & (1 << gsi)))
>  		ioapic_deliver(ioapic, gsi);
> +
> +	if (ioapic->ack_notifier)
> +		ioapic->ack_notifier(ioapic->kvm, gsi);
>  }
>  
>  void kvm_ioapic_update_eoi(struct kvm *kvm, int vector)
> diff --git a/virt/kvm/ioapic.h b/virt/kvm/ioapic.h
> index 7f16675..a42743f 100644
> --- a/virt/kvm/ioapic.h
> +++ b/virt/kvm/ioapic.h
> @@ -58,6 +58,7 @@ struct kvm_ioapic {
>  	} redirtbl[IOAPIC_NUM_PINS];
>  	struct kvm_io_device dev;
>  	struct kvm *kvm;
> +	void (*ack_notifier)(void *opaque, int irq);
>  };
>  
>  #ifdef DEBUG
>   


-- 
error compiling committee.c: too many arguments to function

