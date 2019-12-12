From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/3] virtio-gpu: use damage info for display updates.
Date: Thu, 12 Dec 2019 13:53:46 +0100
Message-ID: <20191212125346.8334-4-kraxel__3185.59767199389$1576155259$gmane$org@redhat.com>
References: <20191212125346.8334-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212125346.8334-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

v2: remove shift by src_{x,y}, drm_atomic_helper_damage_merged()
    handles that for us (Chia-I Wu).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 41 +++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 2fb068cd680e..ecc2157ab6f2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -24,6 +24,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 
@@ -103,22 +104,26 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 }
 
 static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
-				      struct virtio_gpu_object *bo,
-				      struct drm_plane_state *state)
+				      struct drm_plane_state *state,
+				      struct drm_rect *rect)
 {
+	struct virtio_gpu_object *bo =
+		gem_to_virtio_gpu_obj(state->fb->obj[0]);
 	struct virtio_gpu_object_array *objs;
+	uint32_t w = rect->x2 - rect->x1;
+	uint32_t h = rect->y2 - rect->y1;
+	uint32_t x = rect->x1;
+	uint32_t y = rect->y1;
+	uint32_t off = x * state->fb->format->cpp[0] +
+		y * state->fb->pitches[0];
 
 	objs = virtio_gpu_array_alloc(1);
 	if (!objs)
 		return;
 	virtio_gpu_array_add_obj(objs, &bo->base.base);
-	virtio_gpu_cmd_transfer_to_host_2d
-		(vgdev, 0,
-		 state->src_w >> 16,
-		 state->src_h >> 16,
-		 state->src_x >> 16,
-		 state->src_y >> 16,
-		 objs, NULL);
+
+	virtio_gpu_cmd_transfer_to_host_2d(vgdev, off, w, h, x, y,
+					   objs, NULL);
 }
 
 static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
@@ -127,8 +132,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
-	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
+	struct drm_rect rect;
 
 	if (plane->state->crtc)
 		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
@@ -146,12 +151,14 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
+	if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+		return;
+
 	virtio_gpu_disable_notify(vgdev);
 
-	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
-	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 	if (bo->dumb)
-		virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
+		virtio_gpu_update_dumb_bo(vgdev, plane->state, &rect);
 
 	if (plane->state->fb != old_state->fb ||
 	    plane->state->src_w != old_state->src_w ||
@@ -175,10 +182,10 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	}
 
 	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
-				      plane->state->src_x >> 16,
-				      plane->state->src_y >> 16,
-				      plane->state->src_w >> 16,
-				      plane->state->src_h >> 16);
+				      rect.x1,
+				      rect.y1,
+				      rect.x2 - rect.x1,
+				      rect.y2 - rect.y1);
 
 	virtio_gpu_enable_notify(vgdev);
 }
-- 
2.18.1
