From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 09/11] drm: radeon: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:33 +0200
Message-ID: <1497986735-14418-10-git-send-email-peda__47840.8732255504$1509078277$gmane$org@axentia.se>
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
 drivers/gpu/drm/radeon/atombios_crtc.c      |  1 -
 drivers/gpu/drm/radeon/radeon_connectors.c  |  7 ++-
 drivers/gpu/drm/radeon/radeon_display.c     | 71 ++++++++++++-----------------
 drivers/gpu/drm/radeon/radeon_fb.c          |  2 -
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c |  1 -
 5 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 3c492a0..02baaaf 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -2217,7 +2217,6 @@ static const struct drm_crtc_helper_funcs atombios_helper_funcs = {
 	.mode_set_base_atomic = atombios_crtc_set_base_atomic,
 	.prepare = atombios_crtc_prepare,
 	.commit = atombios_crtc_commit,
-	.load_lut = radeon_crtc_load_lut,
 	.disable = atombios_crtc_disable,
 };
 
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 27affbd..2f642cb 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -773,12 +773,15 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
 
 		if (connector->encoder->crtc) {
 			struct drm_crtc *crtc  = connector->encoder->crtc;
-			const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
 			struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 
 			radeon_crtc->output_csc = radeon_encoder->output_csc;
 
-			(*crtc_funcs->load_lut)(crtc);
+			/*
+			 * Our .gamma_set assumes the .gamma_store has been
+			 * prefilled and don't care about its arguments.
+			 */
+			crtc->funcs->gamma_set(crtc, NULL, NULL, NULL, 0, NULL);
 		}
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 17d3daf..8b7d7a0 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -42,6 +42,7 @@ static void avivo_crtc_load_lut(struct drm_crtc *crtc)
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct radeon_device *rdev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 
 	DRM_DEBUG_KMS("%d\n", radeon_crtc->crtc_id);
@@ -60,11 +61,14 @@ static void avivo_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(AVIVO_DC_LUT_WRITE_EN_MASK, 0x0000003f);
 
 	WREG8(AVIVO_DC_LUT_RW_INDEX, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(AVIVO_DC_LUT_30_COLOR,
-			     (radeon_crtc->lut_r[i] << 20) |
-			     (radeon_crtc->lut_g[i] << 10) |
-			     (radeon_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 
 	/* Only change bit 0 of LUT_SEL, other bits are set elsewhere */
@@ -76,6 +80,7 @@ static void dce4_crtc_load_lut(struct drm_crtc *crtc)
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct radeon_device *rdev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 
 	DRM_DEBUG_KMS("%d\n", radeon_crtc->crtc_id);
@@ -93,11 +98,14 @@ static void dce4_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(EVERGREEN_DC_LUT_WRITE_EN_MASK + radeon_crtc->crtc_offset, 0x00000007);
 
 	WREG32(EVERGREEN_DC_LUT_RW_INDEX + radeon_crtc->crtc_offset, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(EVERGREEN_DC_LUT_30_COLOR + radeon_crtc->crtc_offset,
-		       (radeon_crtc->lut_r[i] << 20) |
-		       (radeon_crtc->lut_g[i] << 10) |
-		       (radeon_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 }
 
@@ -106,6 +114,7 @@ static void dce5_crtc_load_lut(struct drm_crtc *crtc)
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct radeon_device *rdev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 
 	DRM_DEBUG_KMS("%d\n", radeon_crtc->crtc_id);
@@ -135,11 +144,14 @@ static void dce5_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(EVERGREEN_DC_LUT_WRITE_EN_MASK + radeon_crtc->crtc_offset, 0x00000007);
 
 	WREG32(EVERGREEN_DC_LUT_RW_INDEX + radeon_crtc->crtc_offset, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(EVERGREEN_DC_LUT_30_COLOR + radeon_crtc->crtc_offset,
-		       (radeon_crtc->lut_r[i] << 20) |
-		       (radeon_crtc->lut_g[i] << 10) |
-		       (radeon_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 
 	WREG32(NI_DEGAMMA_CONTROL + radeon_crtc->crtc_offset,
@@ -172,6 +184,7 @@ static void legacy_crtc_load_lut(struct drm_crtc *crtc)
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct radeon_device *rdev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 	uint32_t dac2_cntl;
 
@@ -183,11 +196,14 @@ static void legacy_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(RADEON_DAC_CNTL2, dac2_cntl);
 
 	WREG8(RADEON_PALETTE_INDEX, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(RADEON_PALETTE_30_DATA,
-			     (radeon_crtc->lut_r[i] << 20) |
-			     (radeon_crtc->lut_g[i] << 10) |
-			     (radeon_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 }
 
@@ -209,41 +225,10 @@ void radeon_crtc_load_lut(struct drm_crtc *crtc)
 		legacy_crtc_load_lut(crtc);
 }
 
-/** Sets the color ramps on behalf of fbcon */
-void radeon_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-			      u16 blue, int regno)
-{
-	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
-
-	radeon_crtc->lut_r[regno] = red >> 6;
-	radeon_crtc->lut_g[regno] = green >> 6;
-	radeon_crtc->lut_b[regno] = blue >> 6;
-}
-
-/** Gets the color ramps on behalf of fbcon */
-void radeon_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-			      u16 *blue, int regno)
-{
-	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
-
-	*red = radeon_crtc->lut_r[regno] << 6;
-	*green = radeon_crtc->lut_g[regno] << 6;
-	*blue = radeon_crtc->lut_b[regno] << 6;
-}
-
 static int radeon_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				 u16 *blue, uint32_t size,
 				 struct drm_modeset_acquire_ctx *ctx)
 {
-	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		radeon_crtc->lut_r[i] = red[i] >> 6;
-		radeon_crtc->lut_g[i] = green[i] >> 6;
-		radeon_crtc->lut_b[i] = blue[i] >> 6;
-	}
 	radeon_crtc_load_lut(crtc);
 
 	return 0;
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 356ad90..638bcb55 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -332,8 +332,6 @@ static int radeon_fbdev_destroy(struct drm_device *dev, struct radeon_fbdev *rfb
 }
 
 static const struct drm_fb_helper_funcs radeon_fb_helper_funcs = {
-	.gamma_set = radeon_crtc_fb_gamma_set,
-	.gamma_get = radeon_crtc_fb_gamma_get,
 	.fb_probe = radeonfb_create,
 };
 
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
index ce6cb66..1f1856e 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
@@ -1116,7 +1116,6 @@ static const struct drm_crtc_helper_funcs legacy_helper_funcs = {
 	.mode_set_base_atomic = radeon_crtc_set_base_atomic,
 	.prepare = radeon_crtc_prepare,
 	.commit = radeon_crtc_commit,
-	.load_lut = radeon_crtc_load_lut,
 	.disable = radeon_crtc_disable
 };
 
-- 
2.1.4
