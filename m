From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] drm: Split out drm_probe_helper.h
Date: Wed, 16 Jan 2019 14:51:56 +0100
Message-ID: <20190116135156.21103-1-daniel.vetter__3686.22779283232$1547692534$gmane$org@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, nouveau@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, Daniel Vetter <daniel.vetter@ffwll.ch>, CK Hu <ck.hu@mediatek.com>, spice-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>l
List-Id: virtualization@lists.linuxfoundation.org

Having the probe helper stuff (which pretty much everyone needs) in
the drm_crtc_helper.h file (which atomic drivers should never need) is
confusing. Split them out.

To make sure I actually achieved the goal here I went through all
drivers. And indeed, all atomic drivers are now free of
drm_crtc_helper.h includes.

v2: Make it compile. There was so much compile fail on arm drivers
that I figured I'll better not include any of the acks on v1.

v3: Massive rebase because i915 has lost a lot of drmP.h includes, but
not all: Through drm_crtc_helper.h > drm_modeset_helper.h -> drmP.h
there was still one, which this patch largely removes. Which means
rolling out lots more includes all over.

This will also conflict with ongoing drmP.h cleanup by others I
expect.

v3: Rebase on top of atomic bochs.

v4: Review from Laurent for bridge/rcar/omap/shmob/core bits:
- (re)move some of the added includes, use the better include files in
  other places (all suggested from Laurent adopted unchanged).
- sort alphabetically

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: CK Hu <ck.hu@mediatek.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: virtualization@lists.linux-foundation.org
Cc: etnaviv@lists.freedesktop.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: spice-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-tegra@vger.kernel.org
Cc: xen-devel@lists.xen.org
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  2 +-
 drivers/gpu/drm/arc/arcpgu_crtc.c             |  2 +-
 drivers/gpu/drm/arc/arcpgu_drv.c              |  2 +-
 drivers/gpu/drm/arc/arcpgu_sim.c              |  2 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c              |  2 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/arm/malidp_mw.c               |  2 +-
 drivers/gpu/drm/armada/armada_510.c           |  2 +-
 drivers/gpu/drm/armada/armada_crtc.c          |  2 +-
 drivers/gpu/drm/armada/armada_crtc.h          |  2 ++
 drivers/gpu/drm/armada/armada_drv.c           |  2 +-
 drivers/gpu/drm/armada/armada_fb.c            |  2 +-
 drivers/gpu/drm/ast/ast_drv.c                 |  1 +
 drivers/gpu/drm/ast/ast_mode.c                |  1 +
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  2 +-
 drivers/gpu/drm/bochs/bochs_drv.c             |  1 +
 drivers/gpu/drm/bochs/bochs_kms.c             |  1 +
 drivers/gpu/drm/bridge/adv7511/adv7511.h      |  4 ++-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |  1 +
 drivers/gpu/drm/bridge/analogix-anx78xx.c     |  2 +-
 .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
 drivers/gpu/drm/bridge/cdns-dsi.c             |  2 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c         |  2 +-
 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c          |  2 +-
 drivers/gpu/drm/bridge/panel.c                |  2 +-
 drivers/gpu/drm/bridge/parade-ps8622.c        |  2 +-
 drivers/gpu/drm/bridge/sii902x.c              |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c |  2 +-
 drivers/gpu/drm/bridge/tc358764.c             |  2 +-
 drivers/gpu/drm/bridge/tc358767.c             |  2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
 drivers/gpu/drm/cirrus/cirrus_drv.c           |  1 +
 drivers/gpu/drm/cirrus/cirrus_mode.c          |  1 +
 drivers/gpu/drm/drm_atomic_helper.c           |  1 -
 drivers/gpu/drm/drm_dp_mst_topology.c         |  2 +-
 drivers/gpu/drm/drm_modeset_helper.c          |  2 +-
 drivers/gpu/drm/drm_probe_helper.c            |  2 +-
 drivers/gpu/drm/drm_simple_kms_helper.c       |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h         |  1 -
 drivers/gpu/drm/exynos/exynos_dp.c            |  3 ++-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c      |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c       |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c       |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c       |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c        |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c      |  2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c    |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c     |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c   |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c     |  2 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h        |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    |  2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c |  2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |  2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c  |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/i2c/ch7006_priv.h             |  1 +
 drivers/gpu/drm/i2c/sil164_drv.c              |  2 +-
 drivers/gpu/drm/i2c/tda998x_drv.c             |  2 +-
 drivers/gpu/drm/i915/i915_debugfs.c           |  3 ++-
 drivers/gpu/drm/i915/i915_drv.c               |  2 +-
 drivers/gpu/drm/i915/i915_gem.c               |  2 ++
 drivers/gpu/drm/i915/i915_ioc32.c             |  1 +
 drivers/gpu/drm/i915/i915_irq.c               |  2 ++
 drivers/gpu/drm/i915/i915_pci.c               |  2 ++
 drivers/gpu/drm/i915/i915_trace.h             |  2 ++
 drivers/gpu/drm/i915/intel_crt.c              |  2 +-
 drivers/gpu/drm/i915/intel_display.c          |  2 +-
 drivers/gpu/drm/i915/intel_dp.c               |  2 +-
 drivers/gpu/drm/i915/intel_dp_mst.c           |  2 +-
 drivers/gpu/drm/i915/intel_drv.h              |  3 ++-
 drivers/gpu/drm/i915/intel_fbc.c              |  2 ++
 drivers/gpu/drm/i915/intel_fbdev.c            |  2 ++
 drivers/gpu/drm/i915/intel_lpe_audio.c        |  1 +
 drivers/gpu/drm/i915/intel_overlay.c          |  2 ++
 drivers/gpu/drm/imx/dw_hdmi-imx.c             |  2 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  2 +-
 drivers/gpu/drm/imx/imx-ldb.c                 |  2 +-
 drivers/gpu/drm/imx/imx-tve.c                 |  2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c              |  2 +-
 drivers/gpu/drm/imx/parallel-display.c        |  2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c         |  2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  2 +-
 drivers/gpu/drm/meson/meson_crtc.c            |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |  2 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c       |  2 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c        |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     |  2 +-
 .../gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c  |  2 +-
 .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  |  2 +-
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  2 +-
 .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  |  2 +-
 drivers/gpu/drm/msm/msm_drv.h                 |  2 +-
 drivers/gpu/drm/msm/msm_fb.c                  |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c            |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c             |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c     |  1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c     |  1 +
 drivers/gpu/drm/omapdrm/omap_connector.c      |  2 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c           |  1 -
 drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.h            |  1 -
 drivers/gpu/drm/omapdrm/omap_encoder.c        |  2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c             |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |  3 ++-
 drivers/gpu/drm/qxl/qxl_fb.c                  |  2 +-
 drivers/gpu/drm/qxl/qxl_kms.c                 |  2 +-
 drivers/gpu/drm/radeon/radeon_acpi.c          |  1 +
 drivers/gpu/drm/radeon/radeon_connectors.c    |  1 +
 drivers/gpu/drm/radeon/radeon_device.c        |  1 +
 drivers/gpu/drm/radeon/radeon_display.c       |  1 +
 drivers/gpu/drm/radeon/radeon_dp_mst.c        |  1 +
 drivers/gpu/drm/radeon/radeon_drv.c           |  1 +
 drivers/gpu/drm/radeon/radeon_irq_kms.c       |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  1 -
 drivers/gpu/drm/rcar-du/rcar_lvds.c           |  2 +-
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c          |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |  2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c       |  2 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c     |  1 +
 drivers/gpu/drm/shmobile/shmob_drm_drv.c      |  1 +
 drivers/gpu/drm/shmobile/shmob_drm_kms.c      |  1 +
 drivers/gpu/drm/sti/sti_crtc.c                |  2 +-
 drivers/gpu/drm/sti/sti_drv.c                 |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                 |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                 |  2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                |  2 +-
 drivers/gpu/drm/sti/sti_tvout.c               |  2 +-
 drivers/gpu/drm/stm/drv.c                     |  2 +-
 drivers/gpu/drm/stm/ltdc.c                    |  2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |  2 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c            |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c        |  2 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c            |  2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c             |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c              |  2 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  2 +-
 drivers/gpu/drm/tegra/drm.h                   |  2 +-
 drivers/gpu/drm/tegra/fb.c                    |  1 +
 drivers/gpu/drm/tegra/hdmi.c                  |  2 +-
 drivers/gpu/drm/tegra/hub.c                   |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  1 +
 drivers/gpu/drm/tilcdc/tilcdc_drv.h           |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_external.c      |  1 +
 drivers/gpu/drm/tilcdc/tilcdc_panel.c         |  1 +
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c        |  1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c   |  2 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c   |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/udl/udl_connector.c           |  1 +
 drivers/gpu/drm/udl/udl_drv.c                 |  1 +
 drivers/gpu/drm/udl/udl_main.c                |  1 +
 drivers/gpu/drm/vc4/vc4_crtc.c                |  2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                 |  2 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                 |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                |  2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                 |  2 +-
 drivers/gpu/drm/vc4/vc4_txp.c                 |  2 +-
 drivers/gpu/drm/vc4/vc4_vec.c                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c      |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  2 +-
 drivers/gpu/drm/vkms/vkms_crtc.c              |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.c               |  2 +-
 drivers/gpu/drm/vkms/vkms_output.c            |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h           |  2 +-
 drivers/gpu/drm/xen/xen_drm_front.c           |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c      |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c       |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c       |  2 +-
 drivers/gpu/drm/zte/zx_drm_drv.c              |  2 +-
 drivers/gpu/drm/zte/zx_hdmi.c                 |  2 +-
 drivers/gpu/drm/zte/zx_tvenc.c                |  2 +-
 drivers/gpu/drm/zte/zx_vga.c                  |  2 +-
 drivers/gpu/drm/zte/zx_vou.c                  |  2 +-
 drivers/staging/vboxvideo/vbox_irq.c          |  4 ++-
 drivers/staging/vboxvideo/vbox_mode.c         |  2 +-
 include/drm/drm_crtc_helper.h                 | 16 -----------
 include/drm/drm_probe_helper.h                | 27 +++++++++++++++++++
 228 files changed, 261 insertions(+), 200 deletions(-)
 create mode 100644 include/drm/drm_probe_helper.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 69ad6ec0a4f3..f0d36787d8d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -25,7 +25,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/amdgpu_drm.h>
 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc1bc65a59c6..9f917dce5897 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -30,7 +30,7 @@
 #include <linux/console.h>
 #include <linux/slab.h>
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/amdgpu_drm.h>
 #include <linux/vgaarb.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0277862d1a74..a1bb3773087b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -32,7 +32,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index aadd0fa42e43..2c99ef35db79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -36,6 +36,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <linux/i2c.h>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 39997d977efb..78173311f718 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -29,7 +29,7 @@
 #include <linux/i2c.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_edid.h>
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 9d2d6986b983..7ef99037167a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -25,7 +25,7 @@
 #include <linux/acpi.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
 #include "dm_services.h"
 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 516795342dd2..d915e8c8769b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -27,7 +27,7 @@
 #include <linux/acpi.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
 #include "dm_services.h"
 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 155ab177ce0b..73e508e00e30 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -15,12 +15,12 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <linux/clk.h>
 #include <linux/platform_data/simplefb.h>
 
diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index 39a79f5718c4..4196f04cd99e 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -15,10 +15,10 @@
  */
 
 #include <linux/clk.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c b/drivers/gpu/drm/arc/arcpgu_sim.c
index 6530d88f7293..ebee4748f5d9 100644
--- a/drivers/gpu/drm/arc/arcpgu_sim.c
+++ b/drivers/gpu/drm/arc/arcpgu_sim.c
@@ -14,7 +14,7 @@
  *
  */
 
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 
 #include "arcpgu.h"
diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index e4d67b70244d..99c188de8651 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -13,7 +13,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 03fb10a2f770..88f300cdff42 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -22,7 +22,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index e1b72782848c..56aad288666e 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -14,7 +14,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <video/videomode.h>
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 505f316a192e..ab50ad06e271 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -23,7 +23,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 91472e5e0c8b..041a64dc7167 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -8,7 +8,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drmP.h>
diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
index 2f7c048c5361..0e91d27921bd 100644
--- a/drivers/gpu/drm/armada/armada_510.c
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -9,7 +9,7 @@
  */
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "armada_crtc.h"
 #include "armada_drm.h"
 #include "armada_hw.h"
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 20dfb29561c2..ba4a3fab7745 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -12,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include "armada_crtc.h"
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 7ebd337b60af..08761ff01739 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -8,6 +8,8 @@
 #ifndef ARMADA_CRTC_H
 #define ARMADA_CRTC_H
 
+#include <drm/drm_crtc.h>
+
 struct armada_gem_object;
 
 struct armada_regs {
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index fa31589b4fc0..e660c5ca52ae 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_of.h>
 #include "armada_crtc.h"
diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index 6bd638a54579..058ac7d9920f 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -5,7 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include "armada_drm.h"
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index bf589c53b908..3871b39d4dea 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -30,6 +30,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "ast_drv.h"
 
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 8bb355d5d43d..97fed0627d1c 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -32,6 +32,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "ast_drv.h"
 
 #include "ast_tables.h"
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 96f4082671fe..8070a558d7b1 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -24,7 +24,7 @@
 #include <linux/pinctrl/consumer.h>
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drmP.h>
 
 #include <video/videomode.h>
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 4cc1e03f0aee..70bd540d644e 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -31,7 +31,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index cea42ac64d7e..cb55bdc36f3f 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "bochs.h"
 
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index e9d5dbc34676..9cd82e3631fb 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -10,6 +10,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_probe_helper.h>
 
 static int defx = 1024;
 static int defy = 768;
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index 73d8ccb97742..4ff7e3bbfce5 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -14,8 +14,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
 
 #define ADV7511_REG_CHIP_REVISION		0x00
 #define ADV7511_REG_N0				0x01
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 85c2d407a52e..aab5faa101a8 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_probe_helper.h>
 
 #include <media/cec.h>
 
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index e11309e9bc4f..22286c6782a4 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -31,7 +31,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 753e96129ab7..c1da8ae3c408 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -26,7 +26,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
 
 #include <drm/bridge/analogix_dp.h>
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index ce9496d13986..48ed444cad50 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -7,7 +7,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9b706789a341..0805801f4e94 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -18,7 +18,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 struct dumb_vga {
 	struct drm_bridge	bridge;
diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 2136c97aeb8e..9687a1a0e737 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -36,7 +36,7 @@
 #include <linux/of.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drmP.h>
 
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index a3e817abace1..a56306421bc7 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -22,7 +22,7 @@
 #include <linux/of_gpio.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 37baa79e95c3..e3687d78cd0c 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -12,7 +12,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 7334d1b62b71..483a7142c5ea 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -26,7 +26,7 @@
 #include <linux/regulator/consumer.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drmP.h>
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index a9b4f45ae87c..43ef8baf747a 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -30,7 +30,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 
 #define SII902X_TPI_VIDEO_DATA			0x0
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 88b720b63126..2fb9772264f0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -25,7 +25,7 @@
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
 #include <drm/bridge/dw_hdmi.h>
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 2f4b145b73af..09a38ae81e52 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -19,7 +19,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/bridge/dw_mipi_dsi.h>
diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index afd491018bfc..282092019e82 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -9,7 +9,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index e6403b9549f1..ac4881d735ff 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -34,7 +34,7 @@
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 10243965ee7c..e74e2c928f51 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -6,7 +6,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index c3e32138c6bb..7bfb4f338813 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -20,7 +20,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #define HOTPLUG_DEBOUNCE_MS		1100
 
diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index db40b77c7f7c..8ec880f3a322 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -12,6 +12,7 @@
 #include <linux/console.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "cirrus_drv.h"
 
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index ed7dcf212a34..a830e70fc0bb 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -17,6 +17,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include <video/cirrus.h>
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 69cbafd5ebee..54417fce5e5c 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -29,7 +29,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_plane_helper.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_writeback.h>
 #include <drm/drm_damage_helper.h>
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 196ebba8af5f..2552a27362a0 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -33,7 +33,7 @@
 #include <drm/drm_fixed.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 /**
  * DOC: dp mst helper
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index 9150fa385bba..6f48137d7192 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -21,7 +21,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index a1bb157bfdfa..c83fee652502 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -32,11 +32,11 @@
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 
+#include <drm/drm_probe_helper.h>
 #include <drm/drmP.h>
 #include <drm/drm_client.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_modeset_helper_vtables.h>
diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 917812448d1b..9fc26a69ab79 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -10,7 +10,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 #include <linux/slab.h>
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 4bf698de5996..a6a7ded37ef1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -21,7 +21,6 @@
 #include <linux/mm_types.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/etnaviv_drm.h>
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index c8449ae4f4fe..9f1c6215be0b 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -23,7 +23,8 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 2696289ecc78..12d3816356ef 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -13,7 +13,7 @@
  */
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_encoder.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 2f0babb67c51..fa95af1dc534 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -11,7 +11,7 @@
 */
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_atomic_helper.h>
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index 2c75e789b2a7..a941d64875f6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -15,7 +15,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index d81e62ae286a..8d28cdbfcddd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -13,7 +13,7 @@
 #include <asm/unaligned.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index 31eb538a44ae..0dc1a688b502 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -14,7 +14,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index c9116dd32187..00bfcd28e589 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -15,7 +15,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/exynos_drm.h>
 
 #include <linux/console.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 19697c1362d8..1b0e4e0f52fe 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -20,7 +20,7 @@
 #include <drm/exynos_drm.h>
 
 #include <drm/drm_edid.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 
 #include "exynos_drm_drv.h"
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index b857df67aff0..d1cd7b71827c 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -16,7 +16,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 
 #include "regs-hdmi.h"
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 18afc94e4dff..bf256971063d 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -16,7 +16,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <video/videomode.h>
 
 #include "fsl_dcu_drm_crtc.h"
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index cd16dfeba082..2eee8ddfc833 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -24,7 +24,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
index ddc68e476a4d..741de83955ec 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -11,7 +11,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 9554b245746e..593f9291b8e2 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -14,7 +14,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 2298ed2a9e1c..577fb1be2d59 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -14,7 +14,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
index e05e5399af2d..313552d2a69d 100644
--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -23,6 +23,7 @@
 #include <linux/i2c-algo-bit.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder.h>
 #include <linux/gpio.h>
 #include "gma_display.h"
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index a956545774a3..2ac593956529 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -18,7 +18,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 
 #include "hibmc_drm_drv.h"
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 68c0c297b3a5..85a701af6530 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index 509f20147bac..04604db0df45 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -17,7 +17,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 
 #include "hibmc_drm_drv.h"
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 744956cea749..d2cf7317930a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -17,7 +17,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index b4c7af3ab6ae..788ec1e53794 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -19,7 +19,7 @@
 #include <linux/component.h>
 
 #include <drm/drm_of.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_encoder_slave.h>
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index bb774202a5a1..8ad7ab7ece9f 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -24,7 +24,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 15e32e5d9101..17b26bd1d0b8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -25,7 +25,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 
 #include "kirin_drm_drv.h"
diff --git a/drivers/gpu/drm/i2c/ch7006_priv.h b/drivers/gpu/drm/i2c/ch7006_priv.h
index dc6414af5d79..25f0abd4fdab 100644
--- a/drivers/gpu/drm/i2c/ch7006_priv.h
+++ b/drivers/gpu/drm/i2c/ch7006_priv.h
@@ -28,6 +28,7 @@
 #define __DRM_I2C_CH7006_PRIV_H__
 
 #include <drm/drmP.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder_slave.h>
 #include <drm/i2c/ch7006.h>
diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil164_drv.c
index c52d7a3af786..14c1fc96a157 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/i2c/sil164_drv.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder_slave.h>
 #include <drm/i2c/sil164.h>
 
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 80e4ff33a37a..df4ed0f9ecb4 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -26,7 +26,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/i2c/tda998x.h>
diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 8d738e6ca7b5..b5da9ead88a9 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -26,9 +26,10 @@
  *
  */
 
-#include <linux/debugfs.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_fourcc.h>
 #include "intel_drv.h"
 #include "intel_guc_submission.h"
 
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 25a6093d963b..aeb38c385df8 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -41,7 +41,7 @@
 #include <linux/vt.h>
 #include <acpi/video.h>
 
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/i915_drm.h>
 
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 80264cb9ca7f..e2bee8a994ca 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -27,6 +27,7 @@
 
 #include <drm/drm_vma_manager.h>
 #include <drm/i915_drm.h>
+#include <drm/drm_pci.h>
 #include "i915_drv.h"
 #include "i915_gem_clflush.h"
 #include "i915_vgpu.h"
@@ -45,6 +46,7 @@
 #include <linux/swap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/mman.h>
 
 static void i915_gem_flush_free_objects(struct drm_i915_private *i915);
 
diff --git a/drivers/gpu/drm/i915/i915_ioc32.c b/drivers/gpu/drm/i915/i915_ioc32.c
index 73c3e8f519e8..c1007245f46d 100644
--- a/drivers/gpu/drm/i915/i915_ioc32.c
+++ b/drivers/gpu/drm/i915/i915_ioc32.c
@@ -29,6 +29,7 @@
 #include <linux/compat.h>
 
 #include <drm/i915_drm.h>
+#include <drm/drm_ioctl.h>
 #include "i915_drv.h"
 
 struct drm_i915_getparam32 {
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 94187e68d39a..8b8a807cf08d 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -31,6 +31,8 @@
 #include <linux/sysrq.h>
 #include <linux/slab.h>
 #include <linux/circ_buf.h>
+#include <drm/drm_irq.h>
+#include <drm/drm_drv.h>
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
 #include "i915_trace.h"
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index dd4aff2b256e..44c23ac60347 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -26,6 +26,8 @@
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 
+#include <drm/drm_drv.h>
+
 #include "i915_drv.h"
 #include "i915_selftest.h"
 
diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index 33d90eca9cdd..43da14f08dc0 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+#include <drm/drm_drv.h>
+
 #include "i915_drv.h"
 #include "intel_drv.h"
 #include "intel_ringbuffer.h"
diff --git a/drivers/gpu/drm/i915/intel_crt.c b/drivers/gpu/drm/i915/intel_crt.c
index 081c333f30d2..77ea0988446a 100644
--- a/drivers/gpu/drm/i915/intel_crt.c
+++ b/drivers/gpu/drm/i915/intel_crt.c
@@ -29,7 +29,7 @@
 #include <linux/slab.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include "intel_drv.h"
 #include <drm/i915_drm.h>
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index af164d712e9e..03542c24478d 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -41,7 +41,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_dp_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_atomic_uapi.h>
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index df4292bb1a4f..1691d006eb81 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -34,7 +34,7 @@
 #include <asm/byteorder.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_hdcp.h>
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index a19699023db1..0a800199918d 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -26,7 +26,7 @@
 #include "i915_drv.h"
 #include "intel_drv.h"
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 
 static int intel_dp_mst_compute_config(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index e5a436c33307..c1eec7c83c44 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -33,12 +33,13 @@
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_dp_dual_mode_helper.h>
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/drm_rect.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_atomic.h>
 #include <media/cec-notifier.h>
 
diff --git a/drivers/gpu/drm/i915/intel_fbc.c b/drivers/gpu/drm/i915/intel_fbc.c
index ccd5e110a19c..3a93cdd1dd91 100644
--- a/drivers/gpu/drm/i915/intel_fbc.c
+++ b/drivers/gpu/drm/i915/intel_fbc.c
@@ -38,6 +38,8 @@
  * forcibly disable it to allow proper screen updates.
  */
 
+#include <drm/drm_fourcc.h>
+
 #include "intel_drv.h"
 #include "i915_drv.h"
 
diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
index 861a0458cb0f..29800fdcf830 100644
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -39,6 +39,8 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
+
 #include "intel_drv.h"
 #include "intel_frontbuffer.h"
 #include <drm/i915_drm.h>
diff --git a/drivers/gpu/drm/i915/intel_lpe_audio.c b/drivers/gpu/drm/i915/intel_lpe_audio.c
index 5d5336fbe7b0..f8239bca3820 100644
--- a/drivers/gpu/drm/i915/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/intel_lpe_audio.c
@@ -65,6 +65,7 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include "i915_drv.h"
 #include <linux/delay.h>
diff --git a/drivers/gpu/drm/i915/intel_overlay.c b/drivers/gpu/drm/i915/intel_overlay.c
index c81db81e4416..c300e5787b3c 100644
--- a/drivers/gpu/drm/i915/intel_overlay.c
+++ b/drivers/gpu/drm/i915/intel_overlay.c
@@ -26,6 +26,8 @@
  * Derived from Xorg ddx, xf86-video-intel, src/i830_video.c
  */
 #include <drm/i915_drm.h>
+#include <drm/drm_fourcc.h>
+
 #include "i915_drv.h"
 #include "i915_reg.h"
 #include "intel_drv.h"
diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index 77a26fd3a44a..06393cd1067d 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -13,7 +13,7 @@
 #include <linux/regmap.h>
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
 
diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 820c7e3878f0..4db26cbed08f 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -13,7 +13,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_cma_helper.h>
diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 2c5bbe317353..ffa742f64d44 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -12,7 +12,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <linux/mfd/syscon.h>
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 293dd5752583..e725af8a0025 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -17,7 +17,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <video/imx-ipu-v3.h>
 
 #include "imx-drm.h"
diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index 058b53c0aa7e..95ddcbf2f6eb 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -12,7 +12,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index f3ce51121dd6..670919781ded 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -10,7 +10,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <linux/videodev2.h>
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 62a9d47df948..22e68a100e7b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -13,7 +13,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_of.h>
 #include <linux/kernel.h>
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 92ecb9bf982c..96709318ad8c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -14,7 +14,7 @@
 #include <asm/barrier.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6422e99952fe..8a48a317cbd3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -15,7 +15,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index be5f6f1daf55..e20fcaef2851 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -12,7 +12,7 @@
  */
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 27b507eb4a99..04bfba71aebf 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -13,7 +13,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index f3ef7bf80563..1fe1b5cd26c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -14,7 +14,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 4f5c67f70c4d..43e29984f8b1 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -30,7 +30,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_flip_work.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "meson_crtc.h"
 #include "meson_plane.h"
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index cc2e30009bd4..95b2429f7fe9 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -31,7 +31,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_flip_work.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index bc25001b8207..a6165b1a564d 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -27,7 +27,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/bridge/dw_hdmi.h>
 
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index f7945bae3b4a..64de3a7026d0 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -27,7 +27,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 
 #include "meson_venc_cvbs.h"
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index acf7bfe68454..7481a3d556ad 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -16,6 +16,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "mgag200_drv.h"
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 9be7c355debd..660c324f861f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -22,7 +22,7 @@
 #include <linux/ktime.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_flip_work.h>
 #include <drm/drm_rect.h>
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 36158b7d99cd..36af231bb73f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -24,7 +24,7 @@
 #include "msm_drv.h"
 #include "dpu_kms.h"
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "dpu_hwio.h"
 #include "dpu_hw_catalog.h"
 #include "dpu_hw_intf.h"
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index cc32ea5f4289..02b4c75ba897 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -16,7 +16,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_flip_work.h>
 #include <drm/drm_mode.h>
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
index 48ce218b8463..caa39b4621e3 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
@@ -18,7 +18,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "mdp4_kms.h"
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
index ff8f2da160c0..259d51971401 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c
@@ -16,7 +16,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "mdp4_kms.h"
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index fff77a4b12c2..df6f9803a1d7 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -17,7 +17,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "mdp4_kms.h"
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
index 976585d8bfd6..9bf9d6065c55 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
@@ -12,7 +12,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "mdp5_kms.h"
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 2f95e6525589..3a9dad897477 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -19,7 +19,7 @@
 #include <linux/sort.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_flip_work.h>
 
 #include "mdp5_kms.h"
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index d2a56e55e53d..820a62c40063 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -17,7 +17,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "mdp5_kms.h"
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9cd6a96c6bf2..353a6fb98adb 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -39,7 +39,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/msm_drm.h>
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 67dfd8d3dc12..2e62c943571d 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -16,7 +16,7 @@
  */
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
 #include "msm_drv.h"
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 24b1f0c1432e..38cdde9841e2 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -19,7 +19,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 72d16ae75d9f..4a580bf5c4ab 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -31,7 +31,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/mxsfb_out.c
index e5edf016a439..1bec96baf948 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
@@ -16,7 +16,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 8fd8124d72ba..26fd71c06626 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -26,6 +26,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "nouveau_drv.h"
 #include "nouveau_reg.h"
 #include "nouveau_encoder.h"
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 67107f0b1299..e3d70027b7a8 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -32,7 +32,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 3f463c91314a..4116ee62adaf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -33,6 +33,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic.h>
 
 #include "nouveau_reg.h"
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 5d273a655479..0b58709f0406 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -29,6 +29,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 
 #include <nvif/class.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 874d8f3cbff6..9da94d10782a 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -17,7 +17,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "omap_drv.h"
 
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 40acf4ce7c9f..d99e24dcc0bf 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -18,7 +18,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_plane_helper.h>
 #include <linux/math64.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 5e67d58cbc28..3a78f0cf3321 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -21,7 +21,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 
 #include "omap_dmm_tiler.h"
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index bd7f2c227a25..0c57d2814c51 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -23,7 +23,6 @@
 #include <linux/workqueue.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/omap_drm.h>
 
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 148b6b20274f..0d85b3a35767 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -18,7 +18,7 @@
 #include <linux/list.h>
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_edid.h>
 
 #include "omap_drv.h"
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 4d264fd554d8..4f8eb9d08f99 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -18,7 +18,7 @@
 #include <linux/seq_file.h>
 
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
 #include "omap_dmm_tiler.h"
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 33e0483d62ae..9dbb11cfbb20 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -64,7 +64,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1f8fddcc34d6..83c8bee71ef4 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -24,9 +24,9 @@
  */
 
 #include <linux/crc32.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 5f5545ee0eea..d856615bdb50 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -33,7 +33,8 @@
 
 #include <drm/drmP.h>
 #include <drm/drm.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 44badfac6544..09d3bcd9ef13 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -28,7 +28,7 @@
 #include <drm/drmP.h>
 #include <drm/drm.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 15238a413f9d..85e13afa1808 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -26,7 +26,7 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <linux/io-mapping.h>
 
 int qxl_log_level;
diff --git a/drivers/gpu/drm/radeon/radeon_acpi.c b/drivers/gpu/drm/radeon/radeon_acpi.c
index 8d3251a10cd4..224cc21bbe38 100644
--- a/drivers/gpu/drm/radeon/radeon_acpi.c
+++ b/drivers/gpu/drm/radeon/radeon_acpi.c
@@ -29,6 +29,7 @@
 #include <acpi/video.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "radeon.h"
 #include "radeon_acpi.h"
 #include "atom.h"
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 414642e5b7a3..88239c1e7c5b 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -26,6 +26,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/radeon_drm.h>
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 59c8a6647ff2..53f29a115104 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_cache.h>
 #include <drm/radeon_drm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 92332226e5cf..e252ab3832a5 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -32,6 +32,7 @@
 
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
index a0c70e27ab65..8d85540bbb43 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -3,6 +3,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "radeon.h"
 #include "atom.h"
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index b8ffee47f764..2e96c886392b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -43,6 +43,7 @@
 #include <drm/drm_fb_helper.h>
 
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 /*
  * KMS wrapper.
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index afaf10db47cc..1d5e3ba7383e 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -27,6 +27,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/radeon_drm.h>
 #include "radeon_reg.h"
 #include "radeon.h"
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 90dacab67be5..39bad26276cd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -15,7 +15,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index f50a3b1864bb..60862858d041 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -19,7 +19,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 1877764bd6d9..a5e7fa1db1c5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -11,7 +11,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 
 #include "rcar_du_drv.h"
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 9c7007d45408..af337c918d84 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -11,7 +11,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 39d5ae3fdf72..279055fbf1da 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -11,7 +11,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 4576119e7777..19d6ff7cfd2e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -10,7 +10,6 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 534a128a869d..24cb74e30fcd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -19,7 +19,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
 
 #include "rcar_lvds_regs.h"
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 080f05352195..2f6b4a4a9d6b 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -21,7 +21,7 @@
 #include <linux/clk.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 8ad0d773dc33..7896b3c28676 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -14,7 +14,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index f57e296401b8..7000b53dddcb 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -16,7 +16,7 @@
 #define _CDN_DP_CORE_H
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include "rockchip_drm_drv.h"
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 89c63cfde5c8..1e2cc2b02a31 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -16,7 +16,7 @@
 
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/bridge/dw_hdmi.h>
 
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 27c945e030a0..95fc9cfd19d3 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -26,7 +26,7 @@
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 
 #include "rockchip_drm_drv.h"
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index be6c2573039a..d2b69a533692 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -15,7 +15,7 @@
  */
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 08bec50d9c5d..59221012adb8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -17,7 +17,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
 #include "rockchip_drm_drv.h"
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index c5062e846b7c..fed7d7698164 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -15,7 +15,7 @@
 #include <drm/drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 22a70ab6e214..a0c8bd235b67 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -14,7 +14,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_psr.h"
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 619b6db05d58..a6c65b61dd00 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -17,7 +17,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_flip_work.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 456bd9f13bae..fd21901880e6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -16,7 +16,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 37f93022a106..2bd043eb0ffb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -16,7 +16,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index 499b5fdb869f..8e77ba8186a8 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -13,6 +13,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index a8416abb0ed4..d4cd9a637b8c 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -17,6 +17,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
 #include "shmob_drm_drv.h"
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
index a17268444c6d..2e866af7b9e7 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
@@ -10,6 +10,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index ec9f87483e39..f73e50282079 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -11,7 +11,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 
 #include "sti_compositor.h"
diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index ac54e0f9caea..dc932ac58ba9 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -14,7 +14,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index b08376b7611b..d0fcb20e9614 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -13,7 +13,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
 
 #include "sti_awg_utils.h"
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 19b9b5ed1297..40a0b392fa51 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -12,7 +12,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 /* HDformatter registers */
 #define HDA_ANA_CFG                     0x0000
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 4b86878f8ddf..dc014c9090fa 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -15,7 +15,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 
 #include <sound/hdmi-codec.h>
diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index ea4a3b87fa55..c42f2fa7053c 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -15,7 +15,7 @@
 #include <linux/seq_file.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "sti_crtc.h"
 #include "sti_drv.h"
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8dec001b9d37..c64c5f27a229 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -13,7 +13,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661aa0ac..8189b5df7ece 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -16,7 +16,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index a021bab11a4f..4143e4c8250a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -14,7 +14,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 3eedf335a935..3d58d8951474 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -13,7 +13,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_modes.h>
 
 #include <linux/clk-provider.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9e4c375ccc96..45c85be54ce0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -16,7 +16,7 @@
 #include <linux/of_reserved_mem.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_helper.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 554a6f4561f3..d95c6e224bd9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -11,7 +11,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index e7eb0d1e17be..87ba8db71a54 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -8,7 +8,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f4a22689eb54..f6f7f4de2e69 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -14,7 +14,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0420f5c978b9..3a09d8e28c25 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -14,7 +14,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 1a838d208211..62fbdef8fffb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -18,7 +18,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e3b34a345546..dfa2d15d7b36 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -19,7 +19,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 44a9ba7d8433..9ef1b494e48d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -14,7 +14,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 18534263a05d..e29cbd60a59b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -16,7 +16,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 87be898f9b7a..1669460106de 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -10,7 +10,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 1012335bb489..40d38f3d9d9e 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -17,7 +17,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index cd8bd83a5568..ea82184073bd 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -15,6 +15,7 @@
 #include "drm.h"
 #include "gem.h"
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_modeset_helper.h>
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
 static inline struct tegra_fbdev *to_tegra_fbdev(struct drm_fb_helper *helper)
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index a7566c67bfb0..78bc7c906e22 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -18,7 +18,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include <sound/hda_verbs.h>
 
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 71cc3cf60066..ba9b3cfb8c3d 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -19,7 +19,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "drm.h"
 #include "dc.h"
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index f6ce98b48358..1099daf5e3e3 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -22,6 +22,7 @@
 #include <linux/suspend.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index 62cea5ff5558..028bfed667f0 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -30,7 +30,6 @@
 #include <linux/list.h>
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_bridge.h>
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index b4eaf9bc87f8..385fb4d2f66f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -11,6 +11,7 @@
 #include <linux/component.h>
 #include <linux/of_graph.h>
 #include <drm/drm_of.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "tilcdc_drv.h"
 #include "tilcdc_external.h"
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index a1acab39d87f..5c21ef6e6510 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -22,6 +22,7 @@
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 
 #include "tilcdc_drv.h"
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index daebf1aa6b0a..fe59fbfdde69 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/consumer.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include "tilcdc_drv.h"
 #include "tilcdc_tfp410.h"
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
index aeb93eadb047..1f8c288a075f 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
@@ -9,11 +9,11 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/tinydrm/tinydrm.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
index d4576d6e8ce4..5c1ead7b70c3 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
@@ -8,11 +8,11 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/tinydrm/tinydrm.h>
 
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 28e2d03c0ccf..138a9a158254 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -43,7 +43,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
index 68e88bed77ca..66885c24590f 100644
--- a/drivers/gpu/drm/udl/udl_connector.c
+++ b/drivers/gpu/drm/udl/udl_connector.c
@@ -14,6 +14,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "udl_connector.h"
 #include "udl_drv.h"
 
diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index a63e3011e971..22cd2d13e272 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "udl_drv.h"
 
 static int udl_usb_suspend(struct usb_interface *interface,
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 1b014d92855b..9086d0d1b880 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -12,6 +12,7 @@
  */
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include "udl_drv.h"
 
 /* -BULK_SIZE as per usb-skeleton. Can we get full page and avoid overhead? */
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 97caf1671dd0..33ad05d9ea83 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -34,7 +34,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <linux/clk.h>
 #include <drm/drm_fb_cma_helper.h>
diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index f185812970da..a4d5a13598ba 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -24,7 +24,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 0c607eb33d7e..4c2f5e143d11 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -30,7 +30,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 051b61b62541..c140bf516a86 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -43,7 +43,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <linux/clk.h>
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 0490edb192a1..8dbb81571773 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -17,7 +17,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include "vc4_drv.h"
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 6e23c50168f9..8ac1b95d01c4 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -9,7 +9,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_cma_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_writeback.h>
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 8e7facb6514e..e8b09c670ee6 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -25,7 +25,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel.h>
 #include <linux/clk.h>
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 87d7c49cf057..070d881d6ee3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -26,7 +26,7 @@
  */
 
 #include "virtgpu_drv.h"
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 4f2f3c43a411..459c9eb6b2be 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -34,7 +34,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_atomic.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/ttm/ttm_bo_api.h>
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 177bbcb38306..2696c370fe9b 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -8,7 +8,7 @@
 
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 static void _vblank_handle(struct vkms_output *output)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 2a16b86196dc..b733c9700a78 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -16,7 +16,7 @@
 
 #include <linux/module.h>
 #include <drm/drm_gem.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 271a0eb9042c..878ff3142473 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -7,7 +7,7 @@
  */
 
 #include "vkms_drv.h"
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_atomic_helper.h>
 
 static void vkms_connector_destroy(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 655abbcd4058..d560f6159bb1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -29,7 +29,7 @@
 #define VMWGFX_KMS_H_
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_encoder.h>
 #include "vmwgfx_drv.h"
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 4d3d36fc3a5d..3e78a832d7f9 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -10,7 +10,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem.h>
 
 #include <linux/of_device.h>
diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index 54af2669b1b3..9f5f31f77f1e 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -9,7 +9,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 
 #include <video/videomode.h>
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 28bc501af450..dfcf6516dd1c 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -11,7 +11,7 @@
 #include "xen_drm_front_gem.h"
 
 #include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index a3479eb72d79..f536d9f5a796 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -13,7 +13,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
index f5ea32ae8600..91eaaa475d36 100644
--- a/drivers/gpu/drm/zte/zx_drm_drv.c
+++ b/drivers/gpu/drm/zte/zx_drm_drv.c
@@ -18,7 +18,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/gpu/drm/zte/zx_hdmi.c b/drivers/gpu/drm/zte/zx_hdmi.c
index 9fc98bb4f3d9..9854c1bce13f 100644
--- a/drivers/gpu/drm/zte/zx_hdmi.c
+++ b/drivers/gpu/drm/zte/zx_hdmi.c
@@ -20,7 +20,7 @@
 #include <linux/of_device.h>
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
diff --git a/drivers/gpu/drm/zte/zx_tvenc.c b/drivers/gpu/drm/zte/zx_tvenc.c
index b73afb212fb2..87b5d86413d2 100644
--- a/drivers/gpu/drm/zte/zx_tvenc.c
+++ b/drivers/gpu/drm/zte/zx_tvenc.c
@@ -14,7 +14,7 @@
 #include <linux/regmap.h>
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drmP.h>
 
 #include "zx_drm_drv.h"
diff --git a/drivers/gpu/drm/zte/zx_vga.c b/drivers/gpu/drm/zte/zx_vga.c
index 23d1ff4355a0..e14c1d709740 100644
--- a/drivers/gpu/drm/zte/zx_vga.c
+++ b/drivers/gpu/drm/zte/zx_vga.c
@@ -13,7 +13,7 @@
 #include <linux/regmap.h>
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drmP.h>
 
 #include "zx_drm_drv.h"
diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
index 442311d31110..9d97f4417698 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -15,7 +15,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/drivers/staging/vboxvideo/vbox_irq.c b/drivers/staging/vboxvideo/vbox_irq.c
index f3d9895c79d8..337feee93e86 100644
--- a/drivers/staging/vboxvideo/vbox_irq.c
+++ b/drivers/staging/vboxvideo/vbox_irq.c
@@ -9,7 +9,9 @@
  *          Hans de Goede <hdegoede@redhat.com>
  */
 
-#include <drm/drm_crtc_helper.h>
+#include <linux/pci.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_irq.h>
 
 #include "vbox_drv.h"
 #include "vboxvideo.h"
diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index c43bec4628ae..30ffa99b69f8 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -11,7 +11,7 @@
  */
 #include <linux/export.h>
 #include <drm/drm_atomic.h>
-#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_helper.h>
 
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index 0ee9a96b70da..a6d520d5b6ca 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -58,20 +58,4 @@ int drm_helper_connector_dpms(struct drm_connector *connector, int mode);
 void drm_helper_resume_force_mode(struct drm_device *dev);
 int drm_helper_force_disable_all(struct drm_device *dev);
 
-/* drm_probe_helper.c */
-int drm_helper_probe_single_connector_modes(struct drm_connector
-					    *connector, uint32_t maxX,
-					    uint32_t maxY);
-int drm_helper_probe_detect(struct drm_connector *connector,
-			    struct drm_modeset_acquire_ctx *ctx,
-			    bool force);
-void drm_kms_helper_poll_init(struct drm_device *dev);
-void drm_kms_helper_poll_fini(struct drm_device *dev);
-bool drm_helper_hpd_irq_event(struct drm_device *dev);
-void drm_kms_helper_hotplug_event(struct drm_device *dev);
-
-void drm_kms_helper_poll_disable(struct drm_device *dev);
-void drm_kms_helper_poll_enable(struct drm_device *dev);
-bool drm_kms_helper_is_poll_worker(void);
-
 #endif
diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_helper.h
new file mode 100644
index 000000000000..8d3ed2834d34
--- /dev/null
+++ b/include/drm/drm_probe_helper.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+#ifndef __DRM_PROBE_HELPER_H__
+#define __DRM_PROBE_HELPER_H__
+
+#include <linux/types.h>
+
+struct drm_connector;
+struct drm_device;
+struct drm_modeset_acquire_ctx;
+
+int drm_helper_probe_single_connector_modes(struct drm_connector
+					    *connector, uint32_t maxX,
+					    uint32_t maxY);
+int drm_helper_probe_detect(struct drm_connector *connector,
+			    struct drm_modeset_acquire_ctx *ctx,
+			    bool force);
+void drm_kms_helper_poll_init(struct drm_device *dev);
+void drm_kms_helper_poll_fini(struct drm_device *dev);
+bool drm_helper_hpd_irq_event(struct drm_device *dev);
+void drm_kms_helper_hotplug_event(struct drm_device *dev);
+
+void drm_kms_helper_poll_disable(struct drm_device *dev);
+void drm_kms_helper_poll_enable(struct drm_device *dev);
+bool drm_kms_helper_is_poll_worker(void);
+
+#endif
-- 
2.20.1
