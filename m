From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] drm/virtio: skip set_scanout if framebuffer didn't change
Date: Wed, 11 Dec 2019 09:42:14 +0100
Message-ID: <20191211084216.25405-2-kraxel__10221.8579313316$1576053757$gmane$org@redhat.com>
References: <20191211084216.25405-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191211084216.25405-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 31 ++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index bc4bc4475a8c..a0f91658c2bc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -151,20 +151,23 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	if (bo->dumb)
 		virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
 
-	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
-		  bo->hw_res_handle,
-		  plane->state->crtc_w, plane->state->crtc_h,
-		  plane->state->crtc_x, plane->state->crtc_y,
-		  plane->state->src_w >> 16,
-		  plane->state->src_h >> 16,
-		  plane->state->src_x >> 16,
-		  plane->state->src_y >> 16);
-	virtio_gpu_cmd_set_scanout(vgdev, output->index,
-				   bo->hw_res_handle,
-				   plane->state->src_w >> 16,
-				   plane->state->src_h >> 16,
-				   plane->state->src_x >> 16,
-				   plane->state->src_y >> 16);
+	if (plane->state->fb != old_state->fb) {
+		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
+			  bo->hw_res_handle,
+			  plane->state->crtc_w, plane->state->crtc_h,
+			  plane->state->crtc_x, plane->state->crtc_y,
+			  plane->state->src_w >> 16,
+			  plane->state->src_h >> 16,
+			  plane->state->src_x >> 16,
+			  plane->state->src_y >> 16);
+		virtio_gpu_cmd_set_scanout(vgdev, output->index,
+					   bo->hw_res_handle,
+					   plane->state->src_w >> 16,
+					   plane->state->src_h >> 16,
+					   plane->state->src_x >> 16,
+					   plane->state->src_y >> 16);
+	}
+
 	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
 				      plane->state->src_x >> 16,
 				      plane->state->src_y >> 16,
-- 
2.18.1
