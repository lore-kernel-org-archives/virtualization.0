From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 06/16] drm/rcar-du: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:18:00 +0000
Message-ID: <becab4ff666eca77162e5cd978087f2d3fb3e308.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 4ec80ae..627abc80 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -468,14 +468,6 @@ static void rcar_du_crtc_disable(struct drm_crtc *crtc)
 	rcrtc->outputs = 0;
 }
 
-static bool rcar_du_crtc_mode_fixup(struct drm_crtc *crtc,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	/* TODO Fixup modes */
-	return true;
-}
-
 static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc,
 				      struct drm_crtc_state *old_crtc_state)
 {
@@ -502,7 +494,6 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
-	.mode_fixup = rcar_du_crtc_mode_fixup,
 	.disable = rcar_du_crtc_disable,
 	.enable = rcar_du_crtc_enable,
 	.atomic_begin = rcar_du_crtc_atomic_begin,
-- 
2.5.0
