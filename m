From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 7/7] drm: Split out drm_probe_helper.h
Date: Mon, 7 Jan 2019 10:45:23 +0100
Message-ID: <20190107094522.GU21184@phenom.ffwll.local>
References: <20181210100359.22507-1-daniel.vetter@ffwll.ch>
	<20181210101133.5364-1-daniel.vetter@ffwll.ch>
	<20181229225639.GC20342@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181229225639.GC20342@bart.dudau.co.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, etnaviv@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org, DRI Development <dri-devel@lists.freedesktop.org>, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, spice-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, xen-devel@lists.xen.org, freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 29, 2018 at 10:56:39PM +0000, Liviu Dudau wrote:
> On Mon, Dec 10, 2018 at 11:11:33AM +0100, Daniel Vetter wrote:
> > Having the probe helper stuff (which pretty much everyone needs) in
> > the drm_crtc_helper.h file (which atomic drivers should never need) is
> > confusing. Split them out.
> > =

> > To make sure I actually achieved the goal here I went through all
> > drivers. And indeed, all atomic drivers are now free of
> > drm_crtc_helper.h includes.
> > =

> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: etnaviv@lists.freedesktop.org
> > Cc: linux-samsung-soc@vger.kernel.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-amlogic@lists.infradead.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: freedreno@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Cc: spice-devel@lists.freedesktop.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Cc: linux-stm32@st-md-mailman.stormreply.com
> > Cc: linux-tegra@vger.kernel.org
> > Cc: xen-devel@lists.xen.org
> =

> Daniel, please fix whatever script you're using to generate the list
> of people being Cc-ed. ./scripts/get_maintainer.pl generates my work
> email address for HDLCD and the Mali DP maintainers for malidp changes,
> but we were not Cc-ed and I've only found this patch in the linux-rockchip
> ML because there was not enough traffic there to be hidden under other pa=
tches.

The number of Cc recipients this will generate is too much to be
acceptable for smtp servers. My scripts do generate the full lists, but
for patches like this here I need to delete a lot of them. So what I ended
up doing is deleting all the people and leaving the mailing lists behind.

Plan B would be to split this up into a massive per-driver patch series,
which I found overkill in this case. But for anything with functional
changes that's what I usually end up doing.

Hope that explains what happened.

btw the tool I'm using is dim add-missing-cc from the maintainer-tools
repos.

Cheers, Daniel

> =

> Best regards,
> Liviu
> =

> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
> >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
> >  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  2 +-
> >  .../display/amdgpu_dm/amdgpu_dm_services.c    |  2 +-
> >  drivers/gpu/drm/arc/arcpgu_crtc.c             |  2 +-
> >  drivers/gpu/drm/arc/arcpgu_drv.c              |  2 +-
> >  drivers/gpu/drm/arc/arcpgu_sim.c              |  2 +-
> >  drivers/gpu/drm/arm/hdlcd_crtc.c              |  2 +-
> >  drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
> >  drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
> >  drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
> >  drivers/gpu/drm/arm/malidp_mw.c               |  2 +-
> >  drivers/gpu/drm/armada/armada_510.c           |  2 +-
> >  drivers/gpu/drm/armada/armada_crtc.c          |  2 +-
> >  drivers/gpu/drm/armada/armada_drv.c           |  2 +-
> >  drivers/gpu/drm/armada/armada_fb.c            |  2 +-
> >  drivers/gpu/drm/ast/ast_drv.c                 |  1 +
> >  drivers/gpu/drm/ast/ast_mode.c                |  1 +
> >  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  2 +-
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  2 +-
> >  drivers/gpu/drm/bochs/bochs_drv.c             |  1 +
> >  drivers/gpu/drm/bochs/bochs_kms.c             |  1 +
> >  drivers/gpu/drm/bridge/adv7511/adv7511.h      |  2 +-
> >  drivers/gpu/drm/bridge/analogix-anx78xx.c     |  3 +-
> >  .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
> >  drivers/gpu/drm/bridge/cdns-dsi.c             |  2 +-
> >  drivers/gpu/drm/bridge/dumb-vga-dac.c         |  2 +-
> >  .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |  2 +-
> >  drivers/gpu/drm/bridge/nxp-ptn3460.c          |  2 +-
> >  drivers/gpu/drm/bridge/panel.c                |  2 +-
> >  drivers/gpu/drm/bridge/parade-ps8622.c        |  2 +-
> >  drivers/gpu/drm/bridge/sii902x.c              |  2 +-
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  2 +-
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  2 +-
> >  drivers/gpu/drm/bridge/tc358764.c             |  2 +-
> >  drivers/gpu/drm/bridge/tc358767.c             |  2 +-
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  2 +-
> >  drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
> >  drivers/gpu/drm/cirrus/cirrus_drv.c           |  1 +
> >  drivers/gpu/drm/cirrus/cirrus_mode.c          |  1 +
> >  drivers/gpu/drm/drm_atomic_helper.c           |  1 -
> >  drivers/gpu/drm/drm_dp_mst_topology.c         |  2 +-
> >  drivers/gpu/drm/drm_modeset_helper.c          |  2 +-
> >  drivers/gpu/drm/drm_probe_helper.c            |  2 +-
> >  drivers/gpu/drm/drm_simple_kms_helper.c       |  2 +-
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.h         |  1 -
> >  drivers/gpu/drm/exynos/exynos_dp.c            |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_crtc.c      |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_dpi.c       |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_drv.c       |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_dsi.c       |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_fb.c        |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_vidi.c      |  2 +-
> >  drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c    |  2 +-
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c     |  2 +-
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c   |  2 +-
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c     |  2 +-
> >  drivers/gpu/drm/gma500/psb_intel_drv.h        |  1 +
> >  .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    |  2 +-
> >  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
> >  .../gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c |  2 +-
> >  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |  2 +-
> >  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c  |  2 +-
> >  .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  2 +-
> >  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
> >  drivers/gpu/drm/i2c/ch7006_priv.h             |  2 +-
> >  drivers/gpu/drm/i2c/sil164_drv.c              |  2 +-
> >  drivers/gpu/drm/i2c/tda998x_drv.c             |  2 +-
> >  drivers/gpu/drm/i915/i915_drv.c               |  2 +-
> >  drivers/gpu/drm/i915/intel_crt.c              |  2 +-
> >  drivers/gpu/drm/i915/intel_display.c          |  2 +-
> >  drivers/gpu/drm/i915/intel_dp.c               |  2 +-
> >  drivers/gpu/drm/i915/intel_dp_mst.c           |  2 +-
> >  drivers/gpu/drm/i915/intel_drv.h              |  2 +-
> >  drivers/gpu/drm/imx/dw_hdmi-imx.c             |  2 +-
> >  drivers/gpu/drm/imx/imx-drm-core.c            |  2 +-
> >  drivers/gpu/drm/imx/imx-ldb.c                 |  2 +-
> >  drivers/gpu/drm/imx/imx-tve.c                 |  2 +-
> >  drivers/gpu/drm/imx/ipuv3-crtc.c              |  2 +-
> >  drivers/gpu/drm/imx/parallel-display.c        |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_dpi.c            |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_fb.c         |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_dsi.c            |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c           |  2 +-
> >  drivers/gpu/drm/meson/meson_crtc.c            |  2 +-
> >  drivers/gpu/drm/meson/meson_drv.c             |  2 +-
> >  drivers/gpu/drm/meson/meson_dw_hdmi.c         |  2 +-
> >  drivers/gpu/drm/meson/meson_venc_cvbs.c       |  2 +-
> >  drivers/gpu/drm/mgag200/mgag200_mode.c        |  1 +
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |  2 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  2 +-
> >  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     |  2 +-
> >  .../gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  2 +-
> >  .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  2 +-
> >  .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  2 +-
> >  .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  2 +-
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  2 +-
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  |  2 +-
> >  drivers/gpu/drm/msm/msm_drv.h                 |  2 +-
> >  drivers/gpu/drm/msm/msm_fb.c                  |  2 +-
> >  drivers/gpu/drm/mxsfb/mxsfb_crtc.c            |  2 +-
> >  drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
> >  drivers/gpu/drm/mxsfb/mxsfb_out.c             |  2 +-
> >  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c     |  1 +
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c       |  2 +-
> >  drivers/gpu/drm/nouveau/nouveau_connector.c   |  1 +
> >  drivers/gpu/drm/nouveau/nouveau_display.c     |  1 +
> >  drivers/gpu/drm/omapdrm/omap_connector.c      |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_crtc.c           |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_drv.h            |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_encoder.c        |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_fb.c             |  2 +-
> >  drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
> >  drivers/gpu/drm/qxl/qxl_display.c             |  2 +-
> >  drivers/gpu/drm/qxl/qxl_drv.c                 |  3 +-
> >  drivers/gpu/drm/qxl/qxl_fb.c                  |  2 +-
> >  drivers/gpu/drm/qxl/qxl_kms.c                 |  2 +-
> >  drivers/gpu/drm/radeon/radeon_acpi.c          |  1 +
> >  drivers/gpu/drm/radeon/radeon_connectors.c    |  1 +
> >  drivers/gpu/drm/radeon/radeon_device.c        |  1 +
> >  drivers/gpu/drm/radeon/radeon_display.c       |  1 +
> >  drivers/gpu/drm/radeon/radeon_dp_mst.c        |  1 +
> >  drivers/gpu/drm/radeon/radeon_drv.c           |  1 +
> >  drivers/gpu/drm/radeon/radeon_irq_kms.c       |  1 +
> >  drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  2 +-
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c           |  2 +-
> >  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  2 +-
> >  drivers/gpu/drm/rockchip/cdn-dp-core.c        |  2 +-
> >  drivers/gpu/drm/rockchip/cdn-dp-core.h        |  2 +-
> >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  2 +-
> >  drivers/gpu/drm/rockchip/inno_hdmi.c          |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_psr.c   |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_lvds.c      |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_rgb.c       |  2 +-
> >  drivers/gpu/drm/sti/sti_crtc.c                |  2 +-
> >  drivers/gpu/drm/sti/sti_drv.c                 |  2 +-
> >  drivers/gpu/drm/sti/sti_dvo.c                 |  2 +-
> >  drivers/gpu/drm/sti/sti_hda.c                 |  2 +-
> >  drivers/gpu/drm/sti/sti_hdmi.c                |  2 +-
> >  drivers/gpu/drm/sti/sti_tvout.c               |  2 +-
> >  drivers/gpu/drm/stm/drv.c                     |  2 +-
> >  drivers/gpu/drm/stm/ltdc.c                    |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_backend.c         |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_crtc.c            |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c        |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_lvds.c            |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_rgb.c             |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c            |  2 +-
> >  drivers/gpu/drm/sun4i/sun4i_tv.c              |  2 +-
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  2 +-
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  2 +-
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c           |  2 +-
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  2 +-
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  2 +-
> >  drivers/gpu/drm/tegra/drm.h                   |  2 +-
> >  drivers/gpu/drm/tegra/hdmi.c                  |  2 +-
> >  drivers/gpu/drm/tegra/hub.c                   |  2 +-
> >  drivers/gpu/drm/tinydrm/core/tinydrm-core.c   |  2 +-
> >  drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c   |  2 +-
> >  drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
> >  drivers/gpu/drm/udl/udl_connector.c           |  1 +
> >  drivers/gpu/drm/udl/udl_drv.c                 |  1 +
> >  drivers/gpu/drm/udl/udl_main.c                |  1 +
> >  drivers/gpu/drm/vc4/vc4_crtc.c                |  2 +-
> >  drivers/gpu/drm/vc4/vc4_dpi.c                 |  2 +-
> >  drivers/gpu/drm/vc4/vc4_dsi.c                 |  2 +-
> >  drivers/gpu/drm/vc4/vc4_hdmi.c                |  2 +-
> >  drivers/gpu/drm/vc4/vc4_kms.c                 |  2 +-
> >  drivers/gpu/drm/vc4/vc4_txp.c                 |  2 +-
> >  drivers/gpu/drm/vc4/vc4_vec.c                 |  2 +-
> >  drivers/gpu/drm/virtio/virtgpu_display.c      |  2 +-
> >  drivers/gpu/drm/virtio/virtgpu_drv.h          |  2 +-
> >  drivers/gpu/drm/vkms/vkms_crtc.c              |  2 +-
> >  drivers/gpu/drm/vkms/vkms_drv.c               |  2 +-
> >  drivers/gpu/drm/vkms/vkms_output.c            |  2 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h           |  2 +-
> >  drivers/gpu/drm/xen/xen_drm_front.c           |  2 +-
> >  drivers/gpu/drm/xen/xen_drm_front_conn.c      |  2 +-
> >  drivers/gpu/drm/xen/xen_drm_front_gem.c       |  2 +-
> >  drivers/gpu/drm/xen/xen_drm_front_kms.c       |  2 +-
> >  drivers/gpu/drm/zte/zx_drm_drv.c              |  2 +-
> >  drivers/gpu/drm/zte/zx_hdmi.c                 |  2 +-
> >  drivers/gpu/drm/zte/zx_tvenc.c                |  2 +-
> >  drivers/gpu/drm/zte/zx_vga.c                  |  2 +-
> >  drivers/gpu/drm/zte/zx_vou.c                  |  2 +-
> >  drivers/staging/vboxvideo/vbox_irq.c          |  2 +-
> >  drivers/staging/vboxvideo/vbox_mode.c         |  2 +-
> >  include/drm/drm_crtc_helper.h                 | 16 ------
> >  include/drm/drm_probe_helper.h                | 50 +++++++++++++++++++
> >  208 files changed, 256 insertions(+), 200 deletions(-)
> >  create mode 100644 include/drm/drm_probe_helper.h
> > =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_connectors.c
> > index 69ad6ec0a4f3..f0d36787d8d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> > @@ -25,7 +25,7 @@
> >   */
> >  #include <drm/drmP.h>
> >  #include <drm/drm_edid.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/amdgpu_drm.h>
> >  #include "amdgpu.h"
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index e669297ffefb..04688272d3e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -30,7 +30,7 @@
> >  #include <linux/console.h>
> >  #include <linux/slab.h>
> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/amdgpu_drm.h>
> >  #include <linux/vgaarb.h>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 90f474f98b6e..345e076902aa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -32,7 +32,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/vga_switcheroo.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "amdgpu.h"
> >  #include "amdgpu_irq.h"
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_mode.h
> > index aadd0fa42e43..2c99ef35db79 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > @@ -36,6 +36,7 @@
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_fixed.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <linux/i2c.h>
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index 39997d977efb..78173311f718 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -29,7 +29,7 @@
> >  #include <linux/i2c.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/amdgpu_drm.h>
> >  #include <drm/drm_edid.h>
> >  =

> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> > index 9d2d6986b983..7ef99037167a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> > @@ -25,7 +25,7 @@
> >  #include <linux/acpi.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/amdgpu_drm.h>
> >  #include "dm_services.h"
> >  #include "amdgpu.h"
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> > index 516795342dd2..d915e8c8769b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> > @@ -27,7 +27,7 @@
> >  #include <linux/acpi.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/amdgpu_drm.h>
> >  #include "dm_services.h"
> >  #include "amdgpu.h"
> > diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/ar=
cpgu_crtc.c
> > index 62f51f70606d..6ba96415e683 100644
> > --- a/drivers/gpu/drm/arc/arcpgu_crtc.c
> > +++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
> > @@ -15,7 +15,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arc=
pgu_drv.c
> > index 206a76abf771..dc72648bd783 100644
> > --- a/drivers/gpu/drm/arc/arcpgu_drv.c
> > +++ b/drivers/gpu/drm/arc/arcpgu_drv.c
> > @@ -15,7 +15,7 @@
> >   */
> >  =

> >  #include <linux/clk.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c b/drivers/gpu/drm/arc/arc=
pgu_sim.c
> > index 68629e614990..7eae7850954b 100644
> > --- a/drivers/gpu/drm/arc/arcpgu_sim.c
> > +++ b/drivers/gpu/drm/arc/arcpgu_sim.c
> > @@ -14,7 +14,7 @@
> >   *
> >   */
> >  =

> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> >  #include "arcpgu.h"
> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdl=
cd_crtc.c
> > index e4d67b70244d..99c188de8651 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > @@ -13,7 +13,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlc=
d_drv.c
> > index dfad8d06d108..fba307c8afa5 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> > @@ -22,7 +22,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/ma=
lidp_crtc.c
> > index e1b72782848c..56aad288666e 100644
> > --- a/drivers/gpu/drm/arm/malidp_crtc.c
> > +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> > @@ -14,7 +14,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <linux/clk.h>
> >  #include <linux/pm_runtime.h>
> >  #include <video/videomode.h>
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/mal=
idp_drv.c
> > index 505f316a192e..ab50ad06e271 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > @@ -23,7 +23,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/mali=
dp_mw.c
> > index 91472e5e0c8b..041a64dc7167 100644
> > --- a/drivers/gpu/drm/arm/malidp_mw.c
> > +++ b/drivers/gpu/drm/arm/malidp_mw.c
> > @@ -8,7 +8,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drmP.h>
> > diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/arma=
da/armada_510.c
> > index 2f7c048c5361..0e91d27921bd 100644
> > --- a/drivers/gpu/drm/armada/armada_510.c
> > +++ b/drivers/gpu/drm/armada/armada_510.c
> > @@ -9,7 +9,7 @@
> >   */
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "armada_crtc.h"
> >  #include "armada_drm.h"
> >  #include "armada_hw.h"
> > diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/arm=
ada/armada_crtc.c
> > index da9360688b55..c68c3da9e17f 100644
> > --- a/drivers/gpu/drm/armada/armada_crtc.c
> > +++ b/drivers/gpu/drm/armada/armada_crtc.c
> > @@ -12,7 +12,7 @@
> >  #include <linux/platform_device.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include "armada_crtc.h"
> > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/arma=
da/armada_drv.c
> > index fa31589b4fc0..e660c5ca52ae 100644
> > --- a/drivers/gpu/drm/armada/armada_drv.c
> > +++ b/drivers/gpu/drm/armada/armada_drv.c
> > @@ -10,7 +10,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of_graph.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_of.h>
> >  #include "armada_crtc.h"
> > diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armad=
a/armada_fb.c
> > index 6bd638a54579..9029656d634d 100644
> > --- a/drivers/gpu/drm/armada/armada_fb.c
> > +++ b/drivers/gpu/drm/armada/armada_fb.c
> > @@ -5,7 +5,7 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include "armada_drm.h"
> > diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_dr=
v.c
> > index bf589c53b908..3871b39d4dea 100644
> > --- a/drivers/gpu/drm/ast/ast_drv.c
> > +++ b/drivers/gpu/drm/ast/ast_drv.c
> > @@ -30,6 +30,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "ast_drv.h"
> >  =

> > diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_m=
ode.c
> > index 8bb355d5d43d..97fed0627d1c 100644
> > --- a/drivers/gpu/drm/ast/ast_mode.c
> > +++ b/drivers/gpu/drm/ast/ast_mode.c
> > @@ -32,6 +32,7 @@
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "ast_drv.h"
> >  =

> >  #include "ast_tables.h"
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/g=
pu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > index 96f4082671fe..8070a558d7b1 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/pinctrl/consumer.h>
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drmP.h>
> >  =

> >  #include <video/videomode.h>
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu=
/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> > index 4cc1e03f0aee..70bd540d644e 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> > @@ -31,7 +31,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/=
bochs_drv.c
> > index f3dd66ae990a..e5a48e87b137 100644
> > --- a/drivers/gpu/drm/bochs/bochs_drv.c
> > +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <drm/drm_fb_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "bochs.h"
> >  =

> > diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/=
bochs_kms.c
> > index f87c284dd93d..5f1eb69dd167 100644
> > --- a/drivers/gpu/drm/bochs/bochs_kms.c
> > +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> > @@ -7,6 +7,7 @@
> >  =

> >  #include "bochs.h"
> >  #include <drm/drm_plane_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  static int defx =3D 1024;
> >  static int defy =3D 768;
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm=
/bridge/adv7511/adv7511.h
> > index 73d8ccb97742..b235d1633575 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > @@ -14,7 +14,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  =

> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  =

> >  #define ADV7511_REG_CHIP_REVISION		0x00
> > diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/dr=
m/bridge/analogix-anx78xx.c
> > index f8433c93f463..7df356b45057 100644
> > --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> > +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> > @@ -31,9 +31,10 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_edid.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "analogix-anx78xx.h"
> >  =

> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drive=
rs/gpu/drm/bridge/analogix/analogix_dp_core.c
> > index 753e96129ab7..c1da8ae3c408 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -26,7 +26,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_panel.h>
> >  =

> >  #include <drm/bridge/analogix_dp.h>
> > diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge=
/cdns-dsi.c
> > index ce9496d13986..48ed444cad50 100644
> > --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> > +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> > @@ -7,7 +7,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_panel.h>
> >  #include <video/mipi_display.h>
> > diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/br=
idge/dumb-vga-dac.c
> > index 9b706789a341..0805801f4e94 100644
> > --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > @@ -18,7 +18,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  struct dumb_vga {
> >  	struct drm_bridge	bridge;
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b=
/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > index 2136c97aeb8e..9687a1a0e737 100644
> > --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -36,7 +36,7 @@
> >  #include <linux/of.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drmP.h>
> >  =

> > diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bri=
dge/nxp-ptn3460.c
> > index a3e817abace1..a56306421bc7 100644
> > --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/of_gpio.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pa=
nel.c
> > index 7cbaba213ef6..caf12b8fd572 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -12,7 +12,7 @@
> >  #include <drm/drm_panel.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_connector.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> >  #include <drm/drm_panel.h>
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/b=
ridge/parade-ps8622.c
> > index 7334d1b62b71..483a7142c5ea 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> > @@ -26,7 +26,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  #include <drm/drmP.h>
> > diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/=
sii902x.c
> > index bfa902013aa4..61b1502f566c 100644
> > --- a/drivers/gpu/drm/bridge/sii902x.c
> > +++ b/drivers/gpu/drm/bridge/sii902x.c
> > @@ -30,7 +30,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  =

> >  #define SII902X_TPI_VIDEO_DATA			0x0
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi.c
> > index 64c3cf027518..360a7ec39861 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -25,7 +25,7 @@
> >  #include <drm/drm_of.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_encoder_slave.h>
> >  #include <drm/bridge/dw_hdmi.h>
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gp=
u/drm/bridge/synopsys/dw-mipi-dsi.c
> > index 2f4b145b73af..09a38ae81e52 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > @@ -19,7 +19,7 @@
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/bridge/dw_mipi_dsi.h>
> > diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge=
/tc358764.c
> > index afd491018bfc..282092019e82 100644
> > --- a/drivers/gpu/drm/bridge/tc358764.c
> > +++ b/drivers/gpu/drm/bridge/tc358764.c
> > @@ -9,7 +9,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge=
/tc358767.c
> > index 8e28e738cb52..5c0ff4a16572 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -34,7 +34,7 @@
> >  #include <linux/slab.h>
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index 10243965ee7c..e74e2c928f51 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -6,7 +6,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridg=
e/ti-tfp410.c
> > index c3e32138c6bb..7bfb4f338813 100644
> > --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> > +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> > @@ -20,7 +20,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #define HOTPLUG_DEBOUNCE_MS		1100
> >  =

> > diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirr=
us/cirrus_drv.c
> > index db40b77c7f7c..8ec880f3a322 100644
> > --- a/drivers/gpu/drm/cirrus/cirrus_drv.c
> > +++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/console.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "cirrus_drv.h"
> >  =

> > diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cir=
rus/cirrus_mode.c
> > index ed7dcf212a34..a830e70fc0bb 100644
> > --- a/drivers/gpu/drm/cirrus/cirrus_mode.c
> > +++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
> > @@ -17,6 +17,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include <video/cirrus.h>
> >  =

> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index 69cbafd5ebee..54417fce5e5c 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -29,7 +29,6 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_uapi.h>
> >  #include <drm/drm_plane_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_writeback.h>
> >  #include <drm/drm_damage_helper.h>
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/dr=
m_dp_mst_topology.c
> > index a9b684f14d14..5f8b80b0bad4 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -33,7 +33,7 @@
> >  #include <drm/drm_fixed.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  /**
> >   * DOC: dp mst helper
> > diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm=
_modeset_helper.c
> > index 9150fa385bba..6f48137d7192 100644
> > --- a/drivers/gpu/drm/drm_modeset_helper.c
> > +++ b/drivers/gpu/drm/drm_modeset_helper.c
> > @@ -21,7 +21,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_modeset_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_p=
robe_helper.c
> > index a1bb157bfdfa..c83fee652502 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -32,11 +32,11 @@
> >  #include <linux/export.h>
> >  #include <linux/moduleparam.h>
> >  =

> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_client.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_fourcc.h>
> > -#include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> > diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/=
drm_simple_kms_helper.c
> > index 917812448d1b..9fc26a69ab79 100644
> > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > @@ -10,7 +10,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_simple_kms_helper.h>
> >  #include <linux/slab.h>
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/et=
naviv/etnaviv_drv.h
> > index 8d02d1b7dcf5..ea743d4fa3f8 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > @@ -21,7 +21,6 @@
> >  #include <linux/mm_types.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/etnaviv_drm.h>
> > diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exyno=
s/exynos_dp.c
> > index c8449ae4f4fe..6b23a1caeedc 100644
> > --- a/drivers/gpu/drm/exynos/exynos_dp.c
> > +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> > @@ -23,7 +23,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  =

> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm=
/exynos/exynos_drm_crtc.c
> > index 2696289ecc78..12d3816356ef 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> > @@ -13,7 +13,7 @@
> >   */
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_encoder.h>
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/=
exynos/exynos_drm_dpi.c
> > index 2f0babb67c51..fa95af1dc534 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> > @@ -11,7 +11,7 @@
> >  */
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_panel.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/=
exynos/exynos_drm_drv.c
> > index 2c75e789b2a7..a941d64875f6 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > @@ -15,7 +15,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  =

> >  #include <linux/component.h>
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/=
exynos/exynos_drm_dsi.c
> > index d81e62ae286a..8d28cdbfcddd 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> > @@ -13,7 +13,7 @@
> >  #include <asm/unaligned.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_panel.h>
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fb.c
> > index 31eb538a44ae..0dc1a688b502 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> > @@ -14,7 +14,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/dr=
m/exynos/exynos_drm_fbdev.c
> > index ce9604ca8041..f057082a9b30 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> > @@ -15,7 +15,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/exynos_drm.h>
> >  =

> >  #include <linux/console.h>
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm=
/exynos/exynos_drm_vidi.c
> > index 19697c1362d8..1b0e4e0f52fe 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> > @@ -20,7 +20,7 @@
> >  #include <drm/exynos_drm.h>
> >  =

> >  #include <drm/drm_edid.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> >  #include "exynos_drm_drv.h"
> > diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exy=
nos/exynos_hdmi.c
> > index 2092a650df7d..231f70b13b37 100644
> > --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> > @@ -16,7 +16,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_edid.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> >  #include "regs-hdmi.h"
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/d=
rm/fsl-dcu/fsl_dcu_drm_crtc.c
> > index 18afc94e4dff..bf256971063d 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> > @@ -16,7 +16,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <video/videomode.h>
> >  =

> >  #include "fsl_dcu_drm_crtc.h"
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/dr=
m/fsl-dcu/fsl_dcu_drm_drv.c
> > index ceddc3e29258..a66fa80be8e8 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> > @@ -24,7 +24,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/dr=
m/fsl-dcu/fsl_dcu_drm_kms.c
> > index ddc68e476a4d..741de83955ec 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
> > @@ -11,7 +11,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/=
drm/fsl-dcu/fsl_dcu_drm_plane.c
> > index 9554b245746e..593f9291b8e2 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> > @@ -14,7 +14,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/dr=
m/fsl-dcu/fsl_dcu_drm_rgb.c
> > index 2298ed2a9e1c..577fb1be2d59 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> > @@ -14,7 +14,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  =

> > diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/g=
ma500/psb_intel_drv.h
> > index e05e5399af2d..313552d2a69d 100644
> > --- a/drivers/gpu/drm/gma500/psb_intel_drv.h
> > +++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
> > @@ -23,6 +23,7 @@
> >  #include <linux/i2c-algo-bit.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <linux/gpio.h>
> >  #include "gma_display.h"
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/g=
pu/drm/hisilicon/hibmc/hibmc_drm_de.c
> > index a956545774a3..2ac593956529 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> > @@ -18,7 +18,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  =

> >  #include "hibmc_drm_drv.h"
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > index 68c0c297b3a5..85a701af6530 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > @@ -20,7 +20,7 @@
> >  #include <linux/module.h>
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "hibmc_drm_drv.h"
> >  #include "hibmc_drm_regs.h"
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/driver=
s/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> > index edcca1761500..c442aa2dd00f 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
> > @@ -17,7 +17,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  =

> >  #include "hibmc_drm_drv.h"
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers=
/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> > index 744956cea749..d2cf7317930a 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> > @@ -17,7 +17,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "hibmc_drm_drv.h"
> >  #include "hibmc_drm_regs.h"
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu=
/drm/hisilicon/kirin/dw_drm_dsi.c
> > index b4c7af3ab6ae..788ec1e53794 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> > +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> > @@ -19,7 +19,7 @@
> >  #include <linux/component.h>
> >  =

> >  #include <drm/drm_of.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_encoder_slave.h>
> >  #include <drm/drm_atomic_helper.h>
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/=
gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > index bb774202a5a1..8ad7ab7ece9f 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > @@ -24,7 +24,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/=
gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> > index e6a62d5a00a3..e0f410ce28b2 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> > +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> > @@ -24,7 +24,7 @@
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  =

> >  #include "kirin_drm_drv.h"
> > diff --git a/drivers/gpu/drm/i2c/ch7006_priv.h b/drivers/gpu/drm/i2c/ch=
7006_priv.h
> > index dc6414af5d79..591621b687de 100644
> > --- a/drivers/gpu/drm/i2c/ch7006_priv.h
> > +++ b/drivers/gpu/drm/i2c/ch7006_priv.h
> > @@ -28,7 +28,7 @@
> >  #define __DRM_I2C_CH7006_PRIV_H__
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder_slave.h>
> >  #include <drm/i2c/ch7006.h>
> >  =

> > diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil=
164_drv.c
> > index c52d7a3af786..14c1fc96a157 100644
> > --- a/drivers/gpu/drm/i2c/sil164_drv.c
> > +++ b/drivers/gpu/drm/i2c/sil164_drv.c
> > @@ -27,7 +27,7 @@
> >  #include <linux/module.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder_slave.h>
> >  #include <drm/i2c/sil164.h>
> >  =

> > diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/td=
a998x_drv.c
> > index a7c39f39793f..b98267792306 100644
> > --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> > +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> > @@ -26,7 +26,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/i2c/tda998x.h>
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i91=
5_drv.c
> > index b310a897a4ad..1e639dc886e5 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -42,7 +42,7 @@
> >  #include <acpi/video.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/i915_drm.h>
> >  =

> > diff --git a/drivers/gpu/drm/i915/intel_crt.c b/drivers/gpu/drm/i915/in=
tel_crt.c
> > index 68f2fb89ece3..4db30862a1cc 100644
> > --- a/drivers/gpu/drm/i915/intel_crt.c
> > +++ b/drivers/gpu/drm/i915/intel_crt.c
> > @@ -30,7 +30,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include "intel_drv.h"
> >  #include <drm/i915_drm.h>
> > diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i91=
5/intel_display.c
> > index 8dec25a2dc5f..4eebe84dc366 100644
> > --- a/drivers/gpu/drm/i915/intel_display.c
> > +++ b/drivers/gpu/drm/i915/intel_display.c
> > @@ -42,7 +42,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_dp_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_rect.h>
> >  #include <drm/drm_atomic_uapi.h>
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/int=
el_dp.c
> > index e94faa0a42eb..77c86977bef8 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -35,7 +35,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_hdcp.h>
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915=
/intel_dp_mst.c
> > index f05427b74e34..32e3c0366876 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -27,7 +27,7 @@
> >  #include "i915_drv.h"
> >  #include "intel_drv.h"
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  =

> >  static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/in=
tel_drv.h
> > index f94a04b4ad87..6dba18425e82 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -32,7 +32,7 @@
> >  #include <drm/i915_drm.h>
> >  #include "i915_drv.h"
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_dp_dual_mode_helper.h>
> > diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw=
_hdmi-imx.c
> > index 77a26fd3a44a..c7273c395811 100644
> > --- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
> > +++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> > @@ -13,7 +13,7 @@
> >  #include <linux/regmap.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_encoder_slave.h>
> >  =

> > diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/i=
mx-drm-core.c
> > index 820c7e3878f0..4db26cbed08f 100644
> > --- a/drivers/gpu/drm/imx/imx-drm-core.c
> > +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> > @@ -13,7 +13,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> > diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ld=
b.c
> > index 2c5bbe317353..ffa742f64d44 100644
> > --- a/drivers/gpu/drm/imx/imx-ldb.c
> > +++ b/drivers/gpu/drm/imx/imx-ldb.c
> > @@ -12,7 +12,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  #include <linux/mfd/syscon.h>
> > diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tv=
e.c
> > index 293dd5752583..e725af8a0025 100644
> > --- a/drivers/gpu/drm/imx/imx-tve.c
> > +++ b/drivers/gpu/drm/imx/imx-tve.c
> > @@ -17,7 +17,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <video/imx-ipu-v3.h>
> >  =

> >  #include "imx-drm.h"
> > diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipu=
v3-crtc.c
> > index 058b53c0aa7e..95ddcbf2f6eb 100644
> > --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> > +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> > @@ -12,7 +12,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <linux/clk.h>
> >  #include <linux/errno.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/i=
mx/parallel-display.c
> > index f3ce51121dd6..670919781ded 100644
> > --- a/drivers/gpu/drm/imx/parallel-display.c
> > +++ b/drivers/gpu/drm/imx/parallel-display.c
> > @@ -10,7 +10,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  #include <linux/videodev2.h>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 62a9d47df948..c88cc0addb62 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -13,7 +13,7 @@
> >   */
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <linux/kernel.h>
> >  #include <linux/component.h>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index 92ecb9bf982c..96709318ad8c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -14,7 +14,7 @@
> >  #include <asm/barrier.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <linux/clk.h>
> >  #include <linux/pm_runtime.h>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_drv.c
> > index 6422e99952fe..8a48a317cbd3 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -15,7 +15,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/me=
diatek/mtk_drm_fb.c
> > index be5f6f1daf55..330c17b5911f 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> > @@ -12,7 +12,7 @@
> >   */
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> > index 66df1b177959..477cd145280c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -13,7 +13,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_panel.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/medi=
atek/mtk_hdmi.c
> > index 862f3ec22131..607287797073 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -14,7 +14,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> > diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson=
/meson_crtc.c
> > index 75d97f1b2e8f..ec573c04206b 100644
> > --- a/drivers/gpu/drm/meson/meson_crtc.c
> > +++ b/drivers/gpu/drm/meson/meson_crtc.c
> > @@ -30,7 +30,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_flip_work.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "meson_crtc.h"
> >  #include "meson_plane.h"
> > diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/=
meson_drv.c
> > index 3ee4d4a4ecba..6b29447fd09e 100644
> > --- a/drivers/gpu/drm/meson/meson_drv.c
> > +++ b/drivers/gpu/drm/meson/meson_drv.c
> > @@ -31,7 +31,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_flip_work.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/me=
son/meson_dw_hdmi.c
> > index 807111ebfdd9..b6299f3f4310 100644
> > --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> > +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> > @@ -27,7 +27,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_edid.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/bridge/dw_hdmi.h>
> >  =

> > diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/=
meson/meson_venc_cvbs.c
> > index f7945bae3b4a..64de3a7026d0 100644
> > --- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
> > +++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
> > @@ -27,7 +27,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_edid.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> >  #include "meson_venc_cvbs.h"
> > diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/m=
gag200/mgag200_mode.c
> > index acf7bfe68454..7481a3d556ad 100644
> > --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> > +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> > @@ -16,6 +16,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "mgag200_drv.h"
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm=
/msm/disp/dpu1/dpu_crtc.c
> > index ca169f013a14..26f21663d56f 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/ktime.h>
> >  #include <drm/drm_mode.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_flip_work.h>
> >  #include <drm/drm_rect.h>
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index d31d8281424e..7fa60ffd4cd8 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -24,7 +24,7 @@
> >  #include "msm_drv.h"
> >  #include "dpu_kms.h"
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "dpu_hwio.h"
> >  #include "dpu_hw_catalog.h"
> >  #include "dpu_hw_intf.h"
> > diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/dr=
m/msm/disp/mdp4/mdp4_crtc.c
> > index 457c29dba4a1..62d173cee0ab 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> > @@ -16,7 +16,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_flip_work.h>
> >  #include <drm/drm_mode.h>
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers=
/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> > index 6a1ebdace391..86cbe173106e 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> > @@ -18,7 +18,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "mdp4_kms.h"
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers=
/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> > index ba8e587f734b..c0ee6f465839 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
> > @@ -16,7 +16,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "mdp4_kms.h"
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/driver=
s/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> > index 2bfb39082f54..473255f09f30 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> > @@ -17,7 +17,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "mdp4_kms.h"
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers=
/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> > index d6f79dc755b4..b7e17651d897 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> > @@ -12,7 +12,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "mdp5_kms.h"
> >  =

> > diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/dr=
m/msm/disp/mdp5/mdp5_crtc.c
> > index b1da9ce54379..6b5f09721dd4 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> > @@ -19,7 +19,7 @@
> >  #include <linux/sort.h>
> >  #include <drm/drm_mode.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_flip_work.h>
> >  =

> >  #include "mdp5_kms.h"
> > diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu=
/drm/msm/disp/mdp5/mdp5_encoder.c
> > index fcd44d1d1068..b32c662dcb60 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> > @@ -17,7 +17,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "mdp5_kms.h"
> >  =

> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_dr=
v.h
> > index 9d11f321f5a9..19f4751e0436 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -39,7 +39,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/msm_drm.h>
> > diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> > index 2a7348aeb38d..22bb2247c52a 100644
> > --- a/drivers/gpu/drm/msm/msm_fb.c
> > +++ b/drivers/gpu/drm/msm/msm_fb.c
> > @@ -16,7 +16,7 @@
> >   */
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> >  #include "msm_drv.h"
> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb=
/mxsfb_crtc.c
> > index 24b1f0c1432e..38cdde9841e2 100644
> > --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> > @@ -19,7 +19,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/=
mxsfb_drv.c
> > index 88ba003979e6..9c117352fca9 100644
> > --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > @@ -31,7 +31,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/=
mxsfb_out.c
> > index e5edf016a439..1bec96baf948 100644
> > --- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> > @@ -16,7 +16,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/dr=
m/nouveau/dispnv04/tvnv17.c
> > index 3e82db41f8a4..51667d13d95a 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> > @@ -26,6 +26,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "nouveau_drv.h"
> >  #include "nouveau_reg.h"
> >  #include "nouveau_encoder.h"
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/=
nouveau/dispnv50/disp.c
> > index 4a56841958c8..79225913a25c 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -32,7 +32,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/=
drm/nouveau/nouveau_connector.c
> > index fd80661dff92..2a0ded1d732e 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -33,6 +33,7 @@
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic.h>
> >  =

> >  #include "nouveau_reg.h"
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/dr=
m/nouveau/nouveau_display.c
> > index 5d273a655479..0b58709f0406 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> > @@ -29,6 +29,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  =

> >  #include <nvif/class.h>
> > diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm=
/omapdrm/omap_connector.c
> > index b81302c4bf9e..4fef6293f6c0 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> > @@ -17,7 +17,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "omap_drv.h"
> >  =

> > diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omap=
drm/omap_crtc.c
> > index caffc547ef97..aab1b1a49a87 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> > @@ -18,7 +18,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mode.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <linux/math64.h>
> > diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapd=
rm/omap_drv.c
> > index 5e67d58cbc28..3a78f0cf3321 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> > @@ -21,7 +21,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  =

> >  #include "omap_dmm_tiler.h"
> > diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapd=
rm/omap_drv.h
> > index bd7f2c227a25..513ae8ab5e64 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> > +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> > @@ -23,7 +23,7 @@
> >  #include <linux/workqueue.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/omap_drm.h>
> >  =

> > diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/o=
mapdrm/omap_encoder.c
> > index 933ebc9f9faa..a0e0f200f677 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/list.h>
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  =

> >  #include "omap_drv.h"
> > diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdr=
m/omap_fb.c
> > index 4d264fd554d8..314add2bbc9a 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_fb.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/seq_file.h>
> >  =

> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> >  #include "omap_dmm_tiler.h"
> > diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/=
pl111_drv.c
> > index 33e0483d62ae..9dbb11cfbb20 100644
> > --- a/drivers/gpu/drm/pl111/pl111_drv.c
> > +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> > @@ -64,7 +64,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qx=
l_display.c
> > index 72a1784dae54..1de03d60bf23 100644
> > --- a/drivers/gpu/drm/qxl/qxl_display.c
> > +++ b/drivers/gpu/drm/qxl/qxl_display.c
> > @@ -24,9 +24,9 @@
> >   */
> >  =

> >  #include <linux/crc32.h>
> > -#include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_dr=
v.c
> > index 13c8a662f9b4..fd987d62d902 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -33,7 +33,8 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_modeset_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "qxl_drv.h"
> >  #include "qxl_object.h"
> >  =

> > diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
> > index a819d24225d2..996cdb8fb4fa 100644
> > --- a/drivers/gpu/drm/qxl/qxl_fb.c
> > +++ b/drivers/gpu/drm/qxl/qxl_fb.c
> > @@ -28,7 +28,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> > diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_km=
s.c
> > index 15238a413f9d..85e13afa1808 100644
> > --- a/drivers/gpu/drm/qxl/qxl_kms.c
> > +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> > @@ -26,7 +26,7 @@
> >  #include "qxl_drv.h"
> >  #include "qxl_object.h"
> >  =

> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <linux/io-mapping.h>
> >  =

> >  int qxl_log_level;
> > diff --git a/drivers/gpu/drm/radeon/radeon_acpi.c b/drivers/gpu/drm/rad=
eon/radeon_acpi.c
> > index 8d3251a10cd4..224cc21bbe38 100644
> > --- a/drivers/gpu/drm/radeon/radeon_acpi.c
> > +++ b/drivers/gpu/drm/radeon/radeon_acpi.c
> > @@ -29,6 +29,7 @@
> >  #include <acpi/video.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "radeon.h"
> >  #include "radeon_acpi.h"
> >  #include "atom.h"
> > diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/d=
rm/radeon/radeon_connectors.c
> > index 414642e5b7a3..88239c1e7c5b 100644
> > --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> > +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> > @@ -26,6 +26,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_dp_mst_helper.h>
> >  #include <drm/radeon_drm.h>
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index 59c8a6647ff2..53f29a115104 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/slab.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_cache.h>
> >  #include <drm/radeon_drm.h>
> >  #include <linux/pm_runtime.h>
> > diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/=
radeon/radeon_display.c
> > index 92332226e5cf..e252ab3832a5 100644
> > --- a/drivers/gpu/drm/radeon/radeon_display.c
> > +++ b/drivers/gpu/drm/radeon/radeon_display.c
> > @@ -32,6 +32,7 @@
> >  =

> >  #include <linux/pm_runtime.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/r=
adeon/radeon_dp_mst.c
> > index a0c70e27ab65..8d85540bbb43 100644
> > --- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
> > +++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
> > @@ -3,6 +3,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_dp_mst_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "radeon.h"
> >  #include "atom.h"
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/rade=
on/radeon_drv.c
> > index 99c63eeb2866..8897c3d18fbb 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -43,6 +43,7 @@
> >  #include <drm/drm_fb_helper.h>
> >  =

> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  /*
> >   * KMS wrapper.
> > diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/=
radeon/radeon_irq_kms.c
> > index afaf10db47cc..1d5e3ba7383e 100644
> > --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> > +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> > @@ -27,6 +27,7 @@
> >   */
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/radeon_drm.h>
> >  #include "radeon_reg.h"
> >  #include "radeon.h"
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/r=
car-du/rcar_du_crtc.c
> > index 90dacab67be5..b15d2b3a07f1 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > @@ -15,7 +15,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rc=
ar-du/rcar_du_drv.c
> > index f50a3b1864bb..60862858d041 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > @@ -19,7 +19,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/dr=
m/rcar-du/rcar_du_encoder.c
> > index 1877764bd6d9..9e751c9be9f2 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
> > @@ -11,7 +11,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_panel.h>
> >  =

> >  #include "rcar_du_drv.h"
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rc=
ar-du/rcar_du_kms.c
> > index 9c7007d45408..af337c918d84 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > @@ -11,7 +11,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/=
rcar-du/rcar_du_plane.c
> > index 39d5ae3fdf72..b7fa278ca745 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> > @@ -11,7 +11,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rc=
ar-du/rcar_du_vsp.c
> > index 4576119e7777..35b2a4d3ae74 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> > @@ -10,7 +10,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar=
-du/rcar_lvds.c
> > index 534a128a869d..24cb74e30fcd 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > @@ -19,7 +19,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_panel.h>
> >  =

> >  #include "rcar_lvds_regs.h"
> > diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/=
gpu/drm/rockchip/analogix_dp-rockchip.c
> > index 080f05352195..2f6b4a4a9d6b 100644
> > --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > @@ -21,7 +21,7 @@
> >  #include <linux/clk.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> > diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/r=
ockchip/cdn-dp-core.c
> > index 8ad0d773dc33..7896b3c28676 100644
> > --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> > +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> > @@ -14,7 +14,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/r=
ockchip/cdn-dp-core.h
> > index f57e296401b8..7000b53dddcb 100644
> > --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
> > +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> > @@ -16,7 +16,7 @@
> >  #define _CDN_DP_CORE_H
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_panel.h>
> >  #include "rockchip_drm_drv.h"
> > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/=
drm/rockchip/dw_hdmi-rockchip.c
> > index 89c63cfde5c8..1e2cc2b02a31 100644
> > --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > @@ -16,7 +16,7 @@
> >  =

> >  #include <drm/drm_of.h>
> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/bridge/dw_hdmi.h>
> >  =

> > diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/roc=
kchip/inno_hdmi.c
> > index 1c02b3e61299..9db4a706b450 100644
> > --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> > +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> > @@ -26,7 +26,7 @@
> >  #include <drm/drm_of.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  =

> >  #include "rockchip_drm_drv.h"
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/=
drm/rockchip/rockchip_drm_drv.c
> > index 37f9a3b651ab..c4aa2ef82e57 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > @@ -15,7 +15,7 @@
> >   */
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_fb.c
> > index ea18cb2a76c0..567605fc2898 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > @@ -17,7 +17,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> >  #include "rockchip_drm_drv.h"
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gp=
u/drm/rockchip/rockchip_drm_fbdev.c
> > index 361604e51361..7bd3b89022be 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> > @@ -15,7 +15,7 @@
> >  #include <drm/drm.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_fb_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "rockchip_drm_drv.h"
> >  #include "rockchip_drm_gem.h"
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/=
drm/rockchip/rockchip_drm_psr.c
> > index 01ff3c858875..b165e248c2e6 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> > @@ -13,7 +13,7 @@
> >   */
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "rockchip_drm_drv.h"
> >  #include "rockchip_drm_psr.h"
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/=
drm/rockchip/rockchip_drm_vop.c
> > index fb70fb486fbf..e78906bb6502 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -16,7 +16,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_flip_work.h>
> >  #include <drm/drm_plane_helper.h>
> >  #ifdef CONFIG_DRM_ANALOGIX_DP
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm=
/rockchip/rockchip_lvds.c
> > index 456bd9f13bae..fd21901880e6 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> > @@ -16,7 +16,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_panel.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/=
rockchip/rockchip_rgb.c
> > index 96ac1458a59c..bec197c9a3cf 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> > @@ -16,7 +16,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_panel.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_c=
rtc.c
> > index ed76e52eb213..7aa3b1d04b78 100644
> > --- a/drivers/gpu/drm/sti/sti_crtc.c
> > +++ b/drivers/gpu/drm/sti/sti_crtc.c
> > @@ -11,7 +11,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  =

> >  #include "sti_compositor.h"
> > diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_dr=
v.c
> > index ac54e0f9caea..dc932ac58ba9 100644
> > --- a/drivers/gpu/drm/sti/sti_drv.c
> > +++ b/drivers/gpu/drm/sti/sti_drv.c
> > @@ -14,7 +14,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dv=
o.c
> > index b08376b7611b..d0fcb20e9614 100644
> > --- a/drivers/gpu/drm/sti/sti_dvo.c
> > +++ b/drivers/gpu/drm/sti/sti_dvo.c
> > @@ -13,7 +13,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_panel.h>
> >  =

> >  #include "sti_awg_utils.h"
> > diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hd=
a.c
> > index 19b9b5ed1297..40a0b392fa51 100644
> > --- a/drivers/gpu/drm/sti/sti_hda.c
> > +++ b/drivers/gpu/drm/sti/sti_hda.c
> > @@ -12,7 +12,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  /* HDformatter registers */
> >  #define HDA_ANA_CFG                     0x0000
> > diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_h=
dmi.c
> > index ccf718404a1c..989bf2cb0249 100644
> > --- a/drivers/gpu/drm/sti/sti_hdmi.c
> > +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> > @@ -15,7 +15,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  =

> >  #include <sound/hdmi-codec.h>
> > diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_=
tvout.c
> > index ea4a3b87fa55..2f9d075f0a66 100644
> > --- a/drivers/gpu/drm/sti/sti_tvout.c
> > +++ b/drivers/gpu/drm/sti/sti_tvout.c
> > @@ -15,7 +15,7 @@
> >  #include <linux/seq_file.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "sti_crtc.h"
> >  #include "sti_drv.h"
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 8dec001b9d37..c64c5f27a229 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -13,7 +13,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 61dd661aa0ac..8189b5df7ece 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -16,7 +16,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/su=
n4i/sun4i_backend.c
> > index 9e9255ee59cd..df9d3f548568 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -14,7 +14,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i=
/sun4i_crtc.c
> > index 3eedf335a935..3d58d8951474 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> > @@ -13,7 +13,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_modes.h>
> >  =

> >  #include <linux/clk-provider.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/=
sun4i_drv.c
> > index 9e4c375ccc96..45c85be54ce0 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/s=
un4i/sun4i_hdmi_enc.c
> > index 061d2e0d9011..60b3e44e6792 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > @@ -11,7 +11,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i=
/sun4i_lvds.c
> > index e7eb0d1e17be..87ba8db71a54 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> > @@ -8,7 +8,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  =

> > diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/=
sun4i_rgb.c
> > index f4a22689eb54..f6f7f4de2e69 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > @@ -14,7 +14,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  =

> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i=
/sun4i_tcon.c
> > index 0420f5c978b9..3a09d8e28c25 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -14,7 +14,7 @@
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_modes.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/s=
un4i_tv.c
> > index 1a838d208211..62fbdef8fffb 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> > @@ -18,7 +18,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> >  =

> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/s=
un4i/sun6i_mipi_dsi.c
> > index e3b34a345546..dfa2d15d7b36 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -19,7 +19,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_panel.h>
> >  =

> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/su=
n4i/sun8i_dw_hdmi.c
> > index dc47720c99ba..92bc1004dc36 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > @@ -10,7 +10,7 @@
> >  =

> >  #include <drm/drm_of.h>
> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "sun8i_dw_hdmi.h"
> >  #include "sun8i_tcon_top.h"
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4=
i/sun8i_mixer.c
> > index 44a9ba7d8433..9ef1b494e48d 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -14,7 +14,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/s=
un4i/sun8i_ui_layer.c
> > index 18534263a05d..e29cbd60a59b 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > @@ -16,7 +16,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/s=
un4i/sun8i_vi_layer.c
> > index 87be898f9b7a..1669460106de 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > @@ -10,7 +10,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> > index 1012335bb489..40d38f3d9d9e 100644
> > --- a/drivers/gpu/drm/tegra/drm.h
> > +++ b/drivers/gpu/drm/tegra/drm.h
> > @@ -17,7 +17,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_fb_helper.h>
> > diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> > index 0082468f703c..11f5e5668b14 100644
> > --- a/drivers/gpu/drm/tegra/hdmi.c
> > +++ b/drivers/gpu/drm/tegra/hdmi.c
> > @@ -18,7 +18,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include <sound/hda_verbs.h>
> >  =

> > diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> > index 6112d9042979..176d1c1ad941 100644
> > --- a/drivers/gpu/drm/tegra/hub.c
> > +++ b/drivers/gpu/drm/tegra/hub.c
> > @@ -19,7 +19,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "drm.h"
> >  #include "dc.h"
> > diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/=
drm/tinydrm/core/tinydrm-core.c
> > index 01a6f2d42440..d4174a564336 100644
> > --- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> > +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
> > @@ -9,7 +9,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/tinydrm/tinydrm.h>
> > diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c b/drivers/gpu/=
drm/tinydrm/core/tinydrm-pipe.c
> > index eacfc0ec8ff1..50ab05a65ca4 100644
> > --- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> > +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> > @@ -8,7 +8,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_modes.h>
> >  #include <drm/tinydrm/tinydrm.h>
> > diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve2=
00/tve200_drv.c
> > index 28e2d03c0ccf..138a9a158254 100644
> > --- a/drivers/gpu/drm/tve200/tve200_drv.c
> > +++ b/drivers/gpu/drm/tve200/tve200_drv.c
> > @@ -43,7 +43,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/=
udl_connector.c
> > index 68e88bed77ca..66885c24590f 100644
> > --- a/drivers/gpu/drm/udl/udl_connector.c
> > +++ b/drivers/gpu/drm/udl/udl_connector.c
> > @@ -14,6 +14,7 @@
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "udl_connector.h"
> >  #include "udl_drv.h"
> >  =

> > diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_dr=
v.c
> > index a63e3011e971..22cd2d13e272 100644
> > --- a/drivers/gpu/drm/udl/udl_drv.c
> > +++ b/drivers/gpu/drm/udl/udl_drv.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/module.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "udl_drv.h"
> >  =

> >  static int udl_usb_suspend(struct usb_interface *interface,
> > diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_m=
ain.c
> > index 1b014d92855b..9086d0d1b880 100644
> > --- a/drivers/gpu/drm/udl/udl_main.c
> > +++ b/drivers/gpu/drm/udl/udl_main.c
> > @@ -12,6 +12,7 @@
> >   */
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include "udl_drv.h"
> >  =

> >  /* -BULK_SIZE as per usb-skeleton. Can we get full page and avoid over=
head? */
> > diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_c=
rtc.c
> > index 3ce136ba8791..11ec7c31824e 100644
> > --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> > +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> > @@ -34,7 +34,7 @@
> >  =

> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_uapi.h>
> >  #include <linux/clk.h>
> >  #include <drm/drm_fb_cma_helper.h>
> > diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dp=
i.c
> > index f185812970da..a4d5a13598ba 100644
> > --- a/drivers/gpu/drm/vc4/vc4_dpi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_dpi.c
> > @@ -24,7 +24,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> > diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_ds=
i.c
> > index 0c607eb33d7e..4c2f5e143d11 100644
> > --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> > @@ -30,7 +30,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
> > index fd5522fd179e..ce3cc2a6a169 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -43,7 +43,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <linux/clk.h>
> >  #include <linux/component.h>
> > diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_km=
s.c
> > index 1f94b9affe4b..ae7b311893df 100644
> > --- a/drivers/gpu/drm/vc4/vc4_kms.c
> > +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> > @@ -17,7 +17,7 @@
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include "vc4_drv.h"
> > diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_tx=
p.c
> > index 6e23c50168f9..8ac1b95d01c4 100644
> > --- a/drivers/gpu/drm/vc4/vc4_txp.c
> > +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> > @@ -9,7 +9,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_panel.h>
> >  #include <drm/drm_writeback.h>
> > diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_ve=
c.c
> > index 8e7facb6514e..e8b09c670ee6 100644
> > --- a/drivers/gpu/drm/vc4/vc4_vec.c
> > +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> > @@ -25,7 +25,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_panel.h>
> >  #include <linux/clk.h>
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm=
/virtio/virtgpu_display.c
> > index b5580b11a063..774f476dd9cd 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> > @@ -26,7 +26,7 @@
> >   */
> >  =

> >  #include "virtgpu_drv.h"
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/vir=
tio/virtgpu_drv.h
> > index 1deb41d42ea4..0c793d91c62b 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -34,7 +34,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_atomic.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/ttm/ttm_bo_api.h>
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vk=
ms_crtc.c
> > index 177bbcb38306..2696c370fe9b 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -8,7 +8,7 @@
> >  =

> >  #include "vkms_drv.h"
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  static void _vblank_handle(struct vkms_output *output)
> >  {
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkm=
s_drv.c
> > index 83087877565c..b446f60e7d8a 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -16,7 +16,7 @@
> >  =

> >  #include <linux/module.h>
> >  #include <drm/drm_gem.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/=
vkms_output.c
> > index 271a0eb9042c..878ff3142473 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -7,7 +7,7 @@
> >   */
> >  =

> >  #include "vkms_drv.h"
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> >  static void vkms_connector_destroy(struct drm_connector *connector)
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwg=
fx/vmwgfx_kms.h
> > index 655abbcd4058..d560f6159bb1 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> > @@ -29,7 +29,7 @@
> >  #define VMWGFX_KMS_H_
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include "vmwgfx_drv.h"
> >  =

> > diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/=
xen_drm_front.c
> > index 6b6d5ab82ec3..fd390dd64b13 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> > @@ -10,7 +10,7 @@
> >  =

> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem.h>
> >  =

> >  #include <linux/of_device.h>
> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm=
/xen/xen_drm_front_conn.c
> > index 54af2669b1b3..9f5f31f77f1e 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
> > @@ -9,7 +9,7 @@
> >   */
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include <video/videomode.h>
> >  =

> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/=
xen/xen_drm_front_gem.c
> > index 47ff019d3aef..9cf847e26cf1 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > @@ -11,7 +11,7 @@
> >  #include "xen_drm_front_gem.h"
> >  =

> >  #include <drm/drmP.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem.h>
> >  =

> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/=
xen/xen_drm_front_kms.c
> > index a3479eb72d79..f536d9f5a796 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
> > @@ -13,7 +13,7 @@
> >  #include <drm/drmP.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> >  =

> > diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_=
drm_drv.c
> > index f5ea32ae8600..91eaaa475d36 100644
> > --- a/drivers/gpu/drm/zte/zx_drm_drv.c
> > +++ b/drivers/gpu/drm/zte/zx_drm_drv.c
> > @@ -18,7 +18,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/gpu/drm/zte/zx_hdmi.c b/drivers/gpu/drm/zte/zx_hdm=
i.c
> > index 78655269d843..8bfb011ce655 100644
> > --- a/drivers/gpu/drm/zte/zx_hdmi.c
> > +++ b/drivers/gpu/drm/zte/zx_hdmi.c
> > @@ -20,7 +20,7 @@
> >  #include <linux/of_device.h>
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drmP.h>
> > diff --git a/drivers/gpu/drm/zte/zx_tvenc.c b/drivers/gpu/drm/zte/zx_tv=
enc.c
> > index b73afb212fb2..87b5d86413d2 100644
> > --- a/drivers/gpu/drm/zte/zx_tvenc.c
> > +++ b/drivers/gpu/drm/zte/zx_tvenc.c
> > @@ -14,7 +14,7 @@
> >  #include <linux/regmap.h>
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drmP.h>
> >  =

> >  #include "zx_drm_drv.h"
> > diff --git a/drivers/gpu/drm/zte/zx_vga.c b/drivers/gpu/drm/zte/zx_vga.c
> > index 23d1ff4355a0..e14c1d709740 100644
> > --- a/drivers/gpu/drm/zte/zx_vga.c
> > +++ b/drivers/gpu/drm/zte/zx_vga.c
> > @@ -13,7 +13,7 @@
> >  #include <linux/regmap.h>
> >  =

> >  #include <drm/drm_atomic_helper.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drmP.h>
> >  =

> >  #include "zx_drm_drv.h"
> > diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
> > index 442311d31110..9d97f4417698 100644
> > --- a/drivers/gpu/drm/zte/zx_vou.c
> > +++ b/drivers/gpu/drm/zte/zx_vou.c
> > @@ -15,7 +15,7 @@
> >  =

> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_fb_cma_helper.h>
> >  #include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem_cma_helper.h>
> > diff --git a/drivers/staging/vboxvideo/vbox_irq.c b/drivers/staging/vbo=
xvideo/vbox_irq.c
> > index 09f858ec1369..b9b716776b7b 100644
> > --- a/drivers/staging/vboxvideo/vbox_irq.c
> > +++ b/drivers/staging/vboxvideo/vbox_irq.c
> > @@ -27,7 +27,7 @@
> >   *          Hans de Goede <hdegoede@redhat.com>
> >   */
> >  =

> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  =

> >  #include "vbox_drv.h"
> >  #include "vboxvideo.h"
> > diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vb=
oxvideo/vbox_mode.c
> > index 6acc965247ff..c72e4f251bc0 100644
> > --- a/drivers/staging/vboxvideo/vbox_mode.c
> > +++ b/drivers/staging/vboxvideo/vbox_mode.c
> > @@ -33,7 +33,7 @@
> >   */
> >  #include <linux/export.h>
> >  #include <drm/drm_atomic.h>
> > -#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_probe_helper.h>
> >  #include <drm/drm_plane_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  =

> > diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helpe=
r.h
> > index 0ee9a96b70da..a6d520d5b6ca 100644
> > --- a/include/drm/drm_crtc_helper.h
> > +++ b/include/drm/drm_crtc_helper.h
> > @@ -58,20 +58,4 @@ int drm_helper_connector_dpms(struct drm_connector *=
connector, int mode);
> >  void drm_helper_resume_force_mode(struct drm_device *dev);
> >  int drm_helper_force_disable_all(struct drm_device *dev);
> >  =

> > -/* drm_probe_helper.c */
> > -int drm_helper_probe_single_connector_modes(struct drm_connector
> > -					    *connector, uint32_t maxX,
> > -					    uint32_t maxY);
> > -int drm_helper_probe_detect(struct drm_connector *connector,
> > -			    struct drm_modeset_acquire_ctx *ctx,
> > -			    bool force);
> > -void drm_kms_helper_poll_init(struct drm_device *dev);
> > -void drm_kms_helper_poll_fini(struct drm_device *dev);
> > -bool drm_helper_hpd_irq_event(struct drm_device *dev);
> > -void drm_kms_helper_hotplug_event(struct drm_device *dev);
> > -
> > -void drm_kms_helper_poll_disable(struct drm_device *dev);
> > -void drm_kms_helper_poll_enable(struct drm_device *dev);
> > -bool drm_kms_helper_is_poll_worker(void);
> > -
> >  #endif
> > diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_hel=
per.h
> > new file mode 100644
> > index 000000000000..96c060c16a1e
> > --- /dev/null
> > +++ b/include/drm/drm_probe_helper.h
> > @@ -0,0 +1,50 @@
> > +/*
> > + * Copyright =A9 2006 Keith Packard
> > + * Copyright =A9 2007-2008 Dave Airlie
> > + * Copyright =A9 2007-2008 Intel Corporation
> > + *   Jesse Barnes <jesse.barnes@intel.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +#ifndef __DRM_PROBE_HELPER_H__
> > +#define __DRM_PROBE_HELPER_H__
> > +
> > +#include <linux/types.h>
> > +
> > +struct drm_connector;
> > +struct drm_device;
> > +struct drm_modeset_acquire_ctx;
> > +
> > +int drm_helper_probe_single_connector_modes(struct drm_connector
> > +					    *connector, uint32_t maxX,
> > +					    uint32_t maxY);
> > +int drm_helper_probe_detect(struct drm_connector *connector,
> > +			    struct drm_modeset_acquire_ctx *ctx,
> > +			    bool force);
> > +void drm_kms_helper_poll_init(struct drm_device *dev);
> > +void drm_kms_helper_poll_fini(struct drm_device *dev);
> > +bool drm_helper_hpd_irq_event(struct drm_device *dev);
> > +void drm_kms_helper_hotplug_event(struct drm_device *dev);
> > +
> > +void drm_kms_helper_poll_disable(struct drm_device *dev);
> > +void drm_kms_helper_poll_enable(struct drm_device *dev);
> > +bool drm_kms_helper_is_poll_worker(void);
> > +
> > +#endif
> > -- =

> > 2.20.0.rc1
> > =

> > =

> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> =

> -- =

>            ________________________________________________________
>   ________|                                                        |_____=
__
>   \       |  With enough courage, you can do without a reputation  |     =
 /
>    \      |                                  -- Rhett Butler       |     /
>    /      |________________________________________________________|     \
>   /__________)                                                  (________=
_\

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
