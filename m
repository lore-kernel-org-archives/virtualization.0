From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 02/16] drm/cirrus: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:16:51 +0000
Message-ID: <5a3c41fed15847549f9bdeae89b72705b4756cc4.1455630967.git.palminha__12877.9516242959$1455632275$gmane$org@synopsys.com>
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
 drivers/gpu/drm/cirrus/cirrus_mode.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 4a02854..e7334a8 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -91,18 +91,6 @@ static void cirrus_crtc_dpms(struct drm_crtc *crtc, int mode)
 	WREG_GFX(0xe, gr0e);
 }
 
-/*
- * The core passes the desired mode to the CRTC code to see whether any
- * CRTC-specific modifications need to be made to it. We're in a position
- * to just pass that straight through, so this does nothing
- */
-static bool cirrus_crtc_mode_fixup(struct drm_crtc *crtc,
-				   const struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void cirrus_set_start_address(struct drm_crtc *crtc, unsigned offset)
 {
 	struct cirrus_device *cdev = crtc->dev->dev_private;
@@ -372,7 +360,6 @@ static const struct drm_crtc_funcs cirrus_crtc_funcs = {
 
 static const struct drm_crtc_helper_funcs cirrus_helper_funcs = {
 	.dpms = cirrus_crtc_dpms,
-	.mode_fixup = cirrus_crtc_mode_fixup,
 	.mode_set = cirrus_crtc_mode_set,
 	.mode_set_base = cirrus_crtc_mode_set_base,
 	.prepare = cirrus_crtc_prepare,
-- 
2.5.0
