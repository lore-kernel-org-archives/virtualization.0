From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/qxl: use qxl_num_crtc directly
Date: Thu,  6 Dec 2018 11:33:52 +0100
Message-ID: <20181206103352.20587-1-kraxel__24015.8601584428$1544092320$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Just use qxl_num_crtc directly everywhere instead of using
qdev->monitors_config->max_allowed.  Drops pointless indirection
and also is less confusing.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ce0b9c40fc..6437369a31 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -80,10 +80,10 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 		DRM_DEBUG_KMS("no client monitors configured\n");
 		return status;
 	}
-	if (num_monitors > qdev->monitors_config->max_allowed) {
+	if (num_monitors > qxl_num_crtc) {
 		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
-			      qdev->monitors_config->max_allowed, num_monitors);
-		num_monitors = qdev->monitors_config->max_allowed;
+			      qxl_num_crtc, num_monitors);
+		num_monitors = qxl_num_crtc;
 	} else {
 		num_monitors = qdev->rom->client_monitors_config.count;
 	}
@@ -96,8 +96,7 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 		return status;
 	}
 	/* we copy max from the client but it isn't used */
-	qdev->client_monitors_config->max_allowed =
-				qdev->monitors_config->max_allowed;
+	qdev->client_monitors_config->max_allowed = qxl_num_crtc;
 	for (i = 0 ; i < qdev->client_monitors_config->count ; ++i) {
 		struct qxl_urect *c_rect =
 			&qdev->rom->client_monitors_config.heads[i];
@@ -204,7 +203,7 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector,
 
 	if (!qdev->monitors_config)
 		return 0;
-	if (h >= qdev->monitors_config->max_allowed)
+	if (h >= qxl_num_crtc)
 		return 0;
 	if (!qdev->client_monitors_config)
 		return 0;
@@ -307,8 +306,7 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		return;
 	}
 
-	if (!qdev->monitors_config ||
-	    qdev->monitors_config->max_allowed <= i)
+	if (!qdev->monitors_config || qxl_num_crtc <= i)
 		return;
 
 	head.id = i;
@@ -348,9 +346,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	if (oldcount != qdev->monitors_config->count)
 		DRM_DEBUG_KMS("active heads %d -> %d (%d total)\n",
 			      oldcount, qdev->monitors_config->count,
-			      qdev->monitors_config->max_allowed);
+			      qxl_num_crtc);
 
 	qdev->monitors_config->heads[i] = head;
+	qdev->monitors_config->max_allowed = qxl_num_crtc;
 	qxl_send_monitors_config(qdev);
 }
 
@@ -1097,9 +1096,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 {
 	int ret;
 	struct drm_gem_object *gobj;
-	int max_allowed = qxl_num_crtc;
 	int monitors_config_size = sizeof(struct qxl_monitors_config) +
-		max_allowed * sizeof(struct qxl_head);
+		qxl_num_crtc * sizeof(struct qxl_head);
 
 	ret = qxl_gem_object_create(qdev, monitors_config_size, 0,
 				    QXL_GEM_DOMAIN_VRAM,
@@ -1121,7 +1119,6 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
 
 	memset(qdev->monitors_config, 0, monitors_config_size);
-	qdev->monitors_config->max_allowed = max_allowed;
 	return 0;
 }
 
-- 
2.9.3
