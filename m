From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 08/14] drm: gma500: remove dead code and pointless local
	lut storage
Date: Thu, 22 Jun 2017 08:06:31 +0200
Message-ID: <1498111597-10714-9-git-send-email-peda__20186.0533365563$1509078440$gmane$org@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1498111597-10714-1-git-send-email-peda@axentia.se>
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, Peter Rosin <peda@axentia.se>, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

The redundant fb helpers .gamma_set and .gamma_get are no longer
used. Remove the dead code and hook up the crtc .gamma_set
to use the crtc gamma_store directly instead of duplicating that
info locally.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/gma500/framebuffer.c       | 22 --------------------
 drivers/gpu/drm/gma500/gma_display.c       | 32 ++++++++++--------------------
 drivers/gpu/drm/gma500/psb_intel_display.c |  7 +------
 drivers/gpu/drm/gma500/psb_intel_drv.h     |  1 -
 4 files changed, 12 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 7da70b6..2570c7f 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -479,26 +479,6 @@ static struct drm_framebuffer *psb_user_framebuffer_create
 	return psb_framebuffer_create(dev, cmd, r);
 }
 
-static void psbfb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-							u16 blue, int regno)
-{
-	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
-
-	gma_crtc->lut_r[regno] = red >> 8;
-	gma_crtc->lut_g[regno] = green >> 8;
-	gma_crtc->lut_b[regno] = blue >> 8;
-}
-
-static void psbfb_gamma_get(struct drm_crtc *crtc, u16 *red,
-					u16 *green, u16 *blue, int regno)
-{
-	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
-
-	*red = gma_crtc->lut_r[regno] << 8;
-	*green = gma_crtc->lut_g[regno] << 8;
-	*blue = gma_crtc->lut_b[regno] << 8;
-}
-
 static int psbfb_probe(struct drm_fb_helper *helper,
 				struct drm_fb_helper_surface_size *sizes)
 {
@@ -525,8 +505,6 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 }
 
 static const struct drm_fb_helper_funcs psb_fb_helper_funcs = {
-	.gamma_set = psbfb_gamma_set,
-	.gamma_get = psbfb_gamma_get,
 	.fb_probe = psbfb_probe,
 };
 
diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index e7fd356..f3c48a2 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -144,33 +144,32 @@ void gma_crtc_load_lut(struct drm_crtc *crtc)
 	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
 	const struct psb_offset *map = &dev_priv->regmap[gma_crtc->pipe];
 	int palreg = map->palette;
+	u16 *r, *g, *b;
 	int i;
 
 	/* The clocks have to be on to load the palette. */
 	if (!crtc->enabled)
 		return;
 
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
+
 	if (gma_power_begin(dev, false)) {
 		for (i = 0; i < 256; i++) {
 			REG_WRITE(palreg + 4 * i,
-				  ((gma_crtc->lut_r[i] +
-				  gma_crtc->lut_adj[i]) << 16) |
-				  ((gma_crtc->lut_g[i] +
-				  gma_crtc->lut_adj[i]) << 8) |
-				  (gma_crtc->lut_b[i] +
-				  gma_crtc->lut_adj[i]));
+				  (((*r++ >> 8) + gma_crtc->lut_adj[i]) << 16) |
+				  (((*g++ >> 8) + gma_crtc->lut_adj[i]) << 8) |
+				  ((*b++ >> 8) + gma_crtc->lut_adj[i]));
 		}
 		gma_power_end(dev);
 	} else {
 		for (i = 0; i < 256; i++) {
 			/* FIXME: Why pipe[0] and not pipe[..._crtc->pipe]? */
 			dev_priv->regs.pipe[0].palette[i] =
-				  ((gma_crtc->lut_r[i] +
-				  gma_crtc->lut_adj[i]) << 16) |
-				  ((gma_crtc->lut_g[i] +
-				  gma_crtc->lut_adj[i]) << 8) |
-				  (gma_crtc->lut_b[i] +
-				  gma_crtc->lut_adj[i]);
+				(((*r++ >> 8) + gma_crtc->lut_adj[i]) << 16) |
+				(((*g++ >> 8) + gma_crtc->lut_adj[i]) << 8) |
+				((*b++ >> 8) + gma_crtc->lut_adj[i]);
 		}
 
 	}
@@ -180,15 +179,6 @@ int gma_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green, u16 *blue,
 		       u32 size,
 		       struct drm_modeset_acquire_ctx *ctx)
 {
-	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
-	int i;
-
-	for (i = 0; i < size; i++) {
-		gma_crtc->lut_r[i] = red[i] >> 8;
-		gma_crtc->lut_g[i] = green[i] >> 8;
-		gma_crtc->lut_b[i] = blue[i] >> 8;
-	}
-
 	gma_crtc_load_lut(crtc);
 
 	return 0;
diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
index 7b6c849..8762efa 100644
--- a/drivers/gpu/drm/gma500/psb_intel_display.c
+++ b/drivers/gpu/drm/gma500/psb_intel_display.c
@@ -518,13 +518,8 @@ void psb_intel_crtc_init(struct drm_device *dev, int pipe,
 	gma_crtc->pipe = pipe;
 	gma_crtc->plane = pipe;
 
-	for (i = 0; i < 256; i++) {
-		gma_crtc->lut_r[i] = i;
-		gma_crtc->lut_g[i] = i;
-		gma_crtc->lut_b[i] = i;
-
+	for (i = 0; i < 256; i++)
 		gma_crtc->lut_adj[i] = 0;
-	}
 
 	gma_crtc->mode_dev = mode_dev;
 	gma_crtc->cursor_addr = 0;
diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
index 6a10215..e8e4ea1 100644
--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -172,7 +172,6 @@ struct gma_crtc {
 	int plane;
 	uint32_t cursor_addr;
 	struct gtt_range *cursor_gt;
-	u8 lut_r[256], lut_g[256], lut_b[256];
 	u8 lut_adj[256];
 	struct psb_intel_framebuffer *fbdev_fb;
 	/* a mode_set for fbdev users on this crtc */
-- 
2.1.4
