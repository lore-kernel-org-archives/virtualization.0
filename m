From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 05/17] drm/ast: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:53:28 +0000
Message-ID: <1455285208-2889-1-git-send-email-palminha__27343.5152521872$1455287089$gmane$org@synopsys.com>
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
 drivers/gpu/drm/ast/ast_mode.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 0123458..f221e2d 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -710,13 +710,6 @@ static void ast_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool ast_mode_fixup(struct drm_encoder *encoder,
-			   const struct drm_display_mode *mode,
-			   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void ast_encoder_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
@@ -736,7 +729,6 @@ static void ast_encoder_commit(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs ast_enc_helper_funcs = {
 	.dpms = ast_encoder_dpms,
-	.mode_fixup = ast_mode_fixup,
 	.prepare = ast_encoder_prepare,
 	.commit = ast_encoder_commit,
 	.mode_set = ast_encoder_mode_set,
-- 
2.5.0
