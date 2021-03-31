Return-Path: <SRS0=Cini=I5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9A7C433ED
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 16:08:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BB16100A
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 16:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BB16100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0413D404E9;
	Wed, 31 Mar 2021 16:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iTgYGswegqC2; Wed, 31 Mar 2021 16:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97668404EA;
	Wed, 31 Mar 2021 16:08:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39B1EC0013;
	Wed, 31 Mar 2021 16:08:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8320C000A;
 Wed, 31 Mar 2021 16:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6AAB60B00;
 Wed, 31 Mar 2021 16:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C2MTUDofO9RI; Wed, 31 Mar 2021 16:08:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F1D060637;
 Wed, 31 Mar 2021 16:08:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D11FD6E;
 Wed, 31 Mar 2021 09:08:04 -0700 (PDT)
Received: from [10.57.24.208] (unknown [10.57.24.208])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FF463F792;
 Wed, 31 Mar 2021 09:08:02 -0700 (PDT)
Subject: Re: [PATCH 16/18] iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
To: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-17-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <163376d7-ab23-a470-5bba-7fcd8ae95a4e@arm.com>
Date: Wed, 31 Mar 2021 17:07:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210316153825.135976-17-hch@lst.de>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 freedreno@lists.freedesktop.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
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

On 2021-03-16 15:38, Christoph Hellwig wrote:
[...]
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f1e38526d5bd40..996dfdf9d375dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2017,7 +2017,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>   		.iommu_dev	= smmu->dev,
>   	};
>   
> -	if (smmu_domain->non_strict)
> +	if (!iommu_get_dma_strict())

As Will raised, this also needs to be checking "domain->type == 
IOMMU_DOMAIN_DMA" to maintain equivalent behaviour to the attribute code 
below.

>   		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>   
>   	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> @@ -2449,52 +2449,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>   	return group;
>   }
>   
> -static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> -				    enum iommu_attr attr, void *data)
> -{
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -
> -	switch (domain->type) {
> -	case IOMMU_DOMAIN_DMA:
> -		switch (attr) {
> -		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			*(int *)data = smmu_domain->non_strict;
> -			return 0;
> -		default:
> -			return -ENODEV;
> -		}
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -}
[...]
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index f985817c967a25..edb1de479dd1a7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -668,7 +668,6 @@ struct arm_smmu_domain {
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   
>   	struct io_pgtable_ops		*pgtbl_ops;
> -	bool				non_strict;
>   	atomic_t			nr_ats_masters;
>   
>   	enum arm_smmu_domain_stage	stage;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0aa6d667274970..3dde22b1f8ffb0 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -761,6 +761,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   		.iommu_dev	= smmu->dev,
>   	};
>   
> +	if (!iommu_get_dma_strict())

Ditto here.

Sorry for not spotting that sooner :(

Robin.

> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +
>   	if (smmu->impl && smmu->impl->init_context) {
>   		ret = smmu->impl->init_context(smmu_domain, &pgtbl_cfg, dev);
>   		if (ret)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
