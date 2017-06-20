From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 06/11] drm: i915: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:30 +0200
Message-ID: <1497986735-14418-7-git-send-email-peda__7992.83718592978$1509078229$gmane$org@axentia.se>
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

The driver stores lut values from the fbdev interface, and is able
to give them back, but does not appear to do anything with these
lut values. The generic fb helpers have replaced this function,
and may even have made the driver work for the C8 mode from the
fbdev interface. But that is untested.

Since the fb helper .gamma_set and .gamma_get are no longer used,
just kill the mysterious dead code.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i915/intel_drv.h   |  1 -
 drivers/gpu/drm/i915/intel_fbdev.c | 31 -------------------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 83dd409..503edf3 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -785,7 +785,6 @@ struct intel_crtc {
 	struct drm_crtc base;
 	enum pipe pipe;
 	enum plane plane;
-	u8 lut_r[256], lut_g[256], lut_b[256];
 	/*
 	 * Whether the crtc and the connected output pipeline is active. Implies
 	 * that crtc->enabled is set, i.e. the current mode configuration has
diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
index 03347c6..5bac953 100644
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -281,27 +281,6 @@ static int intelfb_create(struct drm_fb_helper *helper,
 	return ret;
 }
 
-/** Sets the color ramps on behalf of RandR */
-static void intel_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
-				    u16 blue, int regno)
-{
-	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
-
-	intel_crtc->lut_r[regno] = red >> 8;
-	intel_crtc->lut_g[regno] = green >> 8;
-	intel_crtc->lut_b[regno] = blue >> 8;
-}
-
-static void intel_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
-				    u16 *blue, int regno)
-{
-	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
-
-	*red = intel_crtc->lut_r[regno] << 8;
-	*green = intel_crtc->lut_g[regno] << 8;
-	*blue = intel_crtc->lut_b[regno] << 8;
-}
-
 static struct drm_fb_helper_crtc *
 intel_fb_helper_crtc(struct drm_fb_helper *fb_helper, struct drm_crtc *crtc)
 {
@@ -370,7 +349,6 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
 		struct drm_connector *connector;
 		struct drm_encoder *encoder;
 		struct drm_fb_helper_crtc *new_crtc;
-		struct intel_crtc *intel_crtc;
 
 		fb_conn = fb_helper->connector_info[i];
 		connector = fb_conn->connector;
@@ -412,13 +390,6 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
 
 		num_connectors_enabled++;
 
-		intel_crtc = to_intel_crtc(connector->state->crtc);
-		for (j = 0; j < 256; j++) {
-			intel_crtc->lut_r[j] = j;
-			intel_crtc->lut_g[j] = j;
-			intel_crtc->lut_b[j] = j;
-		}
-
 		new_crtc = intel_fb_helper_crtc(fb_helper,
 						connector->state->crtc);
 
@@ -519,8 +490,6 @@ static bool intel_fb_initial_config(struct drm_fb_helper *fb_helper,
 
 static const struct drm_fb_helper_funcs intel_fb_helper_funcs = {
 	.initial_config = intel_fb_initial_config,
-	.gamma_set = intel_crtc_fb_gamma_set,
-	.gamma_get = intel_crtc_fb_gamma_get,
 	.fb_probe = intelfb_create,
 };
 
-- 
2.1.4
