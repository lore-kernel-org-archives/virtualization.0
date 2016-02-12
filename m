From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 13/17] drm/qxl: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:55:37 +0000
Message-ID: <1455285337-3356-1-git-send-email-palminha__43944.2371753559$1455286865$gmane$org@synopsys.com>
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
