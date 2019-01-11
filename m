From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 07/16] drm/bochs: atomic: use atomic page_flip helper
Date: Fri, 11 Jan 2019 06:37:43 +0100
Message-ID: <20190111053752.4004-8-kraxel__49647.3258747303$1547692771$gmane$org@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, noralf@tronnes.org
List-Id: virtualization@lists.linuxfoundation.org

Conversion to atomic modesetting, step five.
Use atomic page_flip helper for crtc.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 646f897cb2..67c3674609 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -104,27 +104,6 @@ static void bochs_crtc_commit(struct drm_crtc *crtc)
 {
 }
 
-static int bochs_crtc_page_flip(struct drm_crtc *crtc,
-				struct drm_framebuffer *fb,
-				struct drm_pending_vblank_event *event,
-				uint32_t page_flip_flags,
-				struct drm_modeset_acquire_ctx *ctx)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-	struct drm_framebuffer *old_fb = crtc->primary->fb;
-	unsigned long irqflags;
-
-	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
-	bochs_crtc_mode_set_base(crtc, 0, 0, old_fb);
-	if (event) {
-		spin_lock_irqsave(&bochs->dev->event_lock, irqflags);
-		drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irqrestore(&bochs->dev->event_lock, irqflags);
-	}
-	return 0;
-}
-
 static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_crtc_state)
 {
@@ -152,7 +131,7 @@ static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = drm_crtc_cleanup,
-	.page_flip = bochs_crtc_page_flip,
+	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-- 
2.9.3
