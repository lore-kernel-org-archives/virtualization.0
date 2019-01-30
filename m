From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/6] drm/virtio: params struct for
	virtio_gpu_cmd_create_resource()
Date: Wed, 30 Jan 2019 10:43:35 +0100
Message-ID: <20190130094338.14203-4-kraxel__16263.4149355412$1548841440$gmane$org@redhat.com>
References: <20190130094338.14203-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190130094338.14203-1-kraxel@redhat.com>
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

Add format, width and height fields to the virtio_gpu_object_params
struct.  With that in place we can use the parameter struct for
virtio_gpu_cmd_create_resource() calls too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 10 ++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 40928980a2..a40215c10e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -51,6 +51,9 @@
 #define DRIVER_PATCHLEVEL 0
 
 struct virtio_gpu_object_params {
+	uint32_t format;
+	uint32_t width;
+	uint32_t height;
 	unsigned long size;
 	bool pinned;
 };
@@ -248,9 +251,7 @@ int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t format,
-				    uint32_t width,
-				    uint32_t height);
+				    struct virtio_gpu_object_params *params);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index b5f2d94ce5..3a63ffcd4b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -88,7 +88,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	struct virtio_gpu_object_params params = { 0 };
 	int ret;
 	uint32_t pitch;
-	uint32_t format;
 
 	if (args->bpp != 32)
 		return -EINVAL;
@@ -98,16 +97,17 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
 	params.pinned = false,
+	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
+	params.width = args->width;
+	params.height = args->height;
 	params.size = args->size;
 	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
 
-	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_cmd_create_resource(vgdev, obj, format,
-				       args->width, args->height);
+	virtio_gpu_cmd_create_resource(vgdev, obj, &params);
 
 	/* attach the object to the resource */
 	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index fa7b958ca2..84c2216fd4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -303,6 +303,9 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
 	params.pinned = false,
+	params.format = rc->format;
+	params.width = rc->width;
+	params.height = rc->height;
 	params.size = rc->size;
 
 	/* allocate a single page size object */
@@ -315,8 +318,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	obj = &qobj->gem_base;
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
-					       rc->width, rc->height);
+		virtio_gpu_cmd_create_resource(vgdev, qobj, &params);
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6bc2008b0d..363b8b8577 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -376,9 +376,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t format,
-				    uint32_t width,
-				    uint32_t height)
+				    struct virtio_gpu_object_params *params)
 {
 	struct virtio_gpu_resource_create_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -388,9 +386,9 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-	cmd_p->format = cpu_to_le32(format);
-	cmd_p->width = cpu_to_le32(width);
-	cmd_p->height = cpu_to_le32(height);
+	cmd_p->format = cpu_to_le32(params->format);
+	cmd_p->width = cpu_to_le32(params->width);
+	cmd_p->height = cpu_to_le32(params->height);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
-- 
2.9.3
