From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 16/16] drm/ast: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:20:14 +0000
Message-ID: <0f8f948babd93fce8523253b0f525446e2f565db.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/ast/ast_mode.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 0123458..0deeecd 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -497,13 +497,6 @@ static void ast_crtc_dpms(struct drm_crtc *crtc, int mode)
 	}
 }
 
-static bool ast_crtc_mode_fixup(struct drm_crtc *crtc,
-				const struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 /* ast is different - we will force move buffers out of VRAM */
 static int ast_crtc_do_set_base(struct drm_crtc *crtc,
 				struct drm_framebuffer *fb,
@@ -617,7 +610,6 @@ static void ast_crtc_commit(struct drm_crtc *crtc)
 
 static const struct drm_crtc_helper_funcs ast_crtc_helper_funcs = {
 	.dpms = ast_crtc_dpms,
-	.mode_fixup = ast_crtc_mode_fixup,
 	.mode_set = ast_crtc_mode_set,
 	.mode_set_base = ast_crtc_mode_set_base,
 	.disable = ast_crtc_disable,
-- 
2.5.0
