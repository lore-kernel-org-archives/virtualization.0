From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 0/3] drm: drm_encoder_init() => drm_encoder_init_funcs()
Date: Fri, 13 Mar 2020 21:17:41 +0100
Message-ID: <20200313201744.19773-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, amd-gfx@lists.freedesktop.org, Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Boris Brezillon <bbrezillon@kernel.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.velikov@collabora.com>, Gerd Hoffmann <kraxel@redhat.com>, Jose Roberto de Souza <jose.souza@intel.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.c>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Zimmermann had made a nice patch-set that introduced
drm_simple_encoder_init() which is already present in drm-misc-next.

While looking at this it was suddenly obvious to me that
this was functionalty that really should be included in drm_encoder.c
The case where the core could handle the callback is pretty
common and not part of the simple pipe line.

So after some dialog on dri-devel the conclusion was to go for
a change like this:

    drm_encoder_init_funcs() for all users that specified a
    drm_encoder_funcs to extend the functionality.

    drm_encoder_init() for all users that did not
    need to extend the basic functionality with
    drm_encoder_funcs.

A similar approach with a _funcs() prefix is used elsewhere in drm/

This required a rename of the existing users, and
a follow-up patch that moves drm_simple_encoder_init()
to drm_encoder.c

Patches 3 in this set demonstrate the use of drm_encoder_init().
There are many more drivers that can be converted as Thomas
has already demonstrated.

This is all based on work done by Thomas Zimmermann,
I just wanted to implement my suggestion so
we could select the best way forward.

Note: Daniel Vetter has hinted the approach implemented
here smelled like middle-layer.
IMO this is not so, it is just a way to handle cleanup
for the simple cases.

	Sam


Sam Ravnborg (3):
      drm: drm_encoder_init() => drm_encoder_init_funcs()
      drm: drm_simple_encoder_init() => drm_encoder_init()
      drm/atmel-hlcdc: Use drm_encoder_init()

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             | 28 ++++++-------
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             | 28 ++++++-------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              | 28 ++++++-------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              | 28 ++++++-------
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 10 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 ++---
 drivers/gpu/drm/arc/arcpgu_hdmi.c                  |  4 +-
 drivers/gpu/drm/arc/arcpgu_sim.c                   |  4 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  3 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  8 +---
 drivers/gpu/drm/drm_encoder.c                      | 49 +++++++++++++++++++---
 drivers/gpu/drm/drm_encoder_slave.c                |  2 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            | 45 +-------------------
 drivers/gpu/drm/drm_writeback.c                    |  6 +--
 drivers/gpu/drm/exynos/exynos_dp.c                 |  4 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  4 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  4 +-
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |  5 ++-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |  4 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |  4 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |  6 +--
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |  7 ++--
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |  6 +--
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |  4 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |  6 +--
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |  4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |  4 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |  4 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |  5 ++-
 drivers/gpu/drm/i915/display/icl_dsi.c             |  4 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |  5 ++-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  6 ++-
 drivers/gpu/drm/i915/display/intel_dp.c            |  6 +--
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  6 ++-
 drivers/gpu/drm/i915/display/intel_dvo.c           |  6 +--
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  6 +--
 drivers/gpu/drm/i915/display/intel_lvds.c          |  4 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  6 +--
 drivers/gpu/drm/i915/display/intel_tv.c            |  4 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  5 ++-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |  4 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |  4 +-
 drivers/gpu/drm/imx/imx-tve.c                      |  4 +-
 drivers/gpu/drm/imx/parallel-display.c             |  4 +-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |  5 ++-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  5 ++-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  4 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  5 ++-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |  5 ++-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |  7 +---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c   |  4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c   |  4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  |  4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c       |  3 +-
 drivers/gpu/drm/nouveau/dispnv04/dac.c             |  4 +-
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  3 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  4 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |  4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 16 +++----
 drivers/gpu/drm/omapdrm/omap_encoder.c             |  4 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  7 +---
 drivers/gpu/drm/radeon/atombios_encoders.c         | 40 +++++++++---------
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |  4 +-
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    | 20 ++++-----
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |  4 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  5 ++-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  4 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |  5 ++-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  4 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  4 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |  4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |  5 ++-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |  5 ++-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |  4 +-
 drivers/gpu/drm/sti/sti_tvout.c                    | 16 +++----
 drivers/gpu/drm/stm/ltdc.c                         |  4 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 10 ++---
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 | 10 ++---
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 10 ++---
 drivers/gpu/drm/sun4i/sun4i_tv.c                   | 10 ++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             | 10 ++---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |  4 +-
 drivers/gpu/drm/tegra/dsi.c                        |  6 +--
 drivers/gpu/drm/tegra/hdmi.c                       |  5 ++-
 drivers/gpu/drm/tegra/rgb.c                        |  4 +-
 drivers/gpu/drm/tegra/sor.c                        |  4 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |  4 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |  8 ++--
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |  4 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  4 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |  4 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |  4 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  4 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |  4 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |  4 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  5 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  4 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |  4 +-
 drivers/gpu/drm/zte/zx_tvenc.c                     |  4 +-
 drivers/gpu/drm/zte/zx_vga.c                       |  4 +-
 include/drm/drm_encoder.h                          |  9 ++--
 include/drm/drm_simple_kms_helper.h                |  4 --
 109 files changed, 394 insertions(+), 395 deletions(-)
