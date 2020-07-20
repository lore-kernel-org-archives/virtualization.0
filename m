From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 2/6] kvm: detect assigned device via irqbypass manager
Date: Mon, 20 Jul 2020 15:40:46 +0800
Message-ID: <d58a86b7-b7de-65d8-dbd8-174c4f305d8f@intel.com>
References: <1594898629-18790-1-git-send-email-lingshan.zhu@intel.com>
 <1594898629-18790-3-git-send-email-lingshan.zhu@intel.com>
 <f8e0ced4-2883-e022-8fd0-1224987ebef1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <f8e0ced4-2883-e022-8fd0-1224987ebef1@redhat.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 7/17/2020 12:01 PM, Jason Wang wrote:
>
> On 2020/7/16 下午7:23, Zhu Lingshan wrote:
>> vDPA devices has dedicated backed hardware like
>> passthrough-ed devices. Then it is possible to setup irq
>> offloading to vCPU for vDPA devices. Thus this patch tries to
>> manipulated assigned device counters via irqbypass manager.
>
>
> This part needs some tweak, e.g why assigned device could be detected 
> through this way.
>
>
>>
>> We will increase/decrease the assigned device counter in kvm/x86.
>
>
> And you need explain why we don't need similar thing in other arch.
>
> Thanks
OK Thanks!
>
>
>> Both vDPA and VFIO would go through this code path.
>>
>> This code path only affect x86 for now.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   arch/x86/kvm/x86.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 00c88c2..20c07d3 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -10624,11 +10624,17 @@ int kvm_arch_irq_bypass_add_producer(struct 
>> irq_bypass_consumer *cons,
>>   {
>>       struct kvm_kernel_irqfd *irqfd =
>>           container_of(cons, struct kvm_kernel_irqfd, consumer);
>> +    int ret;
>>         irqfd->producer = prod;
>> +    kvm_arch_start_assignment(irqfd->kvm);
>> +    ret = kvm_x86_ops.update_pi_irte(irqfd->kvm,
>> +                     prod->irq, irqfd->gsi, 1);
>> +
>> +    if (ret)
>> +        kvm_arch_end_assignment(irqfd->kvm);
>>   -    return kvm_x86_ops.update_pi_irte(irqfd->kvm,
>> -                       prod->irq, irqfd->gsi, 1);
>> +    return ret;
>>   }
>>     void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer 
>> *cons,
>
