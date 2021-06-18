Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC1EC49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:29:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FB3613E8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FB3613E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DE88403D7;
	Fri, 18 Jun 2021 16:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZVyqtFuDjnYU; Fri, 18 Jun 2021 16:29:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D18840350;
	Fri, 18 Jun 2021 16:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD5BCC000B;
	Fri, 18 Jun 2021 16:29:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 550E4C000B;
 Fri, 18 Jun 2021 16:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A073403B9;
 Fri, 18 Jun 2021 16:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6DBqFFb1sFXY; Fri, 18 Jun 2021 16:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id E38F640350;
 Fri, 18 Jun 2021 16:29:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3D4F13A1;
 Fri, 18 Jun 2021 09:29:20 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380B13F70D;
 Fri, 18 Jun 2021 09:29:18 -0700 (PDT)
Subject: Re: [PATCH v5 4/5] iommu/dma: Pass address limit rather than size to
 iommu_setup_dma_ops()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
 <20210618152059.1194210-5-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1016e527-c5f1-04c7-cccb-9256d26dc3a2@arm.com>
Date: Fri, 18 Jun 2021 17:29:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618152059.1194210-5-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: lorenzo.pieralisi@arm.com, eric.auger@redhat.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
 baolu.lu@linux.intel.com
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

On 2021-06-18 16:20, Jean-Philippe Brucker wrote:
> Passing a 64-bit address width to iommu_setup_dma_ops() is valid on
> virtual platforms, but isn't currently possible. The overflow check in
> iommu_dma_init_domain() prevents this even when @dma_base isn't 0. Pass
> a limit address instead of a size, so callers don't have to fake a size
> to work around the check.
> 
> The base and limit parameters are being phased out, because:
> * they are redundant for x86 callers. dma-iommu already reserves the
>    first page, and the upper limit is already in domain->geometry.
> * they can now be obtained from dev->dma_range_map on Arm.
> But removing them on Arm isn't completely straightforward so is left for
> future work. As an intermediate step, simplify the x86 callers by
> passing dummy limits.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   include/linux/dma-iommu.h   |  4 ++--
>   arch/arm64/mm/dma-mapping.c |  2 +-
>   drivers/iommu/amd/iommu.c   |  2 +-
>   drivers/iommu/dma-iommu.c   | 12 ++++++------
>   drivers/iommu/intel/iommu.c |  5 +----
>   5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 6e75a2d689b4..758ca4694257 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -19,7 +19,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>   void iommu_put_dma_cookie(struct iommu_domain *domain);
>   
>   /* Setup call for arch DMA mapping code */
> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
> +void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
>   
>   /* The DMA API isn't _quite_ the whole story, though... */
>   /*
> @@ -50,7 +50,7 @@ struct msi_msg;
>   struct device;
>   
>   static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
> -		u64 size)
> +				       u64 dma_limit)
>   {
>   }
>   
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 4bf1dd3eb041..6719f9efea09 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -50,7 +50,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   
>   	dev->dma_coherent = coherent;
>   	if (iommu)
> -		iommu_setup_dma_ops(dev, dma_base, size);
> +		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
>   
>   #ifdef CONFIG_XEN
>   	if (xen_swiotlb_detect())
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 3ac42bbdefc6..216323fb27ef 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1713,7 +1713,7 @@ static void amd_iommu_probe_finalize(struct device *dev)
>   	/* Domains are initialized for this device - have a look what we ended up with */
>   	domain = iommu_get_domain_for_dev(dev);
>   	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
> +		iommu_setup_dma_ops(dev, 0, U64_MAX);
>   	else
>   		set_dma_ops(dev, NULL);
>   }
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7bcdd1205535..c62e19bed302 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -319,16 +319,16 @@ static bool dev_is_untrusted(struct device *dev)
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>    * @base: IOVA at which the mappable address space starts
> - * @size: Size of IOVA space
> + * @limit: Last address of the IOVA space
>    * @dev: Device the domain is being initialised for
>    *
> - * @base and @size should be exact multiples of IOMMU page granularity to
> + * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
>    * avoid rounding surprises. If necessary, we reserve the page at address 0
>    * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
>    * any change which could make prior IOVAs invalid will fail.
>    */
>   static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> -		u64 size, struct device *dev)
> +				 dma_addr_t limit, struct device *dev)
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	unsigned long order, base_pfn;
> @@ -346,7 +346,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	/* Check the domain allows at least some access to the device... */
>   	if (domain->geometry.force_aperture) {
>   		if (base > domain->geometry.aperture_end ||
> -		    base + size <= domain->geometry.aperture_start) {
> +		    limit < domain->geometry.aperture_start) {
>   			pr_warn("specified DMA range outside IOMMU capability\n");
>   			return -EFAULT;
>   		}
> @@ -1308,7 +1308,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>    * The IOMMU core code allocates the default DMA domain, which the underlying
>    * IOMMU driver needs to support via the dma-iommu layer.
>    */
> -void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
> +void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>   {
>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>   
> @@ -1320,7 +1320,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
>   	 * underlying IOMMU driver needs to support via the dma-iommu layer.
>   	 */
>   	if (domain->type == IOMMU_DOMAIN_DMA) {
> -		if (iommu_dma_init_domain(domain, dma_base, size, dev))
> +		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>   			goto out_err;
>   		dev->dma_ops = &iommu_dma_ops;
>   	}
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index be35284a2016..2f7213f0e7a1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5165,13 +5165,10 @@ static void intel_iommu_release_device(struct device *dev)
>   
>   static void intel_iommu_probe_finalize(struct device *dev)
>   {
> -	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   
>   	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, base,
> -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
> +		iommu_setup_dma_ops(dev, 0, U64_MAX);
>   	else
>   		set_dma_ops(dev, NULL);
>   }
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
