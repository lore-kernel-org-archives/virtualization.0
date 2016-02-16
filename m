From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 03/16] drm/mgag200: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:17:20 +0000
Message-ID: <3d089c84bcb1aafd485d4944ad472f9843c38eaf.1455630967.git.palminha__8458.60307240418$1455632301$gmane$org@synopsys.com>
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
 drivers/gpu/drm/mgag200/mgag200_mode.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index dc13c48..aa99c40 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -92,18 +92,6 @@ static inline void mga_wait_busy(struct mga_device *mdev)
 	} while ((status & 0x01) && time_before(jiffies, timeout));
 }
 
-/*
- * The core passes the desired mode to the CRTC code to see whether any
- * CRTC-specific modifications need to be made to it. We're in a position
- * to just pass that straight through, so this does nothing
- */
-static bool mga_crtc_mode_fixup(struct drm_crtc *crtc,
-				const struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 #define P_ARRAY_SIZE 9
 
 static int mga_g200se_set_plls(struct mga_device *mdev, long clock)
@@ -1410,7 +1398,6 @@ static const struct drm_crtc_funcs mga_crtc_funcs = {
 static const struct drm_crtc_helper_funcs mga_helper_funcs = {
 	.disable = mga_crtc_disable,
 	.dpms = mga_crtc_dpms,
-	.mode_fixup = mga_crtc_mode_fixup,
 	.mode_set = mga_crtc_mode_set,
 	.mode_set_base = mga_crtc_mode_set_base,
 	.prepare = mga_crtc_prepare,
-- 
2.5.0
