From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH v2 13/17] drm/qxl: removed optional dummy encoder mode_fixup
	function.
Date: Mon, 15 Feb 2016 13:00:54 +0000
Message-ID: <f35bc322f7af69ba0fea734d58b4daf5e0cd9786.1455540137.git.palminha__2682.52125611088$1455541379$gmane$org@synopsys.com>
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
 drivers/gpu/drm/qxl/qxl_display.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 8627651..43e5f50 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -734,14 +734,6 @@ static void qxl_enc_dpms(struct drm_encoder *encoder, int mode)
 	DRM_DEBUG("\n");
 }
 
-static bool qxl_enc_mode_fixup(struct drm_encoder *encoder,
-			       const struct drm_display_mode *mode,
-			       struct drm_display_mode *adjusted_mode)
-{
-	DRM_DEBUG("\n");
-	return true;
-}
-
 static void qxl_enc_prepare(struct drm_encoder *encoder)
 {
 	DRM_DEBUG("\n");
@@ -864,7 +856,6 @@ static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
 
 static const struct drm_encoder_helper_funcs qxl_enc_helper_funcs = {
 	.dpms = qxl_enc_dpms,
-	.mode_fixup = qxl_enc_mode_fixup,
 	.prepare = qxl_enc_prepare,
 	.mode_set = qxl_enc_mode_set,
 	.commit = qxl_enc_commit,
-- 
2.5.0
