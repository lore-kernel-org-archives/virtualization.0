From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] virtio-gpu: use src not crtc
Date: Tue, 31 May 2016 14:52:52 +0200
Message-ID: <1464699172-26755-1-git-send-email-kraxel__21879.9254428179$1464699208$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Pick up the correct source rectangle from framebuffer.
Without this multihead setups are not working correctly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index b7778a7..925ca25 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -85,27 +85,32 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		if (bo->dumb) {
 			virtio_gpu_cmd_transfer_to_host_2d
 				(vgdev, handle, 0,
-				 cpu_to_le32(plane->state->crtc_w),
-				 cpu_to_le32(plane->state->crtc_h),
-				 plane->state->crtc_x, plane->state->crtc_y, NULL);
+				 cpu_to_le32(plane->state->src_w >> 16),
+				 cpu_to_le32(plane->state->src_h >> 16),
+				 plane->state->src_x >> 16,
+				 plane->state->src_y >> 16, NULL);
 		}
 	} else {
 		handle = 0;
 	}
 
-	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d\n", handle,
+	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n", handle,
 		  plane->state->crtc_w, plane->state->crtc_h,
-		  plane->state->crtc_x, plane->state->crtc_y);
+		  plane->state->crtc_x, plane->state->crtc_y,
+		  plane->state->src_w >> 16,
+		  plane->state->src_h >> 16,
+		  plane->state->src_x >> 16,
+		  plane->state->src_y >> 16);
 	virtio_gpu_cmd_set_scanout(vgdev, output->index, handle,
-				   plane->state->crtc_w,
-				   plane->state->crtc_h,
-				   plane->state->crtc_x,
-				   plane->state->crtc_y);
+				   plane->state->src_w >> 16,
+				   plane->state->src_h >> 16,
+				   plane->state->src_x >> 16,
+				   plane->state->src_y >> 16);
 	virtio_gpu_cmd_resource_flush(vgdev, handle,
-				      plane->state->crtc_x,
-				      plane->state->crtc_y,
-				      plane->state->crtc_w,
-				      plane->state->crtc_h);
+				      plane->state->src_x >> 16,
+				      plane->state->src_y >> 16,
+				      plane->state->src_w >> 16,
+				      plane->state->src_h >> 16);
 }
 
 static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
-- 
1.8.3.1
