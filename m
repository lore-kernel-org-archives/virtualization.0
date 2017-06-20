From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 01/11] drm/fb-helper: do a generic fb_setcmap helper in terms
	of crtc .gamma_set
Date: Tue, 20 Jun 2017 21:25:25 +0200
Message-ID: <1497986735-14418-2-git-send-email-peda__1004.63577914542$1509078059$gmane$org@axentia.se>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497986735-14418-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Yannick Fertre <yannick.fertre@st.com>, Sean Paul <seanpaul@chromium.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
totally obsolete.

I think the gamma_store can end up invalid on error. But the way I read
it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
this pesky legacy fbdev stuff be any better?

drm_fb_helper_save_lut_atomic justs saves the gamma lut for later. However,
it saves it to the gamma_store which should already be up to date with what
.gamma_get would return and is thus a nop. So, zap it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_fb_helper.c | 131 ++++++++++++----------------------------
 1 file changed, 40 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 574af01..cc2d55d 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -229,22 +229,6 @@ int drm_fb_helper_remove_one_connector(struct drm_fb_helper *fb_helper,
 }
 EXPORT_SYMBOL(drm_fb_helper_remove_one_connector);
 
-static void drm_fb_helper_save_lut_atomic(struct drm_crtc *crtc, struct drm_fb_helper *helper)
-{
-	uint16_t *r_base, *g_base, *b_base;
-	int i;
-
-	if (helper->funcs->gamma_get == NULL)
-		return;
-
-	r_base = crtc->gamma_store;
-	g_base = r_base + crtc->gamma_size;
-	b_base = g_base + crtc->gamma_size;
-
-	for (i = 0; i < crtc->gamma_size; i++)
-		helper->funcs->gamma_get(crtc, &r_base[i], &g_base[i], &b_base[i], i);
-}
-
 static void drm_fb_helper_restore_lut_atomic(struct drm_crtc *crtc)
 {
 	uint16_t *r_base, *g_base, *b_base;
@@ -285,7 +269,6 @@ int drm_fb_helper_debug_enter(struct fb_info *info)
 			if (drm_drv_uses_atomic_modeset(mode_set->crtc->dev))
 				continue;
 
-			drm_fb_helper_save_lut_atomic(mode_set->crtc, helper);
 			funcs->mode_set_base_atomic(mode_set->crtc,
 						    mode_set->fb,
 						    mode_set->x,
@@ -1167,50 +1150,6 @@ void drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper,
 }
 EXPORT_SYMBOL(drm_fb_helper_set_suspend_unlocked);
 
-static int setcolreg(struct drm_crtc *crtc, u16 red, u16 green,
-		     u16 blue, u16 regno, struct fb_info *info)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-	struct drm_framebuffer *fb = fb_helper->fb;
-
-	if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
-		u32 *palette;
-		u32 value;
-		/* place color in psuedopalette */
-		if (regno > 16)
-			return -EINVAL;
-		palette = (u32 *)info->pseudo_palette;
-		red >>= (16 - info->var.red.length);
-		green >>= (16 - info->var.green.length);
-		blue >>= (16 - info->var.blue.length);
-		value = (red << info->var.red.offset) |
-			(green << info->var.green.offset) |
-			(blue << info->var.blue.offset);
-		if (info->var.transp.length > 0) {
-			u32 mask = (1 << info->var.transp.length) - 1;
-
-			mask <<= info->var.transp.offset;
-			value |= mask;
-		}
-		palette[regno] = value;
-		return 0;
-	}
-
-	/*
-	 * The driver really shouldn't advertise pseudo/directcolor
-	 * visuals if it can't deal with the palette.
-	 */
-	if (WARN_ON(!fb_helper->funcs->gamma_set ||
-		    !fb_helper->funcs->gamma_get))
-		return -EINVAL;
-
-	WARN_ON(fb->format->cpp[0] != 1);
-
-	fb_helper->funcs->gamma_set(crtc, red, green, blue, regno);
-
-	return 0;
-}
-
 /**
  * drm_fb_helper_setcmap - implementation for &fb_ops.fb_setcmap
  * @cmap: cmap to set
@@ -1220,51 +1159,61 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_device *dev = fb_helper->dev;
-	const struct drm_crtc_helper_funcs *crtc_funcs;
-	u16 *red, *green, *blue, *transp;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_crtc *crtc;
-	int i, j, rc = 0;
-	int start;
+	u16 *r, *g, *b;
+	int i, ret;
 
 	if (oops_in_progress)
 		return -EBUSY;
 
-	drm_modeset_lock_all(dev);
+	if (cmap->start + cmap->len < cmap->start)
+		return -EINVAL;
+
+	drm_modeset_acquire_init(&ctx, 0);
+retry:
+	ret = drm_modeset_lock_all_ctx(dev, &ctx);
+	if (ret)
+		goto out;
 	if (!drm_fb_helper_is_bound(fb_helper)) {
-		drm_modeset_unlock_all(dev);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
 	for (i = 0; i < fb_helper->crtc_count; i++) {
 		crtc = fb_helper->crtc_info[i].mode_set.crtc;
-		crtc_funcs = crtc->helper_private;
-
-		red = cmap->red;
-		green = cmap->green;
-		blue = cmap->blue;
-		transp = cmap->transp;
-		start = cmap->start;
+		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-		for (j = 0; j < cmap->len; j++) {
-			u16 hred, hgreen, hblue, htransp = 0xffff;
+		if (cmap->start + cmap->len > crtc->gamma_size) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-			hred = *red++;
-			hgreen = *green++;
-			hblue = *blue++;
+		r = crtc->gamma_store;
+		g = r + crtc->gamma_size;
+		b = g + crtc->gamma_size;
 
-			if (transp)
-				htransp = *transp++;
+		memcpy(r + cmap->start, cmap->red, cmap->len * sizeof(u16));
+		memcpy(g + cmap->start, cmap->green, cmap->len * sizeof(u16));
+		memcpy(b + cmap->start, cmap->blue, cmap->len * sizeof(u16));
 
-			rc = setcolreg(crtc, hred, hgreen, hblue, start++, info);
-			if (rc)
-				goto out;
-		}
-		if (crtc_funcs->load_lut)
-			crtc_funcs->load_lut(crtc);
+		ret = crtc->funcs->gamma_set(crtc, r, g, b,
+					     crtc->gamma_size, &ctx);
+		if (ret)
+			break;
 	}
- out:
-	drm_modeset_unlock_all(dev);
-	return rc;
+out:
+	if (ret == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return ret;
 }
 EXPORT_SYMBOL(drm_fb_helper_setcmap);
 
-- 
2.1.4
