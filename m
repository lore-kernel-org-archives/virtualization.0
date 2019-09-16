From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 0/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Mon, 16 Sep 2019 11:14:22 +0200
Message-ID: <6254f754-eb37-6b1e-deea-7443d185d49b__33618.7440248736$1568625278$gmane$org@redhat.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Thierry,

On 8/29/19 1:17 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Most IOMMU drivers only need to free the memory allocated for each
> reserved region. Instead of open-coding the loop to do this in each
> driver, extract the code into a common function that can be used by
> all these drivers.

If I am not wrong, all the drivers now use the
iommu_put_resv_regions_simple helper. So we can wonder if the callback
is still relevant?

Thanks

Eric
> 
> Thierry
> 
> Thierry Reding (5):
>   iommu: Implement iommu_put_resv_regions_simple()
>   iommu: arm: Use iommu_put_resv_regions_simple()
>   iommu: amd: Use iommu_put_resv_regions_simple()
>   iommu: intel: Use iommu_put_resv_regions_simple()
>   iommu: virt: Use iommu_put_resv_regions_simple()
> 
>  drivers/iommu/amd_iommu.c    | 11 +----------
>  drivers/iommu/arm-smmu-v3.c  | 11 +----------
>  drivers/iommu/arm-smmu.c     | 11 +----------
>  drivers/iommu/intel-iommu.c  | 11 +----------
>  drivers/iommu/iommu.c        | 19 +++++++++++++++++++
>  drivers/iommu/virtio-iommu.c | 14 +++-----------
>  include/linux/iommu.h        |  2 ++
>  7 files changed, 28 insertions(+), 51 deletions(-)
> 
