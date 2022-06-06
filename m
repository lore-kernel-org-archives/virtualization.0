Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A4CCCA473
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 14:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9931C417C2;
	Mon,  6 Jun 2022 14:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hKfqvqrsKWes; Mon,  6 Jun 2022 14:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2B1B417C4;
	Mon,  6 Jun 2022 14:34:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D37C0080;
	Mon,  6 Jun 2022 14:34:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26674C002D;
 Mon,  6 Jun 2022 14:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EAFE840CB;
 Mon,  6 Jun 2022 14:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tr1woR3bU14h; Mon,  6 Jun 2022 14:33:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74D9A84035;
 Mon,  6 Jun 2022 14:33:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CACF15DB;
 Mon,  6 Jun 2022 07:33:55 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 555903F73B;
 Mon,  6 Jun 2022 07:33:48 -0700 (PDT)
Message-ID: <1e0e5403-1e65-db9a-c8e7-34e316bfda8e@arm.com>
Date: Mon, 6 Jun 2022 15:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] iommu: Ensure device has the same iommu_ops as the
 domain
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, robdclark@gmail.com,
 m.szyprowski@samsung.com, krzysztof.kozlowski@linaro.org,
 baolu.lu@linux.intel.com, agross@kernel.org, bjorn.andersson@linaro.org,
 matthias.bgg@gmail.com, heiko@sntech.de, orsonzhai@gmail.com,
 baolin.wang7@gmail.com, zhang.lyra@gmail.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, jean-philippe@linaro.org,
 alex.williamson@redhat.com
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-3-nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220606061927.26049-3-nicolinc@nvidia.com>
Cc: mjrosato@linux.ibm.com, virtualization@lists.linux-foundation.org,
 thierry.reding@gmail.com, alim.akhtar@samsung.com, alyssa@rosenzweig.io,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 kvm@vger.kernel.org, jonathanh@nvidia.com, linux-rockchip@lists.infradead.org,
 yong.wu@mediatek.com, gerald.schaefer@linux.ibm.com,
 linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 suravee.suthikulpanit@amd.com, dwmw2@infradead.org
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

On 2022-06-06 07:19, Nicolin Chen wrote:
> The core code should not call an iommu driver op with a struct device
> parameter unless it knows that the dev_iommu_priv_get() for that struct
> device was setup by the same driver. Otherwise in a mixed driver system
> the iommu_priv could be casted to the wrong type.

We don't have mixed-driver systems, and there are plenty more 
significant problems than this one to solve before we can (but thanks 
for pointing it out - I hadn't got as far as auditing the public 
interfaces yet). Once domains are allocated via a particular device's 
IOMMU instance in the first place, there will be ample opportunity for 
the core to stash suitable identifying information in the domain for 
itself. TBH even the current code could do it without needing the 
weirdly invasive changes here.

> Store the iommu_ops pointer in the iommu_domain and use it as a check to
> validate that the struct device is correct before invoking any domain op
> that accepts a struct device.

In fact this even describes exactly that - "Store the iommu_ops pointer 
in the iommu_domain", vs. the "Store the iommu_ops pointer in the 
iommu_domain_ops" which the patch is actually doing :/

[...]
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 19cf28d40ebe..8a1f437a51f2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1963,6 +1963,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   {
>   	int ret;
>   
> +	/* Ensure the device was probe'd onto the same driver as the domain */
> +	if (dev->bus->iommu_ops != domain->ops->iommu_ops)

Nope, dev_iommu_ops(dev) please. Furthermore I think the logical place 
to put this is in iommu_group_do_attach_device(), since that's the 
gateway for the public interfaces - we shouldn't need to second-guess 
ourselves for internal default-domain-related calls.

Thanks,
Robin.

> +		return -EMEDIUMTYPE;
> +
>   	if (unlikely(domain->ops->attach_dev == NULL))
>   		return -ENODEV;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
