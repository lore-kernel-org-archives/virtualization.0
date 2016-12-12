From: Gustavo Padovan <gustavo@padovan.org>
Subject: [RFC 4/5] drm/virtio: add out-fences support for explicit
	synchronization
Date: Mon, 12 Dec 2016 18:48:28 -0200
Message-ID: <1481575710-12535-4-git-send-email-gustavo__33602.0682276741$1481575752$gmane$org@padovan.org>
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

On the out-fence side we get fence returned by the submitted draw call
and attach it to a sync_file and send the sync_file fd to userspace. On
error -1 is returned to userspace.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 51 ++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index ac0b4b0..f441928 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -103,7 +103,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_fence *fence;
+	struct virtio_gpu_fence *out_fence;
 	struct virtio_gpu_object *qobj;
 	int ret;
 	uint32_t *bo_handles = NULL;
@@ -113,7 +113,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	int i;
 	struct ww_acquire_ctx ticket;
 	struct dma_fence *in_fence = NULL;
+	struct sync_file *sync_file;
 	int in_fence_fd = exbuf->fence_fd;
+	int out_fence_fd = -1;
 	void *buf;
 
 	exbuf->fence_fd = -1;
@@ -134,6 +136,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
+		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
+		if (out_fence_fd < 0) {
+			ret = out_fence_fd;
+			goto out_in_fence;
+		}
+	}
+
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
 
@@ -143,21 +153,21 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 					   sizeof(struct ttm_validate_buffer));
 		if (!bo_handles || !buflist) {
 			ret = -ENOMEM;
-			goto out_in_fence;
+			goto out_unused_fd;
 		}
 
 		user_bo_handles = (void __user *)(uintptr_t)exbuf->bo_handles;
 		if (copy_from_user(bo_handles, user_bo_handles,
 				   exbuf->num_bo_handles * sizeof(uint32_t))) {
 			ret = -EFAULT;
-			goto out_in_fence;
+			goto out_unused_fd;
 		}
 
 		for (i = 0; i < exbuf->num_bo_handles; i++) {
 			gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
 			if (!gobj) {
 				ret = -ENOENT;
-				goto out_in_fence;
+				goto out_unused_fd;
 			}
 
 			qobj = gem_to_virtio_gpu_obj(gobj);
@@ -180,11 +190,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		goto out_unresv;
 	}
 
-	fence = virtio_gpu_fence_alloc(vgdev);
-	if (!fence) {
-		kfree(buf);
+	out_fence = virtio_gpu_fence_alloc(vgdev);
+	if(!out_fence) {
 		ret = -ENOMEM;
-		goto out_unresv;
+		goto out_memdup;
+	}
+
+	if (out_fence_fd >= 0) {
+		sync_file = sync_file_create(dma_fence_get(&out_fence->f));
+		if (!sync_file) {
+			dma_fence_put(&out_fence->f);
+			ret = -ENOMEM;
+			goto out_memdup;
+		}
+
+		exbuf->fence_fd = out_fence_fd;
+		fd_install(out_fence_fd, sync_file->file);
 	}
 
 	if (in_fence) {
@@ -194,23 +215,29 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	}
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, fence);
+			      vfpriv->ctx_id, out_fence);
 
-	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
+	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
 
 	/* fence the command bo */
 	virtio_gpu_unref_list(&validate_list);
 	drm_free_large(buflist);
-	dma_fence_put(&fence->f);
+	dma_fence_put(&out_fence->f);
 	return 0;
 
+out_memdup:
+	kfree(buf);
 out_unresv:
 	ttm_eu_backoff_reservation(&ticket, &validate_list);
 out_free:
 	virtio_gpu_unref_list(&validate_list);
-out_in_fence:
+out_unused_fd:
 	drm_free_large(buflist);
 	drm_free_large(bo_handles);
+
+	if (out_fence_fd >= 0)
+		put_unused_fd(out_fence_fd);
+out_in_fence:
 	dma_fence_put(in_fence);
 	return ret;
 }
-- 
2.5.5
