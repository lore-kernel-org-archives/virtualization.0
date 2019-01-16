From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] drm/qxl: add qxl_add_mode helper function
Date: Wed, 16 Jan 2019 09:35:20 +0100
Message-ID: <20190116083521.22673-3-kraxel__18590.3713609607$1547692467$gmane$org@redhat.com>
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

Add a helper function to add custom video modes to a connector.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 84 +++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 07a37d52c4..b87f72f59e 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -206,15 +206,36 @@ static int qxl_check_framebuffer(struct qxl_device *qdev,
 	return qxl_check_mode(qdev, bo->surf.width, bo->surf.height);
 }
 
-static int qxl_add_monitors_config_modes(struct drm_connector *connector,
-                                         unsigned *pwidth,
-                                         unsigned *pheight)
+static int qxl_add_mode(struct drm_connector *connector,
+			unsigned int width,
+			unsigned int height,
+			bool preferred)
+{
+	struct drm_device *dev = connector->dev;
+	struct qxl_device *qdev = dev->dev_private;
+	struct drm_display_mode *mode = NULL;
+	int rc;
+
+	rc = qxl_check_mode(qdev, width, height);
+	if (rc != 0)
+		return 0;
+
+	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (preferred)
+		mode->type |= DRM_MODE_TYPE_PREFERRED;
+	mode->hdisplay = width;
+	mode->vdisplay = height;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+	return 1;
+}
+
+static int qxl_add_monitors_config_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 	struct qxl_device *qdev = dev->dev_private;
 	struct qxl_output *output = drm_connector_to_qxl_output(connector);
 	int h = output->index;
-	struct drm_display_mode *mode = NULL;
 	struct qxl_head *head;
 
 	if (!qdev->monitors_config)
@@ -229,19 +250,7 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector,
 	head = &qdev->client_monitors_config->heads[h];
 	DRM_DEBUG_KMS("head %d is %dx%d\n", h, head->width, head->height);
 
-	mode = drm_cvt_mode(dev, head->width, head->height, 60, false, false,
-			    false);
-	mode->type |= DRM_MODE_TYPE_PREFERRED;
-	mode->hdisplay = head->width;
-	mode->vdisplay = head->height;
-	drm_mode_set_name(mode);
-	*pwidth = head->width;
-	*pheight = head->height;
-	drm_mode_probed_add(connector, mode);
-	/* remember the last custom size for mode validation */
-	qdev->monitors_config_width = mode->hdisplay;
-	qdev->monitors_config_height = mode->vdisplay;
-	return 1;
+	return qxl_add_mode(connector, head->width, head->height, true);
 }
 
 static struct mode_size {
@@ -267,22 +276,16 @@ static struct mode_size {
 	{1920, 1200}
 };
 
-static int qxl_add_common_modes(struct drm_connector *connector,
-                                unsigned int pwidth,
-                                unsigned int pheight)
+static int qxl_add_common_modes(struct drm_connector *connector)
 {
-	struct drm_device *dev = connector->dev;
-	struct drm_display_mode *mode = NULL;
-	int i;
+	int i, ret = 0;
 
-	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h,
-				    60, false, false, false);
-		if (common_modes[i].w == pwidth && common_modes[i].h == pheight)
-			mode->type |= DRM_MODE_TYPE_PREFERRED;
-		drm_mode_probed_add(connector, mode);
-	}
-	return i - 1;
+	for (i = 0; i < ARRAY_SIZE(common_modes); i++)
+		ret += qxl_add_mode(connector,
+				    common_modes[i].w,
+				    common_modes[i].h,
+				    false);
+	return ret;
 }
 
 static void qxl_send_monitors_config(struct qxl_device *qdev)
@@ -935,14 +938,25 @@ static int qdev_crtc_init(struct drm_device *dev, int crtc_id)
 
 static int qxl_conn_get_modes(struct drm_connector *connector)
 {
+	struct drm_device *dev = connector->dev;
+	struct qxl_device *qdev = dev->dev_private;
+	struct qxl_output *output = drm_connector_to_qxl_output(connector);
 	unsigned int pwidth = 1024;
 	unsigned int pheight = 768;
 	int ret = 0;
 
-	ret = qxl_add_monitors_config_modes(connector, &pwidth, &pheight);
-	if (ret < 0)
-		return ret;
-	ret += qxl_add_common_modes(connector, pwidth, pheight);
+	if (qdev->client_monitors_config) {
+		struct qxl_head *head;
+		head = &qdev->client_monitors_config->heads[output->index];
+		if (head->width)
+			pwidth = head->width;
+		if (head->height)
+			pheight = head->height;
+	}
+
+	ret += qxl_add_common_modes(connector);
+	ret += qxl_add_monitors_config_modes(connector);
+	drm_set_preferred_mode(connector, pwidth, pheight);
 	return ret;
 }
 
-- 
2.9.3
