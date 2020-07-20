From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 2/6] kvm: detect assigned device via irqbypass manager
Date: Mon, 20 Jul 2020 12:19:37 +0800
Message-ID: <c46dc561-610e-e992-8bb9-e7286a560971@redhat.com>
References: <1594898629-18790-1-git-send-email-lingshan.zhu@intel.com>
 <1594898629-18790-3-git-send-email-lingshan.zhu@intel.com>
 <20200717120821.3c2a56db@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200717120821.3c2a56db@x1.home>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/18 上午2:08, Alex Williamson wrote:
> On Thu, 16 Jul 2020 19:23:45 +0800
> Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
>> vDPA devices has dedicated backed hardware like
>> passthrough-ed devices. Then it is possible to setup irq
>> offloading to vCPU for vDPA devices. Thus this patch tries to
>> manipulated assigned device counters via irqbypass manager.
>>
>> We will increase/decrease the assigned device counter in kvm/x86.
>> Both vDPA and VFIO would go through this code path.
>>
>> This code path only affect x86 for now.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   arch/x86/kvm/x86.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 00c88c2..20c07d3 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -10624,11 +10624,17 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
>>   {
>>   	struct kvm_kernel_irqfd *irqfd =
>>   		container_of(cons, struct kvm_kernel_irqfd, consumer);
>> +	int ret;
>>   
>>   	irqfd->producer = prod;
>> +	kvm_arch_start_assignment(irqfd->kvm);
>> +	ret = kvm_x86_ops.update_pi_irte(irqfd->kvm,
>> +					 prod->irq, irqfd->gsi, 1);
>> +
>> +	if (ret)
>> +		kvm_arch_end_assignment(irqfd->kvm);
>>   
>> -	return kvm_x86_ops.update_pi_irte(irqfd->kvm,
>> -					   prod->irq, irqfd->gsi, 1);
>> +	return ret;
>>   }
>>   
>>   void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
>
> Why isn't there a matching end-assignment in the del_producer path?  It
> seems this only goes one-way, what happens when a device is
> hot-unplugged from the VM or the device interrupt configuration changes.
> This will still break vfio if it's not guaranteed to be symmetric.
> Thanks,
>
> Alex


Yes, we need add logic in the del_producer path.

Thanks
