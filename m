From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] virtio-gpu: pick up hotspot from framebuffer
Date: Tue, 31 May 2016 12:53:13 +0200
Message-ID: <1464691994-5704-6-git-send-email-kraxel__2988.96793178773$1464692051$gmane$org@redhat.com>
References: <1464691994-5704-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464691994-5704-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 4780354..b7778a7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -153,17 +153,23 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	}
 
 	if (plane->state->fb != old_state->fb) {
-		DRM_DEBUG("update, handle %d, +%d+%d\n", handle,
+		DRM_DEBUG("update, handle %d, pos +%d+%d, hot %d,%d\n", handle,
 			  plane->state->crtc_x,
-			  plane->state->crtc_y);
+			  plane->state->crtc_y,
+			  plane->state->fb ? plane->state->fb->hot_x : 0,
+			  plane->state->fb ? plane->state->fb->hot_y : 0);
 		output->cursor.hdr.type =
 			cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
 		output->cursor.resource_id = cpu_to_le32(handle);
-#if 0
-		/* TODO */
-		output->cursor.hot_x = cpu_to_le32(hot_x);
-		output->cursor.hot_y = cpu_to_le32(hot_y);
-#endif
+		if (plane->state->fb) {
+			output->cursor.hot_x =
+				cpu_to_le32(plane->state->fb->hot_x);
+			output->cursor.hot_y =
+				cpu_to_le32(plane->state->fb->hot_y);
+		} else {
+			output->cursor.hot_x = cpu_to_le32(0);
+			output->cursor.hot_y = cpu_to_le32(0);
+		}
 	} else {
 		DRM_DEBUG("move +%d+%d\n",
 			  plane->state->crtc_x,
-- 
1.8.3.1
