Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D181C32771
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 11:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5FDA415CF;
	Fri, 19 Aug 2022 11:04:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5FDA415CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVkRBNJz9SqP; Fri, 19 Aug 2022 11:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07D7C415CA;
	Fri, 19 Aug 2022 11:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07D7C415CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBDCAC0032;
	Fri, 19 Aug 2022 11:04:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E861C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 11:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF959831F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 11:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF959831F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 81B5gdBWecRH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 11:04:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D78583118
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D78583118
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 11:04:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F176175A;
 Fri, 19 Aug 2022 04:04:06 -0700 (PDT)
Received: from [10.57.14.7] (unknown [10.57.14.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941913F66F;
 Fri, 19 Aug 2022 04:04:03 -0700 (PDT)
Message-ID: <6d348917-7616-8006-4c9a-800ad1c2034e@arm.com>
Date: Fri, 19 Aug 2022 12:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] iommu/virtio: Fix interaction with VFIO
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220818163801.1011548-1-jean-philippe@linaro.org>
 <51efe220-9eb2-b52f-81e3-45949e51fb27@arm.com> <Yv9oQPtlX+7xw3q5@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yv9oQPtlX+7xw3q5@myrica>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-08-19 11:38, Jean-Philippe Brucker wrote:
> On Thu, Aug 18, 2022 at 09:10:25PM +0100, Robin Murphy wrote:
>> On 2022-08-18 17:38, Jean-Philippe Brucker wrote:
>>> Commit e8ae0e140c05 ("vfio: Require that devices support DMA cache
>>> coherence") requires IOMMU drivers to advertise
>>> IOMMU_CAP_CACHE_COHERENCY, in order to be used by VFIO. Since VFIO does
>>> not provide to userspace the ability to maintain coherency through cache
>>> invalidations, it requires hardware coherency. Advertise the capability
>>> in order to restore VFIO support.
>>>
>>> The meaning of IOMMU_CAP_CACHE_COHERENCY also changed from "IOMMU can
>>> enforce cache coherent DMA transactions" to "IOMMU_CACHE is supported".
>>> While virtio-iommu cannot enforce coherency (of PCIe no-snoop
>>> transactions), it does support IOMMU_CACHE.
>>>
>>> Non-coherent accesses are not currently a concern for virtio-iommu
>>> because host OSes only assign coherent devices,
>>
>> Is that guaranteed though? I see nothing in VFIO checking *device*
>> coherency, only that the *IOMMU* can impose it via this capability, which
>> would form a very circular argument.
> 
> Yes the wording is wrong here, more like "host OSes only assign devices
> whose accesses are coherent". And it's not guaranteed, just I'm still
> looking for a realistic counter-example. I guess a good indicator would be
> a VMM that presents a device without 'dma-coherent'.

vfio-amba with the pl330 on Juno, perhaps?

>> We can no longer say that in practice
>> nobody has a VFIO-capable IOMMU in front of non-coherent PCI, now that
>> Rockchip RK3588 boards are about to start shipping (at best we can only say
>> that they still won't have the SMMUs in the DT until I've finished ripping
>> up the bus ops).
> 
> Ah, I was hoping that vfio-pci should only be concerned about no-snoop. Do
> you know if your series [2] ensures that the SMMU driver doesn't report
> IOMMU_CAP_CACHE_COHERENCY for that system?

It should do, since the downstream DT says the SMMU is non-coherent.

>>> and the guest does not
>>> enable PCIe no-snoop. Nevertheless, we can summarize here the possible
>>> support for non-coherent DMA:
>>>
>>> (1) When accesses from a hardware endpoint are not coherent. The host
>>>       would describe such a device using firmware methods ('dma-coherent'
>>>       in device-tree, '_CCA' in ACPI), since they are also needed without
>>>       a vIOMMU. In this case mappings are created without IOMMU_CACHE.
>>>       virtio-iommu doesn't need any additional support. It sends the same
>>>       requests as for coherent devices.
>>>
>>> (2) When the physical IOMMU supports non-cacheable mappings. Supporting
>>>       those would require a new feature in virtio-iommu, new PROBE request
>>>       property and MAP flags. Device drivers would use a new API to
>>>       discover this since it depends on the architecture and the physical
>>>       IOMMU.
>>>
>>> (3) When the hardware supports PCIe no-snoop. Some architecture do not
>>>       support this either (whether no-snoop is supported by an Arm system
>>>       is not discoverable by software). If Linux did enable no-snoop in
>>>       endpoints on x86, then virtio-iommu would need additional feature,
>>>       PROBE property, ATTACH and/or MAP flags to support enforcing snoop.
>>
>> That's not an "if" - various Linux drivers *do* use no-snoop, which IIUC is
>> the main reason for VFIO wanting to enforce this in the first place. For
>> example, see the big fat comment in drm_arch_can_wc_memory() if you've
>> forgotten the fun we had with AMD GPUs in the TX2 boxes back in the day ;)
> 
> Ah duh, I missed that PCI_EXP_DEVCTL_NOSNOOP_EN defaults to 1, of course
> it does. So I think VFIO should clear it on Arm and make it read-only,
> since the SMMU can't force-snoop like on x86. I'd be tempted to do that if
> CONFIG_ARM{,64} is enabled, but checking a new IOMMU capability may be
> cleaner.

I think that's a good idea, but IIRC Jason mentioned in review of the 
VFIO series that it's not sufficient to provide the actual guarantee 
we're after, since there are out-of-spec devices that ignore the control 
and may send no-snoop packets anyway. However, as part of a best-effort 
approach for arm64 it still makes sense to help all the well-behaved 
drivers/devices do the right thing.

Cheers,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
