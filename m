From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/4] drm/virtio: move mapping teardown to virtio_gpu_cleanup_object()
Date: Fri,  7 Feb 2020 08:46:37 +0100
Message-ID: <20200207074638.26386-4-kraxel@redhat.com>
References: <20200207074638.26386-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207074638.26386-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING
        FRAMEWORK" <linaro-mm-sig@lists.linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Stop sending DETACH_BACKING commands, that will happening anyway when
releasing resources via UNREF.  Handle guest-side cleanup in
virtio_gpu_cleanup_object(), called when the host finished processing
the UNREF command.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 --
 drivers/gpu/drm/virtio/virtgpu_object.c | 14 ++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 46 -------------------------
 3 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1bc13f6b161b..d37ddd7644f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -281,8 +281,6 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
 			     struct virtio_gpu_fence *fence);
-void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
-			      struct virtio_gpu_object *obj);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
 int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 28a161af7503..bce2b3d843fe 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -23,6 +23,7 @@
  * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
 
 #include "virtgpu_drv.h"
@@ -65,6 +66,17 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 {
 	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
 
+	if (bo->pages) {
+		if (bo->mapped) {
+			dma_unmap_sg(vgdev->vdev->dev.parent,
+				     bo->pages->sgl, bo->mapped,
+				     DMA_TO_DEVICE);
+			bo->mapped = 0;
+		}
+		sg_free_table(bo->pages);
+		bo->pages = NULL;
+		drm_gem_shmem_unpin(&bo->base.base);
+	}
 	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 	drm_gem_shmem_free_object(&bo->base.base);
 }
@@ -74,8 +86,6 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
 	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
 
-	if (bo->pages)
-		virtio_gpu_object_detach(vgdev, bo);
 	if (bo->created) {
 		virtio_gpu_cmd_unref_resource(vgdev, bo);
 		/* completion handler calls virtio_gpu_cleanup_object() */
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 4e22c3914f94..87c439156151 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -545,22 +545,6 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
-static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
-						  uint32_t resource_id,
-						  struct virtio_gpu_fence *fence)
-{
-	struct virtio_gpu_resource_detach_backing *cmd_p;
-	struct virtio_gpu_vbuffer *vbuf;
-
-	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
-	memset(cmd_p, 0, sizeof(*cmd_p));
-
-	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
-
-	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
-}
-
 void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 				uint32_t scanout_id, uint32_t resource_id,
 				uint32_t width, uint32_t height,
@@ -1155,36 +1139,6 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
-void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
-			      struct virtio_gpu_object *obj)
-{
-	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
-
-	if (WARN_ON_ONCE(!obj->pages))
-		return;
-
-	if (use_dma_api && obj->mapped) {
-		struct virtio_gpu_fence *fence = virtio_gpu_fence_alloc(vgdev);
-		/* detach backing and wait for the host process it ... */
-		virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, fence);
-		dma_fence_wait(&fence->f, true);
-		dma_fence_put(&fence->f);
-
-		/* ... then tear down iommu mappings */
-		dma_unmap_sg(vgdev->vdev->dev.parent,
-			     obj->pages->sgl, obj->mapped,
-			     DMA_TO_DEVICE);
-		obj->mapped = 0;
-	} else {
-		virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, NULL);
-	}
-
-	sg_free_table(obj->pages);
-	obj->pages = NULL;
-
-	drm_gem_shmem_unpin(&obj->base.base);
-}
-
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
 			    struct virtio_gpu_output *output)
 {
-- 
2.18.1
