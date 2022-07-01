Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8059C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 18:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47E78405A6;
	Fri,  1 Jul 2022 18:17:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47E78405A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kGEgDptcydC; Fri,  1 Jul 2022 18:17:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4F368403C8;
	Fri,  1 Jul 2022 18:17:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F368403C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C5FFC0032;
	Fri,  1 Jul 2022 18:17:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFA80C002D;
 Fri,  1 Jul 2022 18:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A492F60BFE;
 Fri,  1 Jul 2022 18:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A492F60BFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPGKjPQiso62; Fri,  1 Jul 2022 18:17:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 362D060017
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 362D060017;
 Fri,  1 Jul 2022 18:17:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BA4113E;
 Fri,  1 Jul 2022 11:17:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDCD33F5A1;
 Fri,  1 Jul 2022 11:17:43 -0700 (PDT)
Message-ID: <2ccb6033-4c34-ff59-50a8-549c924d269d@arm.com>
Date: Fri, 1 Jul 2022 19:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20220630203635.33200-1-nicolinc@nvidia.com>
 <20220630203635.33200-2-nicolinc@nvidia.com>
 <fab41f28-8f48-9f40-09c8-fd5f0714a9e0@arm.com>
 <Yr8kHnK7xRx2DZus@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yr8kHnK7xRx2DZus@Asurada-Nvidia>
Cc: marcan@marcan.st, mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, will@kernel.org, alyssa@rosenzweig.io,
 jean-philippe@linaro.org, kvm@vger.kernel.org, zhang.lyra@gmail.com,
 joro@8bytes.org, iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 iommu@lists.linux.dev, jgg@nvidia.com, yangyingliang@huawei.com,
 orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com, sven@svenpeter.dev,
 linux-arm-msm@vger.kernel.org, john.garry@huawei.com,
 christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
 linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, chenxiang66@hisilicon.com,
 linux-s390@vger.kernel.org, cohuck@redhat.com, vdumpa@nvidia.com,
 robdclark@gmail.com, suravee.suthikulpanit@amd.com, baolin.wang7@gmail.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com
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

On 01/07/2022 5:43 pm, Nicolin Chen wrote:
> On Fri, Jul 01, 2022 at 11:21:48AM +0100, Robin Murphy wrote:
> 
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 2ed3594f384e..072cac5ab5a4 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -1135,10 +1135,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>>        struct arm_smmu_device *smmu;
>>>        int ret;
>>>
>>> -     if (!fwspec || fwspec->ops != &arm_smmu_ops) {
>>> -             dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
>>> -             return -ENXIO;
>>> -     }
>>> +     if (!fwspec || fwspec->ops != &arm_smmu_ops)
>>> +             return -EMEDIUMTYPE;
>>
>> This is the wrong check, you want the "if (smmu_domain->smmu != smmu)"
>> condition further down. If this one fails it's effectively because the
>> device doesn't have an IOMMU at all, and similar to patch #3 it will be
> 
> Thanks for the review! I will fix that. The "on the same bus" is
> quite eye-catching.
> 
>> removed once the core code takes over properly (I even have both those
>> patches written now!)
> 
> Actually in my v1 the proposal for ops check returned -EMEDIUMTYPE
> also upon an ops mismatch, treating that too as an incompatibility.
> Do you mean that we should have fine-grained it further?

On second look, I think this particular check was already entirely 
redundant by the time I made the fwspec conversion to it, oh well. Since 
it remains harmless for the time being, let's just ignore it entirely 
until we can confidently say goodbye to the whole lot[1].

I don't think there's any need to differentiate an instance mismatch 
from a driver mismatch, once the latter becomes realistically possible, 
mostly due to iommu_domain_alloc() also having to become device-aware to 
know which driver to allocate from. Thus as far as a user is concerned, 
if attaching a device to an existing domain fails with -EMEDIUMTYPE, 
allocating a new domain using the given device, and attaching to that, 
can be expected to succeed, regardless of why the original attempt was 
rejected. In fact even in the theoretical different-driver-per-bus model 
the same principle still holds up.

Thanks,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/aa4accfa4a10e92daad0d51095918e8a89014393
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
