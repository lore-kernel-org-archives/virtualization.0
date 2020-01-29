From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 04/15] drm/bochs: Remove sending of vblank event
Date: Wed, 29 Jan 2020 13:05:20 +0100
Message-ID: <20200129120531.6891-5-tzimmermann@suse.de>
References: <20200129120531.6891-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200129120531.6891-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, hdegoede@redhat.com, david@lechnology.com, noralf@tronnes.org, sean@poorly.run, oleksandr_andrushchenko@epam.com, sam@ravnborg.org, laurent.pinchart@ideasonboard.com, emil.velikov@collabora.com
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, xen-devel@lists.xenproject.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The atomic helpers automatically send out fake VBLANK events if no
vblanking has been initialized. Remove the sending code from the
driver.

v4:
	* separate commit from core vblank changes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 3f0006c2470d..ff275faee88d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -7,7 +7,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_vblank.h>
 
 #include "bochs.h"
 
@@ -57,16 +56,8 @@ static void bochs_pipe_update(struct drm_simple_display_pipe *pipe,
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
2.25.0
