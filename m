From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V5 3/5] iommu/dma-iommu: Handle deferred devices
Date: Mon, 19 Aug 2019 19:26:08 +0100
Message-ID: <5a12defd-b68d-bd2d-da5a-16628a1f5b91__49391.6972934798$1566239187$gmane$org@arm.com>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
	<20190815110944.3579-4-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190815110944.3579-4-murphyt7@tcd.ie>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On 15/08/2019 12:09, Tom Murphy wrote:
> Handle devices which defer their attach to the iommu in the dma-iommu api

Other than nitpicking the name (I'd lean towards something like 
iommu_dma_deferred_attach),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>   drivers/iommu/dma-iommu.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2712fbc68b28..906b7fa14d3c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -22,6 +22,7 @@
>   #include <linux/pci.h>
>   #include <linux/scatterlist.h>
>   #include <linux/vmalloc.h>
> +#include <linux/crash_dump.h>
>   
>   struct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -351,6 +352,21 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
>   
> +static int handle_deferred_device(struct device *dev,
> +	struct iommu_domain *domain)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +
> +	if (!is_kdump_kernel())
> +		return 0;
> +
> +	if (unlikely(ops->is_attach_deferred &&
> +		ops->is_attach_deferred(domain, dev)))
> +		return iommu_attach_device(domain, dev);
> +
> +	return 0;
> +}
> +
>   /**
>    * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
>    *                    page flags.
> @@ -463,6 +479,9 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   	size_t iova_off = iova_offset(iovad, phys);
>   	dma_addr_t iova;
>   
> +	if (unlikely(handle_deferred_device(dev, domain)))
> +		return DMA_MAPPING_ERROR;
> +
>   	size = iova_align(iovad, size + iova_off);
>   
>   	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> @@ -581,6 +600,9 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>   
>   	*dma_handle = DMA_MAPPING_ERROR;
>   
> +	if (unlikely(handle_deferred_device(dev, domain)))
> +		return NULL;
> +
>   	min_size = alloc_sizes & -alloc_sizes;
>   	if (min_size < PAGE_SIZE) {
>   		min_size = PAGE_SIZE;
> @@ -713,7 +735,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	dma_addr_t dma_handle;
>   
> -	dma_handle =__iommu_dma_map(dev, phys, size, prot);
> +	dma_handle = __iommu_dma_map(dev, phys, size, prot);
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   	    dma_handle != DMA_MAPPING_ERROR)
>   		arch_sync_dma_for_device(dev, phys, size, dir);
> @@ -823,6 +845,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	unsigned long mask = dma_get_seg_boundary(dev);
>   	int i;
>   
> +	if (unlikely(handle_deferred_device(dev, domain)))
> +		return 0;
> +
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
>   
> 
