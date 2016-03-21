From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 2/2] drm/virtio: send vblank event on plane atomic update
Date: Mon, 21 Mar 2016 16:23:07 -0300
Message-ID: <1458588187-26002-2-git-send-email-gustavo__15353.2361532145$1458767077$gmane$org@padovan.org>
References: <1458588187-26002-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458588187-26002-1-git-send-email-gustavo@padovan.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

virtio_gpu was failing to send vblank events when using the atomic IOCTL
with the DRM_MODE_PAGE_FLIP_EVENT flag set. This patch fixes each and
enables atomic pageflips updates.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 70b44a2..20260ad 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -63,9 +63,11 @@ static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
-	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(plane->crtc);
+	struct drm_crtc *crtc = plane->crtc;
+	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
+	unsigned long flags;
 	uint32_t handle;
 
 	if (plane->state->fb) {
@@ -96,6 +98,11 @@ static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
 				      plane->state->crtc_y,
 				      plane->state->crtc_w,
 				      plane->state->crtc_h);
+
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	if (crtc->state->event)
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 }
 
 
-- 
2.5.0
