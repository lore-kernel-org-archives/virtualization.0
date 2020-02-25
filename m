From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/4] drm/qxl: Use simple encoder
Date: Tue, 25 Feb 2020 14:10:55 +0100
Message-ID: <20200225131055.27550-5-tzimmermann@suse.de>
References: <20200225131055.27550-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200225131055.27550-1-tzimmermann@suse.de>
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

The qxl driver uses an empty implementation for its encoder. Replace
the code with the generic simple encoder.

v2:
	* rebase onto new simple-encoder interface

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ab4f8dd00400..9c0e1add59fb 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -31,6 +31,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "qxl_drv.h"
 #include "qxl_object.h"
@@ -1007,9 +1008,6 @@ static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
 	return &qxl_output->enc;
 }
 
-static const struct drm_encoder_helper_funcs qxl_enc_helper_funcs = {
-};
-
 static const struct drm_connector_helper_funcs qxl_connector_helper_funcs = {
 	.get_modes = qxl_conn_get_modes,
 	.mode_valid = qxl_conn_mode_valid,
@@ -1059,15 +1057,6 @@ static const struct drm_connector_funcs qxl_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static void qxl_enc_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs qxl_enc_funcs = {
-	.destroy = qxl_enc_destroy,
-};
-
 static int qxl_mode_create_hotplug_mode_update_property(struct qxl_device *qdev)
 {
 	if (qdev->hotplug_mode_update_property)
@@ -1098,15 +1087,14 @@ static int qdev_output_init(struct drm_device *dev, int num_output)
 	drm_connector_init(dev, &qxl_output->base,
 			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
 
-	drm_encoder_init(dev, &qxl_output->enc, &qxl_enc_funcs,
-			 DRM_MODE_ENCODER_VIRTUAL, NULL);
+	drm_simple_encoder_init(dev, &qxl_output->enc,
+				DRM_MODE_ENCODER_VIRTUAL);
 
 	/* we get HPD via client monitors config */
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 	encoder->possible_crtcs = 1 << num_output;
 	drm_connector_attach_encoder(&qxl_output->base,
 					  &qxl_output->enc);
-	drm_encoder_helper_add(encoder, &qxl_enc_helper_funcs);
 	drm_connector_helper_add(connector, &qxl_connector_helper_funcs);
 
 	drm_object_attach_property(&connector->base,
-- 
2.25.0
