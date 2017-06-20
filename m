From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 08/11] drm: nouveau: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:32 +0200
Message-ID: <1497986735-14418-9-git-send-email-peda__11937.9911026501$1509078256$gmane$org@axentia.se>
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
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 26 ++++++++--------------
 drivers/gpu/drm/nouveau/nouveau_crtc.h  |  3 ---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 22 -------------------
 drivers/gpu/drm/nouveau/nv50_display.c  | 39 ++++++++++-----------------------
 4 files changed, 21 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 4b4b0b4..8f689f1 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -764,13 +764,18 @@ nv_crtc_gamma_load(struct drm_crtc *crtc)
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
 	struct drm_device *dev = nv_crtc->base.dev;
 	struct rgb { uint8_t r, g, b; } __attribute__((packed)) *rgbs;
+	u16 *r, *g, *b;
 	int i;
 
 	rgbs = (struct rgb *)nv04_display(dev)->mode_reg.crtc_reg[nv_crtc->index].DAC;
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
+
 	for (i = 0; i < 256; i++) {
-		rgbs[i].r = nv_crtc->lut.r[i] >> 8;
-		rgbs[i].g = nv_crtc->lut.g[i] >> 8;
-		rgbs[i].b = nv_crtc->lut.b[i] >> 8;
+		rgbs[i].r = *r++ >> 8;
+		rgbs[i].g = *g++ >> 8;
+		rgbs[i].b = *b++ >> 8;
 	}
 
 	nouveau_hw_load_state_palette(dev, nv_crtc->index, &nv04_display(dev)->mode_reg);
@@ -792,13 +797,6 @@ nv_crtc_gamma_set(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
 		  struct drm_modeset_acquire_ctx *ctx)
 {
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
-	int i;
-
-	for (i = 0; i < size; i++) {
-		nv_crtc->lut.r[i] = r[i];
-		nv_crtc->lut.g[i] = g[i];
-		nv_crtc->lut.b[i] = b[i];
-	}
 
 	/* We need to know the depth before we upload, but it's possible to
 	 * get called before a framebuffer is bound.  If this is the case,
@@ -1095,7 +1093,6 @@ static const struct drm_crtc_helper_funcs nv04_crtc_helper_funcs = {
 	.mode_set = nv_crtc_mode_set,
 	.mode_set_base = nv04_crtc_mode_set_base,
 	.mode_set_base_atomic = nv04_crtc_mode_set_base_atomic,
-	.load_lut = nv_crtc_gamma_load,
 	.disable = nv_crtc_disable,
 };
 
@@ -1103,17 +1100,12 @@ int
 nv04_crtc_create(struct drm_device *dev, int crtc_num)
 {
 	struct nouveau_crtc *nv_crtc;
-	int ret, i;
+	int ret;
 
 	nv_crtc = kzalloc(sizeof(*nv_crtc), GFP_KERNEL);
 	if (!nv_crtc)
 		return -ENOMEM;
 
-	for (i = 0; i < 256; i++) {
-		nv_crtc->lut.r[i] = i << 8;
-		nv_crtc->lut.g[i] = i << 8;
-		nv_crtc->lut.b[i] = i << 8;
-	}
 	nv_crtc->lut.depth = 0;
 
 	nv_crtc->index = crtc_num;
diff --git a/drivers/gpu/drm/nouveau/nouveau_crtc.h b/drivers/gpu/drm/nouveau/nouveau_crtc.h
index 050fcf3..b7a18fb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_crtc.h
+++ b/drivers/gpu/drm/nouveau/nouveau_crtc.h
@@ -61,9 +61,6 @@ struct nouveau_crtc {
 
 	struct {
 		struct nouveau_bo *nvbo;
-		uint16_t r[256];
-		uint16_t g[256];
-		uint16_t b[256];
 		int depth;
 	} lut;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 2665a07..f770784 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -278,26 +278,6 @@ nouveau_fbcon_accel_init(struct drm_device *dev)
 		info->fbops = &nouveau_fbcon_ops;
 }
 
-static void nouveau_fbcon_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-				    u16 blue, int regno)
-{
-	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
-
-	nv_crtc->lut.r[regno] = red;
-	nv_crtc->lut.g[regno] = green;
-	nv_crtc->lut.b[regno] = blue;
-}
-
-static void nouveau_fbcon_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-				    u16 *blue, int regno)
-{
-	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
-
-	*red = nv_crtc->lut.r[regno];
-	*green = nv_crtc->lut.g[regno];
-	*blue = nv_crtc->lut.b[regno];
-}
-
 static void
 nouveau_fbcon_zfill(struct drm_device *dev, struct nouveau_fbdev *fbcon)
 {
@@ -467,8 +447,6 @@ void nouveau_fbcon_gpu_lockup(struct fb_info *info)
 }
 
 static const struct drm_fb_helper_funcs nouveau_fbcon_helper_funcs = {
-	.gamma_set = nouveau_fbcon_gamma_set,
-	.gamma_get = nouveau_fbcon_gamma_get,
 	.fb_probe = nouveau_fbcon_create,
 };
 
diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
index 775c100..3686f5b 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -2193,28 +2193,28 @@ nv50_head_lut_load(struct drm_crtc *crtc)
 	struct nv50_disp *disp = nv50_disp(crtc->dev);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
 	void __iomem *lut = nvbo_kmap_obj_iovirtual(nv_crtc->lut.nvbo);
+	u16 *r, *g, *b;
 	int i;
 
-	for (i = 0; i < 256; i++) {
-		u16 r = nv_crtc->lut.r[i] >> 2;
-		u16 g = nv_crtc->lut.g[i] >> 2;
-		u16 b = nv_crtc->lut.b[i] >> 2;
+	r = crtc->gamma_store;
+	g = r + crtc->gamma_size;
+	b = g + crtc->gamma_size;
 
+	for (i = 0; i < 256; i++) {
 		if (disp->disp->oclass < GF110_DISP) {
-			writew(r + 0x0000, lut + (i * 0x08) + 0);
-			writew(g + 0x0000, lut + (i * 0x08) + 2);
-			writew(b + 0x0000, lut + (i * 0x08) + 4);
+			writew((*r++ >> 2) + 0x0000, lut + (i * 0x08) + 0);
+			writew((*g++ >> 2) + 0x0000, lut + (i * 0x08) + 2);
+			writew((*b++ >> 2) + 0x0000, lut + (i * 0x08) + 4);
 		} else {
-			writew(r + 0x6000, lut + (i * 0x20) + 0);
-			writew(g + 0x6000, lut + (i * 0x20) + 2);
-			writew(b + 0x6000, lut + (i * 0x20) + 4);
+			writew((*r++ >> 2) + 0x6000, lut + (i * 0x20) + 0);
+			writew((*g++ >> 2) + 0x6000, lut + (i * 0x20) + 2);
+			writew((*b++ >> 2) + 0x6000, lut + (i * 0x20) + 4);
 		}
 	}
 }
 
 static const struct drm_crtc_helper_funcs
 nv50_head_help = {
-	.load_lut = nv50_head_lut_load,
 	.atomic_check = nv50_head_atomic_check,
 };
 
@@ -2223,15 +2223,6 @@ nv50_head_gamma_set(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
 		    uint32_t size,
 		    struct drm_modeset_acquire_ctx *ctx)
 {
-	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
-	u32 i;
-
-	for (i = 0; i < size; i++) {
-		nv_crtc->lut.r[i] = r[i];
-		nv_crtc->lut.g[i] = g[i];
-		nv_crtc->lut.b[i] = b[i];
-	}
-
 	nv50_head_lut_load(crtc);
 	return 0;
 }
@@ -2329,19 +2320,13 @@ nv50_head_create(struct drm_device *dev, int index)
 	struct nv50_base *base;
 	struct nv50_curs *curs;
 	struct drm_crtc *crtc;
-	int ret, i;
+	int ret;
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
 	if (!head)
 		return -ENOMEM;
 
 	head->base.index = index;
-	for (i = 0; i < 256; i++) {
-		head->base.lut.r[i] = i << 8;
-		head->base.lut.g[i] = i << 8;
-		head->base.lut.b[i] = i << 8;
-	}
-
 	ret = nv50_base_new(drm, head, &base);
 	if (ret == 0)
 		ret = nv50_curs_new(drm, head, &curs);
-- 
2.1.4
