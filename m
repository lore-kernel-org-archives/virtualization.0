From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/4] drm/virtio: resource teardown tweaks
Date: Fri,  7 Feb 2020 08:46:36 +0100
Message-ID: <20200207074638.26386-3-kraxel@redhat.com>
References: <20200207074638.26386-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207074638.26386-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add new virtio_gpu_cleanup_object() helper function for object cleanup.
Wire up callback function for resource unref, do cleanup from callback
when we know the host stopped using the resource.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 +++-
 drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++-----
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 29 ++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7e69c06e168e..1bc13f6b161b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -114,6 +114,7 @@ struct virtio_gpu_vbuffer {
 	char *resp_buf;
 	int resp_size;
 	virtio_gpu_resp_cb resp_cb;
+	void *resp_cb_data;
 
 	struct virtio_gpu_object_array *objs;
 	struct list_head list;
@@ -262,7 +263,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
-				   uint32_t resource_id);
+				   struct virtio_gpu_object *bo);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
 					uint32_t width, uint32_t height,
@@ -355,6 +356,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 				    u64 last_seq);
 
 /* virtio_gpu_object */
+void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo);
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 						size_t size);
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 017a9e0fc3bb..28a161af7503 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -61,6 +61,14 @@ static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t
 	}
 }
 
+void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
+{
+	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
+
+	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
+	drm_gem_shmem_free_object(&bo->base.base);
+}
+
 static void virtio_gpu_free_object(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
@@ -68,11 +76,12 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
 
 	if (bo->pages)
 		virtio_gpu_object_detach(vgdev, bo);
-	if (bo->created)
-		virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
-	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
-
-	drm_gem_shmem_free_object(obj);
+	if (bo->created) {
+		virtio_gpu_cmd_unref_resource(vgdev, bo);
+		/* completion handler calls virtio_gpu_cleanup_object() */
+		return;
+	}
+	virtio_gpu_cleanup_object(bo);
 }
 
 static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index df499fb64ac7..4e22c3914f94 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -164,6 +164,16 @@ static void *virtio_gpu_alloc_cmd(struct virtio_gpu_device *vgdev,
 					 NULL);
 }
 
+static void *virtio_gpu_alloc_cmd_cb(struct virtio_gpu_device *vgdev,
+				     struct virtio_gpu_vbuffer **vbuffer_p,
+				     int size,
+				     virtio_gpu_resp_cb cb)
+{
+	return virtio_gpu_alloc_cmd_resp(vgdev, cb, vbuffer_p, size,
+					 sizeof(struct virtio_gpu_ctrl_hdr),
+					 NULL);
+}
+
 static void free_vbuf(struct virtio_gpu_device *vgdev,
 		      struct virtio_gpu_vbuffer *vbuf)
 {
@@ -507,18 +517,31 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 	bo->created = true;
 }
 
+static void virtio_gpu_cmd_unref_cb(struct virtio_gpu_device *vgdev,
+				    struct virtio_gpu_vbuffer *vbuf)
+{
+	struct virtio_gpu_object *bo;
+
+	bo = vbuf->resp_cb_data;
+	vbuf->resp_cb_data = NULL;
+
+	virtio_gpu_cleanup_object(bo);
+}
+
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
-				   uint32_t resource_id)
+				   struct virtio_gpu_object *bo)
 {
 	struct virtio_gpu_resource_unref *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
 
-	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
+	cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
+					virtio_gpu_cmd_unref_cb);
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_UNREF);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 
+	vbuf->resp_cb_data = bo;
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
-- 
2.18.1
