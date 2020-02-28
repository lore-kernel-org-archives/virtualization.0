From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 3/4] drm/mgag200: Use simple encoder
Date: Fri, 28 Feb 2020 09:18:27 +0100
Message-ID: <20200228081828.18463-4-tzimmermann@suse.de>
References: <20200228081828.18463-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200228081828.18463-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, kraxel@redhat.com, noralf@tronnes.org, sam@ravnborg.org, alexander.deucher@amd.com, emil.velikov@collabora.com
Cc: spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The mgag200 driver uses an empty implementation for its encoder. Replace
the code with the generic simple encoder.

v4:
	* print error message with drm_err()
v3:
	* init pre-allocated encoder with drm_simple_encoder_init()
v2:
	* rebase onto new simple-encoder interface

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  9 +--
 drivers/gpu/drm/mgag200/mgag200_mode.c | 86 ++++----------------------
 2 files changed, 13 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index aa32aad222c2..9691252d6233 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -95,7 +95,6 @@
 #define MATROX_DPMS_CLEARED (-1)
 
 #define to_mga_crtc(x) container_of(x, struct mga_crtc, base)
-#define to_mga_encoder(x) container_of(x, struct mga_encoder, base)
 #define to_mga_connector(x) container_of(x, struct mga_connector, base)
 
 struct mga_crtc {
@@ -110,12 +109,6 @@ struct mga_mode_info {
 	struct mga_crtc *crtc;
 };
 
-struct mga_encoder {
-	struct drm_encoder base;
-	int last_dpms;
-};
-
-
 struct mga_i2c_chan {
 	struct i2c_adapter adapter;
 	struct drm_device *dev;
@@ -185,6 +178,8 @@ struct mga_device {
 
 	/* SE model number stored in reg 0x1e24 */
 	u32 unique_rev_id;
+
+	struct drm_encoder encoder;
 };
 
 static inline enum mga_type
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 62a8e9ccb16d..d90e83959fca 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -15,6 +15,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "mgag200_drv.h"
 
@@ -1449,76 +1450,6 @@ static void mga_crtc_init(struct mga_device *mdev)
 	drm_crtc_helper_add(&mga_crtc->base, &mga_helper_funcs);
 }
 
-/*
- * The encoder comes after the CRTC in the output pipeline, but before
- * the connector. It's responsible for ensuring that the digital
- * stream is appropriately converted into the output format. Setup is
- * very simple in this case - all we have to do is inform qemu of the
- * colour depth in order to ensure that it displays appropriately
- */
-
-/*
- * These functions are analagous to those in the CRTC code, but are intended
- * to handle any encoder-specific limitations
- */
-static void mga_encoder_mode_set(struct drm_encoder *encoder,
-				struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
-{
-
-}
-
-static void mga_encoder_dpms(struct drm_encoder *encoder, int state)
-{
-	return;
-}
-
-static void mga_encoder_prepare(struct drm_encoder *encoder)
-{
-}
-
-static void mga_encoder_commit(struct drm_encoder *encoder)
-{
-}
-
-static void mga_encoder_destroy(struct drm_encoder *encoder)
-{
-	struct mga_encoder *mga_encoder = to_mga_encoder(encoder);
-	drm_encoder_cleanup(encoder);
-	kfree(mga_encoder);
-}
-
-static const struct drm_encoder_helper_funcs mga_encoder_helper_funcs = {
-	.dpms = mga_encoder_dpms,
-	.mode_set = mga_encoder_mode_set,
-	.prepare = mga_encoder_prepare,
-	.commit = mga_encoder_commit,
-};
-
-static const struct drm_encoder_funcs mga_encoder_encoder_funcs = {
-	.destroy = mga_encoder_destroy,
-};
-
-static struct drm_encoder *mga_encoder_init(struct drm_device *dev)
-{
-	struct drm_encoder *encoder;
-	struct mga_encoder *mga_encoder;
-
-	mga_encoder = kzalloc(sizeof(struct mga_encoder), GFP_KERNEL);
-	if (!mga_encoder)
-		return NULL;
-
-	encoder = &mga_encoder->base;
-	encoder->possible_crtcs = 0x1;
-
-	drm_encoder_init(dev, encoder, &mga_encoder_encoder_funcs,
-			 DRM_MODE_ENCODER_DAC, NULL);
-	drm_encoder_helper_add(encoder, &mga_encoder_helper_funcs);
-
-	return encoder;
-}
-
-
 static int mga_vga_get_modes(struct drm_connector *connector)
 {
 	struct mga_connector *mga_connector = to_mga_connector(connector);
@@ -1686,8 +1617,9 @@ static struct drm_connector *mga_vga_init(struct drm_device *dev)
 
 int mgag200_modeset_init(struct mga_device *mdev)
 {
-	struct drm_encoder *encoder;
+	struct drm_encoder *encoder = &mdev->encoder;
 	struct drm_connector *connector;
+	int ret;
 
 	mdev->mode_info.mode_config_initialized = true;
 
@@ -1698,11 +1630,15 @@ int mgag200_modeset_init(struct mga_device *mdev)
 
 	mga_crtc_init(mdev);
 
-	encoder = mga_encoder_init(mdev->dev);
-	if (!encoder) {
-		DRM_ERROR("mga_encoder_init failed\n");
-		return -1;
+	ret = drm_simple_encoder_init(mdev->dev, encoder,
+				      DRM_MODE_ENCODER_DAC);
+	if (ret) {
+		drm_err(mdev->dev,
+			"drm_simple_encoder_init() failed, error %d\n",
+			ret);
+		return ret;
 	}
+	encoder->possible_crtcs = 0x1;
 
 	connector = mga_vga_init(mdev->dev);
 	if (!connector) {
-- 
2.25.0
