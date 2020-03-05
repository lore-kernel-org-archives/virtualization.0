From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/22] drm/mediatek: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:38 +0100
Message-ID: <20200305155950.2705-11-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org, abrodkin@synopsys.com, bbrezillon@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jingoohan1@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org, stefan@agner.ch, alison.wang@nxp.com, patrik.r.jakobsson@gmail.com, xinliang.liu@linaro.org, zourongrong@gmail.com, john.stultz@linaro.org, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, linux@armlinux.org.uk, p.zabel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, paul@crapouillou.net, ck.hu@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

The mediatak driver uses empty implementations for its encoders. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++-----------
 drivers/gpu/drm/mediatek/mtk_dsi.c | 14 +++-----------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 14fbe1c09ce9..9c90c58e5acd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -20,6 +20,7 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_of.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "mtk_dpi_regs.h"
 #include "mtk_drm_ddp_comp.h"
@@ -509,15 +510,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	return 0;
 }
 
-static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
-	.destroy = mtk_dpi_encoder_destroy,
-};
-
 static bool mtk_dpi_encoder_mode_fixup(struct drm_encoder *encoder,
 				       const struct drm_display_mode *mode,
 				       struct drm_display_mode *adjusted_mode)
@@ -596,8 +588,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	ret = drm_encoder_init(drm_dev, &dpi->encoder, &mtk_dpi_encoder_funcs,
-			       DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_simple_encoder_init(drm_dev, &dpi->encoder,
+				      DRM_MODE_ENCODER_TMDS);
 	if (ret) {
 		dev_err(dev, "Failed to initialize decoder: %d\n", ret);
 		goto err_unregister;
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 0ede69830a9d..a9a25087112f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -22,6 +22,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "mtk_drm_ddp_comp.h"
 
@@ -787,15 +788,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 	dsi->enabled = false;
 }
 
-static void mtk_dsi_encoder_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs mtk_dsi_encoder_funcs = {
-	.destroy = mtk_dsi_encoder_destroy,
-};
-
 static bool mtk_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
 				       const struct drm_display_mode *mode,
 				       struct drm_display_mode *adjusted_mode)
@@ -888,8 +880,8 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
 {
 	int ret;
 
-	ret = drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_funcs,
-			       DRM_MODE_ENCODER_DSI, NULL);
+	ret = drm_simple_encoder_init(drm, &dsi->encoder,
+				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
 		DRM_ERROR("Failed to encoder init to drm\n");
 		return ret;
-- 
2.25.1
