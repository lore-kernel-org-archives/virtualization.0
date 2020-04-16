From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Date: Thu, 16 Apr 2020 13:48:46 +0200
Message-ID: <551c48b8-3268-6034-2dc6-cec3dbbec250@samsung.com>
References: <CGME20200414131600eucas1p16f1ff6aedb780eb795a770dc08e5dec5@eucas1p1.samsung.com>
 <20200414131542.25608-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20200414131542.25608-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

On 14.04.2020 15:15, Joerg Roedel wrote:
> here is the second version of this patch-set. The first version with
> some more introductory text can be found here:
>
> 	https://lore.kernel.org/lkml/20200407183742.4344-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/
>
> Changes v1->v2:
>
> 	* Rebased to v5.7-rc1
>
> 	* Re-wrote the arm-smmu changes as suggested by Robin Murphy
>
> 	* Re-worked the Exynos patches to hopefully not break the
> 	  driver anymore

Thanks for this rework. This version is much better. Works fine on 
various Exynos-based boards (ARM and ARM64).

Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> (for Exynos and 
core changes)

> 	* Fixed a missing mutex_unlock() reported by Marek Szyprowski,
> 	  thanks for that.
>
> There is also a git-branch available with these patches applied:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
>
> Please review.
>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (32):
>    iommu: Move default domain allocation to separate function
>    iommu/amd: Implement iommu_ops->def_domain_type call-back
>    iommu/vt-d: Wire up iommu_ops->def_domain_type
>    iommu/amd: Remove dma_mask check from check_device()
>    iommu/amd: Return -ENODEV in add_device when device is not handled by
>      IOMMU
>    iommu: Add probe_device() and remove_device() call-backs
>    iommu: Move default domain allocation to iommu_probe_device()
>    iommu: Keep a list of allocated groups in __iommu_probe_device()
>    iommu: Move new probe_device path to separate function
>    iommu: Split off default domain allocation from group assignment
>    iommu: Move iommu_group_create_direct_mappings() out of
>      iommu_group_add_device()
>    iommu: Export bus_iommu_probe() and make is safe for re-probing
>    iommu/amd: Remove dev_data->passthrough
>    iommu/amd: Convert to probe/release_device() call-backs
>    iommu/vt-d: Convert to probe/release_device() call-backs
>    iommu/arm-smmu: Convert to probe/release_device() call-backs
>    iommu/pamu: Convert to probe/release_device() call-backs
>    iommu/s390: Convert to probe/release_device() call-backs
>    iommu/virtio: Convert to probe/release_device() call-backs
>    iommu/msm: Convert to probe/release_device() call-backs
>    iommu/mediatek: Convert to probe/release_device() call-backs
>    iommu/mediatek-v1 Convert to probe/release_device() call-backs
>    iommu/qcom: Convert to probe/release_device() call-backs
>    iommu/rockchip: Convert to probe/release_device() call-backs
>    iommu/tegra: Convert to probe/release_device() call-backs
>    iommu/renesas: Convert to probe/release_device() call-backs
>    iommu/omap: Remove orphan_dev tracking
>    iommu/omap: Convert to probe/release_device() call-backs
>    iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
>    iommu/exynos: Convert to probe/release_device() call-backs
>    iommu: Remove add_device()/remove_device() code-paths
>    iommu: Unexport iommu_group_get_for_dev()
>
> Sai Praneeth Prakhya (1):
>    iommu: Add def_domain_type() callback in iommu_ops
>
>   drivers/iommu/amd_iommu.c       |  97 ++++----
>   drivers/iommu/amd_iommu_types.h |   1 -
>   drivers/iommu/arm-smmu-v3.c     |  38 +--
>   drivers/iommu/arm-smmu.c        |  39 ++--
>   drivers/iommu/exynos-iommu.c    |  24 +-
>   drivers/iommu/fsl_pamu_domain.c |  22 +-
>   drivers/iommu/intel-iommu.c     |  68 +-----
>   drivers/iommu/iommu.c           | 393 +++++++++++++++++++++++++-------
>   drivers/iommu/ipmmu-vmsa.c      |  60 ++---
>   drivers/iommu/msm_iommu.c       |  34 +--
>   drivers/iommu/mtk_iommu.c       |  24 +-
>   drivers/iommu/mtk_iommu_v1.c    |  50 ++--
>   drivers/iommu/omap-iommu.c      |  99 ++------
>   drivers/iommu/qcom_iommu.c      |  24 +-
>   drivers/iommu/rockchip-iommu.c  |  26 +--
>   drivers/iommu/s390-iommu.c      |  22 +-
>   drivers/iommu/tegra-gart.c      |  24 +-
>   drivers/iommu/tegra-smmu.c      |  31 +--
>   drivers/iommu/virtio-iommu.c    |  41 +---
>   include/linux/iommu.h           |  21 +-
>   20 files changed, 533 insertions(+), 605 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
