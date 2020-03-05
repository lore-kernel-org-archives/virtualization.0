From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 00/22] drm: Convert drivers to drm_simple_encoder_init()
Date: Thu,  5 Mar 2020 16:59:28 +0100
Message-ID: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

A call to drm_simple_encoder_init() initializes an encoder without
further functionality. It only provides the destroy callback to
cleanup the encoder's state. Only few drivers implement more
sophisticated encoders than that. Most drivers implement such a
simple encoder and can use drm_simple_encoder_init() instead.

The patchset converts drivers where the encoder's instance is
embedded in a larger data structure. The driver releases the
memory during cleanup. Each patch replaces drm_encoder_init() with
drm_simple_encoder_init() and removes the (now unused) driver's
encoder functions.

While the patchset is fairly large, the indiviual patches are self-
contained and can be merged independently from each other. The
simple-encoder functionality is currently in drm-misc-next, where
these patches could go as well.

Future directions: There's another common case where the driver
calls kzalloc() plus drm_encoder_init(). Such drivers are not
handled by this patchset. The plan here is to use a simple encoder
with either managed memory allocation (once it's merged), or embed
the encoder in a larger data structure and drop kzalloc() entirely.

The patchset has been compile-tested on x86-64, aarch64 and arm.

Thomas Zimmermann (22):
  drm/arc: Use simple encoder
  drm/atmel-hlcdc: Use simple encoder
  drm/exynos: Use simple encoder
  drm/fsl-dcu: Use simple encoder
  drm/gma500: Use simple encoder
  drm/hisilicon/kirin: Use simple encoder
  drm/i2c/tda998x: Use simple encoder
  drm/imx: Use simple encoder
  drm/ingenic: Use simple encoder
  drm/mediatek: Use simple encoder
  drm/rcar-du: Use simple encoder
  drm/rockchip: Use simple encoder
  drm/shmobile: Use simple encoder
  drm/sun4i: Use simple encoder
  drm/tegra: Use simple encoder
  drm/tidss: Use simple encoder
  drm/tilcdc: Use simple encoder
  drm/vc4: Use simple encoder
  drm/virtgpu: Use simple encoder
  drm/vkms: Use simple encoder
  drm/writeback: Use simple encoder
  drm/zte: Use simple encoder

 drivers/gpu/drm/arc/arcpgu_hdmi.c              | 10 +++-------
 drivers/gpu/drm/arc/arcpgu_sim.c               |  8 ++------
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 12 ++++--------
 drivers/gpu/drm/drm_writeback.c                | 10 +++-------
 drivers/gpu/drm/exynos/exynos_dp.c             |  8 ++------
 drivers/gpu/drm/exynos/exynos_drm_dpi.c        |  8 ++------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c        |  8 ++------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c       |  8 ++------
 drivers/gpu/drm/exynos/exynos_hdmi.c           |  8 ++------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c      | 14 +++-----------
 drivers/gpu/drm/gma500/cdv_intel_crt.c         | 14 +++-----------
 drivers/gpu/drm/gma500/cdv_intel_dp.c          | 16 +++-------------
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c        |  4 ++--
 drivers/gpu/drm/gma500/cdv_intel_lvds.c        | 17 +++--------------
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c         |  7 +++----
 drivers/gpu/drm/gma500/mdfld_output.h          |  1 -
 drivers/gpu/drm/gma500/mdfld_tmd_vid.c         |  6 ------
 drivers/gpu/drm/gma500/mdfld_tpo_vid.c         |  6 ------
 drivers/gpu/drm/gma500/oaktrail_hdmi.c         | 14 ++------------
 drivers/gpu/drm/gma500/oaktrail_lvds.c         |  5 +++--
 drivers/gpu/drm/gma500/psb_intel_drv.h         |  1 -
 drivers/gpu/drm/gma500/psb_intel_lvds.c        | 18 +++---------------
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c     |  5 -----
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c   |  8 ++------
 drivers/gpu/drm/i2c/tda998x_drv.c              | 14 +++-----------
 drivers/gpu/drm/imx/dw_hdmi-imx.c              |  8 ++------
 drivers/gpu/drm/imx/imx-drm-core.c             |  6 ------
 drivers/gpu/drm/imx/imx-drm.h                  |  1 -
 drivers/gpu/drm/imx/imx-ldb.c                  |  8 ++------
 drivers/gpu/drm/imx/imx-tve.c                  |  8 ++------
 drivers/gpu/drm/imx/parallel-display.c         |  8 ++------
 drivers/gpu/drm/ingenic/ingenic-drm.c          |  9 +++------
 drivers/gpu/drm/mediatek/mtk_dpi.c             | 14 +++-----------
 drivers/gpu/drm/mediatek/mtk_dsi.c             | 14 +++-----------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c      | 14 +++-----------
 .../gpu/drm/rockchip/analogix_dp-rockchip.c    |  9 +++------
 drivers/gpu/drm/rockchip/cdn-dp-core.c         |  9 +++------
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |  8 ++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c    |  8 ++------
 drivers/gpu/drm/rockchip/inno_hdmi.c           |  8 ++------
 drivers/gpu/drm/rockchip/rk3066_hdmi.c         |  8 ++------
 drivers/gpu/drm/rockchip/rockchip_lvds.c       | 10 +++-------
 drivers/gpu/drm/rockchip/rockchip_rgb.c        |  8 ++------
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c      | 14 +++-----------
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c         | 12 +++---------
 drivers/gpu/drm/sun4i/sun4i_lvds.c             | 12 +++---------
 drivers/gpu/drm/sun4i/sun4i_rgb.c              | 17 +++--------------
 drivers/gpu/drm/sun4i/sun4i_tv.c               | 17 +++--------------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c         | 12 +++---------
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c          |  8 ++------
 drivers/gpu/drm/tegra/drm.h                    |  2 --
 drivers/gpu/drm/tegra/dsi.c                    | 10 +++-------
 drivers/gpu/drm/tegra/hdmi.c                   |  9 +++------
 drivers/gpu/drm/tegra/output.c                 |  6 +-----
 drivers/gpu/drm/tegra/rgb.c                    |  8 ++------
 drivers/gpu/drm/tegra/sor.c                    |  8 ++------
 drivers/gpu/drm/tidss/tidss_encoder.c          | 10 +++-------
 drivers/gpu/drm/tilcdc/tilcdc_external.c       | 10 +++-------
 drivers/gpu/drm/tilcdc/tilcdc_panel.c          |  8 ++------
 drivers/gpu/drm/vc4/vc4_dpi.c                  |  8 ++------
 drivers/gpu/drm/vc4/vc4_dsi.c                  | 15 +++------------
 drivers/gpu/drm/vc4/vc4_hdmi.c                 | 17 ++++-------------
 drivers/gpu/drm/vc4/vc4_vec.c                  |  8 ++------
 drivers/gpu/drm/virtio/virtgpu_display.c       |  8 ++------
 drivers/gpu/drm/vkms/vkms_output.c             |  8 ++------
 drivers/gpu/drm/zte/zx_hdmi.c                  |  8 ++------
 drivers/gpu/drm/zte/zx_tvenc.c                 |  8 ++------
 drivers/gpu/drm/zte/zx_vga.c                   |  8 ++------
 68 files changed, 151 insertions(+), 488 deletions(-)
