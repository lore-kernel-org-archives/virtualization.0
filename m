From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/bochs: Let DRM core send VBLANK events
Date: Fri, 10 Jan 2020 13:06:24 +0100
Message-ID: <20200110120624.26864-1-tzimmermann__20363.2427308307$1578658184$gmane$org@suse.de>
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
To: kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In drm_atomic_helper_fake_vblank() the DRM core sends out VBLANK
events if struct drm_crtc_state.no_vblank is enabled. Replace bochs'
VBLANK events with the DRM core's functionality.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 3f0006c2470d..14d78bd656c5 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -7,7 +7,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_vblank.h>
 
 #include "bochs.h"
 
@@ -49,6 +48,8 @@ static void bochs_pipe_enable(struct drm_simple_display_pipe *pipe,
 {
 	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
 
+	crtc_state->no_vblank = true;
+
 	bochs_hw_setmode(bochs, &crtc_state->mode);
 	bochs_plane_update(bochs, plane_state);
 }
@@ -57,16 +58,8 @@ static void bochs_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *old_state)
 {
 	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
-	struct drm_crtc *crtc = &pipe->crtc;
 
 	bochs_plane_update(bochs, pipe->plane.state);
-
-	if (crtc->state->event) {
-		spin_lock_irq(&crtc->dev->event_lock);
-		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		crtc->state->event = NULL;
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
 }
 
 static const struct drm_simple_display_pipe_funcs bochs_pipe_funcs = {
-- 
2.24.1
