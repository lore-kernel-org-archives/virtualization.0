From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 6/6] drm/virtio: fix resource id handling
Date: Fri, 19 Oct 2018 08:18:47 +0200
Message-ID: <20181019061847.18958-7-kraxel__27552.8402337388$1539929840$gmane$org@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Move virtio_gpu_resource_id_{get,put} to virtgpu_object.c and make them
static.  Allocate and free the id on creation and destroy, drop all
other calls.  That way objects have a valid handle for the whole
lifetime of the object.

Also fixes ids leaking.  Worst offender are dumb buffers, and I think
some error paths too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  3 ---
 drivers/gpu/drm/virtio/virtgpu_fb.c     |  1 -
 drivers/gpu/drm/virtio/virtgpu_gem.c    |  1 -
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  |  1 -
 drivers/gpu/drm/virtio/virtgpu_object.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 20 --------------------
 6 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index c6b0a938ba..78ad8f58ed 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -260,9 +260,6 @@ int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *qfb,
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-			       uint32_t *resid);
-void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    uint32_t format,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index c22a8246b6..fb1cc8b2f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -231,7 +231,6 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
 	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       mode_cmd.width, mode_cmd.height);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 665d18a49d..f065863939 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -103,7 +103,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
 	virtio_gpu_cmd_create_resource(vgdev, obj, format,
 				       args->width, args->height);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 6179d93167..bc5afa4f90 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -253,7 +253,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(qobj))
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
-	virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
 
 	if (!vgdev->has_virgl_3d) {
 		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6611c487d7..8bd1ebe13b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,6 +25,26 @@
 
 #include "virtgpu_drv.h"
 
+static void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
+				       uint32_t *resid)
+{
+	int handle;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&vgdev->resource_idr_lock);
+	handle = idr_alloc(&vgdev->resource_idr, NULL, 1, 0, GFP_NOWAIT);
+	spin_unlock(&vgdev->resource_idr_lock);
+	idr_preload_end();
+	*resid = handle;
+}
+
+static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
+{
+	spin_lock(&vgdev->resource_idr_lock);
+	idr_remove(&vgdev->resource_idr, id);
+	spin_unlock(&vgdev->resource_idr_lock);
+}
+
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct virtio_gpu_object *bo;
@@ -40,6 +60,7 @@ static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 	if (bo->vmap)
 		virtio_gpu_object_kunmap(bo);
 	drm_gem_object_release(&bo->gem_base);
+	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 	kfree(bo);
 }
 
@@ -81,9 +102,11 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	bo = kzalloc(sizeof(struct virtio_gpu_object), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
+	virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
 	size = roundup(size, PAGE_SIZE);
 	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, size);
 	if (ret != 0) {
+		virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 		kfree(bo);
 		return ret;
 	}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ea3d13793d..d2861da2bb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -38,26 +38,6 @@
 			       + MAX_INLINE_CMD_SIZE		 \
 			       + MAX_INLINE_RESP_SIZE)
 
-void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
-				uint32_t *resid)
-{
-	int handle;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&vgdev->resource_idr_lock);
-	handle = idr_alloc(&vgdev->resource_idr, NULL, 1, 0, GFP_NOWAIT);
-	spin_unlock(&vgdev->resource_idr_lock);
-	idr_preload_end();
-	*resid = handle;
-}
-
-void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
-{
-	spin_lock(&vgdev->resource_idr_lock);
-	idr_remove(&vgdev->resource_idr, id);
-	spin_unlock(&vgdev->resource_idr_lock);
-}
-
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
 {
 	struct drm_device *dev = vq->vdev->priv;
-- 
2.9.3
