From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 05/22] drm/gma500: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:33 +0100
Message-ID: <20200305155950.2705-6-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

The gma500 driver uses empty implementations for some of its encoders.
Replace the code with the generic simple encoder. As a side effect, the
patch also removes an indirection in the encoder setup for Medfield.

Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
---
 drivers/gpu/drm/gma500/cdv_intel_crt.c     | 14 +++-----------
 drivers/gpu/drm/gma500/cdv_intel_dp.c      | 16 +++-------------
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c    |  4 ++--
 drivers/gpu/drm/gma500/cdv_intel_lvds.c    | 17 +++--------------
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c     |  7 +++----
 drivers/gpu/drm/gma500/mdfld_output.h      |  1 -
 drivers/gpu/drm/gma500/mdfld_tmd_vid.c     |  6 ------
 drivers/gpu/drm/gma500/mdfld_tpo_vid.c     |  6 ------
 drivers/gpu/drm/gma500/oaktrail_hdmi.c     | 14 ++------------
 drivers/gpu/drm/gma500/oaktrail_lvds.c     |  5 +++--
 drivers/gpu/drm/gma500/psb_intel_drv.h     |  1 -
 drivers/gpu/drm/gma500/psb_intel_lvds.c    | 18 +++---------------
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c |  5 -----
 13 files changed, 22 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index 29c36d63b20e..88535f5aacc5 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -28,6 +28,8 @@
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_simple_kms_helper.h>
+
 #include "cdv_device.h"
 #include "intel_bios.h"
 #include "power.h"
@@ -237,15 +239,6 @@ static const struct drm_connector_helper_funcs
 	.best_encoder = gma_best_encoder,
 };
 
-static void cdv_intel_crt_enc_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs cdv_intel_crt_enc_funcs = {
-	.destroy = cdv_intel_crt_enc_destroy,
-};
-
 void cdv_intel_crt_init(struct drm_device *dev,
 			struct psb_intel_mode_device *mode_dev)
 {
@@ -271,8 +264,7 @@ void cdv_intel_crt_init(struct drm_device *dev,
 		&cdv_intel_crt_connector_funcs, DRM_MODE_CONNECTOR_VGA);
 
 	encoder = &gma_encoder->base;
-	drm_encoder_init(dev, encoder,
-		&cdv_intel_crt_enc_funcs, DRM_MODE_ENCODER_DAC, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 
diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 5772b2dce0d6..13947ec06dbb 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -32,6 +32,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_dp_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "gma_display.h"
 #include "psb_drv.h"
@@ -1908,11 +1909,6 @@ cdv_intel_dp_destroy(struct drm_connector *connector)
 	kfree(connector);
 }
 
-static void cdv_intel_dp_encoder_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
 static const struct drm_encoder_helper_funcs cdv_intel_dp_helper_funcs = {
 	.dpms = cdv_intel_dp_dpms,
 	.mode_fixup = cdv_intel_dp_mode_fixup,
@@ -1935,11 +1931,6 @@ static const struct drm_connector_helper_funcs cdv_intel_dp_connector_helper_fun
 	.best_encoder = gma_best_encoder,
 };
 
-static const struct drm_encoder_funcs cdv_intel_dp_enc_funcs = {
-	.destroy = cdv_intel_dp_encoder_destroy,
-};
-
-
 static void cdv_intel_dp_add_properties(struct drm_connector *connector)
 {
 	cdv_intel_attach_force_audio_property(connector);
@@ -2016,8 +2007,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 	encoder = &gma_encoder->base;
 
 	drm_connector_init(dev, connector, &cdv_intel_dp_connector_funcs, type);
-	drm_encoder_init(dev, encoder, &cdv_intel_dp_enc_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 
@@ -2120,7 +2110,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 		if (ret == 0) {
 			/* if this fails, presume the device is a ghost */
 			DRM_INFO("failed to retrieve link info, disabling eDP\n");
-			cdv_intel_dp_encoder_destroy(encoder);
+			drm_encoder_cleanup(encoder);
 			cdv_intel_dp_destroy(connector);
 			goto err_priv;
 		} else {
diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index 1711a41acc16..0d12c6ffbc40 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -32,6 +32,7 @@
 #include <drm/drm.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "cdv_device.h"
 #include "psb_drv.h"
@@ -311,8 +312,7 @@ void cdv_hdmi_init(struct drm_device *dev,
 			   &cdv_hdmi_connector_funcs,
 			   DRM_MODE_CONNECTOR_DVID);
 
-	drm_encoder_init(dev, encoder, &psb_intel_lvds_enc_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 	gma_encoder->type = INTEL_OUTPUT_HDMI;
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index ea0a5d9a0acc..18de10e9ff9a 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -12,6 +12,8 @@
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_simple_kms_helper.h>
+
 #include "cdv_device.h"
 #include "intel_bios.h"
 #include "power.h"
@@ -499,16 +501,6 @@ static const struct drm_connector_funcs cdv_intel_lvds_connector_funcs = {
 	.destroy = cdv_intel_lvds_destroy,
 };
 
-
-static void cdv_intel_lvds_enc_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs cdv_intel_lvds_enc_funcs = {
-	.destroy = cdv_intel_lvds_enc_destroy,
-};
-
 /*
  * Enumerate the child dev array parsed from VBT to check whether
  * the LVDS is present.
@@ -616,10 +608,7 @@ void cdv_intel_lvds_init(struct drm_device *dev,
 			   &cdv_intel_lvds_connector_funcs,
 			   DRM_MODE_CONNECTOR_LVDS);
 
-	drm_encoder_init(dev, encoder,
-			 &cdv_intel_lvds_enc_funcs,
-			 DRM_MODE_ENCODER_LVDS, NULL);
-
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 	gma_encoder->type = INTEL_OUTPUT_LVDS;
diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
index d4c65f268922..aa5aa293ddb6 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
@@ -27,6 +27,8 @@
 
 #include <linux/delay.h>
 
+#include <drm/drm_simple_kms_helper.h>
+
 #include "mdfld_dsi_dpi.h"
 #include "mdfld_dsi_pkg_sender.h"
 #include "mdfld_output.h"
@@ -993,10 +995,7 @@ struct mdfld_dsi_encoder *mdfld_dsi_dpi_init(struct drm_device *dev,
 	/*create drm encoder object*/
 	connector = &dsi_connector->base.base;
 	encoder = &dpi_output->base.base.base;
-	drm_encoder_init(dev,
-			encoder,
-			p_funcs->encoder_funcs,
-			DRM_MODE_ENCODER_LVDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
 	drm_encoder_helper_add(encoder,
 				p_funcs->encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/gma500/mdfld_output.h b/drivers/gpu/drm/gma500/mdfld_output.h
index ab2b27c0f037..17a944d70add 100644
--- a/drivers/gpu/drm/gma500/mdfld_output.h
+++ b/drivers/gpu/drm/gma500/mdfld_output.h
@@ -51,7 +51,6 @@ struct panel_info {
 };
 
 struct panel_funcs {
-	const struct drm_encoder_funcs *encoder_funcs;
 	const struct drm_encoder_helper_funcs *encoder_helper_funcs;
 	struct drm_display_mode * (*get_config_mode)(struct drm_device *);
 	int (*get_panel_info)(struct drm_device *, int, struct panel_info *);
diff --git a/drivers/gpu/drm/gma500/mdfld_tmd_vid.c b/drivers/gpu/drm/gma500/mdfld_tmd_vid.c
index 49c92debb7b2..25e897b98f86 100644
--- a/drivers/gpu/drm/gma500/mdfld_tmd_vid.c
+++ b/drivers/gpu/drm/gma500/mdfld_tmd_vid.c
@@ -188,13 +188,7 @@ static const struct drm_encoder_helper_funcs
 	.commit = mdfld_dsi_dpi_commit,
 };
 
-/*TPO DPI encoder funcs*/
-static const struct drm_encoder_funcs mdfld_tpo_dpi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 const struct panel_funcs mdfld_tmd_vid_funcs = {
-	.encoder_funcs = &mdfld_tpo_dpi_encoder_funcs,
 	.encoder_helper_funcs = &mdfld_tpo_dpi_encoder_helper_funcs,
 	.get_config_mode = &tmd_vid_get_config_mode,
 	.get_panel_info = tmd_vid_get_panel_info,
diff --git a/drivers/gpu/drm/gma500/mdfld_tpo_vid.c b/drivers/gpu/drm/gma500/mdfld_tpo_vid.c
index a9420bf9a419..11845978fb0a 100644
--- a/drivers/gpu/drm/gma500/mdfld_tpo_vid.c
+++ b/drivers/gpu/drm/gma500/mdfld_tpo_vid.c
@@ -76,13 +76,7 @@ static const struct drm_encoder_helper_funcs
 	.commit = mdfld_dsi_dpi_commit,
 };
 
-/*TPO DPI encoder funcs*/
-static const struct drm_encoder_funcs mdfld_tpo_dpi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 const struct panel_funcs mdfld_tpo_vid_funcs = {
-	.encoder_funcs = &mdfld_tpo_dpi_encoder_funcs,
 	.encoder_helper_funcs = &mdfld_tpo_dpi_encoder_helper_funcs,
 	.get_config_mode = &tpo_vid_get_config_mode,
 	.get_panel_info = tpo_vid_get_panel_info,
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index f4370232767d..b25086f252ae 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 
 #include <drm/drm.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "psb_drv.h"
 #include "psb_intel_drv.h"
@@ -620,15 +621,6 @@ static const struct drm_connector_funcs oaktrail_hdmi_connector_funcs = {
 	.destroy = oaktrail_hdmi_destroy,
 };
 
-static void oaktrail_hdmi_enc_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs oaktrail_hdmi_enc_funcs = {
-	.destroy = oaktrail_hdmi_enc_destroy,
-};
-
 void oaktrail_hdmi_init(struct drm_device *dev,
 					struct psb_intel_mode_device *mode_dev)
 {
@@ -651,9 +643,7 @@ void oaktrail_hdmi_init(struct drm_device *dev,
 			   &oaktrail_hdmi_connector_funcs,
 			   DRM_MODE_CONNECTOR_DVID);
 
-	drm_encoder_init(dev, encoder,
-			 &oaktrail_hdmi_enc_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 582e09597500..2828360153d1 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -13,6 +13,8 @@
 
 #include <asm/intel-mid.h>
 
+#include <drm/drm_simple_kms_helper.h>
+
 #include "intel_bios.h"
 #include "power.h"
 #include "psb_drv.h"
@@ -311,8 +313,7 @@ void oaktrail_lvds_init(struct drm_device *dev,
 			   &psb_intel_lvds_connector_funcs,
 			   DRM_MODE_CONNECTOR_LVDS);
 
-	drm_encoder_init(dev, encoder, &psb_intel_lvds_enc_funcs,
-			 DRM_MODE_ENCODER_LVDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 	gma_encoder->type = INTEL_OUTPUT_LVDS;
diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
index 16c6136f778b..fb601983cef0 100644
--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -252,7 +252,6 @@ extern int psb_intel_lvds_set_property(struct drm_connector *connector,
 					struct drm_property *property,
 					uint64_t value);
 extern void psb_intel_lvds_destroy(struct drm_connector *connector);
-extern const struct drm_encoder_funcs psb_intel_lvds_enc_funcs;
 
 /* intel_gmbus.c */
 extern void gma_intel_i2c_reset(struct drm_device *dev);
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index afaebab7bc17..063c66bb946d 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -11,6 +11,8 @@
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_simple_kms_helper.h>
+
 #include "intel_bios.h"
 #include "power.h"
 #include "psb_drv.h"
@@ -621,18 +623,6 @@ const struct drm_connector_funcs psb_intel_lvds_connector_funcs = {
 	.destroy = psb_intel_lvds_destroy,
 };
 
-
-static void psb_intel_lvds_enc_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-const struct drm_encoder_funcs psb_intel_lvds_enc_funcs = {
-	.destroy = psb_intel_lvds_enc_destroy,
-};
-
-
-
 /**
  * psb_intel_lvds_init - setup LVDS connectors on this device
  * @dev: drm device
@@ -683,9 +673,7 @@ void psb_intel_lvds_init(struct drm_device *dev,
 			   &psb_intel_lvds_connector_funcs,
 			   DRM_MODE_CONNECTOR_LVDS);
 
-	drm_encoder_init(dev, encoder,
-			 &psb_intel_lvds_enc_funcs,
-			 DRM_MODE_ENCODER_LVDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_LVDS);
 
 	gma_connector_attach_encoder(gma_connector, gma_encoder);
 	gma_encoder->type = INTEL_OUTPUT_LVDS;
diff --git a/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c b/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
index 9e8224456ea2..f7e121f4c609 100644
--- a/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
+++ b/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
@@ -765,12 +765,7 @@ static const struct drm_encoder_helper_funcs tc35876x_encoder_helper_funcs = {
 	.commit = mdfld_dsi_dpi_commit,
 };
 
-static const struct drm_encoder_funcs tc35876x_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 const struct panel_funcs mdfld_tc35876x_funcs = {
-	.encoder_funcs = &tc35876x_encoder_funcs,
 	.encoder_helper_funcs = &tc35876x_encoder_helper_funcs,
 	.get_config_mode = tc35876x_get_config_mode,
 	.get_panel_info = tc35876x_get_panel_info,
-- 
2.25.1
