From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/cirrus: Let DRM core send VBLANK events
Date: Fri, 10 Jan 2020 12:57:07 +0100
Message-ID: <20200110115707.14080-1-tzimmermann__43404.8193668545$1578657606$gmane$org@suse.de>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@redhat.com, kraxel@redhat.com, daniel@ffwll.ch
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In drm_atomic_helper_fake_vblank() the DRM core sends out VBLANK
events if struct drm_crtc_state.no_vblank is enabled. Replace cirrus'
VBLANK events with the DRM core's functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/cirrus/cirrus.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 248c9f765c45..4a1729aa7e53 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -38,7 +38,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
-#include <drm/drm_vblank.h>
 
 #define DRIVER_NAME "cirrus"
 #define DRIVER_DESC "qemu cirrus vga"
@@ -415,6 +414,8 @@ static void cirrus_pipe_enable(struct drm_simple_display_pipe *pipe,
 {
 	struct cirrus_device *cirrus = pipe->crtc.dev->dev_private;
 
+	crtc_state->no_vblank = true;
+
 	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
 	cirrus_fb_blit_fullscreen(plane_state->fb);
 }
@@ -434,13 +435,6 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
 		cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
-
-	if (crtc->state->event) {
-		spin_lock_irq(&crtc->dev->event_lock);
-		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		crtc->state->event = NULL;
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
 }
 
 static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs = {
-- 
2.24.1
