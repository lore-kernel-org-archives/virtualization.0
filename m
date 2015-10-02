From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 7/7] [wip] virtio-gpu: add page flip support
Date: Fri,  2 Oct 2015 13:58:24 +0200
Message-ID: <1443787104-24243-8-git-send-email-kraxel__12730.5978131064$1443787170$gmane$org@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 49 ++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index c9c1427..f545913 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -125,6 +125,51 @@ static int virtio_gpu_crtc_cursor_move(struct drm_crtc *crtc,
 	return 0;
 }
 
+static int virtio_gpu_page_flip(struct drm_crtc *crtc,
+				struct drm_framebuffer *fb,
+				struct drm_pending_vblank_event *event,
+				uint32_t flags)
+{
+	struct virtio_gpu_device *vgdev = crtc->dev->dev_private;
+	struct virtio_gpu_output *output =
+		container_of(crtc, struct virtio_gpu_output, crtc);
+	struct drm_plane *plane = crtc->primary;
+	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_object *bo;
+	unsigned long irqflags;
+	uint32_t handle;
+
+	plane->fb = fb;
+	vgfb = to_virtio_gpu_framebuffer(plane->fb);
+	bo = gem_to_virtio_gpu_obj(vgfb->obj);
+	handle = bo->hw_res_handle;
+
+	DRM_DEBUG("handle 0x%x%s, crtc %dx%d\n", handle,
+		  bo->dumb ? ", dumb" : "",
+		  crtc->mode.hdisplay, crtc->mode.vdisplay);
+	if (bo->dumb) {
+		virtio_gpu_cmd_transfer_to_host_2d
+			(vgdev, handle, 0,
+			 cpu_to_le32(crtc->mode.hdisplay),
+			 cpu_to_le32(crtc->mode.vdisplay),
+			 0, 0, NULL);
+	}
+	virtio_gpu_cmd_set_scanout(vgdev, output->index, handle,
+				   crtc->mode.hdisplay,
+				   crtc->mode.vdisplay, 0, 0);
+	virtio_gpu_cmd_resource_flush(vgdev, handle, 0, 0,
+				      crtc->mode.hdisplay,
+				      crtc->mode.vdisplay);
+
+	if (event) {
+		spin_lock_irqsave(&crtc->dev->event_lock, irqflags);
+		drm_send_vblank_event(crtc->dev, -1, event);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, irqflags);
+	}
+
+	return 0;
+}
+
 static const struct drm_crtc_funcs virtio_gpu_crtc_funcs = {
 	.cursor_set2            = virtio_gpu_crtc_cursor_set,
 	.cursor_move            = virtio_gpu_crtc_cursor_move,
@@ -132,9 +177,7 @@ static const struct drm_crtc_funcs virtio_gpu_crtc_funcs = {
 	.set_config             = drm_atomic_helper_set_config,
 	.destroy                = drm_crtc_cleanup,
 
-#if 0 /* not (yet) working without vblank support according to docs */
-	.page_flip              = drm_atomic_helper_page_flip,
-#endif
+	.page_flip              = virtio_gpu_page_flip,
 	.reset                  = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
-- 
1.8.3.1
