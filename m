From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 09/10] drm/virtio: move virtio_gpu_cmd_create_resource call
	into virtio_gpu_object_create
Date: Wed, 19 Dec 2018 13:27:07 +0100
Message-ID: <20181219122708.4586-10-kraxel__21348.1192746714$1545222374$gmane$org@redhat.com>
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

Specifically call virtio_gpu_object_create() before ttm_bo_init().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c    |  3 +--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 10 ++--------
 drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f9959306ae..f50ca81132 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -59,7 +59,9 @@ struct virtio_gpu_object_params {
 	uint32_t height;
 	unsigned long size;
 	bool pinned;
+	bool dumb;
 	/* 3d */
+	bool virgl;
 	uint32_t target;
 	uint32_t bind;
 	uint32_t depth;
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index eea6c6e8db..ca84990382 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -102,20 +102,19 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	params.width = args->width;
 	params.height = args->height;
 	params.size = args->size;
+	params.dumb = true;
 	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
 
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_cmd_create_resource(vgdev, obj, &params);
 
 	/* attach the object to the resource */
 	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
 	if (ret)
 		goto fail;
 
-	obj->dumb = true;
 	args->pitch = pitch;
 	return ret;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 65ac61f86a..e5bd1fed56 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -301,6 +301,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	params.height = rc->height;
 	params.size = rc->size;
 	if (vgdev->has_virgl_3d) {
+		params.virgl = true;
 		params.target = rc->target;
 		params.bind = rc->bind;
 		params.depth = rc->depth;
@@ -318,14 +319,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		return PTR_ERR(qobj);
 	obj = &qobj->gem_base;
 
-	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, &params);
-
-		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
-	} else {
-		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
-		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
-	}
+	ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
 	if (ret) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 62367e3f80..94da9e68d2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -106,9 +106,15 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		kfree(bo);
 		return ret;
 	}
-	bo->dumb = false;
+	bo->dumb = params->dumb;
+
+	if (params->virgl) {
+		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params);
+	} else {
+		virtio_gpu_cmd_create_resource(vgdev, bo, params);
+	}
+
 	virtio_gpu_init_ttm_placement(bo, params->pinned);
-
 	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
 			  ttm_bo_type_device, &bo->placement, 0,
 			  true, acc_size, NULL, NULL,
-- 
2.9.3
