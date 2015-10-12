From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] kvm/x86: Hyper-V synthetic interrupt controller
Date: Mon, 12 Oct 2015 09:54:41 +0200
Message-ID: <561B6741.8080309@de.ibm.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-2-git-send-email-den@openvz.org>
	<5617D259.8070101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5617D259.8070101@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Am 09.10.2015 um 16:42 schrieb Paolo Bonzini:
> Christian, the question for you is towards the end...



[....]
> 
>> --- a/virt/kvm/irqchip.c
>> +++ b/virt/kvm/irqchip.c
>> @@ -144,11 +144,13 @@ static int setup_routing_entry(struct kvm_irq_routing_table *rt,
>>  
>>  	/*
>>  	 * Do not allow GSI to be mapped to the same irqchip more than once.
>> -	 * Allow only one to one mapping between GSI and MSI.
>> +	 * Allow only one to one mapping between GSI and MSI/Hyper-V SINT.
>>  	 */
>>  	hlist_for_each_entry(ei, &rt->map[ue->gsi], link)
>>  		if (ei->type == KVM_IRQ_ROUTING_MSI ||
>>  		    ue->type == KVM_IRQ_ROUTING_MSI ||
>> +		    ei->type == KVM_IRQ_ROUTING_HV_SINT ||
>> +		    ue->type == KVM_IRQ_ROUTING_HV_SINT ||
>>  		    ue->u.irqchip.irqchip == ei->irqchip.irqchip)
>>  			return r;
> 
> Christian, what's the desired behavior for s390 adapter interrupts here?
>  Should this actually become
> 
> 	if (ei->type != KVM_IRQ_ROUTING_IRQCHIP ||
> 	    ue->type != KVM_IRQ_ROUTING_IRQCHIP ||
> 	    ue->u.irqchip.irqchip == ei->irqchip.irqchip)

Hmm, this is the failure path if we already have one routing entry, Right?
This will work with virtio ccw as we only setup one route, but I am not
sure about the upcoming PCI irqfd support which might add a 2nd adapter
route.

Adding Conny, Jens,Not sure about PC, 
As soon as we wire up the PCI irgfd, we want to register a 2nd route for
the same irqchip via flic, which will also be of type 
KVM_IRQ_ROUTING_S390_ADAPTER. Correct?
