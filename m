From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 15/16] drm/bochs: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:20:02 +0000
Message-ID: <40a78cafba2cd5b391d244e806613192b3a31413.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/bochs/bochs_kms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 2849f1b..c922b48 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -30,13 +30,6 @@ static void bochs_crtc_dpms(struct drm_crtc *crtc, int mode)
 	}
 }
 
-static bool bochs_crtc_mode_fixup(struct drm_crtc *crtc,
-				  const struct drm_display_mode *mode,
-				  struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 				    struct drm_framebuffer *old_fb)
 {
@@ -135,7 +128,6 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
 
 static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.dpms = bochs_crtc_dpms,
-	.mode_fixup = bochs_crtc_mode_fixup,
 	.mode_set = bochs_crtc_mode_set,
 	.mode_set_base = bochs_crtc_mode_set_base,
 	.prepare = bochs_crtc_prepare,
-- 
2.5.0
