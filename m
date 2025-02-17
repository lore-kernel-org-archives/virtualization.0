Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165271922F3
	for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778572; cv=none; b=Cveqk7SlDnwjfqKp1Wf4Bvh47dAeBgR9xlP0tEDRNY5QwnuAZQRwofdNCNyzr+SJgeyMOEcTLU43Pui1rxvrssj6SXHHj9LOY2ccYbFdlxL/RZaTL+6jiOGxkoRL43zjT5mRwYJ0an9cQyeA9+guu6ud0I1rpDHbwcJf4Et6oiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778572; c=relaxed/simple;
	bh=Barv0R6skxKOgnvpSlNtX+i7ynp/UPhYdbdccDez6dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3k8/oluBmaHK3vu4xKEJUKHswhz2c4J7nlqNeT1A47e9YJsqh2yahtPJyN3mDY8eOYYRBanbAXZjLGpBNQfxIcBOJqxsj0UG3s3f6T+CdXbspQVG4J9OCi7SrrlvAuywtanSS+Xyu8IMST8lC/KTzUkxej/gjgKjdU3mHVpYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObILUStk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObILUStk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739778571; x=1771314571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Barv0R6skxKOgnvpSlNtX+i7ynp/UPhYdbdccDez6dA=;
  b=ObILUStkjM1FLnzcBucGP8lUiFNJAES2uWLSfQ7XzVQ5ujB7ZwIS1usn
   dPQSAHRMmB352OaS2mkIr+YTSbarhmaoBJXJlEb6kmzCe2bDFygAOviVT
   RhiN8Zn41ShxLe+Jd2fQzOdPNCfHOUy2a1k4fctxtZk5fnnm52ybyJhbR
   WrVJC7V542qzikIB89UE4j+bcz0XimdB9qs3hCPV/hUKX6abB6IaCZhbY
   nXz4KaqbuVW6WAsccNrWDl1h9bp8Cu5GbiQC79GL0B8cy7Prf+VoL8vm8
   5tkzrQm9MkxFJVtrJWok5BOzZ5gjwjYSp0uYYisPbAwfZ3ibUxuzOIirG
   A==;
X-CSE-ConnectionGUID: F2gzqnlsQvKRnGFE1F9r9Q==
X-CSE-MsgGUID: nFgMMrNtRAqG0HEjVUULfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40317560"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40317560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 23:49:30 -0800
X-CSE-ConnectionGUID: ikWUSaFPSLGB1CfBiOaXkg==
X-CSE-MsgGUID: 7XEh/G06RpS3sq4pZnVn/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114938851"
Received: from unknown (HELO [10.238.0.67]) ([10.238.0.67])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 23:49:28 -0800
Message-ID: <882cf846-300c-4b9c-9e7b-4e1874542cf6@linux.intel.com>
Date: Mon, 17 Feb 2025 15:49:25 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
 <CACGkMEsejG=6nj0YY7Wfzd1YBihoqn10PnhHtsVVdEOfPsgwNQ@mail.gmail.com>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <CACGkMEsejG=6nj0YY7Wfzd1YBihoqn10PnhHtsVVdEOfPsgwNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/17 11:29, Jason Wang wrote:
> On Fri, Feb 14, 2025 at 8:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
>>> Hi,
>>>
>>> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
>>>>
>>>>
>>>> On 2025/2/6 16:59, Eric Auger wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/4/25 12:46 PM, Eric Auger wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>>>>>> Hi Kirill, Michael
>>>>>>>>
>>>>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>>>>>> accesses during the hang.
>>>>>>>>>
>>>>>>>>>      Invalid read at addr 0x102877002, size 2, region '(null)',
>>>>>>>>> reason: rejected
>>>>>>>>>      Invalid write at addr 0x102877A44, size 2, region '(null)',
>>>>>>>>> reason: rejected
>>>>>>>>>      ...
>>>>>>>>>
>>>>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
>>>>>>>>> console
>>>>>>>>> is not in use.
>>>>>>>>>
>>>>>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>>>>>> underlying virtio-pci device is removed.
>>>>>>>>>
>>>>>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>>>>>> bus shutdown.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>>>>>
>>>>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>>>>>
>>>>>>>> I think this fix is really needed. I have another test case with a
>>>>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>>>>>
>>>>>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>>>>>> iommu shutdown.
>>>>>>>>
>>>>>>>> With that fix, the above test case is fixed and I do not see spurious
>>>>>>>> vhost IOTLB miss spurious requests.
>>>>>>>>
>>>>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>>>>>> IOTLB callbacks when IOMMU gets disabled,
>>>>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
>>>>>>>> eric.auger@redhat.com/)
>>>>>>>>
>>>>>>>>
>>>>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Eric
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>    drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>>>>    1 file changed, 10 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>>>>> --- a/drivers/virtio/virtio.c
>>>>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>>>>        of_node_put(dev->dev.of_node);
>>>>>>>>>    }
>>>>>>>>>    +static void virtio_dev_shutdown(struct device *_d)
>>>>>>>>> +{
>>>>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>>>>> +
>>>>>>>>> +    if (drv && drv->remove)
>>>>>>>>> +        drv->remove(dev);
>>>>>>>
>>>>>>>
>>>>>>> I am concerned that full remove is a heavyweight operation.
>>>>>>> Do not want to slow down reboots even more.
>>>>>>> How about just doing a reset, instead?
>>>>>>
>>>>>> I tested with
>>>>>>
>>>>>> static void virtio_dev_shutdown(struct device *_d)
>>>>>> {
>>>>>>           struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>
>>>>>>           virtio_reset_device(dev);
>>>>>> }
>>>>>>
>>>>>>
>>>>>> and it fixes my issue.
>>>>>>
>>>>>> Kirill, would that fix you issue too?
>>>>
>>>> Hi,
>>>>
>>>> sorry for my late response, I synced with Kirill offline and did a retest.
>>>>
>>>> The issue is still reproduced on my side, kexec will be stuck in case of
>>>> "console=hvc0" append in kernel cmdline and even with such patch applied.
>>>
>>> Thanks for testing!
>>>
>>> Michael, it looks like the initial patch from Kyrill is the one that
>>> fixes both issues. virtio_reset_device() usage does not work for the
>>> initial bug report while it works for me. Other ideas?
>>>
>>> Thanks
>>>
>>> Eric
>>
>> Ah, wait a second.
>>
>> Looks like virtio-console continues to write to the MMIO even after
>> underlying virtio-pci device is removed.
> 
> Where is such code? I think the virtcons_remove() is called so the
> console is unregistered from the subsystem.
> 
> Or for surprise removal, we have break the device in:
> 
> static void virtio_pci_remove(struct pci_dev *pci_dev)
> {
>          struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>          struct device *dev = get_device(&vp_dev->vdev.dev);
> 
>          /*
>           * Device is marked broken on surprise removal so that virtio upper
>           * layers can abort any ongoing operation.
>           */
>          if (!pci_device_is_present(pci_dev))
>                  virtio_break_device(&vp_dev->vdev);
> 
> 
>>
>> Hmm. I am not sure why that is a problem, but I assume some hypervisors just
>> hang the system if you try to kick them after reset.
>> Unfortunate that spec did not disallow it.
>>
>> If we want to prevent that, we want to do something like this:
>>
>>
>>          /*
>>           * Some devices get wedged if you kick them after they are
>>           * reset. Mark all vqs as broken to make sure we don't.
>>           */
>>          virtio_break_device(dev);
>>          /*
>>           * The below virtio_synchronize_cbs() guarantees that any
>>           * interrupt for this line arriving after
>>           * virtio_synchronize_vqs() has completed is guaranteed to see
>>           * vq->broken as true.
>>           */
>>          virtio_synchronize_cbs(dev);
> 
> This seems to relate to doing this when we reintroduce the
> notification hardening.
> 
>>          dev->config->reset(dev);
>>

quick update on above patch from Michael, it could fix the original 
issue in my test setup of vm kexec kernel switching, which is triggered 
with console=hvc0 cmdline.

>>
>> I assume this still works for you, yes?
>>
> 
> Thanks
> 
>>
>>
>>>>
>>>> my kernel code base is 6.14.0-rc2.
>>>>
>>>> let me know if any more experiments needed.
>>>>
>>>> ---
>>>>   drivers/virtio/virtio.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>> index ba37665188b5..f9f885d04763 100644
>>>> --- a/drivers/virtio/virtio.c
>>>> +++ b/drivers/virtio/virtio.c
>>>> @@ -395,6 +395,13 @@ static const struct cpumask
>>>> *virtio_irq_get_affinity(struct device *_d,
>>>>          return dev->config->get_vq_affinity(dev, irq_vec);
>>>>   }
>>>>
>>>> +static void virtio_dev_shutdown(struct device *_d)
>>>> +{
>>>> +        struct virtio_device *dev = dev_to_virtio(_d);
>>>> +
>>>> +        virtio_reset_device(dev);
>>>> +}
>>>> +
>>>>   static const struct bus_type virtio_bus = {
>>>>          .name  = "virtio",
>>>>          .match = virtio_dev_match,
>>>> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
>>>>          .probe = virtio_dev_probe,
>>>>          .remove = virtio_dev_remove,
>>>>          .irq_get_affinity = virtio_irq_get_affinity,
>>>> +       .shutdown = virtio_dev_shutdown,
>>>>   };
>>>>
>>>>   int __register_virtio_driver(struct virtio_driver *driver, struct
>>>> module *owner)
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>>> gentle ping.
>>>>>
>>>>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
>>>>> the above addition I get rid of spurious warning in qemu on guest reboot.
>>>>>
>>>>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
>>>>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
>>>>> argument (22)
>>>>>
>>>>> Would you mind if I respin?
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Eric
>>>>>>>
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>    static const struct bus_type virtio_bus = {
>>>>>>>>>        .name  = "virtio",
>>>>>>>>>        .match = virtio_dev_match,
>>>>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>>>>>        .uevent = virtio_uevent,
>>>>>>>>>        .probe = virtio_dev_probe,
>>>>>>>>>        .remove = virtio_dev_remove,
>>>>>>>>> +    .shutdown = virtio_dev_shutdown,
>>>>>>>>>    };
>>>>>>>>>      int __register_virtio_driver(struct virtio_driver *driver,
>>>>>>>>> struct module *owner)
>>>>>>>
>>>>>>
>>>>>
>>>>
>>
> 
> 

