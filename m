From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 12/16] drm/nouveau/dispnv04: removed optional dummy crtc
	mode_fixup function.
Date: Tue, 16 Feb 2016 14:19:19 +0000
Message-ID: <897eae438eec566078b1872d7654c4863e4e4e57.1455630967.git.palminha@synopsys.com>
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
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 6f04397..55ccbf0 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -227,13 +227,6 @@ nv_crtc_dpms(struct drm_crtc *crtc, int mode)
 	NVWriteVgaCrtc(dev, nv_crtc->index, NV_CIO_CRE_RPC1_INDEX, crtc1A);
 }
 
-static bool
-nv_crtc_mode_fixup(struct drm_crtc *crtc, const struct drm_display_mode *mode,
-		   struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void
 nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct drm_display_mode *mode)
 {
@@ -1093,7 +1086,6 @@ static const struct drm_crtc_helper_funcs nv04_crtc_helper_funcs = {
 	.dpms = nv_crtc_dpms,
 	.prepare = nv_crtc_prepare,
 	.commit = nv_crtc_commit,
-	.mode_fixup = nv_crtc_mode_fixup,
 	.mode_set = nv_crtc_mode_set,
 	.mode_set_base = nv04_crtc_mode_set_base,
 	.mode_set_base_atomic = nv04_crtc_mode_set_base_atomic,
-- 
2.5.0
