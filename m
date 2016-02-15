From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH v2 05/17] drm/ast: removed optional dummy encoder mode_fixup
	function.
Date: Mon, 15 Feb 2016 12:59:00 +0000
Message-ID: <12e1e900724c890166b88b0f4d67baba387482af.1455540137.git.palminha__49273.1997081593$1455541190$gmane$org@synopsys.com>
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
