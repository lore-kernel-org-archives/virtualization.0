From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Wed, 18 Sep 2019 16:37:38 +0100
Message-ID: <20190918153737.dea2z5dddhuus25g__27343.9145459392$1568821075$gmane$org@willie-the-truck>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
	<20190829111752.17513-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190829111752.17513-2-thierry.reding@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 29, 2019 at 01:17:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Implement a generic function for removing reserved regions. This can be
> used by drivers that don't do anything fancy with these regions other
> than allocating memory for them.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  include/linux/iommu.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0f585b614657..73a2a6b13507 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  		ops->put_resv_regions(dev, list);
>  }
>  
> +/**
> + * iommu_put_resv_regions_simple - Reserved region driver helper
> + * @dev: device for which to free reserved regions
> + * @list: reserved region list for device
> + *
> + * IOMMU drivers can use this to implement their .put_resv_regions() callback
> + * for simple reservations. Memory allocated for each reserved region will be
> + * freed. If an IOMMU driver allocates additional resources per region, it is
> + * going to have to implement a custom callback.
> + */
> +void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, list, list)
> +		kfree(entry);
> +}
> +EXPORT_SYMBOL(iommu_put_resv_regions_simple);

Can you call this directly from iommu_put_resv_regions() if the function
pointer in ops is NULL? That would save having to plumb the default callback
into a bunch of drivers.

Will
