From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 04/16] drm/udl: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:17:33 +0000
Message-ID: <11327d1a3c3b6623064f6d82efa96e7993f77f38.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/udl/udl_modeset.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 160ef2a..b87afee 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -279,14 +279,6 @@ static void udl_crtc_dpms(struct drm_crtc *crtc, int mode)
 
 }
 
-static bool udl_crtc_mode_fixup(struct drm_crtc *crtc,
-				  const struct drm_display_mode *mode,
-				  struct drm_display_mode *adjusted_mode)
-
-{
-	return true;
-}
-
 #if 0
 static int
 udl_pipe_set_base_atomic(struct drm_crtc *crtc, struct drm_framebuffer *fb,
@@ -402,7 +394,6 @@ static void udl_crtc_commit(struct drm_crtc *crtc)
 
 static const struct drm_crtc_helper_funcs udl_helper_funcs = {
 	.dpms = udl_crtc_dpms,
-	.mode_fixup = udl_crtc_mode_fixup,
 	.mode_set = udl_crtc_mode_set,
 	.prepare = udl_crtc_prepare,
 	.commit = udl_crtc_commit,
-- 
2.5.0
