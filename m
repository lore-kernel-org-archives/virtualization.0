From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 06/17] drm/bochs: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:54:04 +0000
Message-ID: <1455285244-2978-1-git-send-email-palminha__44923.140310175$1455286991$gmane$org@synopsys.com>
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
 drivers/gpu/drm/bochs/bochs_kms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 2849f1b..317c27f 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -152,13 +152,6 @@ static void bochs_crtc_init(struct drm_device *dev)
 	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
 }
 
-static bool bochs_encoder_mode_fixup(struct drm_encoder *encoder,
-				     const struct drm_display_mode *mode,
-				     struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void bochs_encoder_mode_set(struct drm_encoder *encoder,
 				   struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
@@ -179,7 +172,6 @@ static void bochs_encoder_commit(struct drm_encoder *encoder)
 
 static const struct drm_encoder_helper_funcs bochs_encoder_helper_funcs = {
 	.dpms = bochs_encoder_dpms,
-	.mode_fixup = bochs_encoder_mode_fixup,
 	.mode_set = bochs_encoder_mode_set,
 	.prepare = bochs_encoder_prepare,
 	.commit = bochs_encoder_commit,
-- 
2.5.0
