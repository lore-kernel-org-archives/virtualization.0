From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 11/15] iommu/renesas: Use accessor functions for iommu
 private data
Date: Mon, 16 Mar 2020 16:50:28 +0100
Message-ID: <20200316155028.GK304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-12-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-12-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 10:12:25AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ecb3f9464dd5..310cf09feea3 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -89,9 +89,7 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
>  
>  static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return fwspec ? fwspec->iommu_priv : NULL;
> +	return dev_iommu_priv_get(dev);

The removal of the fwspec NULL check was worrying me a little. Now any
user of to_ipmmu() directly dereferences dev->iommu->priv where they
previously tested first whether dev->fwspec was set. But I didn't find
anything that could go wrong, and the resulting code looks better.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  }
>  
>  #define TLB_LOOP_TIMEOUT		100	/* 100us */
> @@ -727,14 +725,13 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
>  static int ipmmu_init_platform_device(struct device *dev,
>  				      struct of_phandle_args *args)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct platform_device *ipmmu_pdev;
>  
>  	ipmmu_pdev = of_find_device_by_node(args->np);
>  	if (!ipmmu_pdev)
>  		return -ENODEV;
>  
> -	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
> +	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
