From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 2/3] iommu/virtio: Fix freeing of incomplete domains
Date: Thu, 26 Mar 2020 12:09:32 +0000
Message-ID: <9d5f4c7d-e4ce-6351-fcd3-520eb7d5a963@arm.com>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
 <20200326093558.2641019-3-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200326093558.2641019-3-jean-philippe@linaro.org>
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
> Calling viommu_domain_free() on a domain that hasn't been finalised (not
> attached to any device, for example) can currently cause an Oops,
> because we attempt to call ida_free() on ID 0, which may either be
> unallocated or used by another domain.
> 
> Only initialise the vdomain->viommu pointer, which denotes a finalised
> domain, at the end of a successful viommu_domain_finalise().

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/virtio-iommu.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index cce329d71fba..5eed75cd121f 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -613,18 +613,20 @@ static int viommu_domain_finalise(struct viommu_dev *viommu,
>   	int ret;
>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
>   
> -	vdomain->viommu		= viommu;
> -	vdomain->map_flags	= viommu->map_flags;
> +	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> +			      viommu->last_domain, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	vdomain->id		= (unsigned int)ret;
>   
>   	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
>   	domain->geometry	= viommu->geometry;
>   
> -	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> -			      viommu->last_domain, GFP_KERNEL);
> -	if (ret >= 0)
> -		vdomain->id = (unsigned int)ret;
> +	vdomain->map_flags	= viommu->map_flags;
> +	vdomain->viommu		= viommu;
>   
> -	return ret > 0 ? 0 : ret;
> +	return 0;
>   }
>   
>   static void viommu_domain_free(struct iommu_domain *domain)
> 
