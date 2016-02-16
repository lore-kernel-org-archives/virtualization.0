From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 14/16] drm/fsl-dcu: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:19:46 +0000
Message-ID: <a9827a57b25509dae29c0e8d09a9063a11970647.1455630967.git.palminha__42846.4715638713$1455632693$gmane$org@synopsys.com>
References: <cover.1455630967.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1455630967.git.palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org
Cc: nicolas.pitre@linaro.org, boris.brezillon@free-electrons.com, jianwei.wang.chn@gmail.com, jani.nikula@intel.com, alison.wang@freescale.com, CARLOS.PALMINHA@synopsys.com, linux-renesas-soc@vger.kernel.org, laurent.pinchart@ideasonboard.com, benjamin.gaignard@linaro.org, vincent.abriou@st.com, sudipm.mukherjee@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

This patch set nukes all the dummy crtc mode_fixup implementations.
(made on top of Daniel topic/drm-misc branch)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index d8ab8f0..9aa6ad5 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -72,13 +72,6 @@ static void fsl_dcu_drm_crtc_enable(struct drm_crtc *crtc)
 		dev_err(fsl_dev->dev, "Enable CRTC failed\n");
 }
 
-static bool fsl_dcu_drm_crtc_mode_fixup(struct drm_crtc *crtc,
-					const struct drm_display_mode *mode,
-					struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
@@ -153,7 +146,6 @@ static const struct drm_crtc_helper_funcs fsl_dcu_drm_crtc_helper_funcs = {
 	.atomic_flush = fsl_dcu_drm_crtc_atomic_flush,
 	.disable = fsl_dcu_drm_disable_crtc,
 	.enable = fsl_dcu_drm_crtc_enable,
-	.mode_fixup = fsl_dcu_drm_crtc_mode_fixup,
 	.mode_set_nofb = fsl_dcu_drm_crtc_mode_set_nofb,
 };
 
-- 
2.5.0
