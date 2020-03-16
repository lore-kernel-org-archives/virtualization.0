From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 01/15] iommu: Define dev_iommu_fwspec_get() for
 !CONFIG_IOMMU_API
Date: Mon, 16 Mar 2020 16:39:16 +0100
Message-ID: <20200316153916.GB304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-2-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-2-joro@8bytes.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 10:12:15AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> There are users outside of the IOMMU code that need to call that
> function. Define it for !CONFIG_IOMMU_API too so that compilation does
> not break.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

As a result drivers/gpu/host1x/hw/channel_hw.c and
drivers/gpu/drm/tegra/vic.c can lose their #ifdef CONFIG_IOMMU_API

> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d1b5f4d98569..3c4ca041d7a2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1073,6 +1073,10 @@ static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
>  	return -ENODEV;
>  }
>  
> +static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_DEBUGFS
> -- 
> 2.17.1
> 
