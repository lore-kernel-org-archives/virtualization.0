From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 15/18] drm/qxl: use qxl_num_crtc directly
Date: Wed, 12 Dec 2018 14:21:06 +0100
Message-ID: <20181212132109.8126-16-kraxel__9154.69770920954$1544620858$gmane$org@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, spice-devel@redhat.com, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

qdev->monitors_config->max_allowed is effectively set by the
qxl.num_heads module parameter, stored in the qxl_num_crtc variable.
Lets get rid of the indirection and use the variable qxl_num_crtc
directly.  The kernel doesn't need to dereference pointers each time it
needs the value, and when reading the code you don't have to trace where
and why qdev->monitors_config->max_allowed is set.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index fc88826b69..6ea5d031d0 100644
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
@@ -350,9 +348,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	if (oldcount != qdev->monitors_config->count)
 		DRM_DEBUG_KMS("active heads %d -> %d (%d total)\n",
 			      oldcount, qdev->monitors_config->count,
-			      qdev->monitors_config->max_allowed);
+			      qxl_num_crtc);
 
 	qdev->monitors_config->heads[i] = head;
+	qdev->monitors_config->max_allowed = qxl_num_crtc;
 	qxl_send_monitors_config(qdev);
 }
 
@@ -1148,9 +1147,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 {
 	int ret;
 	struct drm_gem_object *gobj;
-	int max_allowed = qxl_num_crtc;
 	int monitors_config_size = sizeof(struct qxl_monitors_config) +
-		max_allowed * sizeof(struct qxl_head);
+		qxl_num_crtc * sizeof(struct qxl_head);
 
 	ret = qxl_gem_object_create(qdev, monitors_config_size, 0,
 				    QXL_GEM_DOMAIN_VRAM,
@@ -1172,9 +1170,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
 
 	memset(qdev->monitors_config, 0, monitors_config_size);
-	qdev->monitors_config->max_allowed = max_allowed;
-
-	qdev->dumb_heads = kcalloc(max_allowed, sizeof(qdev->dumb_heads[0]), GFP_KERNEL);
+	qdev->dumb_heads = kcalloc(qxl_num_crtc, sizeof(qdev->dumb_heads[0]),
+				   GFP_KERNEL);
 	return 0;
 }
 
-- 
2.9.3
