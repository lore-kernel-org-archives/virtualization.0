From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 3/6] vDPA: implement IRQ offloading helpers in vDPA
 core
Date: Tue, 21 Jul 2020 10:51:44 +0800
Message-ID: <8d12231e-aabe-317e-0afb-d680b866304b@redhat.com>
References: <1594898629-18790-1-git-send-email-lingshan.zhu@intel.com>
 <1594898629-18790-4-git-send-email-lingshan.zhu@intel.com>
 <ab4644cc-9668-a909-4dea-5416aacf7221@redhat.com>
 <45b2cc93-6ae1-47c7-aae6-01afdab1094b@intel.com>
 <625c08af-a81f-d834-bb41-538c3dc9acb4@redhat.com>
 <8c9adead-d3a0-374e-e817-3cb5a44c4bda@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <8c9adead-d3a0-374e-e817-3cb5a44c4bda@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/21 上午10:02, Zhu, Lingshan wrote:
>
>
> On 7/20/2020 5:40 PM, Jason Wang wrote:
>>
>> On 2020/7/20 下午5:07, Zhu, Lingshan wrote:
>>>>>
>>>>> +}
>>>>> +
>>>>> +static void vdpa_unsetup_irq(struct vdpa_device *vdev, int qid)
>>>>> +{
>>>>> +    struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
>>>>> +
>>>>> +    if (drv->unsetup_vq_irq)
>>>>> +        drv->unsetup_vq_irq(vdev, qid);
>>>>
>>>>
>>>> Do you need to check the existence of drv before calling 
>>>> unset_vq_irq()?
>>> Yes, we should check this when we take the releasing path into account.
>>>>
>>>> And how can this synchronize with driver releasing and binding?
>>> Will add an vdpa_unsetup_irq() call in vhsot_vdpa_release().
>>> For binding, I think it is a new dev bound to the the driver,
>>> it should go through the vdpa_setup_irq() routine. or if it is
>>> a device re-bind to vhost_vdpa, I think we have cleaned up
>>> irq_bypass_producer for it as we would call vhdpa_unsetup_irq()
>>> in the release function.
>>
>>
>> I meant can the following things happen?
>>
>> 1) some vDPA device driver probe the hardware and call 
>> vdpa_request_irq() in its PCI probe function.
>> 2) vDPA device is probed by vhost-vDPA
>>
>> Then irq bypass can't work since we when vdpa_unsetup_irq() is 
>> called, there's no driver bound. Or is there a requirement that 
>> vdap_request/free_irq() must be called somewhere (e.g in the 
>> set_status bus operations)? If yes, we need document those requirements.
> vdpa_unseup_irq is only called when we want to unregister the producer,


Typo, I meant vdpa_setup_irq().

Thanks


>   now we have two code path using it: free_irq and relaase(). I agree we can document this requirements for the helpers, these functions can only be called through status changes(DRIVER_OK and !DRIVER_OK).
>
> Thanks,
> BR
> Zhu Lingshan
>>
>> Thanks
>>
