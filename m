From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 09/17] drm/gma500: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:54:48 +0000
Message-ID: <1455285288-3164-1-git-send-email-palminha__37223.1288849891$1455287051$gmane$org@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, heiko@sntech.de, benjamin.gaignard@linaro.org, airlied@linux.ie, jingoohan1@gmail.com, CARLOS.PALMINHA@synopsys.com, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, p.zabel@pengutronix.de, vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/gpu/drm/gma500/cdv_intel_crt.c  | 1 -
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c | 1 -
 drivers/gpu/drm/gma500/gma_display.c    | 7 -------
 drivers/gpu/drm/gma500/gma_display.h    | 3 ---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c  | 1 -
 5 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index d0717a8..b837e7a 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -217,7 +217,6 @@ static int cdv_intel_crt_set_property(struct drm_connector *connector,
 
 static const struct drm_encoder_helper_funcs cdv_intel_crt_helper_funcs = {
 	.dpms = cdv_intel_crt_dpms,
-	.mode_fixup = gma_encoder_mode_fixup,
 	.prepare = gma_encoder_prepare,
 	.commit = gma_encoder_commit,
 	.mode_set = cdv_intel_crt_mode_set,
diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index ddf2d77..28f9d90 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -255,7 +255,6 @@ static void cdv_hdmi_destroy(struct drm_connector *connector)
 
 static const struct drm_encoder_helper_funcs cdv_hdmi_helper_funcs = {
 	.dpms = cdv_hdmi_dpms,
-	.mode_fixup = gma_encoder_mode_fixup,
 	.prepare = gma_encoder_prepare,
 	.mode_set = cdv_hdmi_mode_set,
 	.commit = gma_encoder_commit,
diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index ff17af4..9270821 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -478,13 +478,6 @@ int gma_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
 	return 0;
 }
 
-bool gma_encoder_mode_fixup(struct drm_encoder *encoder,
-			    const struct drm_display_mode *mode,
-			    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 bool gma_crtc_mode_fixup(struct drm_crtc *crtc,
 			 const struct drm_display_mode *mode,
 			 struct drm_display_mode *adjusted_mode)
diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
index ed569d8..78b9f98 100644
--- a/drivers/gpu/drm/gma500/gma_display.h
+++ b/drivers/gpu/drm/gma500/gma_display.h
@@ -90,9 +90,6 @@ extern void gma_crtc_restore(struct drm_crtc *crtc);
 extern void gma_encoder_prepare(struct drm_encoder *encoder);
 extern void gma_encoder_commit(struct drm_encoder *encoder);
 extern void gma_encoder_destroy(struct drm_encoder *encoder);
-extern bool gma_encoder_mode_fixup(struct drm_encoder *encoder,
-				   const struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode);
 
 /* Common clock related functions */
 extern const struct gma_limit_t *gma_limit(struct drm_crtc *crtc, int refclk);
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 2d18499..8b2eb32 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -601,7 +601,6 @@ static void oaktrail_hdmi_destroy(struct drm_connector *connector)
 
 static const struct drm_encoder_helper_funcs oaktrail_hdmi_helper_funcs = {
 	.dpms = oaktrail_hdmi_dpms,
-	.mode_fixup = gma_encoder_mode_fixup,
 	.prepare = gma_encoder_prepare,
 	.mode_set = oaktrail_hdmi_mode_set,
 	.commit = gma_encoder_commit,
-- 
2.5.0
