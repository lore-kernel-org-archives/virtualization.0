From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/22] drm/shmobile: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:41 +0100
Message-ID: <20200305155950.2705-14-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org, abrodkin@synopsys.com, bbrezillon@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jingoohan1@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org, stefan@agner.ch, alison.wang@nxp.com, patrik.r.jakobsson@gmail.com, xinliang.liu@linaro.org, zourongrong@gmail.com, john.stultz@linaro.org, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, linux@armlinux.org.uk, p.zabel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, paul@crapouillou.net, ck.hu@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

The shmobile driver uses empty implementations for its encoders. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index 75a752d59ef1..03556dbfcafb 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -17,6 +17,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "shmob_drm_backlight.h"
@@ -558,15 +559,6 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.mode_set = shmob_drm_encoder_mode_set,
 };
 
-static void shmob_drm_encoder_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs encoder_funcs = {
-	.destroy = shmob_drm_encoder_destroy,
-};
-
 int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
 {
 	struct drm_encoder *encoder = &sdev->encoder.encoder;
@@ -576,8 +568,8 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
 
 	encoder->possible_crtcs = 1;
 
-	ret = drm_encoder_init(sdev->ddev, encoder, &encoder_funcs,
-			       DRM_MODE_ENCODER_LVDS, NULL);
+	ret = drm_simple_encoder_init(sdev->ddev, encoder,
+				      DRM_MODE_ENCODER_LVDS);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1
