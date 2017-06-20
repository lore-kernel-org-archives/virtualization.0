From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 04/11] drm: cirrus: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:28 +0200
Message-ID: <1497986735-14418-5-git-send-email-peda__46779.9103972085$1509078103$gmane$org@axentia.se>
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
 drivers/gpu/drm/cirrus/cirrus_drv.h   |  8 ----
 drivers/gpu/drm/cirrus/cirrus_fbdev.c |  2 -
 drivers/gpu/drm/cirrus/cirrus_mode.c  | 71 ++++++++---------------------------
 3 files changed, 16 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirrus/cirrus_drv.h
index 8690352..be2d7e48 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.h
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.h
@@ -96,7 +96,6 @@
 
 struct cirrus_crtc {
 	struct drm_crtc			base;
-	u8				lut_r[256], lut_g[256], lut_b[256];
 	int				last_dpms;
 	bool				enabled;
 };
@@ -180,13 +179,6 @@ cirrus_bo(struct ttm_buffer_object *bo)
 #define to_cirrus_obj(x) container_of(x, struct cirrus_gem_object, base)
 #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
 
-				/* cirrus_mode.c */
-void cirrus_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-			     u16 blue, int regno);
-void cirrus_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-			     u16 *blue, int regno);
-
-
 				/* cirrus_main.c */
 int cirrus_device_init(struct cirrus_device *cdev,
 		      struct drm_device *ddev,
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 7fa58ee..1fedab0 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -265,8 +265,6 @@ static int cirrus_fbdev_destroy(struct drm_device *dev,
 }
 
 static const struct drm_fb_helper_funcs cirrus_fb_helper_funcs = {
-	.gamma_set = cirrus_crtc_fb_gamma_set,
-	.gamma_get = cirrus_crtc_fb_gamma_get,
 	.fb_probe = cirrusfb_create,
 };
 
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 53f6f0f..a4c4a46 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -31,25 +31,6 @@
  * This file contains setup code for the CRTC.
  */
 
-static void cirrus_crtc_load_lut(struct drm_crtc *crtc)
-{
-	struct cirrus_crtc *cirrus_crtc = to_cirrus_crtc(crtc);
-	struct drm_device *dev = crtc->dev;
-	struct cirrus_device *cdev = dev->dev_private;
-	int i;
-
-	if (!crtc->enabled)
-		return;
-
-	for (i = 0; i < CIRRUS_LUT_SIZE; i++) {
-		/* VGA registers */
-		WREG8(PALETTE_INDEX, i);
-		WREG8(PALETTE_DATA, cirrus_crtc->lut_r[i]);
-		WREG8(PALETTE_DATA, cirrus_crtc->lut_g[i]);
-		WREG8(PALETTE_DATA, cirrus_crtc->lut_b[i]);
-	}
-}
-
 /*
  * The DRM core requires DPMS functions, but they make little sense in our
  * case and so are just stubs
@@ -330,15 +311,25 @@ static int cirrus_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				 u16 *blue, uint32_t size,
 				 struct drm_modeset_acquire_ctx *ctx)
 {
-	struct cirrus_crtc *cirrus_crtc = to_cirrus_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	struct cirrus_device *cdev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 
-	for (i = 0; i < size; i++) {
-		cirrus_crtc->lut_r[i] = red[i];
-		cirrus_crtc->lut_g[i] = green[i];
-		cirrus_crtc->lut_b[i] = blue[i];
+	if (!crtc->enabled)
+		return 0;
+
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
+
+	for (i = 0; i < CIRRUS_LUT_SIZE; i++) {
+		/* VGA registers */
+		WREG8(PALETTE_INDEX, i);
+		WREG8(PALETTE_DATA, *r++ >> 8);
+		WREG8(PALETTE_DATA, *g++ >> 8);
+		WREG8(PALETTE_DATA, *b++ >> 8);
 	}
-	cirrus_crtc_load_lut(crtc);
 
 	return 0;
 }
@@ -365,7 +356,6 @@ static const struct drm_crtc_helper_funcs cirrus_helper_funcs = {
 	.mode_set_base = cirrus_crtc_mode_set_base,
 	.prepare = cirrus_crtc_prepare,
 	.commit = cirrus_crtc_commit,
-	.load_lut = cirrus_crtc_load_lut,
 };
 
 /* CRTC setup */
@@ -373,7 +363,6 @@ static void cirrus_crtc_init(struct drm_device *dev)
 {
 	struct cirrus_device *cdev = dev->dev_private;
 	struct cirrus_crtc *cirrus_crtc;
-	int i;
 
 	cirrus_crtc = kzalloc(sizeof(struct cirrus_crtc) +
 			      (CIRRUSFB_CONN_LIMIT * sizeof(struct drm_connector *)),
@@ -387,37 +376,9 @@ static void cirrus_crtc_init(struct drm_device *dev)
 	drm_mode_crtc_set_gamma_size(&cirrus_crtc->base, CIRRUS_LUT_SIZE);
 	cdev->mode_info.crtc = cirrus_crtc;
 
-	for (i = 0; i < CIRRUS_LUT_SIZE; i++) {
-		cirrus_crtc->lut_r[i] = i;
-		cirrus_crtc->lut_g[i] = i;
-		cirrus_crtc->lut_b[i] = i;
-	}
-
 	drm_crtc_helper_add(&cirrus_crtc->base, &cirrus_helper_funcs);
 }
 
-/** Sets the color ramps on behalf of fbcon */
-void cirrus_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-			      u16 blue, int regno)
-{
-	struct cirrus_crtc *cirrus_crtc = to_cirrus_crtc(crtc);
-
-	cirrus_crtc->lut_r[regno] = red;
-	cirrus_crtc->lut_g[regno] = green;
-	cirrus_crtc->lut_b[regno] = blue;
-}
-
-/** Gets the color ramps on behalf of fbcon */
-void cirrus_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-			      u16 *blue, int regno)
-{
-	struct cirrus_crtc *cirrus_crtc = to_cirrus_crtc(crtc);
-
-	*red = cirrus_crtc->lut_r[regno];
-	*green = cirrus_crtc->lut_g[regno];
-	*blue = cirrus_crtc->lut_b[regno];
-}
-
 static void cirrus_encoder_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
-- 
2.1.4
