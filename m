From: Gustavo Padovan <gustavo@padovan.org>
Subject: [RFC 3/5] drm/virtio: add in-fences support for explicit
	synchronization
Date: Mon, 12 Dec 2016 18:48:27 -0200
Message-ID: <1481575710-12535-3-git-send-email-gustavo__35240.1135875427$1481575738$gmane$org@padovan.org>
References: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, robdclark@gmail.com, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

When the execbuf call receives an in-fence it will get the dma_fence
related to that fence fd and wait on it before submitting the draw call.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 41 ++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d164b54..ac0b4b0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -29,6 +29,7 @@
 #include "virtgpu_drv.h"
 #include <drm/virtgpu_drm.h>
 #include "ttm/ttm_execbuf_util.h"
+#include <linux/sync_file.h>
 
 static void convert_to_hw_box(struct virtio_gpu_box *dst,
 			      const struct drm_virtgpu_3d_box *src)
@@ -111,6 +112,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct ttm_validate_buffer *buflist = NULL;
 	int i;
 	struct ww_acquire_ctx ticket;
+	struct dma_fence *in_fence = NULL;
+	int in_fence_fd = exbuf->fence_fd;
 	void *buf;
 
 	exbuf->fence_fd = -1;
@@ -118,6 +121,19 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if (vgdev->has_virgl_3d == false)
 		return -ENOSYS;
 
+	/* TODO: if the fence is a fence array we need to check
+	 * the context of every single fence */
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
+		in_fence = sync_file_get_fence(in_fence_fd);
+		if (!in_fence)
+			return -EINVAL;
+
+		if (in_fence->context == vgdev->fence_drv.context) {
+			dma_fence_put(in_fence);
+			return -EINVAL;
+		}
+	}
+
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
 
@@ -126,26 +142,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		buflist = drm_calloc_large(exbuf->num_bo_handles,
 					   sizeof(struct ttm_validate_buffer));
 		if (!bo_handles || !buflist) {
-			drm_free_large(bo_handles);
-			drm_free_large(buflist);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out_in_fence;
 		}
 
 		user_bo_handles = (void __user *)(uintptr_t)exbuf->bo_handles;
 		if (copy_from_user(bo_handles, user_bo_handles,
 				   exbuf->num_bo_handles * sizeof(uint32_t))) {
 			ret = -EFAULT;
-			drm_free_large(bo_handles);
-			drm_free_large(buflist);
-			return ret;
+			goto out_in_fence;
 		}
 
 		for (i = 0; i < exbuf->num_bo_handles; i++) {
 			gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
 			if (!gobj) {
-				drm_free_large(bo_handles);
-				drm_free_large(buflist);
-				return -ENOENT;
+				ret = -ENOENT;
+				goto out_in_fence;
 			}
 
 			qobj = gem_to_virtio_gpu_obj(gobj);
@@ -154,6 +166,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			list_add(&buflist[i].head, &validate_list);
 		}
 		drm_free_large(bo_handles);
+		bo_handles = NULL;
 	}
 
 	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
@@ -173,6 +186,13 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		ret = -ENOMEM;
 		goto out_unresv;
 	}
+
+	if (in_fence) {
+		dma_fence_wait(in_fence, true);
+		dma_fence_put(in_fence);
+		in_fence = NULL;
+	}
+
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, fence);
 
@@ -188,7 +208,10 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	ttm_eu_backoff_reservation(&ticket, &validate_list);
 out_free:
 	virtio_gpu_unref_list(&validate_list);
+out_in_fence:
 	drm_free_large(buflist);
+	drm_free_large(bo_handles);
+	dma_fence_put(in_fence);
 	return ret;
 }
 
-- 
2.5.5
