From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 06/22] drm/hisilicon/kirin: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:34 +0100
Message-ID: <20200305155950.2705-7-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

The kirin driver uses an empty implementation for its encoder. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index f31068d74b18..08c1ab542c03 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -25,6 +25,7 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "dw_dsi_reg.h"
 
@@ -696,10 +697,6 @@ static const struct drm_encoder_helper_funcs dw_encoder_helper_funcs = {
 	.disable	= dsi_encoder_disable
 };
 
-static const struct drm_encoder_funcs dw_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int dw_drm_encoder_init(struct device *dev,
 			       struct drm_device *drm_dev,
 			       struct drm_encoder *encoder)
@@ -713,8 +710,7 @@ static int dw_drm_encoder_init(struct device *dev,
 	}
 
 	encoder->possible_crtcs = crtc_mask;
-	ret = drm_encoder_init(drm_dev, encoder, &dw_encoder_funcs,
-			       DRM_MODE_ENCODER_DSI, NULL);
+	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
 	if (ret) {
 		DRM_ERROR("failed to init dsi encoder\n");
 		return ret;
-- 
2.25.1
