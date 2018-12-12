From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 13/18] drm/qxl: use shadow bo directly
Date: Wed, 12 Dec 2018 14:21:04 +0100
Message-ID: <20181212132109.8126-14-kraxel__20377.7231429287$1544620845$gmane$org@redhat.com>
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

Pass the shadow bo to qxl_io_create_primary() instead of expecting
qxl_io_create_primary to check bo->shadow.  Set is_primary flag on the
shadow bo.  Move the is_primary tracking into qxl_io_create_primary()
and qxl_io_destroy_primary() functions.

That simplifies primary surface tracking and the workflow in
qxl_primary_atomic_update().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c     |  8 +++-----
 drivers/gpu/drm/qxl/qxl_display.c | 33 +++++++++++----------------------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index aed0242e11..fd9725bacb 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -372,6 +372,7 @@ void qxl_io_flush_surfaces(struct qxl_device *qdev)
 void qxl_io_destroy_primary(struct qxl_device *qdev)
 {
 	wait_for_io_cmd(qdev, 0, QXL_IO_DESTROY_PRIMARY_ASYNC);
+	qdev->primary_bo->is_primary = false;
 	qdev->primary_bo = NULL;
 }
 
@@ -388,11 +389,7 @@ void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 	create->width = bo->surf.width;
 	create->height = bo->surf.height;
 	create->stride = bo->surf.stride;
-	if (bo->shadow) {
-		create->mem = qxl_bo_physical_address(qdev, bo->shadow, 0);
-	} else {
-		create->mem = qxl_bo_physical_address(qdev, bo, 0);
-	}
+	create->mem = qxl_bo_physical_address(qdev, bo, 0);
 
 	DRM_DEBUG_DRIVER("mem = %llx, from %p\n", create->mem, bo->kptr);
 
@@ -401,6 +398,7 @@ void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 
 	wait_for_io_cmd(qdev, 0, QXL_IO_CREATE_PRIMARY_ASYNC);
 	qdev->primary_bo = bo;
+	qdev->primary_bo->is_primary = true;
 }
 
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id)
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 828e4f773c..204ae46c62 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -401,13 +401,15 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	struct qxl_device *qdev = fb->dev->dev_private;
 	struct drm_clip_rect norect;
 	struct qxl_bo *qobj;
+	bool is_primary;
 	int inc = 1;
 
 	drm_modeset_lock_all(fb->dev);
 
 	qobj = gem_to_qxl_bo(fb->obj[0]);
 	/* if we aren't primary surface ignore this */
-	if (!qobj->is_primary) {
+	is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
+	if (!is_primary) {
 		drm_modeset_unlock_all(fb->dev);
 		return 0;
 	}
@@ -526,14 +528,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 {
 	struct qxl_device *qdev = plane->dev->dev_private;
 	struct qxl_bo *bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
-	struct qxl_bo *bo_old;
+	struct qxl_bo *bo_old, *primary;
 	struct drm_clip_rect norect = {
 	    .x1 = 0,
 	    .y1 = 0,
 	    .x2 = plane->state->fb->width,
 	    .y2 = plane->state->fb->height
 	};
-	bool same_shadow = false;
 
 	if (old_state->fb) {
 		bo_old = gem_to_qxl_bo(old_state->fb->obj[0]);
@@ -541,26 +542,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		bo_old = NULL;
 	}
 
-	if (bo == bo_old)
-		return;
+	primary = bo->shadow ? bo->shadow : bo;
 
-	if (bo_old && bo_old->shadow && bo->shadow &&
-	    bo_old->shadow == bo->shadow) {
-		same_shadow = true;
-	}
-
-	if (bo_old && bo_old->is_primary) {
-		if (!same_shadow)
+	if (!primary->is_primary) {
+		if (qdev->primary_bo)
 			qxl_io_destroy_primary(qdev);
-		bo_old->is_primary = false;
-	}
-
-	if (!bo->is_primary) {
-		if (!same_shadow) {
-			qxl_io_create_primary(qdev, bo);
-			qxl_primary_apply_cursor(plane);
-		}
-		bo->is_primary = true;
+		qxl_io_create_primary(qdev, primary);
+		qxl_primary_apply_cursor(plane);
 	}
 
 	qxl_draw_dirty_fb(qdev, plane->state->fb, bo, 0, 0, &norect, 1, 1);
@@ -756,6 +744,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 			qxl_bo_create(qdev, user_bo->gem_base.size,
 				      true, true, QXL_GEM_DOMAIN_SURFACE, NULL,
 				      &user_bo->shadow);
+			user_bo->shadow->surf = user_bo->surf;
 		}
 	}
 
@@ -784,7 +773,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
 	user_bo = gem_to_qxl_bo(obj);
 	qxl_bo_unpin(user_bo);
 
-	if (user_bo->shadow && !user_bo->is_primary) {
+	if (user_bo->shadow && !user_bo->shadow->is_primary) {
 		drm_gem_object_put_unlocked(&user_bo->shadow->gem_base);
 		user_bo->shadow = NULL;
 	}
-- 
2.9.3
