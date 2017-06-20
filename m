From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 10/11] drm: stm: remove dead code and pointless local lut
	storage
Date: Tue, 20 Jun 2017 21:25:34 +0200
Message-ID: <1497986735-14418-11-git-send-email-peda__32919.0416414805$1509078274$gmane$org@axentia.se>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497986735-14418-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Yannick Fertre <yannick.fertre@st.com>, Sean Paul <seanpaul@chromium.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The redundant fb helper .load_lut is no longer used, and can not
work right without also providing the fb helpers .gamma_set and
.gamma_get thus rendering the code in this driver suspect.

Just remove the dead code.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/stm/ltdc.c | 12 ------------
 drivers/gpu/drm/stm/ltdc.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 1b9483d..87829b9 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -375,17 +375,6 @@ static irqreturn_t ltdc_irq(int irq, void *arg)
  * DRM_CRTC
  */
 
-static void ltdc_crtc_load_lut(struct drm_crtc *crtc)
-{
-	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
-	unsigned int i, lay;
-
-	for (lay = 0; lay < ldev->caps.nb_layers; lay++)
-		for (i = 0; i < 256; i++)
-			reg_write(ldev->regs, LTDC_L1CLUTWR + lay * LAY_OFS,
-				  ldev->clut[i]);
-}
-
 static void ltdc_crtc_enable(struct drm_crtc *crtc)
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
@@ -523,7 +512,6 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
 }
 
 static struct drm_crtc_helper_funcs ltdc_crtc_helper_funcs = {
-	.load_lut = ltdc_crtc_load_lut,
 	.enable = ltdc_crtc_enable,
 	.disable = ltdc_crtc_disable,
 	.mode_set_nofb = ltdc_crtc_mode_set_nofb,
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index d7a9c73..620ca55 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -27,7 +27,6 @@ struct ltdc_device {
 	struct drm_panel *panel;
 	struct mutex err_lock;	/* protecting error_status */
 	struct ltdc_caps caps;
-	u32 clut[256];		/* color look up table */
 	u32 error_status;
 	u32 irq_status;
 };
-- 
2.1.4
