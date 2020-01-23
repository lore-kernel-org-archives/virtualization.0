From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 10/15] drm/repaper: Remove sending of vblank event
Date: Thu, 23 Jan 2020 10:21:18 +0100
Message-ID: <20200123092123.28368-11-tzimmermann@suse.de>
References: <20200123092123.28368-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200123092123.28368-1-tzimmermann@suse.de>
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
Cc: xen-devel@lists.xenproject.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The atomic helpers automatically send out fake VBLANK events if no
vblanking has been initialized. Remove the sending code from the
driver.

v4:
	* separate commit from core vblank changes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/tiny/repaper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 76d179200775..183484595aea 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -33,7 +33,6 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_rect.h>
-#include <drm/drm_vblank.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
@@ -856,18 +855,10 @@ static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
 				struct drm_plane_state *old_state)
 {
 	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_rect rect;
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
 		repaper_fb_dirty(state->fb);
-
-	if (crtc->state->event) {
-		spin_lock_irq(&crtc->dev->event_lock);
-		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-		crtc->state->event = NULL;
-	}
 }
 
 static const struct drm_simple_display_pipe_funcs repaper_pipe_funcs = {
-- 
2.24.1
