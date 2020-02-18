From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/4] drm/mgag200: Use simple encoder
Date: Tue, 18 Feb 2020 09:48:14 +0100
Message-ID: <20200218084815.2137-4-tzimmermann@suse.de>
References: <20200218084815.2137-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200218084815.2137-1-tzimmermann@suse.de>
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

v2:
	* rebase onto new simple-encoder interface

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  7 ---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 61 ++------------------------
 2 files changed, 3 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index aa32aad222c2..9bb9e8e14539 100644
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
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 62a8e9ccb16d..957ea1057b6c 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -15,6 +15,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "mgag200_drv.h"
 
@@ -1449,72 +1450,16 @@ static void mga_crtc_init(struct mga_device *mdev)
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
 static struct drm_encoder *mga_encoder_init(struct drm_device *dev)
 {
 	struct drm_encoder *encoder;
-	struct mga_encoder *mga_encoder;
 
-	mga_encoder = kzalloc(sizeof(struct mga_encoder), GFP_KERNEL);
-	if (!mga_encoder)
+	encoder = drm_simple_encoder_create(dev, DRM_MODE_ENCODER_DAC);
+	if (IS_ERR(encoder))
 		return NULL;
 
-	encoder = &mga_encoder->base;
 	encoder->possible_crtcs = 0x1;
 
-	drm_encoder_init(dev, encoder, &mga_encoder_encoder_funcs,
-			 DRM_MODE_ENCODER_DAC, NULL);
-	drm_encoder_helper_add(encoder, &mga_encoder_helper_funcs);
-
 	return encoder;
 }
 
-- 
2.25.0
