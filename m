From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/5] virtio-gpu: switch to atomic cursor interfaces
Date: Tue, 31 May 2016 12:53:11 +0200
Message-ID: <1464691994-5704-4-git-send-email-kraxel__44823.497234802$1464692034$gmane$org@redhat.com>
References: <1464691994-5704-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464691994-5704-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 102 ++++--------------------------
 drivers/gpu/drm/virtio/virtgpu_drv.h     |   1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 105 ++++++++++++++++++++++++++++---
 3 files changed, 109 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index c5d33e0..d6f5d1e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -29,8 +29,8 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic_helper.h>
 
-#define XRES_MIN   320
-#define YRES_MIN   200
+#define XRES_MIN    32
+#define YRES_MIN    32
 
 #define XRES_DEF  1024
 #define YRES_DEF   768
@@ -38,86 +38,6 @@
 #define XRES_MAX  8192
 #define YRES_MAX  8192
 
-static void
-virtio_gpu_hide_cursor(struct virtio_gpu_device *vgdev,
-		       struct virtio_gpu_output *output)
-{
-	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
-	output->cursor.resource_id = 0;
-	virtio_gpu_cursor_ping(vgdev, output);
-}
-
-static int virtio_gpu_crtc_cursor_set(struct drm_crtc *crtc,
-				      struct drm_file *file_priv,
-				      uint32_t handle,
-				      uint32_t width,
-				      uint32_t height,
-				      int32_t hot_x, int32_t hot_y)
-{
-	struct virtio_gpu_device *vgdev = crtc->dev->dev_private;
-	struct virtio_gpu_output *output =
-		container_of(crtc, struct virtio_gpu_output, crtc);
-	struct drm_gem_object *gobj = NULL;
-	struct virtio_gpu_object *qobj = NULL;
-	struct virtio_gpu_fence *fence = NULL;
-	int ret = 0;
-
-	if (handle == 0) {
-		virtio_gpu_hide_cursor(vgdev, output);
-		return 0;
-	}
-
-	/* lookup the cursor */
-	gobj = drm_gem_object_lookup(file_priv, handle);
-	if (gobj == NULL)
-		return -ENOENT;
-
-	qobj = gem_to_virtio_gpu_obj(gobj);
-
-	if (!qobj->hw_res_handle) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	virtio_gpu_cmd_transfer_to_host_2d(vgdev, qobj->hw_res_handle, 0,
-					   cpu_to_le32(64),
-					   cpu_to_le32(64),
-					   0, 0, &fence);
-	ret = virtio_gpu_object_reserve(qobj, false);
-	if (!ret) {
-		reservation_object_add_excl_fence(qobj->tbo.resv,
-						  &fence->f);
-		fence_put(&fence->f);
-		virtio_gpu_object_unreserve(qobj);
-		virtio_gpu_object_wait(qobj, false);
-	}
-
-	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
-	output->cursor.resource_id = cpu_to_le32(qobj->hw_res_handle);
-	output->cursor.hot_x = cpu_to_le32(hot_x);
-	output->cursor.hot_y = cpu_to_le32(hot_y);
-	virtio_gpu_cursor_ping(vgdev, output);
-	ret = 0;
-
-out:
-	drm_gem_object_unreference_unlocked(gobj);
-	return ret;
-}
-
-static int virtio_gpu_crtc_cursor_move(struct drm_crtc *crtc,
-				    int x, int y)
-{
-	struct virtio_gpu_device *vgdev = crtc->dev->dev_private;
-	struct virtio_gpu_output *output =
-		container_of(crtc, struct virtio_gpu_output, crtc);
-
-	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_MOVE_CURSOR);
-	output->cursor.pos.x = cpu_to_le32(x);
-	output->cursor.pos.y = cpu_to_le32(y);
-	virtio_gpu_cursor_ping(vgdev, output);
-	return 0;
-}
-
 static int virtio_gpu_page_flip(struct drm_crtc *crtc,
 				struct drm_framebuffer *fb,
 				struct drm_pending_vblank_event *event,
@@ -164,8 +84,6 @@ static int virtio_gpu_page_flip(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_funcs virtio_gpu_crtc_funcs = {
-	.cursor_set2            = virtio_gpu_crtc_cursor_set,
-	.cursor_move            = virtio_gpu_crtc_cursor_move,
 	.set_config             = drm_atomic_helper_set_config,
 	.destroy                = drm_crtc_cleanup,
 
@@ -406,7 +324,7 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	struct drm_connector *connector = &output->conn;
 	struct drm_encoder *encoder = &output->enc;
 	struct drm_crtc *crtc = &output->crtc;
-	struct drm_plane *plane;
+	struct drm_plane *primary, *cursor;
 
 	output->index = index;
 	if (index == 0) {
@@ -415,13 +333,17 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 		output->info.r.height = cpu_to_le32(YRES_DEF);
 	}
 
-	plane = virtio_gpu_plane_init(vgdev, index);
-	if (IS_ERR(plane))
-		return PTR_ERR(plane);
-	drm_crtc_init_with_planes(dev, crtc, plane, NULL,
+	primary = virtio_gpu_plane_init(vgdev, DRM_PLANE_TYPE_PRIMARY, index);
+	if (IS_ERR(primary))
+		return PTR_ERR(primary);
+	cursor = virtio_gpu_plane_init(vgdev, DRM_PLANE_TYPE_CURSOR, index);
+	if (IS_ERR(cursor))
+		return PTR_ERR(cursor);
+	drm_crtc_init_with_planes(dev, crtc, primary, cursor,
 				  &virtio_gpu_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &virtio_gpu_crtc_helper_funcs);
-	plane->crtc = crtc;
+	primary->crtc = crtc;
+	cursor->crtc = crtc;
 
 	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,
 			   DRM_MODE_CONNECTOR_VIRTUAL);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index ecd1c43..acf556a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -336,6 +336,7 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
 
 /* virtio_gpu_plane.c */
 struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
+					enum drm_plane_type type,
 					int index);
 
 /* virtio_gpu_ttm.c */
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index e50674b..4780354 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -38,6 +38,10 @@ static const uint32_t virtio_gpu_formats[] = {
 	DRM_FORMAT_ABGR8888,
 };
 
+static const uint32_t virtio_gpu_cursor_formats[] = {
+	DRM_FORMAT_ARGB8888,
+};
+
 static void virtio_gpu_plane_destroy(struct drm_plane *plane)
 {
 	kfree(plane);
@@ -58,8 +62,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	return 0;
 }
 
-static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
-					   struct drm_plane_state *old_state)
+static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
+					    struct drm_plane_state *old_state)
 {
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
@@ -104,32 +108,115 @@ static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
 				      plane->state->crtc_h);
 }
 
+static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
+					   struct drm_plane_state *old_state)
+{
+	struct drm_device *dev = plane->dev;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_output *output = NULL;
+	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_fence *fence = NULL;
+	struct virtio_gpu_object *bo = NULL;
+	uint32_t handle;
+	int ret = 0;
 
-static const struct drm_plane_helper_funcs virtio_gpu_plane_helper_funcs = {
+	if (plane->state->crtc)
+		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
+	if (old_state->crtc)
+		output = drm_crtc_to_virtio_gpu_output(old_state->crtc);
+	WARN_ON(!output);
+
+	if (plane->state->fb) {
+		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+		bo = gem_to_virtio_gpu_obj(vgfb->obj);
+		handle = bo->hw_res_handle;
+	} else {
+		handle = 0;
+	}
+
+	if (bo && bo->dumb && (plane->state->fb != old_state->fb)) {
+		/* new cursor -- update & wait */
+		virtio_gpu_cmd_transfer_to_host_2d
+			(vgdev, handle, 0,
+			 cpu_to_le32(plane->state->crtc_w),
+			 cpu_to_le32(plane->state->crtc_h),
+			 0, 0, &fence);
+		ret = virtio_gpu_object_reserve(bo, false);
+		if (!ret) {
+			reservation_object_add_excl_fence(bo->tbo.resv,
+							  &fence->f);
+			fence_put(&fence->f);
+			fence = NULL;
+			virtio_gpu_object_unreserve(bo);
+			virtio_gpu_object_wait(bo, false);
+		}
+	}
+
+	if (plane->state->fb != old_state->fb) {
+		DRM_DEBUG("update, handle %d, +%d+%d\n", handle,
+			  plane->state->crtc_x,
+			  plane->state->crtc_y);
+		output->cursor.hdr.type =
+			cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
+		output->cursor.resource_id = cpu_to_le32(handle);
+#if 0
+		/* TODO */
+		output->cursor.hot_x = cpu_to_le32(hot_x);
+		output->cursor.hot_y = cpu_to_le32(hot_y);
+#endif
+	} else {
+		DRM_DEBUG("move +%d+%d\n",
+			  plane->state->crtc_x,
+			  plane->state->crtc_y);
+		output->cursor.hdr.type =
+			cpu_to_le32(VIRTIO_GPU_CMD_MOVE_CURSOR);
+	}
+	output->cursor.pos.x = cpu_to_le32(plane->state->crtc_x);
+	output->cursor.pos.y = cpu_to_le32(plane->state->crtc_y);
+	virtio_gpu_cursor_ping(vgdev, output);
+}
+
+static const struct drm_plane_helper_funcs virtio_gpu_primary_helper_funcs = {
+	.atomic_check		= virtio_gpu_plane_atomic_check,
+	.atomic_update		= virtio_gpu_primary_plane_update,
+};
+
+static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
 	.atomic_check		= virtio_gpu_plane_atomic_check,
-	.atomic_update		= virtio_gpu_plane_atomic_update,
+	.atomic_update		= virtio_gpu_cursor_plane_update,
 };
 
 struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
+					enum drm_plane_type type,
 					int index)
 {
 	struct drm_device *dev = vgdev->ddev;
+	const struct drm_plane_helper_funcs *funcs;
 	struct drm_plane *plane;
-	int ret;
+	const uint32_t *formats;
+	int ret, nformats;
 
 	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
 	if (!plane)
 		return ERR_PTR(-ENOMEM);
 
+	if (type == DRM_PLANE_TYPE_CURSOR) {
+		formats = virtio_gpu_cursor_formats;
+		nformats = ARRAY_SIZE(virtio_gpu_cursor_formats);
+		funcs = &virtio_gpu_cursor_helper_funcs;
+	} else {
+		formats = virtio_gpu_formats;
+		nformats = ARRAY_SIZE(virtio_gpu_formats);
+		funcs = &virtio_gpu_primary_helper_funcs;
+	}
 	ret = drm_universal_plane_init(dev, plane, 1 << index,
 				       &virtio_gpu_plane_funcs,
-				       virtio_gpu_formats,
-				       ARRAY_SIZE(virtio_gpu_formats),
-				       DRM_PLANE_TYPE_PRIMARY, NULL);
+				       formats, nformats,
+				       type, NULL);
 	if (ret)
 		goto err_plane_init;
 
-	drm_plane_helper_add(plane, &virtio_gpu_plane_helper_funcs);
+	drm_plane_helper_add(plane, funcs);
 	return plane;
 
 err_plane_init:
-- 
1.8.3.1
