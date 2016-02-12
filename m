From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 10/17] drm/imx: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:55:01 +0000
Message-ID: <1455285301-3214-1-git-send-email-palminha__3775.07656016878$1455287110$gmane$org@synopsys.com>
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
 drivers/gpu/drm/imx/dw_hdmi-imx.c      | 8 --------
 drivers/gpu/drm/imx/imx-ldb.c          | 8 --------
 drivers/gpu/drm/imx/imx-tve.c          | 8 --------
 drivers/gpu/drm/imx/parallel-display.c | 8 --------
 4 files changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index 063825f..21d6158 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -109,13 +109,6 @@ static void dw_hdmi_imx_encoder_disable(struct drm_encoder *encoder)
 {
 }
 
-static bool dw_hdmi_imx_encoder_mode_fixup(struct drm_encoder *encoder,
-					   const struct drm_display_mode *mode,
-					   struct drm_display_mode *adj_mode)
-{
-	return true;
-}
-
 static void dw_hdmi_imx_encoder_mode_set(struct drm_encoder *encoder,
 					 struct drm_display_mode *mode,
 					 struct drm_display_mode *adj_mode)
@@ -138,7 +131,6 @@ static void dw_hdmi_imx_encoder_prepare(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs dw_hdmi_imx_encoder_helper_funcs = {
-	.mode_fixup = dw_hdmi_imx_encoder_mode_fixup,
 	.mode_set   = dw_hdmi_imx_encoder_mode_set,
 	.prepare    = dw_hdmi_imx_encoder_prepare,
 	.commit     = dw_hdmi_imx_encoder_commit,
diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 22ac482..024d613 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -139,13 +139,6 @@ static void imx_ldb_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 }
 
-static bool imx_ldb_encoder_mode_fixup(struct drm_encoder *encoder,
-			   const struct drm_display_mode *mode,
-			   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void imx_ldb_set_clock(struct imx_ldb *ldb, int mux, int chno,
 		unsigned long serial_clk, unsigned long di_clk)
 {
@@ -376,7 +369,6 @@ static const struct drm_encoder_funcs imx_ldb_encoder_funcs = {
 
 static const struct drm_encoder_helper_funcs imx_ldb_encoder_helper_funcs = {
 	.dpms = imx_ldb_encoder_dpms,
-	.mode_fixup = imx_ldb_encoder_mode_fixup,
 	.prepare = imx_ldb_encoder_prepare,
 	.commit = imx_ldb_encoder_commit,
 	.mode_set = imx_ldb_encoder_mode_set,
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 292349f..ae7a9fb 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -286,13 +286,6 @@ static void imx_tve_encoder_dpms(struct drm_encoder *encoder, int mode)
 		dev_err(tve->dev, "failed to disable TVOUT: %d\n", ret);
 }
 
-static bool imx_tve_encoder_mode_fixup(struct drm_encoder *encoder,
-				       const struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void imx_tve_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_tve *tve = enc_to_tve(encoder);
@@ -379,7 +372,6 @@ static const struct drm_encoder_funcs imx_tve_encoder_funcs = {
 
 static const struct drm_encoder_helper_funcs imx_tve_encoder_helper_funcs = {
 	.dpms = imx_tve_encoder_dpms,
-	.mode_fixup = imx_tve_encoder_mode_fixup,
 	.prepare = imx_tve_encoder_prepare,
 	.mode_set = imx_tve_encoder_mode_set,
 	.commit = imx_tve_encoder_commit,
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index 0ffef17..363e2c7 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -112,13 +112,6 @@ static void imx_pd_encoder_dpms(struct drm_encoder *encoder, int mode)
 		drm_panel_enable(imxpd->panel);
 }
 
-static bool imx_pd_encoder_mode_fixup(struct drm_encoder *encoder,
-			   const struct drm_display_mode *mode,
-			   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
 {
 	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
@@ -166,7 +159,6 @@ static const struct drm_encoder_funcs imx_pd_encoder_funcs = {
 
 static const struct drm_encoder_helper_funcs imx_pd_encoder_helper_funcs = {
 	.dpms = imx_pd_encoder_dpms,
-	.mode_fixup = imx_pd_encoder_mode_fixup,
 	.prepare = imx_pd_encoder_prepare,
 	.commit = imx_pd_encoder_commit,
 	.mode_set = imx_pd_encoder_mode_set,
-- 
2.5.0
