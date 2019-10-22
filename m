From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] drm/virtio: factor out virtio_gpu_update_dumb_bo
Date: Tue, 22 Oct 2019 10:05:46 +0200
Message-ID: <20191022080546.19769-6-kraxel__42512.9813420185$1571731603$gmane$org@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 36 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 0b5a760bc293..bc4bc4475a8c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -102,6 +102,25 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	return ret;
 }
 
+static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
+				      struct virtio_gpu_object *bo,
+				      struct drm_plane_state *state)
+{
+	struct virtio_gpu_object_array *objs;
+
+	objs = virtio_gpu_array_alloc(1);
+	if (!objs)
+		return;
+	virtio_gpu_array_add_obj(objs, &bo->base.base);
+	virtio_gpu_cmd_transfer_to_host_2d
+		(vgdev, 0,
+		 state->src_w >> 16,
+		 state->src_h >> 16,
+		 state->src_x >> 16,
+		 state->src_y >> 16,
+		 objs, NULL);
+}
+
 static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 					    struct drm_plane_state *old_state)
 {
@@ -129,21 +148,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-	if (bo->dumb) {
-		struct virtio_gpu_object_array *objs;
-
-		objs = virtio_gpu_array_alloc(1);
-		if (!objs)
-			return;
-		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_cmd_transfer_to_host_2d
-			(vgdev, 0,
-			 plane->state->src_w >> 16,
-			 plane->state->src_h >> 16,
-			 plane->state->src_x >> 16,
-			 plane->state->src_y >> 16,
-			 objs, NULL);
-	}
+	if (bo->dumb)
+		virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
 
 	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
 		  bo->hw_res_handle,
-- 
2.18.1
