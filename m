From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 17/22] drm/tilcdc: Use simple encoder
Date: Fri, 6 Mar 2020 18:03:18 +0200
Message-ID: <d4b7313e-3b5e-0659-fb2a-32a969a80081@ti.com>
References: <20200305155950.2705-1-tzimmermann@suse.de>
 <20200305155950.2705-18-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20200305155950.2705-18-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/03/2020 17:59, Thomas Zimmermann wrote:
> The tilcdc driver uses empty implementations for its encoders. Replace
> the code with the generic simple encoder.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>

Acked-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_external.c | 10 +++-------
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c    |  8 ++------
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> index 28b7f703236e..b177525588c1 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> @@ -10,6 +10,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include "tilcdc_drv.h"
>  #include "tilcdc_external.h"
> @@ -83,10 +84,6 @@ int tilcdc_add_component_encoder(struct drm_device *ddev)
>  	return 0;
>  }
>  
> -static const struct drm_encoder_funcs tilcdc_external_encoder_funcs = {
> -	.destroy	= drm_encoder_cleanup,
> -};
> -
>  static
>  int tilcdc_attach_bridge(struct drm_device *ddev, struct drm_bridge *bridge)
>  {
> @@ -131,9 +128,8 @@ int tilcdc_attach_external_device(struct drm_device *ddev)
>  	if (!priv->external_encoder)
>  		return -ENOMEM;
>  
> -	ret = drm_encoder_init(ddev, priv->external_encoder,
> -			       &tilcdc_external_encoder_funcs,
> -			       DRM_MODE_ENCODER_NONE, NULL);
> +	ret = drm_simple_encoder_init(ddev, priv->external_encoder,
> +				      DRM_MODE_ENCODER_NONE);
>  	if (ret) {
>  		dev_err(ddev->dev, "drm_encoder_init() failed %d\n", ret);
>  		return ret;
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> index 5584e656b857..12823d60c4e8 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> @@ -16,6 +16,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include "tilcdc_drv.h"
>  #include "tilcdc_panel.h"
> @@ -74,10 +75,6 @@ static void panel_encoder_mode_set(struct drm_encoder *encoder,
>  	/* nothing needed */
>  }
>  
> -static const struct drm_encoder_funcs panel_encoder_funcs = {
> -		.destroy        = drm_encoder_cleanup,
> -};
> -
>  static const struct drm_encoder_helper_funcs panel_encoder_helper_funcs = {
>  		.dpms           = panel_encoder_dpms,
>  		.prepare        = panel_encoder_prepare,
> @@ -102,8 +99,7 @@ static struct drm_encoder *panel_encoder_create(struct drm_device *dev,
>  	encoder = &panel_encoder->base;
>  	encoder->possible_crtcs = 1;
>  
> -	ret = drm_encoder_init(dev, encoder, &panel_encoder_funcs,
> -			DRM_MODE_ENCODER_LVDS, NULL);
> +	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
>  	if (ret < 0)
>  		goto fail;
>  
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
