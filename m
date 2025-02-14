Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3220C03A
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517680; cv=none; b=pbyIKzUDAzoO/EQXJjtuTRYsLqwOkdyl5Bkx+J3iTKek1hQefb+aebHf9in+BjlwP3Rd+lslWv3H8gBGT2w/QGL2SU+tvA98QlPATtgcW1gBBNAac5nJ2ixJCm0dbYTXNVr0AmSrBz6FNVrn/N5kJgfsoDnW8uv5gNkBKkCoGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517680; c=relaxed/simple;
	bh=d6YvzmhZdp1UQthxLehfAcJuwXIc0kTIS+/CMh1p+gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGebEx/k1UYn/SI6Mmd6GVPJ9Sfbxzpgle0KGux1r2I+musk4vU9pTdoqRz54QML/rG3J5NHClnzgS8nw5EN73z7ryI0wo9Zne9h/ueSKOee3WLofOCQimqxsoNBqlL9wIWLK/tnqWb0DrDUAKq5F1eOAoqiTCtYvjv3teCc+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXvphQHo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXvphQHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739517678; x=1771053678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d6YvzmhZdp1UQthxLehfAcJuwXIc0kTIS+/CMh1p+gk=;
  b=UXvphQHoNbXyYylhFgS+lDpHNdtpHP6jV0SMCqkzaleBn+x2dlgEAlVf
   uoLP152+Mv+sgHSW3Fkfe9k69IzO7suIiTXcBybXRQkdeyOVipnVpMniJ
   hM+QAGdk7VXa5Pr8iCNVdIcsiYvZcgYWwx36mOtKcXctOyhyKTO/5q0f2
   /evEQSsZDT+Gklzy1uaFA6791jhoFdvEh4vBWLmWEplOcWVC14FjovAWQ
   r2sApi0ORPX/4xBr6w6Pi69zmdxjEQAmjTnyg6cItXP6hGILbIifDxmfP
   QAfCx7nPLlu8VsrdebQMlFjZGnLLNBlhVOMc97i5CsSt0/4mv+OGMN+TI
   A==;
X-CSE-ConnectionGUID: yINq/I/4QVun/a9XuX6c+g==
X-CSE-MsgGUID: lPvvxgdqT9Swa7HG/3XSiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40291859"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40291859"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 23:21:17 -0800
X-CSE-ConnectionGUID: KcWW0NhNREyHk/GliVO58A==
X-CSE-MsgGUID: URM/KXm9TXCrxuvwjCKWrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113575960"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.240.136]) ([10.124.240.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 23:21:15 -0800
Message-ID: <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
Date: Fri, 14 Feb 2025 15:21:02 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: Eric Auger <eauger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/6 16:59, Eric Auger wrote:
> Hi,
> 
> On 2/4/25 12:46 PM, Eric Auger wrote:
>> Hi,
>>
>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>> Hi Kirill, Michael
>>>>
>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>> accesses during the hang.
>>>>>
>>>>> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>>>>> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>>>>> 	...
>>>>>
>>>>> It was traced down to virtio-console. Kexec works fine if virtio-console
>>>>> is not in use.
>>>>>
>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>> underlying virtio-pci device is removed.
>>>>>
>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>> bus shutdown.
>>>>>
>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>
>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>
>>>> I think this fix is really needed. I have another test case with a
>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>
>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>> iommu shutdown.
>>>>
>>>> With that fix, the above test case is fixed and I do not see spurious
>>>> vhost IOTLB miss spurious requests.
>>>>
>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>> IOTLB callbacks when IOMMU gets disabled,
>>>> https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/)
>>>>
>>>>
>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>>>> ---
>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
>>>>>   1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>> --- a/drivers/virtio/virtio.c
>>>>> +++ b/drivers/virtio/virtio.c
>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>   	of_node_put(dev->dev.of_node);
>>>>>   }
>>>>>   
>>>>> +static void virtio_dev_shutdown(struct device *_d)
>>>>> +{
>>>>> +	struct virtio_device *dev = dev_to_virtio(_d);
>>>>> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>> +
>>>>> +	if (drv && drv->remove)
>>>>> +		drv->remove(dev);
>>>
>>>
>>> I am concerned that full remove is a heavyweight operation.
>>> Do not want to slow down reboots even more.
>>> How about just doing a reset, instead?
>>
>> I tested with
>>
>> static void virtio_dev_shutdown(struct device *_d)
>> {
>>          struct virtio_device *dev = dev_to_virtio(_d);
>>
>>          virtio_reset_device(dev);
>> }
>>
>>
>> and it fixes my issue.
>>
>> Kirill, would that fix you issue too?

Hi,

sorry for my late response, I synced with Kirill offline and did a retest.

The issue is still reproduced on my side, kexec will be stuck in case of 
"console=hvc0" append in kernel cmdline and even with such patch applied.

my kernel code base is 6.14.0-rc2.

let me know if any more experiments needed.

---
  drivers/virtio/virtio.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ba37665188b5..f9f885d04763 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -395,6 +395,13 @@ static const struct cpumask 
*virtio_irq_get_affinity(struct device *_d,
         return dev->config->get_vq_affinity(dev, irq_vec);
  }

+static void virtio_dev_shutdown(struct device *_d)
+{
+        struct virtio_device *dev = dev_to_virtio(_d);
+
+        virtio_reset_device(dev);
+}
+
  static const struct bus_type virtio_bus = {
         .name  = "virtio",
         .match = virtio_dev_match,
@@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
         .probe = virtio_dev_probe,
         .remove = virtio_dev_remove,
         .irq_get_affinity = virtio_irq_get_affinity,
+       .shutdown = virtio_dev_shutdown,
  };

  int __register_virtio_driver(struct virtio_driver *driver, struct 
module *owner)
--
2.43.0


> gentle ping.
> 
> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
> the above addition I get rid of spurious warning in qemu on guest reboot.
> 
> qemu-system-aarch64: virtio: zero sized buffers are not allowed
> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid argument (22)
> 
> Would you mind if I respin?
> 
> Thanks
> 
> Eric
> 
> 
> 
> 
>>
>> Thanks
>>
>> Eric
>>>
>>>>> +}
>>>>> +
>>>>>   static const struct bus_type virtio_bus = {
>>>>>   	.name  = "virtio",
>>>>>   	.match = virtio_dev_match,
>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>   	.uevent = virtio_uevent,
>>>>>   	.probe = virtio_dev_probe,
>>>>>   	.remove = virtio_dev_remove,
>>>>> +	.shutdown = virtio_dev_shutdown,
>>>>>   };
>>>>>   
>>>>>   int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
>>>
>>
> 

