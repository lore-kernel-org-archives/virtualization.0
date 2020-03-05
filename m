From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 03/22] drm/exynos: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:31 +0100
Message-ID: <20200305155950.2705-4-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org, abrodkin@synopsys.com, bbrezillon@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jingoohan1@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org, stefan@agner.ch, alison.wang@nxp.com, patrik.r.jakobsson@gmail.com, xinliang.liu@linaro.org, zourongrong@gmail.com, john.stultz@linaro.org, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, linux@armlinux.org.uk, p.zabel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, paul@crapouillou.net, ck.hu@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

The exynos driver uses empty implementations for its encoders. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/exynos/exynos_dp.c       | 8 ++------
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 8 ++------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 8 ++------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 8 ++------
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 8 ++------
 5 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index d23d3502ca91..a61482af2998 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -25,6 +25,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 #include <drm/exynos_drm.h>
 
 #include "exynos_drm_crtc.h"
@@ -135,10 +136,6 @@ static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
 	.disable = exynos_dp_nop,
 };
 
-static const struct drm_encoder_funcs exynos_dp_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int exynos_dp_dt_parse_panel(struct exynos_dp_device *dp)
 {
 	int ret;
@@ -174,8 +171,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 			return ret;
 	}
 
-	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 43fa0f26c052..7ba5354e7d94 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -14,6 +14,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include <video/of_videomode.h>
 #include <video/videomode.h>
@@ -149,10 +150,6 @@ static const struct drm_encoder_helper_funcs exynos_dpi_encoder_helper_funcs = {
 	.disable = exynos_dpi_disable,
 };
 
-static const struct drm_encoder_funcs exynos_dpi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 enum {
 	FIMD_PORT_IN0,
 	FIMD_PORT_IN1,
@@ -201,8 +198,7 @@ int exynos_dpi_bind(struct drm_device *dev, struct drm_encoder *encoder)
 {
 	int ret;
 
-	drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	drm_encoder_helper_add(encoder, &exynos_dpi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 669d3857502a..2986c93382e0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_drv.h"
@@ -1524,10 +1525,6 @@ static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
 	.disable = exynos_dsi_disable,
 };
 
-static const struct drm_encoder_funcs exynos_dsi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 MODULE_DEVICE_TABLE(of, exynos_dsi_of_match);
 
 static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
@@ -1705,8 +1702,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	struct drm_bridge *in_bridge;
 	int ret;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	drm_encoder_helper_add(encoder, &exynos_dsi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index b320b3a21ad4..282467121699 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -14,6 +14,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/exynos_drm.h>
 
@@ -369,10 +370,6 @@ static const struct drm_encoder_helper_funcs exynos_vidi_encoder_helper_funcs =
 	.disable = exynos_vidi_disable,
 };
 
-static const struct drm_encoder_funcs exynos_vidi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int vidi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct vidi_context *ctx = dev_get_drvdata(dev);
@@ -406,8 +403,7 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(ctx->crtc);
 	}
 
-	drm_encoder_init(drm_dev, encoder, &exynos_vidi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	drm_encoder_helper_add(encoder, &exynos_vidi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 3e5f1a77286d..302ffda5f297 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -38,6 +38,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "exynos_drm_crtc.h"
 #include "regs-hdmi.h"
@@ -1559,10 +1560,6 @@ static const struct drm_encoder_helper_funcs exynos_hdmi_encoder_helper_funcs =
 	.disable	= hdmi_disable,
 };
 
-static const struct drm_encoder_funcs exynos_hdmi_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static void hdmi_audio_shutdown(struct device *dev, void *data)
 {
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
@@ -1851,8 +1848,7 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	hdata->phy_clk.enable = hdmiphy_clk_enable;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
 
 	drm_encoder_helper_add(encoder, &exynos_hdmi_encoder_helper_funcs);
 
-- 
2.25.1
