From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 10/16] drm/sti: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:18:53 +0000
Message-ID: <08d27e27582fb2daa48555ab542245c6cf0a2268.1455630967.git.palminha__21240.4468017214$1455632565$gmane$org@synopsys.com>
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
 drivers/gpu/drm/sti/sti_crtc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index de11c7c..e04deed 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -51,14 +51,6 @@ static void sti_crtc_disabling(struct drm_crtc *crtc)
 	mixer->status = STI_MIXER_DISABLING;
 }
 
-static bool sti_crtc_mode_fixup(struct drm_crtc *crtc,
-				const struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
-{
-	/* accept the provided drm_display_mode, do not fix it up */
-	return true;
-}
-
 static int
 sti_crtc_mode_set(struct drm_crtc *crtc, struct drm_display_mode *mode)
 {
@@ -229,7 +221,6 @@ static void sti_crtc_atomic_flush(struct drm_crtc *crtc,
 static const struct drm_crtc_helper_funcs sti_crtc_helper_funcs = {
 	.enable = sti_crtc_enable,
 	.disable = sti_crtc_disabling,
-	.mode_fixup = sti_crtc_mode_fixup,
 	.mode_set = drm_helper_crtc_mode_set,
 	.mode_set_nofb = sti_crtc_mode_set_nofb,
 	.mode_set_base = drm_helper_crtc_mode_set_base,
-- 
2.5.0
