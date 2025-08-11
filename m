Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39126E71F;
	Mon, 11 Aug 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951688; cv=none; b=eoY3W2rMvwGsKmv2JAu+pXi41D61duWXHuv/0ooUAq5lNT/Ai/fPf2AdayIRZfGY+5GjNUNWpIInY0NzRdwCALM8wM+HlTcbki0bmz2/nEXSG4Sf9VQ6PXuk2wOzVYyt1lOMbUxMG8fRsYvSqQiWTkYDO0i7ubV1qH/OFf//+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951688; c=relaxed/simple;
	bh=KEJz8V3hTKSNX75hFQYkEePbPa67hYMeGLAn/TFBgQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQsw095/U809sHWSyptup03cvxURco3d5yEamTaLrs7rTz5MHIQz6nN3Sx/Wk5ExuMtC9TFP+SsxKZqmNUB4GbFzKplg91sYgBv8VLODotqKdiBazkVvWlcy2aDVj5+GjkrHhIu7/13whQLKJO6FbxnVHOynGIndRuXSpGsR07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NC8fmStE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NC8fmStE"
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 766862118279;
	Mon, 11 Aug 2025 15:34:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 766862118279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754951686;
	bh=IwUhsFOiIi6zVcaJg3YrevuM/Efz5wgM79z0k/2+V58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NC8fmStEktFHXs7Gwd5+MBF/sOxe/YRuwXQMP7Cdg+03h1qB9i7z25fjbxNTfeJB2
	 HJs+BEDX2sjBvRhUBvPOeI4Cvh3CkAvE1SK931K1TBY6QoisYwInK5UxEvhzD1jKiM
	 v1dAlPzV+DO2ajr4BftKMDV3pGyAsQQN4RRFhBPg=
Date: Mon, 11 Aug 2025 15:34:44 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, virtualization@lists.linux.dev, jgg@ziepe.ca,
 will@kernel.org, eric.auger@redhat.com, code@tyhicks.com,
 eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
 bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 3/3] arm-smmu: select suitable MSI IOVA
Message-ID: <20250811153444.000071ab@linux.microsoft.com>
In-Reply-To: <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
	<20250806215539.1240561-4-shyamsaini@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Aug 2025 14:55:39 -0700
Shyam Saini <shyamsaini@linux.microsoft.com> wrote:

> Currently ARM SMMU drivers hardcode PCI MSI IOVA address.
> Not all the platform have same memory mappings and some platform
> could have this address already being mapped for something else.
> This can lead to collision and as a consequence the MSI IOVA addr
> range is never reserved.
> 
> Fix this by reserving faulty IOVA range and selecting alternate
> MSI_IOVA suitable for the intended platform.
> 
> Example of reserving faulty IOVA range for PCIE device in the DTS:
> 
> reserved-memory {
> 	#address-cells = <2>;
> 	#size-cells = <2>;
> 	faulty_iova: resv_faulty {
> 		iommu-addresses = <&pcieX 0x0 0x8000000 0x0 0x100000>;
> 	};
> };
> 
> &pcieX {
> 	memory-region = <&faulty_iova>;
> };
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Link: https://lore.kernel.org/linux-iommu/20250416181759.GF493866@ziepe.ca/
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27
> +++++++++++++++------ drivers/iommu/arm/arm-smmu/arm-smmu.c       |
> 27 +++++++++++++++------ include/linux/iommu.h
> | 25 +++++++++++++++++++ 3 files changed, 65 insertions(+), 14
> deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> 5f46140a8f3fa..0dfb522e173f0 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -3642,17 +3642,30 @@
> static int arm_smmu_of_xlate(struct device *dev, static void
> arm_smmu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI,
> GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE,
> MSI_IOVA_BASE2 }; 
>  	iommu_dma_get_resv_regions(dev, head);
> +
> +	/*
> +	 * Use the first msi_base that does not intersect with a
> platform
> +	 * reserved region. The SW MSI base selection is entirely
> arbitrary.
> +	 */
> +	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
nit: i < ARRAY_SIZE(msi_bases) is more robust

> +		struct iommu_resv_region *region;
> +
> +		if (resv_region_intersects(msi_bases[i],
> MSI_IOVA_LENGTH, head))
> +			continue;
> +
> +		region = iommu_alloc_resv_region(msi_bases[i],
> MSI_IOVA_LENGTH, prot,
> +						 IOMMU_RESV_SW_MSI,
> GFP_KERNEL);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +		return;
> +	}

Maybe add a warning if both msi_bases are conflicting. Or you can keep
searching until a non-intersecting region is found. e.g. let
resv_region_intersects() return a valid region.

>  }
>  
>  /*
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> b/drivers/iommu/arm/arm-smmu/arm-smmu.c index
> 4a07650911991..84b74b8519386 100644 ---
> a/drivers/iommu/arm/arm-smmu/arm-smmu.c +++
> b/drivers/iommu/arm/arm-smmu/arm-smmu.c @@ -1600,17 +1600,30 @@
> static int arm_smmu_of_xlate(struct device *dev, static void
> arm_smmu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE,
> MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI,
> GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE,
> MSI_IOVA_BASE2 }; 
>  	iommu_dma_get_resv_regions(dev, head);
> +
> +	/*
> +	 * Use the first msi_base that does not intersect with a
> platform
> +	 * reserved region. The SW MSI base selection is entirely
> arbitrary.
> +	 */
> +	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
> +		struct iommu_resv_region *region;
> +
> +		if (resv_region_intersects(msi_bases[i],
> MSI_IOVA_LENGTH, head))
> +			continue;
> +
> +		region = iommu_alloc_resv_region(msi_bases[i],
> MSI_IOVA_LENGTH, prot,
> +						 IOMMU_RESV_SW_MSI,
> GFP_KERNEL);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +		return;
> +	}
>  }
>  
>  static int arm_smmu_def_domain_type(struct device *dev)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 517f908296436..6750ecdebaa94 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1509,14 +1509,39 @@ static inline void iommu_debugfs_setup(void)
> {} 
>  #ifdef CONFIG_IOMMU_DMA
>  #define MSI_IOVA_BASE        0x8000000
> +#define MSI_IOVA_BASE2       0xA0000000
>  #define MSI_IOVA_LENGTH      0x100000
>  
> +static inline bool resv_region_intersects(phys_addr_t msi_base,
> size_t length,
> +					  struct list_head
> *resv_region_list) +{
> +	struct iommu_resv_region *region;
> +	phys_addr_t start, end, resv_region_end;
> +
> +	start = msi_base;
> +	end = start + length - 1;
> +	list_for_each_entry(region, resv_region_list, list) {
> +		resv_region_end = region->start + region->length - 1;
> +		/* overlap detected */
> +		if (!(start > resv_region_end || end <
> region->start))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t
> base); #else /* CONFIG_IOMMU_DMA */
>  static inline int iommu_get_msi_cookie(struct iommu_domain *domain,
> dma_addr_t base) {
>  	return -ENODEV;
>  }
> +
> +static inline bool resv_region_intersects(phys_addr_t msi_base,
> size_t length,
> +					  struct list_head
> *resv_region_list) +{
> +	return false;
> +}
>  #endif	/* CONFIG_IOMMU_DMA */
>  
>  /*

