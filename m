From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 12/17] drm/mgag200: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:55:25 +0000
Message-ID: <1455285325-3308-1-git-send-email-palminha__3151.23093682832$1455287092$gmane$org@synopsys.com>
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
 drivers/gpu/drm/mgag200/mgag200_mode.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index dc13c48..af8b4c1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1479,13 +1479,6 @@ void mga_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
  * These functions are analagous to those in the CRTC code, but are intended
  * to handle any encoder-specific limitations
  */
-static bool mga_encoder_mode_fixup(struct drm_encoder *encoder,
-				   const struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void mga_encoder_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -1515,7 +1508,6 @@ static void mga_encoder_destroy(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs mga_encoder_helper_funcs = {
 	.dpms = mga_encoder_dpms,
-	.mode_fixup = mga_encoder_mode_fixup,
 	.mode_set = mga_encoder_mode_set,
 	.prepare = mga_encoder_prepare,
 	.commit = mga_encoder_commit,
-- 
2.5.0
