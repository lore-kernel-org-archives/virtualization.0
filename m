From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/3] drm/virtio: Simplify virtio_gpu_primary_plane_update
	workflow.
Date: Wed, 23 Oct 2019 08:25:38 +0200
Message-ID: <20191023062539.11728-3-kraxel__2282.84966885752$1571811963$gmane$org@redhat.com>
References: <20191023062539.11728-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023062539.11728-1-kraxel@redhat.com>
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

Return early for the no framebuffer (or disabled output) case.
Results in a simpler code flow for the remaining cases.
No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 62 ++++++++++++++------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 390524143139..0b5a760bc293 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -110,7 +110,6 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
-	uint32_t handle;
 
 	if (plane->state->crtc)
 		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
@@ -119,47 +118,52 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	if (WARN_ON(!output))
 		return;
 
-	if (plane->state->fb && output->enabled) {
-		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
-		bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-		handle = bo->hw_res_handle;
-		if (bo->dumb) {
-			struct virtio_gpu_object_array *objs;
+	if (!plane->state->fb || !output->enabled) {
+		DRM_DEBUG("nofb\n");
+		virtio_gpu_cmd_set_scanout(vgdev, output->index, 0,
+					   plane->state->src_w >> 16,
+					   plane->state->src_h >> 16,
+					   0, 0);
+		return;
+	}
+
+	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+	if (bo->dumb) {
+		struct virtio_gpu_object_array *objs;
 
-			objs = virtio_gpu_array_alloc(1);
-			if (!objs)
-				return;
-			virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-			virtio_gpu_cmd_transfer_to_host_2d
-				(vgdev, 0,
-				 plane->state->src_w >> 16,
-				 plane->state->src_h >> 16,
-				 plane->state->src_x >> 16,
-				 plane->state->src_y >> 16,
-				 objs, NULL);
-		}
-	} else {
-		handle = 0;
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs)
+			return;
+		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
+		virtio_gpu_cmd_transfer_to_host_2d
+			(vgdev, 0,
+			 plane->state->src_w >> 16,
+			 plane->state->src_h >> 16,
+			 plane->state->src_x >> 16,
+			 plane->state->src_y >> 16,
+			 objs, NULL);
 	}
 
-	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n", handle,
+	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
+		  bo->hw_res_handle,
 		  plane->state->crtc_w, plane->state->crtc_h,
 		  plane->state->crtc_x, plane->state->crtc_y,
 		  plane->state->src_w >> 16,
 		  plane->state->src_h >> 16,
 		  plane->state->src_x >> 16,
 		  plane->state->src_y >> 16);
-	virtio_gpu_cmd_set_scanout(vgdev, output->index, handle,
+	virtio_gpu_cmd_set_scanout(vgdev, output->index,
+				   bo->hw_res_handle,
 				   plane->state->src_w >> 16,
 				   plane->state->src_h >> 16,
 				   plane->state->src_x >> 16,
 				   plane->state->src_y >> 16);
-	if (handle)
-		virtio_gpu_cmd_resource_flush(vgdev, handle,
-					      plane->state->src_x >> 16,
-					      plane->state->src_y >> 16,
-					      plane->state->src_w >> 16,
-					      plane->state->src_h >> 16);
+	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
+				      plane->state->src_x >> 16,
+				      plane->state->src_y >> 16,
+				      plane->state->src_w >> 16,
+				      plane->state->src_h >> 16);
 }
 
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
-- 
2.18.1
