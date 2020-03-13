From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 2/3] drm: drm_simple_encoder_init() => drm_encoder_init()
Date: Fri, 13 Mar 2020 21:17:43 +0100
Message-ID: <20200313201744.19773-3-sam@ravnborg.org>
References: <20200313201744.19773-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200313201744.19773-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Andrzej Pietrasiewicz <andrzej.p-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Boris Brezillon <bbrezillon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Emil Velikov <emil.velikov-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jose Roberto de Souza <jose.souza-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563A2t4k+OOtxA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

A lot of drivers requires only a basic encoder with no need
to extend the functionality.
This was previously implemented in drm_simple_kms_helper.c
but encoders are not necessarily simple despite no
need for a drm_encoder_funcs for adding functionality.

Move the init function to drm_encoder.c to reflect this.
And adjust the name to drm_encoder_init().

Drop include of drm_simple_kms_helper.h in the touched
drivers as it is no logner required.

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Emil Velikov <emil.velikov-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Andrzej Pietrasiewicz <andrzej.p-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: "José Roberto de Souza" <jose.souza-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/gpu/drm/ast/ast_mode.c          |  3 +-
 drivers/gpu/drm/drm_encoder.c           | 37 ++++++++++++++++++++
 drivers/gpu/drm/drm_simple_kms_helper.c | 45 +------------------------
 drivers/gpu/drm/mgag200/mgag200_mode.c  |  7 ++--
 drivers/gpu/drm/qxl/qxl_display.c       |  7 ++--
 include/drm/drm_encoder.h               |  3 ++
 include/drm/drm_simple_kms_helper.h     |  4 ---
 7 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index cdd6c46d6557..4f6ace1afaf0 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -40,7 +40,6 @@
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "ast_drv.h"
 #include "ast_tables.h"
@@ -964,7 +963,7 @@ static int ast_encoder_init(struct drm_device *dev)
 	struct drm_encoder *encoder = &ast->encoder;
 	int ret;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
+	ret = drm_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index a76a5f04ab39..e1e90652094c 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -152,6 +152,43 @@ int drm_encoder_init_funcs(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_encoder_init_funcs);
 
+static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
+/**
+ * drm_simple_init - Initialize a preallocated encoder with basic functionality.
+ * @dev: drm device
+ * @encoder: the encoder to initialize
+ * @encoder_type: user visible type of the encoder
+ *
+ * Initialises a preallocated encoder that has no further functionality.
+ * Settings for possible CRTC and clones are left to their initial values.
+ * The encoder will be cleaned up automatically as part of the mode-setting
+ * cleanup.
+ *
+ * The caller of drm_encoder_init() is responsible for freeing
+ * the encoder's memory after the encoder has been cleaned up. At the
+ * moment this only works reliably if the encoder data structure is
+ * stored in the device structure. Free the encoder's memory as part of
+ * the device release function.
+ *
+ * FIXME: Later improvements to DRM's resource management may allow for
+ *        an automated kfree() of the encoder's memory.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_simple_init(struct drm_device *dev,
+		    struct drm_encoder *encoder,
+		    int encoder_type)
+{
+	return drm_encoder_init_funcs(dev, encoder,
+				      &drm_simple_encoder_funcs_cleanup,
+				      encoder_type, NULL);
+}
+EXPORT_SYMBOL(drm_encoder_init);
+
 /**
  * drm_encoder_cleanup - cleans up an initialised encoder
  * @encoder: encoder to cleanup
diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 24d4433c347b..d70170980839 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -26,51 +26,8 @@
  * entity. Some flexibility for code reuse is provided through a separately
  * allocated &drm_connector object and supporting optional &drm_bridge
  * encoder drivers.
- *
- * Many drivers require only a very simple encoder that fulfills the minimum
- * requirements of the display pipeline and does not add additional
- * functionality. The function drm_simple_encoder_init() provides an
- * implementation of such an encoder.
  */
 
-static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
-	.destroy = drm_encoder_cleanup,
-};
-
-/**
- * drm_simple_encoder_init - Initialize a preallocated encoder with
- *                           basic functionality.
- * @dev: drm device
- * @encoder: the encoder to initialize
- * @encoder_type: user visible type of the encoder
- *
- * Initialises a preallocated encoder that has no further functionality.
- * Settings for possible CRTC and clones are left to their initial values.
- * The encoder will be cleaned up automatically as part of the mode-setting
- * cleanup.
- *
- * The caller of drm_simple_encoder_init() is responsible for freeing
- * the encoder's memory after the encoder has been cleaned up. At the
- * moment this only works reliably if the encoder data structure is
- * stored in the device structure. Free the encoder's memory as part of
- * the device release function.
- *
- * FIXME: Later improvements to DRM's resource management may allow for
- *        an automated kfree() of the encoder's memory.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type)
-{
-	return drm_encoder_init_funcs(dev, encoder,
-				      &drm_simple_encoder_funcs_cleanup,
-				      encoder_type, NULL);
-}
-EXPORT_SYMBOL(drm_simple_encoder_init);
-
 static enum drm_mode_status
 drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
 			       const struct drm_display_mode *mode)
@@ -327,7 +284,7 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 		return ret;
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE);
 	if (ret || !connector)
 		return ret;
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index d90e83959fca..9de654b2dffd 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -15,7 +15,6 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "mgag200_drv.h"
 
@@ -1630,12 +1629,10 @@ int mgag200_modeset_init(struct mga_device *mdev)
 
 	mga_crtc_init(mdev);
 
-	ret = drm_simple_encoder_init(mdev->dev, encoder,
-				      DRM_MODE_ENCODER_DAC);
+	ret = drm_encoder_init(mdev->dev, encoder, DRM_MODE_ENCODER_DAC);
 	if (ret) {
 		drm_err(mdev->dev,
-			"drm_simple_encoder_init() failed, error %d\n",
-			ret);
+			"drm_encoder_init() failed, error %d\n", ret);
 		return ret;
 	}
 	encoder->possible_crtcs = 0x1;
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 09583a08e141..43fb05df950c 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -31,7 +31,6 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "qxl_drv.h"
 #include "qxl_object.h"
@@ -1088,11 +1087,9 @@ static int qdev_output_init(struct drm_device *dev, int num_output)
 	drm_connector_init(dev, &qxl_output->base,
 			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
 
-	ret = drm_simple_encoder_init(dev, &qxl_output->enc,
-				      DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, &qxl_output->enc, DRM_MODE_ENCODER_VIRTUAL);
 	if (ret) {
-		drm_err(dev, "drm_simple_encoder_init() failed, error %d\n",
-			ret);
+		drm_err(dev, "drm_encoder_init() failed, error %d\n", ret);
 		goto err_drm_connector_cleanup;
 	}
 
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 378ab1778be3..8298b696dca8 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -191,6 +191,9 @@ int drm_encoder_init_funcs(struct drm_device *dev,
 			   const struct drm_encoder_funcs *funcs,
 			   int encoder_type, const char *name, ...);
 
+int drm_encoder_init(struct drm_device *dev,
+		     struct drm_encoder *encoder,
+		     int encoder_type);
 /**
  * drm_encoder_index - find the index of a registered encoder
  * @encoder: encoder to find index for
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index a026375464ff..e253ba7bea9d 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -181,8 +181,4 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 			const uint64_t *format_modifiers,
 			struct drm_connector *connector);
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type);
-
 #endif /* __LINUX_DRM_SIMPLE_KMS_HELPER_H */
-- 
2.20.1
