From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 16/22] drm/tidss: Use simple encoder
Date: Thu,  5 Mar 2020 16:59:44 +0100
Message-ID: <20200305155950.2705-17-tzimmermann@suse.de>
References: <20200305155950.2705-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20200305155950.2705-1-tzimmermann@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org, abrodkin@synopsys.com, bbrezillon@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jingoohan1@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org, stefan@agner.ch, alison.wang@nxp.com, patrik.r.jakobsson@gmail.com, xinliang.liu@linaro.org, zourongrong@gmail.com, john.stultz@linaro.org, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, linux@armlinux.org.uk, p.zabel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, paul@crapouillou.net, ck.hu@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

The tidss driver uses an empty implementation for its encoder. Replace
the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 83785b0a66a9..4c0558286f5e 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -8,8 +8,9 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_drv.h"
@@ -59,10 +60,6 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.atomic_check = tidss_encoder_atomic_check,
 };
 
-static const struct drm_encoder_funcs encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 struct drm_encoder *tidss_encoder_create(struct tidss_device *tidss,
 					 u32 encoder_type, u32 possible_crtcs)
 {
@@ -75,8 +72,7 @@ struct drm_encoder *tidss_encoder_create(struct tidss_device *tidss,
 
 	enc->possible_crtcs = possible_crtcs;
 
-	ret = drm_encoder_init(&tidss->ddev, enc, &encoder_funcs,
-			       encoder_type, NULL);
+	ret = drm_simple_encoder_init(&tidss->ddev, enc, encoder_type);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-- 
2.25.1
