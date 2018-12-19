From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 06/10] drm/virtio: params struct for
	virtio_gpu_cmd_create_resource()
Date: Wed, 19 Dec 2018 13:27:04 +0100
Message-ID: <20181219122708.4586-7-kraxel__8905.13146664507$1545222360$gmane$org@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Add format, width and height to the virtio_gpu_object_params struct
and use the struct for virtio_gpu_cmd_create_resource().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 10 ++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 8cff8a3f7c..8c65deadd0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -54,6 +54,9 @@
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev);
 
 struct virtio_gpu_object_params {
+	uint32_t format;
+	uint32_t width;
+	uint32_t height;
 	unsigned long size;
 	bool pinned;
 };
@@ -251,9 +254,7 @@ int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
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
index 384cd80bf3..eea6c6e8db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -90,7 +90,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	};
 	int ret;
 	uint32_t pitch;
-	uint32_t format;
 
 	if (args->bpp != 32)
 		return -EINVAL;
@@ -99,16 +98,17 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
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
index 65b4a54f10..33112c8495 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -304,6 +304,9 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
+	params.format = rc->format;
+	params.width = rc->width;
+	params.height = rc->height;
 	params.size = rc->size;
 
 	/* allocate a single page size object */
@@ -316,8 +319,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
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
