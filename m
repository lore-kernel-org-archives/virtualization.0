From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v7 15/18] drm/virtio: remove virtio_gpu_alloc_object
Date: Fri,  2 Aug 2019 15:12:22 +0200
Message-ID: <20190802131225.17760-16-kraxel__29794.9850720883$1564751662$gmane$org@redhat.com>
References: <20190802131225.17760-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190802131225.17760-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Thin wrapper around virtio_gpu_object_create(),
but calling that directly works equally well.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ----
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 23 ++++-------------------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 +++---
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1d6e4ffee7d1..d4d82679d83a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -229,10 +229,6 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 			       struct drm_file *file);
 void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 				 struct drm_file *file);
-struct virtio_gpu_object*
-virtio_gpu_alloc_object(struct drm_device *dev,
-			struct virtio_gpu_object_params *params,
-			struct virtio_gpu_fence *fence);
 int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 0cba78bcf39c..33cc5ab31356 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -28,35 +28,20 @@
 
 #include "virtgpu_drv.h"
 
-struct virtio_gpu_object*
-virtio_gpu_alloc_object(struct drm_device *dev,
-			struct virtio_gpu_object_params *params,
-			struct virtio_gpu_fence *fence)
-{
-	struct virtio_gpu_device *vgdev = dev->dev_private;
-	struct virtio_gpu_object *obj;
-	int ret;
-
-	ret = virtio_gpu_object_create(vgdev, params, &obj, fence);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return obj;
-}
-
 int virtio_gpu_gem_create(struct drm_file *file,
 			  struct drm_device *dev,
 			  struct virtio_gpu_object_params *params,
 			  struct drm_gem_object **obj_p,
 			  uint32_t *handle_p)
 {
+	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_object *obj;
 	int ret;
 	u32 handle;
 
-	obj = virtio_gpu_alloc_object(dev, params, NULL);
-	if (IS_ERR(obj))
-		return PTR_ERR(obj);
+	ret = virtio_gpu_object_create(vgdev, params, &obj, NULL);
+	if (ret < 0)
+		return ret;
 
 	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
 	if (ret) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 865b3b8400ed..890bc55183cc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -256,10 +256,10 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	fence = virtio_gpu_fence_alloc(vgdev);
 	if (!fence)
 		return -ENOMEM;
-	qobj = virtio_gpu_alloc_object(dev, &params, fence);
+	ret = virtio_gpu_object_create(vgdev, &params, &qobj, fence);
 	dma_fence_put(&fence->f);
-	if (IS_ERR(qobj))
-		return PTR_ERR(qobj);
+	if (ret < 0)
+		return ret;
 	obj = &qobj->base.base;
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
-- 
2.18.1
