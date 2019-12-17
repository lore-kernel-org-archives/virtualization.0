From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Tue, 17 Dec 2019 11:08:50 +0100
Message-ID: <20191217100850.GI8689__34216.7403128528$1576577347$gmane$org@8bytes.org>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Thierry

On Mon, Dec 09, 2019 at 03:50:02PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Most IOMMU drivers only need to free the memory allocated for each
> reserved region. Instead of open-coding the loop to do this in each
> driver, extract the code into a common function that can be used by
> all these drivers.
> 
> Changes in v2:
> - change subject prefix to "iommu: virtio: " for virtio-iommu.c driver
> 
> Thierry
> 
> Thierry Reding (5):
>   iommu: Implement iommu_put_resv_regions_simple()
>   iommu: arm: Use iommu_put_resv_regions_simple()
>   iommu: amd: Use iommu_put_resv_regions_simple()
>   iommu: intel: Use iommu_put_resv_regions_simple()
>   iommu: virtio: Use iommu_put_resv_regions_simple()

Thanks, that is a nice consolidation. Just a minor nit, can you please
rename iommu_put_resv_regions_simple to
generic_iommu_put_resv_regsions(). That matches the naming in other
places where we have done similar things.

Thanks,

	Joerg
