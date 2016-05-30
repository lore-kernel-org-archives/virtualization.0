From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] virtio-gpu: fix output lookup
Date: Mon, 30 May 2016 14:03:26 +0200
Message-ID: <1464609806-22013-1-git-send-email-kraxel__44182.4909918525$1464609825$gmane$org@redhat.com>
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
To: dri-devel@redhat.com
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Needed for multihead setups where we can have disabled
outputs and therefore plane->crtc can be NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 70b44a2..e50674b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -63,11 +63,17 @@ static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
-	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(plane->crtc);
+	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
 	uint32_t handle;
 
+	if (plane->state->crtc)
+		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
+	if (old_state->crtc)
+		output = drm_crtc_to_virtio_gpu_output(old_state->crtc);
+	WARN_ON(!output);
+
 	if (plane->state->fb) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
 		bo = gem_to_virtio_gpu_obj(vgfb->obj);
-- 
1.8.3.1
