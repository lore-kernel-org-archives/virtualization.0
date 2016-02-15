From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH v2 02/17] drm/udl: removed optional dummy encoder mode_fixup
	function.
Date: Mon, 15 Feb 2016 12:57:58 +0000
Message-ID: <a7ebfb6c6c333056d0a77d2684c539107ee63589.1455540137.git.palminha__4746.70003536648$1455541160$gmane$org@synopsys.com>
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
 drivers/gpu/drm/udl/udl_encoder.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_encoder.c b/drivers/gpu/drm/udl/udl_encoder.c
index a181a64..59a4b34 100644
--- a/drivers/gpu/drm/udl/udl_encoder.c
+++ b/drivers/gpu/drm/udl/udl_encoder.c
@@ -26,13 +26,6 @@ static void udl_encoder_disable(struct drm_encoder *encoder)
 {
 }
 
-static bool udl_mode_fixup(struct drm_encoder *encoder,
-			   const struct drm_display_mode *mode,
-			   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void udl_encoder_prepare(struct drm_encoder *encoder)
 {
 }
@@ -54,7 +47,6 @@ udl_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 static const struct drm_encoder_helper_funcs udl_helper_funcs = {
 	.dpms = udl_encoder_dpms,
-	.mode_fixup = udl_mode_fixup,
 	.prepare = udl_encoder_prepare,
 	.mode_set = udl_encoder_mode_set,
 	.commit = udl_encoder_commit,
-- 
2.5.0
