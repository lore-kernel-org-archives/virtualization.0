From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [Intel-gfx] [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Date: Thu, 26 Apr 2018 15:45:44 +0300
Message-ID: <1556510.Xu6NnhyFGZ__6808.08510301194$1524746640$gmane$org@avalon>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
	<20180426123615.GA12521@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426123615.GA12521@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: matthias.bgg@gmail, alexandre.belloni@bootlin.com, heiko@sntech.de, airlied@linux.ie, nouveau@lists.freedesktop.org, linus.walleij@linaro.org, stefan@agner.ch, virtualization@lists.linux-foundation.org, benjamin.gaignard@linaro.org, shawnguo@kernel.org, marex@denx.de, David1.Zhou@amd.com, maxime.ripard@bootlin.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com, z.liuxinliang@hisilicon.com, linux-rockchip@lists.infradead.org, kong.kongxinwei@hisilicon.com, tomi.valkeinen@ti.com, bskeggs@redhat.com, puck.chen@hisilicon.com, ck.hu@mediatek.com, airlied@redhat.com, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, nicolas.ferre@microchip.com, etnaviv@lists.freedesktop.org, brodkin@synopsys.com, zourongrong@gmail.com, linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel,

On Thursday, 26 April 2018 15:36:15 EEST Daniel Vetter wrote:
> On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
> > It's been a while since we introduced drm_dev{get/put} functions
> > to replace reference/unreference in drm subsystem for the
> > consistency purpose. So, with this patch, let's just replace
> > all current use cases of drm_dev_unref() with drm_dev_put and remove
> > the function itself.
> > 
> > Coccinelle was used for mass-patching.
> > 
> > Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> 
> Thanks for doing this. Unfortunately drm moves pretty fast, so already a
> conflict when I tried to apply this. Some drivers are also in their own
> trees, so this might lead to more fun :-/
> 
> Can you pls split it up per-driver (just the directories under
> drivers/gpu/drm/ is enough)? Final patch to remove the function might then
> get stalled a bit ofc.

I requested a single patch instead of splitting it per driver, you might want 
to blame me for that.

> Also can you pls update ./scripts/coccinelle/api/drm-get-put.cocci and
> remove that spatch hunk in the final patch, since we no longer need it?

How about just rerunning the coccinelle patch when it's time to apply this ? 
There's precedent for performing such automated changes, and it would ensure 
that no driver is left out.

> > ---
> > 
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 ++--
> >  drivers/gpu/drm/arc/arcpgu_drv.c                   |  4 ++--
> >  drivers/gpu/drm/armada/armada_drv.c                |  6 +++---
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |  4 ++--
> >  drivers/gpu/drm/drm_drv.c                          | 13 -------------
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  4 ++--
> >  drivers/gpu/drm/exynos/exynos_drm_drv.c            |  4 ++--
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |  4 ++--
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  4 ++--
> >  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  8 ++++----
> >  drivers/gpu/drm/i915/selftests/huge_pages.c        |  2 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c   |  2 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |  2 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  2 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem_object.c   |  2 +-
> >  drivers/gpu/drm/i915/selftests/i915_request.c      |  2 +-
> >  drivers/gpu/drm/i915/selftests/i915_vma.c          |  2 +-
> >  drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  2 +-
> >  drivers/gpu/drm/imx/imx-drm-core.c                 |  4 ++--
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  6 +++---
> >  drivers/gpu/drm/msm/msm_drv.c                      |  8 ++++----
> >  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  4 ++--
> >  drivers/gpu/drm/nouveau/nouveau_platform.c         |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_drv.c                 |  4 ++--
> >  drivers/gpu/drm/pl111/pl111_drv.c                  |  4 ++--
> >  drivers/gpu/drm/qxl/qxl_drv.c                      |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  4 ++--
> >  drivers/gpu/drm/shmobile/shmob_drm_drv.c           |  4 ++--
> >  drivers/gpu/drm/sti/sti_drv.c                      |  8 ++++----
> >  drivers/gpu/drm/stm/drv.c                          |  4 ++--
> >  drivers/gpu/drm/sun4i/sun4i_drv.c                  |  4 ++--
> >  drivers/gpu/drm/tegra/drm.c                        |  4 ++--
> >  drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |  6 +++---
> >  drivers/gpu/drm/tve200/tve200_drv.c                |  4 ++--
> >  drivers/gpu/drm/udl/udl_drv.c                      |  2 +-
> >  drivers/gpu/drm/vc4/vc4_drv.c                      |  4 ++--
> >  drivers/gpu/drm/vgem/vgem_drv.c                    |  2 +-
> >  drivers/gpu/drm/virtio/virtgpu_drm_bus.c           |  2 +-
> >  drivers/gpu/drm/zte/zx_drm_drv.c                   |  4 ++--
> >  include/drm/drm_drv.h                              |  1 -
> >  41 files changed, 73 insertions(+), 87 deletions(-)

-- 
Regards,

Laurent Pinchart
