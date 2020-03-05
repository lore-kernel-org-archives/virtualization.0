From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 14/22] drm/sun4i: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:42 +0100
Message-ID: <20200305155950.2705-15-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

The ingenic driver uses empty implementations for its encoders. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 +++---------
 drivers/gpu/drm/sun4i/sun4i_lvds.c     | 12 +++---------
 drivers/gpu/drm/sun4i/sun4i_rgb.c      | 17 +++--------------
 drivers/gpu/drm/sun4i/sun4i_tv.c       | 17 +++--------------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++---------
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  8 ++------
 6 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 68d4644ac2dc..e324d7db7b7d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -22,6 +22,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_backend.h"
 #include "sun4i_crtc.h"
@@ -204,10 +205,6 @@ static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs = {
 	.mode_valid	= sun4i_hdmi_mode_valid,
 };
 
-static const struct drm_encoder_funcs sun4i_hdmi_funcs = {
-	.destroy	= drm_encoder_cleanup,
-};
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -611,11 +608,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 	drm_encoder_helper_add(&hdmi->encoder,
 			       &sun4i_hdmi_helper_funcs);
-	ret = drm_encoder_init(drm,
-			       &hdmi->encoder,
-			       &sun4i_hdmi_funcs,
-			       DRM_MODE_ENCODER_TMDS,
-			       NULL);
+	ret = drm_simple_encoder_init(drm, &hdmi->encoder,
+				      DRM_MODE_ENCODER_TMDS);
 	if (ret) {
 		dev_err(dev, "Couldn't initialise the HDMI encoder\n");
 		goto err_put_ddc_i2c;
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index 26e5c7ceb8ff..ffda3184aa12 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -12,6 +12,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_tcon.h"
@@ -96,10 +97,6 @@ static const struct drm_encoder_helper_funcs sun4i_lvds_enc_helper_funcs = {
 	.enable		= sun4i_lvds_encoder_enable,
 };
 
-static const struct drm_encoder_funcs sun4i_lvds_enc_funcs = {
-	.destroy	= drm_encoder_cleanup,
-};
-
 int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 {
 	struct drm_encoder *encoder;
@@ -121,11 +118,8 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 
 	drm_encoder_helper_add(&lvds->encoder,
 			       &sun4i_lvds_enc_helper_funcs);
-	ret = drm_encoder_init(drm,
-			       &lvds->encoder,
-			       &sun4i_lvds_enc_funcs,
-			       DRM_MODE_ENCODER_LVDS,
-			       NULL);
+	ret = drm_simple_encoder_init(drm, &lvds->encoder,
+				      DRM_MODE_ENCODER_LVDS);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialise the lvds encoder\n");
 		goto err_out;
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 3b23d5be3cf3..5a7d43939ae6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -14,6 +14,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_tcon.h"
@@ -188,15 +189,6 @@ static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
 	.mode_valid	= sun4i_rgb_mode_valid,
 };
 
-static void sun4i_rgb_enc_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static struct drm_encoder_funcs sun4i_rgb_enc_funcs = {
-	.destroy	= sun4i_rgb_enc_destroy,
-};
-
 int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 {
 	struct drm_encoder *encoder;
@@ -218,11 +210,8 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
-	ret = drm_encoder_init(drm,
-			       &rgb->encoder,
-			       &sun4i_rgb_enc_funcs,
-			       DRM_MODE_ENCODER_NONE,
-			       NULL);
+	ret = drm_simple_encoder_init(drm, &rgb->encoder,
+				      DRM_MODE_ENCODER_NONE);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialise the rgb encoder\n");
 		goto err_out;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 39c15282e448..63f4428ac3bf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -19,6 +19,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
@@ -473,15 +474,6 @@ static struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
 	.mode_set	= sun4i_tv_mode_set,
 };
 
-static void sun4i_tv_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static struct drm_encoder_funcs sun4i_tv_funcs = {
-	.destroy	= sun4i_tv_destroy,
-};
-
 static int sun4i_tv_comp_get_modes(struct drm_connector *connector)
 {
 	int i;
@@ -592,11 +584,8 @@ static int sun4i_tv_bind(struct device *dev, struct device *master,
 
 	drm_encoder_helper_add(&tv->encoder,
 			       &sun4i_tv_helper_funcs);
-	ret = drm_encoder_init(drm,
-			       &tv->encoder,
-			       &sun4i_tv_funcs,
-			       DRM_MODE_ENCODER_TVDAC,
-			       NULL);
+	ret = drm_simple_encoder_init(drm, &tv->encoder,
+				      DRM_MODE_ENCODER_TVDAC);
 	if (ret) {
 		dev_err(dev, "Couldn't initialise the TV encoder\n");
 		goto err_disable_clk;
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 059939789730..f6c67dd87a05 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -24,6 +24,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_tcon.h"
@@ -846,10 +847,6 @@ static const struct drm_encoder_helper_funcs sun6i_dsi_enc_helper_funcs = {
 	.enable		= sun6i_dsi_encoder_enable,
 };
 
-static const struct drm_encoder_funcs sun6i_dsi_enc_funcs = {
-	.destroy	= drm_encoder_cleanup,
-};
-
 static u32 sun6i_dsi_dcs_build_pkt_hdr(struct sun6i_dsi *dsi,
 				       const struct mipi_dsi_msg *msg)
 {
@@ -1062,11 +1059,8 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
-	ret = drm_encoder_init(drm,
-			       &dsi->encoder,
-			       &sun6i_dsi_enc_funcs,
-			       DRM_MODE_ENCODER_DSI,
-			       NULL);
+	ret = drm_simple_encoder_init(drm, &dsi->encoder,
+				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
 		dev_err(dsi->dev, "Couldn't initialise the DSI encoder\n");
 		return ret;
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index e8a317d5ba19..972682bb8000 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -10,6 +10,7 @@
 
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_of.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "sun8i_dw_hdmi.h"
 #include "sun8i_tcon_top.h"
@@ -29,10 +30,6 @@ sun8i_dw_hdmi_encoder_helper_funcs = {
 	.mode_set = sun8i_dw_hdmi_encoder_mode_set,
 };
 
-static const struct drm_encoder_funcs sun8i_dw_hdmi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static enum drm_mode_status
 sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *connector,
 			      const struct drm_display_mode *mode)
@@ -220,8 +217,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
-	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 
 	sun8i_hdmi_phy_init(hdmi->phy);
 
-- 
2.25.1
