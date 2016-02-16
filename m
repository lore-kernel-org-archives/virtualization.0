From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 11/16] drm/atmel-hldcd: removed optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:19:06 +0000
Message-ID: <e4bdb8552c245f8b73084b93da60460a00f7798c.1455630967.git.palminha__46496.5498577387$1455632654$gmane$org@synopsys.com>
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 9863291..58c4f78 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -121,13 +121,6 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   cfg);
 }
 
-static bool atmel_hlcdc_crtc_mode_fixup(struct drm_crtc *crtc,
-					const struct drm_display_mode *mode,
-					struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void atmel_hlcdc_crtc_disable(struct drm_crtc *c)
 {
 	struct drm_device *dev = c->dev;
@@ -261,7 +254,6 @@ static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
-	.mode_fixup = atmel_hlcdc_crtc_mode_fixup,
 	.mode_set = drm_helper_crtc_mode_set,
 	.mode_set_nofb = atmel_hlcdc_crtc_mode_set_nofb,
 	.mode_set_base = drm_helper_crtc_mode_set_base,
@@ -349,4 +341,3 @@ fail:
 	atmel_hlcdc_crtc_destroy(&crtc->base);
 	return ret;
 }
-
-- 
2.5.0
