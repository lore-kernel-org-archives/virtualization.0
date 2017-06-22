From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 03/14] drm/fb-helper: do a generic fb_setcmap helper in
	terms of crtc .gamma_set
Date: Thu, 22 Jun 2017 12:22:10 +0200
Message-ID: <fd73b01e-3327-faf1-c3eb-80663b739ff6__33076.4710008681$1509078542$gmane$org@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
	<1498111597-10714-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1498111597-10714-4-git-send-email-peda@axentia.se>
Content-Language: en-US
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Jani Nikula <jani.nikula@linux.intel.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Yannick Fertre <yannick.fertre@st.com>, Sean Paul <seanpaul@chromium.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
totally obsolete.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_fb_helper.c | 151 +++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 88 deletions(-)

This is an alternative version rebased on top of Daniel's "fbdev helper
locking rework and deferred setup" series.

And as noted by Daniel, .gamma_set does an atomic commit. Thus, the locks
needs to be dropped and reacquired for each crtc. So, that is fixed here
too. Doing it like this with a couple of individual alternative patches
instead of sending a whole new series since the dependency on Daniel's
series makes life somewhat difficult...

Cheers,
peda

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 4aceb59..aa025f1 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1257,50 +1257,6 @@ void drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper,
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
@@ -1310,12 +1266,10 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_device *dev = fb_helper->dev;
-	const struct drm_crtc_helper_funcs *crtc_funcs;
-	u16 *red, *green, *blue, *transp;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_crtc *crtc;
 	u16 *r, *g, *b;
-	int i, j, rc = 0;
-	int start;
+	int i, ret = 0;
 
 	if (oops_in_progress)
 		return -EBUSY;
@@ -1329,61 +1283,82 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 		return -EBUSY;
 	}
 
-	drm_modeset_lock_all(dev);
-	for (i = 0; i < fb_helper->crtc_count; i++) {
-		crtc = fb_helper->crtc_info[i].mode_set.crtc;
-		crtc_funcs = crtc->helper_private;
+	drm_modeset_acquire_init(&ctx, 0);
 
-		red = cmap->red;
-		green = cmap->green;
-		blue = cmap->blue;
-		transp = cmap->transp;
-		start = cmap->start;
+	for (i = 0; i < fb_helper->crtc_count; i++) {
+		if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
+			u32 *palette;
+			int j;
 
-		if (info->fix.visual != FB_VISUAL_TRUECOLOR) {
-			if (!crtc->gamma_size) {
-				rc = -EINVAL;
-				goto out;
+			if (cmap->start + cmap->len > 16) {
+				ret = -EINVAL;
+				break;
 			}
 
-			if (cmap->start + cmap->len > crtc->gamma_size) {
-				rc = -EINVAL;
-				goto out;
+			palette = (u32 *)info->pseudo_palette;
+			for (j = 0; j < cmap->len; ++j) {
+				u16 red = cmap->red[j];
+				u16 green = cmap->green[j];
+				u16 blue = cmap->blue[j];
+				u32 value;
+
+				red >>= 16 - info->var.red.length;
+				green >>= 16 - info->var.green.length;
+				blue >>= 16 - info->var.blue.length;
+				value = (red << info->var.red.offset) |
+					(green << info->var.green.offset) |
+					(blue << info->var.blue.offset);
+				if (info->var.transp.length > 0) {
+					u32 mask = (1 << info->var.transp.length) - 1;
+
+					mask <<= info->var.transp.offset;
+					value |= mask;
+				}
+				palette[cmap->start + j] = value;
 			}
+			continue;
+		}
 
-			r = crtc->gamma_store;
-			g = r + crtc->gamma_size;
-			b = g + crtc->gamma_size;
+retry:
+		ret = drm_modeset_lock_all_ctx(dev, &ctx);
+		if (ret)
+			break;
 
-			memcpy(r + cmap->start, cmap->red,
-			       cmap->len * sizeof(u16));
-			memcpy(g + cmap->start, cmap->green,
-			       cmap->len * sizeof(u16));
-			memcpy(b + cmap->start, cmap->blue,
-			       cmap->len * sizeof(u16));
+		crtc = fb_helper->crtc_info[i].mode_set.crtc;
+		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
+			ret = -EINVAL;
+			goto drop_locks;
 		}
 
-		for (j = 0; j < cmap->len; j++) {
-			u16 hred, hgreen, hblue, htransp = 0xffff;
+		if (cmap->start + cmap->len > crtc->gamma_size) {
+			ret = -EINVAL;
+			goto drop_locks;
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
+		ret = crtc->funcs->gamma_set(crtc, r, g, b,
+					     crtc->gamma_size, &ctx);
+		if (ret == -EDEADLK) {
+			drm_modeset_backoff(&ctx);
+			goto retry;
 		}
-		if (crtc_funcs->load_lut)
-			crtc_funcs->load_lut(crtc);
+drop_locks:
+		drm_modeset_drop_locks(&ctx);
+		if (ret)
+			break;
 	}
- out:
-	drm_modeset_unlock_all(dev);
+
+	drm_modeset_acquire_fini(&ctx);
 	mutex_unlock(&fb_helper->lock);
-	return rc;
+
+	return ret;
 }
 EXPORT_SYMBOL(drm_fb_helper_setcmap);
 
-- 
2.1.4
