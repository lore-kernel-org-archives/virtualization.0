From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Date: Thu, 26 Apr 2018 13:43:09 +0300
Message-ID: <2767328.18DNhHKilX__36431.7390755334$1524739802$gmane$org@avalon>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426102819.6985-1-vthakkar1994@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, alexandre.belloni@bootlin.com, heiko@sntech.de, airlied@linux.ie, gustavo@padovan.org, linus.walleij@linaro.org, joonas.lahtinen@linux.intel.com, stefan@agner.ch, hjc@rock-chips.com, eric@anholt.net, thierry.reding@gmail.com, nouveau@lists.freedesktop.org, freedreno@lists.freedesktop.org, marex@denx.de, David1.Zhou@amd.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, linux-rockchip@lists.infradead.org, tomi.valkeinen@ti.com, linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com, z.liuxinliang@hisilicon.com, maxime.ripard@bootlin.com, kong.kongxinwei@hisilicon.com, kgene@kernel.org, bskeggs@redhat.com, linux-arm-msm@vger.kernel.org, ck.hu@mediatek.com, airlied@redhat.com, virtualization@lists.linux-foundation.org, robdclark@gmail.com, linux-tegra@vger.kernel.org, puck.chen@hisilicon.com, intel-gfx@lists.freedeskto
List-Id: virtualization@lists.linuxfoundation.org

Hi Vaishali,

Thank you for the patch.

On Thursday, 26 April 2018 13:28:19 EEST Vaishali Thakkar wrote:
> It's been a while since we introduced drm_dev{get/put} functions
> to replace reference/unreference in drm subsystem for the
> consistency purpose. So, with this patch, let's just replace
> all current use cases of drm_dev_unref() with drm_dev_put and remove
> the function itself.
> 
> Coccinelle was used for mass-patching.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

I love seeing deprecated functions go.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 ++--
>  drivers/gpu/drm/arc/arcpgu_drv.c                   |  4 ++--
>  drivers/gpu/drm/armada/armada_drv.c                |  6 +++---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  4 ++--
>  drivers/gpu/drm/drm_drv.c                          | 13 -------------
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  4 ++--
>  drivers/gpu/drm/exynos/exynos_drm_drv.c            |  4 ++--
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |  4 ++--
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  4 ++--
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  8 ++++----
>  drivers/gpu/drm/i915/selftests/huge_pages.c        |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c   |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_object.c   |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_request.c      |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_vma.c          |  2 +-
>  drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  2 +-
>  drivers/gpu/drm/imx/imx-drm-core.c                 |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  6 +++---
>  drivers/gpu/drm/msm/msm_drv.c                      |  8 ++++----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  4 ++--
>  drivers/gpu/drm/nouveau/nouveau_platform.c         |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.c                 |  4 ++--
>  drivers/gpu/drm/pl111/pl111_drv.c                  |  4 ++--
>  drivers/gpu/drm/qxl/qxl_drv.c                      |  2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  4 ++--
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c           |  4 ++--
>  drivers/gpu/drm/sti/sti_drv.c                      |  8 ++++----
>  drivers/gpu/drm/stm/drv.c                          |  4 ++--
>  drivers/gpu/drm/sun4i/sun4i_drv.c                  |  4 ++--
>  drivers/gpu/drm/tegra/drm.c                        |  4 ++--
>  drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |  6 +++---
>  drivers/gpu/drm/tve200/tve200_drv.c                |  4 ++--
>  drivers/gpu/drm/udl/udl_drv.c                      |  2 +-
>  drivers/gpu/drm/vc4/vc4_drv.c                      |  4 ++--
>  drivers/gpu/drm/vgem/vgem_drv.c                    |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drm_bus.c           |  2 +-
>  drivers/gpu/drm/zte/zx_drm_drv.c                   |  4 ++--
>  include/drm/drm_drv.h                              |  1 -
>  41 files changed, 73 insertions(+), 87 deletions(-)

-- 
Regards,

Laurent Pinchart
