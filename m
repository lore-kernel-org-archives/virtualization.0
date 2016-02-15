From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH v2 08/17] drm/exynos: removed optional dummy encoder
	mode_fixup function.
Date: Mon, 15 Feb 2016 12:59:49 +0000
Message-ID: <4906a9925eebbe55489b1005c449b426a61c09bd.1455540137.git.palminha__15797.6854047321$1455541309$gmane$org@synopsys.com>
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
 drivers/gpu/drm/exynos/exynos_dp_core.c  | 8 --------
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 8 --------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 8 --------
 3 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index 673164b..9fd12c62 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -1155,13 +1155,6 @@ static int exynos_dp_create_connector(struct drm_encoder *encoder)
 	return 0;
 }
 
-static bool exynos_dp_mode_fixup(struct drm_encoder *encoder,
-				 const struct drm_display_mode *mode,
-				 struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void exynos_dp_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
@@ -1177,7 +1170,6 @@ static void exynos_dp_disable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
-	.mode_fixup = exynos_dp_mode_fixup,
 	.mode_set = exynos_dp_mode_set,
 	.enable = exynos_dp_enable,
 	.disable = exynos_dp_disable,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 05350ae..75e570f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -128,13 +128,6 @@ static int exynos_dpi_create_connector(struct drm_encoder *encoder)
 	return 0;
 }
 
-static bool exynos_dpi_mode_fixup(struct drm_encoder *encoder,
-				  const struct drm_display_mode *mode,
-				  struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void exynos_dpi_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -162,7 +155,6 @@ static void exynos_dpi_disable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs exynos_dpi_encoder_helper_funcs = {
-	.mode_fixup = exynos_dpi_mode_fixup,
 	.mode_set = exynos_dpi_mode_set,
 	.enable = exynos_dpi_enable,
 	.disable = exynos_dpi_disable,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 62ac4e5..65108cb 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -410,13 +410,6 @@ static int vidi_create_connector(struct drm_encoder *encoder)
 	return 0;
 }
 
-static bool exynos_vidi_mode_fixup(struct drm_encoder *encoder,
-				 const struct drm_display_mode *mode,
-				 struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void exynos_vidi_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
@@ -432,7 +425,6 @@ static void exynos_vidi_disable(struct drm_encoder *encoder)
 }
 
 static const struct drm_encoder_helper_funcs exynos_vidi_encoder_helper_funcs = {
-	.mode_fixup = exynos_vidi_mode_fixup,
 	.mode_set = exynos_vidi_mode_set,
 	.enable = exynos_vidi_enable,
 	.disable = exynos_vidi_disable,
-- 
2.5.0
