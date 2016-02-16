From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 09/16] drm/shmobile: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:18:40 +0000
Message-ID: <c1652b5b8d84d857f8036a37d1d3e6123970e1a0.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index 27342fd..88643ab 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -359,13 +359,6 @@ static void shmob_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
 	scrtc->dpms = mode;
 }
 
-static bool shmob_drm_crtc_mode_fixup(struct drm_crtc *crtc,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void shmob_drm_crtc_mode_prepare(struct drm_crtc *crtc)
 {
 	shmob_drm_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
@@ -431,7 +424,6 @@ static int shmob_drm_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.dpms = shmob_drm_crtc_dpms,
-	.mode_fixup = shmob_drm_crtc_mode_fixup,
 	.prepare = shmob_drm_crtc_mode_prepare,
 	.commit = shmob_drm_crtc_mode_commit,
 	.mode_set = shmob_drm_crtc_mode_set,
-- 
2.5.0
