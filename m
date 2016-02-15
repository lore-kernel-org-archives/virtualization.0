From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH v2 11/17] drm/msm/mdp: removed optional dummy encoder
	mode_fixup function.
Date: Mon, 15 Feb 2016 13:00:24 +0000
Message-ID: <77692d9d34c2ed6a035f36d377d3544dbe100114.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
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

mode_fixup function for encoder drivers became optional with patch
http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha@synopsys.com

This patch set nukes all the dummy mode_fixup implementations.

(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_dsi_encoder.c  | 8 --------
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_dtv_encoder.c  | 8 --------
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_lcdc_encoder.c | 8 --------
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c  | 9 ---------
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_encoder.c      | 8 --------
 5 files changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dsi_encoder.c
index 2f57e94..106f0e7 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dsi_encoder.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dsi_encoder.c
@@ -47,13 +47,6 @@ static const struct drm_encoder_funcs mdp4_dsi_encoder_funcs = {
 	.destroy = mdp4_dsi_encoder_destroy,
 };
 
-static bool mdp4_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
-					const struct drm_display_mode *mode,
-					struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mdp4_dsi_encoder_mode_set(struct drm_encoder *encoder,
 				      struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode)
@@ -163,7 +156,6 @@ static void mdp4_dsi_encoder_enable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs mdp4_dsi_encoder_helper_funcs = {
-	.mode_fixup = mdp4_dsi_encoder_mode_fixup,
 	.mode_set = mdp4_dsi_encoder_mode_set,
 	.disable = mdp4_dsi_encoder_disable,
 	.enable = mdp4_dsi_encoder_enable,
diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dtv_encoder.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dtv_encoder.c
index a21df54..35ad78a 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dtv_encoder.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_dtv_encoder.c
@@ -94,13 +94,6 @@ static const struct drm_encoder_funcs mdp4_dtv_encoder_funcs = {
 	.destroy = mdp4_dtv_encoder_destroy,
 };
 
-static bool mdp4_dtv_encoder_mode_fixup(struct drm_encoder *encoder,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mdp4_dtv_encoder_mode_set(struct drm_encoder *encoder,
 		struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode)
@@ -234,7 +227,6 @@ static void mdp4_dtv_encoder_enable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs mdp4_dtv_encoder_helper_funcs = {
-	.mode_fixup = mdp4_dtv_encoder_mode_fixup,
 	.mode_set = mdp4_dtv_encoder_mode_set,
 	.enable = mdp4_dtv_encoder_enable,
 	.disable = mdp4_dtv_encoder_disable,
diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lcdc_encoder.c
index cd63fed..bc3d8e7 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lcdc_encoder.c
@@ -260,13 +260,6 @@ static void setup_phy(struct drm_encoder *encoder)
 	mdp4_write(mdp4_kms, REG_MDP4_LVDS_PHY_CFG0, lvds_phy_cfg0);
 }
 
-static bool mdp4_lcdc_encoder_mode_fixup(struct drm_encoder *encoder,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mdp4_lcdc_encoder_mode_set(struct drm_encoder *encoder,
 		struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode)
@@ -430,7 +423,6 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs mdp4_lcdc_encoder_helper_funcs = {
-	.mode_fixup = mdp4_lcdc_encoder_mode_fixup,
 	.mode_set = mdp4_lcdc_encoder_mode_set,
 	.disable = mdp4_lcdc_encoder_disable,
 	.enable = mdp4_lcdc_encoder_enable,
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c
index 1aa21db..69094cb 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c
@@ -188,13 +188,6 @@ static const struct drm_encoder_funcs mdp5_cmd_encoder_funcs = {
 	.destroy = mdp5_cmd_encoder_destroy,
 };
 
-static bool mdp5_cmd_encoder_mode_fixup(struct drm_encoder *encoder,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mdp5_cmd_encoder_mode_set(struct drm_encoder *encoder,
 		struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode)
@@ -256,7 +249,6 @@ static void mdp5_cmd_encoder_enable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs mdp5_cmd_encoder_helper_funcs = {
-	.mode_fixup = mdp5_cmd_encoder_mode_fixup,
 	.mode_set = mdp5_cmd_encoder_mode_set,
 	.disable = mdp5_cmd_encoder_disable,
 	.enable = mdp5_cmd_encoder_enable,
@@ -340,4 +332,3 @@ fail:
 
 	return ERR_PTR(ret);
 }
-
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_encoder.c
index 0d737ca..1d95f9f 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_encoder.c
@@ -112,13 +112,6 @@ static const struct drm_encoder_funcs mdp5_encoder_funcs = {
 	.destroy = mdp5_encoder_destroy,
 };
 
-static bool mdp5_encoder_mode_fixup(struct drm_encoder *encoder,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mdp5_encoder_mode_set(struct drm_encoder *encoder,
 		struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode)
@@ -287,7 +280,6 @@ static void mdp5_encoder_enable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs mdp5_encoder_helper_funcs = {
-	.mode_fixup = mdp5_encoder_mode_fixup,
 	.mode_set = mdp5_encoder_mode_set,
 	.disable = mdp5_encoder_disable,
 	.enable = mdp5_encoder_enable,
-- 
2.5.0
