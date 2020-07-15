From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/7] virtio_vdpa: init IRQ offloading function pointers to
 NULL.
Date: Wed, 15 Jul 2020 16:43:05 +0800
Message-ID: <d5b12368-7d78-6c0b-e593-289594d11985@redhat.com>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-5-git-send-email-lingshan.zhu@intel.com>
 <276bf939-8e12-e28a-64f7-1767851e0db5@redhat.com>
 <ba1ea94c-b0ae-8bd8-8425-64b096512d3d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ba1ea94c-b0ae-8bd8-8425-64b096512d3d@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/13 下午6:20, Zhu, Lingshan wrote:
>
>
> On 7/13/2020 4:28 PM, Jason Wang wrote:
>>
>> On 2020/7/12 下午10:49, Zhu Lingshan wrote:
>>> This commit initialize IRQ offloading function pointers in
>>> virtio_vdpa_driver to NULL. Becasue irq offloading only focus
>>> on VMs for vhost_vdpa.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>>   drivers/virtio/virtio_vdpa.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_vdpa.c 
>>> b/drivers/virtio/virtio_vdpa.c
>>> index c30eb55..1e8acb9 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -386,6 +386,8 @@ static void virtio_vdpa_remove(struct 
>>> vdpa_device *vdpa)
>>>       },
>>>       .probe    = virtio_vdpa_probe,
>>>       .remove = virtio_vdpa_remove,
>>> +    .setup_vq_irq = NULL,
>>> +    .unsetup_vq_irq = NULL,
>>>   };
>>
>>
>> Is this really needed consider the it's static?
>>
>> Thanks
> This is for readability, to show they are NULL, so virtio_vdpa would not go through irq forwarding / offloading.
>
> Does this make sense?


Probably not, please refer what is done by other subsystems.

Thanks


>
> Thanks,
> BR
> Zhu Lingshan
>>
>>
>>> module_vdpa_driver(virtio_vdpa_driver);
>>
