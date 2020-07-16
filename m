From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/7] *** IRQ offloading for vDPA ***
Date: Thu, 16 Jul 2020 12:20:09 +0800
Message-ID: <67c4c41d-9e95-2270-4acb-6f04668c34fa@redhat.com>
References: <1594565524-3394-1-git-send-email-lingshan.zhu@intel.com>
 <70244d80-08a4-da91-3226-7bfd2019467e@redhat.com>
 <97032c51-3265-c94a-9ce1-f42fcc6d3075@intel.com>
 <77318609-85ef-f169-2a1e-500473976d84@redhat.com>
 <29ab6da8-ed8e-6b91-d658-f3d240543b29@intel.com>
 <1e91d9dd-d787-beff-2c14-9c76ffc3b285@redhat.com>
 <a319cba3-8b3d-8968-0fb7-48a1d34042bf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <a319cba3-8b3d-8968-0fb7-48a1d34042bf@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, alex williamson <alex.williamson@redhat.com>, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, dan daly <dan.daly@intel.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/16 下午12:13, Zhu, Lingshan wrote:
>
>
> On 7/16/2020 12:02 PM, Jason Wang wrote:
>>
>> On 2020/7/16 上午11:59, Zhu, Lingshan wrote:
>>>
>>> On 7/16/2020 10:59 AM, Jason Wang wrote:
>>>>
>>>> On 2020/7/16 上午9:39, Zhu, Lingshan wrote:
>>>>>
>>>>>
>>>>> On 7/15/2020 9:43 PM, Jason Wang wrote:
>>>>>>
>>>>>> On 2020/7/12 下午10:52, Zhu Lingshan wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> This series intends to implement IRQ offloading for
>>>>>>> vhost_vdpa.
>>>>>>>
>>>>>>> By the feat of irq forwarding facilities like posted
>>>>>>> interrupt on X86, irq bypass can  help deliver
>>>>>>> interrupts to vCPU directly.
>>>>>>>
>>>>>>> vDPA devices have dedicated hardware backends like VFIO
>>>>>>> pass-throughed devices. So it would be possible to setup
>>>>>>> irq offloading(irq bypass) for vDPA devices and gain
>>>>>>> performance improvements.
>>>>>>>
>>>>>>> In my testing, with this feature, we can save 0.1ms
>>>>>>> in a ping between two VFs on average.
>>>>>>
>>>>>>
>>>>>> Hi Lingshan:
>>>>>>
>>>>>> During the virtio-networking meeting, Michael spots two possible 
>>>>>> issues:
>>>>>>
>>>>>> 1) do we need an new uAPI to stop the irq offloading?
>>>>>> 2) can interrupt lost during the eventfd ctx?
>>>>>>
>>>>>> For 1) I think we probably not, we can allocate an independent 
>>>>>> eventfd which does not map to MSIX. So the consumer can't match 
>>>>>> the producer and we fallback to eventfd based irq.
>>>>> Hi Jason,
>>>>>
>>>>> I wonder why we need to stop irq offloading, but if we need to do 
>>>>> so, maybe a new uAPI would be more intuitive to me,
>>>>> but why and who(user? qemu?) shall initialize this process, based 
>>>>> on what kinda of basis to make the decision?
>>>>
>>>>
>>>> The reason is we may want to fallback to software datapath for some 
>>>> reason (e.g software assisted live migration). In this case we need 
>>>> intercept device write to used ring so we can not offloading 
>>>> virtqueue interrupt in this case.
>>> so add a VHOST_VDPA_STOP_IRQ_OFFLOADING? Then do we need a 
>>> VHOST_VDPA_START_IRQ_OFFLOADING, then let userspace fully control 
>>> this? Or any better approaches? 
>>
>>
>> Probably not, it's as simple as allocating another eventfd (but not 
>> irqfd), and pass it to vhost-vdpa. Then the offloading is disabled 
>> since it doesn't have a consumer.
> OK, sounds like QEMU work, no need to take care in this series, right?


That's my understanding.

Thanks


>
> Thanks,
> BR
> Zhu Lingshan
>>
>> Thanks
>>
>>
