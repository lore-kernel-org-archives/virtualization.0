Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E451AC43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 10:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2986840119;
	Fri,  1 Jul 2022 10:22:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2986840119
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eCNFcrMjUAZF; Fri,  1 Jul 2022 10:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8FC0E40B6A;
	Fri,  1 Jul 2022 10:22:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8FC0E40B6A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E57F4C007B;
	Fri,  1 Jul 2022 10:22:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 055C0C002D;
 Fri,  1 Jul 2022 10:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0CF040878;
 Fri,  1 Jul 2022 10:22:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0CF040878
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qIc6_mO5iR_5; Fri,  1 Jul 2022 10:21:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A094407D7
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A094407D7;
 Fri,  1 Jul 2022 10:21:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0D94113E;
 Fri,  1 Jul 2022 03:21:58 -0700 (PDT)
Received: from [10.57.85.162] (unknown [10.57.85.162])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADFA03F66F;
 Fri,  1 Jul 2022 03:21:52 -0700 (PDT)
Message-ID: <fab41f28-8f48-9f40-09c8-fd5f0714a9e0@arm.com>
Date: Fri, 1 Jul 2022 11:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
 marcan@marcan.st, sven@svenpeter.dev, robdclark@gmail.com,
 baolu.lu@linux.intel.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
 zhang.lyra@gmail.com, jean-philippe@linaro.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com
References: <20220630203635.33200-1-nicolinc@nvidia.com>
 <20220630203635.33200-2-nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220630203635.33200-2-nicolinc@nvidia.com>
Cc: mjrosato@linux.ibm.com, virtualization@lists.linux-foundation.org,
 thierry.reding@gmail.com, alyssa@rosenzweig.io, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, jonathanh@nvidia.com, iommu@lists.linux.dev,
 yangyingliang@huawei.com, gerald.schaefer@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, john.garry@huawei.com, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 chenxiang66@hisilicon.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org
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

On 2022-06-30 21:36, Nicolin Chen wrote:
> Cases like VFIO wish to attach a device to an existing domain that was
> not allocated specifically from the device. This raises a condition
> where the IOMMU driver can fail the domain attach because the domain and
> device are incompatible with each other.
> 
> This is a soft failure that can be resolved by using a different domain.
> 
> Provide a dedicated errno from the IOMMU driver during attach that the
> reason attached failed is because of domain incompatability. EMEDIUMTYPE
> is chosen because it is never used within the iommu subsystem today and
> evokes a sense that the 'medium' aka the domain is incompatible.
> 
> VFIO can use this to know attach is a soft failure and it should continue
> searching. Otherwise the attach will be a hard failure and VFIO will
> return the code to userspace.
> 
> Update all drivers to return EMEDIUMTYPE in their failure paths that are
> related to domain incompatability. Also remove adjacent error prints for
> these soft failures, to prevent a kernel log spam, since -EMEDIUMTYPE is
> clear enough to indicate an incompatability error.
> 
> Add kdocs describing this behavior.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
[...]
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 2ed3594f384e..072cac5ab5a4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1135,10 +1135,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	struct arm_smmu_device *smmu;
>   	int ret;
>   
> -	if (!fwspec || fwspec->ops != &arm_smmu_ops) {
> -		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
> -		return -ENXIO;
> -	}
> +	if (!fwspec || fwspec->ops != &arm_smmu_ops)
> +		return -EMEDIUMTYPE;

This is the wrong check, you want the "if (smmu_domain->smmu != smmu)" 
condition further down. If this one fails it's effectively because the 
device doesn't have an IOMMU at all, and similar to patch #3 it will be 
removed once the core code takes over properly (I even have both those 
patches written now!)

Thanks,
Robin.

>   	/*
>   	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
