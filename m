Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A313B7B3
	for <virtualization@lists.linux.dev>; Tue, 18 Feb 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843354; cv=none; b=VtEvVKiUtBNXa3FjnjzwM0If8uqFnxlM8xF6bqbmjFdUqODaRO2MN5P49tn4daJtPSvUIh+NeY7zr6yg/f8jhtkaKpharZXEUqd/IwR2ovE4Ozkk4UpRtOVKyrBwe1V1hB5JSKNp6WZIntUgibB/NNYtAiouDf3vZARQ7fHcOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843354; c=relaxed/simple;
	bh=JM41Lnt2JV7bMGjF0Re7Z/qqFKUo0zm6S2LI5DBPSyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBOlvFLUCmbH26Nu4P2qXyGh7vKmp3x70rQ/AYfU/5lI19mJ9IsCwluwbvSbd/ItG2BTiT8kZzcq1IOHFxPAV5ugWiOM1VbUNGSgLXZDEBasxBuF9jG68GMGwm3UD5wNCr8o2g+LPN7rruTD6RSB5C70BaeFVpggXFFWWLB/RAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqqyp40f; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqqyp40f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739843352; x=1771379352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JM41Lnt2JV7bMGjF0Re7Z/qqFKUo0zm6S2LI5DBPSyU=;
  b=kqqyp40fy/CrsZ53YMlk1oEI82aEGy/VPRByzLwpvudkF55fU1q4yXLo
   9YVimHus6PQSFvE0dbZ6dZ/6hYtGbWpvIwbAaVRmN/4AwGFAoiib39I+m
   dsR1a1s1ZqBA8pxJ1x3lyTVGspGyq1/yTRq1cegsmOC2SVwttgQyTcmKm
   1rAmTfVNPBECkPkFb7uJOWzpWougMbBJ+z1ZmqpLhiXZSS52WLnBrG5GK
   pM+WbHA0hJ+F9EhxzyszU69ndpdmNN9oRoN0dr/L/RHRqba1a+FfKSiFx
   Zmz9twVUqbk6cZnXgeM37N28RV1v7uUbPse2iDzX816YL4p+/nQeJQe6q
   A==;
X-CSE-ConnectionGUID: lALkWb5wSualnwVrAatOoQ==
X-CSE-MsgGUID: PoupQVD0SBW+RieuEB4BFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40650059"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="40650059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 17:49:12 -0800
X-CSE-ConnectionGUID: ZqKvHF9cTK+RDVMycVTkcw==
X-CSE-MsgGUID: p2qvXF2HTNSvmDpiH1XTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="151449221"
Received: from unknown (HELO [10.238.0.67]) ([10.238.0.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 17:49:09 -0800
Message-ID: <4eba9bf7-4619-444e-9c6d-4fc28eebe8f3@linux.intel.com>
Date: Tue, 18 Feb 2025 09:49:06 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
 <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
 <ee89c12c-a252-4c6d-a062-4fb57f2c85a9@linux.intel.com>
 <20250217191103-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <20250217191103-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/18 8:12, Michael S. Tsirkin wrote:
> On Tue, Feb 18, 2025 at 07:57:23AM +0800, Ning, Hongyu wrote:
>>
>>
>> On 2025/2/17 17:25, Eric Auger wrote:
>>> Hi Michael, Hongyu,
>>>
>>> On 2/14/25 1:16 PM, Michael S. Tsirkin wrote:
>>>> On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/2/6 16:59, Eric Auger wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 2/4/25 12:46 PM, Eric Auger wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>>>>>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>>>>>>>> Hi Kirill, Michael
>>>>>>>>>>
>>>>>>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>>>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>>>>>>>> accesses during the hang.
>>>>>>>>>>>
>>>>>>>>>>>       Invalid read at addr 0x102877002, size 2, region '(null)',
>>>>>>>>>>> reason: rejected
>>>>>>>>>>>       Invalid write at addr 0x102877A44, size 2, region '(null)',
>>>>>>>>>>> reason: rejected
>>>>>>>>>>>       ...
>>>>>>>>>>>
>>>>>>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
>>>>>>>>>>> console
>>>>>>>>>>> is not in use.
>>>>>>>>>>>
>>>>>>>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>>>>>>>> underlying virtio-pci device is removed.
>>>>>>>>>>>
>>>>>>>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>>>>>>>> bus shutdown.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>>>>>>>
>>>>>>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>>>>>>>
>>>>>>>>>> I think this fix is really needed. I have another test case with a
>>>>>>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>>>>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>>>>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>>>>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>>>>>>>
>>>>>>>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>>>>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>>>>>>>> iommu shutdown.
>>>>>>>>>>
>>>>>>>>>> With that fix, the above test case is fixed and I do not see spurious
>>>>>>>>>> vhost IOTLB miss spurious requests.
>>>>>>>>>>
>>>>>>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>>>>>>>> IOTLB callbacks when IOMMU gets disabled,
>>>>>>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
>>>>>>>>>> eric.auger@redhat.com/)
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>>
>>>>>>>>>> Eric
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>     drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>>>>>>     1 file changed, 10 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>>>>>>> --- a/drivers/virtio/virtio.c
>>>>>>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>>>>>>         of_node_put(dev->dev.of_node);
>>>>>>>>>>>     }
>>>>>>>>>>>     +static void virtio_dev_shutdown(struct device *_d)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (drv && drv->remove)
>>>>>>>>>>> +        drv->remove(dev);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I am concerned that full remove is a heavyweight operation.
>>>>>>>>> Do not want to slow down reboots even more.
>>>>>>>>> How about just doing a reset, instead?
>>>>>>>>
>>>>>>>> I tested with
>>>>>>>>
>>>>>>>> static void virtio_dev_shutdown(struct device *_d)
>>>>>>>> {
>>>>>>>>            struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>>>
>>>>>>>>            virtio_reset_device(dev);
>>>>>>>> }
>>>>>>>>
>>>>>>>>
>>>>>>>> and it fixes my issue.
>>>>>>>>
>>>>>>>> Kirill, would that fix you issue too?
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> sorry for my late response, I synced with Kirill offline and did a retest.
>>>>>>
>>>>>> The issue is still reproduced on my side, kexec will be stuck in case of
>>>>>> "console=hvc0" append in kernel cmdline and even with such patch applied.
>>>>>
>>>>> Thanks for testing!
>>>>>
>>>>> Michael, it looks like the initial patch from Kyrill is the one that
>>>>> fixes both issues. virtio_reset_device() usage does not work for the
>>>>> initial bug report while it works for me. Other ideas?
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>
>>>> Ah, wait a second.
>>>>
>>>> Looks like virtio-console continues to write to the MMIO even after
>>>> underlying virtio-pci device is removed.
>>>>
>>>> Hmm. I am not sure why that is a problem, but I assume some hypervisors just
>>>> hang the system if you try to kick them after reset.
>>>> Unfortunate that spec did not disallow it.
>>>>
>>>> If we want to prevent that, we want to do something like this:
>>>>
>>>>
>>>> 	/*
>>>> 	 * Some devices get wedged if you kick them after they are
>>>> 	 * reset. Mark all vqs as broken to make sure we don't.
>>>> 	 */
>>>>           virtio_break_device(dev);
>>>>           /*
>>>>            * The below virtio_synchronize_cbs() guarantees that any
>>>>            * interrupt for this line arriving after
>>>>            * virtio_synchronize_vqs() has completed is guaranteed to see
>>>>            * vq->broken as true.
>>>>            */
>>>>           virtio_synchronize_cbs(dev);
>>>>           dev->config->reset(dev);
>>>>
>>>>
>>>> I assume this still works for you, yes?
>>> Would that still been done in the virtio_dev_shutdown()?
>>>
>>> Is that what you tested Hongyu?
>>
>> Hi Eric,
>>
>> my patch applied based on Michael's comments:
>>
>> ---
>>   drivers/virtio/virtio.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index ba37665188b5..458dc28be060 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -395,6 +395,25 @@ static const struct cpumask
>> *virtio_irq_get_affinity(struct device *_d,
>>          return dev->config->get_vq_affinity(dev, irq_vec);
>>   }
>>
>> +static void virtio_dev_shutdown(struct device *_d)
>> +{
>> +        struct virtio_device *dev = dev_to_virtio(_d);
>> +        /*
>> +         * Some devices get wedged if you kick them after they are
>> +         * reset. Mark all vqs as broken to make sure we don't.
>> +         */
>> +        virtio_break_device(dev);
>> +        /*
>> +         * The below virtio_synchronize_cbs() guarantees that any
>> +         * interrupt for this line arriving after
>> +         * virtio_synchronize_vqs() has completed is guaranteed to see
>> +         * vq->broken as true.
>> +         */
>> +        virtio_synchronize_cbs(dev);
>> +        dev->config->reset(dev);
>> +       //virtio_reset_device(dev);
>> +}
>> +
>>   static const struct bus_type virtio_bus = {
>>          .name  = "virtio",
>>          .match = virtio_dev_match,
>> @@ -403,6 +422,7 @@ static const struct bus_type virtio_bus = {
>>          .probe = virtio_dev_probe,
>>          .remove = virtio_dev_remove,
>>          .irq_get_affinity = virtio_irq_get_affinity,
>> +       .shutdown = virtio_dev_shutdown,
>>   };
>>
>>   int __register_virtio_driver(struct virtio_driver *driver, struct module
>> *owner)
>> --
>> 2.43.0
> 
> 
> 
> yes, that's the patch. Does it work for you? Addresses the
> problem? If yes I'll repost.
> 

yes, issue fixed on my side. Thanks.

>>
>>>
>>> Eric
>>>>
>>>>
>>>>
>>>>>>
>>>>>> my kernel code base is 6.14.0-rc2.
>>>>>>
>>>>>> let me know if any more experiments needed.
>>>>>>
>>>>>> ---
>>>>>>    drivers/virtio/virtio.c | 8 ++++++++
>>>>>>    1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>> index ba37665188b5..f9f885d04763 100644
>>>>>> --- a/drivers/virtio/virtio.c
>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>> @@ -395,6 +395,13 @@ static const struct cpumask
>>>>>> *virtio_irq_get_affinity(struct device *_d,
>>>>>>           return dev->config->get_vq_affinity(dev, irq_vec);
>>>>>>    }
>>>>>>
>>>>>> +static void virtio_dev_shutdown(struct device *_d)
>>>>>> +{
>>>>>> +        struct virtio_device *dev = dev_to_virtio(_d);
>>>>>> +
>>>>>> +        virtio_reset_device(dev);
>>>>>> +}
>>>>>> +
>>>>>>    static const struct bus_type virtio_bus = {
>>>>>>           .name  = "virtio",
>>>>>>           .match = virtio_dev_match,
>>>>>> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
>>>>>>           .probe = virtio_dev_probe,
>>>>>>           .remove = virtio_dev_remove,
>>>>>>           .irq_get_affinity = virtio_irq_get_affinity,
>>>>>> +       .shutdown = virtio_dev_shutdown,
>>>>>>    };
>>>>>>
>>>>>>    int __register_virtio_driver(struct virtio_driver *driver, struct
>>>>>> module *owner)
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>>>
>>>>>>> gentle ping.
>>>>>>>
>>>>>>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
>>>>>>> the above addition I get rid of spurious warning in qemu on guest reboot.
>>>>>>>
>>>>>>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
>>>>>>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
>>>>>>> argument (22)
>>>>>>>
>>>>>>> Would you mind if I respin?
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Eric
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Eric
>>>>>>>>>
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>     static const struct bus_type virtio_bus = {
>>>>>>>>>>>         .name  = "virtio",
>>>>>>>>>>>         .match = virtio_dev_match,
>>>>>>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>>>>>>>         .uevent = virtio_uevent,
>>>>>>>>>>>         .probe = virtio_dev_probe,
>>>>>>>>>>>         .remove = virtio_dev_remove,
>>>>>>>>>>> +    .shutdown = virtio_dev_shutdown,
>>>>>>>>>>>     };
>>>>>>>>>>>       int __register_virtio_driver(struct virtio_driver *driver,
>>>>>>>>>>> struct module *owner)
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>
>>>
> 
> 

