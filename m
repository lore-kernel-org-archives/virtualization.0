From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V5 4/5] iommu/dma-iommu: Use the dev->coherent_dma_mask
Date: Mon, 19 Aug 2019 19:39:23 +0100
Message-ID: <d3c8d4ce-8ffb-bf69-a8f3-d64108f5987a__28972.0361166232$1566239981$gmane$org@arm.com>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
	<20190815110944.3579-5-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190815110944.3579-5-murphyt7@tcd.ie>
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
> Use the dev->coherent_dma_mask when allocating in the dma-iommu ops api.

Oops... I suppose technically that's my latent bug, but since we've all 
missed it so far, I doubt arm64 systems ever see any devices which 
actually have different masks.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>   drivers/iommu/dma-iommu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 906b7fa14d3c..b9a3ab02434b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -471,7 +471,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot)
> +		size_t size, int prot, dma_addr_t dma_mask)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -484,7 +484,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   
>   	size = iova_align(iovad, size + iova_off);
>   
> -	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> +	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
>   	if (!iova)
>   		return DMA_MAPPING_ERROR;
>   
> @@ -735,7 +735,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	dma_addr_t dma_handle;
>   
> -	dma_handle = __iommu_dma_map(dev, phys, size, prot);
> +	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   	    dma_handle != DMA_MAPPING_ERROR)
>   		arch_sync_dma_for_device(dev, phys, size, dir);
> @@ -938,7 +938,8 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	return __iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
> +			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> +			dma_get_mask(dev));
>   }
>   
>   static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> @@ -1041,7 +1042,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	if (!cpu_addr)
>   		return NULL;
>   
> -	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
> +	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
> +			dev->coherent_dma_mask);
>   	if (*handle == DMA_MAPPING_ERROR) {
>   		__iommu_dma_free(dev, size, cpu_addr);
>   		return NULL;
> 
