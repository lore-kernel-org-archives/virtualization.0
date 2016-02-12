From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 17/17] drm/tilcdc: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:56:26 +0000
Message-ID: <1455285386-3547-1-git-send-email-palminha__31227.6841876612$1455286915$gmane$org@synopsys.com>
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
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 9 ---------
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 4dda6e2..8dcf02a 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -70,14 +70,6 @@ static void panel_encoder_dpms(struct drm_encoder *encoder, int mode)
 					 mode == DRM_MODE_DPMS_ON ? 1 : 0);
 }
 
-static bool panel_encoder_mode_fixup(struct drm_encoder *encoder,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	/* nothing needed */
-	return true;
-}
-
 static void panel_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct panel_encoder *panel_encoder = to_panel_encoder(encoder);
@@ -103,7 +95,6 @@ static const struct drm_encoder_funcs panel_encoder_funcs = {
 
 static const struct drm_encoder_helper_funcs panel_encoder_helper_funcs = {
 		.dpms           = panel_encoder_dpms,
-		.mode_fixup     = panel_encoder_mode_fixup,
 		.prepare        = panel_encoder_prepare,
 		.commit         = panel_encoder_commit,
 		.mode_set       = panel_encoder_mode_set,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index 5052a8a..1c23017 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -80,14 +80,6 @@ static void tfp410_encoder_dpms(struct drm_encoder *encoder, int mode)
 	tfp410_encoder->dpms = mode;
 }
 
-static bool tfp410_encoder_mode_fixup(struct drm_encoder *encoder,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	/* nothing needed */
-	return true;
-}
-
 static void tfp410_encoder_prepare(struct drm_encoder *encoder)
 {
 	tfp410_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
@@ -112,7 +104,6 @@ static const struct drm_encoder_funcs tfp410_encoder_funcs = {
 
 static const struct drm_encoder_helper_funcs tfp410_encoder_helper_funcs = {
 		.dpms           = tfp410_encoder_dpms,
-		.mode_fixup     = tfp410_encoder_mode_fixup,
 		.prepare        = tfp410_encoder_prepare,
 		.commit         = tfp410_encoder_commit,
 		.mode_set       = tfp410_encoder_mode_set,
-- 
2.5.0
