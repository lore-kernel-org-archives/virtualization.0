From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/3] drm/virtio: drop virtio_gpu_fence_cleanup()
Date: Wed,  5 Dec 2018 11:53:17 +0100
Message-ID: <20181205105317.15138-4-kraxel__47659.6228116707$1544007288$gmane$org@redhat.com>
References: <20181205105317.15138-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181205105317.15138-1-kraxel@redhat.com>
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

Just call drm_fence_put directly instead.
Also set vgfb->fence to NULL after dropping the reference.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 1 -
 drivers/gpu/drm/virtio/virtgpu_fence.c | 8 --------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c | 6 ++++--
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1deb41d42e..551860497f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -351,7 +351,6 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 /* virtio_gpu_fence.c */
 struct virtio_gpu_fence *virtio_gpu_fence_alloc(
 	struct virtio_gpu_device *vgdev);
-void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence);
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 4d6826b278..21bd4c4a32 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -81,14 +81,6 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
 	return fence;
 }
 
-void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
-{
-	if (!fence)
-		return;
-
-	dma_fence_put(&fence->f);
-}
-
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence)
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 161b80fee4..14ce8188c0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -351,7 +351,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
 		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
-			virtio_gpu_fence_cleanup(fence);
+			dma_fence_put(&fence->f);
 			goto fail_backoff;
 		}
 		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 548265b8e8..024c2aa0c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -169,8 +169,10 @@ static void virtio_gpu_cursor_cleanup_fb(struct drm_plane *plane,
 		return;
 
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
-	if (vgfb->fence)
-		virtio_gpu_fence_cleanup(vgfb->fence);
+	if (vgfb->fence) {
+		dma_fence_put(&vgfb->fence->f);
+		vgfb->fence = NULL;
+	}
 }
 
 static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
-- 
2.9.3
