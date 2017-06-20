From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 02/11] drm: amd: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:26 +0200
Message-ID: <1497986735-14418-3-git-send-email-peda__14385.0329485305$1509078077$gmane$org@axentia.se>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c   | 24 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h |  1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c   | 27 +++++++--------------------
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c   | 27 +++++++--------------------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c    | 27 +++++++--------------------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c    | 27 +++++++--------------------
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 23 -----------------------
 7 files changed, 28 insertions(+), 128 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index c0d8c6f..7dc3780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -312,31 +312,7 @@ static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfb
 	return 0;
 }
 
-/** Sets the color ramps on behalf of fbcon */
-static void amdgpu_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-				      u16 blue, int regno)
-{
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-	amdgpu_crtc->lut_r[regno] = red >> 6;
-	amdgpu_crtc->lut_g[regno] = green >> 6;
-	amdgpu_crtc->lut_b[regno] = blue >> 6;
-}
-
-/** Gets the color ramps on behalf of fbcon */
-static void amdgpu_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-				      u16 *blue, int regno)
-{
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-	*red = amdgpu_crtc->lut_r[regno] << 6;
-	*green = amdgpu_crtc->lut_g[regno] << 6;
-	*blue = amdgpu_crtc->lut_b[regno] << 6;
-}
-
 static const struct drm_fb_helper_funcs amdgpu_fb_helper_funcs = {
-	.gamma_set = amdgpu_crtc_fb_gamma_set,
-	.gamma_get = amdgpu_crtc_fb_gamma_get,
 	.fb_probe = amdgpufb_create,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 43a9d3a..39f7eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -369,7 +369,6 @@ struct amdgpu_atom_ss {
 struct amdgpu_crtc {
 	struct drm_crtc base;
 	int crtc_id;
-	u16 lut_r[256], lut_g[256], lut_b[256];
 	bool enabled;
 	bool can_tile;
 	uint32_t crtc_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 3c62c45..8e8c028 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2264,6 +2264,7 @@ static void dce_v10_0_crtc_load_lut(struct drm_crtc *crtc)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 	u32 tmp;
 
@@ -2301,11 +2302,14 @@ static void dce_v10_0_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(mmDC_LUT_WRITE_EN_MASK + amdgpu_crtc->crtc_offset, 0x00000007);
 
 	WREG32(mmDC_LUT_RW_INDEX + amdgpu_crtc->crtc_offset, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(mmDC_LUT_30_COLOR + amdgpu_crtc->crtc_offset,
-		       (amdgpu_crtc->lut_r[i] << 20) |
-		       (amdgpu_crtc->lut_g[i] << 10) |
-		       (amdgpu_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 
 	tmp = RREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset);
@@ -2621,15 +2625,6 @@ static int dce_v10_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				    u16 *blue, uint32_t size,
 				    struct drm_modeset_acquire_ctx *ctx)
 {
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		amdgpu_crtc->lut_r[i] = red[i] >> 6;
-		amdgpu_crtc->lut_g[i] = green[i] >> 6;
-		amdgpu_crtc->lut_b[i] = blue[i] >> 6;
-	}
 	dce_v10_0_crtc_load_lut(crtc);
 
 	return 0;
@@ -2841,14 +2836,12 @@ static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
 	.mode_set_base_atomic = dce_v10_0_crtc_set_base_atomic,
 	.prepare = dce_v10_0_crtc_prepare,
 	.commit = dce_v10_0_crtc_commit,
-	.load_lut = dce_v10_0_crtc_load_lut,
 	.disable = dce_v10_0_crtc_disable,
 };
 
 static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
-	int i;
 
 	amdgpu_crtc = kzalloc(sizeof(struct amdgpu_crtc) +
 			      (AMDGPUFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
@@ -2866,12 +2859,6 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
 	adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
 	adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
 
-	for (i = 0; i < 256; i++) {
-		amdgpu_crtc->lut_r[i] = i << 2;
-		amdgpu_crtc->lut_g[i] = i << 2;
-		amdgpu_crtc->lut_b[i] = i << 2;
-	}
-
 	switch (amdgpu_crtc->crtc_id) {
 	case 0:
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c8ed0fa..2280376 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2248,6 +2248,7 @@ static void dce_v11_0_crtc_load_lut(struct drm_crtc *crtc)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 	u32 tmp;
 
@@ -2279,11 +2280,14 @@ static void dce_v11_0_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(mmDC_LUT_WRITE_EN_MASK + amdgpu_crtc->crtc_offset, 0x00000007);
 
 	WREG32(mmDC_LUT_RW_INDEX + amdgpu_crtc->crtc_offset, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(mmDC_LUT_30_COLOR + amdgpu_crtc->crtc_offset,
-		       (amdgpu_crtc->lut_r[i] << 20) |
-		       (amdgpu_crtc->lut_g[i] << 10) |
-		       (amdgpu_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 
 	tmp = RREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset);
@@ -2641,15 +2645,6 @@ static int dce_v11_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				    u16 *blue, uint32_t size,
 				    struct drm_modeset_acquire_ctx *ctx)
 {
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		amdgpu_crtc->lut_r[i] = red[i] >> 6;
-		amdgpu_crtc->lut_g[i] = green[i] >> 6;
-		amdgpu_crtc->lut_b[i] = blue[i] >> 6;
-	}
 	dce_v11_0_crtc_load_lut(crtc);
 
 	return 0;
@@ -2889,14 +2884,12 @@ static const struct drm_crtc_helper_funcs dce_v11_0_crtc_helper_funcs = {
 	.mode_set_base_atomic = dce_v11_0_crtc_set_base_atomic,
 	.prepare = dce_v11_0_crtc_prepare,
 	.commit = dce_v11_0_crtc_commit,
-	.load_lut = dce_v11_0_crtc_load_lut,
 	.disable = dce_v11_0_crtc_disable,
 };
 
 static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
-	int i;
 
 	amdgpu_crtc = kzalloc(sizeof(struct amdgpu_crtc) +
 			      (AMDGPUFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
@@ -2914,12 +2907,6 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
 	adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
 	adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
 
-	for (i = 0; i < 256; i++) {
-		amdgpu_crtc->lut_r[i] = i << 2;
-		amdgpu_crtc->lut_g[i] = i << 2;
-		amdgpu_crtc->lut_b[i] = i << 2;
-	}
-
 	switch (amdgpu_crtc->crtc_id) {
 	case 0:
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3f3a254..6d957f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1679,6 +1679,7 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 
 	DRM_DEBUG_KMS("%d\n", amdgpu_crtc->crtc_id);
@@ -1708,11 +1709,14 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(mmDC_LUT_WRITE_EN_MASK + amdgpu_crtc->crtc_offset, 0x00000007);
 
 	WREG32(mmDC_LUT_RW_INDEX + amdgpu_crtc->crtc_offset, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(mmDC_LUT_30_COLOR + amdgpu_crtc->crtc_offset,
-		       (amdgpu_crtc->lut_r[i] << 20) |
-		       (amdgpu_crtc->lut_g[i] << 10) |
-		       (amdgpu_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 
 	WREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset,
@@ -1993,15 +1997,6 @@ static int dce_v6_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				   u16 *blue, uint32_t size,
 				   struct drm_modeset_acquire_ctx *ctx)
 {
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		amdgpu_crtc->lut_r[i] = red[i] >> 6;
-		amdgpu_crtc->lut_g[i] = green[i] >> 6;
-		amdgpu_crtc->lut_b[i] = blue[i] >> 6;
-	}
 	dce_v6_0_crtc_load_lut(crtc);
 
 	return 0;
@@ -2209,14 +2204,12 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
 	.mode_set_base_atomic = dce_v6_0_crtc_set_base_atomic,
 	.prepare = dce_v6_0_crtc_prepare,
 	.commit = dce_v6_0_crtc_commit,
-	.load_lut = dce_v6_0_crtc_load_lut,
 	.disable = dce_v6_0_crtc_disable,
 };
 
 static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
-	int i;
 
 	amdgpu_crtc = kzalloc(sizeof(struct amdgpu_crtc) +
 			      (AMDGPUFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
@@ -2234,12 +2227,6 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
 	adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
 	adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
 
-	for (i = 0; i < 256; i++) {
-		amdgpu_crtc->lut_r[i] = i << 2;
-		amdgpu_crtc->lut_g[i] = i << 2;
-		amdgpu_crtc->lut_b[i] = i << 2;
-	}
-
 	amdgpu_crtc->crtc_offset = crtc_offsets[amdgpu_crtc->crtc_id];
 
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 3e90c19..a946bf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2121,6 +2121,7 @@ static void dce_v8_0_crtc_load_lut(struct drm_crtc *crtc)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	u16 *r, *g, *b;
 	int i;
 
 	DRM_DEBUG_KMS("%d\n", amdgpu_crtc->crtc_id);
@@ -2150,11 +2151,14 @@ static void dce_v8_0_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(mmDC_LUT_WRITE_EN_MASK + amdgpu_crtc->crtc_offset, 0x00000007);
 
 	WREG32(mmDC_LUT_RW_INDEX + amdgpu_crtc->crtc_offset, 0);
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 	for (i = 0; i < 256; i++) {
 		WREG32(mmDC_LUT_30_COLOR + amdgpu_crtc->crtc_offset,
-		       (amdgpu_crtc->lut_r[i] << 20) |
-		       (amdgpu_crtc->lut_g[i] << 10) |
-		       (amdgpu_crtc->lut_b[i] << 0));
+		       ((*r++ & 0xffc0) << 14) |
+		       ((*g++ & 0xffc0) << 4) |
+		       (*b++ >> 6));
 	}
 
 	WREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset,
@@ -2472,15 +2476,6 @@ static int dce_v8_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				   u16 *blue, uint32_t size,
 				   struct drm_modeset_acquire_ctx *ctx)
 {
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		amdgpu_crtc->lut_r[i] = red[i] >> 6;
-		amdgpu_crtc->lut_g[i] = green[i] >> 6;
-		amdgpu_crtc->lut_b[i] = blue[i] >> 6;
-	}
 	dce_v8_0_crtc_load_lut(crtc);
 
 	return 0;
@@ -2699,14 +2694,12 @@ static const struct drm_crtc_helper_funcs dce_v8_0_crtc_helper_funcs = {
 	.mode_set_base_atomic = dce_v8_0_crtc_set_base_atomic,
 	.prepare = dce_v8_0_crtc_prepare,
 	.commit = dce_v8_0_crtc_commit,
-	.load_lut = dce_v8_0_crtc_load_lut,
 	.disable = dce_v8_0_crtc_disable,
 };
 
 static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
-	int i;
 
 	amdgpu_crtc = kzalloc(sizeof(struct amdgpu_crtc) +
 			      (AMDGPUFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
@@ -2724,12 +2717,6 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
 	adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
 	adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
 
-	for (i = 0; i < 256; i++) {
-		amdgpu_crtc->lut_r[i] = i << 2;
-		amdgpu_crtc->lut_g[i] = i << 2;
-		amdgpu_crtc->lut_b[i] = i << 2;
-	}
-
 	amdgpu_crtc->crtc_offset = crtc_offsets[amdgpu_crtc->crtc_id];
 
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 90bb083..ecf34bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -168,16 +168,6 @@ static int dce_virtual_crtc_gamma_set(struct drm_crtc *crtc, u16 *red,
 				      u16 *green, u16 *blue, uint32_t size,
 				      struct drm_modeset_acquire_ctx *ctx)
 {
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	int i;
-
-	/* userspace palettes are always correct as is */
-	for (i = 0; i < size; i++) {
-		amdgpu_crtc->lut_r[i] = red[i] >> 6;
-		amdgpu_crtc->lut_g[i] = green[i] >> 6;
-		amdgpu_crtc->lut_b[i] = blue[i] >> 6;
-	}
-
 	return 0;
 }
 
@@ -289,11 +279,6 @@ static int dce_virtual_crtc_set_base(struct drm_crtc *crtc, int x, int y,
 	return 0;
 }
 
-static void dce_virtual_crtc_load_lut(struct drm_crtc *crtc)
-{
-	return;
-}
-
 static int dce_virtual_crtc_set_base_atomic(struct drm_crtc *crtc,
 					 struct drm_framebuffer *fb,
 					 int x, int y, enum mode_set_atomic state)
@@ -309,14 +294,12 @@ static const struct drm_crtc_helper_funcs dce_virtual_crtc_helper_funcs = {
 	.mode_set_base_atomic = dce_virtual_crtc_set_base_atomic,
 	.prepare = dce_virtual_crtc_prepare,
 	.commit = dce_virtual_crtc_commit,
-	.load_lut = dce_virtual_crtc_load_lut,
 	.disable = dce_virtual_crtc_disable,
 };
 
 static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
-	int i;
 
 	amdgpu_crtc = kzalloc(sizeof(struct amdgpu_crtc) +
 			      (AMDGPUFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
@@ -329,12 +312,6 @@ static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
 	amdgpu_crtc->crtc_id = index;
 	adev->mode_info.crtcs[index] = amdgpu_crtc;
 
-	for (i = 0; i < 256; i++) {
-		amdgpu_crtc->lut_r[i] = i << 2;
-		amdgpu_crtc->lut_g[i] = i << 2;
-		amdgpu_crtc->lut_b[i] = i << 2;
-	}
-
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
-- 
2.1.4
