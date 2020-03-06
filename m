From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 03/22] drm/exynos: Use simple encoder
Date: Fri, 6 Mar 2020 22:28:09 +0100
Message-ID: <20200306212809.GC17369@ravnborg.org>
References: <20200305155950.2705-1-tzimmermann@suse.de>
 <20200305155950.2705-4-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200305155950.2705-4-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Cc: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, matthias
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 05, 2020 at 04:59:31PM +0100, Thomas Zimmermann wrote:
> The exynos driver uses empty implementations for its encoders. Replace
> the code with the generic simple encoder.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>

Acked-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>

> ---
>  drivers/gpu/drm/exynos/exynos_dp.c       | 8 ++------
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 8 ++------
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 8 ++------
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c | 8 ++------
>  drivers/gpu/drm/exynos/exynos_hdmi.c     | 8 ++------
>  5 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index d23d3502ca91..a61482af2998 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  #include <drm/exynos_drm.h>
>  
>  #include "exynos_drm_crtc.h"
> @@ -135,10 +136,6 @@ static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
>  	.disable = exynos_dp_nop,
>  };
>  
> -static const struct drm_encoder_funcs exynos_dp_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  static int exynos_dp_dt_parse_panel(struct exynos_dp_device *dp)
>  {
>  	int ret;
> @@ -174,8 +171,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  			return ret;
>  	}
>  
> -	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
> -			 DRM_MODE_ENCODER_TMDS, NULL);
> +	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
>  
>  	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> index 43fa0f26c052..7ba5354e7d94 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> @@ -14,6 +14,7 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include <video/of_videomode.h>
>  #include <video/videomode.h>
> @@ -149,10 +150,6 @@ static const struct drm_encoder_helper_funcs exynos_dpi_encoder_helper_funcs = {
>  	.disable = exynos_dpi_disable,
>  };
>  
> -static const struct drm_encoder_funcs exynos_dpi_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  enum {
>  	FIMD_PORT_IN0,
>  	FIMD_PORT_IN1,
> @@ -201,8 +198,7 @@ int exynos_dpi_bind(struct drm_device *dev, struct drm_encoder *encoder)
>  {
>  	int ret;
>  
> -	drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
> -			 DRM_MODE_ENCODER_TMDS, NULL);
> +	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
>  
>  	drm_encoder_helper_add(encoder, &exynos_dpi_encoder_helper_funcs);
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 669d3857502a..2986c93382e0 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -30,6 +30,7 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include "exynos_drm_crtc.h"
>  #include "exynos_drm_drv.h"
> @@ -1524,10 +1525,6 @@ static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
>  	.disable = exynos_dsi_disable,
>  };
>  
> -static const struct drm_encoder_funcs exynos_dsi_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  MODULE_DEVICE_TABLE(of, exynos_dsi_of_match);
>  
>  static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
> @@ -1705,8 +1702,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  	struct drm_bridge *in_bridge;
>  	int ret;
>  
> -	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
> -			 DRM_MODE_ENCODER_TMDS, NULL);
> +	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
>  
>  	drm_encoder_helper_add(encoder, &exynos_dsi_encoder_helper_funcs);
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> index b320b3a21ad4..282467121699 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -14,6 +14,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/exynos_drm.h>
>  
> @@ -369,10 +370,6 @@ static const struct drm_encoder_helper_funcs exynos_vidi_encoder_helper_funcs =
>  	.disable = exynos_vidi_disable,
>  };
>  
> -static const struct drm_encoder_funcs exynos_vidi_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  static int vidi_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct vidi_context *ctx = dev_get_drvdata(dev);
> @@ -406,8 +403,7 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
>  		return PTR_ERR(ctx->crtc);
>  	}
>  
> -	drm_encoder_init(drm_dev, encoder, &exynos_vidi_encoder_funcs,
> -			 DRM_MODE_ENCODER_TMDS, NULL);
> +	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
>  
>  	drm_encoder_helper_add(encoder, &exynos_vidi_encoder_helper_funcs);
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 3e5f1a77286d..302ffda5f297 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -38,6 +38,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include "exynos_drm_crtc.h"
>  #include "regs-hdmi.h"
> @@ -1559,10 +1560,6 @@ static const struct drm_encoder_helper_funcs exynos_hdmi_encoder_helper_funcs =
>  	.disable	= hdmi_disable,
>  };
>  
> -static const struct drm_encoder_funcs exynos_hdmi_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>  static void hdmi_audio_shutdown(struct device *dev, void *data)
>  {
>  	struct hdmi_context *hdata = dev_get_drvdata(dev);
> @@ -1851,8 +1848,7 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
>  
>  	hdata->phy_clk.enable = hdmiphy_clk_enable;
>  
> -	drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
> -			 DRM_MODE_ENCODER_TMDS, NULL);
> +	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
>  
>  	drm_encoder_helper_add(encoder, &exynos_hdmi_encoder_helper_funcs);
>  
> -- 
> 2.25.1
