From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 10/15] iommu/arm-smmu: Use accessor functions for iommu
 private data
Date: Mon, 16 Mar 2020 18:55:15 +0100
Message-ID: <20200316175515.GP304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-11-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-11-joro@8bytes.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 10:12:24AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions and simplify the code
> where possible with this change.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
[...]
> @@ -1467,7 +1470,7 @@ static void arm_smmu_remove_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>  		return;
>  
> -	cfg  = fwspec->iommu_priv;
> +	cfg  = dev_iommu_priv_get(dev);
>  	smmu = cfg->smmu;
>  
>  	ret = arm_smmu_rpm_get(smmu);
> @@ -1475,23 +1478,22 @@ static void arm_smmu_remove_device(struct device *dev)
>  		return;
>  
>  	iommu_device_unlink(&smmu->iommu, dev);
> -	arm_smmu_master_free_smes(fwspec);
> +	arm_smmu_master_free_smes(dev);
>  
>  	arm_smmu_rpm_put(smmu);
>  
>  	iommu_group_remove_device(dev);
> -	kfree(fwspec->iommu_priv);
>  	iommu_fwspec_free(dev);
> +	kfree(cfg);

nit: cfg is allocated after fwspec so it might be cleaner to free cfg
before fwspec.

But more importantly, should we clear the private data here and in the
other drivers, by calling dev_iommu_priv_set(dev, NULL) from
remove_device()?  We are leaving stale pointers in dev->iommu and I think
some of the drivers could end up reusing them.

Thanks,
Jean
