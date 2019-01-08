From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 09/15] drm/bochs: remove old bochs_crtc_* functions
Date: Tue,  8 Jan 2019 12:25:13 +0100
Message-ID: <20190108112519.27473-10-kraxel__10376.0149133906$1546946637$gmane$org@redhat.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190108112519.27473-1-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Remove the old, now unused crtc callbacks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 81 ---------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f39e291245..85ada2d097 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -20,74 +20,6 @@ MODULE_PARM_DESC(defy, "default y resolution");
 
 /* ---------------------------------------------------------------------- */
 
-static void bochs_crtc_dpms(struct drm_crtc *crtc, int mode)
-{
-	switch (mode) {
-	case DRM_MODE_DPMS_ON:
-	case DRM_MODE_DPMS_STANDBY:
-	case DRM_MODE_DPMS_SUSPEND:
-	case DRM_MODE_DPMS_OFF:
-	default:
-		return;
-	}
-}
-
-static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
-				    struct drm_framebuffer *old_fb)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-	struct bochs_bo *bo;
-	u64 gpu_addr = 0;
-	int ret;
-
-	if (old_fb) {
-		bo = gem_to_bochs_bo(old_fb->obj[0]);
-		ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-		if (ret) {
-			DRM_ERROR("failed to reserve old_fb bo\n");
-		} else {
-			bochs_bo_unpin(bo);
-			ttm_bo_unreserve(&bo->bo);
-		}
-	}
-
-	if (WARN_ON(crtc->primary->fb == NULL))
-		return -EINVAL;
-
-	bo = gem_to_bochs_bo(crtc->primary->fb->obj[0]);
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
-	if (ret) {
-		ttm_bo_unreserve(&bo->bo);
-		return ret;
-	}
-
-	ttm_bo_unreserve(&bo->bo);
-	bochs_hw_setbase(bochs, x, y, gpu_addr);
-	return 0;
-}
-
-static int bochs_crtc_mode_set(struct drm_crtc *crtc,
-			       struct drm_display_mode *mode,
-			       struct drm_display_mode *adjusted_mode,
-			       int x, int y, struct drm_framebuffer *old_fb)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-
-	if (WARN_ON(crtc->primary->fb == NULL))
-		return -EINVAL;
-
-	bochs_hw_setmode(bochs, mode);
-	bochs_hw_setformat(bochs, crtc->primary->fb->format);
-	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
-	return 0;
-}
-
 static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct bochs_device *bochs =
@@ -96,14 +28,6 @@ static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	bochs_hw_setmode(bochs, &crtc->mode);
 }
 
-static void bochs_crtc_prepare(struct drm_crtc *crtc)
-{
-}
-
-static void bochs_crtc_commit(struct drm_crtc *crtc)
-{
-}
-
 static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_crtc_state)
 {
@@ -138,12 +62,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
 };
 
 static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
-	.dpms = bochs_crtc_dpms,
-	.mode_set = bochs_crtc_mode_set,
-	.mode_set_base = bochs_crtc_mode_set_base,
 	.mode_set_nofb = bochs_crtc_mode_set_nofb,
-	.prepare = bochs_crtc_prepare,
-	.commit = bochs_crtc_commit,
 	.atomic_enable = bochs_crtc_atomic_enable,
 	.atomic_flush = bochs_crtc_atomic_flush,
 };
-- 
2.9.3
