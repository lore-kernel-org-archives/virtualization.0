From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule larger
 than PAGE_SIZE
Date: Thu, 26 Mar 2020 12:13:21 +0000
Message-ID: <66e665bc-bc33-8bda-331d-270b43cbe36d@arm.com>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
 <20200326093558.2641019-4-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200326093558.2641019-4-jean-philippe@linaro.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org
Cc: bbhushan2@marvell.com, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 2020-03-26 9:35 am, Jean-Philippe Brucker wrote:
> We don't currently support IOMMUs with a page granule larger than the
> system page size. The IOVA allocator has a BUG_ON() in this case, and
> VFIO has a WARN_ON().
> 
> Removing these obstacles ranges doesn't seem possible without major
> changes to the DMA API and VFIO. Some callers of iommu_map(), for
> example, want to map multiple page-aligned regions adjacent to each
> others for scatter-gather purposes. Even in simple DMA API uses, a call
> to dma_map_page() would let the endpoint access neighbouring memory. And
> VFIO users cannot ensure that their virtual address buffer is physically
> contiguous at the IOMMU granule.
> 
> Rather than triggering the IOVA BUG_ON() on mismatched page sizes, abort
> the vdomain finalise() with an error message. We could simply abort the
> viommu probe(), but an upcoming extension to virtio-iommu will allow
> setting different page masks for each endpoint.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reported-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: Move to vdomain_finalise(), improve commit message
> ---
>   drivers/iommu/virtio-iommu.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 5eed75cd121f..750f69c49b95 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -607,12 +607,22 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>   	return &vdomain->domain;
>   }
>   
> -static int viommu_domain_finalise(struct viommu_dev *viommu,
> +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>   				  struct iommu_domain *domain)
>   {
>   	int ret;
> +	unsigned long viommu_page_size;
> +	struct viommu_dev *viommu = vdev->viommu;
>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
>   
> +	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> +	if (viommu_page_size > PAGE_SIZE) {
> +		dev_err(vdev->dev,
> +			"granule 0x%lx larger than system page size 0x%lx\n",
> +			viommu_page_size, PAGE_SIZE);
> +		return -EINVAL;
> +	}
> +
>   	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
>   			      viommu->last_domain, GFP_KERNEL);
>   	if (ret < 0)
> @@ -659,7 +669,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		 * Properly initialize the domain now that we know which viommu
>   		 * owns it.
>   		 */
> -		ret = viommu_domain_finalise(vdev->viommu, domain);
> +		ret = viommu_domain_finalise(vdev, domain);
>   	} else if (vdomain->viommu != vdev->viommu) {
>   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
>   		ret = -EXDEV;
> 
