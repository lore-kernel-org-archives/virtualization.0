Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A57219A79;
	Thu, 18 Sep 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214186; cv=none; b=mEGY0k1dpzshElbcxNw32CCci/kY3iPVtkdOAYUsZHBHSntyR+A5FDOM6hiWn1rzMBO8P6C0pEuRvwvXWWy4pZarOb6jlfMoBbReY3bUw3sHrkKAJFXF01rwqkvTE9hi7FkWQ6/PRWhNspxw7fMI4AwvYnnUqIZ6tIU1jZK4JdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214186; c=relaxed/simple;
	bh=8OuWAH6OvinDsM3HZFF+ftHMzLteFxBCpGaW+ema4Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4OE+fhaf4O5Cx29/3nQTCPSnyUg0258Z+3Z9PbKYLa/v3RZQ5xMpgWhEZSs2+CGifStWdsBnEvrlrhU2fiNCs19bpQGxXECm3MXmwWRl32gBDGu2VTsYrlZabGGkGN79ppu+ByLNghtrF1rTDIPnaEcmdUnS5+3eMiCd8W7+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhkSqZ0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhkSqZ0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAD2C4CEE7;
	Thu, 18 Sep 2025 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214186;
	bh=8OuWAH6OvinDsM3HZFF+ftHMzLteFxBCpGaW+ema4Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhkSqZ0RmKMoDqAaFQQbP8Dedsoke4YsdpJ+eT+BNeZBOKu6GoLC4mV5fyKlSj22V
	 7O0M1l7sGbCN1coRUo5Y128lXr8FnrJb+JB6tYZ2+H8A5EYXG99fgoGXtkNgj+c6Qm
	 qNPM0lAXmCKkUqjXFZlCKmR7yieAEwWyAW6LAih45owBDXF6kqosW+POMFzAA6PacD
	 153lrIBqKlSGd6wlcFbCihifTBnEdEbNFwmwivOFJI+z8AukyS9luPcW9jQGQ5G1DL
	 bxFMZMMUHVfWjU2lYn85Yv7UrECeA1J2GV6Tf7NCem2OafCWJ37XPnQOfszsdBOxdK
	 64C0fcYteJRug==
Date: Thu, 18 Sep 2025 17:49:39 +0100
From: Will Deacon <will@kernel.org>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com, saravanak@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lizhi.hou@amd.com,
	clement.leger@bootlin.com
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Message-ID: <aMw4I0AjKNPY6SOw@willie-the-truck>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909154600.910110-4-shyamsaini@linux.microsoft.com>

On Tue, Sep 09, 2025 at 08:45:59AM -0700, Shyam Saini wrote:
> Currently ARM SMMU drivers hardcode PCI MSI IOVA address.
> Not all the platform have same memory mappings and some platform
> could have this address already being mapped for something else.
> This can lead to collision and as a consequence the MSI IOVA addr
> range is never reserved.
> 
> Fix this by reserving faulty IOVA range and selecting alternate MSI_IOVA
> suitable for the intended platform.
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
> }
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 27 ++++++++++++-----
>  include/linux/iommu.h                       | 33 +++++++++++++++++++++
>  3 files changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2a8b46b948f05..748a5513c5dbb 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3642,17 +3642,32 @@ static int arm_smmu_of_xlate(struct device *dev,
>  static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
>  
>  	iommu_dma_get_resv_regions(dev, head);
> +
> +	/*
> +	 * Use the first msi_base that does not intersect with a platform
> +	 * reserved region. The SW MSI base selection is entirely arbitrary.
> +	 */
> +	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
> +		struct iommu_resv_region *region;
> +
> +		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
> +			continue;
> +
> +		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
> +						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
> +		if (!region) {
> +			pr_warn("IOMMU: Failed to reserve MSI IOVA: No suitable MSI IOVA range available");
> +			return;
> +		}
> +
> +		list_add_tail(&region->list, head);
> +		return;
> +	}
>  }
>  
>  /*
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4a07650911991..84b74b8519386 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1600,17 +1600,30 @@ static int arm_smmu_of_xlate(struct device *dev,
>  static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
>  
>  	iommu_dma_get_resv_regions(dev, head);
> +
> +	/*
> +	 * Use the first msi_base that does not intersect with a platform
> +	 * reserved region. The SW MSI base selection is entirely arbitrary.
> +	 */
> +	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
> +		struct iommu_resv_region *region;
> +
> +		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
> +			continue;
> +
> +		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
> +						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +		return;
> +	}

Given that we're walking over the reserved regions to see if we have a
collision with MSI_IOVA_BASE, why not allocate the base address
dynamically if we detect a collision rather than having yet another
hard-coded address which we can't guarantee won't be problematic in future?

Will
