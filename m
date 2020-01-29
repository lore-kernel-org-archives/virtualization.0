From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 09/15] drm/qxl: Remove sending of vblank event
Date: Wed, 29 Jan 2020 13:05:25 +0100
Message-ID: <20200129120531.6891-10-tzimmermann@suse.de>
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
 drivers/gpu/drm/qxl/qxl_display.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 16d73b22f3f5..ab4f8dd00400 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -31,7 +31,6 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_vblank.h>
 
 #include "qxl_drv.h"
 #include "qxl_object.h"
@@ -372,19 +371,6 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
-	struct drm_device *dev = crtc->dev;
-	struct drm_pending_vblank_event *event;
-	unsigned long flags;
-
-	if (crtc->state && crtc->state->event) {
-		event = crtc->state->event;
-		crtc->state->event = NULL;
-
-		spin_lock_irqsave(&dev->event_lock, flags);
-		drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irqrestore(&dev->event_lock, flags);
-	}
-
 	qxl_crtc_update_monitors_config(crtc, "flush");
 }
 
-- 
2.25.0
