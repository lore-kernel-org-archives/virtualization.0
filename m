From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 03/11] drm: ast: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:27 +0200
Message-ID: <1497986735-14418-4-git-send-email-peda__24112.6125948087$1509078085$gmane$org@axentia.se>
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

The redundant fb helpers .load_lut, .gamma_set and .gamma_get are
no longer used. Remove the dead code and hook up the crtc .gamma_set
to use the crtc gamma_store directly instead of duplicating that
info locally.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/ast/ast_drv.h  |  1 -
 drivers/gpu/drm/ast/ast_fb.c   | 20 --------------------
 drivers/gpu/drm/ast/ast_mode.c | 26 ++++++--------------------
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 8880f0b..569a148 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -245,7 +245,6 @@ struct ast_connector {
 
 struct ast_crtc {
 	struct drm_crtc base;
-	u8 lut_r[256], lut_g[256], lut_b[256];
 	struct drm_gem_object *cursor_bo;
 	uint64_t cursor_addr;
 	int cursor_width, cursor_height;
diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index 4ad4acd..dbabcac 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -255,27 +255,7 @@ static int astfb_create(struct drm_fb_helper *helper,
 	return ret;
 }
 
-static void ast_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-			       u16 blue, int regno)
-{
-	struct ast_crtc *ast_crtc = to_ast_crtc(crtc);
-	ast_crtc->lut_r[regno] = red >> 8;
-	ast_crtc->lut_g[regno] = green >> 8;
-	ast_crtc->lut_b[regno] = blue >> 8;
-}
-
-static void ast_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-			       u16 *blue, int regno)
-{
-	struct ast_crtc *ast_crtc = to_ast_crtc(crtc);
-	*red = ast_crtc->lut_r[regno] << 8;
-	*green = ast_crtc->lut_g[regno] << 8;
-	*blue = ast_crtc->lut_b[regno] << 8;
-}
-
 static const struct drm_fb_helper_funcs ast_fb_helper_funcs = {
-	.gamma_set = ast_fb_gamma_set,
-	.gamma_get = ast_fb_gamma_get,
 	.fb_probe = astfb_create,
 };
 
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index aaef0a6..724c16b 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -63,15 +63,18 @@ static inline void ast_load_palette_index(struct ast_private *ast,
 static void ast_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct ast_private *ast = crtc->dev->dev_private;
-	struct ast_crtc *ast_crtc = to_ast_crtc(crtc);
+	u16 *r, *g, *b;
 	int i;
 
 	if (!crtc->enabled)
 		return;
 
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
+
 	for (i = 0; i < 256; i++)
-		ast_load_palette_index(ast, i, ast_crtc->lut_r[i],
-				       ast_crtc->lut_g[i], ast_crtc->lut_b[i]);
+		ast_load_palette_index(ast, i, *r++ >> 8, *g++ >> 8, *b++ >> 8);
 }
 
 static bool ast_get_vbios_mode_info(struct drm_crtc *crtc, struct drm_display_mode *mode,
@@ -633,7 +636,6 @@ static const struct drm_crtc_helper_funcs ast_crtc_helper_funcs = {
 	.mode_set = ast_crtc_mode_set,
 	.mode_set_base = ast_crtc_mode_set_base,
 	.disable = ast_crtc_disable,
-	.load_lut = ast_crtc_load_lut,
 	.prepare = ast_crtc_prepare,
 	.commit = ast_crtc_commit,
 
@@ -648,15 +650,6 @@ static int ast_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 			      u16 *blue, uint32_t size,
 			      struct drm_modeset_acquire_ctx *ctx)
 {
-	struct ast_crtc *ast_crtc = to_ast_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		ast_crtc->lut_r[i] = red[i] >> 8;
-		ast_crtc->lut_g[i] = green[i] >> 8;
-		ast_crtc->lut_b[i] = blue[i] >> 8;
-	}
 	ast_crtc_load_lut(crtc);
 
 	return 0;
@@ -681,7 +674,6 @@ static const struct drm_crtc_funcs ast_crtc_funcs = {
 static int ast_crtc_init(struct drm_device *dev)
 {
 	struct ast_crtc *crtc;
-	int i;
 
 	crtc = kzalloc(sizeof(struct ast_crtc), GFP_KERNEL);
 	if (!crtc)
@@ -690,12 +682,6 @@ static int ast_crtc_init(struct drm_device *dev)
 	drm_crtc_init(dev, &crtc->base, &ast_crtc_funcs);
 	drm_mode_crtc_set_gamma_size(&crtc->base, 256);
 	drm_crtc_helper_add(&crtc->base, &ast_crtc_helper_funcs);
-
-	for (i = 0; i < 256; i++) {
-		crtc->lut_r[i] = i;
-		crtc->lut_g[i] = i;
-		crtc->lut_b[i] = i;
-	}
 	return 0;
 }
 
-- 
2.1.4
