From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] drm/qxl: add mode/framebuffer check functions
Date: Wed, 16 Jan 2019 09:35:19 +0100
Message-ID: <20190116083521.22673-2-kraxel__38265.9483272166$1547693643$gmane$org@redhat.com>
References: <20190116083521.22673-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190116083521.22673-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Add a helper functions to check video modes.  Also add a helper to check
framebuffer buffer objects, using the former for consistency.  That way
we should not fail in qxl_primary_atomic_check() because video modes
which are too big will not be added to the mode list in the first place.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1f8fddcc34..07a37d52c4 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -191,6 +191,21 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 	}
 }
 
+static int qxl_check_mode(struct qxl_device *qdev,
+			  unsigned int width,
+			  unsigned int height)
+{
+	if (width * height * 4 > qdev->vram_size)
+		return -ENOMEM;
+	return 0;
+}
+
+static int qxl_check_framebuffer(struct qxl_device *qdev,
+				 struct qxl_bo *bo)
+{
+	return qxl_check_mode(qdev, bo->surf.width, bo->surf.height);
+}
+
 static int qxl_add_monitors_config_modes(struct drm_connector *connector,
                                          unsigned *pwidth,
                                          unsigned *pheight)
@@ -466,12 +481,7 @@ static int qxl_primary_atomic_check(struct drm_plane *plane,
 
 	bo = gem_to_qxl_bo(state->fb->obj[0]);
 
-	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
-		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
-		return -EINVAL;
-	}
-
-	return 0;
+	return qxl_check_framebuffer(qdev, bo);
 }
 
 static int qxl_primary_apply_cursor(struct drm_plane *plane)
@@ -941,20 +951,11 @@ static enum drm_mode_status qxl_conn_mode_valid(struct drm_connector *connector,
 {
 	struct drm_device *ddev = connector->dev;
 	struct qxl_device *qdev = ddev->dev_private;
-	int i;
 
-	/* TODO: is this called for user defined modes? (xrandr --add-mode)
-	 * TODO: check that the mode fits in the framebuffer */
+	if (qxl_check_mode(qdev, mode->hdisplay, mode->vdisplay) != 0)
+		return MODE_BAD;
 
-	if (qdev->monitors_config_width == mode->hdisplay &&
-	    qdev->monitors_config_height == mode->vdisplay)
-		return MODE_OK;
-
-	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		if (common_modes[i].w == mode->hdisplay && common_modes[i].h == mode->vdisplay)
-			return MODE_OK;
-	}
-	return MODE_BAD;
+	return MODE_OK;
 }
 
 static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
-- 
2.9.3
