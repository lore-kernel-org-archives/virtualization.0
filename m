From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 00/22] drm: Convert drivers to drm_simple_encoder_init()
Date: Fri, 6 Mar 2020 11:56:59 +0100
Message-ID: <20200306105659.GY2363188@phenom.ffwll.local>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200305155950.2705-1-tzimmermann@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org, abrodkin@synopsys.com, bbrezillon@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jingoohan1@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org, stefan@agner.ch, alison.wang@nxp.com, patrik.r.jakobsson@gmail.com, xinliang.liu@linaro.org, zourongrong@gmail.com, john.stultz@linaro.org, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, linux@armlinux.org.uk, p.zabel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, paul@crapouillou.net, ck.hu@mediatek.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 05, 2020 at 04:59:28PM +0100, Thomas Zimmermann wrote:
> A call to drm_simple_encoder_init() initializes an encoder without
> further functionality. It only provides the destroy callback to
> cleanup the encoder's state. Only few drivers implement more
> sophisticated encoders than that. Most drivers implement such a
> simple encoder and can use drm_simple_encoder_init() instead.
> 
> The patchset converts drivers where the encoder's instance is
> embedded in a larger data structure. The driver releases the
> memory during cleanup. Each patch replaces drm_encoder_init() with
> drm_simple_encoder_init() and removes the (now unused) driver's
> encoder functions.
> 
> While the patchset is fairly large, the indiviual patches are self-
> contained and can be merged independently from each other. The
> simple-encoder functionality is currently in drm-misc-next, where
> these patches could go as well.
> 
> Future directions: There's another common case where the driver
> calls kzalloc() plus drm_encoder_init(). Such drivers are not
> handled by this patchset. The plan here is to use a simple encoder
> with either managed memory allocation (once it's merged), or embed
> the encoder in a larger data structure and drop kzalloc() entirely.
> 
> The patchset has been compile-tested on x86-64, aarch64 and arm.

So from a cursory look all these drivers get it wrong and devm_kzalloc
their encoders. But I guess simplifying stuff like you do here will at
least give us a nice list of things to look at once we get to the
drmm_simple_encoder_init version of all this. On the series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> Thomas Zimmermann (22):
>   drm/arc: Use simple encoder
>   drm/atmel-hlcdc: Use simple encoder
>   drm/exynos: Use simple encoder
>   drm/fsl-dcu: Use simple encoder
>   drm/gma500: Use simple encoder
>   drm/hisilicon/kirin: Use simple encoder
>   drm/i2c/tda998x: Use simple encoder
>   drm/imx: Use simple encoder
>   drm/ingenic: Use simple encoder
>   drm/mediatek: Use simple encoder
>   drm/rcar-du: Use simple encoder
>   drm/rockchip: Use simple encoder
>   drm/shmobile: Use simple encoder
>   drm/sun4i: Use simple encoder
>   drm/tegra: Use simple encoder
>   drm/tidss: Use simple encoder
>   drm/tilcdc: Use simple encoder
>   drm/vc4: Use simple encoder
>   drm/virtgpu: Use simple encoder
>   drm/vkms: Use simple encoder
>   drm/writeback: Use simple encoder
>   drm/zte: Use simple encoder
> 
>  drivers/gpu/drm/arc/arcpgu_hdmi.c              | 10 +++-------
>  drivers/gpu/drm/arc/arcpgu_sim.c               |  8 ++------
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 12 ++++--------
>  drivers/gpu/drm/drm_writeback.c                | 10 +++-------
>  drivers/gpu/drm/exynos/exynos_dp.c             |  8 ++------
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c        |  8 ++------
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c        |  8 ++------
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c       |  8 ++------
>  drivers/gpu/drm/exynos/exynos_hdmi.c           |  8 ++------
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c      | 14 +++-----------
>  drivers/gpu/drm/gma500/cdv_intel_crt.c         | 14 +++-----------
>  drivers/gpu/drm/gma500/cdv_intel_dp.c          | 16 +++-------------
>  drivers/gpu/drm/gma500/cdv_intel_hdmi.c        |  4 ++--
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c        | 17 +++--------------
>  drivers/gpu/drm/gma500/mdfld_dsi_dpi.c         |  7 +++----
>  drivers/gpu/drm/gma500/mdfld_output.h          |  1 -
>  drivers/gpu/drm/gma500/mdfld_tmd_vid.c         |  6 ------
>  drivers/gpu/drm/gma500/mdfld_tpo_vid.c         |  6 ------
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c         | 14 ++------------
>  drivers/gpu/drm/gma500/oaktrail_lvds.c         |  5 +++--
>  drivers/gpu/drm/gma500/psb_intel_drv.h         |  1 -
>  drivers/gpu/drm/gma500/psb_intel_lvds.c        | 18 +++---------------
>  drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c     |  5 -----
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c   |  8 ++------
>  drivers/gpu/drm/i2c/tda998x_drv.c              | 14 +++-----------
>  drivers/gpu/drm/imx/dw_hdmi-imx.c              |  8 ++------
>  drivers/gpu/drm/imx/imx-drm-core.c             |  6 ------
>  drivers/gpu/drm/imx/imx-drm.h                  |  1 -
>  drivers/gpu/drm/imx/imx-ldb.c                  |  8 ++------
>  drivers/gpu/drm/imx/imx-tve.c                  |  8 ++------
>  drivers/gpu/drm/imx/parallel-display.c         |  8 ++------
>  drivers/gpu/drm/ingenic/ingenic-drm.c          |  9 +++------
>  drivers/gpu/drm/mediatek/mtk_dpi.c             | 14 +++-----------
>  drivers/gpu/drm/mediatek/mtk_dsi.c             | 14 +++-----------
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c      | 14 +++-----------
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c    |  9 +++------
>  drivers/gpu/drm/rockchip/cdn-dp-core.c         |  9 +++------
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |  8 ++------
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c    |  8 ++------
>  drivers/gpu/drm/rockchip/inno_hdmi.c           |  8 ++------
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c         |  8 ++------
>  drivers/gpu/drm/rockchip/rockchip_lvds.c       | 10 +++-------
>  drivers/gpu/drm/rockchip/rockchip_rgb.c        |  8 ++------
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c      | 14 +++-----------
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c         | 12 +++---------
>  drivers/gpu/drm/sun4i/sun4i_lvds.c             | 12 +++---------
>  drivers/gpu/drm/sun4i/sun4i_rgb.c              | 17 +++--------------
>  drivers/gpu/drm/sun4i/sun4i_tv.c               | 17 +++--------------
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c         | 12 +++---------
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c          |  8 ++------
>  drivers/gpu/drm/tegra/drm.h                    |  2 --
>  drivers/gpu/drm/tegra/dsi.c                    | 10 +++-------
>  drivers/gpu/drm/tegra/hdmi.c                   |  9 +++------
>  drivers/gpu/drm/tegra/output.c                 |  6 +-----
>  drivers/gpu/drm/tegra/rgb.c                    |  8 ++------
>  drivers/gpu/drm/tegra/sor.c                    |  8 ++------
>  drivers/gpu/drm/tidss/tidss_encoder.c          | 10 +++-------
>  drivers/gpu/drm/tilcdc/tilcdc_external.c       | 10 +++-------
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c          |  8 ++------
>  drivers/gpu/drm/vc4/vc4_dpi.c                  |  8 ++------
>  drivers/gpu/drm/vc4/vc4_dsi.c                  | 15 +++------------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                 | 17 ++++-------------
>  drivers/gpu/drm/vc4/vc4_vec.c                  |  8 ++------
>  drivers/gpu/drm/virtio/virtgpu_display.c       |  8 ++------
>  drivers/gpu/drm/vkms/vkms_output.c             |  8 ++------
>  drivers/gpu/drm/zte/zx_hdmi.c                  |  8 ++------
>  drivers/gpu/drm/zte/zx_tvenc.c                 |  8 ++------
>  drivers/gpu/drm/zte/zx_vga.c                   |  8 ++------
>  68 files changed, 151 insertions(+), 488 deletions(-)
> 
> --
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
