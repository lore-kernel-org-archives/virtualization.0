From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 15/15] iommu: Move fwspec->iommu_priv to struct dev_iommu
Date: Mon, 16 Mar 2020 16:57:56 +0100
Message-ID: <20200316155756.GO304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-16-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-16-joro@8bytes.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 10:12:29AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move the pointer for iommu private data from struct iommu_fwspec to
> struct dev_iommu.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 056900e75758..8c4d45fce042 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -369,6 +369,7 @@ struct iommu_fault_param {
>   *
>   * @fault_param: IOMMU detected device fault reporting data
>   * @fwspec:	 IOMMU fwspec data
> + * @priv:	 IOMMU Driver private data
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -377,6 +378,7 @@ struct dev_iommu {
>  	struct mutex lock;
>  	struct iommu_fault_param	*fault_param;
>  	struct iommu_fwspec		*fwspec;
> +	void				*priv;
>  };
>  
>  int  iommu_device_register(struct iommu_device *iommu);
> @@ -589,7 +591,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>  struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
> -	void			*iommu_priv;
>  	u32			flags;
>  	u32			num_pasid_bits;
>  	unsigned int		num_ids;
> @@ -629,12 +630,12 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
>  
>  static inline void *dev_iommu_priv_get(struct device *dev)
>  {
> -	return dev->iommu->fwspec->iommu_priv;
> +	return dev->iommu->priv;
>  }
>  
>  static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>  {
> -	dev->iommu->fwspec->iommu_priv = priv;
> +	dev->iommu->priv = priv;
>  }
>  
>  int iommu_probe_device(struct device *dev);
> -- 
> 2.17.1
> 
