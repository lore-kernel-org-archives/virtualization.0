From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 12/22] drm/rockchip: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:40 +0100
Message-ID: <20200305155950.2705-13-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, alison.wang-3arQi8VN3Tc@public.gmane.org, patrik.r.jakobsson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xinliang.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org, ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

The rockchip driver uses empty implementations for its encoders. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  9 +++------
 drivers/gpu/drm/rockchip/cdn-dp-core.c          |  9 +++------
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c |  8 ++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     |  8 ++------
 drivers/gpu/drm/rockchip/inno_hdmi.c            |  8 ++------
 drivers/gpu/drm/rockchip/rk3066_hdmi.c          |  8 ++------
 drivers/gpu/drm/rockchip/rockchip_lvds.c        | 10 +++-------
 drivers/gpu/drm/rockchip/rockchip_rgb.c         |  8 ++------
 8 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index f38f5e113c6b..848522797314 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -26,6 +26,7 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
@@ -258,10 +259,6 @@ static struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
 	.atomic_check = rockchip_dp_drm_encoder_atomic_check,
 };
 
-static struct drm_encoder_funcs rockchip_dp_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
 {
 	struct device *dev = dp->dev;
@@ -309,8 +306,8 @@ static int rockchip_dp_drm_create_encoder(struct rockchip_dp_device *dp)
 							     dev->of_node);
 	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
 
-	ret = drm_encoder_init(drm_dev, encoder, &rockchip_dp_encoder_funcs,
-			       DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_simple_encoder_init(drm_dev, encoder,
+				      DRM_MODE_ENCODER_TMDS);
 	if (ret) {
 		DRM_ERROR("failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index eed594bd38d3..06f85138b51b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -20,6 +20,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
@@ -689,10 +690,6 @@ static const struct drm_encoder_helper_funcs cdn_dp_encoder_helper_funcs = {
 	.atomic_check = cdn_dp_encoder_atomic_check,
 };
 
-static const struct drm_encoder_funcs cdn_dp_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 {
 	struct device *dev = dp->dev;
@@ -1030,8 +1027,8 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 							     dev->of_node);
 	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
 
-	ret = drm_encoder_init(drm_dev, encoder, &cdn_dp_encoder_funcs,
-			       DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_simple_encoder_init(drm_dev, encoder,
+				      DRM_MODE_ENCODER_TMDS);
 	if (ret) {
 		DRM_ERROR("failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 6e1270e45f97..3feff0c45b3f 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -21,6 +21,7 @@
 #include <drm/bridge/dw_mipi_dsi.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
@@ -789,10 +790,6 @@ dw_mipi_dsi_encoder_helper_funcs = {
 	.disable = dw_mipi_dsi_encoder_disable,
 };
 
-static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int rockchip_dsi_drm_create_encoder(struct dw_mipi_dsi_rockchip *dsi,
 					   struct drm_device *drm_dev)
 {
@@ -802,8 +799,7 @@ static int rockchip_dsi_drm_create_encoder(struct dw_mipi_dsi_rockchip *dsi,
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dsi->dev->of_node);
 
-	ret = drm_encoder_init(drm_dev, encoder, &dw_mipi_dsi_encoder_funcs,
-			       DRM_MODE_ENCODER_DSI, NULL);
+	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
 	if (ret) {
 		DRM_ERROR("Failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 7f56d8c3491d..121aa8a63a76 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -14,6 +14,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
@@ -237,10 +238,6 @@ dw_hdmi_rockchip_mode_valid(struct drm_connector *connector,
 	return (valid) ? MODE_OK : MODE_BAD;
 }
 
-static const struct drm_encoder_funcs dw_hdmi_rockchip_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static void dw_hdmi_rockchip_encoder_disable(struct drm_encoder *encoder)
 {
 }
@@ -546,8 +543,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	}
 
 	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
-	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 
 	platform_set_drvdata(pdev, hdmi);
 
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e5864e823020..7afdc54eb3ec 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -19,6 +19,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
@@ -532,10 +533,6 @@ static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.atomic_check = inno_hdmi_encoder_atomic_check,
 };
 
-static struct drm_encoder_funcs inno_hdmi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static enum drm_connector_status
 inno_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -617,8 +614,7 @@ static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
 		return -EPROBE_DEFER;
 
 	drm_encoder_helper_add(encoder, &inno_hdmi_encoder_helper_funcs);
-	drm_encoder_init(drm, encoder, &inno_hdmi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 
 	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
 
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index fe203d38664e..1c546c3a8998 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -6,6 +6,7 @@
 
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
@@ -451,10 +452,6 @@ struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
 	.atomic_check = rk3066_hdmi_encoder_atomic_check,
 };
 
-static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static enum drm_connector_status
 rk3066_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -557,8 +554,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 		return -EPROBE_DEFER;
 
 	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
-	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 
 	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 449a62908d21..63f967902c2d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -16,13 +16,14 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
-
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
@@ -435,10 +436,6 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
 	.atomic_check = rockchip_lvds_encoder_atomic_check,
 };
 
-static const struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int rk3288_lvds_probe(struct platform_device *pdev,
 			     struct rockchip_lvds *lvds)
 {
@@ -607,8 +604,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dev->of_node);
 
-	ret = drm_encoder_init(drm_dev, encoder, &rockchip_lvds_encoder_funcs,
-			       DRM_MODE_ENCODER_LVDS, NULL);
+	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
 	if (ret < 0) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to initialize encoder: %d\n", ret);
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 3e2484985955..6c10caecd0db 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -14,6 +14,7 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
@@ -67,10 +68,6 @@ struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
 	.atomic_check = rockchip_rgb_encoder_atomic_check,
 };
 
-static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 				       struct drm_crtc *crtc,
 				       struct drm_device *drm_dev)
@@ -125,8 +122,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	encoder = &rgb->encoder;
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
-	ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
-			       DRM_MODE_ENCODER_NONE, NULL);
+	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_NONE);
 	if (ret < 0) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to initialize encoder: %d\n", ret);
-- 
2.25.1
