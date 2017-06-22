From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 05/14] drm: armada: remove dead empty functions
Date: Thu, 22 Jun 2017 08:06:28 +0200
Message-ID: <1498111597-10714-6-git-send-email-peda__17537.9014494412$1509078404$gmane$org@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1498111597-10714-1-git-send-email-peda@axentia.se>
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, Peter Rosin <peda@axentia.se>, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

The redundant fb helpers .gamma_set and .gamma_get are no longer used.
Remove the dead code.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/armada/armada_crtc.c  | 10 ----------
 drivers/gpu/drm/armada/armada_crtc.h  |  2 --
 drivers/gpu/drm/armada/armada_fbdev.c |  2 --
 3 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 4fe19fd..96bccf8 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -334,16 +334,6 @@ static void armada_drm_vblank_off(struct armada_crtc *dcrtc)
 	armada_drm_plane_work_run(dcrtc, dcrtc->crtc.primary);
 }
 
-void armada_drm_crtc_gamma_set(struct drm_crtc *crtc, u16 r, u16 g, u16 b,
-	int idx)
-{
-}
-
-void armada_drm_crtc_gamma_get(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
-	int idx)
-{
-}
-
 /* The mode_config.mutex will be held for this call */
 static void armada_drm_crtc_dpms(struct drm_crtc *crtc, int dpms)
 {
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
index 7e8906d..bab11f4 100644
--- a/drivers/gpu/drm/armada/armada_crtc.h
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -102,8 +102,6 @@ struct armada_crtc {
 };
 #define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
 
-void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
-void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
 void armada_drm_crtc_update_regs(struct armada_crtc *, struct armada_regs *);
 
 void armada_drm_crtc_plane_disable(struct armada_crtc *dcrtc,
diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 602dfea..5fa076d 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -118,8 +118,6 @@ static int armada_fb_probe(struct drm_fb_helper *fbh,
 }
 
 static const struct drm_fb_helper_funcs armada_fb_helper_funcs = {
-	.gamma_set	= armada_drm_crtc_gamma_set,
-	.gamma_get	= armada_drm_crtc_gamma_get,
 	.fb_probe	= armada_fb_probe,
 };
 
-- 
2.1.4
