From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 08/16] drm/msm/mdp: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:18:26 +0000
Message-ID: <4374682ff7c52aaa58456034a0900c7cb93068bc.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c | 8 --------
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c
index 909d742..38329a6 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c
@@ -147,13 +147,6 @@ static void mdp4_crtc_destroy(struct drm_crtc *crtc)
 	kfree(mdp4_crtc);
 }
 
-static bool mdp4_crtc_mode_fixup(struct drm_crtc *crtc,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 /* statically (for now) map planes to mixer stage (z-order): */
 static const int idxs[] = {
 		[VG1]  = 1,
@@ -508,7 +501,6 @@ static const struct drm_crtc_funcs mdp4_crtc_funcs = {
 };
 
 static const struct drm_crtc_helper_funcs mdp4_crtc_helper_funcs = {
-	.mode_fixup = mdp4_crtc_mode_fixup,
 	.mode_set_nofb = mdp4_crtc_mode_set_nofb,
 	.disable = mdp4_crtc_disable,
 	.enable = mdp4_crtc_enable,
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c
index 46682aa..d6b45eb 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c
@@ -185,13 +185,6 @@ static void mdp5_crtc_destroy(struct drm_crtc *crtc)
 	kfree(mdp5_crtc);
 }
 
-static bool mdp5_crtc_mode_fixup(struct drm_crtc *crtc,
-		const struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 /*
  * blend_setup() - blend all the planes of a CRTC
  *
@@ -634,7 +627,6 @@ static const struct drm_crtc_funcs mdp5_crtc_funcs = {
 };
 
 static const struct drm_crtc_helper_funcs mdp5_crtc_helper_funcs = {
-	.mode_fixup = mdp5_crtc_mode_fixup,
 	.mode_set_nofb = mdp5_crtc_mode_set_nofb,
 	.disable = mdp5_crtc_disable,
 	.enable = mdp5_crtc_enable,
-- 
2.5.0
