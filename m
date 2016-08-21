From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] virtio-gpu: avoid possible NULL pointer dereference
Date: Sun, 21 Aug 2016 23:06:06 +0200
Message-ID: <1471813566-5324-1-git-send-email-xypron.glpk__23810.4987577119$1472119818$gmane$org@gmx.de>
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
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If output is NULL it is not permissable to dereference it.
So we should leave the respective function in this case.

The inconsistency was indicated by cppcheck.
No actual NULL pointer dereference was observed.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 925ca25..ba28c0f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -76,7 +76,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
 	if (old_state->crtc)
 		output = drm_crtc_to_virtio_gpu_output(old_state->crtc);
-	WARN_ON(!output);
+	if (WARN_ON(!output))
+		return;
 
 	if (plane->state->fb) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
@@ -129,7 +130,8 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
 	if (old_state->crtc)
 		output = drm_crtc_to_virtio_gpu_output(old_state->crtc);
-	WARN_ON(!output);
+	if (WARN_ON(!output))
+		return;
 
 	if (plane->state->fb) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
-- 
2.1.4
