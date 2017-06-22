From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 10/14] drm: mgag200: remove dead code and pointless local
	lut storage
Date: Thu, 22 Jun 2017 08:06:33 +0200
Message-ID: <1498111597-10714-11-git-send-email-peda__37876.37233404$1509078453$gmane$org@axentia.se>
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

The redundant fb helpers .load_lut, .gamma_set and .gamma_get are
no longer used. Remove the dead code and hook up the crtc .gamma_set
to use the crtc gamma_store directly instead of duplicating that
info locally.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  5 ---
 drivers/gpu/drm/mgag200/mgag200_fb.c   |  2 --
 drivers/gpu/drm/mgag200/mgag200_mode.c | 62 ++++++++--------------------------
 3 files changed, 15 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index c88b6ec..04f1dfb 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -237,11 +237,6 @@ mgag200_bo(struct ttm_buffer_object *bo)
 {
 	return container_of(bo, struct mgag200_bo, bo);
 }
-				/* mgag200_crtc.c */
-void mga_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-			     u16 blue, int regno);
-void mga_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-			     u16 *blue, int regno);
 
 				/* mgag200_mode.c */
 int mgag200_modeset_init(struct mga_device *mdev);
diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
index 5d3b1fa..5cf980a 100644
--- a/drivers/gpu/drm/mgag200/mgag200_fb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
@@ -258,8 +258,6 @@ static int mga_fbdev_destroy(struct drm_device *dev,
 }
 
 static const struct drm_fb_helper_funcs mga_fb_helper_funcs = {
-	.gamma_set = mga_crtc_fb_gamma_set,
-	.gamma_get = mga_crtc_fb_gamma_get,
 	.fb_probe = mgag200fb_create,
 };
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index f4b5358..5e9cd4c 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -27,15 +27,19 @@
 
 static void mga_crtc_load_lut(struct drm_crtc *crtc)
 {
-	struct mga_crtc *mga_crtc = to_mga_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct mga_device *mdev = dev->dev_private;
 	struct drm_framebuffer *fb = crtc->primary->fb;
+	u16 *r_ptr, *g_ptr, *b_ptr;
 	int i;
 
 	if (!crtc->enabled)
 		return;
 
+	r_ptr = crtc->gamma_store;
+	g_ptr = r_ptr + crtc->gamma_size;
+	b_ptr = g_ptr + crtc->gamma_size;
+
 	WREG8(DAC_INDEX + MGA1064_INDEX, 0);
 
 	if (fb && fb->format->cpp[0] * 8 == 16) {
@@ -46,25 +50,27 @@ static void mga_crtc_load_lut(struct drm_crtc *crtc)
 				if (i > (MGAG200_LUT_SIZE >> 1)) {
 					r = b = 0;
 				} else {
-					r = mga_crtc->lut_r[i << 1];
-					b = mga_crtc->lut_b[i << 1];
+					r = *r_ptr++ >> 8;
+					b = *b_ptr++ >> 8;
+					r_ptr++;
+					b_ptr++;
 				}
 			} else {
-				r = mga_crtc->lut_r[i];
-				b = mga_crtc->lut_b[i];
+				r = *r_ptr++ >> 8;
+				b = *b_ptr++ >> 8;
 			}
 			/* VGA registers */
 			WREG8(DAC_INDEX + MGA1064_COL_PAL, r);
-			WREG8(DAC_INDEX + MGA1064_COL_PAL, mga_crtc->lut_g[i]);
+			WREG8(DAC_INDEX + MGA1064_COL_PAL, *g_ptr++ >> 8);
 			WREG8(DAC_INDEX + MGA1064_COL_PAL, b);
 		}
 		return;
 	}
 	for (i = 0; i < MGAG200_LUT_SIZE; i++) {
 		/* VGA registers */
-		WREG8(DAC_INDEX + MGA1064_COL_PAL, mga_crtc->lut_r[i]);
-		WREG8(DAC_INDEX + MGA1064_COL_PAL, mga_crtc->lut_g[i]);
-		WREG8(DAC_INDEX + MGA1064_COL_PAL, mga_crtc->lut_b[i]);
+		WREG8(DAC_INDEX + MGA1064_COL_PAL, *r_ptr++ >> 8);
+		WREG8(DAC_INDEX + MGA1064_COL_PAL, *g_ptr++ >> 8);
+		WREG8(DAC_INDEX + MGA1064_COL_PAL, *b_ptr++ >> 8);
 	}
 }
 
@@ -1399,14 +1405,6 @@ static int mga_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 			      u16 *blue, uint32_t size,
 			      struct drm_modeset_acquire_ctx *ctx)
 {
-	struct mga_crtc *mga_crtc = to_mga_crtc(crtc);
-	int i;
-
-	for (i = 0; i < size; i++) {
-		mga_crtc->lut_r[i] = red[i] >> 8;
-		mga_crtc->lut_g[i] = green[i] >> 8;
-		mga_crtc->lut_b[i] = blue[i] >> 8;
-	}
 	mga_crtc_load_lut(crtc);
 
 	return 0;
@@ -1455,14 +1453,12 @@ static const struct drm_crtc_helper_funcs mga_helper_funcs = {
 	.mode_set_base = mga_crtc_mode_set_base,
 	.prepare = mga_crtc_prepare,
 	.commit = mga_crtc_commit,
-	.load_lut = mga_crtc_load_lut,
 };
 
 /* CRTC setup */
 static void mga_crtc_init(struct mga_device *mdev)
 {
 	struct mga_crtc *mga_crtc;
-	int i;
 
 	mga_crtc = kzalloc(sizeof(struct mga_crtc) +
 			      (MGAG200FB_CONN_LIMIT * sizeof(struct drm_connector *)),
@@ -1476,37 +1472,9 @@ static void mga_crtc_init(struct mga_device *mdev)
 	drm_mode_crtc_set_gamma_size(&mga_crtc->base, MGAG200_LUT_SIZE);
 	mdev->mode_info.crtc = mga_crtc;
 
-	for (i = 0; i < MGAG200_LUT_SIZE; i++) {
-		mga_crtc->lut_r[i] = i;
-		mga_crtc->lut_g[i] = i;
-		mga_crtc->lut_b[i] = i;
-	}
-
 	drm_crtc_helper_add(&mga_crtc->base, &mga_helper_funcs);
 }
 
-/** Sets the color ramps on behalf of fbcon */
-void mga_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-			      u16 blue, int regno)
-{
-	struct mga_crtc *mga_crtc = to_mga_crtc(crtc);
-
-	mga_crtc->lut_r[regno] = red >> 8;
-	mga_crtc->lut_g[regno] = green >> 8;
-	mga_crtc->lut_b[regno] = blue >> 8;
-}
-
-/** Gets the color ramps on behalf of fbcon */
-void mga_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-			      u16 *blue, int regno)
-{
-	struct mga_crtc *mga_crtc = to_mga_crtc(crtc);
-
-	*red = (u16)mga_crtc->lut_r[regno] << 8;
-	*green = (u16)mga_crtc->lut_g[regno] << 8;
-	*blue = (u16)mga_crtc->lut_b[regno] << 8;
-}
-
 /*
  * The encoder comes after the CRTC in the output pipeline, but before
  * the connector. It's responsible for ensuring that the digital
-- 
2.1.4
