From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 04/16] drm/color-mgmt: move atomic state/commit out from
	.gamma_set
Date: Tue,  4 Jul 2017 12:37:00 +0200
Message-ID: <1499164632-5582-5-git-send-email-peda__20871.5464490981$1509078711$gmane$org@axentia.se>
References: <1499164632-5582-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1499164632-5582-1-git-send-email-peda@axentia.se>
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
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Sinclair Yeh <syeh@vmware.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Eric Anholt <eric@anholt.net>, Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Handle the atomics directly in the ioctl instead, in preparation for the
fb_setcmap helper needing to commit the gamma map for several crtc in one
commit.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c |  2 +-
 drivers/gpu/drm/ast/ast_mode.c           |  2 +-
 drivers/gpu/drm/cirrus/cirrus_mode.c     |  2 +-
 drivers/gpu/drm/drm_atomic_helper.c      | 37 +++++++-------------------------
 drivers/gpu/drm/drm_color_mgmt.c         | 27 ++++++++++++++++++++++-
 drivers/gpu/drm/gma500/gma_display.c     |  2 +-
 drivers/gpu/drm/gma500/gma_display.h     |  2 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c   |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c  |  2 +-
 drivers/gpu/drm/nouveau/nv50_display.c   |  2 +-
 drivers/gpu/drm/radeon/radeon_display.c  |  2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c           |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h      |  2 +-
 include/drm/drm_atomic_helper.h          |  2 +-
 include/drm/drm_crtc.h                   |  3 +--
 20 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 9f78c03..31c977b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2622,7 +2622,7 @@ static void dce_v10_0_cursor_reset(struct drm_crtc *crtc)
 
 static int dce_v10_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				    u16 *blue, uint32_t size,
-				    struct drm_modeset_acquire_ctx *ctx)
+				    struct drm_crtc_state *state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 4bcf01d..cf42640 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2642,7 +2642,7 @@ static void dce_v11_0_cursor_reset(struct drm_crtc *crtc)
 
 static int dce_v11_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				    u16 *blue, uint32_t size,
-				    struct drm_modeset_acquire_ctx *ctx)
+				    struct drm_crtc_state *state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index fd134a4..045014d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2494,7 +2494,7 @@ static void dce_v6_0_cursor_reset(struct drm_crtc *crtc)
 
 static int dce_v6_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				   u16 *blue, uint32_t size,
-				   struct drm_modeset_acquire_ctx *ctx)
+				   struct drm_crtc_state *state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a9e8695..ee9389f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2473,7 +2473,7 @@ static void dce_v8_0_cursor_reset(struct drm_crtc *crtc)
 
 static int dce_v8_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				   u16 *blue, uint32_t size,
-				   struct drm_modeset_acquire_ctx *ctx)
+				   struct drm_crtc_state *state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 90bb083..f194dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -166,7 +166,7 @@ static void dce_virtual_bandwidth_update(struct amdgpu_device *adev)
 
 static int dce_virtual_crtc_gamma_set(struct drm_crtc *crtc, u16 *red,
 				      u16 *green, u16 *blue, uint32_t size,
-				      struct drm_modeset_acquire_ctx *ctx)
+				      struct drm_crtc_state *state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index aaef0a6..6f0335b 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -646,7 +646,7 @@ static void ast_crtc_reset(struct drm_crtc *crtc)
 
 static int ast_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 			      u16 *blue, uint32_t size,
-			      struct drm_modeset_acquire_ctx *ctx)
+			      struct drm_crtc_state *state)
 {
 	struct ast_crtc *ast_crtc = to_ast_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 53f6f0f..2b4c2c3 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -328,7 +328,7 @@ static void cirrus_crtc_commit(struct drm_crtc *crtc)
  */
 static int cirrus_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				 u16 *blue, uint32_t size,
-				 struct drm_modeset_acquire_ctx *ctx)
+				 struct drm_crtc_state *state)
 {
 	struct cirrus_crtc *cirrus_crtc = to_cirrus_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 86d3093..3045f51 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3599,7 +3599,7 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
  * @green: green correction table
  * @blue: green correction table
  * @size: size of the tables
- * @ctx: lock acquire context
+ * @state: atomic CRTC state object to manipulate
  *
  * Implements support for legacy gamma correction table for drivers
  * that support color management through the DEGAMMA_LUT/GAMMA_LUT
@@ -3609,28 +3609,19 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
 int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
 				       u16 *red, u16 *green, u16 *blue,
 				       uint32_t size,
-				       struct drm_modeset_acquire_ctx *ctx)
+				       struct drm_crtc_state *state)
 {
 	struct drm_device *dev = crtc->dev;
 	struct drm_mode_config *config = &dev->mode_config;
-	struct drm_atomic_state *state;
-	struct drm_crtc_state *crtc_state;
-	struct drm_property_blob *blob = NULL;
+	struct drm_property_blob *blob;
 	struct drm_color_lut *blob_data;
 	int i, ret = 0;
 
-	state = drm_atomic_state_alloc(crtc->dev);
-	if (!state)
-		return -ENOMEM;
-
 	blob = drm_property_create_blob(dev,
 					sizeof(struct drm_color_lut) * size,
 					NULL);
-	if (IS_ERR(blob)) {
-		ret = PTR_ERR(blob);
-		blob = NULL;
-		goto fail;
-	}
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
 
 	/* Prepare GAMMA_LUT with the legacy values. */
 	blob_data = (struct drm_color_lut *) blob->data;
@@ -3640,33 +3631,21 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
 		blob_data[i].blue = blue[i];
 	}
 
-	state->acquire_ctx = ctx;
-	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	if (IS_ERR(crtc_state)) {
-		ret = PTR_ERR(crtc_state);
-		goto fail;
-	}
-
 	/* Reset DEGAMMA_LUT and CTM properties. */
-	ret = drm_atomic_crtc_set_property(crtc, crtc_state,
+	ret = drm_atomic_crtc_set_property(crtc, state,
 			config->degamma_lut_property, 0);
 	if (ret)
 		goto fail;
 
-	ret = drm_atomic_crtc_set_property(crtc, crtc_state,
+	ret = drm_atomic_crtc_set_property(crtc, state,
 			config->ctm_property, 0);
 	if (ret)
 		goto fail;
 
-	ret = drm_atomic_crtc_set_property(crtc, crtc_state,
+	ret = drm_atomic_crtc_set_property(crtc, state,
 			config->gamma_lut_property, blob->base.id);
-	if (ret)
-		goto fail;
-
-	ret = drm_atomic_commit(state);
 
 fail:
-	drm_atomic_state_put(state);
 	drm_property_blob_put(blob);
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 3eda500..864efe8 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -21,6 +21,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_color_mgmt.h>
 
@@ -218,9 +219,12 @@ int drm_mode_gamma_set_ioctl(struct drm_device *dev,
 			     void *data, struct drm_file *file_priv)
 {
 	struct drm_mode_crtc_lut *crtc_lut = data;
+	struct drm_crtc_state *crtc_state = NULL;
+	struct drm_atomic_state *state = NULL;
 	struct drm_crtc *crtc;
 	void *r_base, *g_base, *b_base;
 	int size;
+	int atomic;
 	struct drm_modeset_acquire_ctx ctx;
 	int ret = 0;
 
@@ -238,12 +242,28 @@ int drm_mode_gamma_set_ioctl(struct drm_device *dev,
 	if (crtc_lut->gamma_size != crtc->gamma_size)
 		return -EINVAL;
 
+	atomic = drm_drv_uses_atomic_modeset(dev);
+	if (atomic) {
+		state = drm_atomic_state_alloc(dev);
+		if (!state)
+			return -ENOMEM;
+	}
 	drm_modeset_acquire_init(&ctx, 0);
 retry:
 	ret = drm_modeset_lock_all_ctx(dev, &ctx);
 	if (ret)
 		goto out;
 
+	if (atomic) {
+		state->acquire_ctx = &ctx;
+
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state)) {
+			ret = PTR_ERR(crtc_state);
+			goto out;
+		}
+	}
+
 	size = crtc_lut->gamma_size * (sizeof(uint16_t));
 	r_base = crtc->gamma_store;
 	if (copy_from_user(r_base, (void __user *)(unsigned long)crtc_lut->red, size)) {
@@ -264,7 +284,10 @@ int drm_mode_gamma_set_ioctl(struct drm_device *dev,
 	}
 
 	ret = crtc->funcs->gamma_set(crtc, r_base, g_base, b_base,
-				     crtc->gamma_size, &ctx);
+				     crtc->gamma_size, crtc_state);
+
+	if (!ret && atomic)
+		ret = drm_atomic_commit(state);
 
 out:
 	if (ret == -EDEADLK) {
@@ -273,6 +296,8 @@ int drm_mode_gamma_set_ioctl(struct drm_device *dev,
 	}
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
+	if (atomic)
+		drm_atomic_state_put(state);
 
 	return ret;
 
diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index e7fd356..ccf8c33 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -178,7 +178,7 @@ void gma_crtc_load_lut(struct drm_crtc *crtc)
 
 int gma_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green, u16 *blue,
 		       u32 size,
-		       struct drm_modeset_acquire_ctx *ctx)
+		       struct drm_crtc_state *state)
 {
 	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
index 239c374..c07b34f 100644
--- a/drivers/gpu/drm/gma500/gma_display.h
+++ b/drivers/gpu/drm/gma500/gma_display.h
@@ -74,7 +74,7 @@ extern int gma_crtc_cursor_move(struct drm_crtc *crtc, int x, int y);
 extern void gma_crtc_load_lut(struct drm_crtc *crtc);
 extern int gma_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 			      u16 *blue, u32 size,
-			      struct drm_modeset_acquire_ctx *ctx);
+			      struct drm_crtc_state *state);
 extern void gma_crtc_dpms(struct drm_crtc *crtc, int mode);
 extern void gma_crtc_prepare(struct drm_crtc *crtc);
 extern void gma_crtc_commit(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index f4b5358..2141796 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1397,7 +1397,7 @@ static void mga_crtc_commit(struct drm_crtc *crtc)
  */
 static int mga_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 			      u16 *blue, uint32_t size,
-			      struct drm_modeset_acquire_ctx *ctx)
+			      struct drm_crtc_state *state)
 {
 	struct mga_crtc *mga_crtc = to_mga_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 4b4b0b4..f562824 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -789,7 +789,7 @@ nv_crtc_disable(struct drm_crtc *crtc)
 static int
 nv_crtc_gamma_set(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
 		  uint32_t size,
-		  struct drm_modeset_acquire_ctx *ctx)
+		  struct drm_crtc_state *state)
 {
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
index e3132a2..f13fa74 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -2232,7 +2232,7 @@ nv50_head_help = {
 static int
 nv50_head_gamma_set(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
 		    uint32_t size,
-		    struct drm_modeset_acquire_ctx *ctx)
+		    struct drm_crtc_state *state)
 {
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
 	u32 i;
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 17d3daf..0ea575d 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -233,7 +233,7 @@ void radeon_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
 
 static int radeon_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
 				 u16 *blue, uint32_t size,
-				 struct drm_modeset_acquire_ctx *ctx)
+				 struct drm_crtc_state *state)
 {
 	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 	int i;
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 403bbd5..fcc8dac 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -301,7 +301,7 @@ vc4_crtc_lut_load(struct drm_crtc *crtc)
 static int
 vc4_crtc_gamma_set(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
 		   uint32_t size,
-		   struct drm_modeset_acquire_ctx *ctx)
+		   struct drm_crtc_state *state)
 {
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	u32 i;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 3d94ea6..d75c5da 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1914,7 +1914,7 @@ static int vmw_du_update_layout(struct vmw_private *dev_priv, unsigned num,
 int vmw_du_crtc_gamma_set(struct drm_crtc *crtc,
 			  u16 *r, u16 *g, u16 *b,
 			  uint32_t size,
-			  struct drm_modeset_acquire_ctx *ctx)
+			  struct drm_crtc_state *state)
 {
 	struct vmw_private *dev_priv = vmw_priv(crtc->dev);
 	int i;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 5f8d678..9b2d8d3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -255,7 +255,7 @@ void vmw_du_crtc_restore(struct drm_crtc *crtc);
 int vmw_du_crtc_gamma_set(struct drm_crtc *crtc,
 			   u16 *r, u16 *g, u16 *b,
 			   uint32_t size,
-			   struct drm_modeset_acquire_ctx *ctx);
+			   struct drm_crtc_state *state);
 int vmw_du_connector_set_property(struct drm_connector *connector,
 				  struct drm_property *property,
 				  uint64_t val);
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index f0a8678..a91e063 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -177,7 +177,7 @@ void drm_atomic_helper_connector_destroy_state(struct drm_connector *connector,
 int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
 				       u16 *red, u16 *green, u16 *blue,
 				       uint32_t size,
-				       struct drm_modeset_acquire_ctx *ctx);
+				       struct drm_crtc_state *state);
 
 /**
  * drm_atomic_crtc_for_each_plane - iterate over planes currently attached to CRTC
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 629a5fe..d442d30 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -368,8 +368,7 @@ struct drm_crtc_funcs {
 	 * hooks.
 	 */
 	int (*gamma_set)(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
-			 uint32_t size,
-			 struct drm_modeset_acquire_ctx *ctx);
+			 uint32_t size, struct drm_crtc_state *state);
 
 	/**
 	 * @destroy:
-- 
2.1.4
